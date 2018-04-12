Return-Path: <prvs=6335d9f7e=Bart.VanAssche@wdc.com>
Subject: Re: [PATCH] block: Ensure that a request queue is dissociated from
 the cgroup controller
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>,
 Alexandru Moise <00moses.alexander00@gmail.com>
References: <20180412015852.26014-1-bart.vanassche@wdc.com>
 <20180412135149.GX793541@devbig577.frc2.facebook.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <af6dafea-d754-8a0d-b96b-81716f2ea24d@wdc.com>
Date: Thu, 12 Apr 2018 08:09:17 -0600
MIME-Version: 1.0
In-Reply-To: <20180412135149.GX793541@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Return-Path: bart.vanassche@wdc.com
List-ID: <linux-block@vger.kernel.org>

On 04/12/18 07:51, Tejun Heo wrote:
> On Wed, Apr 11, 2018 at 07:58:52PM -0600, Bart Van Assche wrote:
>> Several block drivers call alloc_disk() followed by put_disk() if
>> something fails before device_add_disk() is called without calling
>> blk_cleanup_queue(). Make sure that also for this scenario a request
>> queue is dissociated from the cgroup controller. This patch avoids
>> that loading the parport_pc, paride and pf drivers triggers the
>> following kernel crash:
>>
>> BUG: KASAN: null-ptr-deref in pi_init+0x42e/0x580 [paride]
>> Read of size 4 at addr 0000000000000008 by task modprobe/744
>> Call Trace:
>> dump_stack+0x9a/0xeb
>> kasan_report+0x139/0x350
>> pi_init+0x42e/0x580 [paride]
>> pf_init+0x2bb/0x1000 [pf]
>> do_one_initcall+0x8e/0x405
>> do_init_module+0xd9/0x2f2
>> load_module+0x3ab4/0x4700
>> SYSC_finit_module+0x176/0x1a0
>> do_syscall_64+0xee/0x2b0
>> entry_SYSCALL_64_after_hwframe+0x42/0xb7
>>
>> Reported-by: Alexandru Moise <00moses.alexander00@gmail.com>
>> Fixes: a063057d7c73 ("block: Fix a race between request queue removal and the block cgroup controller")
>> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
>> Cc: Alexandru Moise <00moses.alexander00@gmail.com>
>> Cc: Tejun Heo <tj@kernel.org>
> 
> So, this might be correct for this reported case but I don't think
> it's correct in general.  There's no synchronization between blkcg
> q->lock usages and blk_cleanup_queue().  e.g. hotunplugging and
> shutting down a device while file operations are still in progress can
> easily blow this up.

Hello Tejun,

I have retested hotunplugging by rerunning the srp-test software. It 
seems like you overlooked that this patch does not remove the 
blkcg_exit_queue() call from blk_cleanup_queue()? If a device is 
hotunplugged it is up to the block driver to call blk_cleanup_queue(). 
And blk_cleanup_queue() will call blkcg_exit_queue().

Bart.
