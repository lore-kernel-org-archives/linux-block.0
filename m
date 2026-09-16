Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4C244839D
	for <linux-block@vger.kernel.org>; Wed, 16 Sep 2026 19:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588373; cv=none; b=tcsUdjCL8bOIbFOdiRUYfG2rkAzI3C0FFa02LBPa6/JPYpBLnOPghjTZXF7ciUEvxHeRmEH6X4iKNNqhOnM8mBoR/J9mrmRDApz/5/VwrkcaY1LIBrV3Xm4NxlXQqUwQ8iBarc8Q2yryvd2JOCk1LmuAVmkXqgv1+oiDEKKx9W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588373; c=relaxed/simple;
	bh=HHLgW41r8qycYv3yt4CLfx24N4Kf+UHPC51mprz/bPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gal6bbj4HPMAdVj4lGzey8uSaS8TVJvo3gxtw0409rUtMW89544xPyhyZxs149QbNObZOuWKUT0iOraD+LDxXghdscgIkDqh2zyzaTIlsJjPsGs6Id7ozHt2ltxKszoDl03f37sBLZ3Wtgomv8useHO4/VMdsSks1N2035zh83I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=BvJPWkaq; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="BvJPWkaq"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hlV0X2N5SzlfvpG;
	Wed, 16 Sep 2026 19:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1789588342; x=1792180343; bh=JEu8D
	HdUlvucubVqH8h1PDuDRNbvtkds36oFayhCluw=; b=BvJPWkaqOg+FoVtEouNyq
	YFvDkCgv6eVvhs99GzWAwMj6157vOn+4gIK+ELloTf4argaWqn/5bysx/ROnU5pa
	r3fJhJhRtsTcp559SFC1d1FmQt568XgG5hSY7Y9S0s+Ap8xtpP2B97uj9R1TJ/Ej
	+GLvYvd7QbWhsD3H8UchpZXpicx9AgXDWijDwxv37gFaCZSUVAge8Y+dsWz/Bd6Z
	xzqIzSEZE18eNVUQQWUpBb2fFnTU/KQVgzndtdOmU/RyvMxcLQ3ocLSFvKhq777P
	8kb+ceMfoj/CDcIPRfT1fDBMOPTCq4FeYmShCx21AvOnsWXsfJ0MP0EMK8UinwJ/
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id BQWRxe911sJi; Wed, 16 Sep 2026 19:52:22 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (148.60.168.34.bc.googleusercontent.com [34.168.60.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hlV0N6fCWzlfvq8;
	Wed, 16 Sep 2026 19:52:20 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 2/2] loop: Perform __loop_clr_fd() after disk->open_mutex is dropped
Date: Wed, 16 Sep 2026 12:51:53 -0700
Message-ID: <cb1383e61e1b4d63906deb9a947f781416282939.1789587960.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <cover.1789587960.git.bvanassche@acm.org>
References: <cover.1789587960.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In order to prevent NULL pointer dereferences in lo_rw_aio() when tearing
down a loop device, outstanding I/O must be flushed before clearing the
backing file and device state. However, calling blk_mq_wait_quiesce_done(=
),
drain_workqueue(), or blk_mq_freeze_queue() with disk->open_mutex held
causes lockdep warnings and potential deadlocks.

Use the .post_release() block device operation to execute __loop_clr_fd()
synchronously after disk->open_mutex has been released by the block layer=
.
Inside __loop_clr_fd(), outstanding I/O is flushed and the request queue
is frozen before acquiring disk->open_mutex to perform the remaining
device teardown and partition rescans.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 51 ++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 758c20678bf6..d3e686bebcd3 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1138,11 +1138,33 @@ static int loop_configure(struct loop_device *lo,=
 blk_mode_t mode,
=20
 static void __loop_clr_fd(struct loop_device *lo)
 {
+	struct gendisk *disk =3D lo->lo_disk;
 	struct queue_limits lim;
 	struct file *filp;
 	gfp_t gfp =3D lo->old_gfp_mask;
+	unsigned int memflags;
 	int err;
=20
+	WARN_ON_ONCE(READ_ONCE(lo->lo_state) !=3D Lo_rundown);
+
+	/*
+	 * Wait for ongoing loop_queue_rq() calls. Subsequent loop_queue_rq()
+	 * calls which are made after this call returned will see lo->lo_state
+	 * !=3D Lo_bound and return with BLK_STS_IOERR.
+	 */
+	blk_mq_wait_quiesce_done(&lo->tag_set);
+
+	/* loop_queue_rq() queues work on lo->workqueue, hence drain it. */
+	drain_workqueue(lo->workqueue);
+
+	lim =3D queue_limits_start_update(lo->lo_queue);
+
+	/*
+	 * Freeze the request queue while updating parameters used while
+	 * processing requests.
+	 */
+	memflags =3D blk_mq_freeze_queue(lo->lo_queue);
+
 	spin_lock_irq(&lo->lo_lock);
 	filp =3D lo->lo_backing_file;
 	lo->lo_backing_file =3D NULL;
@@ -1153,18 +1175,17 @@ static void __loop_clr_fd(struct loop_device *lo)
 	lo->lo_sizelimit =3D 0;
 	memset(lo->lo_file_name, 0, LO_NAME_SIZE);
=20
-	/*
-	 * Reset the block size to the default.
-	 *
-	 * No queue freezing needed because this is called from the final
-	 * ->release call only, so there can't be any outstanding I/O.
-	 */
-	lim =3D queue_limits_start_update(lo->lo_queue);
+	/* Reset the block size to the default. */
 	lim.logical_block_size =3D SECTOR_SIZE;
 	lim.physical_block_size =3D SECTOR_SIZE;
 	lim.io_min =3D SECTOR_SIZE;
 	queue_limits_commit_update(lo->lo_queue, &lim);
=20
+	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
+
+	/* Serialize against concurrent bdev_open() calls. */
+	mutex_lock(&disk->open_mutex);
+
 	invalidate_disk(lo->lo_disk);
 	loop_sysfs_exit(lo);
 	/* let user-space know about this change */
@@ -1178,9 +1199,6 @@ static void __loop_clr_fd(struct loop_device *lo)
 	/*
 	 * Remove all partitions, including partitions added manually with
 	 * BLKPG, which may exist even if LO_FLAGS_PARTSCAN is not set.
-	 *
-	 * open_mutex has been held already in release path, so don't acquire
-	 * it here.
 	 */
 	err =3D bdev_disk_changed(lo->lo_disk, false);
 	if (err)
@@ -1197,6 +1215,8 @@ static void __loop_clr_fd(struct loop_device *lo)
 	lo->lo_flags =3D 0;
 	if (!part_shift)
 		set_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
+	mutex_unlock(&disk->open_mutex);
+
 	mutex_lock(&lo->lo_mutex);
 	WRITE_ONCE(lo->lo_state, Lo_unbound);
 	mutex_unlock(&lo->lo_mutex);
@@ -1754,7 +1774,6 @@ static int lo_open(struct gendisk *disk, blk_mode_t=
 mode)
 static void lo_release(struct gendisk *disk)
 {
 	struct loop_device *lo =3D disk->private_data;
-	bool need_clear =3D false;
=20
 	if (disk_openers(disk) > 0)
 		return;
@@ -1767,11 +1786,14 @@ static void lo_release(struct gendisk *disk)
 	mutex_lock(&lo->lo_mutex);
 	if (lo->lo_state =3D=3D Lo_bound && (lo->lo_flags & LO_FLAGS_AUTOCLEAR)=
)
 		WRITE_ONCE(lo->lo_state, Lo_rundown);
-
-	need_clear =3D (lo->lo_state =3D=3D Lo_rundown);
 	mutex_unlock(&lo->lo_mutex);
+}
+
+static void lo_post_release(struct gendisk *disk)
+{
+	struct loop_device *lo =3D disk->private_data;
=20
-	if (need_clear)
+	if (READ_ONCE(lo->lo_state) =3D=3D Lo_rundown)
 		__loop_clr_fd(lo);
 }
=20
@@ -1791,6 +1813,7 @@ static const struct block_device_operations lo_fops=
 =3D {
 	.owner =3D	THIS_MODULE,
 	.open =3D         lo_open,
 	.release =3D	lo_release,
+	.post_release =3D lo_post_release,
 	.ioctl =3D	lo_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl =3D	lo_compat_ioctl,
