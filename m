Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C853F1AA1
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 22:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042793; cv=none; b=YgVdL2qbmIH17Qj9EsiSm8kEeh8eLlwM7GKaTSlw55hai8brovGfWB9uoQu/3gzO4WatUslnwExL0NIT+k6BdF3zMVLtsJfCl3nM8Xs/6KZ2EBFojoS4UUmJRXjLTQlyklHnkr9bOi7MQ8k+DK1st2O+oRc3Dxt7sCw+kFD/Jxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042793; c=relaxed/simple;
	bh=cX2puecmAf3eyTzCx5/GlKbIcd4FEEspo1QtUBjQ2SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGczV57VafWL9H9bMc2xh5SHmj0NhWUoxdm7C8nbZ43plbtX4Hc6rzy0tcoPLHazVzO95WLKG8Oa7vxHVvQK2bRIPzFKiU/unFXvNDrL0K5h5etkGvE99gHBdieLoelMbR4A21LYDtSqUy4r58Ae+0MyqwOmwOjpNaz4y3w94wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ejOiWwsH; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ejOiWwsH"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gZjfw0GnfzlfdCs;
	Tue,  9 Jun 2026 22:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1781042787; x=1783634788; bh=cp1oZ
	UjksmoVYKzC68jo1+ZOZm1ITlFRZ9t3dERjllo=; b=ejOiWwsHBjim7dLj2CIug
	ZzYjJJSoq7pLzFXE3C3aEYPOuVm9/N3rkDDGtbERlonY9Rmss76qinQpy3zlBrps
	rnuCSa55uxD3QFI/vq/BjvrelRqbxXf8iDsGFtwmoBxX2IadvaN+dN3otG7SdlJ2
	CajAD6JzhM7goA1K8xUN0f7bNRL0fguYTGhktXVCeScmSmpYqx55b0rDRYo2qD02
	ol1zlmbaM+fyhZZk+25dAL0TgXe0vmr/WPIvEWKu1kW/qyEPiPgwE5Mw7W1E3pUo
	dFVCDET3/5vprRhzbp9VDqU50FlkKPN0qQWrVKUCWHW8JSXF8fxPlA0AzfKbsf1y
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ArvxauE1dErn; Tue,  9 Jun 2026 22:06:27 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gZjfp2dB5zlfddT;
	Tue,  9 Jun 2026 22:06:26 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 16/27] loop: Split loop_configure()
Date: Tue,  9 Jun 2026 15:05:03 -0700
Message-ID: <f001b652198021d586af28c4c2c27be4b1824f3d.1781042470.git.bvanassche@acm.org>
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

Prepare for adding a second __loop_configure() call.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 109 ++++++++++++++++++++++---------------------
 1 file changed, 57 insertions(+), 52 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6fbea0af144f..80fdb0dee268 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -981,61 +981,28 @@ static void loop_update_limits(struct loop_device *=
lo, struct queue_limits *lim,
 		lim->discard_granularity =3D 0;
 }
=20
-static int loop_configure(struct loop_device *lo, blk_mode_t mode,
-			  struct block_device *bdev,
-			  const struct loop_config *config)
+static int __loop_configure(struct loop_device *lo, blk_mode_t mode,
+			    struct block_device *bdev,
+			    const struct loop_config *config, struct file *file,
+			    bool *partscan)
 {
-	struct file *file =3D fget(config->fd);
 	struct queue_limits lim;
-	int error;
 	loff_t size;
-	bool partscan;
-	bool is_loop;
-
-	if (!file)
-		return -EBADF;
-
-	error =3D loop_check_backing_file(file);
-	if (error) {
-		fput(file);
-		return error;
-	}
-
-	is_loop =3D is_loop_device(file);
-
-	/* This is safe, since we have a reference from open(). */
-	__module_get(THIS_MODULE);
-
-	/*
-	 * If we don't hold exclusive handle for the device, upgrade to it
-	 * here to avoid changing device under exclusive owner.
-	 */
-	if (!(mode & BLK_OPEN_EXCL)) {
-		error =3D bd_prepare_to_claim(bdev, loop_configure, NULL);
-		if (error)
-			goto out_putf;
-	}
-
-	error =3D loop_global_lock_killable(lo, is_loop);
-	if (error)
-		goto out_bdev;
+	int error;
=20
-	error =3D -EBUSY;
 	if (lo->lo_state !=3D Lo_unbound)
-		goto out_unlock;
+		return -EBUSY;
=20
 	error =3D loop_validate_file(file, bdev);
 	if (error)
-		goto out_unlock;
+		return error;
=20
-	if ((config->info.lo_flags & ~LOOP_CONFIGURE_SETTABLE_FLAGS) !=3D 0) {
-		error =3D -EINVAL;
-		goto out_unlock;
-	}
+	if ((config->info.lo_flags & ~LOOP_CONFIGURE_SETTABLE_FLAGS) !=3D 0)
+		return -EINVAL;
=20
 	error =3D loop_set_status_from_info(lo, &config->info);
 	if (error)
-		goto out_unlock;
+		return error;
 	lo->lo_flags =3D config->info.lo_flags;
=20
 	if (!(file->f_mode & FMODE_WRITE) || !(mode & BLK_OPEN_WRITE) ||
@@ -1046,10 +1013,8 @@ static int loop_configure(struct loop_device *lo, =
blk_mode_t mode,
 		lo->workqueue =3D alloc_workqueue("loop%d",
 						WQ_UNBOUND | WQ_FREEZABLE,
 						0, lo->lo_number);
-		if (!lo->workqueue) {
-			error =3D -ENOMEM;
-			goto out_unlock;
-		}
+		if (!lo->workqueue)
+			return -ENOMEM;
 	}
=20
 	/* suppress uevents while reconfiguring the device */
@@ -1066,7 +1031,7 @@ static int loop_configure(struct loop_device *lo, b=
lk_mode_t mode,
 	/* No need to freeze the queue as the device isn't bound yet. */
 	error =3D queue_limits_commit_update(lo->lo_queue, &lim);
 	if (error)
-		goto out_unlock;
+		return error;
=20
 	/*
 	 * We might switch to direct I/O mode for the loop device, write back
@@ -1087,14 +1052,56 @@ static int loop_configure(struct loop_device *lo,=
 blk_mode_t mode,
 	WRITE_ONCE(lo->lo_state, Lo_bound);
 	if (part_shift)
 		lo->lo_flags |=3D LO_FLAGS_PARTSCAN;
-	partscan =3D lo->lo_flags & LO_FLAGS_PARTSCAN;
-	if (partscan)
+	*partscan =3D lo->lo_flags & LO_FLAGS_PARTSCAN;
+	if (*partscan)
 		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
=20
 	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
 	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
=20
+	return 0;
+}
+
+static int loop_configure(struct loop_device *lo, blk_mode_t mode,
+			  struct block_device *bdev,
+			  const struct loop_config *config)
+{
+	struct file *file =3D fget(config->fd);
+	int error;
+	bool partscan;
+	bool is_loop;
+
+	if (!file)
+		return -EBADF;
+
+	error =3D loop_check_backing_file(file);
+	if (error) {
+		fput(file);
+		return error;
+	}
+
+	is_loop =3D is_loop_device(file);
+
+	/* This is safe, since we have a reference from open(). */
+	__module_get(THIS_MODULE);
+
+	/*
+	 * If we don't hold exclusive handle for the device, upgrade to it
+	 * here to avoid changing device under exclusive owner.
+	 */
+	if (!(mode & BLK_OPEN_EXCL)) {
+		error =3D bd_prepare_to_claim(bdev, loop_configure, NULL);
+		if (error)
+			goto out_putf;
+	}
+
+	error =3D loop_global_lock_killable(lo, is_loop);
+	if (error)
+		goto out_bdev;
+	error =3D __loop_configure(lo, mode, bdev, config, file, &partscan);
 	loop_global_unlock(lo, is_loop);
+	if (error)
+		goto out_bdev;
 	if (partscan)
 		loop_reread_partitions(lo);
=20
@@ -1103,8 +1110,6 @@ static int loop_configure(struct loop_device *lo, b=
lk_mode_t mode,
=20
 	return 0;
=20
-out_unlock:
-	loop_global_unlock(lo, is_loop);
 out_bdev:
 	if (!(mode & BLK_OPEN_EXCL))
 		bd_abort_claiming(bdev, loop_configure);
