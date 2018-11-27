import React from 'react';
import {Link} from 'react-router-dom';
import axios from 'axios';

class ItemsIndex extends React.Component {

  constructor () {

    super();
    this.state = {
      items: []
    };


  }

  componentDidMount(){

    axios.get('/items.json')
    .then(response => {
      console.log( response );
      this.setState({items: response.data})
    })
    .catch( console.error );

  }
  gotoItem( id ) {

    this.props.history.push(`/${id}`);
  }
  render() {
    return (
      <div>
        <h1>All Items</h1>
        <ul>
          { this.state.items.map(item => <li onClick={()=> this.gotoItem(item.id)}>{item.summary}</li>) }
        </ul>
      </div>
    );
  }
}

export default ItemsIndex
