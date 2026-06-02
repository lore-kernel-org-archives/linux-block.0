Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50E43F58C3
	for <linux-block@vger.kernel.org>; Tue,  2 Jun 2026 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420130; cv=none; b=SgXeZgtqFFy4n53AvK/54uteS3erB3pujae3scQFrc1q9SsrW7ZhtL3Tx3XIeqGyDquSweOSZ8c6FLdu7D7HKy9FCCe0BIDrCfU1y47DgmMAHki4rLnxDijFWe2rT0w90W/24lIdcvwXQZB3xfOdfIv5BSneuVTHohGQAySiGx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420130; c=relaxed/simple;
	bh=Ve5keet2/l97YX+4KCTqM79w7b6hNqMLOmKyF52LWbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1yj30ohxpLqljkXtEZdXG8YA3gOluwKcZqeUj3FN6Bm7mams5V4Kg7SgfKOp0HnEKDTo8Pq4/mUQiLur1onwuYvXQO6vxsKNh1PUkjiabvoBOhBGSrFyy2mE0VbMv6oMi8aCRzOky40KKVFgoawizfnH0KvP8NqRnkrfd3KFtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=cCjtkHOY; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="cCjtkHOY"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gVHNZ6hnNz1XM0p0;
	Tue,  2 Jun 2026 17:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1780420121; x=1783012122; bh=OWczc
	12zHtTadm/mAo61qOPIp7h2ZS1tVbH7NZW3m3Y=; b=cCjtkHOYqNpayG/eC3+uS
	HqwhYD1La9dp0h66lBrZi7DqnkRhgQVGjN97yEHdhrevrLLBXcNVfWfo1mIf2G6Q
	cAAxUQ5SdyEIHrDvjnho5OTkMhOctpFIemT26ywrxHAoS8QR9ZluUcj7FgJejLcn
	U5b+4iFqltI6jRd0QjD0/GZq8zveDuzm9JXqkEleGnjmEC74YXs2YxWJvL127Xw/
	Zfu31GlCznsubqHj0Ujflnq/KvUNAqFQY95poCOmslIKVDTsKctm/U0nTkkwPCS/
	ARirdVcLIWSVKcF7uE699jYdOgQrCc2Cuf4lUtBIPwYWw61/tkPXlN6c0uFmp8nF
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 385ktLZw4Pwb; Tue,  2 Jun 2026 17:08:41 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gVHNR5Xm8z1XM0p7;
	Tue,  2 Jun 2026 17:08:39 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v6 12/14] block/Kyber: Make the lock context annotations compatible with Clang
Date: Tue,  2 Jun 2026 10:07:41 -0700
Message-ID: <316fd1a98523bd05f42a3b0f2b2cf16ae6972124.1780419600.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
In-Reply-To: <cover.1780419600.git.bvanassche@acm.org>
References: <cover.1780419600.git.bvanassche@acm.org>
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
