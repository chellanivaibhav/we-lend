App = {
  web3Provider: null,
  contracts: {},

  init: function() {
    // Load pets.
    /*$.getJSON('../pets.json', function(data) {
      console.log(data);
      var petsRow = $('#petsRow');
      var petTemplate = $('#petTemplate');

      for (i = 0; i < data.length; i ++) {
        petTemplate.find('.panel-title').text(data[i].name);
        petTemplate.find('img').attr('src', data[i].picture);
        petTemplate.find('.pet-breed').text(data[i].breed);
        petTemplate.find('.pet-age').text(data[i].age);
        petTemplate.find('.pet-location').text(data[i].location);
        petTemplate.find('.btn-adopt').attr('data-id', data[i].id);

        petsRow.append(petTemplate.html());
      }
    });
    */
    return App.initWeb3();
  },

  initWeb3: function() {
    // Initialize web3 and set the provider to the testRPC.
    if (typeof web3 !== 'undefined') {
      App.web3Provider = web3.currentProvider;
      web3 = new Web3(web3.currentProvider);
    } else {
  // set the provider you want from Web3.providers
    App.web3Provider = new web3.providers.HttpProvider('http://localhost:8545');
    web3 = new Web3(App.web3Provider);
}
return App.initContract();
},

initContract: function() {
 $.getJSON('WeLend.json', function(data) {
  // Get the necessary contract artifact file and instantiate it with truffle-contract.
  var LendArtifact = data;
  App.contracts.Lend = TruffleContract(LendArtifact);
  
  // Set the provider for our contract.
  App.contracts.Lend.setProvider(App.web3Provider);

  // Use our contract to retieve and mark the adopted pets.
  return App.updateUI();
});

 return App.bindEvents();
},
//bind ui to contract function
bindEvents: function() {
  $(document).on('click', '.btn-adopt', App.handleAdopt);
},

handleAdopt: function() {
  event.preventDefault();
  var adoptionInstance;
  
  web3.eth.getAccounts(function(error, accounts) {
    if (error) {
      console.log(error);
    }

    var account = accounts[0];

    App.contracts.Adoption.deployed().then(function(instance) {
      adoptionInstance = instance;
      return adoptionInstance.adopt(petId, {from: account});
    }).then(function(result) {
      return App.markAdopted();
    }).catch(function(err) {
      console.log("petid is "+petId);
      console.log(err.message);
    });
  });
},
//check
updateUI: function(adopters, account) {

  var adoptionInstance;

  App.contracts.Adoption.deployed().then(function(instance) {
    adoptionInstance = instance;

    return adoptionInstance.getAdopters.call();
  }).then(function(adopters) {
    for (i = 0; i < adopters.length; i++) {
      if (adopters[i] !== '0x0000000000000000000000000000000000000000') {
        $('.panel-pet').eq(i).find('button').text('Pending...').attr('disabled', true);
      }
    }
  }).catch(function(err) {
    console.log(err.message);
  });
}

};

$(function() {
  $(window).load(function() {
    App.init();
  });
});
