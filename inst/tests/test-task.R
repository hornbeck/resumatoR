test_that("getTask returns a data.fraame with one task", {
  
})

test_that("getTasks returns a data.frame", {
  tasks <- getTasks()
  expect_that(tasks, is_a("data.frame"))
})