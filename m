Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:6682 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752510AbdBIJkn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Feb 2017 04:40:43 -0500
To: <linux-block@vger.kernel.org>
From: Hou Tao <houtao1@huawei.com>
Subject: rate-capped fio jobs in a CFQ group degrade performance of fio jobs
 in another CFQ group with the same weight
CC: <axboe@fb.com>, Shaohua Li <shli@fb.com>, <tj@kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Message-ID: <d3c53b1b-ec45-4a37-35bd-36489b5aaf4a@huawei.com>
Date: Thu, 9 Feb 2017 17:40:16 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi all,

During our test of the CFQ group schedule, we found a performance related problem.
Rate-capped fio jobs in a CFQ group will degrade the performance of fio jobs in
another CFQ group. Both of the CFQ groups have the same blkio.weight.

We launch two fios in difference terminals. The following is the content of
these two job files:

# cat a.job
[global]
bs=4k
ioengine=psync
iodepth=1
direct=1
rw=randwrite
time_based
runtime=30
cgroup_nodelete=1
group_reporting=1

[test1]
filename=test1.dat
size=2G
cgroup_weight=500
cgroup=testA
thread=1
numjobs=2

[test3]
stonewall
filename=test3.dat
size=2G
rate=4m
cgroup_weight=500
cgroup=testA
thread=1
numjobs=2


# cat b.job
[global]
bs=4k
ioengine=psync
iodepth=1
direct=1
rw=randwrite
time_based
runtime=60
cgroup_nodelete=1
group_reporting=1

[test2]
filename=test2.dat
size=2G
cgroup_weight=500
cgroup=testB
thread=1
numjobs=2

In the first 30 seconds, the iops of both "test1" and "test3" is ~5000 and
the rate is about 20MBps.

In the last 30 seconds, we start "test3" and the rate of "test3" is limited to
8MBps (4MBps * 2 jobs). The cap works fine, but the iops of "test2" also
degraded from ~5000 to ~2040 or lower. This may seems reasonable for CFQ group
schedule because it needs to dispatch disk time equally to these two CFQ group,
but it doesn't fully utilize the disk throughput.

It can be reproduced on 4.4 and 4.10.0-rc7, the version of fio is 2.2.4.
The configuration options of CFQ are untouched.

I am not sure whether this situation is a bug or not. Are there some
configuration options we can used to alleviate the performance degradation
problem ? And how CFQ group schedule handles the trace-off between fairness
and performance ?

Any suggestion will be appreciated.

Regards,

Tao
