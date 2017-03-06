Return-Path: <markus@trippelsdorf.de>
Date: Mon, 6 Mar 2017 08:43:21 +0100
From: Markus Trippelsdorf <markus@trippelsdorf.de>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Fabio Checconi <fchecconi@gmail.com>,
	Arianna Avanzini <avanzini.arianna@gmail.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org, linus.walleij@linaro.org,
	broonie@kernel.org
Subject: Re: [PATCH RFC 00/14] Add the BFQ I/O Scheduler to blk-mq
Message-ID: <20170306074321.GA290@x4>
References: <20170304160131.57366-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170304160131.57366-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

On 2017.03.04 at 17:01 +0100, Paolo Valente wrote:
> Hi,
> at last, here is my first patch series meant for merging. It adds BFQ
> to blk-mq. Don't worry, in this message I won't bore you again with
> the wonderful properties of BFQ :)

I gave BFQ a quick try. Unfortunately it hangs when I try to delete
btrfs snapshots:

root       124  0.0  0.0      0     0 ?        D    07:19   0:03 [btrfs-cleaner]  
root       125  0.0  0.0      0     0 ?        D    07:19   0:00 [btrfs-transacti]

[ 4372.880116] sysrq: SysRq : Show Blocked State
[ 4372.880125]   task                        PC stack   pid father
[ 4372.880148] btrfs-cleaner   D    0   124      2 0x00000000
[ 4372.880156] Call Trace:
[ 4372.880166]  ? __schedule+0x160/0x7c0
[ 4372.880174]  ? io_schedule+0x64/0xe0
[ 4372.880179]  ? wait_on_page_bit+0x7a/0x100
[ 4372.880183]  ? devm_memunmap+0x40/0x40
[ 4372.880189]  ? read_extent_buffer_pages+0x25c/0x2c0
[ 4372.880195]  ? run_one_async_done+0xc0/0xc0
[ 4372.880200]  ? btree_read_extent_buffer_pages+0x60/0x2e0
[ 4372.880206]  ? read_tree_block+0x2c/0x60
[ 4372.880211]  ? read_block_for_search.isra.38+0xec/0x3a0
[ 4372.880217]  ? btrfs_search_slot+0x214/0xbc0
[ 4372.880221]  ? lookup_inline_extent_backref+0xfb/0x8c0
[ 4372.880225]  ? __btrfs_free_extent.isra.74+0xe9/0xdc0
[ 4372.880231]  ? btrfs_merge_delayed_refs+0x57/0x6e0
[ 4372.880235]  ? __btrfs_run_delayed_refs+0x60d/0x1340
[ 4372.880239]  ? btrfs_run_delayed_refs+0x64/0x280
[ 4372.880243]  ? btrfs_should_end_transaction+0x3b/0xa0
[ 4372.880247]  ? btrfs_drop_snapshot+0x3b2/0x800
[ 4372.880251]  ? __schedule+0x168/0x7c0
[ 4372.880254]  ? btrfs_clean_one_deleted_snapshot+0xa4/0xe0
[ 4372.880259]  ? cleaner_kthread+0x13a/0x180
[ 4372.880264]  ? btree_invalidatepage+0xc0/0xc0
[ 4372.880268]  ? kthread+0x144/0x180
[ 4372.880272]  ? kthread_flush_work_fn+0x20/0x20
[ 4372.880277]  ? ret_from_fork+0x23/0x30
[ 4372.880280] btrfs-transacti D    0   125      2 0x00000000
[ 4372.880285] Call Trace:
[ 4372.880290]  ? __schedule+0x160/0x7c0
[ 4372.880295]  ? io_schedule+0x64/0xe0
[ 4372.880300]  ? wait_on_page_bit_common.constprop.57+0x160/0x180
[ 4372.880303]  ? devm_memunmap+0x40/0x40
[ 4372.880307]  ? __filemap_fdatawait_range+0xd3/0x140
[ 4372.880311]  ? clear_state_bit.constprop.82+0xf7/0x180
[ 4372.880315]  ? __clear_extent_bit.constprop.79+0x138/0x3c0
[ 4372.880319]  ? filemap_fdatawait_range+0x9/0x60
[ 4372.880323]  ? __btrfs_wait_marked_extents.isra.18+0xc1/0x100
[ 4372.880327]  ? btrfs_write_and_wait_marked_extents.constprop.23+0x49/0x80
[ 4372.880331]  ? btrfs_commit_transaction+0x8e1/0xb00
[ 4372.880334]  ? join_transaction.constprop.24+0x10/0xa0
[ 4372.880340]  ? wake_bit_function+0x60/0x60
[ 4372.880345]  ? transaction_kthread+0x185/0x1a0
[ 4372.880350]  ? btrfs_cleanup_transaction+0x500/0x500
[ 4372.880354]  ? kthread+0x144/0x180
[ 4372.880358]  ? kthread_flush_work_fn+0x20/0x20
[ 4372.880362]  ? ret_from_fork+0x23/0x30
[ 4372.880367] ntpd            D    0   175      1 0x00000004
[ 4372.880372] Call Trace:
[ 4372.880375]  ? __schedule+0x160/0x7c0
[ 4372.880379]  ? schedule_preempt_disabled+0x2d/0x80
[ 4372.880383]  ? __mutex_lock.isra.5+0x17b/0x4c0
[ 4372.880386]  ? wait_current_trans+0x15/0xc0
[ 4372.880391]  ? btrfs_free_path+0xe/0x20
[ 4372.880395]  ? btrfs_pin_log_trans+0x14/0x40
[ 4372.880400]  ? btrfs_rename2+0x28e/0x19c0
[ 4372.880404]  ? path_init+0x187/0x3e0
[ 4372.880407]  ? unlazy_walk+0x4b/0x100
[ 4372.880410]  ? terminate_walk+0x8d/0x100
[ 4372.880414]  ? filename_parentat+0x1e9/0x2c0
[ 4372.880420]  ? __kmalloc_track_caller+0xc4/0x100
[ 4372.880424]  ? vfs_rename+0x33f/0x7e0
[ 4372.880428]  ? SYSC_renameat2+0x53c/0x680
[ 4372.880433]  ? entry_SYSCALL_64_fastpath+0x13/0x94
[ 4372.880437] fcron           D    0   178      1 0x00000000
[ 4372.880441] Call Trace:
[ 4372.880445]  ? __schedule+0x160/0x7c0
[ 4372.880448]  ? schedule_preempt_disabled+0x2d/0x80
[ 4372.880452]  ? __mutex_lock.isra.5+0x17b/0x4c0
[ 4372.880458]  ? pagevec_lookup_tag+0x18/0x20
[ 4372.880462]  ? btrfs_log_dentry_safe+0x4cd/0xac0
[ 4372.880466]  ? btrfs_start_transaction+0x249/0x460
[ 4372.880470]  ? btrfs_sync_file+0x288/0x3c0
[ 4372.880475]  ? btrfs_file_write_iter+0x3a9/0x4e0
[ 4372.880479]  ? vfs_write+0x26c/0x2c0
[ 4372.880483]  ? SyS_write+0x3d/0xa0
[ 4372.880486]  ? SyS_fchown+0x7b/0xa0
[ 4372.880491]  ? entry_SYSCALL_64_fastpath+0x13/0x94
[ 4372.880508] kworker/u8:8    D    0   759      2 0x00000000
[ 4372.880518] Workqueue: btrfs-submit btrfs_submit_helper
[ 4372.880520] Call Trace:
[ 4372.880524]  ? __schedule+0x160/0x7c0
[ 4372.880529]  ? io_schedule+0x64/0xe0
[ 4372.880534]  ? blk_mq_get_tag+0x212/0x320
[ 4372.880538]  ? wake_bit_function+0x60/0x60
[ 4372.880544]  ? __blk_mq_alloc_request+0x11/0x1c0
[ 4372.880548]  ? blk_mq_sched_get_request+0x17e/0x220
[ 4372.880553]  ? blk_sq_make_request+0xd3/0x4c0
[ 4372.880557]  ? blk_mq_sched_dispatch_requests+0x104/0x160
[ 4372.880561]  ? generic_make_request+0xc3/0x2e0
[ 4372.880564]  ? submit_bio+0x58/0x100
[ 4372.880569]  ? run_scheduled_bios+0x1a6/0x500
[ 4372.880574]  ? btrfs_worker_helper+0x129/0x1c0
[ 4372.880580]  ? process_one_work+0x1bc/0x400
[ 4372.880585]  ? worker_thread+0x42/0x540
[ 4372.880588]  ? __schedule+0x168/0x7c0
[ 4372.880592]  ? process_one_work+0x400/0x400
[ 4372.880596]  ? kthread+0x144/0x180
[ 4372.880600]  ? kthread_flush_work_fn+0x20/0x20
[ 4372.880605]  ? ret_from_fork+0x23/0x30

I could get it going again by running:
 echo "mq-deadline" > /sys/block/sdb/queue/scheduler

--
Markus
