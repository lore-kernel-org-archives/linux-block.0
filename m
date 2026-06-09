Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99962F5313
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 22:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042754; cv=none; b=aIs4HMZw1kRZZ26DYk4P5b04MIiFAoOi0N8Y991C8yXOQE0FnAyyuLuNxgcO1lb2SkVEkzdDG0SRfz8zeTYJE2YGOyQ5EanHLPJ93b1PVeCkxFujCp9uEWejiHG3noEE4lAdC07GikPCG9t1Csof0306+uLgVzTqul6cD2RNJyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042754; c=relaxed/simple;
	bh=IeCVkZixJQJECXGRkZCv8/Tajn1i3ov2bxx6U6HXmSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czjM71mq79CgcT45SW0L2GDhjSwRugOLMUdXYdYSXJK3Ojb2hN+g+dsGIgfrPAGu4u2jMxyDnm1ZskfTW8kmENCuZhe5J2ahYhIrflKLUFjdKRdYOdYPCuuzTJINoyPqb2aSkRnFHNdy08sgnQ4xLu4IPYRVdWt85iIiq0YH874=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ANtX3JBm; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ANtX3JBm"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gZjf935pzzlgwMq;
	Tue,  9 Jun 2026 22:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1781042747; x=1783634748; bh=KPqvl
	IEPOAwDGSlDwwXk/YqnoZX84yHzhKVIbM9HHOM=; b=ANtX3JBmB+xohBumky80g
	sc3DzIy3kjVy9RtsDpzBLmm9oqEoNxaJe71TRofw/oIXdVbpnfq14Bap+03hP4+X
	F2kndVGPN9Bic0rn4Q7kOeYLWI92TIP6T5U8lj/DIFUhlT+YT5IOlfKA5G2Y7Z2J
	Zdsu/12mrhPTNiaRPWyfvpsBKmURNJg75U98bneA7Iq6ubchQ4ubdrVLZI1LYkhe
	e0NiAZZR1t2Wnj7btwSHcMWxf/bcfkIycVhjv7pVzacEDChGfD5jtyUTGUMQqEM1
	qWz2qPcFHPWuAM7F+o3EDU8lLwAB6leiB+cVLwzLFrIPrK/RryGS8OhqfJv2n/+Q
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Fk3SoBEHdGzs; Tue,  9 Jun 2026 22:05:47 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gZjf157HhzlfpM6;
	Tue,  9 Jun 2026 22:05:45 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 03/27] drbd: Retain one _get_ldev_if_state() implementation
Date: Tue,  9 Jun 2026 15:04:50 -0700
Message-ID: <3777c00c7a6e8bf807ac9133cc9b89540c19bac1.1781042470.git.bvanassche@acm.org>
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

There are two slightly different _get_ldev_if_state() implementations
in the DRBD source code. Keep the version that is used. This does not
affect C=3D1 / C=3D2 builds because lock context checking is performed by
Clang instead of sparse since commit 5b63d0ae94cc ("compiler-context-
analysis: Remove Sparse support").

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
