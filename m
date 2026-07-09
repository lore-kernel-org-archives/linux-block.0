Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD584499AB
	for <linux-block@vger.kernel.org>; Thu,  9 Jul 2026 21:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783632972; cv=none; b=vAs1kPyA8KvqmwpqldIJB+2x+xUkqOl6giP8TkqqrDPdlVCLJeBszMsBkFop4Za2AjZfm4Bct03lGr6mGu6lgcv+1mhw7dfyb+jRlrt31/8XZmMR1YX+SUQTpMxYw+0NcbimAuzcoNVxJzsOdi0OyireuCMVfwcUFQggFTkSnk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783632972; c=relaxed/simple;
	bh=v+9kaNooxOtNy/BmZ4gJBp+n1JTnpDA7Hu99G6elUF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mx7HUgW4ub2qLtb5wH+6AGYFuQZ/Pv3TH0cNhIJOu5EyUV8x2kO23ks2iLW2MFnxHW0u0JEZYtgnfUwBdyARcbLAuldRrMEer+/4eA5Pk+pf6nqBFZas+7Ex1vUvoB9mzNQ7APLlvVcwKiJEWMXVbeao4rysiu7dIR5cx9tP4M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=U+6Em4Cj; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="U+6Em4Cj"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gx7Z23JLpzlhH0Y;
	Thu,  9 Jul 2026 21:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1783632964; x=1786224965; bh=FbBvt
	ThbPERZbmFDwX/RVnb2ygHZMIxHWt7WizAwJ8I=; b=U+6Em4CjZm6cnEZfiL3oV
	xgRRY3iWOSZTop45SsYgu8PppN2LYyUPKr+9zTpswCdaHej/OtRnud5YYZsIZA1M
	gUmK8vIY0o67iu5aTZpcP7lM0a3xdU3nMsresRH1QfCuHIrEIENTIg8lxL8mYXrj
	Clt+KLhPDWSL/+1w0dOGQ3c+oXNMVTx4On8oMTT6Xq+YzPwM8FxYuRs7xEAEKyvj
	XASSakY/zKy+vjlbFGq4Z540sNOYVRZq/L9M/4WHlmn29WeNi70wV7CLC10synAO
	wLdv5s75HZUWz3yR5xKKXA+7b0dqAe5gqtttYzuJWHFf9ZNv7lfkka/fzTrMxWZb
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id UtZkZvkku66R; Thu,  9 Jul 2026 21:36:04 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gx7Yt4LT3zlfdCs;
	Thu,  9 Jul 2026 21:36:02 +0000 (UTC)
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
Subject: [PATCH 05/12] drbd: Simplify the bitmap locking functions.
Date: Thu,  9 Jul 2026 14:35:26 -0700
Message-ID: <2bed33a871a6cb6ee13933b3a1f6bccb41cbb1e6.1783632330.git.bvanassche@acm.org>
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

Call mutex_lock() instead of mutex_trylock() followed by mutex_lock().
Remove the code that depends on device->bitmap =3D=3D NULL because this
can't happen. All drbd_bm_{lock,unlock}() callers guarantee that the
device->bitmap pointer is valid.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/drbd/drbd_bitmap.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_b=
itmap.c
index 1c68f1774e28..e332a96fe90c 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -124,22 +124,8 @@ static void __bm_print_lock_info(struct drbd_device =
*device, const char *func)
 void drbd_bm_lock(struct drbd_device *device, char *why, enum bm_flag fl=
ags)
 {
 	struct drbd_bitmap *b =3D device->bitmap;
-	int trylock_failed;
=20
-	if (!b) {
-		drbd_err(device, "FIXME no bitmap in drbd_bm_lock!?\n");
-		return;
-	}
-
-	trylock_failed =3D !mutex_trylock(&b->bm_change);
-
-	if (trylock_failed) {
-		drbd_warn(device, "%s[%d] going to '%s' but bitmap already locked for =
'%s' by %s[%d]\n",
-			  current->comm, task_pid_nr(current),
-			  why, b->bm_why ?: "?",
-			  b->bm_task->comm, task_pid_nr(b->bm_task));
-		mutex_lock(&b->bm_change);
-	}
+	mutex_lock(&b->bm_change);
 	if (BM_LOCKED_MASK & b->bm_flags)
 		drbd_err(device, "FIXME bitmap already locked in bm_lock\n");
 	b->bm_flags |=3D flags & BM_LOCKED_MASK;
@@ -151,10 +137,6 @@ void drbd_bm_lock(struct drbd_device *device, char *=
why, enum bm_flag flags)
 void drbd_bm_unlock(struct drbd_device *device)
 {
 	struct drbd_bitmap *b =3D device->bitmap;
-	if (!b) {
-		drbd_err(device, "FIXME no bitmap in drbd_bm_unlock!?\n");
-		return;
-	}
=20
 	if (!(BM_LOCKED_MASK & device->bitmap->bm_flags))
 		drbd_err(device, "FIXME bitmap not locked in bm_unlock\n");
