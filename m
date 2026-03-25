Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4326396573
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475163; cv=none; b=DPUps6sbneDWzlLezYgpFWJJ656ch5LuDqzOUkz24CeizsnnA6PeUcp3CtM9Mar2crPD4VRQntw4nVmxpj8SsZFNYykc7lHLBrGVa4KfhX3pHFHBKJmIEZviGexnreUbjJCmKKRk1XpD+JT5ADho3zGi1fJ+b4Vnl00OM8WHno4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475163; c=relaxed/simple;
	bh=R4da2b0IfEMs/daZccGFXkF4HRUXQbYuW+fA4C1/xlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQLN/m7gd7gf/2eiz6Mz9x4KygG3uIgeNboc3H+vdatf5eu7HvQKM+dn7W5ahH7EX2AGOtq/kuLJ+kXrvjg6jBh0lxJ3fZqYG01E1XFNuIb8HhkmbtMsrNS4Du8jYRxqm7x1Sv0qpaQv/m0+/d93KlfVJXkPKuS2dn4HMJ1bgTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=aO8SbUFv; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="aO8SbUFv"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0pL29KtzlfpMC;
	Wed, 25 Mar 2026 21:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774475158; x=1777067159; bh=Mrdoi
	z/zHa1MdgoYTwMzYKCspC4zql6E37/1FWObays=; b=aO8SbUFvVVX9bCZaa47NR
	BnFHPlI7I62rV0l447KFPaNp6WXZFzDpECXqW3x0I5uHTLAQ7oTC7e1cRY9cpJB9
	3agc7j6r2BD6+m6CMDhOOOIXWytVTNCZE3p2Lq3QXUXU51VT1Hve8BFh4KjPREhG
	SJqmYWWgOVwdHlDG/tLKi80Yw6uyqCUsBYg9hmZEEUEE4JLCg0bEaHgtEZWKwElb
	68Pe+mPNDhtUAhtK//m637MURADw5T3Zpl7FdqYcqKABYKtNniQVn41DUwPu5C6X
	/pMn/L22LYQVI2H08DcHfzjAVQu7Pw2BT/pjmAyh8ZcNVjNAiBoYq+9WiwLHX3b7
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 7HgM4lnxzB3Z; Wed, 25 Mar 2026 21:45:58 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0pD3htJzlgyGs;
	Wed, 25 Mar 2026 21:45:56 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 12/26] block/mq-deadline: Make the lock context annotations compatible with Clang
Date: Wed, 25 Mar 2026 14:44:53 -0700
Message-ID: <20260325214518.2854494-13-bvanassche@acm.org>
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
