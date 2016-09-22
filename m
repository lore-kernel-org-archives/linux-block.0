Return-Path: <prvs=8073c3c87f=jbacik@fb.com>
Subject: Re: [PATCH 2/2] blk-mq: add flag for drivers wanting blocking
 ->queue_rq()
To: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@fb.com>
References: <1474555980-2787-1-git-send-email-axboe@fb.com>
 <1474555980-2787-3-git-send-email-axboe@fb.com>
 <20160922145922.GB1800@infradead.org>
CC: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Ming Lei
	<ming.lei@canonical.com>
From: Josef Bacik <jbacik@fb.com>
Message-ID: <02165387-eedc-d237-5ad1-c5d8be3d17c7@fb.com>
Date: Thu, 22 Sep 2016 11:04:09 -0400
MIME-Version: 1.0
In-Reply-To: <20160922145922.GB1800@infradead.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 09/22/2016 10:59 AM, Christoph Hellwig wrote:
> On Thu, Sep 22, 2016 at 08:53:00AM -0600, Jens Axboe wrote:
>> If a driver sets BLK_MQ_F_BLOCKING, it is allowed to block in its
>> ->queue_rq() handler. For that case, blk-mq ensures that we always
>> calls it from a safe context.
>
> First can you provide a more useful defintion of blocking?  Lots of current
> drivers will already block in ->queue_rq, mostly to allocate memory.
>

NBD needs to take a mutex before it sends.  This patch was born out of a kbuild 
error I got because of a schedule while atomic, this was the backtrace

[   17.698207] BUG: sleeping function called from invalid context at 
kernel/locking/mutex.c:620
[   17.700903] in_atomic(): 1, irqs_disabled(): 0, pid: 1050, name: mount
[   17.702350] 1 lock held by mount/1050:
[   17.703395]  #0:  (&type->s_umount_key#20/1){+.+.+.}, at: 
[<ffffffff8122627b>] sget_userns+0x2f7/0x4b0
[   17.706064] CPU: 0 PID: 1050 Comm: mount Not tainted 4.8.0-rc4-00007-gfd8383fd #1
[   17.708149] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
Debian-1.8.2-1 04/01/2014
[   17.710523]  0000000000000000 ffff880034dd39f0 ffffffff8178e23d ffff8800350e4d00
[   17.712773]  000000000000041a ffff880034dd3a18 ffffffff81108c39 ffffffff839f1476
[   17.714978]  000000000000026c 0000000000000000 ffff880034dd3a40 ffffffff81108cb5
[   17.717224] Call Trace:
[   17.718130]  [<ffffffff8178e23d>] dump_stack+0x82/0xb8
[   17.719474]  [<ffffffff81108c39>] ___might_sleep+0x1bd/0x1c4
[   17.720813]  [<ffffffff81108cb5>] __might_sleep+0x75/0x7c
[   17.722100]  [<ffffffff82ef53e2>] mutex_lock_nested+0x3e/0x396
[   17.723449]  [<ffffffff8114aace>] ? mod_timer+0x10/0x12
[   17.724705]  [<ffffffff81770002>] ? blk_add_timer+0xe0/0xe5
[   17.726088]  [<ffffffff81c2a35c>] nbd_queue_rq+0x7b/0x14b
[   17.727367]  [<ffffffff81c2a35c>] ? nbd_queue_rq+0x7b/0x14b
[   17.728653]  [<ffffffff81772b66>] __blk_mq_run_hw_queue+0x1c7/0x2c8
[   17.730118]  [<ffffffff81772942>] blk_mq_run_hw_queue+0x5e/0xbb
[   17.731454]  [<ffffffff81773d53>] blk_sq_make_request+0x1a1/0x1ba
[   17.732806]  [<ffffffff81768e24>] generic_make_request+0xbd/0x160
[   17.734153]  [<ffffffff81768fbd>] submit_bio+0xf6/0xff
[   17.735365]  [<ffffffff81252806>] submit_bh_wbc+0x136/0x143
[   17.736719]  [<ffffffff81252c00>] submit_bh+0x10/0x12
[   17.737888]  [<ffffffff81252c52>] __bread_gfp+0x50/0x6f
[   17.739212]  [<ffffffff812f290a>] ext4_fill_super+0x1f4/0x27ec
[   17.740492]  [<ffffffff81798a59>] ? vsnprintf+0x22d/0x3b7
[   17.741685]  [<ffffffff812265e3>] mount_bdev+0x144/0x197
[   17.742928]  [<ffffffff812f2716>] ? ext4_calculate_overhead+0x2bd/0x2bd
[   17.744275]  [<ffffffff812ede93>] ext4_mount+0x15/0x17
[   17.745406]  [<ffffffff81227049>] mount_fs+0x67/0x131
[   17.746518]  [<ffffffff8123ee2f>] vfs_kern_mount+0x6b/0xdb
[   17.747675]  [<ffffffff81241759>] do_mount+0x708/0x97d
[   17.748833]  [<ffffffff811e87f0>] ? __might_fault+0x7e/0x84
[   17.750074]  [<ffffffff811da511>] ? strndup_user+0x3f/0x53
[   17.751198]  [<ffffffff81268eb6>] compat_SyS_mount+0x185/0x1ae
[   17.752433]  [<ffffffff81003b6f>] do_int80_syscall_32+0x5c/0x6b
[   17.753592]  [<ffffffff82efa6d8>] entry_INT80_compat+0x38/0x50
[   17.754952] block nbd11: Attempted send on closed socket

> Second we looked at something similar a few times ago, mosty notably
> when converting loop and rbd, and came to the conclusion that
> performance sucks when we only have that single per-hctx work struct
> for a busy device.  I think Ming has done a lot of the benchmarking,
> so I've added him to Cc.
>

Yeah this looks to be about a 5% hit on my microbenchmarks for NBD, but nobody 
accuses NBD of being particularly fast either so I wasn't too worried about it. 
If we want to say that we can block in ->queue_rq that would make me happy too. 
Thanks,

Josef
