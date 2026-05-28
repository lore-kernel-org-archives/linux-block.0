Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBC526C3BD
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997595; cv=none; b=F011aq01ind3OeMAv10WaT+sZRrVot4hG+0q+2MrzrrAfXzNbmwaUn5E5Jc9tvnw4ig584R33YpJ2tZWzls7Qxj+Y6SxtoVBRzZXEUrGVlk+95K1MsJtcF9Z0Pqtb1tb/xwcROZIr26tAR9GywV+IE6LmXhw8ftb66Ht88b0scs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997595; c=relaxed/simple;
	bh=B8P70B7NwGvY0IhombkfYC1c/SxCpj/tPu6on2PWZqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Itm3uhmGhPp9J9T+PDK0G0rI+tn/pHlIG0SRV9J0K3SBgHZuUmFLZdE6ICO1a+jSdHhvcVuafW+EwzGbedWj3x+xDNhxKsedRqZBKXI0ae7uxQNxwkWqzedZebwx0bx7Fv4lYO88yCUCIIPDlKHiNpeMlu9g7BLixlCrmyvKX94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Eh8aZBt6; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Eh8aZBt6"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gRH6y4JShz1XM0pY;
	Thu, 28 May 2026 19:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1779997590; x=1782589591; bh=gm0fK
	XTgCPJyE/KLGPmM82EHDPIjy2z8ZOamO/6aJJo=; b=Eh8aZBt6EDmMYhWTy5MPH
	OLmeq5Y/K1nSitCsdek6N92tP5SOmDV91pYQPePUflQnfdMntebg4wmOgBGMYCJQ
	rkLieTUV9Nym49JB7gYXSvKtVAWS0h/BnzA3kSu3nqrN/uKpjaIjdQlEFPaPnvvG
	JjOMki2ml355a/7sgknodAdVF22lUU+Twjg/PPMwWQHNhxLtv1RbDjGfHPzI7mTx
	iIbSJtR7P4USxkX82TYwp4rIKEAN2t8RMryEzSHb4+enruciLbhKGclHIynidZH2
	FYDFuVUHnjWGEC2jsILRK4oTiRbDnoy50jEFSHMZEr3oDbi2uAZwINVvGROvJWoe
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id H-FARTjPuufv; Thu, 28 May 2026 19:46:30 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gRH6s4PFqz1XM0p3;
	Thu, 28 May 2026 19:46:29 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v5 10/12] block/kyber: Make the lock context annotations compatible with Clang
Date: Thu, 28 May 2026 12:45:47 -0700
Message-ID: <5165d212359b6b2ac70f52917282b85ea6c75fdf.1779997063.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
In-Reply-To: <cover.1779997063.git.bvanassche@acm.org>
References: <cover.1779997063.git.bvanassche@acm.org>
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
