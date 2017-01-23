Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37551 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750742AbdAWQH4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2017 11:07:56 -0500
Received: by mail-wm0-f53.google.com with SMTP id c206so163130017wme.0
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2017 08:07:55 -0800 (PST)
To: LKML <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>
Subject: BUG: KASAN: Use-after-free
Message-ID: <0b458b92-62ee-bffc-8f3e-fbd6490b26fd@bjorling.me>
Date: Mon, 23 Jan 2017 17:07:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

I could use some help verifying an use-after-free bug that I am seeing
after the new direct I/O work went in.

When issuing a direct write io using libaio, a bio is referenced in the
blkdev_direct_IO path, and then put again in the blkdev_bio_end_io path.
However, there is a case where the bio is put twice, which leads to
modules that rely on the bio after biodev_bio_end_io() to access it
prematurely.

The KASAN error report:

[   14.645916]
==================================================================
[   14.648027] BUG: KASAN: use-after-free in
blkdev_direct_IO+0x50c/0x600 at addr ffff8801ef30ea14
[   14.648558] Read of size 1 by task fio/375
[   14.648779] CPU: 0 PID: 375 Comm: fio Not tainted 4.10.0-rc5 #4845
[   14.649107] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.7.5-0-ge51488c-20140602_164612-nilsson.home.kraxel.org 04/01/2014
[   14.649792] Call Trace:
[   14.649930]  dump_stack+0x63/0x8b
[   14.650112]  kasan_object_err+0x21/0x80
[   14.650323]  kasan_report_error+0x1fa/0x520
[   14.650551]  kasan_report+0x58/0x60
[   14.650741]  ? blkdev_direct_IO+0x50c/0x600
[   14.650969]  __asan_load1+0x47/0x50
[   14.651159]  blkdev_direct_IO+0x50c/0x600
[   14.651377]  ? filemap_check_errors+0x38/0x70
[   14.651613]  generic_file_direct_write+0x11b/0x220
[   14.651871]  __generic_file_write_iter+0x12b/0x2d0
[   14.652129]  blkdev_write_iter+0xd8/0x180
[   14.652348]  ? security_file_permission+0x81/0x100
[   14.652607]  aio_write+0x15f/0x1c0
[   14.652795]  ? kasan_unpoison_shadow+0x14/0x40
[   14.653036]  ? kasan_kmalloc+0x93/0xc0
[   14.653239]  ? __fget+0xae/0x110
[   14.653417]  do_io_submit+0x672/0x830
[   14.653617]  SyS_io_submit+0x10/0x20
[   14.653813]  entry_SYSCALL_64_fastpath+0x1e/0xad
[   14.654061] RIP: 0033:0x7f40d6d14667
[   14.654255] RSP: 002b:00007fff5a8cc858 EFLAGS: 00000202 ORIG_RAX:
00000000000000d1
[   14.654661] RAX: ffffffffffffffda RBX: 00000000000000df RCX:
00007f40d6d14667
[   14.655041] RDX: 00000000017a7f00 RSI: 0000000000000002 RDI:
00007f40d71a6000
[   14.655421] RBP: 00007f40cffea000 R08: fffffffffd33e1f0 R09:
00000000000001f0
[   14.655801] R10: 000000000446e000 R11: 0000000000000202 R12:
0000000000000001
[   14.656180] R13: 0000000000000001 R14: 00007f40cffea008 R15:
0000000000000001
[   14.656556] Object at ffff8801ef30ea00, in cache bio-1 size: 224
[   14.656871] Allocated:
[   14.657075] PID = 375
[   14.657202]
[   14.657205] [<ffffffff8d0e52db>] save_stack_trace+0x1b/0x20
[   14.657591]
[   14.657593] [<ffffffff8d39dc96>] save_stack+0x46/0xd0
[   14.657953]
[   14.657955] [<ffffffff8d39e4d3>] kasan_kmalloc+0x93/0xc0
[   14.658350]
[   14.658353] [<ffffffff8d39ea42>] kasan_slab_alloc+0x12/0x20
[   14.658739]
[   14.658741] [<ffffffff8d39a139>] kmem_cache_alloc+0xb9/0x1c0
[   14.659134]
[   14.659137] [<ffffffff8d30ddc5>] mempool_alloc_slab+0x15/0x20
[   14.659536]
[   14.659538] [<ffffffff8d30df56>] mempool_alloc+0x96/0x1a0
[   14.659918]
[   14.659921] [<ffffffff8d911af9>] bio_alloc_bioset+0xf9/0x330
[   14.660315]
[   14.660317] [<ffffffff8d4283d7>] blkdev_direct_IO+0x187/0x600
[   14.660716]
[   14.660719] [<ffffffff8d30b63b>] generic_file_direct_write+0x11b/0x220
[   14.661152]
[   14.661154] [<ffffffff8d30b86b>] __generic_file_write_iter+0x12b/0x2d0
[   14.661588]
[   14.661590] [<ffffffff8d4295e8>] blkdev_write_iter+0xd8/0x180
[   14.661985]
[   14.661987] [<ffffffff8d4461ff>] aio_write+0x15f/0x1c0
[   14.662355]
[   14.662357] [<ffffffff8d446b82>] do_io_submit+0x672/0x830
[   14.662736]
[   14.662738] [<ffffffff8d448140>] SyS_io_submit+0x10/0x20
[   14.663113]
[   14.663115] [<ffffffff8e17a27b>] entry_SYSCALL_64_fastpath+0x1e/0xad
[   14.663545] Freed:
[   14.663658] PID = 375
[   14.663784]
[   14.663786] [<ffffffff8d0e52db>] save_stack_trace+0x1b/0x20
[   14.664175]
[   14.664177] [<ffffffff8d39dc96>] save_stack+0x46/0xd0
[   14.664539]
[   14.664542] [<ffffffff8d39eacd>] kasan_slab_free+0x7d/0xc0
[   14.664925]
[   14.664927] [<ffffffff8d39b3f3>] kmem_cache_free+0x73/0x200
[   14.665317]
[   14.665319] [<ffffffff8d30dde7>] mempool_free_slab+0x17/0x20
[   14.665713]
[   14.665715] [<ffffffff8d30e24f>] mempool_free+0x5f/0xd0
[   14.666092]
[   14.666094] [<ffffffff8d912024>] bio_free+0x94/0xb0
[   14.666446]
[   14.666449] [<ffffffff8d91207d>] bio_put+0x3d/0x50
[   14.666793]
[   14.666796] [<ffffffff8dbd0a15>] rrpc_end_io+0x235/0x430
[   14.667168]
[   14.667170] [<ffffffff8dbcdfac>] gen_end_io+0x5c/0x70
[   14.667529]
[   14.667531] [<ffffffff8dbc90ae>] nvm_end_io+0x2e/0x40
[   14.667890]
[   14.667893] [<ffffffff8dca237f>] nvme_nvm_end_io+0x5f/0x90
[   14.668277]
[   14.668279] [<ffffffff8d930f35>] blk_mq_end_request+0x55/0x90
[   14.668675]
[   14.668678] [<ffffffff8dca590c>] nvme_complete_rq+0x12c/0x3d0
[   14.669073]
[   14.669075] [<ffffffff8d9310cf>] __blk_mq_complete_request+0x15f/0x240
[   14.669512]
[   14.669514] [<ffffffff8d9311e5>] blk_mq_complete_request+0x35/0x40
[   14.669932]
[   14.669934] [<ffffffff8dca407b>] __nvme_process_cq+0x12b/0x330
[   14.670336]
[   14.670338] [<ffffffff8dca8a4c>] nvme_queue_rq+0x31c/0xe70
[   14.670720]
[   14.670722] [<ffffffff8d932f01>] blk_mq_dispatch_rq_list+0x191/0x360
[   14.671149]
[   14.671151] [<ffffffff8d9333e2>] blk_mq_process_rq_list+0x312/0x350
[   14.671570]
[   14.671572] [<ffffffff8d9334c3>] __blk_mq_run_hw_queue+0xa3/0xb0
[   14.671976]
[   14.671978] [<ffffffff8d932d67>] blk_mq_run_hw_queue+0xd7/0xe0
[   14.672373]
[   14.672375] [<ffffffff8d935099>] blk_mq_insert_request+0xd9/0xf0
[   14.672780]
[   14.672782] [<ffffffff8d928eee>] blk_execute_rq_nowait+0xae/0x1c0
[   14.673190]
[   14.673192] [<ffffffff8dca39af>] nvme_nvm_submit_io+0x28f/0x310
[   14.673648]
[   14.673650] [<ffffffff8dbce3fa>] gen_submit_io+0x9a/0xb0
[   14.674024]
[   14.674026] [<ffffffff8dbc8e5b>] nvm_submit_io+0x4b/0x60
[   14.674406]
[   14.674408] [<ffffffff8dbd2fd1>] rrpc_submit_io+0x361/0xad0
[   14.674793]
[   14.674795] [<ffffffff8dbd3e7a>] rrpc_make_rq+0xda/0x360
[   14.675166]
[   14.675168] [<ffffffff8d91f173>] generic_make_request+0x183/0x310
[   14.675578]
[   14.675580] [<ffffffff8d91f39f>] submit_bio+0x9f/0x200
[   14.675940]
[   14.675942] [<ffffffff8d42882a>] blkdev_direct_IO+0x5da/0x600
[   14.676331]
[   14.676334] [<ffffffff8d30b63b>] generic_file_direct_write+0x11b/0x220
[   14.676764]
[   14.676767] [<ffffffff8d30b86b>] __generic_file_write_iter+0x12b/0x2d0
[   14.677199]
[   14.677201] [<ffffffff8d4295e8>] blkdev_write_iter+0xd8/0x180
[   14.677593]
[   14.677595] [<ffffffff8d4461ff>] aio_write+0x15f/0x1c0
[   14.677957]
[   14.677959] [<ffffffff8d446b82>] do_io_submit+0x672/0x830
[   14.678349]
[   14.678352] [<ffffffff8d448140>] SyS_io_submit+0x10/0x20
[   14.678724]
[   14.678726] [<ffffffff8e17a27b>] entry_SYSCALL_64_fastpath+0x1e/0xad
[   14.679151] Memory state around the buggy address:
[   14.679408]  ffff8801ef30e900: fb fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb
[   14.679791]  ffff8801ef30e980: fb fb fb fb fc fc fc fc fc fc fc fc fc
fc fc fc
[   14.680173] >ffff8801ef30ea00: fb fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb
[   14.680555]                          ^
[   14.680758]  ffff8801ef30ea80: fb fb fb fb fb fb fb fb fb fb fb fb fc
fc fc fc
[   14.681140]  ffff8801ef30eb00: fc fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc
[   14.681522]
==================================================================
[   14.681912] Disabling lock debugging due to kernel taint
--------
Which boils down to the bio already being freed, when we hit the
module's endio function.

The double bio_put() occurs when dio->should_dirty = 0, and dio->is_sync
= 0. The flow follows:

Issuing:
  blkdev_direct_IO
     get_bio(bio)
     submit_io()
       rrpc make_request(bio)
         get_bio(bio)
Completion:
  blkdev_bio_end_io
    bio_put(bio)
    bio_put(bio) - bio is freed
  rrpc_end_io
    bio_put(bio) (use-after-free access)

To fix it, the first bio_put() was removed in the blkdev_bio_end_io
function:

static void blkdev_bio_end_io(struct bio *bio)
{
        struct blkdev_dio *dio = bio->bi_private;
        bool should_dirty = dio->should_dirty;

        if (dio->multi_bio && !atomic_dec_and_test(&dio->ref)) {
                if (bio->bi_error && !dio->bio.bi_error)
                        dio->bio.bi_error = bio->bi_error;
        } else {
                if (!dio->is_sync) {
                        struct kiocb *iocb = dio->iocb;
                        ssize_t ret = dio->bio.bi_error;

                        if (likely(!ret)) {
                                ret = dio->size;
                                iocb->ki_pos += ret;
                        }

                        dio->iocb->ki_complete(iocb, ret, 0);
First bio_put           bio_put(&dio->bio);
                } else {
                        struct task_struct *waiter = dio->waiter;

                        WRITE_ONCE(dio->waiter, NULL);
                        wake_up_process(waiter);
                }
	}
        if (should_dirty) {
                bio_check_pages_dirty(bio);
        } else {
                struct bio_vec *bvec;
                int i;

                bio_for_each_segment_all(bvec, bio, i)
                        put_page(bvec->bv_page);
Second bio_put          bio_put(bio);
        }
}

What I am unsure about is that if removing the bio_put() from the inner
if, then in some cases, where it should have been put, it isn't.
Removing the bio_put() only might not be the right fix.

-Matias
