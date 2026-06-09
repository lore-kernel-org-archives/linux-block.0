Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD1B404BD4
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 22:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042764; cv=none; b=pPwm70V1oekEq1+T1XER1+qxoo4o2rs2Imwmtjc5JfUd2aN68eJgiaaKm6fu0HB99A5wy0ce2FfZRKW/r47DWTXiBUsgfyEGN5FhvmrXMAj1StmSiddiK9NLLZVc2oFHs31/Lobb16e8CKfXzEO926oiZi0EMgxbQf0h+NKp/4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042764; c=relaxed/simple;
	bh=MEVKsV99h9NxNvha4hmJsPEJy9dkp4dL7iIPe1Dq12k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwvUecQa4uVWdSZnlzrWWkcQRvzyv/SvuzjOiGyRVl3xnGv72u+MbPktV05koQqGHNcwjLqdX9brTgcY8hs4p6Yms9h+A7vTZk5FFqpWYcOJ5fIeyoPd343MDogf6QBXCdOS680+ry+yk91HTEZjJVBimAkiPWKs1xgDJ3p8weo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=C8sgFDw+; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="C8sgFDw+"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gZjfK2h4rzlgyGq;
	Tue,  9 Jun 2026 22:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1781042756; x=1783634757; bh=NOooZ
	nAfXP7r7TgrjnGT8ZZyqalVr/nYyM4CPD3e8XM=; b=C8sgFDw+qHBI7N0xetVcg
	16Z0iJZoFa8aHciMj/uFagC8e6IRIdiyNob27w7DLRwKJ73CdytKYaPhb/+sggKK
	wA02PSSWNgluj2jUJ1BuxvZhBPDC3moWiFT9UQOCjnq4Tfu2cmtCs6c3pcgAhzE+
	ywX5+RCDTI3hffVAVBDNLDXC+z0pXgawOwqG+v5fSBq2HUah1ElVStiHSSPf8UK0
	xCvT9bn0spfToK2Jj7DIu0JvdvO+U8AsFDhnM7E/sgQiRRcfvs/lzmXto6YBuR+B
	mtSND2JalHMrU9jvRVpz5PCQuY3YhAKdMv8erfQNJZJgeqbac99abehKaUUlCEnB
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6tW6WsnCyQV4; Tue,  9 Jun 2026 22:05:56 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gZjf96CBbzlgy1v;
	Tue,  9 Jun 2026 22:05:53 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 06/27] drbd: Simplify the bitmap locking functions.
Date: Tue,  9 Jun 2026 15:04:53 -0700
Message-ID: <b5a5c65d4f10572a112071033c105d54c9ad0974.1781042470.git.bvanassche@acm.org>
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

Call mutex_lock() instead of mutex_trylock() followed by mutex_lock().
Remove the code that depends on device->bitmap =3D=3D NULL because this
can't happen. All drbd_bm_{lock,unlock}() callers guarantee that the
device->bitmap pointer is valid.

Suggested-by: Christoph Hellwig <hch@lst.de>
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
