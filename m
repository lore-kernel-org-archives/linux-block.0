Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B5C408630
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 19:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255881; cv=none; b=HiKuEJTLACLB+in1vYGfQAF8UNub/QuGG/XXccHKwMsLc16/3i9uVIyF2earyMULj6/v7zPK7dTd07O45d0miCD18T38WZuj0x8E/5Ne/IWaS7GVjkCu7pLAnXoz5nbuwu6GBN1yb3zlpY5BCwUTQkhLg/5rgF9ACR4AyYXth50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255881; c=relaxed/simple;
	bh=I8RkNWSpVzcWnem7YKxE5qLPKzCRgyMO61A99lng1OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlkZtzod4w1W24kRsoB2lRtt1Fg1gvg/RegcwVBt7yXVJVCfXBZ31zXz9rjU+KKIUvCu91sCsJ2iPTQP5Jyk3MflpWOFj/v5Y6EYu7CwcAj7skIFq9njtaRJh989mi96GUjmmaxPoOte8WcVnAcqhbaAxGTLjP4RkUizAGj0vjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=tQ+N2mx3; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="tQ+N2mx3"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hQvPJ2JXHzlfq9s;
	Thu, 20 Aug 2026 19:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1787255872; x=1789847873; bh=rtPkI
	qgkJD8iXWqaEwKiruaotFa2KML0Kr1H6VSxjD8=; b=tQ+N2mx3nWe37wEBaCDjW
	nhEMZvBhyR5AaeIc5LbPT/Kfqqllqyet3K1LbujQupAFku7O7kjaSs3fXONS05J/
	jr9W+mf2ZDVvke92ZYHqaTjHrvfPYBpX72PdvvC72nkb2rvT5u7BtSFETzDGdMZ5
	JkK8W8ea0WKVTbFXrT6jvBlQpcZcD1onUdrDzck1U2+cU732rz86HPL0tSz0TJGT
	1phcpilWIq+HoVTjAr9CBAYPFiYnsEokkYsoBZXWqYfRMA8SoDzDj8RwyqRjvNcA
	4LQGBPDK41VWrRvZhTQB1XN+8ctfTzzEI8yvZbutjzdJ8dhU5URMwtQ58MOXyEO/
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id USRjenhvVuSo; Thu, 20 Aug 2026 19:57:52 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (148.60.168.34.bc.googleusercontent.com [34.168.60.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hQvPC3SqqzlfvpW;
	Thu, 20 Aug 2026 19:57:51 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 07/13] loop: Fix race conditions in loop_validate_file()
Date: Thu, 20 Aug 2026 12:57:15 -0700
Message-ID: <2b6da8a843526abf58d0d591ce487533bbce805e.1787255652.git.bvanassche@acm.org>
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

Fix race conditions in loop_validate_file() by adding reference counting
to the file chain traversal.

Ensure the file reference is kept alive during all dereferences by
calling get_file() before the loop and deferring fput() until after we
have locked the target device's lo_mutex and confirmed it is in the
Lo_bound state.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c5f026520836..8b633ea6e72f 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -520,7 +520,7 @@ static struct file *loop_get_backing_file(struct loop=
_device *lo)
 	 * loop_configure().
 	 */
 	rmb();
-	return lo->lo_backing_file;
+	return get_file(lo->lo_backing_file);
 }
=20
 /* Returns 0 if and only if @file is not backed by loop device @bdev. */
@@ -534,21 +534,27 @@ static int loop_validate_file(struct loop_device *l=
o, struct file *file,
 	if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
 		return -EINVAL;
=20
+	get_file(f);
 	/* Avoid recursion */
 	while (is_loop_device(f)) {
 		struct loop_device *l;
+		struct file *prev_f =3D f;
 		struct block_device *f_bdev =3D loop_get_bdev(f);
=20
 		lockdep_assert_held(&loop_validate_mutex);
-		if (f_bdev->bd_disk =3D=3D bdev->bd_disk)
+		if (f_bdev->bd_disk =3D=3D bdev->bd_disk) {
+			fput(f);
 			return -EBADF;
+		}
=20
 		l =3D f_bdev->bd_disk->private_data;
 		scoped_guard(mutex, &l->lo_mutex)
 			f =3D loop_get_backing_file(l);
+		fput(prev_f);
 		if (!f)
 			return -EINVAL;
 	}
+	fput(f);
 	return 0;
 }
=20
