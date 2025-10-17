/**
 * T001 Scaffold Tests
 * Validates that the project structure is properly set up
 */

const assert = require('assert');
const fs = require('fs');
const path = require('path');

describe('T001: Scaffold & Tooling', () => {
  const projectRoot = path.resolve(__dirname, '..');

  describe('Configuration Files', () => {
    it('should have package.json', () => {
      const pkgPath = path.join(projectRoot, 'package.json');
      assert.ok(fs.existsSync(pkgPath), 'package.json should exist');
      
      const pkg = require(pkgPath);
      assert.ok(pkg.name, 'package.json should have name');
      assert.ok(pkg.version, 'package.json should have version');
      assert.ok(pkg.workspaces, 'package.json should have workspaces');
    });

    it('should have .gitignore', () => {
      const gitignorePath = path.join(projectRoot, '.gitignore');
      assert.ok(fs.existsSync(gitignorePath), '.gitignore should exist');
    });

    it('should have ESLint config', () => {
      const eslintPath = path.join(projectRoot, '.eslintrc.json');
      assert.ok(fs.existsSync(eslintPath), '.eslintrc.json should exist');
    });

    it('should have Prettier config', () => {
      const prettierPath = path.join(projectRoot, '.prettierrc');
      assert.ok(fs.existsSync(prettierPath), '.prettierrc should exist');
    });

    it('should have README', () => {
      const readmePath = path.join(projectRoot, 'README.md');
      assert.ok(fs.existsSync(readmePath), 'README.md should exist');
    });
  });

  describe('Directory Structure', () => {
    it('should have packages directory', () => {
      const packagesPath = path.join(projectRoot, 'packages');
      assert.ok(fs.existsSync(packagesPath), 'packages/ should exist');
    });

    it('should have tests directory', () => {
      const testsPath = path.join(projectRoot, 'tests');
      assert.ok(fs.existsSync(testsPath), 'tests/ should exist');
    });

    it('should have reports directory', () => {
      const reportsPath = path.join(projectRoot, 'reports');
      assert.ok(fs.existsSync(reportsPath), 'reports/ should exist');
    });
  });

  describe('Git Repository', () => {
    it('should have .git directory', () => {
      const gitPath = path.join(projectRoot, '.git');
      assert.ok(fs.existsSync(gitPath), '.git/ should exist');
    });
  });
});
