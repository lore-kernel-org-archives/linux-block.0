Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD9B24BD03
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 22:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042792; cv=none; b=DKADB/QX+ShQB8u4eu3uBbgCW5wKu6ZSjZqVRapEWDnqIUYa5VI/Sc/tiLYBNHIe0+sSPp66wJkKcwNeIBQXKICaiynXUUs/aI2rzsX+i60aa6rsIFCTZzCqnLqzlRPFH9z+NR9IKbGN9PnyZDaakw7macwkdALj5rNTCw+KoU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042792; c=relaxed/simple;
	bh=7NIIAUSQ3iiOtQv+Zhaaw3m8c7PVFWKR7ExGNI+ggao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNZP144Zoqj8SqM/9kfYOGhFmFM0raO3HXJ8TnMNDxCbOcfMikuanuzwlCsH490DOnohCPEeYlFQVFrhvKX8DDZtceQwbZY2D7rTJvrUUnzheWoyJ7MpFyma6MxTdEwPzU6lO4+Jxe42BfhMJywXK8CMcFN+KrCGb8mWkZg6u1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=b6hvuyVh; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="b6hvuyVh"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gZjft2npNzlh2rj;
	Tue,  9 Jun 2026 22:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1781042785; x=1783634786; bh=92E2+
	XcRm7LE6ho3kONtEkcqFsdL9Cvpxv9GApYbc68=; b=b6hvuyVhZxzWN2gbBgviG
	PFg0hg0hoQoTNmNCkOH0m8y1FGhXwYCYDw3C9bsfk6ajgHARxwYxMVu9hxACQbtW
	1u2lwaktRd3lhWrUsnQqkyv59ZngSKblZZz8P3xcpk701A/tGjNlsetocc+7Ckt6
	Fw+/PXlX8OzbUhlIHQjlm32CsPyQmwN1tWLsd8LX0c4iDR1Y4sonW4TZCdphjju1
	WUp4PWBC8ZkSWyIlaeRiNMRrXQyhW4bvJUzwNC/zeQLa0OI2bOouhmJTeheYotb2
	V5aji92Xc6BQymtCMcFpaapvDREJGCyvVgX7hobtaPJsZjUogVs8PvvedYo1Ak4V
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id veONb_VByCYj; Tue,  9 Jun 2026 22:06:25 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gZjfm4WPVzlfdCs;
	Tue,  9 Jun 2026 22:06:24 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 15/27] loop: Split loop_change_fd()
Date: Tue,  9 Jun 2026 15:05:02 -0700
Message-ID: <f835863049bc0364d80c69a7eeb9514e2a698ae2.1781042470.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
In-Reply-To: <cover.1781042470.git.bvanassche@acm.org>
References: <cover.1781042470.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for adding a second call of __loop_change_fd().

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 85 ++++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 39 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 310de0463beb..6fbea0af144f 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -523,6 +523,49 @@ static int loop_check_backing_file(struct file *file=
)
 	return 0;
 }
=20
+static int __loop_change_fd(struct loop_device *lo, struct block_device =
*bdev,
+			    struct file *file, struct file **old_file,
+			    bool *partscan)
+{
+	unsigned int memflags;
+	int error;
+
+	if (lo->lo_state !=3D Lo_bound)
+		return -ENXIO;
+
+	/* the loop device has to be read-only */
+	if (!(lo->lo_flags & LO_FLAGS_READ_ONLY))
+		return -EINVAL;
+
+	error =3D loop_validate_file(file, bdev);
+	if (error)
+		return error;
+
+	*old_file =3D lo->lo_backing_file;
+
+	/* size of the new backing store needs to be the same */
+	if (lo_calculate_size(lo, file) !=3D lo_calculate_size(lo, *old_file))
+		return -EINVAL;
+
+	/*
+	 * We might switch to direct I/O mode for the loop device, write back
+	 * all dirty data the page cache now that so that the individual I/O
+	 * operations don't have to do that.
+	 */
+	vfs_fsync(file, 0);
+
+	/* and ... switch */
+	disk_force_media_change(lo->lo_disk);
+	memflags =3D blk_mq_freeze_queue(lo->lo_queue);
+	mapping_set_gfp_mask((*old_file)->f_mapping, lo->old_gfp_mask);
+	loop_assign_backing_file(lo, file);
+	loop_update_dio(lo);
+	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
+	*partscan =3D lo->lo_flags & LO_FLAGS_PARTSCAN;
+
+	return 0;
+}
+
 /*
  * loop_change_fd switched the backing store of a loopback device to
  * a new file. This is useful for operating system installers to free up
@@ -536,7 +579,6 @@ static int loop_change_fd(struct loop_device *lo, str=
uct block_device *bdev,
 {
 	struct file *file =3D fget(arg);
 	struct file *old_file;
-	unsigned int memflags;
 	int error;
 	bool partscan;
 	bool is_loop;
@@ -557,43 +599,10 @@ static int loop_change_fd(struct loop_device *lo, s=
truct block_device *bdev,
 	error =3D loop_global_lock_killable(lo, is_loop);
 	if (error)
 		goto out_putf;
-	error =3D -ENXIO;
-	if (lo->lo_state !=3D Lo_bound)
-		goto out_err;
-
-	/* the loop device has to be read-only */
-	error =3D -EINVAL;
-	if (!(lo->lo_flags & LO_FLAGS_READ_ONLY))
-		goto out_err;
-
-	error =3D loop_validate_file(file, bdev);
-	if (error)
-		goto out_err;
-
-	old_file =3D lo->lo_backing_file;
-
-	error =3D -EINVAL;
-
-	/* size of the new backing store needs to be the same */
-	if (lo_calculate_size(lo, file) !=3D lo_calculate_size(lo, old_file))
-		goto out_err;
-
-	/*
-	 * We might switch to direct I/O mode for the loop device, write back
-	 * all dirty data the page cache now that so that the individual I/O
-	 * operations don't have to do that.
-	 */
-	vfs_fsync(file, 0);
-
-	/* and ... switch */
-	disk_force_media_change(lo->lo_disk);
-	memflags =3D blk_mq_freeze_queue(lo->lo_queue);
-	mapping_set_gfp_mask(old_file->f_mapping, lo->old_gfp_mask);
-	loop_assign_backing_file(lo, file);
-	loop_update_dio(lo);
-	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
-	partscan =3D lo->lo_flags & LO_FLAGS_PARTSCAN;
+	error =3D __loop_change_fd(lo, bdev, file, &old_file, &partscan);
 	loop_global_unlock(lo, is_loop);
+	if (error)
+		goto out_putf;
=20
 	/*
 	 * Flush loop_validate_file() before fput(), for l->lo_backing_file
@@ -618,8 +627,6 @@ static int loop_change_fd(struct loop_device *lo, str=
uct block_device *bdev,
 	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 	return error;
=20
-out_err:
-	loop_global_unlock(lo, is_loop);
 out_putf:
 	fput(file);
 	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
