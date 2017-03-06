Return-Path: <houtao1@huawei.com>
From: Hou Tao <houtao1@huawei.com>
Subject: cfq-iosched: two questions about the hrtimer version of CFQ
To: Jan Kara <jack@suse.cz>, <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        Vivek Goyal
	<vgoyal@redhat.com>
Message-ID: <775f3ecb-45d1-4264-885a-f14e0458d36b@huawei.com>
Date: Mon, 6 Mar 2017 21:50:09 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

Hi Jan and list,

When testing the hrtimer version of CFQ, we found a performance degradation
problem which seems to be caused by commit 0b31c10 ("cfq-iosched: Charge at
least 1 jiffie instead of 1 ns").

The following is the test process:

* filesystem and block device
	* XFS + /dev/sda mounted on /tmp/sda
* CFQ configuration
	* default configurations
* fio job configuration
	[global]
	bs=4k
	ioengine=psync
	iodepth=1
	direct=1
	rw=randwrite
	time_based
	runtime=15
	cgroup_nodelete=1
	group_reporting=1

	[cfq_a]
	filename=/tmp/sda/cfq_a.dat
	size=2G
	cgroup_weight=500
	cgroup=cfq_a
	thread=1
	numjobs=2

	[cfq_b]
	new_group
	filename=/tmp/sda/cfq_b.dat
	size=2G
	rate=4m
	cgroup_weight=500
	cgroup=cfq_b
	thread=1
	numjobs=2


The following is the test result:
* with 0b31c10:
	* fio report
		cfq_a: bw=5312.6KB/s, iops=1328
		cfq_b: bw=8192.6KB/s, iops=2048

	* blkcg debug files
		./cfq_a/blkio.group_wait_time:8:0 12062571233
		./cfq_b/blkio.group_wait_time:8:0 155841600
		./cfq_a/blkio.io_serviced:Total 19922
		./cfq_b/blkio.io_serviced:Total 30722
		./cfq_a/blkio.time:8:0 19406083246
		./cfq_b/blkio.time:8:0 19417146869

* without 0b31c10:
	* fio report
		cfq_a: bw=21670KB/s, iops=5417
		cfq_b: bw=8191.2KB/s, iops=2047

	* blkcg debug files
		./cfq_a/blkio.group_wait_time:8:0 5798452504
		./cfq_b/blkio.group_wait_time:8:0 5131844007
		./cfq_a/blkio.io_serviced:8:0 Write 81261
		./cfq_b/blkio.io_serviced:8:0 Write 30722
		./cfq_a/blkio.time:8:0 5642608173
		./cfq_b/blkio.time:8:0 5849949812

We want to known the reason why you revert the minimal used slice to 1 jiffy
when the slice has not been allocated. Does it lead to some performance
regressions or something similar ? If not, I think we could revert the minimal
slice to 1 ns again.

Another problem is about the time comparison in CFQ code. In no-hrtimer version
of CFQ, it uses time_after or time_before when possible, Why the hrtimer version
doesn't use the equivalent time_after64/time_before64 ? Can ktime_get_ns()
ensure there will be no wrapping problem ?

Thanks very much.

Regards,

Tao
