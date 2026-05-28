Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F1C32ED58
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 19:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997599; cv=none; b=kiaJDSwS4vsbgAcvXhDtMP7B+2tq4muFz2SDid0Ctta6c0RCS2WcS5MAEyaEImy6MAir5pbTyDkvm8FZU40zgxj9BhGYTDPCF6+zbJHJwb4/vrr8rIF7aXAOOz7Bmu9efZpGJhvXL/0heDWBWk1TJyhDbOWUZrtNDGfP4Mp6jRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997599; c=relaxed/simple;
	bh=TSqaXIzovtlie/fKjnGMo4KUeFfNRuEqeJgz6HqCtBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVcJQJoBpxuBp71xE7rRlPL+p5H0j5D2wpoIAtzTj8j+2TkDAPP6cJnnM5qmgliuLKscAQoKTIxE/eMdl6PcjvsKMDjRN0i1AJDfLWDTQ5Cv3jkfykxMNsiYNgWD/BqiAHxbv+uBMBteqRyqvpVbJwMZJMdd3/7dqJ9SY43s4mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=cKekBe0J; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="cKekBe0J"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gRH7222m0z1XM0pZ;
	Thu, 28 May 2026 19:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1779997592; x=1782589593; bh=K5Ons
	IMUWEO3f7Puk/LNleG4Sv8GRVFLQTnM11h4cqM=; b=cKekBe0JagUlg44Xih5m6
	/hGWcT4M9w9BRFF97/Irn4yFhJl1l8Dtk4i5QFankxhGU81fkvX/DU8b4kkUEMKy
	Be0MYVjXJjOX737PH1P4Dc94V2RtNguF3ppqKGi6HcYaq9oGMs9gr0oOt8ecdCMf
	vdiUL2ADqdO8+L5jWTgdpRuoirGZdET6Jil7o/TkA/5ws9Dr3f7Ul8HeT1ijlTV0
	FyCNOlc69ftWr8+Mbut5ynHH5voNkzHdqBj+8aDXvArvVEspuRzEqX+4L5ADgmmM
	Xu6kAx9lGLi8rGjnGHs9Yw3xQR5z4Z8rKDxvv2DvN2cm5pXjGehdc+cQ52n9V5mx
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Gzt72xSXT-XH; Thu, 28 May 2026 19:46:32 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gRH6v3JcKz1XM0ph;
	Thu, 28 May 2026 19:46:31 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v5 11/12] block/mq-deadline: Make the lock context annotations compatible with Clang
Date: Thu, 28 May 2026 12:45:48 -0700
Message-ID: <be44a8b8ed93792d33b07de74c971d1a8a5703f8.1779997063.git.bvanassche@acm.org>
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
