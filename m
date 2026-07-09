Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7954499AB
	for <linux-block@vger.kernel.org>; Thu,  9 Jul 2026 21:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783632964; cv=none; b=pJ1BC7JZdfb4b10j6Rrl7uoLABM+KhkYq11rwNjF8vCDOtO6B1MhZqsN8zyiFMfTogw/GNmhL6alrOpgdS+AvtN0FQu5lp+emyna3MhMINiY7zK4bCXJ0MeHTRFqyYaB7pPLj1JKtt2sKYChQHJJKVGhI1dFCIZGJwlbyNbzyLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783632964; c=relaxed/simple;
	bh=xbq+00QUEJgV9atEtW0i9wF42qoaHU2Iq/UGaat8LrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sFnjJOgToOr4W7Irh9dGpgtuDjXScT9VT8je2QgLPy8IT42XA1sLv+ouE1b3DzdXTtHgCKOXAOlOQqOlvT6OIt9XmGAGn9owXIo4j9wzqjV//zOQ+Cne3Y5zX1X8dSBhWiODVKSY+hv8OB311yLcKUux1gpFFPvsMy4HJbTWBAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=TH6lWHPA; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="TH6lWHPA"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gx7Yt1xdwzlhH01;
	Thu,  9 Jul 2026 21:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1783632956; x=1786224957; bh=EJvtT
	GDvcSPxzREaPXRpQeUK/eRsWTrtnSdDUlC8+Jw=; b=TH6lWHPAY0+HNij8xDZAl
	Y9tEkc6gcyxvwzpQfHAWibwDikco9scW4sZhkN6oL8T1klVzyFL/LK4bJ+78sFfV
	xEXe12yWP1EK7DytyEKyJhdyVWrOY77KxbakMjZl94pENtnAdSPu91r50S1n6WP9
	SSI1DlVg7oYp4tykCNldy3UqFyYeKkKMbUli5NsUu4zXA2wExOR8D07optheOQXh
	s7na7K9zDC4AyvwkMBLQZIAd3Nhh5LE0BEd7qhyXg0zcxV1Hiq+FCkcYvTxR7EoF
	6fxRtIy+/1u7sk25oBYL528naP40P618Unt7r8diSzyd/XoEYgkR6pn/tUNIx3Q5
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id QLYNHlyqnz7l; Thu,  9 Jul 2026 21:35:56 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gx7Yj3JQ7zlfdCs;
	Thu,  9 Jul 2026 21:35:53 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	=?UTF-8?q?Cc=20=3A=20Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 02/12] drbd: Retain one _get_ldev_if_state() implementation
Date: Thu,  9 Jul 2026 14:35:23 -0700
Message-ID: <3e4528bba912f3bc6def952c2159733c06ab928d.1783632330.git.bvanassche@acm.org>
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

There are two slightly different _get_ldev_if_state() implementations
in the DRBD source code. Keep the version that is used. This does not
affect C=3D1 / C=3D2 builds because lock context checking is performed by
Clang instead of sparse since commit 5b63d0ae94cc ("compiler-context-
analysis: Remove Sparse support").

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/drbd/drbd_int.h  |  7 ++-----
 drivers/block/drbd/drbd_main.c | 19 -------------------
 2 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.=
h
index aa39c4d19133..bba52252fbac 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -2033,8 +2033,8 @@ static inline void put_ldev(struct drbd_device *dev=
ice)
 	}
 }
=20
-#ifndef __CHECKER__
-static inline int _get_ldev_if_state(struct drbd_device *device, enum dr=
bd_disk_state mins)
+static inline int _get_ldev_if_state(struct drbd_device *device,
+				     enum drbd_disk_state mins)
 {
 	int io_allowed;
=20
@@ -2048,9 +2048,6 @@ static inline int _get_ldev_if_state(struct drbd_de=
vice *device, enum drbd_disk_
 		put_ldev(device);
 	return io_allowed;
 }
-#else
-int _get_ldev_if_state(struct drbd_device *device, enum drbd_disk_state =
mins);
-#endif
=20
 /* this throttles on-the-fly application requests
  * according to max_buffers settings;
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_mai=
n.c
index a2a841c89201..dbf6e413db03 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -128,25 +128,6 @@ static const struct block_device_operations drbd_ops=
 =3D {
 	.release	=3D drbd_release,
 };
=20
-#ifdef __CHECKER__
-/* When checking with sparse, and this is an inline function, sparse wil=
l
-   give tons of false positives. When this is a real functions sparse wo=
rks.
- */
-int _get_ldev_if_state(struct drbd_device *device, enum drbd_disk_state =
mins)
-{
-	int io_allowed;
-
-	atomic_inc(&device->local_cnt);
-	io_allowed =3D (device->state.disk >=3D mins);
-	if (!io_allowed) {
-		if (atomic_dec_and_test(&device->local_cnt))
-			wake_up(&device->misc_wait);
-	}
-	return io_allowed;
-}
-
-#endif
-
 /**
  * tl_release() - mark as BARRIER_ACKED all requests in the correspondin=
g transfer log epoch
  * @connection:	DRBD connection.
