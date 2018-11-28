import React from 'react';
import axios from 'axios';

export default class ItemDetail extends React.Component {

  constructor (props) {

    super(props);
    this.state = {
      item: []
    };
  }

  componentDidMount(){
    let id = this.props.match.params.id;

    axios.get(`/items/${id}.json`)
    .then(response => {
      // console.log( response );
      this.setState({item: response.data})
    })
    .catch( console.error );

  }

  render() {
    return (
      <div>
        <h1>All Items</h1>
        <ul>
          <li>{this.state.item.summary}</li>
          <li>{this.state.item.address}</li>
        </ul>
      </div>
    );
  }
}
