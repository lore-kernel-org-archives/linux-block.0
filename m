Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FC0408630
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 19:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255885; cv=none; b=CEL7mvuPx/lW0TumHy1VZEEZxe7zA0onqKmL+0xvr4gQwXnjShXfjwfdNJ7efjslD/fh9fsWQeW/aWhTWmDrqaPhC2mD2nchrwPHsbf+jtkySJXokrl04u83NUMEHVG/IM7FEq4MWxE0aZaCZI4M3Om29pksBig1HQF1rAX5EOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255885; c=relaxed/simple;
	bh=FdemlE/D63fvfwoZuVQ4//FXMQi2bHQBeHx9NA+LIfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9BVFobO3wsYZOknQlXE+am6s4jf6aMRZXJUTE+xobWdf5ToXZDQCqVFgohT6d34Di5DWDnwdvxagElmuV+qpFMkiP/+GgFy2er2qybILyRqm3Egxbi/TN9OS/BlWGn1asvDlC4mqH9ISMe5kQ8znmuCyp3euViXZRu/cpbh9Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=JsuWB1pY; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="JsuWB1pY"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hQvPR4Zj9zlfq9R;
	Thu, 20 Aug 2026 19:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1787255879; x=1789847880; bh=lSnF2
	8tCm4QwwldrbFHNsXPBJVyD980ZWV6kfqJyWnU=; b=JsuWB1pY2K98BdxZXvOt2
	UV0AKTEuamnMVmH8baFRCYjrHXVcsyx3VSTPH3yEkhhyXvKNAMNApuDWDHRzt7S7
	87FYGKjors7w+p0mfBvs31ac4F68619P4SKN451yfRM1WJzFeYNCzsj0CjYs+54C
	rkKlPy0P5VScyyf0ve92kp+Pb3Y0Q/4ILspBRXwkHR7kVWCxj9nUUpo0q9zPVAmk
	SkZejIDoqzvgTiAhTlo8N4+UlUIbTTDiL02nbL6dcnqv8nJ38BRrcjoruvNO0Fnl
	fbeirfdCnp1yJwiJRrGBScbv8iF1kBFF18SEPoSiJ7N1AGtmYRutzHJOmf5IUdOP
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id EhKUYnR3jcDh; Thu, 20 Aug 2026 19:57:59 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (148.60.168.34.bc.googleusercontent.com [34.168.60.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hQvPL0HBVzlfvpW;
	Thu, 20 Aug 2026 19:57:57 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 10/13] loop: Split loop_configure()
Date: Thu, 20 Aug 2026 12:57:18 -0700
Message-ID: <53467b1efacc57ea68c8d5e4f6f56fb2c2ccf516.1787255652.git.bvanassche@acm.org>
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

Prepare for adding a second __loop_configure() call.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 110 +++++++++++++++++++++++--------------------
 1 file changed, 58 insertions(+), 52 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 5ba4cf435103..cf65d88d73c2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1052,61 +1052,29 @@ static void loop_update_limits(struct loop_device=
 *lo, struct queue_limits *lim,
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
+	__must_hold(&lo->lo_mutex)
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
 	error =3D loop_validate_file(lo, file, bdev);
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
@@ -1117,10 +1085,8 @@ static int loop_configure(struct loop_device *lo, =
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
@@ -1137,7 +1103,7 @@ static int loop_configure(struct loop_device *lo, b=
lk_mode_t mode,
 	/* No need to freeze the queue as the device isn't bound yet. */
 	error =3D queue_limits_commit_update(lo->lo_queue, &lim);
 	if (error)
-		goto out_unlock;
+		return error;
=20
 	/*
 	 * We might switch to direct I/O mode for the loop device, write back
@@ -1155,14 +1121,56 @@ static int loop_configure(struct loop_device *lo,=
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
@@ -1171,8 +1179,6 @@ static int loop_configure(struct loop_device *lo, b=
lk_mode_t mode,
=20
 	return 0;
=20
-out_unlock:
-	loop_global_unlock(lo, is_loop);
 out_bdev:
 	if (!(mode & BLK_OPEN_EXCL))
 		bd_abort_claiming(bdev, loop_configure);
