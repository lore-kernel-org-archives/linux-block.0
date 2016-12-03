Return-Path: <prvs=11458901a0=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <paolo.valente@linaro.org>
Subject: [PATCHSET/RFC] Make legacy IO schedulers work with blk-mq
Date: Fri, 2 Dec 2016 20:15:14 -0700
Message-ID: <1480734921-23701-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

This is by no means done, but it seems to work well enough that
I thought I'd send it out for others to take a look at and play
with.

Basically this allows blk-mq managed devices to run the legacy
IO schedulers, unmodified. The only requirement is that the
blk-mq device has to be single queue for now, though that
limitation would be rather simple to lift.

Since this is a debug patch, the default scheduler is deadline.
You can switch that to the other configured schedulers, as you
would with non-mq devices. Here's an example of a scsi-mq device
that is running deadline, and being switched to CFQ online:

root@leopard:~# cat /sys/block/sda/mq/0/tags 
nr_tags=31, reserved_tags=0, bits_per_word=4
nr_free=31, nr_reserved=0
active_queues=0

root@leopard:~# cat /sys/block/sda/queue/scheduler 
noop [deadline] cfq 

root@leopard:~# echo cfq > /sys/block/sda/queue/scheduler 
root@leopard:~# cat /sys/block/sda/queue/scheduler 
noop deadline [cfq] 

Testing welcome. There's certainly room for improvement here, so
I'm mostly interested in grave performance issues or crashes, if any.

Can also be viewed/fetched via git:

git://git.kernel.dk/linux-block for-4.11/blk-mq-legacy-sched

-- 
Jens Axboe
