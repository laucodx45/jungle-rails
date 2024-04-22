describe('home page', () => {
  
  beforeEach(() => {
    cy.visit('http://localhost:3000/')
  })

  it('should display nav bar', () => {
    cy.get('.intro').should('exist');
    cy.get('.intro').find('p').should('have.length', 3);
  })

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });
  
  it ('should have Evergreens as category and should be clickable', () => {
    cy.contains('a.nav-link', 'Evergreens')
    .should('have.attr', 'href', '/categories/1')
    .click()
  })


})