class PdfUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add an allowlist of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_allowlist
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg"
  # end

  # version :thumb do
  #   process convert: 'png'
  # end

  version :thumb do
    # ここに`full_filename`を作るとそれがサムネイルのファイル名になります。
    # このUploaderは画像とPDF両対応なのでPDFの時だけ拡張子を変更しています。
    # `minimagick!`で`convert: :jpg`してるので拡張子変わってくれそうですが
    # 残念ながら変わりません。
    def full_filename(for_file)
      name = super(for_file)
      name = name.sub(/\.pdf$/, '.jpg') if for_file.ends_with?('.pdf')
      name
    end

    # このメソッドでPDFの1ページ目を画像に変換しています。
    process :pdf_first_page_to_jpg, if: :pdf?
    
    # サムネイルのサイズ
    # process resize_to_limit: [280, 280]
  end

  private

    def pdf?(new_file)
      new_file.content_type == 'application/pdf'
    end

    def pdf_first_page_to_jpg
      # 以前は`manipulate!`を使っていましたが`minimagick!`に変わりました。
      # 引数には`ImageProcessing::Builder`がきます。
      # `ImageProcessing::Builder`については
      # すぐ下にリンクを貼りましたのでそちらを見てください。
      minimagick! do |pdf|
        pdf
          # `append`は`convert`コマンドに渡す引数を渡せます。
          # この二つのオプションを指定しないとものによっては背景が真っ黒になります。
          .append('-background', 'white')
          .append('-alpha', 'remove')
          # `loader`の指定は`convert path/to/file.pdf[0] path/to/file.jpg`
          # のようなコマンドを生成します。これでページ指定ができるようです。
          .loader(page: 0)
          .convert('jpg')
      end
    end
end