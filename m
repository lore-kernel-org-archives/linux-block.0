Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4375386422
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 18:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682530; cv=none; b=AV5lSddbdE3oAS+VxG0PJXzRXGUk2DsgtT9kGYWjk6OSuklIcK6oM8dwR/qbBlTEa7uFDbjQrS61RA9gqvcseBq3WpM7s5LS3W1M9ZXdjGQ+eTwwIg2P4E3oqQPYn8eYQrclJCLnMFo0z74O0OXYC1qGaHix0uHkTc3WD64Sr2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682530; c=relaxed/simple;
	bh=Ve5keet2/l97YX+4KCTqM79w7b6hNqMLOmKyF52LWbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PB1+06jx1rFNx2bGFjui5BB6rrykf7TSEl7VV1OuInkSBFxqeEcqsO44TK63Jr/Mw+BNltSNjqJaUSu8ihPCI2+89LSDy3i4GRYcq3GDjMpcnH2RAN4+OVtn1D+sj/pYxs4uBFdzsHcZAeRzC4yNJc/wNTtEnmSQIOCaMX/8Ubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=nhbzHS8N; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="nhbzHS8N"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gX8Qm2td3z1XM6Jh;
	Fri,  5 Jun 2026 18:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1780682523; x=1783274524; bh=OWczc
	12zHtTadm/mAo61qOPIp7h2ZS1tVbH7NZW3m3Y=; b=nhbzHS8NF3rhlDV1gjbE+
	3ThAPc0uuyQAUg+LGUtN1442/qrYBt7PH5dFRhVhLxSUpgBdm3CYfob3NPPX99lo
	XOW2802Kdj31zIqb+s8wOdvt8nefPoSruJ47z3nodplkWVBNFNggDw2oe71DoMKg
	dZtgv6LDH20Fpp1zWRCzrbwNjZle5Uz/dXXVaxg3JX2mEArXk8eRtO+ve0Qg/KYF
	NoYUuFwQd60xTjjDcpM3UL4EQTzA4hgQDS5OrXxMH+9ZKY9T/4S6IcKkMnFzV5BV
	aB3biJjRxXjKJXxdK1RuIDcyTm2DZy0jlD0HC0/MsqErTX8OO6SB2PY/M+MsY0ij
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id pPPx09iQi4iz; Fri,  5 Jun 2026 18:02:03 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gX8Qc6N1Dz1XM0pW;
	Fri,  5 Jun 2026 18:02:00 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v7 12/14] block/Kyber: Make the lock context annotations compatible with Clang
Date: Fri,  5 Jun 2026 11:01:05 -0700
Message-ID: <91cb8c790fc8b26b8aa742569fbf8c2c1d099dac.1780682325.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <cover.1780682325.git.bvanassche@acm.org>
References: <cover.1780682325.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

While sparse ignores the __acquires() and __releases() arguments, Clang
verifies these. Make the arguments of __acquires() and __releases()
acceptable for Clang.

Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
