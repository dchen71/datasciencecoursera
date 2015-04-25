## Run_analysis function
This function analyzes the UCI wearables data and produces two tables of data:
table1 - id, activity, mean/sd for each result for test and training data
table2 - id, activity, mean/sd for each id/activity for test and training data

## Function Breakdown
1. The data from test is read into 3 tables: teSubject(subject_test.txt, teY_test(y_test.txt), teX_test(x_test.txt)
2. teSubject, teY_test are melted down to create teSubY containing the id,test.activity
3. teSubY, teX_test are melted down to create teTable which contains id, test, activity, and each test data result

4. teTable is subset to have id, activity.test
5. rowMean is used to find the mean of each trial and stored in teMean
6. A loop is used to find the sd of each trial and stored in teSD
7. The data from teMean and teSD are transplanted into table1p1

8. The data from train is read into 3 tables: trSubject(subject_train.txt, trY_test(y_train.txt), trX_test(x_train.txt)
9. trSubject, trY_test are melted down to create trSubY containing the id,test.activity
10. trSubY, trX_test are melted down to create trTable which contains id, test, activity, and each train data result

11. trTable is subset to have id, activity.train
12. rowMean is used to find the mean of each trial and stored in trMean
13. A loop is used to find the sd of each trial and stored in trSD
14. The data from trMean and trSD are transplanted into table1p2

15. Both table1p2, table1p1 are merged together and globally returned

16. teTable is melted down to extract the test data for id, test.activity and saved in test1
17. test1 is recasted to create a table showing the mean per activity/id and saved in test2
18. test1 is recasted to create a table showing the mean per activity/id and saved in test3
19. A for loop is used to move all the valid data points to column 3 of both test2 and test3
20. The columns for test2/test3 are renamed and subset to remove the extra columns
21. The mean and sd data are merged into a single table in testTable

22. trTable is melted down to extract the train data for id, train.activity and saved in train1
23. train1 is recasted to create a table showing the mean per activity/id and saved in train2
24. train1 is recasted to create a table showing the mean per activity/id and saved in train3
25. A for loop is used to move all the valid data points to column 3 of both train2 and train3
26. The columns for train2/train3 are renamed and subset to remove the extra columns
27. The mean and sd data are merged into a single table in trainTable

28. trainTable and testTable are merged together and globally returned in table2