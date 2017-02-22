Return-Path: <jack@suse.cz>
Date: Wed, 22 Feb 2017 11:24:25 +0100
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	Tejun Heo <tj@kernel.org>, NeilBrown <neilb@suse.de>,
	Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 0/13 v2] block: Fix block device shutdown related races
Message-ID: <20170222102425.GB23312@quack2.suse.cz>
References: <20170221170958.21845-1-jack@suse.cz>
 <7734fd93-e4fd-65a7-bf32-08012de83c1e@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
In-Reply-To: <7734fd93-e4fd-65a7-bf32-08012de83c1e@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue 21-02-17 10:19:28, Jens Axboe wrote:
> On 02/21/2017 10:09 AM, Jan Kara wrote:
> > Hello,
> > 
> > this is a second revision of the patch set to fix several different races and
> > issues I've found when testing device shutdown and reuse. The first three
> > patches are fixes to problems in my previous series fixing BDI lifetime issues.
> > Patch 4 fixes issues with reuse of BDI name with scsi devices. With it I cannot
> > reproduce the BDI name reuse issues using Omar's stress test using scsi_debug
> > so it can be used as a replacement of Dan's patches. Patches 5-11 fix oops that
> > is triggered by __blkdev_put() calling inode_detach_wb() too early (the problem
> > reported by Thiago). Patches 12 and 13 fix oops due to a bug in gendisk code
> > where get_gendisk() can return already freed gendisk structure (again triggered
> > by Omar's stress test).
> > 
> > People, please have a look at patches. They are mostly simple however the
> > interactions are rather complex so I may have missed something. Also I'm
> > happy for any additional testing these patches can get - I've stressed them
> > with Omar's script, tested memcg writeback, tested static (not udev managed)
> > device inodes.
> > 
> > Jens, I think at least patches 1-3 should go in together with my fixes you
> > already have in your tree (or shortly after them). It is up to you whether
> > you decide to delay my first fixes or pick these up quickly. Patch 4 is
> > (IMHO a cleaner) replacement of Dan's patches so consider whether you want
> > to use it instead of those patches.
> 
> I have applied 1-3 to my for-linus branch, which will go in after
> the initial pull request has been pulled by Linus. Consider fixing up
> #4 so it applies, I like it.

OK, attached is patch 4 rebased on top of Linus' tree from today which
already has linux-block changes pulled in. I've left put_disk_devt() in
blk_cleanup_queue() to maintain the logic in the original patch (now commit
0dba1314d4f8) that request_queue and gendisk each hold one devt reference.
The bdi_unregister() call that is moved to del_gendisk() by this patch is
now protected by the gendisk reference instead of the request_queue one
so it still maintains the property that devt reference protects bdi
registration-unregistration lifetime (as much as that is not needed anymore
after this patch).

I have also updated the comment in the code and the changelog - they were
somewhat stale after changes to the whole series Tejun suggested.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--6c2NcOVqGQ03X4Wi
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-block-Move-bdi_unregister-to-del_gendisk.patch"

>From 9abe9565c83af6b653b159a7bf5b895aff638c65 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 8 Feb 2017 08:05:56 +0100
Subject: [PATCH] block: Move bdi_unregister() to del_gendisk()

Commit 6cd18e711dd8 "block: destroy bdi before blockdev is
unregistered." moved bdi unregistration (at that time through
bdi_destroy()) from blk_release_queue() to blk_cleanup_queue() because
it needs to happen before blk_unregister_region() call in del_gendisk()
for MD. SCSI though will free up the device number from sd_remove()
called through a maze of callbacks from device_del() in
__scsi_remove_device() before blk_cleanup_queue() and thus similar races
as described in 6cd18e711dd8 can happen for SCSI as well as reported by
Omar [1].

Moving bdi_unregister() to del_gendisk() works for MD and fixes the
problem for SCSI since del_gendisk() gets called from sd_remove() before
freeing the device number.

This also makes device_add_disk() (calling bdi_register_owner()) more
symmetric with del_gendisk().

[1] http://marc.info/?l=linux-block&m=148554717109098&w=2

Tested-by: Lekshmi Pillai <lekshmicpillai@in.ibm.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-core.c | 1 -
 block/genhd.c    | 5 +++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index b9e857f4afe8..1086dac8724c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -578,7 +578,6 @@ void blk_cleanup_queue(struct request_queue *q)
 		q->queue_lock = &q->__queue_lock;
 	spin_unlock_irq(lock);
 
-	bdi_unregister(q->backing_dev_info);
 	put_disk_devt(q->disk_devt);
 
 	/* @q is and will stay empty, shutdown and put */
diff --git a/block/genhd.c b/block/genhd.c
index 2f444b87a5f2..b26a5ea115d0 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -681,6 +681,11 @@ void del_gendisk(struct gendisk *disk)
 	disk->flags &= ~GENHD_FL_UP;
 
 	sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
+	/*
+	 * Unregister bdi before releasing device numbers (as they can get
+	 * reused and we'd get clashes in sysfs).
+	 */
+	bdi_unregister(disk->queue->backing_dev_info);
 	blk_unregister_queue(disk);
 	blk_unregister_region(disk_devt(disk), disk->minors);
 
-- 
2.10.2


--6c2NcOVqGQ03X4Wi--
