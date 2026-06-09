Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF869369D51
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 22:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042781; cv=none; b=EbHUdY3P/1/DuaigF5GuDWtCGhJEKZ2mMzD2br+xqpOgd0hve+Ysc/k5BnhwLOS6ihY1QCPUFgaN9prZ28DaxL3XJLU7AsWrMPRAQ/cj79y3zeoUFI8anIszmeD1s54Rb3aOBc3jXE7m3PTyskJ23yNfGqYjfUiUvGAkvHuX7f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042781; c=relaxed/simple;
	bh=6tfgj0eAxkQSPmCsIaoFhwzgSQ/sW16PkkfbcCkMLHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HCBXv33UU7a2AG0yd2V3IGOJ6F3mDswkHDvZAy8oAfyke+d1ytLE8TFFAKVksGV2wEr0w17NbMAbXyT9MMOO6lEm8YV0/jT0cRoXfRDGGkXZKoxee66rNgomhHXDEWTKqqFd5cZPDxgkYsYnmguGTNyGQTU/A+sRp1KVBQcRdQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=KpBLVo/U; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="KpBLVo/U"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gZjff0H7GzlfpM6;
	Tue,  9 Jun 2026 22:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1781042773; x=1783634774; bh=A0bjZ
	quDBxV4XIQZkALlPRhGnCd8dWWkeUupW2scbNc=; b=KpBLVo/UY8AayqbAd1APO
	AWIoSlfX9MCSgkEMQ7Cv6+Y1N+gAunENnsV6xg2eB1ohhxsqrdmBEqVKLzp2H/ej
	RXkMY7fHUINfkqP/A7wmz1D+KW7nkiKY6fvOJvoL4fqGy0NAl9IvyyvukY19Fhd1
	9mfzQK9X9KPivqIUPV7iuGahT0P6dhnR/0wvGV7q2lJC+vM3h30nm2+ixWAh4ILv
	ZLTV632mykJ3z2h0RdgPQgZTDUrY7bLzQxEdVojZHzSbQ9DEr6Mz7pPxuyaBHNAv
	MfqyYj13gNpKsfdeZ+7KsM0/sfoar+Rsn2VQWEhDm4GTNneR898oCMjICuBo+gDm
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 5dEGPjaId893; Tue,  9 Jun 2026 22:06:13 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gZjfV1rBhzlgwNJ;
	Tue,  9 Jun 2026 22:06:09 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 11/27] drbd: Split drbd_req_state()
Date: Tue,  9 Jun 2026 15:04:58 -0700
Message-ID: <83d144f376580f491b42d7533e004aced7d26d7a.1781042470.git.bvanassche@acm.org>
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

Move all code except a mutex_lock() and a mutex_unlock() call from
drbd_req_state() into the new function __drbd_req_state(). This patch
prepares for adding a second __drbd_req_state() caller.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/drbd/drbd_state.c | 43 +++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_st=
ate.c
index adcba7f1d8ea..5aa4b1889144 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -549,19 +549,10 @@ _req_st_cond(struct drbd_device *device, union drbd=
_state mask,
 	return rv;
 }
=20
-/**
- * drbd_req_state() - Perform an eventually cluster wide state change
- * @device:	DRBD device.
- * @mask:	mask of state bits to change.
- * @val:	value of new state bits.
- * @f:		flags
- *
- * Should not be called directly, use drbd_request_state() or
- * _drbd_request_state().
- */
-static enum drbd_state_rv
-drbd_req_state(struct drbd_device *device, union drbd_state mask,
-	       union drbd_state val, enum chg_state_flags f)
+static enum drbd_state_rv __drbd_req_state(struct drbd_device *device,
+					   union drbd_state mask,
+					   union drbd_state val,
+					   enum chg_state_flags f)
 {
 	struct completion done;
 	unsigned long flags;
@@ -571,8 +562,6 @@ drbd_req_state(struct drbd_device *device, union drbd=
_state mask,
=20
 	init_completion(&done);
=20
-	if (f & CS_SERIALIZE)
-		mutex_lock(device->state_mutex);
 	if (f & CS_INHIBIT_MD_IO)
 		buffer =3D drbd_md_get_buffer(device, __func__);
=20
@@ -629,6 +618,30 @@ drbd_req_state(struct drbd_device *device, union drb=
d_state mask,
 abort:
 	if (buffer)
 		drbd_md_put_buffer(device);
+
+	return rv;
+}
+
+/**
+ * drbd_req_state() - Perform an eventually cluster wide state change
+ * @device:	DRBD device.
+ * @mask:	mask of state bits to change.
+ * @val:	value of new state bits.
+ * @f:		flags
+ *
+ * Should not be called directly, use drbd_request_state() or
+ * _drbd_request_state().
+ */
+static enum drbd_state_rv drbd_req_state(struct drbd_device *device,
+					 union drbd_state mask,
+					 union drbd_state val,
+					 enum chg_state_flags f)
+{
+	enum drbd_state_rv rv;
+
+	if (f & CS_SERIALIZE)
+		mutex_lock(device->state_mutex);
+	rv =3D __drbd_req_state(device, mask, val, f & ~CS_SERIALIZE);
 	if (f & CS_SERIALIZE)
 		mutex_unlock(device->state_mutex);
=20
