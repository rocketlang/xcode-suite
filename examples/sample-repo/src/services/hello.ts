export function add(a: number, b: number){ return a + b }
export function div(a: number, b: number){ if(b===0) throw new Error('Divide by zero'); return a / b }
