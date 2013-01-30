test_that("getJob returns a data.fraame with one job", {
  
})

test_that("getJobs returns a data.frame", {
  jobs <- getJobs()
  expect_that(jobs, is_a("data.frame"))
})