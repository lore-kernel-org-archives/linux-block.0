Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D9A469842
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441559; cv=none; b=u5wL1BpCBelrfc6QRCesftr0l3AguJaMBtgTyFFPFe+CXF7WXAeT3QUJzt3VfBeIN8tk544QsZd/SaQxoXVppJV2/PwxvNRZn/Lg7I0xrgnFwNTHudyiQrcqJsd3asu4S4m1hNFKzY2wC2KZ/rxw7hRnaB4XJle++otBKdefpwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441559; c=relaxed/simple;
	bh=0xcAtRvMdroJQTCEK9I9JSdHl8Qsbk7r7nAJe2WeEsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eD9uFp7ellFyfRS46l0y9vpJqT5bHKjJE/DqgF908iQ5aqJRkk2ayBZxMmTyMCS+AwCS7pnpLDw6PfwHNd5ywT4x9Dw9fChiY1Xcg1AoUm1nklICeFVcaYFzJQt3PKSt+ochYFBmHLBNtcCq0rF40gdBpV6TUD0ZmlupWU46bEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Ld4KVAUL; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Ld4KVAUL"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hB0QW2xgNzlfvpx;
	Thu, 30 Jul 2026 19:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1785441543; x=1788033544; bh=3P3LP
	zI0VkxNffgbD0+clc36g+yudB8p+1gOMs+hw4A=; b=Ld4KVAULw3ciSCclWE/GD
	iUvwCucAEDvs5YcJqyFXHuwi33K72EQ2q02Jsjlb2WyyGR2mU/pCayTcJeLaduBc
	0hKfjQbRo0gz2B7G3M8ngBWD3ufVwcf4v6F91scseiShbgUhoun9t5d+BCIeTzcE
	9yjra7UEnaPha2+QElgtieGIZsqb3luEkiKVPfwvessqUbzxH7jemrWI+BNofxhE
	AIRsbKRefCZhmaeDMak+tJXLtpOYJfngTsCyxgnQ3d8g4voVupX3uvkNZA8YS2jS
	eiNJFJoN88yMGLPphFO5IW5G8LC/dEKzO0ZjCQuo0Dpo8oHTduGuXIhwQOFv49Wk
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id JEYLmC3kbTlY; Thu, 30 Jul 2026 19:59:03 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hB0QD6d8BzlfpLr;
	Thu, 30 Jul 2026 19:59:00 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Haris Iqbal <haris.iqbal@linux.dev>
Subject: [PATCH v2 02/12] loop: Remove the "bool global" function argument
Date: Thu, 30 Jul 2026 12:58:25 -0700
Message-ID: <d5142cf35b04e88939c4aed2debf6f3716d540ae.1785440858.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <cover.1785440858.git.bvanassche@acm.org>
References: <cover.1785440858.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Move the code that is protected by a mutex from loop_change_fd() into
__loop_change_fd(). Move the code that is protected by a mutex from
loop_configure() into __loop_configure(). Keep the behavior in
loop_global_lock_killable() for the global =3D=3D true case. Expand
loop_global_lock_killable(lo, false) calls into a mutex_lock_killable()
and a mutex_unlock() call. This patch prepares for adding lock context
annotations.

Cc: Haris Iqbal <haris.iqbal@linux.dev>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 249 ++++++++++++++++++++++++-------------------
 1 file changed, 138 insertions(+), 111 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1faecef33009..a71fe763c933 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -98,25 +98,22 @@ static DEFINE_MUTEX(loop_validate_mutex);
  * loop_global_lock_killable() - take locks for safe loop_validate_file(=
) test
  *
  * @lo: struct loop_device
- * @global: true if @lo is about to bind another "struct loop_device", f=
alse otherwise
  *
  * Returns 0 on success, -EINTR otherwise.
  *
- * Since loop_validate_file() traverses on other "struct loop_device" if
- * is_loop_device() is true, we need a global lock for serializing concu=
rrent
+ * Since loop_validate_file() traverses on other "struct loop_device", w=
e need a
+ * global lock for serializing concurrent
  * loop_configure()/loop_change_fd()/__loop_clr_fd() calls.
  */
-static int loop_global_lock_killable(struct loop_device *lo, bool global=
)
+static int loop_global_lock_killable(struct loop_device *lo)
 {
 	int err;
=20
-	if (global) {
-		err =3D mutex_lock_killable(&loop_validate_mutex);
-		if (err)
-			return err;
-	}
+	err =3D mutex_lock_killable(&loop_validate_mutex);
+	if (err)
+		return err;
 	err =3D mutex_lock_killable(&lo->lo_mutex);
-	if (err && global)
+	if (err)
 		mutex_unlock(&loop_validate_mutex);
 	return err;
 }
@@ -125,13 +122,11 @@ static int loop_global_lock_killable(struct loop_de=
vice *lo, bool global)
  * loop_global_unlock() - release locks taken by loop_global_lock_killab=
le()
  *
  * @lo: struct loop_device
- * @global: true if @lo was about to bind another "struct loop_device", =
false otherwise
  */
-static void loop_global_unlock(struct loop_device *lo, bool global)
+static void loop_global_unlock(struct loop_device *lo)
 {
 	mutex_unlock(&lo->lo_mutex);
-	if (global)
-		mutex_unlock(&loop_validate_mutex);
+	mutex_unlock(&loop_validate_mutex);
 }
=20
 static int max_part;
@@ -523,6 +518,50 @@ static int loop_check_backing_file(struct file *file=
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
@@ -536,7 +575,6 @@ static int loop_change_fd(struct loop_device *lo, str=
uct block_device *bdev,
 {
 	struct file *file =3D fget(arg);
 	struct file *old_file;
-	unsigned int memflags;
 	int error;
 	bool partscan;
 	bool is_loop;
@@ -554,46 +592,21 @@ static int loop_change_fd(struct loop_device *lo, s=
truct block_device *bdev,
 	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
=20
 	is_loop =3D is_loop_device(file);
-	error =3D loop_global_lock_killable(lo, is_loop);
+	if (is_loop) {
+		error =3D loop_global_lock_killable(lo);
+		if (error)
+			goto out_putf;
+		error =3D __loop_change_fd(lo, bdev, file, &old_file, &partscan);
+		loop_global_unlock(lo);
+	} else {
+		error =3D mutex_lock_killable(&lo->lo_mutex);
+		if (error)
+			goto out_putf;
+		error =3D __loop_change_fd(lo, bdev, file, &old_file, &partscan);
+		mutex_unlock(&lo->lo_mutex);
+	}
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
-	loop_global_unlock(lo, is_loop);
=20
 	/*
 	 * Flush loop_validate_file() before fput(), for l->lo_backing_file
@@ -618,8 +631,6 @@ static int loop_change_fd(struct loop_device *lo, str=
uct block_device *bdev,
 	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 	return error;
=20
-out_err:
-	loop_global_unlock(lo, is_loop);
 out_putf:
 	fput(file);
 	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
@@ -974,61 +985,29 @@ static void loop_update_limits(struct loop_device *=
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
@@ -1039,10 +1018,8 @@ static int loop_configure(struct loop_device *lo, =
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
@@ -1059,7 +1036,7 @@ static int loop_configure(struct loop_device *lo, b=
lk_mode_t mode,
 	/* No need to freeze the queue as the device isn't bound yet. */
 	error =3D queue_limits_commit_update(lo->lo_queue, &lim);
 	if (error)
-		goto out_unlock;
+		return error;
=20
 	/*
 	 * We might switch to direct I/O mode for the loop device, write back
@@ -1080,14 +1057,66 @@ static int loop_configure(struct loop_device *lo,=
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
-	loop_global_unlock(lo, is_loop);
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
+	if (is_loop) {
+		error =3D loop_global_lock_killable(lo);
+		if (error)
+			goto out_bdev;
+		error =3D __loop_configure(lo, mode, bdev, config, file,
+					 &partscan);
+		loop_global_unlock(lo);
+	} else {
+		error =3D mutex_lock_killable(&lo->lo_mutex);
+		if (error)
+			goto out_bdev;
+		error =3D __loop_configure(lo, mode, bdev, config, file,
+					 &partscan);
+		mutex_unlock(&lo->lo_mutex);
+	}
+	if (error)
+		goto out_bdev;
 	if (partscan)
 		loop_reread_partitions(lo);
=20
@@ -1096,8 +1125,6 @@ static int loop_configure(struct loop_device *lo, b=
lk_mode_t mode,
=20
 	return 0;
=20
-out_unlock:
-	loop_global_unlock(lo, is_loop);
 out_bdev:
 	if (!(mode & BLK_OPEN_EXCL))
 		bd_abort_claiming(bdev, loop_configure);
@@ -1194,11 +1221,11 @@ static int loop_clr_fd(struct loop_device *lo)
 	 * which loop_configure()/loop_change_fd() found via fget() was this
 	 * loop device.
 	 */
-	err =3D loop_global_lock_killable(lo, true);
+	err =3D loop_global_lock_killable(lo);
 	if (err)
 		return err;
 	if (lo->lo_state !=3D Lo_bound) {
-		loop_global_unlock(lo, true);
+		loop_global_unlock(lo);
 		return -ENXIO;
 	}
 	/*
@@ -1210,7 +1237,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	lo->lo_flags |=3D LO_FLAGS_AUTOCLEAR;
 	if (disk_openers(lo->lo_disk) =3D=3D 1)
 		WRITE_ONCE(lo->lo_state, Lo_rundown);
-	loop_global_unlock(lo, true);
+	loop_global_unlock(lo);
=20
 	return 0;
 }
