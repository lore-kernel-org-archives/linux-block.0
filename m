Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325F1374A0F
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 22:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042795; cv=none; b=OWHST0ceWpE+u0uR3YMCCyoLnGbJzjf2jvbVOns9IOTy1O9yJNsfAvUUvzCZ0qkB9lAW+o5bkQNX7/7EAtwUqGsAN8SwRFSqXvDw7oUjFVCkMXG8W8ujE8g4VTl0694LRdsAmHKgD/Lx8kuckcPBu36AjjGuu6hqZMRkGzaTGO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042795; c=relaxed/simple;
	bh=J8ieSYaDIuWJZdu/FiKM64Qwts8gpibvM9443hqzJ0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzcddFpc5rdbnGoa7vXpNR3S69LcvETHnNEx8oHqK8tR7qkt6DiSsx64kaQjPGztj+rbY2XBbpiXm9oBuL1H81ZGhYJb7JfuK7bhdIoL1MH3gkKXz5o9iZSlDPZeViMnbqr7f5HH6Mpmnb1621gXNffLTuKTvMIguyja72XELeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Xi1f00ga; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Xi1f00ga"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gZjfx3cctzlh2s0;
	Tue,  9 Jun 2026 22:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1781042789; x=1783634790; bh=tsBMF
	4J68jmkvsPGBXPK7xZ7XbRz36jxSL5EkPfpcwg=; b=Xi1f00ga9UGjS9nM6uk6m
	qdJEN4rB6HNp2vgg0uR1W0crTMOVFhJB4TEpWVYwmm/hwlYQ1dY4qTPr0CZJlp6/
	/gW76BXf9qaruFcD8QBbRFvDoYG3c//W5n6Y1Sg7IE2DlUbqqhBG7rhCt6OoNNAD
	uEePpNS0SlmsynJ7nCnor2edA3BHOK+gVJGLuywL77qzJG6rgaCL9OuFSDi1IkNd
	+pXFbDdtaVMjGCQ6eS2rBznFOBLEfx0ks8i5PBy8Te72f/1MA9TSu1QroCcB0swD
	ZU56WyZY7gSh2NbhOrPkjXRLDCvroOZaROTOfVmWQPDZySbFIXBqWCTg10L0SZnP
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0j3eaSDAjYfT; Tue,  9 Jun 2026 22:06:29 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gZjfr0VfRzlgyH5;
	Tue,  9 Jun 2026 22:06:27 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 17/27] loop: Remove the "bool global" function argument
Date: Tue,  9 Jun 2026 15:05:04 -0700
Message-ID: <088eb361d78d4a2cc5ca03072a3efbc5d3099c9b.1781042470.git.bvanassche@acm.org>
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

Keep the behavior in loop_global_lock_killable() for the global =3D=3D tr=
ue
case. Expand loop_global_lock_killable(lo, false) calls into a
mutex_lock_killable() and a mutex_unlock() call.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 67 ++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 27 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 80fdb0dee268..1a33536000e0 100644
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
@@ -596,11 +591,19 @@ static int loop_change_fd(struct loop_device *lo, s=
truct block_device *bdev,
 	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
=20
 	is_loop =3D is_loop_device(file);
-	error =3D loop_global_lock_killable(lo, is_loop);
-	if (error)
-		goto out_putf;
-	error =3D __loop_change_fd(lo, bdev, file, &old_file, &partscan);
-	loop_global_unlock(lo, is_loop);
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
=20
@@ -1095,11 +1098,21 @@ static int loop_configure(struct loop_device *lo,=
 blk_mode_t mode,
 			goto out_putf;
 	}
=20
-	error =3D loop_global_lock_killable(lo, is_loop);
-	if (error)
-		goto out_bdev;
-	error =3D __loop_configure(lo, mode, bdev, config, file, &partscan);
-	loop_global_unlock(lo, is_loop);
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
 	if (error)
 		goto out_bdev;
 	if (partscan)
@@ -1210,11 +1223,11 @@ static int loop_clr_fd(struct loop_device *lo)
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
@@ -1226,7 +1239,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	lo->lo_flags |=3D LO_FLAGS_AUTOCLEAR;
 	if (disk_openers(lo->lo_disk) =3D=3D 1)
 		WRITE_ONCE(lo->lo_state, Lo_rundown);
-	loop_global_unlock(lo, true);
+	loop_global_unlock(lo);
=20
 	return 0;
 }
