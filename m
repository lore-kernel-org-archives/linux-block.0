Return-Path: <neilb@suse.de>
From: NeilBrown <neilb@suse.com>
To: stable@vger.kernel.org
Date: Fri, 07 Oct 2016 15:13:26 +1100
Cc: Francesco Dolcini <francesco@dolcini.it>, LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, tj@kernel.org
Subject: [PATCH - stable 4.1 backport] block: don't release bdi while request_queue has live references
Message-ID: <87zimg3ift.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-block@vger.kernel.org>

--=-=-=
Content-Type: text/plain


Hi,
 This patch was marked for stable v4.2+, but is needed for v4.1 as well.
 It fixes a regression introduced by:
  Fixes: 6cd18e711dd8 ("block: destroy bdi before blockdev is unregistered.")

 This is a backport to 4.1.33 which has been tested and confirmed to
 work.
 Bug report at
  https://bugzilla.kernel.org/show_bug.cgi?id=173031

 Please queue for 4.1.y

Thanks,
NeilBrown



From: Tejun Heo <tj@kernel.org>
Date: Tue, 8 Sep 2015 12:20:22 -0400
Subject: [PATCH] block: don't release bdi while request_queue has live
 references

[ Upstream commit: b02176f30cd30acccd3b633ab7d9aed8b5da52ff ]

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
Fixes: a13f35e87140 ("writeback: don't embed root bdi_writeback_congested in bdi_writeback")
Fixes: 6cd18e711dd8 ("block: destroy bdi before blockdev is unregistered.")
Cc: stable@vger.kernel.org # v4.2+
Reported-and-tested-by: Andrey Konovalov <andreyknvl@google.com>
Reported-and-tested-by: Francesco Dolcini <francesco@dolcini.it> (for 4.1 backport)
Link: http://lkml.kernel.org/g/CAAeHK+zUJ74Zn17=rOyxacHU18SgCfC6bsYW=6kCY5GXJBwGfQ@mail.gmail.com
Reviewed-by: Jan Kara <jack@suse.com>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: NeilBrown <neilb@suse.com>

---
 block/blk-core.c            |  2 +-
 block/blk-sysfs.c           |  1 +
 include/linux/backing-dev.h |  5 ++++-
 mm/backing-dev.c            | 17 ++++++++++++++---
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index bbbf36e6066b..edf8d72daa83 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -554,7 +554,7 @@ void blk_cleanup_queue(struct request_queue *q)
 		q->queue_lock = &q->__queue_lock;
 	spin_unlock_irq(lock);

-	bdi_destroy(&q->backing_dev_info);
+	bdi_unregister(&q->backing_dev_info);

 	/* @q is and will stay empty, shutdown and put */
 	blk_put_queue(q);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 2b8fd302f677..c0bb3291859c 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -501,6 +501,7 @@ static void blk_release_queue(struct kobject *kobj)
 	struct request_queue *q =
 		container_of(kobj, struct request_queue, kobj);

+	bdi_exit(&q->backing_dev_info);
 	blkcg_exit_queue(q);

 	if (q->elevator) {
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index d87d8eced064..17d1799f8552 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -110,12 +110,15 @@ struct backing_dev_info {
 struct backing_dev_info *inode_to_bdi(struct inode *inode);

 int __must_check bdi_init(struct backing_dev_info *bdi);
-void bdi_destroy(struct backing_dev_info *bdi);
+void bdi_exit(struct backing_dev_info *bdi);

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
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -421,10 +421,8 @@ err:
 }
 EXPORT_SYMBOL(bdi_init);

-void bdi_destroy(struct backing_dev_info *bdi)
+void bdi_unregister(struct backing_dev_info *bdi)
 {
-	int i;
-
 	bdi_wb_shutdown(bdi);
 	bdi_set_min_ratio(bdi, 0);

@@ -436,11 +434,24 @@ void bdi_destroy(struct backing_dev_info *bdi)
 		device_unregister(bdi->dev);
 		bdi->dev = NULL;
 	}
+}
+
+void bdi_exit(struct backing_dev_info *bdi)
+{
+	int i;
+
+	WARN_ON_ONCE(bdi->dev);

 	for (i = 0; i < NR_BDI_STAT_ITEMS; i++)
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

 /*


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJX9yDmAAoJEDnsnt1WYoG50wUP/RLxJgZ9rOm8trOTAmiIaBiH
LnW25pUjhlyOlmGx78loOlb+6TmBGe+cSTgxqkIkJ9i2FOwA6qymMQHrATDWstQX
0UC9IYc3lGYthNtOjp5n856ILJtHIj6NQBx6nh3i4WKdc3GYAA1v0N6UP7gP6Kku
L75+KTXRRiOjb0ThhiLloyxiXN9qOSlBISyG1A1jH95Y4F66DM66nGn54JtV7mLy
jhnKcdqehUZSDRuZ6At+Uq/9t77rRWPsOSRR7s+Fhto9l/tSfMS9WrW5Wbz5MNC/
QdFl4MZyYonn5U6SzC+8GYQEXG7NtygiZfHquBC662z8m0UO+b0R/mkqERNVe8cc
7RZnPApKbx3IKGMi6KnWooX6QaZy0RnkmmvoBWTNY23QyOeyMGRSU+eOWFM2XZVi
Dlfm2MzBF2kwbRwbdEu7ETHcl/MbitAP1my6VxC4ChBgYL658uvH1OmdqADkQU8k
N60i6wS4LQB/GkIRP3l7Wy/4elcHvxg+33p7eV1uGrZFmU34qKSvoGOfPS7WMEfQ
WmcE3vl/7aPxa/l0YrYI06XZ7tydG2hJwmJuLG8pd3ECIw7xTRDETW+bczGZsRYG
a3WFLiRr1w2EC+kkRVWRyx7AcVEHud9h8RKmAA2p/Q5YDzxW7/nC/rP8gGC6A/uQ
3394FplSYXMlVopLLchV
=bDTi
-----END PGP SIGNATURE-----
--=-=-=--
