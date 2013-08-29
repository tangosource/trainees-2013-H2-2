module ProjectsHelper
  def project_status(periodo)
   if periodo != false
    cadena = "<div class = 'btn btn2 btn-success'>Back this project <br/> $1 minimium pledge </div>"
   else 
     cadena = "<h3>Closed project</h3>"
   end
    return cadena.html_safe 
  end   
  
  def project_visit (id)
    project = Project.find(id)
    counter = project.hit_counter + 1
    project.update(:hit_counter => counter)
  end

end

