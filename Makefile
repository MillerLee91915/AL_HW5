
all:hw5_test.s numsort.s
	arm-none-eabi-gcc -g ./hw5_test.s  ./numsort.s -o hw5
clean:
	rm -f hw5
