"use strict";var c=Object.defineProperty;var s=Object.getOwnPropertyDescriptor;var i=Object.getOwnPropertyNames;var l=Object.prototype.hasOwnProperty;var m=(a,n)=>{for(var o in n)c(a,o,{get:n[o],enumerable:!0})},f=(a,n,o,r)=>{if(n&&typeof n=="object"||typeof n=="function")for(let e of i(n))!l.call(a,e)&&e!==o&&c(a,e,{get:()=>n[e],enumerable:!(r=s(n,e))||r.enumerable});return a};var p=a=>f(c({},"__esModule",{value:!0}),a);var g={};m(g,{default:()=>u});module.exports=p(g);var t=require("@raycast/api");async function u(a){let n="cleanshot://capture-fullscreen";await(0,t.closeMainWindow)(),a.arguments?.action?(0,t.open)(n+"?action="+a.arguments.action):(0,t.open)(n)}
