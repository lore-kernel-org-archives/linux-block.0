Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E369B4499AB
	for <linux-block@vger.kernel.org>; Thu,  9 Jul 2026 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783632990; cv=none; b=qXhMvaEEl+9cjuTtJwW0vhsyDHt1tFojIXTjvraGURHd4gVfrJ1UKFQk7QvEBG0K7N1eeIqSOVL77/vs1OVtt5WPuVmH3t56431kwO+vR3cuGFOuVtO+tEyEZkKjEwBNsFHuX5fZzayUFJjFbSJn8JrK94oG2MDnhxdpbwpx4XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783632990; c=relaxed/simple;
	bh=3itDCo/xKHYaVqNAFLoaT3afn0NeudMD9ftH4HtAX0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKlYjy7t2rMCtiM058p3u1TJ+FWQJHRlxhKXs9FYhUOn0Ea3vU558RuujiIntV9MAUS+HS7t6S6fdJXJ3CGxLjLudtX8OyByaClZiCbggT6/z/OTdXcGoDhZOwvuQKnc53GhkA2fy0e7fVCX78oc08pv8bLagQsGaZ61K5BWYPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=mUbHv3hw; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="mUbHv3hw"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gx7ZN4zSjzlhH09;
	Thu,  9 Jul 2026 21:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1783632982; x=1786224983; bh=HyzBl
	vTptNB+AT5OWquYTTtxVbwKdkQOW24Pg02AS/8=; b=mUbHv3hwy8hr5sVuLvJBR
	h6nHoFgrLboI6k8kMAbZKLvomNekzJF2N3YbCE04oN4QYfCZeer7I1NdEoYAKCtv
	Zh1OTH5tcvRgoQ8q+Rd7xfwJnWvpOvy5ymBnCSZJxbY4L2vylU5PmVKAaa6RJszC
	2t24gp/4KOx7ToKEAc0ed13ZdQ7C3p05kw4BfUtNvzaT0uRn0yFyERuBs1/rrvee
	iWx80wnUBit1MWTqq8KhKqNdj4tJ1+In1o4jpe1AXcIMx+2mrr3ZhbbOvLTYErut
	givPU9xeOhAx89Xv6eIP98+EdBI9nZUyQDlA9Mspdpkd49Kqt0GftdDRlnV0U6JB
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id meK-ocbbwKpO; Thu,  9 Jul 2026 21:36:22 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gx7ZC2BJTzlhH0F;
	Thu,  9 Jul 2026 21:36:19 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	=?UTF-8?q?Cc=20=3A=20Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [PATCH 11/12] drbd: Annotate drbd_bm_{lock,unlock}()
Date: Thu,  9 Jul 2026 14:35:32 -0700
Message-ID: <2108bc1373807d815e3c2f8b656b873b7b201adc.1783632330.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <cover.1783632330.git.bvanassche@acm.org>
References: <cover.1783632330.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Annotate the bitmap locking functions. Introduce a new token context
lock because the struct drbd_device definition is not visible from the
drbd_int.h header file. Annotate the declarations of bitmap locking
functions with only the token context lock. Annotate the definitions of
the bitmap locking functions with both the token context lock and the
actual mutex.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/drbd/drbd_bitmap.c | 6 ++++++
 drivers/block/drbd/drbd_int.h    | 8 ++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_b=
itmap.c
index e332a96fe90c..d849bd780ca9 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -122,9 +122,12 @@ static void __bm_print_lock_info(struct drbd_device =
*device, const char *func)
 }
=20
 void drbd_bm_lock(struct drbd_device *device, char *why, enum bm_flag fl=
ags)
+	__acquires(drbd_dev_bm_lock)
+	__acquires(&device->bitmap->bm_change)
 {
 	struct drbd_bitmap *b =3D device->bitmap;
=20
+	__acquire(drbd_dev_bm_lock);
 	mutex_lock(&b->bm_change);
 	if (BM_LOCKED_MASK & b->bm_flags)
 		drbd_err(device, "FIXME bitmap already locked in bm_lock\n");
@@ -135,6 +138,8 @@ void drbd_bm_lock(struct drbd_device *device, char *w=
hy, enum bm_flag flags)
 }
=20
 void drbd_bm_unlock(struct drbd_device *device)
+	__releases(drbd_dev_bm_lock)
+	__releases(&device->bitmap->bm_change)
 {
 	struct drbd_bitmap *b =3D device->bitmap;
=20
@@ -145,6 +150,7 @@ void drbd_bm_unlock(struct drbd_device *device)
 	b->bm_why  =3D NULL;
 	b->bm_task =3D NULL;
 	mutex_unlock(&b->bm_change);
+	__release(drbd_dev_bm_lock);
 }
=20
 /* we store some "meta" info about our pages in page->private */
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.=
h
index 1f3f2157df8b..7e0e0a0f27ae 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1337,8 +1337,12 @@ void drbd_bm_merge_lel(struct drbd_device *device,=
 size_t offset, size_t number,
 void drbd_bm_get_lel(struct drbd_device *device, size_t offset, size_t n=
umber,
 		     unsigned long *buffer);
=20
-void drbd_bm_lock(struct drbd_device *device, char *why, enum bm_flag fl=
ags);
-void drbd_bm_unlock(struct drbd_device *device);
+token_context_lock(drbd_dev_bm_lock);
+
+void drbd_bm_lock(struct drbd_device *device, char *why, enum bm_flag fl=
ags)
+	__acquires(drbd_dev_bm_lock);
+void drbd_bm_unlock(struct drbd_device *device)
+	__releases(drbd_dev_bm_lock);
 /* drbd_main.c */
=20
 extern struct kmem_cache *drbd_request_cache;
