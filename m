Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97EC3BD659
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 19:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255875; cv=none; b=jQCm1k1ktb90+iK0d4NPRatmvsm79RKfWyKdV9bmi8Cm/H+048y1vczOZ5OFfCCLV0OeekBEY7PwL8vXVi/o9aBxNo5XS8PmCwBzy2wyRfETB0iNBkj/KTpbEjlP6w7NvNSYaitsD8OGMlM09KioaOFky4TBkb+OiFfNjRRQzPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255875; c=relaxed/simple;
	bh=HhNfKZ36bJ/Al/+KtFcTf9VkvlJlDzmgFVENrc/p+5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u7vQqdehd7Q6CdG36pADTNTl0rVyVcByz+/gspTTD1WpHC2DJoFY0a/tcsJIEgZWAGqPvcNdXbEDtr9Y0/p3bqgA+PbkZY0UGkZa2xYKe/IZyBMKbHRhZNdG4qvE1m/WDkNt+6V3cBgecPIuUzBr8NQLDhqzx600nfPqHRioRpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=A9pXKP0f; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="A9pXKP0f"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hQvPF31cSzlfqKv;
	Thu, 20 Aug 2026 19:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1787255868; x=1789847869; bh=NK3ge
	/VDE0ew/qB1zT7k25y3aPpNVR+cguiwPdaGO/g=; b=A9pXKP0fJCBxxGg7DRVJa
	+rB7Y2x2fyD/rczcTCY/ZbeoQHWG5S0r5wcqQAT2V4OwK4t6knyi1cwDlXOqJ2Hc
	hv/IxGlCHeRVTJ1VaYAaAT5Sc96p9eOVz7aKDKwMHouWhlsjGG3OsN4I1U7qSleC
	cSUTZ+Iy4K5wK88iLHgEoCgUZwNQ354VPw5JJHl0luKE4pU2ztIqnGKU/gR1Wk3J
	HyT2l77WHZtYA3gYNNgkiX5/napSZyN9xe20yQ1aXRESROL3KsddxmzKCgR4WRpj
	1OZ1HI2zIWug3AWMZ6MerlNeJyBKOhfaQCLVB0w1llD9ngMESiH484LBMWtiWyCr
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0Uuj7mKxXvtR; Thu, 20 Aug 2026 19:57:48 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (148.60.168.34.bc.googleusercontent.com [34.168.60.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hQvP70YMBzlfq9P;
	Thu, 20 Aug 2026 19:57:46 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 05/13] loop: Add more __must_hold() annotations
Date: Thu, 20 Aug 2026 12:57:13 -0700
Message-ID: <7ee40af22f72ebcd3e8f8704e7d181c3b3a0611d.1787255652.git.bvanassche@acm.org>
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

Annotate all functions that are called with lo_mutex held with
__must_hold(&lo->lo_mutex). Add a 'lo' argument to loop_validate_file()
such that a __must_hold(&lo->lo_mutex) annotation can be added to this
function too.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 5c7f72e01345..aa40a6ed7f35 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -145,6 +145,7 @@ static int max_part;
 static int part_shift;
=20
 static loff_t lo_calculate_size(struct loop_device *lo, struct file *fil=
e)
+	__must_hold(&lo->lo_mutex)
 {
 	loff_t loopsize;
 	int ret;
@@ -186,6 +187,7 @@ static loff_t lo_calculate_size(struct loop_device *l=
o, struct file *file)
  * the backing device.
  */
 static bool lo_can_use_dio(struct loop_device *lo)
+	__must_hold(&lo->lo_mutex)
 {
 	if (!(lo->lo_backing_file->f_mode & FMODE_CAN_ODIRECT))
 		return false;
@@ -205,6 +207,7 @@ static bool lo_can_use_dio(struct loop_device *lo)
  * not the originally passed in one.
  */
 static inline void loop_update_dio(struct loop_device *lo)
+	__must_hold(&lo->lo_mutex)
 {
 	lockdep_assert_held(&lo->lo_mutex);
 	WARN_ON_ONCE(lo->lo_state =3D=3D Lo_bound &&
@@ -223,6 +226,7 @@ static inline void loop_update_dio(struct loop_device=
 *lo)
  * a sector_t, eg using loop_validate_size()
  */
 static void loop_set_size(struct loop_device *lo, loff_t size)
+	__must_hold(&lo->lo_mutex)
 {
 	if (!set_capacity_and_notify(lo->lo_disk, size))
 		kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
@@ -455,6 +459,7 @@ static void loop_reread_partitions(struct loop_device=
 *lo)
 }
=20
 static void loop_update_dio_alignment(struct loop_device *lo)
+	__must_hold(&lo->lo_mutex)
 {
 	struct file *file =3D lo->lo_backing_file;
 	struct block_device *sb_bdev =3D file->f_mapping->host->i_sb->s_bdev;
@@ -507,7 +512,9 @@ static inline bool is_loop_device(struct file *file)
 }
=20
 /* Returns 0 if and only if @file is not backed by loop device @bdev. */
-static int loop_validate_file(struct file *file, struct block_device *bd=
ev)
+static int loop_validate_file(struct loop_device *lo, struct file *file,
+			      struct block_device *bdev)
+	__must_hold(&lo->lo_mutex)
 {
 	struct inode	*inode =3D file->f_mapping->host;
 	struct file	*f =3D file;
@@ -535,6 +542,7 @@ static int loop_validate_file(struct file *file, stru=
ct block_device *bdev)
 }
=20
 static void loop_assign_backing_file(struct loop_device *lo, struct file=
 *file)
+	__must_hold(&lo->lo_mutex)
 {
 	lo->lo_backing_file =3D file;
 	lo->old_gfp_mask =3D mapping_gfp_mask(file->f_mapping);
@@ -599,7 +607,7 @@ static int loop_change_fd(struct loop_device *lo, str=
uct block_device *bdev,
 	if (!(lo->lo_flags & LO_FLAGS_READ_ONLY))
 		goto out_err;
=20
-	error =3D loop_validate_file(file, bdev);
+	error =3D loop_validate_file(lo, file, bdev);
 	if (error)
 		goto out_err;
=20
@@ -770,6 +778,7 @@ static void loop_sysfs_exit(struct loop_device *lo)
=20
 static void loop_get_discard_config(struct loop_device *lo,
 				    u32 *granularity, u32 *max_discard_sectors)
+	__must_hold(&lo->lo_mutex)
 {
 	struct file *file =3D lo->lo_backing_file;
 	struct inode *inode =3D file->f_mapping->host;
@@ -936,6 +945,7 @@ static void loop_free_idle_workers_timer(struct timer=
_list *timer)
 static int
 loop_set_status_from_info(struct loop_device *lo,
 			  const struct loop_info64 *info)
+	__must_hold(&lo->lo_mutex)
 {
 	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE)
 		return -EINVAL;
@@ -974,6 +984,7 @@ static unsigned int loop_default_blocksize(struct loo=
p_device *lo)
 }
=20
 static void loop_set_dma_limit(struct loop_device *lo, struct queue_limi=
ts *lim)
+	__must_hold(&lo->lo_mutex)
 {
 	/*
 	 * Direct I/O forwards the user pages to the backing file unchanged, so
@@ -988,6 +999,7 @@ static void loop_set_dma_limit(struct loop_device *lo=
, struct queue_limits *lim)
=20
 static void loop_update_limits(struct loop_device *lo, struct queue_limi=
ts *lim,
 		unsigned int bsize)
+	__must_hold(&lo->lo_mutex)
 {
 	struct file *file =3D lo->lo_backing_file;
 	struct inode *inode =3D file->f_mapping->host;
@@ -1064,7 +1076,7 @@ static int loop_configure(struct loop_device *lo, b=
lk_mode_t mode,
 	if (lo->lo_state !=3D Lo_unbound)
 		goto out_unlock;
=20
-	error =3D loop_validate_file(file, bdev);
+	error =3D loop_validate_file(lo, file, bdev);
 	if (error)
 		goto out_unlock;
=20
@@ -1443,6 +1455,7 @@ loop_get_status64(struct loop_device *lo, struct lo=
op_info64 __user *arg) {
 }
=20
 static int loop_set_capacity(struct loop_device *lo)
+	__must_hold(&lo->lo_mutex)
 {
 	loff_t size;
=20
@@ -1456,6 +1469,7 @@ static int loop_set_capacity(struct loop_device *lo=
)
 }
=20
 static int loop_set_dio(struct loop_device *lo, unsigned long arg)
+	__must_hold(&lo->lo_mutex)
 {
 	bool use_dio =3D !!arg;
 	unsigned int memflags;
