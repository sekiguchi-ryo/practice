class Pdf < ApplicationRecord
  mount_uploader :pdf, PdfUploader
end
