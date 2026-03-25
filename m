Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176D02773DE
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475161; cv=none; b=lJ7uCQrGM4bwEtagqNMeOwnMffHE3YEIkXCehpigg10ZYyNVX55F26NrNKwOs/MG4TtU78ttvx6znyEJcn9VZZon/FX4Ykc7wm6mdTRmQaURx97Sh/BytQR0RVCX/O/AhGnX724WqFiHXW+fFrWZqv95vJfhr9iS79OM4+9/P64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475161; c=relaxed/simple;
	bh=IBeSinFkk//cBuAfZyABkHYgvIObaYgbUq9oTSJOcfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzNKGvH4XeU9G7cM4nfrPXHmxFQ/oVKlG9+Tn+AHzMWx4f/nnJIBAQICabzmHZ7OiAWOEgknq6tspL0Rw6SwrcaxpiRuq1bFbE+Fu6eYN8E2RsYUUb656lbOWxfERHQSIhOjCHhbQioqsgYPsAJF200IKO7hQUo+GXSK5GAfZk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=k7NNJVzf; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="k7NNJVzf"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0pH520HzlgyG8;
	Wed, 25 Mar 2026 21:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774475156; x=1777067157; bh=ETlaJ
	yxsowEzZpTIg/YNj3DV0+C7sBNRxSR/Z/J3IMw=; b=k7NNJVzf9hqAW5vHH/xZS
	Wt4Z2JhsgGjFo8pRZj0ANZRKa5wi37c7YaadbIycnjt5iOTSN9QNEg27SxvFm2h/
	85GXRGKwbFW72CkFjZe7rVJ1rFRD7E3dPT/yze2HC8Xsy68zC71aY7HrozpKXYSZ
	3kvJIWracI1Q3k3/9ArSQlg83rr/qWEcbfl27SWESKxwwtBrO3iyiMP0qe+zvqvH
	IGVhxYjNBfReLJoEi6no1zajw8X0ig32HQRH1eO51R+zoNKl8lNgt3vrSq2aTlbh
	QTyhdqIw+ZkrQW3WOhF8KGiEkW1MOU6e0xunPu8cSSOCi0xzPJJ7WK5+4iVwlWCq
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id H30BRJlT30pc; Wed, 25 Mar 2026 21:45:56 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0pB2PylzlfdGT;
	Wed, 25 Mar 2026 21:45:54 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 11/26] block/Kyber: Make the lock context annotations compatible with Clang
Date: Wed, 25 Mar 2026 14:44:52 -0700
Message-ID: <20260325214518.2854494-12-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325214518.2854494-1-bvanassche@acm.org>
References: <20260325214518.2854494-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for enabling lock context analysis.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/kyber-iosched.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index b84163d1f851..971818bcdc9d 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -882,6 +882,9 @@ static const struct elv_fs_entry kyber_sched_attrs[] =
=3D {
 };
 #undef KYBER_LAT_ATTR
=20
+#define HCTX_FROM_SEQ_FILE(m) ((struct blk_mq_hw_ctx *)(m)->private)
+#define KYBER_HCTX_DATA(hctx) ((struct kyber_hctx_data *)(hctx)->sched_d=
ata)
+
 #ifdef CONFIG_BLK_DEBUG_FS
 #define KYBER_DEBUGFS_DOMAIN_ATTRS(domain, name)			\
 static int kyber_##name##_tokens_show(void *data, struct seq_file *m)	\
@@ -894,7 +897,7 @@ static int kyber_##name##_tokens_show(void *data, str=
uct seq_file *m)	\
 }									\
 									\
 static void *kyber_##name##_rqs_start(struct seq_file *m, loff_t *pos)	\
-	__acquires(&khd->lock)						\
+	__acquires(&KYBER_HCTX_DATA(HCTX_FROM_SEQ_FILE(m))->lock)	\
 {									\
 	struct blk_mq_hw_ctx *hctx =3D m->private;			\
 	struct kyber_hctx_data *khd =3D hctx->sched_data;			\
@@ -913,7 +916,7 @@ static void *kyber_##name##_rqs_next(struct seq_file =
*m, void *v,	\
 }									\
 									\
 static void kyber_##name##_rqs_stop(struct seq_file *m, void *v)	\
-	__releases(&khd->lock)						\
+	__releases(&KYBER_HCTX_DATA(HCTX_FROM_SEQ_FILE(m))->lock)	\
 {									\
 	struct blk_mq_hw_ctx *hctx =3D m->private;			\
 	struct kyber_hctx_data *khd =3D hctx->sched_data;			\
