Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHSET v5] blk-mq: reimplement timeout handling
To: Bart Van Assche <Bart.VanAssche@wdc.com>, "jbacik@fb.com"
 <jbacik@fb.com>, "tj@kernel.org" <tj@kernel.org>, "jack@suse.cz"
 <jack@suse.cz>, "clm@fb.com" <clm@fb.com>
Cc: "kernel-team@fb.com" <kernel-team@fb.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
References: <20180109162953.1211451-1-tj@kernel.org>
 <1515790585.2396.50.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3b2ad58c-837a-a084-fdb5-7e8913e5e285@kernel.dk>
Date: Fri, 12 Jan 2018 14:07:33 -0700
MIME-Version: 1.0
In-Reply-To: <1515790585.2396.50.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/12/18 1:57 PM, Bart Van Assche wrote:
> On Tue, 2018-01-09 at 08:29 -0800, Tejun Heo wrote:
>> Currently, blk-mq timeout path synchronizes against the usual
>> issue/completion path using a complex scheme involving atomic
>> bitflags, REQ_ATOM_*, memory barriers and subtle memory coherence
>> rules.  Unfortunatley, it contains quite a few holes.
> 
> Hello Tejun,
> 
> With this patch series applied I see weird hangs in blk_mq_get_tag() when I
> run the srp-test software. If I pull Jens' latest for-next branch and revert
> this patch series then the srp-test software runs successfully. Note: if you
> don't have InfiniBand hardware available then you will need the RDMA/CM
> patches for the SRP initiator and target drivers that have been posted
> recently on the linux-rdma mailing list to run the srp-test software.

You're really not making it easy for folks to run this :-)

> This is how I run the srp-test software in a VM:
> 
> ./run_tests -c -d -r 10
> 
> Here is an example of what SysRq-w reported when the hang occurred:
> 
> sysrq: SysRq : Show Blocked State
>  task                        PC stack   pid father
> kworker/u8:0    D12864     5      2 0x80000000
> Workqueue: events_unbound sd_probe_async [sd_mod]
> Call Trace:
> ? __schedule+0x2b4/0xbb0
> schedule+0x2d/0x90
> io_schedule+0xd/0x30
> blk_mq_get_tag+0x169/0x290
> ? finish_wait+0x80/0x80
> blk_mq_get_request+0x16a/0x4f0
> blk_mq_alloc_request+0x59/0xc0
> blk_get_request_flags+0x3f/0x260
> scsi_execute+0x33/0x1e0 [scsi_mod]
> read_capacity_16.part.35+0x9c/0x460 [sd_mod]
> sd_revalidate_disk+0x14bb/0x1cb0 [sd_mod]
> sd_probe_async+0xf2/0x1a0 [sd_mod]
> process_one_work+0x21c/0x6d0
> worker_thread+0x35/0x380
> ? process_one_work+0x6d0/0x6d0
> kthread+0x117/0x130
> ? kthread_create_worker_on_cpu+0x40/0x40
> ret_from_fork+0x24/0x30
> systemd-udevd   D13672  1048    285 0x00000100
> Call Trace:
> ? __schedule+0x2b4/0xbb0
> schedule+0x2d/0x90
> io_schedule+0xd/0x30
> generic_file_read_iter+0x32f/0x970
> ? page_cache_tree_insert+0x100/0x100
> __vfs_read+0xcc/0x120
> vfs_read+0x96/0x140
> SyS_read+0x40/0xa0
> do_syscall_64+0x5f/0x1b0
> entry_SYSCALL64_slow_path+0x25/0x25

Do you have the matching blk-mq debugfs output for the device?

-- 
Jens Axboe
