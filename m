Return-Path: <geoff@infradead.org>
Subject: Re: [PATCH 03/17] ps3disk: convert to blk-mq
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20181011165909.32615-1-axboe@kernel.dk>
 <20181011165909.32615-4-axboe@kernel.dk>
 <17539e5f-742b-796e-8e36-31327120f883@infradead.org>
 <ee11f577-5766-13bc-2ff5-e3d672041462@kernel.dk>
 <7f27a68f-9cbe-c4c2-5c35-70763a5b1484@infradead.org>
 <b95e3ebf-f08d-2cbf-3f82-89424d7bf60d@kernel.dk>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <3403ae47-1aaa-9d01-817c-cd52a7daa272@infradead.org>
Date: Mon, 15 Oct 2018 11:23:18 -0700
MIME-Version: 1.0
In-Reply-To: <b95e3ebf-f08d-2cbf-3f82-89424d7bf60d@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

On 10/15/2018 09:27 AM, Jens Axboe wrote:> Can you try and change the queue depth to 1 instead of 2? It's set in> the tag_set, as ->queue_depth.

With this change:

-       set->queue_depth = 2;
+       set->queue_depth = 1;

Something is still wrong.  It can sometimes boot, sometimes udevd hangs
up on /sbin/blkid.  If it boots I can sometimes mount a ps3disk
partition, but then cat or echo to a file will hang.  Other times the
mount command will hang. I saw this error appear in the system log:

Oct 15 10:51:47 ps3 kernel: jbd2/ps3da2-8   D    0  2463      2 0x00000800
Oct 15 10:51:47 ps3 kernel: Call Trace:
Oct 15 10:51:47 ps3 kernel: [c00000000d3c36b0] [c00000000d3c3750] 0xc00000000d3c3750 (unreliable)
Oct 15 10:51:47 ps3 kernel: [c00000000d3c3880] [c0000000000152d0] .__switch_to+0x290/0x300
Oct 15 10:51:47 ps3 kernel: [c00000000d3c3930] [c000000000571d3c] .__schedule+0x904/0x958
Oct 15 10:51:47 ps3 kernel: [c00000000d3c3a10] [c000000000571e0c] .schedule+0x7c/0x90
Oct 15 10:51:47 ps3 kernel: [c00000000d3c3a90] [c0000000002553c4] .jbd2_journal_commit_transaction+0xb84/0x1f68
Oct 15 10:51:47 ps3 kernel: [c00000000d3c3ca0] [c00000000025ad94] .kjournald2+0xc8/0x230
Oct 15 10:51:47 ps3 kernel: [c00000000d3c3d70] [c0000000000713c4] .kthread+0x14c/0x154
Oct 15 10:51:47 ps3 kernel: [c00000000d3c3e30] [c00000000000a83c] .ret_from_kernel_thread+0x58/0x7c
Oct 15 10:51:47 ps3 kernel: ext4lazyinit    D    0  2465      2 0x00000800
Oct 15 10:51:47 ps3 kernel: Call Trace:
Oct 15 10:51:47 ps3 kernel: [c00000000a12f130] [c00000000a12f1b0] 0xc00000000a12f1b0 (unreliable)
Oct 15 10:51:47 ps3 kernel: [c00000000a12f300] [c0000000000152d0] .__switch_to+0x290/0x300
Oct 15 10:51:47 ps3 kernel: [c00000000a12f3b0] [c000000000571d3c] .__schedule+0x904/0x958
Oct 15 10:51:47 ps3 kernel: [c00000000a12f490] [c000000000571e0c] .schedule+0x7c/0x90
Oct 15 10:51:47 ps3 kernel: [c00000000a12f510] [c00000000007e1b0] .io_schedule+0x1c/0x34
Oct 15 10:51:47 ps3 kernel: [c00000000a12f590] [c0000000002fbc60] .blk_mq_get_tag+0x180/0x2a0
Oct 15 10:51:47 ps3 kernel: [c00000000a12f660] [c0000000002f59c0] .blk_mq_get_request+0x230/0x4c4
Oct 15 10:51:47 ps3 kernel: [c00000000a12f700] [c0000000002f88b8] .blk_mq_make_request+0x1c0/0x6ec
Oct 15 10:51:47 ps3 kernel: [c00000000a12f7f0] [c0000000002e9b10] .generic_make_request+0x3a0/0x450
Oct 15 10:51:47 ps3 kernel: [c00000000a12f8b0] [c0000000002e9c08] .submit_bio+0x48/0x148
Oct 15 10:51:47 ps3 kernel: [c00000000a12f970] [c0000000002f49e0] .next_bio+0x50/0x60
Oct 15 10:51:47 ps3 kernel: [c00000000a12f9f0] [c0000000002f5074] .__blkdev_issue_zero_pages+0xa4/0x168
Oct 15 10:51:47 ps3 kernel: [c00000000a12fac0] [c0000000002f5360] .blkdev_issue_zeroout+0x168/0x16c
Oct 15 10:51:47 ps3 kernel: [c00000000a12fbb0] [c00000000020edb8] .ext4_init_inode_table+0x230/0x34c
Oct 15 10:51:47 ps3 kernel: [c00000000a12fc90] [c000000000242c30] .ext4_lazyinit_thread+0x21c/0x2f8
Oct 15 10:51:47 ps3 kernel: [c00000000a12fd70] [c0000000000713c4] .kthread+0x14c/0x154
Oct 15 10:51:47 ps3 kernel: [c00000000a12fe30] [c00000000000a83c] .ret_from_kernel_thread+0x58/0x7c
Oct 15 10:51:47 ps3 kernel: kworker/u4:11   D    0  2478      2 0x00000800
Oct 15 10:51:47 ps3 kernel: Workqueue: writeback .wb_workfn (flush-254:0)
Oct 15 10:51:47 ps3 kernel: Call Trace:
Oct 15 10:51:47 ps3 kernel: [c00000000d5928f0] [c00000000d592990] 0xc00000000d592990 (unreliable)
Oct 15 10:51:47 ps3 kernel: [c00000000d592ac0] [c0000000000152d0] .__switch_to+0x290/0x300
Oct 15 10:51:47 ps3 kernel: [c00000000d592b70] [c000000000571d3c] .__schedule+0x904/0x958
Oct 15 10:51:47 ps3 kernel: [c00000000d592c50] [c000000000571e0c] .schedule+0x7c/0x90
Oct 15 10:51:47 ps3 kernel: [c00000000d592cd0] [c00000000007e1b0] .io_schedule+0x1c/0x34
Oct 15 10:51:47 ps3 kernel: [c00000000d592d50] [c0000000002fbc60] .blk_mq_get_tag+0x180/0x2a0
Oct 15 10:51:47 ps3 kernel: [c00000000d592e20] [c0000000002f59c0] .blk_mq_get_request+0x230/0x4c4
Oct 15 10:51:47 ps3 kernel: [c00000000d592ec0] [c0000000002f88b8] .blk_mq_make_request+0x1c0/0x6ec
Oct 15 10:51:47 ps3 kernel: [c00000000d592fb0] [c0000000002e9b10] .generic_make_request+0x3a0/0x450
Oct 15 10:51:47 ps3 kernel: [c00000000d593070] [c0000000002e9c08] .submit_bio+0x48/0x148
Oct 15 10:51:47 ps3 kernel: [c00000000d593130] [c0000000001aa2f8] .submit_bh_wbc.isra.9+0x198/0x1a8
Oct 15 10:51:47 ps3 kernel: [c00000000d5931d0] [c0000000001aa594] .__block_write_full_page+0x28c/0x430
Oct 15 10:51:47 ps3 kernel: [c00000000d5932c0] [c0000000001adc1c] .blkdev_writepage+0x1c/0x30
Oct 15 10:51:47 ps3 kernel: [c00000000d593330] [c000000000118fbc] .__writepage+0x34/0x80
Oct 15 10:51:47 ps3 kernel: [c00000000d5933b0] [c000000000118920] .write_cache_pages+0x39c/0x47c
Oct 15 10:51:47 ps3 kernel: [c00000000d593550] [c000000000118a54] .generic_writepages+0x54/0x70
Oct 15 10:51:47 ps3 kernel: [c00000000d593600] [c0000000001adbbc] .blkdev_writepages+0x10/0x24
Oct 15 10:51:47 ps3 kernel: [c00000000d593670] [c00000000011ab80] .do_writepages+0x54/0xa0
Oct 15 10:51:47 ps3 kernel: [c00000000d5936f0] [c00000000019d84c] .__writeback_single_inode+0x104/0x698
Oct 15 10:51:47 ps3 kernel: [c00000000d5937b0] [c00000000019e0b8] .writeback_sb_inodes+0x2d8/0x480
Oct 15 10:51:47 ps3 kernel: [c00000000d5938e0] [c00000000019e2d4] .__writeback_inodes_wb+0x74/0xb0
Oct 15 10:51:47 ps3 kernel: [c00000000d593990] [c00000000019e7b8] .wb_writeback+0x3f8/0x464
Oct 15 10:51:47 ps3 kernel: [c00000000d593ab0] [c00000000019f388] .wb_workfn+0x43c/0x5ac
Oct 15 10:51:47 ps3 kernel: [c00000000d593be0] [c00000000006aae0] .process_one_work+0x30c/0x588
Oct 15 10:51:47 ps3 kernel: [c00000000d593cb0] [c00000000006b2b4] .worker_thread+0x294/0x33c
Oct 15 10:51:47 ps3 kernel: [c00000000d593d70] [c0000000000713c4] .kthread+0x14c/0x154
Oct 15 10:51:47 ps3 kernel: [c00000000d593e30] [c00000000000a83c] .ret_from_kernel_thread+0x58/0x7c
Oct 15 10:51:47 ps3 kernel: cat             D    0  2481      1 0x00000012
Oct 15 10:51:47 ps3 kernel: Call Trace:
Oct 15 10:51:47 ps3 kernel: [c00000000b6a3130] [c00000000b6a31d0] 0xc00000000b6a31d0 (unreliable)
Oct 15 10:51:47 ps3 kernel: [c00000000b6a3300] [c0000000000152d0] .__switch_to+0x290/0x300
Oct 15 10:51:47 ps3 kernel: [c00000000b6a33b0] [c000000000571d3c] .__schedule+0x904/0x958
Oct 15 10:51:47 ps3 kernel: [c00000000b6a3490] [c000000000571e0c] .schedule+0x7c/0x90
Oct 15 10:51:47 ps3 kernel: [c00000000b6a3510] [c000000000250dac] .wait_transaction_locked+0xd8/0xf4
Oct 15 10:51:47 ps3 kernel: [c00000000b6a35d0] [c000000000250e3c] .add_transaction_credits+0x2c/0x370
Oct 15 10:51:47 ps3 kernel: [c00000000b6a36a0] [c0000000002519a0] .start_this_handle+0x2f0/0x3bc
Oct 15 10:51:47 ps3 kernel: [c00000000b6a37d0] [c000000000251b5c] .jbd2__journal_start+0xf0/0x27c
Oct 15 10:51:47 ps3 kernel: [c00000000b6a3890] [c0000000001fd828] .__ext4_journal_start_sb+0x1b4/0x1ec
Oct 15 10:51:47 ps3 kernel: [c00000000b6a3950] [c000000000209b90] .ext4_file_open+0xc8/0x1c8
Oct 15 10:51:47 ps3 kernel: [c00000000b6a3a50] [c000000000167b18] .do_dentry_open+0x2a0/0x380
Oct 15 10:51:47 ps3 kernel: [c00000000b6a3af0] [c00000000017c7b0] .path_openat+0x4a4/0x904
Oct 15 10:51:47 ps3 kernel: [c00000000b6a3bf0] [c00000000017cc50] .do_filp_open+0x40/0x88
Oct 15 10:51:47 ps3 kernel: [c00000000b6a3d60] [c000000000169074] .do_sys_open+0x13c/0x228
Oct 15 10:51:47 ps3 kernel: [c00000000b6a3e30] [c00000000000a4a4] system_call+0x5c/0x70
Oct 15 10:51:47 ps3 kernel: 
Oct 15 10:51:47 ps3 kernel: Showing all locks held in the system:
Oct 15 10:51:47 ps3 kernel: 1 lock held by khungtaskd/148:
Oct 15 10:51:47 ps3 kernel: #0: 000000003bcb2a3a (rcu_read_lock){....}, at: .debug_show_all_locks+0x38/0x1ac
Oct 15 10:51:47 ps3 kernel: 2 locks held by ps3fb/301:
Oct 15 10:51:47 ps3 kernel: 1 lock held by in:imklog/1779:
Oct 15 10:51:47 ps3 kernel: #0: 00000000713da15f (&f->f_pos_lock){+.+.}, at: .__fdget_pos+0x48/0x58
Oct 15 10:51:47 ps3 kernel: 2 locks held by getty/2404:
Oct 15 10:51:47 ps3 kernel: #0: 00000000ced8d07b (&tty->ldisc_sem){++++}, at: .tty_ldisc_ref_wait+0x2c/0x54
Oct 15 10:51:47 ps3 kernel: #1: 00000000fd462e7d (&ldata->atomic_read_lock){+.+.}, at: .n_tty_read+0x1bc/0x724
Oct 15 10:51:47 ps3 kernel: 2 locks held by getty/2405:
Oct 15 10:51:47 ps3 kernel: #0: 000000009e9dff48 (&tty->ldisc_sem){++++}, at: .tty_ldisc_ref_wait+0x2c/0x54
Oct 15 10:51:47 ps3 kernel: #1: 0000000098475abc (&ldata->atomic_read_lock){+.+.}, at: .n_tty_read+0x1bc/0x724
Oct 15 10:51:47 ps3 kernel: 2 locks held by getty/2406:
Oct 15 10:51:47 ps3 kernel: #0: 00000000f060a6f0 (&tty->ldisc_sem){++++}, at: .tty_ldisc_ref_wait+0x2c/0x54
Oct 15 10:51:47 ps3 kernel: #1: 00000000efce01c3 (&ldata->atomic_read_lock){+.+.}, at: .n_tty_read+0x1bc/0x724
Oct 15 10:51:47 ps3 kernel: 2 locks held by getty/2407:
Oct 15 10:51:47 ps3 kernel: #0: 00000000935f3792 (&tty->ldisc_sem){++++}, at: .tty_ldisc_ref_wait+0x2c/0x54
Oct 15 10:51:47 ps3 kernel: #1: 00000000efa3bee7 (&ldata->atomic_read_lock){+.+.}, at: .n_tty_read+0x1bc/0x724
Oct 15 10:51:47 ps3 kernel: 2 locks held by getty/2408:
Oct 15 10:51:47 ps3 kernel: #0: 00000000111a56ee (&tty->ldisc_sem){++++}, at: .tty_ldisc_ref_wait+0x2c/0x54
Oct 15 10:51:47 ps3 kernel: #1: 00000000f219e2ab (&ldata->atomic_read_lock){+.+.}, at: .n_tty_read+0x1bc/0x724
Oct 15 10:51:47 ps3 kernel: 2 locks held by getty/2409:
Oct 15 10:51:47 ps3 kernel: #0: 0000000045df3048 (&tty->ldisc_sem){++++}, at: .tty_ldisc_ref_wait+0x2c/0x54
Oct 15 10:51:47 ps3 kernel: #1: 00000000deede503 (&ldata->atomic_read_lock){+.+.}, at: .n_tty_read+0x1bc/0x724
Oct 15 10:51:47 ps3 kernel: 4 locks held by ext4lazyinit/2465:
Oct 15 10:51:47 ps3 kernel: #0: 000000001603d342 (&type->s_umount_key#26){.+.+}, at: .ext4_lazyinit_thread+0x12c/0x2f8
Oct 15 10:51:47 ps3 kernel: #1: 00000000c857701f (sb_writers#10){.+.+}, at: .ext4_lazyinit_thread+0x14c/0x2f8
Oct 15 10:51:47 ps3 kernel: #2: 000000004c766729 (jbd2_handle){++++}, at: .start_this_handle+0x2f8/0x3bc
Oct 15 10:51:47 ps3 kernel: #3: 000000001c56823b (&meta_group_info[i]->alloc_sem){+.+.}, at: .ext4_init_inode_table+0xcc/0x34c
Oct 15 10:51:47 ps3 kernel: 3 locks held by kworker/u4:11/2478:
Oct 15 10:51:47 ps3 kernel: #0: 0000000030f3b24b ((wq_completion)"writeback"){+.+.}, at: .process_one_work+0x1bc/0x588
Oct 15 10:51:47 ps3 kernel: #1: 00000000a1fc5fc0 ((work_completion)(&(&wb->dwork)->work)){+.+.}, at: .process_one_work+0x1bc/0x588
Oct 15 10:51:47 ps3 kernel: #2: 000000007f2fe323 (&type->s_umount_key#27){.+.+}, at: .trylock_super+0x24/0x70
Oct 15 10:51:47 ps3 kernel: 1 lock held by cat/2481:
Oct 15 10:51:47 ps3 kernel: #0: 00000000aa6085f9 (sb_internal){.+.+}, at: .ext4_file_open+0x54/0x1c8
Oct 15 10:51:47 ps3 kernel: 2 locks held by bash/2490:
Oct 15 10:51:47 ps3 kernel: #0: 0000000077655c1f (&tty->ldisc_sem){++++}, at: .tty_ldisc_ref_wait+0x2c/0x54
Oct 15 10:51:47 ps3 kernel: #1: 000000006f4f8843 (&ldata->atomic_read_lock){+.+.}, at: .n_tty_read+0x1bc/0x724
Oct 15 10:51:47 ps3 kernel: 2 locks held by touch/2518:
Oct 15 10:51:47 ps3 kernel: #0: 00000000c857701f (sb_writers#10){.+.+}, at: .mnt_want_write+0x28/0x58
Oct 15 10:51:47 ps3 kernel: #1: 00000000957b6825 (&type->i_mutex_dir_key#4){++++}, at: .path_openat+0x308/0x904
Oct 15 10:51:47 ps3 kernel: 
Oct 15 10:51:47 ps3 kernel: =============================================
