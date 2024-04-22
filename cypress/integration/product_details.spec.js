describe('product detail page', () => {
  
  beforeEach(() => {
    cy.visit('http://localhost:3000/')
  });

  it('should display nav bar', () => {
    cy.get('.intro').should('exist');
    cy.get('.intro').find('p').should('have.length', 3);
  });

  it("There is products on the page", () => {
    cy.get('.products article').should("be.visible");
  });

  it("clicking on product should take user to product details page", () => {
    cy.contains('a', 'Cliff Collard')
      .should('have.attr', 'href', '/products/12')
      .click()
      .get('.products-show').should('be.visible')
      .contains('h1', 'Cliff Collard')
  })
});