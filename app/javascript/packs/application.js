/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

// console.log('Hello World from react')

import React from 'react';
import ReactDOM from 'react-dom';
import ItemsIndex from '../components/ItemsIndex';
import {HashRouter as Router, Route} from 'react-router-dom';
import ItemDetail from '../components/ItemDetail';

const Routes = (
  <Router>
  <div>
    <Route exact path="/" component={ ItemsIndex }/>
    <Route exact path="/:id" component={ ItemDetail }/>
  </div>
  </Router>
);

document.addEventListener('DOMContentLoaded', () => {
  const container = document.body.appendChild(document.createElement('div'));
  ReactDOM.render(Routes, container);
});

// ReactDOM.render(Routes, document.getElementByID('root'));
