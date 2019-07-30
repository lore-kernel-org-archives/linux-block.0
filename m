Return-Path: <SRS0=ZBGg=V3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF470C0650F
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 13:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36DA2089E
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 13:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfG3NgK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jul 2019 09:36:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:42312 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727860AbfG3NgK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jul 2019 09:36:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EBA47ABF1;
        Tue, 30 Jul 2019 13:36:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 552FC1E440D; Tue, 30 Jul 2019 15:36:07 +0200 (CEST)
Date:   Tue, 30 Jul 2019 15:36:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     John Lenton <john.lenton@canonical.com>
Cc:     Jan Kara <jack@suse.cz>, Kai-Heng Feng <kaihengfeng@me.com>,
        Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org, jean-baptiste.lallement@canonical.com
Subject: Re: [PATCH] loop: Don't change loop device under exclusive opener
Message-ID: <20190730133607.GD28829@quack2.suse.cz>
References: <20190516140127.23272-1-jack@suse.cz>
 <50edd0fa-9cfa-38e1-8870-0fbc5c618522@kernel.dk>
 <20190527122915.GB9998@quack2.suse.cz>
 <b0f27980-be75-bded-3e74-bce14fc7ea47@kernel.dk>
 <894DDAA8-2ADD-467C-8E4F-4DE6B9A50625@me.com>
 <20190730092939.GB28829@quack2.suse.cz>
 <CAL1QPZQWDx2YEAP168C+Eb4g4DmGg8eOBoOqkbUOBKTMDc9gjg@mail.gmail.com>
 <20190730101646.GC28829@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20190730101646.GC28829@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue 30-07-19 12:16:46, Jan Kara wrote:
> On Tue 30-07-19 10:36:59, John Lenton wrote:
> > On Tue, 30 Jul 2019 at 10:29, Jan Kara <jack@suse.cz> wrote:
> > >
> > > Thanks for the notice and the references. What's your version of
> > > util-linux? What your test script does is indeed racy. You have there:
> > >
> > > echo Running:
> > > for i in {a..z}{a..z}; do
> > >     mount $i.squash /mnt/$i &
> > > done
> > >
> > > So all mount(8) commands will run in parallel and race to setup loop
> > > devices with LOOP_SET_FD and mount them. However util-linux (at least in
> > > the current version) seems to handle EBUSY from LOOP_SET_FD just fine and
> > > retries with the new loop device. So at this point I don't see why the patch
> > > makes difference... I guess I'll need to reproduce and see what's going on
> > > in detail.
> > 
> > We've observed this in arch with util-linux 2.34, and ubuntu 19.10
> > (eoan ermine) with util-linux 2.33.
> > 
> > just to be clear, the initial reports didn't involve a zany loop of
> > mounts, but were triggered by effectively the same thing as systemd
> > booted a system with a lot of snaps. The reroducer tries to makes
> > things simpler to reproduce :-). FWIW,  systemd versions were 244 and
> > 242 for those systems, respectively.
> 
> Thanks for info! So I think I see what's going on. The two mounts race
> like:
> 
> MOUNT1					MOUNT2
> num = ioctl(LOOP_CTL_GET_FREE)
> 					num = ioctl(LOOP_CTL_GET_FREE)
> ioctl("/dev/loop$num", LOOP_SET_FD, ..)
>  - returns OK
> 					ioctl("/dev/loop$num", LOOP_SET_FD, ..)
> 					  - acquires exclusine loop$num
> 					    reference
> mount("/dev/loop$num", ...)
>  - sees exclusive reference from MOUNT2 and fails
> 					  - sees loop device is already
> 					    bound and fails
> 
> It is a bug in the scheme I've chosen that racing LOOP_SET_FD can block
> perfectly valid mount. I'll think how to fix this...

So how about attached patch? It fixes the regression for me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--XsQoSWH+UP9D9v3l
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-loop-Fix-mount-2-failure-due-to-race-with-LOOP_SET_F.patch"

From 5069263402e9daef5df1ee02576107e11bd138a6 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Tue, 30 Jul 2019 13:10:14 +0200
Subject: [PATCH] loop: Fix mount(2) failure due to race with LOOP_SET_FD

Commit 33ec3e53e7b1 ("loop: Don't change loop device under exclusive
opener") made LOOP_SET_FD ioctl acquire exclusive block device reference
while it updates loop device binding. However this can make perfectly
valid mount(2) fail with EBUSY due to racing LOOP_SET_FD holding
temporarily the exclusive bdev reference in cases like this:

for i in {a..z}{a..z}; do
        dd if=/dev/zero of=$i.image bs=1k count=0 seek=1024
        mkfs.ext2 $i.image
        mkdir mnt$i
done

echo "Run"
for i in {a..z}{a..z}; do
        mount -o loop -t ext2 $i.image mnt$i &
done

Fix the problem by not getting full exclusive bdev reference in
LOOP_SET_FD but instead just mark the bdev as being claimed while we
update the binding information. This just blocks new exclusive openers
instead of failing them with EBUSY thus fixing the problem.

Fixes: 33ec3e53e7b1 ("loop: Don't change loop device under exclusive opener")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c | 16 +++++-----
 fs/block_dev.c       | 83 ++++++++++++++++++++++++++++++++++++----------------
 include/linux/fs.h   |  6 ++++
 3 files changed, 73 insertions(+), 32 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 44c9985f352a..3036883fc9f8 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -924,6 +924,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	struct file	*file;
 	struct inode	*inode;
 	struct address_space *mapping;
+	struct block_device *claimed_bdev = NULL;
 	int		lo_flags = 0;
 	int		error;
 	loff_t		size;
@@ -942,10 +943,11 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	 * here to avoid changing device under exclusive owner.
 	 */
 	if (!(mode & FMODE_EXCL)) {
-		bdgrab(bdev);
-		error = blkdev_get(bdev, mode | FMODE_EXCL, loop_set_fd);
-		if (error)
+		claimed_bdev = bd_start_claiming(bdev, loop_set_fd);
+		if (IS_ERR(claimed_bdev)) {
+			error = PTR_ERR(claimed_bdev);
 			goto out_putf;
+		}
 	}
 
 	error = mutex_lock_killable(&loop_ctl_mutex);
@@ -1015,15 +1017,15 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	mutex_unlock(&loop_ctl_mutex);
 	if (partscan)
 		loop_reread_partitions(lo, bdev);
-	if (!(mode & FMODE_EXCL))
-		blkdev_put(bdev, mode | FMODE_EXCL);
+	if (claimed_bdev)
+		bd_abort_claiming(bdev, claimed_bdev, loop_set_fd);
 	return 0;
 
 out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
 out_bdev:
-	if (!(mode & FMODE_EXCL))
-		blkdev_put(bdev, mode | FMODE_EXCL);
+	if (claimed_bdev)
+		bd_abort_claiming(bdev, claimed_bdev, loop_set_fd);
 out_putf:
 	fput(file);
 out:
diff --git a/fs/block_dev.c b/fs/block_dev.c
index c2a85b587922..22591bad9353 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1181,8 +1181,7 @@ static struct gendisk *bdev_get_gendisk(struct block_device *bdev, int *partno)
  * Pointer to the block device containing @bdev on success, ERR_PTR()
  * value on failure.
  */
-static struct block_device *bd_start_claiming(struct block_device *bdev,
-					      void *holder)
+struct block_device *bd_start_claiming(struct block_device *bdev, void *holder)
 {
 	struct gendisk *disk;
 	struct block_device *whole;
@@ -1229,6 +1228,62 @@ static struct block_device *bd_start_claiming(struct block_device *bdev,
 		return ERR_PTR(err);
 	}
 }
+EXPORT_SYMBOL(bd_start_claiming);
+
+static void bd_clear_claiming(struct block_device *whole, void *holder)
+{
+	lockdep_assert_held(&bdev_lock);
+	/* tell others that we're done */
+	BUG_ON(whole->bd_claiming != holder);
+	whole->bd_claiming = NULL;
+	wake_up_bit(&whole->bd_claiming, 0);
+}
+
+/**
+ * bd_finish_claiming - finish claiming of a block device
+ * @bdev: block device of interest
+ * @whole: whole block device (returned from bd_start_claiming())
+ * @holder: holder that has claimed @bdev
+ *
+ * Finish exclusive open of a block device. Mark the device as exlusively
+ * open by the holder and wake up all waiters for exclusive open to finish.
+ */
+void bd_finish_claiming(struct block_device *bdev, struct block_device *whole,
+			void *holder)
+{
+	spin_lock(&bdev_lock);
+	BUG_ON(!bd_may_claim(bdev, whole, holder));
+	/*
+	 * Note that for a whole device bd_holders will be incremented twice,
+	 * and bd_holder will be set to bd_may_claim before being set to holder
+	 */
+	whole->bd_holders++;
+	whole->bd_holder = bd_may_claim;
+	bdev->bd_holders++;
+	bdev->bd_holder = holder;
+	bd_clear_claiming(whole, holder);
+	spin_unlock(&bdev_lock);
+}
+EXPORT_SYMBOL(bd_finish_claiming);
+
+/**
+ * bd_abort_claiming - abort claiming of a block device
+ * @bdev: block device of interest
+ * @whole: whole block device (returned from bd_start_claiming())
+ * @holder: holder that has claimed @bdev
+ *
+ * Abort claiming of a block device when the exclusive open failed. This can be
+ * also used when exclusive open is not actually desired and we just needed
+ * to block other exclusive openers for a while.
+ */
+void bd_abort_claiming(struct block_device *bdev, struct block_device *whole,
+		       void *holder)
+{
+	spin_lock(&bdev_lock);
+	bd_clear_claiming(whole, holder);
+	spin_unlock(&bdev_lock);
+}
+EXPORT_SYMBOL(bd_abort_claiming);
 
 #ifdef CONFIG_SYSFS
 struct bd_holder_disk {
@@ -1698,29 +1753,7 @@ int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
 
 		/* finish claiming */
 		mutex_lock(&bdev->bd_mutex);
-		spin_lock(&bdev_lock);
-
-		if (!res) {
-			BUG_ON(!bd_may_claim(bdev, whole, holder));
-			/*
-			 * Note that for a whole device bd_holders
-			 * will be incremented twice, and bd_holder
-			 * will be set to bd_may_claim before being
-			 * set to holder
-			 */
-			whole->bd_holders++;
-			whole->bd_holder = bd_may_claim;
-			bdev->bd_holders++;
-			bdev->bd_holder = holder;
-		}
-
-		/* tell others that we're done */
-		BUG_ON(whole->bd_claiming != holder);
-		whole->bd_claiming = NULL;
-		wake_up_bit(&whole->bd_claiming, 0);
-
-		spin_unlock(&bdev_lock);
-
+		bd_finish_claiming(bdev, whole, holder);
 		/*
 		 * Block event polling for write claims if requested.  Any
 		 * write holder makes the write_holder state stick until
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 56b8e358af5c..997a530ff4e9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2598,6 +2598,12 @@ extern struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
 					       void *holder);
 extern struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode,
 					      void *holder);
+extern struct block_device *bd_start_claiming(struct block_device *bdev,
+					      void *holder);
+extern void bd_finish_claiming(struct block_device *bdev,
+			       struct block_device *whole, void *holder);
+extern void bd_abort_claiming(struct block_device *bdev,
+			      struct block_device *whole, void *holder);
 extern void blkdev_put(struct block_device *bdev, fmode_t mode);
 extern int __blkdev_reread_part(struct block_device *bdev);
 extern int blkdev_reread_part(struct block_device *bdev);
-- 
2.16.4


--XsQoSWH+UP9D9v3l--
