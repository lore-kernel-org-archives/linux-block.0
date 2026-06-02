Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F915375F8A
	for <linux-block@vger.kernel.org>; Tue,  2 Jun 2026 17:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420130; cv=none; b=d2pdxeme9hlYKOTInVaJv01mlL+W4NqpDEIojJ8N5oYlHAZMbAlBSJ8K22HqjSouZ9FquVTC+cE5nc9Piwwr/ja3Fh4wykqudYSr4VH//EUsoHQHq/I/cOyet8nZVLv4MJ+/z18WEFRevZZVre7iInvW0Atm+08C3u0fabCaOUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420130; c=relaxed/simple;
	bh=0AjjdLaURGtpD+4A421goT669ZzUhaOeY137DTxtA4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aa53y0h8/HsHHC5GfX9TiDxg2r5wG8HtoEcHe5emELegtoo1nRUvWEBQHb3v3HNsIpujz+nFU22EK+DZvMKnPq95O6pbVGcpn0QkrJU/5hDO8j1RgFNQXfXLTLO44f06mRLp1FQ9dYji8rs8Qr8wmIGULln9qpCDRn+PzbBD+LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=G20CODpy; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="G20CODpy"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gVHNd0jjkz1XM0p7;
	Tue,  2 Jun 2026 17:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1780420123; x=1783012124; bh=d9MNI
	2OTzJ1W2fdPLD42pRpSaujg+1uWz+WLRL6AD1I=; b=G20CODpye2MWIDkojaM6g
	h/tswL06FUzqTjxT38yyh3ku6zAvzGiQMTpnefFkt35VdK9amlJ6QaQT6HqQod63
	OrhsmyKpu3eGlinLfFpUaGCBaCBqC/VDzIOXgbb050aAKkuHjlLx/tYj51+ySiod
	HUX13NrxweLa+AGeiI1evzcX0bv7QlBxG4yO5FAtYCLYLqf5aKVadWjmBsUcL9/a
	F+y5osZQ4X13Y8gV+lb7ZiVmKX6hby4vFBctgjeO+c26xKREAFo/JTcksLUZHYSm
	w0xTpndRAg4NgzoVt5ymG+gQ/7p4Usnj4vLOCJQ2r4uu9M1Qami/mjPDcupxXB+R
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 1IZRhLbjwV6P; Tue,  2 Jun 2026 17:08:43 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gVHNV1RFQz1XM0p2;
	Tue,  2 Jun 2026 17:08:41 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v6 13/14] block/mq-deadline: Make the lock context annotations compatible with Clang
Date: Tue,  2 Jun 2026 10:07:42 -0700
Message-ID: <41277d6a7299c948f16c9e74ef3ceb5f2aa971d0.1780419600.git.bvanassche@acm.org>
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
 block/mq-deadline.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 95917a88976f..824bfc17b2c6 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -794,11 +794,15 @@ static const struct elv_fs_entry deadline_attrs[] =3D=
 {
 	__ATTR_NULL
 };
=20
+#define RQ_FROM_SEQ_FILE(m) ((struct request_queue *)(m)->private)
+#define DD_DATA_FROM_RQ(rq)					\
+	((struct deadline_data *)(rq)->elevator->elevator_data)
+
 #ifdef CONFIG_BLK_DEBUG_FS
 #define DEADLINE_DEBUGFS_DDIR_ATTRS(prio, data_dir, name)		\
 static void *deadline_##name##_fifo_start(struct seq_file *m,		\
 					  loff_t *pos)			\
-	__acquires(&dd->lock)						\
+	__acquires(&DD_DATA_FROM_RQ(RQ_FROM_SEQ_FILE(m))->lock)		\
 {									\
 	struct request_queue *q =3D m->private;				\
 	struct deadline_data *dd =3D q->elevator->elevator_data;		\
@@ -819,7 +823,7 @@ static void *deadline_##name##_fifo_next(struct seq_f=
ile *m, void *v,	\
 }									\
 									\
 static void deadline_##name##_fifo_stop(struct seq_file *m, void *v)	\
-	__releases(&dd->lock)						\
+	__releases(&DD_DATA_FROM_RQ(RQ_FROM_SEQ_FILE(m))->lock)		\
 {									\
 	struct request_queue *q =3D m->private;				\
 	struct deadline_data *dd =3D q->elevator->elevator_data;		\
@@ -921,7 +925,7 @@ static int dd_owned_by_driver_show(void *data, struct=
 seq_file *m)
 }
=20
 static void *deadline_dispatch_start(struct seq_file *m, loff_t *pos)
-	__acquires(&dd->lock)
+	__acquires(&DD_DATA_FROM_RQ(RQ_FROM_SEQ_FILE(m))->lock)
 {
 	struct request_queue *q =3D m->private;
 	struct deadline_data *dd =3D q->elevator->elevator_data;
@@ -939,7 +943,7 @@ static void *deadline_dispatch_next(struct seq_file *=
m, void *v, loff_t *pos)
 }
=20
 static void deadline_dispatch_stop(struct seq_file *m, void *v)
-	__releases(&dd->lock)
+	__releases(&DD_DATA_FROM_RQ(RQ_FROM_SEQ_FILE(m))->lock)
 {
 	struct request_queue *q =3D m->private;
 	struct deadline_data *dd =3D q->elevator->elevator_data;
