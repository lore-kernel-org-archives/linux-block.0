Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70296381AE4
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 18:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682533; cv=none; b=p5R8aS7KiWDH9A2/tPGqPjTZiKsAtgZp5KUUJLKQgrtakluyBf2+wV0eE2X3vOa3eBnAaAtH5Xht3nsHLh8APzmuq4eMXDEIwaofBRQOwSV9Ra+lNyHr4qKCe7sDkuI1i5EuxmfrGF+Q+yH98y4QyqjH5/IsnuBKuxZVDwgd4rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682533; c=relaxed/simple;
	bh=0AjjdLaURGtpD+4A421goT669ZzUhaOeY137DTxtA4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ex0jXrkx5VjkTRIEhvIdp84lbybmaX4f3alMSYxl6wQvLIGTXhEPYZTHEuaSJMIr0FWpm5VLXJkeGCWHKmeTJM8HgKDDinyK3iEQxfz/7yPdYvwczpdC7SOP0X+wwHXYzB38OdTQFoaQ7Xj98+2UZmwIdx3YBhdeA2rd5sjIV3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=wAiZhzHL; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="wAiZhzHL"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gX8Qp6VT1z1XM0ny;
	Fri,  5 Jun 2026 18:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1780682525; x=1783274526; bh=d9MNI
	2OTzJ1W2fdPLD42pRpSaujg+1uWz+WLRL6AD1I=; b=wAiZhzHLDaAHI5v6SUpBv
	uISlfkPOR+23pEx+xyFqmS60bP5a+l2geMamIlIHR038Qh9gKyqJvzSuCttu3MF7
	Q/Zu0bhEdwf+LJC8qI3Nlla32piTVORydPCIBgV53OHzruOujTgIlAO7GOW3a1g+
	tuMtLPhckG94GOp/DGCnU0R4+xvLwUJgdYcpVoocCtU3+vSnbiTw5aSkPmsO4lto
	UVU4NS610ENGNGODiG8yOR8uLyO6xkMzEvyKsJjMOQ2ZppOwEx9r7Ufaq1QpDl62
	hWRn/poZmIIaBHVeOYONYAbM0Oc0SzqWDxI+hlcO469ULy7Gs41jPJLWnlKcjwOk
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id g7tNRJXS_T5k; Fri,  5 Jun 2026 18:02:05 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gX8Qg539kz1XM31H;
	Fri,  5 Jun 2026 18:02:03 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v7 13/14] block/mq-deadline: Make the lock context annotations compatible with Clang
Date: Fri,  5 Jun 2026 11:01:06 -0700
Message-ID: <3b6e336ced91e27213608ffce205ccd24f4ba285.1780682325.git.bvanassche@acm.org>
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
