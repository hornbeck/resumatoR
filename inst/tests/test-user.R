test_that("getUser returns a data.fraame with one user", {
  
})

test_that("getUsers returns a data.frame", {
  users <- getUsers()
  expect_that(users, is_a("data.frame"))  
})