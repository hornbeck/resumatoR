test_that("getActivity returns a data.fraame with one activity", {
  
})

test_that("getActivities returns a data.frame", {
  activities <- getActivities()
  expect_that(activities, is_a("data.frame"))
})


