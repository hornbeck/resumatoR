test_that("getApplicant returns a data.fraame with one applicant", {
  
})

test_that("getApplicants returns a data.frame", {
  applicants <- getApplicants()
  expect_that(applicants, is_a("data.frame"))
})

