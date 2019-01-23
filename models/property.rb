require('pg')
class Property

attr_accessor :value, :no_of_bedrooms, :status, :build
attr_reader :id

def initialize(options)
  @value = options['value']
  @no_of_bedrooms = options['no_of_bedrooms']
  @status = options['status']
  @build = options['build']
  @id = options['id'].to_i if options['id']
end

def save()
  db = PG.connect({dbname: 'homes', host: 'localhost'})
  sql = "INSERT INTO homes
        (value,
        no_of_bedrooms,
        status,
        build)
        VALUES
        ($1, $2, $3, $4)
        RETURNING *"
   values = [@value, @no_of_bedrooms, @status, @build]
   db.prepare('save', sql)
   @id = db.exec_prepared('save', values)[0]['id'].to_i
   db.close()
      end

  def update()
    db = PG.connect({dbname: 'homes', host: 'localhost'})
    sql = "UPDATE homes
           SET (
             value,
             no_of_bedrooms,
             status,
             build
             ) = (
               $1, $2, $3, $4
             )
             WHERE id = $5"
     values = [@value, @no_of_bedrooms, @status, @build, @id]
     db.prepare('update', sql)
     db.exec_prepared('update', values)
     db.close()
  end

  def Property.delete_all()
    db = PG.connect({dbname: 'homes', host: 'localhost'})
    sql = "DELETE FROM homes"
    db.prepare('delete_all', sql)
    db.exec_prepared('delete_all')
    db.close()
  end

  def delete()
    db = PG.connect({dbname: 'homes', host: 'localhost'})
    sql = "DELETE FROM homes WHERE id = $1"
    values = [@id]
    db.prepare('delete_one', sql)
    db.exec_prepared('delete_one', values)
    db.close()
  end

  def Property.find(id)
    db = PG.connect({dbname: 'homes', host: 'localhost'})
    sql = "SELECT * FROM homes WHERE id = $1"
    values = [id]
    db.prepare('find', sql)
    results = db.exec_prepared('find', values)[0]
    db.close()
    return Property.new(results)
  end

  def Property.find_by_value(value)
    db = PG.connect({dbname: 'homes', host: 'localhost'})
    sql = "SELECT * FROM homes WHERE value = $1"
    values = [value]
    db.prepare('find_by_value', sql)
    results = db.exec_prepared('find_by_value', values)
    db.close()
    return nil if results.count==0
    property_hash = results[0]
    found_property = Property.new(property_hash)
    return found_property
  end


end
