Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FFF3EB0F6
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 22:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042787; cv=none; b=dWq1Z5ND4cqPNVfoQsw/EYZlb8R2Tb6m5gemVPx1YdvRbUiNCa0L0HJenAPMKeR/T7guLcJVE2XQWlIxYbCwgoJpQotnOXoPZzrOY3f9g6rjUWudMwvaLdC6akfxQNLTe8OQyUsIYcQSOJWNTy5ol1GLmg2V3j8Ppzj4Q+lkNN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042787; c=relaxed/simple;
	bh=Fi9GKdr6NLwT5mkke/9hYefB6UAPJjZJu7OfW8DNtNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmpM4nDX857S55x6bf8M1nqi96goUs5lDAKepAZ0/RTzzqPOplQ8ObiApZwc+j9bh6I+iNyGmsH4hGIi/UZhk/ZoRPS9rrrJ4XlxvEP887pKEKn3ZBfanUfb92WXE+nLg7urqVYHiy9g2QbJp9LijOofMS0tg1R9vVDbtfuO2D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=28svsKgO; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="28svsKgO"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gZjfp00TWzlgwNJ;
	Tue,  9 Jun 2026 22:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1781042780; x=1783634781; bh=QH+VM
	ZUic1rgE/Pw0UXmwiVhmIeFsmwHWNlQjKNCbcg=; b=28svsKgOIO/rdmFHQ537/
	SiFKPHczM+w3+jd1M0xRCcOE1CVXv9SfDZahc3H9+PCP+JPhomRcyA+9s6ooJ/L5
	tw4G0exCe2N+o7kNDeRPsKv0Oc/VNK2Ym8bKmT/FVbJE+Jzct5XsrgF5m6hCMOBk
	ct1ot3IxgZx5Beoi9Xc5iXhbegxHwND6p8xiSYulpF0YF2KzV06WlXkLcU8MoQ5u
	3KNmiaZqDT8UQsV2KBEBmEQWOuQSd8jtFa7YSr4LkyTN88T/UPuXX1CRnF1I2085
	Y2e0z8dXM1RQ3vKoQ0Kes1LjC59ytZRn9T68WP+kckZWqd7ZUGmgEFq7B+j/Vk34
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id x8qVLj6aXhQI; Tue,  9 Jun 2026 22:06:20 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gZjff70yCzlfddT;
	Tue,  9 Jun 2026 22:06:18 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 13/27] drbd: Annotate drbd_bm_{lock,unlock}()
Date: Tue,  9 Jun 2026 15:05:00 -0700
Message-ID: <b5346ca2d22de25c6a03a7b6477d4110c263e5c6.1781042470.git.bvanassche@acm.org>
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

Annotate the bitmap locking functions. Introduce a new token context
lock because the struct drbd_device definition is not visible from the
drbd_int.h header file. Annotate the declarations of bitmap locking
functions with only the token context lock. Annotate the definitions of
the bitmap locking functions with both the token context lock and the
actual mutex.

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
