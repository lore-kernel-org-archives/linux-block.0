Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51D246AEDF
	for <linux-block@vger.kernel.org>; Mon, 11 May 2026 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517102; cv=none; b=EdaZcPdYWncAi/GJ+jhw80kZBNQ5oD4o6j1oS5DX9n3eP9VESBQje/vXvihyhQ9xKnVDfhYN6tlgbjSPqYLjEoUi1YLl2PHVJnsMg4r+X1FIrywiddeJem9yFYP5cK4Cx1yu1/Qulqut7enuxtK7MV/CaZGf+HCH3jnNBxce8Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517102; c=relaxed/simple;
	bh=TSqaXIzovtlie/fKjnGMo4KUeFfNRuEqeJgz6HqCtBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKW6L0uuHCTeatGWqOgg3AhIw49Hvx4lLVLVjoUYMVcxfnLxZOnUeYk0VJ42Hjgec/sZFkkNfsN8Ujmwlmkx95y6JeAUJh1dbtm42ifOzi7jCV0uzAzNHJZVckyrJLtCWe5aKITmEGamT9YHJZyfCmYoFNYdpky0NUGM32TyRwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=eCG2Sa4W; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="eCG2Sa4W"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gDlbw38hzzlgtd1;
	Mon, 11 May 2026 16:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1778517096; x=1781109097; bh=K5Ons
	IMUWEO3f7Puk/LNleG4Sv8GRVFLQTnM11h4cqM=; b=eCG2Sa4WzA0NqHaPKZbA7
	MAAbJEYDOyv2ZP2KBirTO10NB2KCZqdOfXoBdcrv+H8UfL2//xZRw5Zm+Ufp8791
	Z9PVHZrHG/ppJBqTnPR2VzB7DZ22lA5FAfSIghMhJ9ixzUiGf+3ekDSWG4qiwFlu
	ayceq72b4t1q+oAZJ1+EjhQQL5T/vNNMvgetXk3rEp4KdSFmkXzw+N8oNsecBsL/
	FX5UYvESc8TylUdYankMLLGOoVAndfrczbUksnOEkqPfc+9OMLHFo+TxerXEYg94
	97Up1wgy96HIWFIQqTL8srSoI71kdcHtakFpd3crUvGU3YLwBNog2Sx5Y6yOBBaf
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fioqwGQ6_xN6; Mon, 11 May 2026 16:31:36 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gDlbp6zYNzlh2kn;
	Mon, 11 May 2026 16:31:34 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v4 11/12] block/mq-deadline: Make the lock context annotations compatible with Clang
Date: Mon, 11 May 2026 09:30:53 -0700
Message-ID: <20260511163100.1887263-12-bvanassche@acm.org>
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
