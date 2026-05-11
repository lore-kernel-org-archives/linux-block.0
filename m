Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C0C466B4B
	for <linux-block@vger.kernel.org>; Mon, 11 May 2026 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517100; cv=none; b=I3humTIilIIWLwhS8fth1QSJtGkAAzFT4/BBsy8NCPJdIqcZy5jaoFv+o7UOrCjMwd6z4oDcjr0rXvrhmHYhU4QjxsEmVAssrbVQQ00Fvscq1hdbXs4zCd3OPOOd+hOgtPpTIPCxOklT8lOokZFUJGB/a3UiMBkrZAOxl1NcUUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517100; c=relaxed/simple;
	bh=B8P70B7NwGvY0IhombkfYC1c/SxCpj/tPu6on2PWZqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSDKp7sToGDHz7z62FZ0+8+uTCjb8vMI3pXyLw0xwe1my1VeZlVu00ErjckmJykltKLmC18nbVeNIkdgn3TutkbVgV44O8H4A6RnDDdF9NPbYL6Y8cQcSIoxdKch7jICJjEx9M/cMRk+ySPHuN7jBaKkUqQyvpfTSWQmXRo4ujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=f23+gzbW; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="f23+gzbW"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gDlbt2MJ1zlh2fr;
	Mon, 11 May 2026 16:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1778517094; x=1781109095; bh=gm0fK
	XTgCPJyE/KLGPmM82EHDPIjy2z8ZOamO/6aJJo=; b=f23+gzbWCq7mKpF+Zq5O/
	wkZ0hbbAaia2GyVmjcGyKmxe447BowHu8oI4iwyOkwO0XfcWIBkCwE0VhKqVO2a4
	eX7le5iw7ld1ff9YBvF/VX8lpVT8GjEeVrb3Y+AbKuDbcIqqeeg/3tPUljWiNbkI
	56xjP7mSZxP4IslekXLH9qB845jJp6/u7K1iPMBAUQPNNuDGcq9WqqzSKaCdvF0D
	Td1gHy+Y/rMqBm8UqQin9dYEqJwIt/Mvuegouknez+GVyyvP+yMrImvCdKQjhnYR
	PUHyTYHKjXZ6igJexlWgmmADU9El6q2Bj2E+nvyHEQk7LgDtVgEtkvcAulP2JVVn
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id c28FSF2zOO51; Mon, 11 May 2026 16:31:34 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gDlbm6GWCzlfl5V;
	Mon, 11 May 2026 16:31:32 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v4 10/12] block/kyber: Make the lock context annotations compatible with Clang
Date: Mon, 11 May 2026 09:30:52 -0700
Message-ID: <20260511163100.1887263-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
In-Reply-To: <20260511163100.1887263-1-bvanassche@acm.org>
References: <20260511163100.1887263-1-bvanassche@acm.org>
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
