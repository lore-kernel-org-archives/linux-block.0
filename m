Return-Path: <bo.li.liu@oracle.com>
Date: Fri, 14 Jul 2017 16:20:47 -0700
From: Liu Bo <bo.li.liu@oracle.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        linux-block <linux-block@vger.kernel.org>, fdmanana@suse.com
Subject: Re: [PATCH] block: note about cloned bios and
 bio_for_each_segment_all
Message-ID: <20170714232046.GD10708@lim.localdomain>
Reply-To: bo.li.liu@oracle.com
References: <20170714134051.22756-1-dsterba@suse.com>
 <CACVXFVP_a5kofmW-Wfx1FT_kyqFKdatf57RfKLrh+Jte1J8ZmA@mail.gmail.com>
 <06376146-e4c3-efd6-8893-155052b14034@kernel.dk>
 <20170714205429.GC10708@lim.localdomain>
 <CACVXFVM2mT5Eu45On2h-vDYb05jm+ci7M9Y6cokoNu289iddvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVM2mT5Eu45On2h-vDYb05jm+ci7M9Y6cokoNu289iddvw@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Sat, Jul 15, 2017 at 06:35:05AM +0800, Ming Lei wrote:
> On Sat, Jul 15, 2017 at 4:54 AM, Liu Bo <bo.li.liu@oracle.com> wrote:
> > On Fri, Jul 14, 2017 at 08:22:31AM -0600, Jens Axboe wrote:
> >> On 07/14/2017 07:47 AM, Ming Lei wrote:
> >> >> @@ -156,6 +156,9 @@ static inline void *bio_data(struct bio *bio)
> >> >>  /*
> >> >>   * drivers should _never_ use the all version - the bio may have been split
> >> >>   * before it got to the driver and the driver won't own all of it
> >> >> + *
> >> >> + * Note that cloned bios must not use this as their bi_vcnt may be invalid and
> >> >> + * this could lead to silent corruptions.
> >> >>   */
> >> >>  #define bio_for_each_segment_all(bvl, bio, i)                          \
> >> >>         for (i = 0, bvl = (bio)->bi_io_vec; i < (bio)->bi_vcnt; i++, bvl++)
> >> >> --
> >> >> 2.13.0
> >> >>
> >> >
> >> > Maybe we can add a warning here if it is a cloned bio.
> >>
> >> I think that's a good idea, it's easy for people to get this wrong, and
> >> the consequences can be dire. How about something like this?
> >>
> >> diff --git a/include/linux/bio.h b/include/linux/bio.h
> >> index 7b1cf4ba0902..13b6ac6eae29 100644
> >> --- a/include/linux/bio.h
> >> +++ b/include/linux/bio.h
> >> @@ -155,9 +155,12 @@ static inline void *bio_data(struct bio *bio)
> >>
> >>  /*
> >>   * drivers should _never_ use the all version - the bio may have been split
> >> - * before it got to the driver and the driver won't own all of it
> >> + * before it got to the driver and the driver won't own all of it.
> >> + *
> >> + * Don't use this on cloned bio's.
> >>   */
> >>  #define bio_for_each_segment_all(bvl, bio, i)                                \
> >> +     WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));                     \
> >>       for (i = 0, bvl = (bio)->bi_io_vec; i < (bio)->bi_vcnt; i++, bvl++)
> >>
> >>  static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
> >>
> >
> > This patch gave me a crash, I'm double checking it..
> 
> Hi Liu Bo,
> 
> Looks one extra warning shouldn't have trigger a crash, please double
> check and update
> with us.
> 
> I just start a VM and run a quick test on ext4, btrfs, looks
> everything is fine, and not see
> any warning.
> 
> -- 
> Ming Lei

I removed that WARN_ON() in btrfs's index_rbio_pages() which is simply
WARN_ON(bio_flagged(bio, BIO_CLONED));

And I still got the same crash.

The test I ran is

$ mkfs.btrfs -f -draid5 /dev/sd[cde]
$ mount /dev/sde /mnt/btrfs
$ xfs_io -f -d -c "pwrite 0 128K" /mnt/btrfs/foobar
# then kernel went to panic.

It's 4.12.0 vanilla + Jen's patch, but given that it's purely a
WARN_ON_ONCE(), I haven't figured out where the crash came from.

thanks,
-liubo

[   70.885850] BTRFS: device fsid b994b77f-a9a0-4fa2-8a66-5a36caa7c174 devid 1 transid 5 /dev/sdc
[   70.896194] BTRFS: device fsid b994b77f-a9a0-4fa2-8a66-5a36caa7c174 devid 2 transid 5 /dev/sdd
[   70.903853] BTRFS: device fsid b994b77f-a9a0-4fa2-8a66-5a36caa7c174 devid 3 transid 5 /dev/sde
[   72.991044] BTRFS info (device sde): disk space caching is enabled
[   72.991494] BTRFS info (device sde): has skinny extents
[   72.991836] BTRFS info (device sde): flagging fs with big metadata feature
[   73.015831] BTRFS info (device sde): creating UUID tree
[   82.798313] BUG: unable to handle kernel paging request at ffffffffa03bcc0e
[   82.799070] IP: report_bug+0xc4/0x180
[   82.799312] PGD 2626067 
[   82.799313] P4D 2626067 
[   82.799483] PUD 2627063 
[   82.799655] PMD 2346a3067 
[   82.799868] PTE 800000022019b161
[   82.800091] 
[   82.800471] Oops: 0003 [#1] SMP
[   82.800734] Dumping ftrace buffer:
[   82.800997]    (ftrace buffer empty)
[   82.801305] Modules linked in: btrfs(OE) xor raid6_pq ppdev parport_pc parport serio_raw nfsd auth_rpcgss nfs_acl lockd grace sunrpc
[   82.802312] CPU: 3 PID: 154 Comm: kworker/u16:5 Tainted: G           OE   4.12.0+ #802
[   82.802947] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-1.fc25 04/01/2014
[   82.803690] Workqueue: btrfs-rmw btrfs_rmw_helper [btrfs]
[   82.804176] task: ffff8802383bd200 task.stack: ffffc90000fa4000
[   82.804680] RIP: 0010:report_bug+0xc4/0x180
[   82.805082] RSP: 0018:ffffc90000fa7ac8 EFLAGS: 00010002
[   82.805454] RAX: 0000000000000001 RBX: ffffffffa0379ca5 RCX: 0000000000000001
[   82.805911] RDX: ffffffffa03bcc04 RSI: 000000000000047f RDI: 0000000000000000
[   82.806373] RBP: ffffc90000fa7ae8 R08: 0000000000000907 R09: 0000000000000000
[   82.806832] R10: 00000000e3e32d2f R11: 000000000526ce2c R12: ffffc90000fa7c38
[   82.807301] R13: ffffffffa03ad415 R14: 0000000000000004 R15: 0000000000000006
[   82.807758] FS:  0000000000000000(0000) GS:ffff88023ac00000(0000) knlGS:0000000000000000
[   82.808653] CR2: ffffffffa03bcc0e CR3: 00000002203f7000 CR4: 00000000000006e0
[   82.809129] Call Trace:
[   82.809297]  fixup_bug+0x43/0x60
[   82.809512]  do_trap+0x18a/0x1f0
[   82.809727]  do_error_trap+0xdf/0x1a0
[   82.810051]  ? index_rbio_pages+0xf5/0x100 [btrfs]
[   82.810366]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[   82.810672]  do_invalid_op+0x20/0x30
[   82.810907]  invalid_op+0x1e/0x30
[   82.811205] RIP: 0010:index_rbio_pages+0xf5/0x100 [btrfs]
[   82.811554] RSP: 0018:ffffc90000fa7ce8 EFLAGS: 00010002
[   82.811891] RAX: 0000000000000002 RBX: ffffffffa0444938 RCX: 0000000000000000
[   82.812349] RDX: 0000000000000003 RSI: 0000000000000001 RDI: ffffffffa04633f8
[   82.812805] RBP: ffffc90000fa7d18 R08: 0000000000000001 R09: 0000000000000000
[   82.813280] R10: 0000000000000001 R11: 000000000526ce2c R12: 0000000000000001
[   82.813738] R13: ffff8802386fc800 R14: ffff88022fe9a200 R15: 0000000000000000
[   82.814280]  ? index_rbio_pages+0x7a/0x100 [btrfs]
[   82.814670]  rmw_work+0x76/0x310 [btrfs]
[   82.815007]  btrfs_scrubparity_helper+0xad/0x8e0 [btrfs]
[   82.815430]  btrfs_rmw_helper+0xe/0x10 [btrfs]
[   82.815723]  process_one_work+0x34f/0x9c0
[   82.815992]  worker_thread+0x34a/0x6b0
[   82.816241]  kthread+0x180/0x190
[   82.816455]  ? create_worker+0x230/0x230
[   82.816712]  ? kthread_create_on_node+0x70/0x70
[   82.817019]  ret_from_fork+0x2a/0x40
[   82.817267] Code: 44 89 c7 31 c0 66 83 e7 04 0f 95 c0 48 83 c0 02 48 83 04 c5 18 e6 dc 82 01 66 85 ff b8 01 00 00 00 0f 85 72 ff ff ff 41 83 c8 04 <
66> 44 89 42 0a 48 89 c8 83 e0 01 48 83 c0 02 48 83 04 c5 f0 e5 
[   82.818516] RIP: report_bug+0xc4/0x180 RSP: ffffc90000fa7ac8
[   82.818883] CR2: ffffffffa03bcc0e
[   82.819110] ---[ end trace 5a34df2460aff289 ]---
