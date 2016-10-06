Return-Path: <neilb@suse.de>
From: NeilBrown <neilb@suse.com>
To: Francesco Dolcini <francesco@dolcini.it>, axboe@kernel.dk
Date: Thu, 06 Oct 2016 16:42:52 +1100
Cc: tj@kernel.org, hch@lst.de, axboe@fb.com, akpm@linux-foundation.org, linux-block@vger.kernel.org
Subject: Re: blockdev kernel regression (bugzilla 173031)
In-Reply-To: <20161005111826.GA2430@dev1>
References: <20161004150350.GA27176@dev1> <8760p75zc6.fsf@notabene.neil.brown.name> <20161005111826.GA2430@dev1>
Message-ID: <87k2dm3ueb.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-block@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 05 2016, Francesco Dolcini wrote:

> Hi all,
> Adding linux-block in CC for this bug report.
>
>
> On Wed, Oct 05, 2016 at 01:00:57PM +1100, NeilBrown wrote:
>> On Wed, Oct 05 2016, Francesco Dolcini wrote:
>> > Hi all,
>> > moving from kernel 3.14 to kernel 4.1 I had a kernel regression on blo=
ck device.
>> >
>> > Problem first arise while removing a usb flash drive while writing was=
 in
>> > progress (details here: https://bugzilla.kernel.org/show_bug.cgi?id=3D=
173031).
>> >
>> > I was able to bisect the issue to commit 6cd18e711dd8075da9d78cfc1239f=
912ff28968a.
>> >
>> > Any suggestion?=20
>> >
>> > Maybe b02176f30cd30acccd3b633ab7d9aed8b5da52ff is the correct fix also=
 for v4.1 stable?
>> >
>> > Andrew Morton in copy since I originally assigned the bug, by mistake,=
 to mm.
>> >
>> > Thanks,
>> > Francesco
>>=20
>> You probably just need
>>=20
>> Commit: bdfe0cbd746a ("Revert "ext4: remove block_device_ejected"")
>>=20
>> NeilBrown
>
> Hi NeilBrown,
> bdfe0cbd746a is already present on 4.1-stable, moreover Oops is reproduce=
d also using vfat.

So it is... odd.

The change should cause ext4 to avoid the problematic code when bdi->dev
is NULL, yet the stack trace strongly suggests that bdi->bdi_stat[x] is
NULL.
bdi_stat[] aren't destroyed until after bdi->dev is set to NULL.

Maybe there is a race, but that seems unlikely.

Anyway, clearly that patch cannot fix the problem.
The vfat issue is different, and is only a warning.

>
>
> Short recap of the situation, if someone does not need the long story on =
bugzilla.
>
> Regression in kernel 4.1, Kernel Oops on USB flash drive removal while wr=
iting.
> Problem was reproduced with ext4 and fat, on x86 and ARM arch.
>
> [   90.740733] BUG: unable to handle kernel paging request at 1dcb5000
> [   90.744026] IP: [<c121ca3c>] __percpu_counter_add+0x2c/0xf0
> [   90.744026] *pde =3D 00000000=20
> [   90.744026] Oops: 0000 [#1] PREEMPT SMP=20
> [   90.744026] Modules linked in: arc4 ath9k ath9k_common ath9k_hw ath ma=
c80211 cfg80211 rfkill
> [   90.744026] CPU: 0 PID: 1534 Comm: dd Tainted: G        W       4.1.33=
_11 #2
> [   90.744026] task: dee12880 ti: defca000 task.ti: defca000
> [   90.744026] EIP: 0060:[<c121ca3c>] EFLAGS: 00010002 CPU: 0
> [   90.744026] EIP is at __percpu_counter_add+0x2c/0xf0
> [   90.744026] EAX: 00000000 EBX: ded84bfc ECX: 00000002 EDX: 00000001
> [   90.744026] ESI: ffffffff EDI: de80eb68 EBP: defcbc84 ESP: defcbc68
> [   90.744026]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
> [   90.744026] CR0: 8005003b CR2: 1dcb5000 CR3: 1efa5000 CR4: 000006d0
> [   90.744026] Stack:
> [   90.744026]  c15ed780 00000019 00000001 00000000 ded84bdc ffffffff de8=
0eb68 defcbc98
> [   90.744026]  c10c58ca 00000008 df6bf800 de80eb58 defcbcb4 c1121447 000=
00000 00000282
> [   90.744026]  df6bf800 de040400 de040400 defcbcc0 c11215a4 dd553000 def=
cbcf4 c1189c5a
> [   90.744026] Call Trace:
> [   90.744026]  [<c10c58ca>] account_page_dirtied+0x6a/0xc0
> [   90.744026]  [<c1121447>] __set_page_dirty+0x37/0xb0
> [   90.744026]  [<c11215a4>] mark_buffer_dirty+0x44/0x80
> [   90.744026]  [<c1189c5a>] ext4_commit_super+0x17a/0x230
> [   90.744026]  [<c118a38b>] __ext4_abort+0x2b/0x110
> [   90.744026]  [<c1124f1d>] ? sync_dirty_buffer+0xd/0x10
> [   90.744026]  [<c1189c7a>] ? ext4_commit_super+0x19a/0x230
> [   90.744026]  [<c119c3c8>] ext4_journal_check_start+0x88/0x90
> [   90.744026]  [<c119c495>] __ext4_journal_start_sb+0x15/0x60
> [   90.744026]  [<c117f7c4>] ext4_dirty_inode+0x34/0x70
> [   90.744026]  [<c111b577>] __mark_inode_dirty+0x27/0x290
> [   90.744026]  [<c111039c>] ? setattr_copy+0x6c/0xd0
> [   90.744026]  [<c117f36e>] ext4_setattr+0x23e/0x660
> [   90.744026]  [<c1173fb7>] ? ext4_file_open+0x37/0x140
> [   90.744026]  [<c11107c5>] notify_change+0x1d5/0x350
> [   90.744026]  [<c121cac4>] ? __percpu_counter_add+0xb4/0xf0
> [   90.744026]  [<c105c17b>] ? get_parent_ip+0xb/0x40
> [   90.744026]  [<c10f4b33>] do_truncate+0x53/0x90
> [   90.744026]  [<c10c71bd>] ? file_ra_state_init+0xd/0x30
> [   90.744026]  [<c11030a8>] do_last.isra.48+0x778/0xe90
> [   90.744026]  [<c121c36f>] ? __this_cpu_preempt_check+0xf/0x20
> [   90.744026]  [<c1104788>] path_openat+0x68/0x4d0
> [   90.744026]  [<c1105c3d>] do_filp_open+0x2d/0x80
> [   90.744026]  [<c10f5e31>] do_sys_open+0x111/0x200
> [   90.744026]  [<c10f4376>] ? filp_close+0x46/0x60
> [   90.744026]  [<c10f5f3f>] SyS_open+0x1f/0x30
> [   90.744026]  [<c1418ba2>] syscall_call+0x7/0x7
> [   90.744026] Code: 89 e5 57 56 53 89 c3 b8 01 00 00 00 8d 64 24 f0 89 5=
5 ec 89 4d f0 e8 84 f7 e3 ff b8 1b b1 53 c1 e8 2a f9 ff ff 8b 55 ec 8b 43 0=
c <64> 8b 30 89 f7 8b 4d f0 c1 ff 1f 01 d6 89 75 ec 8b 75 08 11 cf
> [   90.744026] EIP: [<c121ca3c>] __percpu_counter_add+0x2c/0xf0 SS:ESP 00=
68:defcbc68
> [   90.744026] CR2: 000000001dcb5000
> [   90.744026] ---[ end trace faf081e4d1712537 ]---
> [   90.744026] Kernel panic - not syncing: Fatal exception
> [   90.744026] Kernel Offset: disabled
>
>
> Regression is on commit 6cd18e7 ("block: destroy bdi before blockdev is u=
nregistered.")
>
> Commit: bdfe0cbd746a ("Revert "ext4: remove block_device_ejected") is alr=
eady present on 4.1 stable I am currently working on (2a6f417 on 4.1 branch)
>
> I wonder if commit b02176f ("block: don't release bdi while request_queue=
 has live references") is the correct fix for this also in kernel 4.1.

Maybe.  It is worth a try.

Below is a a backport to 4.1.33.  It compiles, but I haven't tested.
If it works for you, I can recommend it for -stable.

NeilBrown

From: Tejun Heo <tj@kernel.org>
Date: Tue, 8 Sep 2015 12:20:22 -0400
Subject: [PATCH] block: don't release bdi while request_queue has live
 references

bdi's are initialized in two steps, bdi_init() and bdi_register(), but
destroyed in a single step by bdi_destroy() which, for a bdi embedded
in a request_queue, is called during blk_cleanup_queue() which makes
the queue invisible and starts the draining of remaining usages.

A request_queue's user can access the congestion state of the embedded
bdi as long as it holds a reference to the queue.  As such, it may
access the congested state of a queue which finished
blk_cleanup_queue() but hasn't reached blk_release_queue() yet.
Because the congested state was embedded in backing_dev_info which in
turn is embedded in request_queue, accessing the congested state after
bdi_destroy() was called was fine.  The bdi was destroyed but the
memory region for the congested state remained accessible till the
queue got released.

a13f35e87140 ("writeback: don't embed root bdi_writeback_congested in
bdi_writeback") changed the situation.  Now, the root congested state
which is expected to be pinned while request_queue remains accessible
is separately reference counted and the base ref is put during
bdi_destroy().  This means that the root congested state may go away
prematurely while the queue is between bdi_dstroy() and
blk_cleanup_queue(), which was detected by Andrey's KASAN tests.

The root cause of this problem is that bdi doesn't distinguish the two
steps of destruction, unregistration and release, and now the root
congested state actually requires a separate release step.  To fix the
issue, this patch separates out bdi_unregister() and bdi_exit() from
bdi_destroy().  bdi_unregister() is called from blk_cleanup_queue()
and bdi_exit() from blk_release_queue().  bdi_destroy() is now just a
simple wrapper calling the two steps back-to-back.

While at it, the prototype of bdi_destroy() is moved right below
bdi_setup_and_register() so that the counterpart operations are
located together.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: a13f35e87140 ("writeback: don't embed root bdi_writeback_congested i=
n bdi_writeback")
Cc: stable@vger.kernel.org # v4.2+
Reported-and-tested-by: Andrey Konovalov <andreyknvl@google.com>
Link: http://lkml.kernel.org/g/CAAeHK+zUJ74Zn17=3DrOyxacHU18SgCfC6bsYW=3D6k=
CY5GXJBwGfQ@mail.gmail.com
Reviewed-by: Jan Kara <jack@suse.com>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 block/blk-core.c            |  2 +-
 block/blk-sysfs.c           |  1 +
 include/linux/backing-dev.h |  5 ++++-
 mm/backing-dev.c            | 17 ++++++++++++++---
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index bbbf36e6066b..edf8d72daa83 100644
=2D-- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -554,7 +554,7 @@ void blk_cleanup_queue(struct request_queue *q)
 		q->queue_lock =3D &q->__queue_lock;
 	spin_unlock_irq(lock);
=20
=2D	bdi_destroy(&q->backing_dev_info);
+	bdi_unregister(&q->backing_dev_info);
=20
 	/* @q is and will stay empty, shutdown and put */
 	blk_put_queue(q);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 2b8fd302f677..c0bb3291859c 100644
=2D-- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -501,6 +501,7 @@ static void blk_release_queue(struct kobject *kobj)
 	struct request_queue *q =3D
 		container_of(kobj, struct request_queue, kobj);
=20
+	bdi_exit(&q->backing_dev_info);
 	blkcg_exit_queue(q);
=20
 	if (q->elevator) {
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index d87d8eced064..17d1799f8552 100644
=2D-- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -110,12 +110,15 @@ struct backing_dev_info {
 struct backing_dev_info *inode_to_bdi(struct inode *inode);
=20
 int __must_check bdi_init(struct backing_dev_info *bdi);
=2Dvoid bdi_destroy(struct backing_dev_info *bdi);
+void bdi_exit(struct backing_dev_info *bdi);
=20
 __printf(3, 4)
 int bdi_register(struct backing_dev_info *bdi, struct device *parent,
 		const char *fmt, ...);
 int bdi_register_dev(struct backing_dev_info *bdi, dev_t dev);
+void bdi_unregister(struct backing_dev_info *bdi);
+void bdi_destroy(struct backing_dev_info *bdi);
+
 int __must_check bdi_setup_and_register(struct backing_dev_info *, char *);
 void bdi_start_writeback(struct backing_dev_info *bdi, long nr_pages,
 			enum wb_reason reason);
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 000e7b3b9896..1cf18ff42c54 100644
=2D-- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -421,10 +421,8 @@ err:
 }
 EXPORT_SYMBOL(bdi_init);
=20
=2Dvoid bdi_destroy(struct backing_dev_info *bdi)
+void bdi_unregister(struct backing_dev_info *bdi)
 {
=2D	int i;
=2D
 	bdi_wb_shutdown(bdi);
 	bdi_set_min_ratio(bdi, 0);
=20
@@ -436,11 +434,24 @@ void bdi_destroy(struct backing_dev_info *bdi)
 		device_unregister(bdi->dev);
 		bdi->dev =3D NULL;
 	}
+}
+
+void bdi_exit(struct backing_dev_info *bdi)
+{
+	int i;
+
+	WARN_ON_ONCE(bdi->dev);
=20
 	for (i =3D 0; i < NR_BDI_STAT_ITEMS; i++)
 		percpu_counter_destroy(&bdi->bdi_stat[i]);
 	fprop_local_destroy_percpu(&bdi->completions);
 }
+
+void bdi_destroy(struct backing_dev_info *bdi)
+{
+	bdi_unregister(bdi);
+	bdi_exit(bdi);
+}
 EXPORT_SYMBOL(bdi_destroy);
=20
 /*
=2D-=20
2.10.0


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJX9eRcAAoJEDnsnt1WYoG5SdsP/REuoIKghviAmyLDkXmevVks
ojomY2J4I3P/+kHtlzno6/J/ZZnHvknM2OMbOlxTk8S2G9fOgdmA2rjmBIe+5aAO
ZuEFlaytb106Pp5nHhcmAeJhqUQeBgnlRDeRFJrkYDdnDuFm0IL8rzbbFqyVlJoK
+MX+cQk41lQ0ZQKXIUWrJpNZGfuhDndPEoeoeswP6pm8grhPOIFIPqZoB8V4pEDn
/VGzKbmxQQYmI2EkhXxXsXryJypa0QQHIogpAGMLwyqg/p/PnXkGJE+vus3mziKL
H9Atkab3HpV++vP5J82KV+oWo2FfphDRAEIswjW3f+g/3qYaGnuGceiNiApArIvv
rxakF2CAM7uHYWnEaXK50Ud86VT+l9CGczPYNNDGvBkqyMKghKh0SykgLNiMLHj7
3Zcvwh0fv5UvXFxkQM91+MoKIBmA443THuhUrmLebikd9xBZMP1m2fC84XNauLO6
Es/a1q355wpaah3msrIKp3oOx0fL98JSEmeURPN5GypcGWPDMsNkIjuUYICw9hl4
QTyc/zbkHnXNy0oGtQl0gj7gyX7imxezYQWw7uZ46SjjFjLw088XjqQTvHnWQWm4
QD6C1Mh7hhioI+Zjk0qlL5K9BkSiruGG2dWowOrCpKrILdRf+xvzTT45GHcPVp9J
P9Fn5NIL2bvcihOrdMDp
=WRd4
-----END PGP SIGNATURE-----
--=-=-=--
