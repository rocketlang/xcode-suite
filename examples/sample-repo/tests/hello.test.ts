import { add, div } from '../src/services/hello';
test('add', ()=> expect(add(2,3)).toBe(5));
test('div', ()=> expect(div(6,3)).toBe(2));
