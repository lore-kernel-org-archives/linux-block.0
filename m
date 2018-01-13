Return-Path: <ming.lei@redhat.com>
Date: Sun, 14 Jan 2018 01:59:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Laurence Oberman <loberman@redhat.com>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
	"jbacik@fb.com" <jbacik@fb.com>, "tj@kernel.org" <tj@kernel.org>,
	"jack@suse.cz" <jack@suse.cz>, "clm@fb.com" <clm@fb.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCHSET v5] blk-mq: reimplement timeout handling
Message-ID: <20180113175932.GA22054@ming.t460p>
References: <20180109162953.1211451-1-tj@kernel.org>
 <1515790585.2396.50.camel@wdc.com>
 <1515794134.28222.4.camel@redhat.com>
 <20180113144514.GA8013@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180113144514.GA8013@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Sat, Jan 13, 2018 at 10:45:14PM +0800, Ming Lei wrote:
> On Fri, Jan 12, 2018 at 04:55:34PM -0500, Laurence Oberman wrote:
> > On Fri, 2018-01-12 at 20:57 +0000, Bart Van Assche wrote:
> > > On Tue, 2018-01-09 at 08:29 -0800, Tejun Heo wrote:
> > > > Currently, blk-mq timeout path synchronizes against the usual
> > > > issue/completion path using a complex scheme involving atomic
> > > > bitflags, REQ_ATOM_*, memory barriers and subtle memory coherence
> > > > rules.��Unfortunatley, it contains quite a few holes.
> > > 
> > > Hello Tejun,
> > > 
> > > With this patch series applied I see weird hangs in blk_mq_get_tag()
> > > when I
> > > run the srp-test software. If I pull Jens' latest for-next branch and
> > > revert
> > > this patch series then the srp-test software runs successfully. Note:
> > > if you
> > > don't have InfiniBand hardware available then you will need the
> > > RDMA/CM
> > > patches for the SRP initiator and target drivers that have been
> > > posted
> > > recently on the linux-rdma mailing list to run the srp-test software.
> > > 
> > > This is how I run the srp-test software in a VM:
> > > 
> > > ./run_tests -c -d -r 10
> > > 
> > > Here is an example of what SysRq-w reported when the hang occurred:
> > > 
> > > sysrq: SysRq : Show Blocked State
> > > �task������������������������PC stack���pid father
> > > kworker/u8:0����D12864�����5������2 0x80000000
> > > Workqueue: events_unbound sd_probe_async [sd_mod]
> > > Call Trace:
> > > ? __schedule+0x2b4/0xbb0
> > > schedule+0x2d/0x90
> > > io_schedule+0xd/0x30
> > > blk_mq_get_tag+0x169/0x290
> > > ? finish_wait+0x80/0x80
> > > blk_mq_get_request+0x16a/0x4f0
> > > blk_mq_alloc_request+0x59/0xc0
> > > blk_get_request_flags+0x3f/0x260
> > > scsi_execute+0x33/0x1e0 [scsi_mod]
> > > read_capacity_16.part.35+0x9c/0x460 [sd_mod]
> > > sd_revalidate_disk+0x14bb/0x1cb0 [sd_mod]
> > > sd_probe_async+0xf2/0x1a0 [sd_mod]
> > > process_one_work+0x21c/0x6d0
> > > worker_thread+0x35/0x380
> > > ? process_one_work+0x6d0/0x6d0
> > > kthread+0x117/0x130
> > > ? kthread_create_worker_on_cpu+0x40/0x40
> > > ret_from_fork+0x24/0x30
> > > systemd-udevd���D13672��1048����285 0x00000100
> > > Call Trace:
> > > ? __schedule+0x2b4/0xbb0
> > > schedule+0x2d/0x90
> > > io_schedule+0xd/0x30
> > > generic_file_read_iter+0x32f/0x970
> > > ? page_cache_tree_insert+0x100/0x100
> > > __vfs_read+0xcc/0x120
> > > vfs_read+0x96/0x140
> > > SyS_read+0x40/0xa0
> > > do_syscall_64+0x5f/0x1b0
> > > entry_SYSCALL64_slow_path+0x25/0x25
> > > RIP: 0033:0x7f8ce6d08d11
> > > RSP: 002b:00007fff96dec288 EFLAGS: 00000246 ORIG_RAX:
> > > 0000000000000000
> > > RAX: ffffffffffffffda RBX: 00005651de7f6e10 RCX: 00007f8ce6d08d11
> > > RDX: 0000000000000040 RSI: 00005651de7f6e38 RDI: 0000000000000007
> > > RBP: 00005651de7ea500 R08: 00007f8ce6cf1c20 R09: 00005651de7f6e10
> > > R10: 000000000000006f R11: 0000000000000246 R12: 0000000001ff0000
> > > R13: 0000000001ff0040 R14: 00005651de7ea550 R15: 0000000000000040
> > > systemd-udevd���D13496��1049����285 0x00000100
> > > Call Trace:
> > > ? __schedule+0x2b4/0xbb0
> > > schedule+0x2d/0x90
> > > io_schedule+0xd/0x30
> > > blk_mq_get_tag+0x169/0x290
> > > ? finish_wait+0x80/0x80
> > > blk_mq_get_request+0x16a/0x4f0
> > > blk_mq_make_request+0x105/0x8e0
> > > ? generic_make_request+0xd6/0x3d0
> > > generic_make_request+0x103/0x3d0
> > > ? submit_bio+0x57/0x110
> > > submit_bio+0x57/0x110
> > > mpage_readpages+0x13b/0x160
> > > ? I_BDEV+0x10/0x10
> > > ? rcu_read_lock_sched_held+0x66/0x70
> > > ? __alloc_pages_nodemask+0x2e8/0x360
> > > __do_page_cache_readahead+0x2a4/0x370
> > > ? force_page_cache_readahead+0xaf/0x110
> > > force_page_cache_readahead+0xaf/0x110
> > > generic_file_read_iter+0x743/0x970
> > > ? find_held_lock+0x2d/0x90
> > > ? _raw_spin_unlock+0x29/0x40
> > > __vfs_read+0xcc/0x120
> > > vfs_read+0x96/0x140
> > > SyS_read+0x40/0xa0
> > > do_syscall_64+0x5f/0x1b0
> > > entry_SYSCALL64_slow_path+0x25/0x25
> > > RIP: 0033:0x7f8ce6d08d11
> > > RSP: 002b:00007fff96dec8b8 EFLAGS: 00000246 ORIG_RAX:
> > > 0000000000000000
> > > RAX: ffffffffffffffda RBX: 00007f8ce7085010 RCX: 00007f8ce6d08d11
> > > RDX: 0000000000040000 RSI: 00007f8ce7085038 RDI: 000000000000000f
> > > RBP: 00005651de7ec840 R08: ffffffffffffffff R09: 00007f8ce7085010
> > > R10: 00007f8ce7085028 R11: 0000000000000246 R12: 0000000000000000
> > > R13: 0000000000040000 R14: 00005651de7ec890 R15: 0000000000040000
> > > systemd-udevd���D13672��1055����285 0x00000100
> > > Call Trace:
> > > ? __schedule+0x2b4/0xbb0
> > > schedule+0x2d/0x90
> > > io_schedule+0xd/0x30
> > > blk_mq_get_tag+0x169/0x290
> > > ? finish_wait+0x80/0x80
> > > blk_mq_get_request+0x16a/0x4f0
> > > blk_mq_make_request+0x105/0x8e0
> > > ? generic_make_request+0xd6/0x3d0
> > > generic_make_request+0x103/0x3d0
> > > ? submit_bio+0x57/0x110
> > > submit_bio+0x57/0x110
> > > mpage_readpages+0x13b/0x160
> > > ? I_BDEV+0x10/0x10
> > > ? rcu_read_lock_sched_held+0x66/0x70
> > > ? __alloc_pages_nodemask+0x2e8/0x360
> > > __do_page_cache_readahead+0x2a4/0x370
> > > ? force_page_cache_readahead+0xaf/0x110
> > > force_page_cache_readahead+0xaf/0x110
> > > generic_file_read_iter+0x743/0x970
> > > __vfs_read+0xcc/0x120
> > > vfs_read+0x96/0x140
> > > SyS_read+0x40/0xa0
> > > do_syscall_64+0x5f/0x1b0
> > > entry_SYSCALL64_slow_path+0x25/0x25
> > > RIP: 0033:0x7f8ce6d08d11
> > > RSP: 002b:00007fff96dec848 EFLAGS: 00000246 ORIG_RAX:
> > > 0000000000000000
> > > RAX: ffffffffffffffda RBX: 00005651de7ec300 RCX: 00007f8ce6d08d11
> > > RDX: 0000000000000100 RSI: 00005651de7ec328 RDI: 000000000000000f
> > > RBP: 00005651de7ea500 R08: 0000000000000000 R09: 00005651de7ec300
> > > R10: 00005651de7ec318 R11: 0000000000000246 R12: 0000000001ffe000
> > > R13: 0000000001ffe100 R14: 00005651de7ea550 R15: 0000000000000100
> > > 
> > > Please let me know if you need more information.
> > > 
> > > Bart.
> > 
> > I just bumped into stalls too, using Mike's tree. I had started getting
> > ready with blk-mq enabled for both dm_mod and scsi_mod and testing SRP
> > so I could run further tests for Bart.
> > 
> > I am working to see when it started by starting first with Linus's
> > latest tree as I tested that same without blk-mq initially and it was
> > fine.
> > 
> > My concern is that I tried a 4.15-rc1 kernel as well and still saw
> > issues so have to sanitize all of this first and report back.
> > 
> > My trace was this
> > 
> > [��615.714199]�������Tainted: G����������I������4.15.0-rc4+ #1
> > [��615.746226] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [��615.790597] systemd-udevd���D����0��2247����745 0x80000086
> > [��615.821048] Call Trace:
> > [��615.833971]��? __schedule+0x28d/0x870
> > [��615.854226]��schedule+0x32/0x80
> > [��615.871819]��io_schedule+0x12/0x40
> > [��615.890850]��__lock_page+0x105/0x150
> > [��615.910378]��? page_cache_tree_insert+0xd0/0xd0
> > [��615.935932]��truncate_inode_pages_range+0x49d/0x810
> > [��615.963371]��__blkdev_put+0x73/0x200
> > [��615.983351]��blkdev_close+0x21/0x30
> > [��616.002910]��__fput+0xd5/0x210
> > [��616.019812]��task_work_run+0x82/0xa0
> > [��616.040506]��do_exit+0x2ce/0xb30
> > [��616.058622]��do_group_exit+0x39/0xa0
> > [��616.079506]��get_signal+0x1d0/0x5b0
> > [��616.100116]��do_signal+0x36/0x610
> > [��616.118889]��? page_cache_tree_insert+0xd0/0xd0
> > [��616.144958]��exit_to_usermode_loop+0x47/0x93
> > [��616.169040]��do_syscall_64+0x172/0x1a0
> > [��616.190514]��entry_SYSCALL64_slow_path+0x25/0x25
> > [��616.216566] RIP: 0033:0x7fb247dd86f0
> > [��616.237395] RSP: 002b:00007ffea3c56cb8 EFLAGS: 00000246 ORIG_RAX:
> > 0000000000000000
> > [��616.279551] RAX: fffffffffffffffc RBX: 0000000000200000 RCX:
> > 00007fb247dd86f0
> > [��616.318057] RDX: 0000000000000400 RSI: 000055855eeefea8 RDI:
> > 0000000000000008
> > [��616.357320] RBP: 000055855eeefe80 R08: 0000000005231994 R09:
> > 0000000000000428
> > [��616.397099] R10: 0000000000000040 R11: 0000000000000246 R12:
> > 000055855eeea550
> > [��616.436999] R13: 0000000000000400 R14: 000055855eeea5a0 R15:
> > 000055855eeefe98
> > [��616.477831] INFO: task systemd-udevd:2248 blocked for more than 120
> > seconds.
> > [��616.518289]�������Tainted: G����������I������4.15.0-rc4+ #1
> > [��616.549323] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> 
> I can trigger this hang too, looks it happens after starting multipathd,
> and 'lsblk' also complains:
> 
> 	lsblk: dm-0: failed to get device path
> 	lsblk: dm-0: failed to get device path

This one is caused by 7c3fb70f0341 ("block: rearrange a few request fields
for better cache layout"), and fix has been sent out in the link:

	https://marc.info/?l=linux-block&m=151586577400558&w=2

Not sure if it is same with Bart's report, but it is worth a test.

-- 
Ming
