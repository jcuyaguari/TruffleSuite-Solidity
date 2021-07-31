// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

contract PersonaContract{
	uint nextId;
	
	struct Persona{
		uint id;
		string name;
		string description;
	}
	
	Persona[] personas;
	
	function createPerson(string memory name,string memory description) public{
	    personas.push(Persona(nextId,name,description));
	    nextId++;
	}
	
	//Declara internal porque es solo para uso interno y view xq no modifica solo se ve los datos
	function findIndex(uint _id) internal view returns (uint){
	    for(uint i=0; i< personas.length; i++){
	        if(personas[i].id == _id){
	            return i;
	        }
	    }
	    revert('Person has no found now'); //En el caso de que no encuentre algun id usa esta funcion
	}
	
	function readPerson(uint _id) public view returns(uint,string memory,string memory){
	    uint index = findIndex(_id); //Llama a la funcion findIndex
	    return (personas[index].id,
	            personas[index].name,
	            personas[index].description);
	    
	}
	
	//Los valores se actuaizan pero se queda un registro de los datos guardados previamente, no existe forma de alterar
	function updatePerson(uint _id,string memory name,string memory description) public{
	    uint index = findIndex(_id);
	    personas[index].name = name;
	    personas[index].description = description;
	}
	
	//Cabe recalcar que no se puede eliminar datos de una Blockchain
	//una vez registrado no se puede borrar la informacion guardada
	//Aqui solo vuelve a su estado por defecto a los datos
	function deletePerson(uint _id) public{
	    uint index = findIndex(_id);
	    delete personas[index];
	    
	    
	}
}