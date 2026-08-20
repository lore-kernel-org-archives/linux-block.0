Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB453E7BA0
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 19:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255883; cv=none; b=jv9GS0NcXf6r7S1cxmnWFbpJfFaeoUbuTBN6hQVZYtKSfzytuGVPbhaCLP5mgi/d+PCo2N64aYqeDU3pObCYYfqweq6g7jEf8W4LqPmRKrcI3tvAH52x4dTVvYlq2IMQzI7zU6X3UmXFHkhZvTdzv3Gu1pBFI9n9SekG3hXppl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255883; c=relaxed/simple;
	bh=rvQoVHycu79FV/gSSwi/+ycFzS3LTTG4rfsYc7DmaPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKt3AmRdwdGiqQF7CrRB2haXk6QBC/TUyDNIu1IRaVHXdf78KYMzvwrVflIY8dSkOejTwwgmYHFtz8E48gRxwrh9aE5oRiOkB1E1sum5prACALAESEEjxBH1uGXH4YSl2usZC5M5BZDe6Oqtq91WLOAe83NgAqQnH6QP2O5HXJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=tkVhOIgX; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="tkVhOIgX"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hQvPP2pYHzlfq9P;
	Thu, 20 Aug 2026 19:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1787255877; x=1789847878; bh=m/FzT
	quW67bo8xtcdO5PVOl16775SyPH2BWO8lMjPiI=; b=tkVhOIgXZmuUFTUm9YzhI
	at6YLo2af1XWyLa1ZMtKk63fNNJ08de3st1e0+JVv56xShWlHQmAL4wIPYXPn5/7
	YaJA+GNXH4L8iRNutt8IR+ByBt4EmDSrtXe7hU/ehu5LBls0r4vwP9yhMq8xZzG1
	HP6WP/retsajbIU8CObob3y9Co9FS0OI/b1LzX50EnOnf7KCJ5+mzNqBYU936pum
	hbdDlss1bgjmXidMb8C9jMHDvQj/cRA0jQUh4Tz5Dz7ciLQg9y+ymXNtvJ+YvgYM
	MY8UDp1PHVjir1YqovTgnqRbnUlY1ov/oXdQyopIjVSd29Et5MC5KIxK/JXwc4Am
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id lZwW-OpG3ldY; Thu, 20 Aug 2026 19:57:57 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (148.60.168.34.bc.googleusercontent.com [34.168.60.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hQvPH6jL6zlfsVF;
	Thu, 20 Aug 2026 19:57:55 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 09/13] loop: Split loop_change_fd()
Date: Thu, 20 Aug 2026 12:57:17 -0700
Message-ID: <917d78a53754334a26b63490bb72c8776312099d.1787255652.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
In-Reply-To: <cover.1787255652.git.bvanassche@acm.org>
References: <cover.1787255652.git.bvanassche@acm.org>
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
 drivers/block/loop.c | 86 ++++++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 39 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 93b589bc6e3d..5ba4cf435103 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -576,6 +576,50 @@ static int loop_check_backing_file(struct file *file=
)
 	return 0;
 }
=20
+static int __loop_change_fd(struct loop_device *lo, struct block_device =
*bdev,
+			    struct file *file, struct file **old_file,
+			    bool *partscan)
+	__must_hold(&lo->lo_mutex)
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
+	error =3D loop_validate_file(lo, file, bdev);
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
@@ -589,7 +633,6 @@ static int loop_change_fd(struct loop_device *lo, str=
uct block_device *bdev,
 {
 	struct file *file =3D fget(arg);
 	struct file *old_file;
-	unsigned int memflags;
 	int error;
 	bool partscan;
 	bool is_loop;
@@ -610,43 +653,10 @@ static int loop_change_fd(struct loop_device *lo, s=
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
-	error =3D loop_validate_file(lo, file, bdev);
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
@@ -671,8 +681,6 @@ static int loop_change_fd(struct loop_device *lo, str=
uct block_device *bdev,
 	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 	return error;
=20
-out_err:
-	loop_global_unlock(lo, is_loop);
 out_putf:
 	fput(file);
 	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
