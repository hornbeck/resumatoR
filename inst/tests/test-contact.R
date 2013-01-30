test_that("getContact returns a data.fraame with one contact", {
  
})

test_that("getContacts returns a data.frame", {
  contacts <- getContacts()
  expect_that(contacts, is_a("data.frame"))
})