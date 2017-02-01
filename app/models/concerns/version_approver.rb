module VersionApprover
  extend ActiveSupport::Concern

  included do
  end

  def versions
    Version.where(item_type: self.class.to_s, item_id: self.id)
  end

  def update_with_versioning(params)
    current_attributes = self.attributes.dup
    if update(params)
      # バージョンレコードを作成
      create_version
      # ステータスだけ変更して元に戻す
      update(current_attributes.merge(state: :draft))
    end
  end

  def approve(id)
    version = Version.find(id)
    self.attributes = YAML.load(version.object).merge(state: :approved)
    self.save!
  end

  private

  def create_version
    Version.create(
      item_type: self.class.to_s,
      item_id: self.id,
      object: self.attributes.to_yaml
    )
  end
end
