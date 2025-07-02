Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB172E4982
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751480698; cv=none; b=nqL904AjsIrFo3lLQaqXLR7us67P4u7nM6AD5Hf2IY/COI3N6Cy4ROzsTcWNLwJ8nScbW32b+6Vj7qE/PiU5JYV6lCvPwBWSJ3422wp1S0HWaTBvg5VVFVQ4ZmPEH2bHswGJkiOI2oX1NCPPLxYz+E7jRRportVKoFmDdofqoQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751480698; c=relaxed/simple;
	bh=vBR9LSHhf71O7OJEFUZowQv+J+xWNCeO5cPcVonETgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pd1lMUYd/YlIIWpMfwlx12mYrvAMYd2qyzBTZm3S7+iwc04SPbu6VMVLhsQos/mV+O0g/ZcsEYoud1soPcqGkiIBO8hBsqUSPr/3FbWh7gG63+tP/43aJHSxlykheD9DH5hJyzUNDIix7eRFpywQ1Q/vecFh75DvTGUj5W5a7bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=FMn7hjLx; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="FMn7hjLx"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bXSx35cnRzm0XBf;
	Wed,  2 Jul 2025 18:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1751480694; x=1754072695; bh=adqWi
	tcL3341+rt5YY9AEoDQOlTVjwoyEodX0mSmOjM=; b=FMn7hjLxhpu9yj4BI1mcp
	WT+UgwFdsEXQtZcaoMe5ZH9JFzTPdEytOkJ2Y4B3BU563OOn7k0WWwTiyZcTuF1j
	pCLKPUdwXMOP2ePBgoOwFd4b5AjYL6Gs5UU+/x5F42dQbzmuUbPirHPE5afA8acF
	qt0VFIxdjEXlRSAH5fxGawLRaQLAMo7O6lYd93liAQA5UZjtYu1kqayiQkOBITJp
	rxiWhjsFGi0ewDca/VODQ45sIivuQxvR0i68+fLV+NQQ9M2jJaX2GzdfuW30gL9T
	uaJBRg3HQZCAgF+J4IQXUcO9G30TpdusvmZFMLNFKBJkhWrwWt0UV1TuRRTB4mFf
	w==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id msohUBJ4XKcu; Wed,  2 Jul 2025 18:24:54 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bXSwz3vndzm0bgd;
	Wed,  2 Jul 2025 18:24:50 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 2/3] block: Restrict the duration of sysfs attribute changes
Date: Wed,  2 Jul 2025 11:24:29 -0700
Message-ID: <20250702182430.3764163-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250702182430.3764163-1-bvanassche@acm.org>
References: <20250702182430.3764163-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Freezing the request queue from inside sysfs store callbacks may cause a
deadlock in combination with the dm-multipath driver and the
queue_if_no_path option. Fix this by restricting how long to wait until
the queue is frozen inside the remaining sysfs callback methods that
freeze the request queue.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Nilay Shroff <nilay@linux.ibm.com>
Fixes: af2814149883 ("block: freeze the queue in queue_attr_store")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c         | 14 ++++++++++++++
 block/blk-settings.c   | 32 ++++++++++++++++++++++++++++++++
 block/blk-sysfs.c      | 19 +++++++++++--------
 include/linux/blk-mq.h |  2 ++
 include/linux/blkdev.h |  2 ++
 5 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 532acdbe9e16..23fd8db663d9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -191,6 +191,7 @@ void blk_mq_freeze_queue_wait(struct request_queue *q=
)
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait);
=20
+/* Returns > 0 upon success; 0 upon failure. */
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout)
 {
@@ -207,6 +208,19 @@ void blk_mq_freeze_queue_nomemsave(struct request_qu=
eue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_nomemsave);
=20
+/*
+ * Try to freeze @q. Returns 0 if successful or a negative value if free=
zing @q
+ * did not succeed before the timeout expired.
+ */
+int blk_mq_freeze_queue_nomemsave_timeout(struct request_queue *q,
+					  unsigned long timeout)
+{
+	blk_freeze_queue_start(q);
+	if (blk_mq_freeze_queue_wait_timeout(q, timeout) <=3D 0)
+		return -EAGAIN;
+	return 0;
+}
+
 bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
 {
 	bool unfreeze;
diff --git a/block/blk-settings.c b/block/blk-settings.c
index a000daafbfb4..93225762a40d 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -487,6 +487,38 @@ int queue_limits_commit_update_frozen(struct request=
_queue *q,
 }
 EXPORT_SYMBOL_GPL(queue_limits_commit_update_frozen);
=20
+/**
+ * queue_limits_commit_update_frozen_timeout - commit an atomic update o=
f queue
+ *	limits
+ * @q:		queue to update
+ * @lim:	limits to apply
+ * @timeout:	maximum time to wait until @q is frozen
+ *
+ * Apply the limits in @lim that were obtained from queue_limits_start_u=
pdate()
+ * and updated with the new values by the caller to @q.  Freezes the que=
ue
+ * before the update and unfreezes it after.
+ *
+ * Returns 0 if successful, else a negative error code.
+ */
+int queue_limits_commit_update_frozen_timeout(struct request_queue *q,
+			struct queue_limits *lim, unsigned long timeout)
+{
+	unsigned int memflags;
+	int ret;
+
+	memflags =3D memalloc_noio_save();
+	ret =3D blk_mq_freeze_queue_nomemsave_timeout(q, timeout);
+	if (ret < 0) {
+		memalloc_flags_restore(memflags);
+		queue_limits_cancel_update(q);
+		return ret;
+	}
+	ret =3D queue_limits_commit_update(q, lim);
+	blk_mq_unfreeze_queue(q, memflags);
+
+	return ret;
+}
+
 /**
  * queue_limits_set - apply queue limits to queue
  * @q:		queue to update
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index ab34fe62f4da..c75901a55497 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -65,7 +65,7 @@ static ssize_t
 queue_requests_store(struct gendisk *disk, const char *page, size_t coun=
t)
 {
 	unsigned long nr;
-	int ret, err;
+	int ret;
 	unsigned int memflags;
 	struct request_queue *q =3D disk->queue;
=20
@@ -76,17 +76,18 @@ queue_requests_store(struct gendisk *disk, const char=
 *page, size_t count)
 	if (ret < 0)
 		return ret;
=20
-	memflags =3D blk_mq_freeze_queue(q);
+	memflags =3D memalloc_noio_save();
+	ret =3D blk_mq_freeze_queue_nomemsave_timeout(q, q->rq_timeout);
+	if (ret < 0)
+		return ret;
 	mutex_lock(&q->elevator_lock);
 	if (nr < BLKDEV_MIN_RQ)
 		nr =3D BLKDEV_MIN_RQ;
=20
-	err =3D blk_mq_update_nr_requests(disk->queue, nr);
-	if (err)
-		ret =3D err;
+	ret =3D blk_mq_update_nr_requests(disk->queue, nr);
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
-	return ret;
+	return ret < 0 ? ret : count;
 }
=20
 static ssize_t queue_ra_show(struct gendisk *disk, char *page)
@@ -582,7 +583,8 @@ static ssize_t queue_wb_lat_store(struct gendisk *dis=
k, const char *page,
 	if (val < -1)
 		return -EINVAL;
=20
-	memflags =3D blk_mq_freeze_queue(q);
+	memflags =3D memalloc_noio_save();
+	ret =3D blk_mq_freeze_queue_nomemsave_timeout(q, q->rq_timeout);
=20
 	rqos =3D wbt_rq_qos(q);
 	if (!rqos) {
@@ -782,7 +784,8 @@ queue_attr_store(struct kobject *kobj, struct attribu=
te *attr,
 			return res;
 		}
=20
-		res =3D queue_limits_commit_update_frozen(q, &lim);
+		res =3D queue_limits_commit_update_frozen_timeout(q, &lim,
+								q->rq_timeout);
 		if (res)
 			return res;
 		return length;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2a5a828f19a0..6665de1cd75e 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -925,6 +925,8 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *t=
agset,
 		busy_tag_iter_fn *fn, void *priv);
 void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset)=
;
 void blk_mq_freeze_queue_nomemsave(struct request_queue *q);
+int blk_mq_freeze_queue_nomemsave_timeout(struct request_queue *q,
+					  unsigned long timeout);
 void blk_mq_unfreeze_queue_nomemrestore(struct request_queue *q);
 static inline unsigned int __must_check
 blk_mq_freeze_queue(struct request_queue *q)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a51f92b6c340..dc00a0f4bd28 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1059,6 +1059,8 @@ queue_limits_start_update(struct request_queue *q)
 }
 int queue_limits_commit_update_frozen(struct request_queue *q,
 		struct queue_limits *lim);
+int queue_limits_commit_update_frozen_timeout(struct request_queue *q,
+		struct queue_limits *lim, unsigned long timeout);
 int queue_limits_commit_update(struct request_queue *q,
 		struct queue_limits *lim);
 int queue_limits_set(struct request_queue *q, struct queue_limits *lim);
