component extends="railoRunner" {


	variables.controllerBookmark = "/* AutoGen - Do Not Delete */";
	variables.mypath = getDirectoryFromPath(getCurrentTemplatePath());
	variables.help = {
				'create' : "The 'create' command creates a FW/1 scaffold application. All you need to pass is an application name, such as 'fw1 create MyApplication'",
				'help' : "That's this method, I can't give you help using help",
				'default' : "The current commands you can send to FW1 are: create, help. You can view documentation for a specific command by doing fw1 help <commandname>"
			};
	function create(paramArray=[]){

		if(!ArrayLen(arguments.paramArray)){
			return "There needs to be at least a name for the project";
		}
		if(!Len(arguments.paramArray[1])){
			return "The project needs a name";
		}

		var projectName = paramArray[1];
		var projectPath = "#variables.targetpath#/#projectName#" ;
		var zipFile = variables.mypath & "templates/newproject.zip";

		if(DirectoryExists(projectPath)){
			return "Path #projectPath# already exists";
		}

		DirectoryCreate(projectPath);
		zip action="unzip" file="#zipFile#" destination="#projectPath#";


		return "Project created at #projectPath#";
	
	}

	function hello(){

		return "Howdy!";
	}
	
	
	/**
	@hint: creates a view, using the dot notation such as section.action
	**/
	function view(paramArray=[]){
		if(!paramArray.Len()){
			return "There needs to be a section and action defined";
		}
		
			if(paramArray.Len() == 1){
				//let's create a view
				var viewpath = variables.targetpath & "/views";
				//Make sure the views folder has been created
			
				if(!DirectoryExists(viewpath)){
					println("Creating #viewpath#");
					DirectoryCreate(viewpath);
				}
			
				var sectionpath = viewPath & "/" & ListFirst(paramArray[1], ".");

				if(!DirectoryExists(sectionpath)){
					println("Creating #sectionpath#");
					DirectoryCreate(sectionpath);
				}
			
			
				// We only have a section
				if(ListLen(paramArray[1],".") EQ 1){
					//create the default file
					var defaultViewFile = sectionpath & "/default.cfm";
					println("Creating view '#paramArray[1]#.default'");
					FileWrite(defaultViewFile, "<h1>#paramArray[1]#.default</h1>");
				}
			
				if(ListLen(paramArray[1],".") EQ 2){
					//create the specific file
					var viewFile = sectionpath & "/" & ListGetAt(paramArray[1],2, ".") & ".cfm";
					println("Creating view '#paramArray[1]#'");
					FileWrite(viewFile, "<h1>#paramArray[1]#</h1>");
			
				}
				return ;		
			}
	}
	
	function controller(paramArray=[]){
		
		var controllerFolder = 	variables.targetpath & "/controllers";
		
		if(!DirectoryExists(controllerFolder)){
			println("Creating the controllers folder");
			DirectoryCreate(controllerFolder);
		}
		
		if(paramArray.len()){
			//At least we have the name of the controller!
			var controllerFile = controllerFolder & "/" & paramArray[1] & ".cfc";
			if(!FileExists(controllerFile)){
				println("Creating the #paramArray[1]#.cfc controller file");
				FileCopy(variables.mypath & "templates/controller.cfc", controllerFile);
			}
		
		
		}
	
		println(Serialize(paramArray));
	}


	function section(paramArray=[]){
				println(Serialize(paramArray));
	}
	
}