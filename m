Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F144CA796
	for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 21:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680062; cv=none; b=n5jB2Yzx27rVn1mXZ9RZWzXs15yMXO0Cb1QGJ7wmmHuWEKaUptawg+6sffoYLT0xxDcjIEH199+SBC0/DR4e2X8nkH2jHIe/qpf7b263cssvR6WdoSvpMjCAFBOg/JoYQSCzrWQ1DiBQrndCRRYuFx39GJ9tHArUyKCcjEC9QYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680062; c=relaxed/simple;
	bh=v0l0oWWiebdz2Y0Tr0OmG9dCAnSjT+WnoaCYD00XP7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJWbIrEbg66FiYlF464Mvcm2SDg+WBBHkGsxiAvGHILSmdbJySgQT3eXTZ7UqecpHP05UFLvLigX07rj0o+baOF7cY+rrZQ4avGEerSOftPjYEL4US2wKZBW7ZXV+R5JhSLNEVLiC5w+nSWqcubkCoijlm4euRPPQX7AwxPOg3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=K9mSWVjS; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="K9mSWVjS"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hm7w964Jczlfvpc;
	Thu, 17 Sep 2026 21:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1789680051; x=1792272052; bh=tuGhP
	I0mrdLZWKJzbkoZFARjEoJ476H2ROod8lm9iC8=; b=K9mSWVjST+AYQBcH2f0i8
	gYec/Zv2cp6G8MSaEMOhWpU8otBu3CqD7+8/4/GQOqCWdRfr698NyzgKUzOs7l1R
	b6+C5fWxYIUjejN1j4WYwj6FhH7i/9A/sdC9vHLN6A6hQKFSgITZL4eWpN1XSARD
	575WPFAiSU2ANDagcz8G6CN07gdWmhRiCorI/mgW6En2/ZgeLebDTjV86xehwgHV
	kcYN/CfVLpYJ1Q1pt2+25Lp4Th1XywtNdxl2XTNUmAoNz6nKGJpSrFentcbw+QsN
	R4ZP4gTmvqS33Ren8dpv+Onru36492NENTPZhtCuQON1bJqQSCdsIz9ka7i33T6+
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Le9QZYdnDSL5; Thu, 17 Sep 2026 21:20:51 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (148.60.168.34.bc.googleusercontent.com [34.168.60.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hm7w16q5Hzlfvq0;
	Thu, 17 Sep 2026 21:20:49 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 2/2] loop: Perform __loop_clr_fd() after disk->open_mutex is dropped
Date: Thu, 17 Sep 2026 14:20:26 -0700
Message-ID: <cdaebcf71c5de3e994f535dfdc9daa15a77bf59b.1789680010.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <72661d0de27da8c843faf18f9b79442b0e1bb6b5.1789680010.git.bvanassche@acm.org>
References: <72661d0de27da8c843faf18f9b79442b0e1bb6b5.1789680010.git.bvanassche@acm.org>
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

Introduce a new loop device state to ensure that __loop_clr_fd() clears
a loop device once even if it is called multiple times concurrently.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 60 ++++++++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 16 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 758c20678bf6..0ebee9a8816a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -42,6 +42,7 @@ enum {
 	Lo_unbound,
 	Lo_bound,
 	Lo_rundown,
+	Lo_clearing,
 	Lo_deleting,
 };
=20
@@ -1138,11 +1139,38 @@ static int loop_configure(struct loop_device *lo,=
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
+	scoped_guard(mutex, &lo->lo_mutex) {
+		if (READ_ONCE(lo->lo_state) !=3D Lo_rundown)
+			return;
+		WRITE_ONCE(lo->lo_state, Lo_clearing);
+	}
+
+	/*
+	 * Wait for ongoing loop_queue_rq() calls. Subsequent loop_queue_rq()
+	 * calls which are made after this call returned will see lo->lo_state
+	 * !=3D Lo_bound and return with BLK_STS_IOERR.
+	 */
+	blk_mq_quiesce_queue(lo->lo_queue);
+	blk_mq_unquiesce_queue(lo->lo_queue);
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
@@ -1153,18 +1181,17 @@ static void __loop_clr_fd(struct loop_device *lo)
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
@@ -1178,9 +1205,6 @@ static void __loop_clr_fd(struct loop_device *lo)
 	/*
 	 * Remove all partitions, including partitions added manually with
 	 * BLKPG, which may exist even if LO_FLAGS_PARTSCAN is not set.
-	 *
-	 * open_mutex has been held already in release path, so don't acquire
-	 * it here.
 	 */
 	err =3D bdev_disk_changed(lo->lo_disk, false);
 	if (err)
@@ -1197,6 +1221,8 @@ static void __loop_clr_fd(struct loop_device *lo)
 	lo->lo_flags =3D 0;
 	if (!part_shift)
 		set_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
+	mutex_unlock(&disk->open_mutex);
+
 	mutex_lock(&lo->lo_mutex);
 	WRITE_ONCE(lo->lo_state, Lo_unbound);
 	mutex_unlock(&lo->lo_mutex);
@@ -1745,7 +1771,7 @@ static int lo_open(struct gendisk *disk, blk_mode_t=
 mode)
 	if (err)
 		return err;
=20
-	if (lo->lo_state =3D=3D Lo_deleting || lo->lo_state =3D=3D Lo_rundown)
+	if (lo->lo_state !=3D Lo_bound && lo->lo_state !=3D Lo_unbound)
 		err =3D -ENXIO;
 	mutex_unlock(&lo->lo_mutex);
 	return err;
@@ -1754,7 +1780,6 @@ static int lo_open(struct gendisk *disk, blk_mode_t=
 mode)
 static void lo_release(struct gendisk *disk)
 {
 	struct loop_device *lo =3D disk->private_data;
-	bool need_clear =3D false;
=20
 	if (disk_openers(disk) > 0)
 		return;
@@ -1767,12 +1792,14 @@ static void lo_release(struct gendisk *disk)
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
-		__loop_clr_fd(lo);
+	__loop_clr_fd(lo);
 }
=20
 static void lo_free_disk(struct gendisk *disk)
@@ -1791,6 +1818,7 @@ static const struct block_device_operations lo_fops=
 =3D {
 	.owner =3D	THIS_MODULE,
 	.open =3D         lo_open,
 	.release =3D	lo_release,
+	.post_release =3D lo_post_release,
 	.ioctl =3D	lo_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl =3D	lo_compat_ioctl,
