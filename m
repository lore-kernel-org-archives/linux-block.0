Return-Path: <faiz_abbas@ti.com>
From: Faiz Abbas <faiz_abbas@ti.com>
Subject: mmc filesystem performance decreased on the first write after
 filesystem creation
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-omap
	<linux-omap@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
CC: Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>,
        Jens
 Axboe <axboe@kernel.dk>
Message-ID: <a976e20a-3ed1-43d0-4665-f570ef496d02@ti.com>
Date: Tue, 22 May 2018 20:48:31 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

Hi,

I am debugging a performance reduction in ext2 filesystems on an mmc
device in TI's am335x evm board.

I see that the performance is reduced on the first write after making a
new filesystem using mkfs.ext2 on one of the mmc partitions. The
performance comes back to normal after the first write.

commands used:

=> umount /dev/mmcblk1p2

=> mkfs.ext2 -F  /dev/mmcblk1p2

=> mount -t ext2 -o async /dev/mmcblk1p2 /mnt/partition_mmc

=> dd if=/dev/urandom of=/dev/shm/srctest_file_mmc_1184 bs=1M count=10

=> ./filesystem_tests -write -src_file /dev/shm/srctest_file_mmc_1184
-srcfile_size 10 -file /mnt/partition_mmc/test_file_1184 -buffer_size
102400 -file_size 100 -performance

The filesystem_tests write utility reads from the file generated at
/dev/shm/srctest_file_mmc_1184, memory maps the file to a buffer, and
then writes it into the newly created /mnt/partition_mmc in multiples of
buffer_size while measuring write performance.

See here for the implementation of filesystem_tests write utility:
http://arago-project.org/git/projects/?p=test-automation/ltp-ddt.git;a=blob;f=testcases/ddt/filesystem_test_suite/src/testcases/st_filesystem_write_to_file.c;h=80e8e244d7eaa9f0dbd9b21ea705445156c36bef;hb=f7fc06c290333ce08a7d4fba104eee0f0f1d942b

Complete log with multiple calls to filesystem_tests:
https://pastebin.ubuntu.com/p/BckmTJpqPv/

Notice that the first run of filesystem_tests has a lower throughput
reported.

I was able to bisect the issue to this commit:
5d1429fead5b (mmc: remove the discard_zeroes_data flag)

I would assume that after this flag is removed, the filesystem creation
command would explicitly write zeroes to the device which might explain
the performance fall. However, then the mkfs.ext2 command itself should
take more time rather than the first file write after that.

It would be nice if someone could help me understand why this is happening.

Thanks for your help.

Regards,
Faiz
