Return-Path: <prvs=011358c635=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>
CC: <hch@lst.de>
Subject: [PATCHSET] block: IO polling improvements
Date: Tue, 1 Nov 2016 15:05:21 -0600
Message-ID: <1478034325-28232-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

This builds on top of Christophs simplified bdev O_DIRECT code,
posted earlier today [1].

This patchset adds support for a hybrid polling mode, where a poll
cycle can be split into an upfront sleep, then a busy poll. On the
devices where we care about IO polling, generally we have fairly
deterministic completion latencies. So this patchset pulls in
the stats code from the buffered writeback code, and uses that to
more intelligently poll a device.

Let's assume a device completes IO in 8 usecs. When we poll now,
we busy loop for 8 usec. It's a lot more efficient to sleep for
a bit, then poll the last few usecs instead, if we know the
rough completion time of the IO.

This adds a sysfs file, /sys/block/<dev>/queue/io_poll_delay, which
makes the polling behave as follows:

-1	Never enter hybrid sleep, always poll
 0	Use half of the completion mean for this request type for the
	sleep delay
>0	Use this specific value as the sleep delay

We default to -1, which is the old behavior. Initial testing with '0'
has been positive, retaining 93% of the performance at roughly 50%
CPU instead of the 100% with classic polling.

You can also find this code in my for-4.10/dio branch.

[1] https://marc.info/?l=linux-kernel&m=147793678521108&w=2
