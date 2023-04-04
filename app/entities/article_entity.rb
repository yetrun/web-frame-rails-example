class ArticleEntity < Meta::Entity
  property :id, type: 'integer', description: 'ID', param: false
  property :title, type: 'string', description: '标题'
  property :content, type: 'string', description: '内容', scope: 'full'
end
