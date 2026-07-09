Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FA54499AB
	for <linux-block@vger.kernel.org>; Thu,  9 Jul 2026 21:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783632984; cv=none; b=KE45nhqAjBed5QcKOzkZ+W9SxYXRzYHCoR74Id90GO1W3NuWzAt1SZgqLSH1ZUysz2EhKVNLjPZrNsnzrGmCaUM7B86vYqROtqaUt7/FgCgG26zzIBagjQEDddVP7WIPiMibGedSqD01lsks+4scW2bMBthUt2HfF8MjRvDRTig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783632984; c=relaxed/simple;
	bh=Xn4T8pxKh4/2aTvGVSJcIVWr2WmsiurlO6Ys5bKMC2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTHPLphBuIcU44EOTuhbRF7mLxo2qTlgcjfLzNFyWfvnD2zpLj7Nu9GVfSlXMYLmab4ZaaNiRl0Zgji0lYczrFhGqh7YEyFHXURdIapEuNUD/KHa15M6iWW4QaqvpA/mGyti7MqvU1ag5k238j53JGPZOkk9uh5E7Lw0iX+vYjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Y7gJKckd; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Y7gJKckd"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gx7ZH32PbzlhH05;
	Thu,  9 Jul 2026 21:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1783632978; x=1786224979; bh=lQB1u
	OBqHTKkev6rEA0HCMerdWtba+/Oww4q8vJYDxQ=; b=Y7gJKckdEtF06MpFGDaBM
	H97NtP/ONSpg/na5C4N3beYIblr9JxM8MWc5XP0/+9z4+0JEw7HgqUg9Oqeb5CX0
	hQZaAvX+fGZ+nyK/HOz0VGzc7SwzB05XguiTcpr9mr9mRBQ7rQ+bcA+aPtpzFHJp
	DuDTeeIdEqdorQqWVWCxwfinZ++bFznLSPG35/jT3q10oCZMd1zpSll5uvaNIWXg
	r0vEgzoKYhwFoInUMHuoxzLIQWoQtwlyl5Fy5L3EPdWoYIrDYnOWZNiXu+AxfPQt
	NC6fsRz9ieWO/aQ+GSBgOy15qC+KW7LAbM5a0h6xNRWhN2ikyH9tDOu3VL2YmfkE
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id zNgy1OnxGW1V; Thu,  9 Jul 2026 21:36:18 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gx7Z859k1zlhH04;
	Thu,  9 Jul 2026 21:36:16 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	=?UTF-8?q?Cc=20=3A=20Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [PATCH 10/12] drbd: Rework locking in drbd_req_state()
Date: Thu,  9 Jul 2026 14:35:31 -0700
Message-ID: <2831b184dfe3d04ab8c30d1eaaae4a254d37c7a3.1783632330.git.bvanassche@acm.org>
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

Move all code except a mutex_lock() and a mutex_unlock() call from
drbd_req_state() into the new function __drbd_req_state(). Rework
locking in drbd_req_state() such that the mutex_lock() and
mutex_unlock() calls occur in the same branch of an if-condition.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/drbd/drbd_state.c | 47 ++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_st=
ate.c
index adcba7f1d8ea..c60c071a666a 100644
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
@@ -629,8 +618,34 @@ drbd_req_state(struct drbd_device *device, union drb=
d_state mask,
 abort:
 	if (buffer)
 		drbd_md_put_buffer(device);
-	if (f & CS_SERIALIZE)
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
+	if (f & CS_SERIALIZE) {
+		mutex_lock(device->state_mutex);
+		rv =3D __drbd_req_state(device, mask, val, f);
 		mutex_unlock(device->state_mutex);
+	} else {
+		rv =3D __drbd_req_state(device, mask, val, f);
+	}
=20
 	return rv;
 }
