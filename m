Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C96408630
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 19:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255888; cv=none; b=WuQ7WpljZg1WqRx6Bb9Ig/vw6fNfKixES3tB74ze5WF40LsQ4GtSnyBm257xohHEm1WZWRHdb0hpvZEEbkJlHr2EwU8eaWP4c7qKoIVzIM22zZF7UyVN0ZKThw+OkVhPQyEWL+PmNtDw2V0A8QPPM2/PelXohlEq1m4NIvPGqy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255888; c=relaxed/simple;
	bh=pr9ZvrDvki+Uy47LhGJLHqZ46I2cEXi7ExGQMaBKWHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rolRenH8Zl/Pgvwve+geMUIeY7vfsAmyl6faG67kAh0SYYE5WwtCmyaU7fs6mUr63i2sFy0gyhmg6cKxw2+nvnQ1Re0u9gie2fntYFXjD7TcWu3p852TLV76bI9k8LRFVWldIRjiyoRJ7X3U/PTo7xiRWaZPg53jdBrcRTA5yS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=H2EByAvx; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="H2EByAvx"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hQvPV11GkzlfqKv;
	Thu, 20 Aug 2026 19:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1787255881; x=1789847882; bh=6fa1N
	wn60FqYeGY8ZTJ4/uEgeQfn4lc84SnOMekKf1Y=; b=H2EByAvxJ3zH65CPNi46L
	yA9KZW+QtMdbgTRdHc/Dpuf76TaFStlUqyyk5uHSvzihCFR8yXk4ol6bpnwm7R/d
	80C9tv8oRVbBhvOv1pHGNaZMv6RKvfNfZu4hjLWEZY7QGEfL/WfWOe9r3Se3n4qs
	PfFrp3QESjceeICnGie4E8/6DjIObB4xfvhgCrKtYHDD654FDHEj+6XbE8dgE7fr
	ORPqIIePuFB0poL+T9O1Tz+PxSezfzdcjapag7nkecH4CxynXaGZkMXHo4mO4zHX
	l8HoZS0dkoJAVuM6RRO26Fl8Tf2NIFcNDfjaCESuWYu3i7GWip+Jn8WbkjCN8Ny5
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id qLLKCMDoPHhX; Thu, 20 Aug 2026 19:58:01 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (148.60.168.34.bc.googleusercontent.com [34.168.60.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hQvPN161pzlfsTm;
	Thu, 20 Aug 2026 19:57:59 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 11/13] loop: Remove the "bool global" function argument
Date: Thu, 20 Aug 2026 12:57:19 -0700
Message-ID: <9523d8b685058b2fd761010ebc9efc623a087486.1787255652.git.bvanassche@acm.org>
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

Keep the behavior in loop_global_lock_killable() for the global =3D=3D tr=
ue
case. Expand loop_global_lock_killable(lo, false) calls into a
mutex_lock_killable() and a mutex_unlock() call.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 71 ++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 29 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cf65d88d73c2..8fde5f2d3473 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -100,27 +100,24 @@ static DEFINE_MUTEX(loop_validate_mutex);
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
+	__cond_acquires(0, &loop_validate_mutex)
 	__cond_acquires(0, &lo->lo_mutex)
-	__context_unsafe(conditional locking)
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
@@ -129,15 +126,13 @@ static int loop_global_lock_killable(struct loop_de=
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
 	__releases(&lo->lo_mutex)
-	__context_unsafe(conditional locking)
+	__releases(&loop_validate_mutex)
 {
 	mutex_unlock(&lo->lo_mutex);
-	if (global)
-		mutex_unlock(&loop_validate_mutex);
+	mutex_unlock(&loop_validate_mutex);
 }
=20
 static int max_part;
@@ -650,11 +645,19 @@ static int loop_change_fd(struct loop_device *lo, s=
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
@@ -1164,11 +1167,21 @@ static int loop_configure(struct loop_device *lo,=
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
@@ -1275,11 +1288,11 @@ static int loop_clr_fd(struct loop_device *lo)
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
@@ -1291,7 +1304,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	lo->lo_flags |=3D LO_FLAGS_AUTOCLEAR;
 	if (disk_openers(lo->lo_disk) =3D=3D 1)
 		WRITE_ONCE(lo->lo_state, Lo_rundown);
-	loop_global_unlock(lo, true);
+	loop_global_unlock(lo);
=20
 	return 0;
 }
