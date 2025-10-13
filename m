Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0F52D97B8
	for <linux-block@vger.kernel.org>; Mon, 13 Oct 2025 19:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760383713; cv=none; b=YfQ9g4pY5RSTMfC10HnZH9BAOsxNCkkKh4fUeXpFYtMJkSpzBpvnSvKM643diK+uZbgLMDEx0Ovox+uVs9WEGl1/BH8aqXp07iTTzn3uVHk8P8MxEQce1lmSWmNP6mMXGXes1oG3oKFgd4tkX06kbd0AgOtZXmL1BezI3KNSz6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760383713; c=relaxed/simple;
	bh=EzBR0TN6lzba25miy8jnbCzmiQjnW3HZ+A/JHHqa6oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ynrq7wUwSSlKEis9XKVsgZduc6y4vpVAJ6IaZrV8s4RWfR7snOthmf9TYiie+nVDr3qnwPKQ852wOjnUiu5NTmSaAeZcEKTet9kEoXV0Xh4GAtPTjFBJp0/iu3A1eL//bfpsTQmmT5NqevfriwSf43LsGJfuA4I3aOUwxkhEbyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=aLxIHzvF; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="aLxIHzvF"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4clnSt4kXjzm0yTm;
	Mon, 13 Oct 2025 19:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1760383709; x=1762975710; bh=YnAhv
	cmePKiAyoLtaB76iwf0aBM7cCvIWuAAshMZ/Bc=; b=aLxIHzvFOrO+CVYCeer8F
	xPsvCTC7XjN5M2DpVT0lDkIBvKfOKsD5gu1F7+G267OpgNrRLd5c0/RiQYl1XT5d
	ITdFws3nFkKYXhQqzOzR5fSOrvEJMCswQp+T+FL+lX4Dl8bSIiTADPjtiJ5LO1K0
	4ix3B/baCvrCGXhfzA2xXUjBAHmOtnA2oX3FOd3IpcJCOwpNCyFPs3IIQr2KXwYy
	X/1U5ltRvKVI9rn1iltxbl7w4yDUa1l28xfFSb0p7sp4qrp6A9V9jwpB9xqQMXJN
	ncP/mrNYf0SIdversUe+3DKlHUHfA7OrxlE164wMjrIBJ815KD3v6VfdnKDRiL6V
	g==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id LywbxuVcN_K3; Mon, 13 Oct 2025 19:28:29 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4clnSm5cGTzm0yT2;
	Mon, 13 Oct 2025 19:28:24 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Yu Kuai <yukuai@kernel.org>,
	chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH 2/2] block/mq-deadline: Switch back to a single dispatch list
Date: Mon, 13 Oct 2025 12:28:03 -0700
Message-ID: <20251013192803.4168772-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.0.760.g7b8bcc2412-goog
In-Reply-To: <20251013192803.4168772-1-bvanassche@acm.org>
References: <20251013192803.4168772-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit c807ab520fc3 ("block/mq-deadline: Add I/O priority support")
modified the behavior of request flag BLK_MQ_INSERT_AT_HEAD from
dispatching a request before other requests into dispatching a request
before other requests with the same I/O priority. This is not correct sin=
ce
BLK_MQ_INSERT_AT_HEAD is used when requeuing requests and also when a flu=
sh
request is inserted.  Both types of requests should be dispatched as soon
as possible. Hence, make the mq-deadline I/O scheduler again ignore the I=
/O
priority for BLK_MQ_INSERT_AT_HEAD requests.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Yu Kuai <yukuai@kernel.org>
Reported-by: chengkaitao <chengkaitao@kylinos.cn>
Closes: https://lore.kernel.org/linux-block/20251009155253.14611-1-pilgri=
mtao@gmail.com/
Fixes: c807ab520fc3 ("block/mq-deadline: Add I/O priority support")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 107 +++++++++++++++++++-------------------------
 1 file changed, 47 insertions(+), 60 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 647a45f6d935..3e3719093aec 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -71,7 +71,6 @@ struct io_stats_per_prio {
  * present on both sort_list[] and fifo_list[].
  */
 struct dd_per_prio {
-	struct list_head dispatch;
 	struct rb_root sort_list[DD_DIR_COUNT];
 	struct list_head fifo_list[DD_DIR_COUNT];
 	/* Position of the most recently dispatched request. */
@@ -84,6 +83,7 @@ struct deadline_data {
 	 * run time data
 	 */
=20
+	struct list_head dispatch;
 	struct dd_per_prio per_prio[DD_PRIO_COUNT];
=20
 	/* Data direction of latest dispatched request. */
@@ -332,16 +332,6 @@ static struct request *__dd_dispatch_request(struct =
deadline_data *dd,
=20
 	lockdep_assert_held(&dd->lock);
=20
-	if (!list_empty(&per_prio->dispatch)) {
-		rq =3D list_first_entry(&per_prio->dispatch, struct request,
-				      queuelist);
-		if (started_after(dd, rq, latest_start))
-			return NULL;
-		list_del_init(&rq->queuelist);
-		data_dir =3D rq_data_dir(rq);
-		goto done;
-	}
-
 	/*
 	 * batches are currently reads XOR writes
 	 */
@@ -421,7 +411,6 @@ static struct request *__dd_dispatch_request(struct d=
eadline_data *dd,
 	 */
 	dd->batching++;
 	deadline_move_request(dd, per_prio, rq);
-done:
 	return dd_start_request(dd, data_dir, rq);
 }
=20
@@ -469,6 +458,14 @@ static struct request *dd_dispatch_request(struct bl=
k_mq_hw_ctx *hctx)
 	enum dd_prio prio;
=20
 	spin_lock(&dd->lock);
+
+	if (!list_empty(&dd->dispatch)) {
+		rq =3D list_first_entry(&dd->dispatch, struct request, queuelist);
+		list_del_init(&rq->queuelist);
+		dd_start_request(dd, rq_data_dir(rq), rq);
+		goto unlock;
+	}
+
 	rq =3D dd_dispatch_prio_aged_requests(dd, now);
 	if (rq)
 		goto unlock;
@@ -557,10 +554,10 @@ static int dd_init_sched(struct request_queue *q, s=
truct elevator_queue *eq)
=20
 	eq->elevator_data =3D dd;
=20
+	INIT_LIST_HEAD(&dd->dispatch);
 	for (prio =3D 0; prio <=3D DD_PRIO_MAX; prio++) {
 		struct dd_per_prio *per_prio =3D &dd->per_prio[prio];
=20
-		INIT_LIST_HEAD(&per_prio->dispatch);
 		INIT_LIST_HEAD(&per_prio->fifo_list[DD_READ]);
 		INIT_LIST_HEAD(&per_prio->fifo_list[DD_WRITE]);
 		per_prio->sort_list[DD_READ] =3D RB_ROOT;
@@ -664,7 +661,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *h=
ctx, struct request *rq,
 	trace_block_rq_insert(rq);
=20
 	if (flags & BLK_MQ_INSERT_AT_HEAD) {
-		list_add(&rq->queuelist, &per_prio->dispatch);
+		list_add(&rq->queuelist, &dd->dispatch);
 		rq->fifo_time =3D jiffies;
 	} else {
 		deadline_add_rq_rb(per_prio, rq);
@@ -731,8 +728,7 @@ static void dd_finish_request(struct request *rq)
=20
 static bool dd_has_work_for_prio(struct dd_per_prio *per_prio)
 {
-	return !list_empty_careful(&per_prio->dispatch) ||
-		!list_empty_careful(&per_prio->fifo_list[DD_READ]) ||
+	return !list_empty_careful(&per_prio->fifo_list[DD_READ]) ||
 		!list_empty_careful(&per_prio->fifo_list[DD_WRITE]);
 }
=20
@@ -741,6 +737,9 @@ static bool dd_has_work(struct blk_mq_hw_ctx *hctx)
 	struct deadline_data *dd =3D hctx->queue->elevator->elevator_data;
 	enum dd_prio prio;
=20
+	if (!list_empty_careful(&dd->dispatch))
+		return true;
+
 	for (prio =3D 0; prio <=3D DD_PRIO_MAX; prio++)
 		if (dd_has_work_for_prio(&dd->per_prio[prio]))
 			return true;
@@ -949,49 +948,39 @@ static int dd_owned_by_driver_show(void *data, stru=
ct seq_file *m)
 	return 0;
 }
=20
-#define DEADLINE_DISPATCH_ATTR(prio)					\
-static void *deadline_dispatch##prio##_start(struct seq_file *m,	\
-					     loff_t *pos)		\
-	__acquires(&dd->lock)						\
-{									\
-	struct request_queue *q =3D m->private;				\
-	struct deadline_data *dd =3D q->elevator->elevator_data;		\
-	struct dd_per_prio *per_prio =3D &dd->per_prio[prio];		\
-									\
-	spin_lock(&dd->lock);						\
-	return seq_list_start(&per_prio->dispatch, *pos);		\
-}									\
-									\
-static void *deadline_dispatch##prio##_next(struct seq_file *m,		\
-					    void *v, loff_t *pos)	\
-{									\
-	struct request_queue *q =3D m->private;				\
-	struct deadline_data *dd =3D q->elevator->elevator_data;		\
-	struct dd_per_prio *per_prio =3D &dd->per_prio[prio];		\
-									\
-	return seq_list_next(v, &per_prio->dispatch, pos);		\
-}									\
-									\
-static void deadline_dispatch##prio##_stop(struct seq_file *m, void *v)	=
\
-	__releases(&dd->lock)						\
-{									\
-	struct request_queue *q =3D m->private;				\
-	struct deadline_data *dd =3D q->elevator->elevator_data;		\
-									\
-	spin_unlock(&dd->lock);						\
-}									\
-									\
-static const struct seq_operations deadline_dispatch##prio##_seq_ops =3D=
 { \
-	.start	=3D deadline_dispatch##prio##_start,			\
-	.next	=3D deadline_dispatch##prio##_next,			\
-	.stop	=3D deadline_dispatch##prio##_stop,			\
-	.show	=3D blk_mq_debugfs_rq_show,				\
+static void *deadline_dispatch_start(struct seq_file *m, loff_t *pos)
+	__acquires(&dd->lock)
+{
+	struct request_queue *q =3D m->private;
+	struct deadline_data *dd =3D q->elevator->elevator_data;
+
+	spin_lock(&dd->lock);
+	return seq_list_start(&dd->dispatch, *pos);
 }
=20
-DEADLINE_DISPATCH_ATTR(0);
-DEADLINE_DISPATCH_ATTR(1);
-DEADLINE_DISPATCH_ATTR(2);
-#undef DEADLINE_DISPATCH_ATTR
+static void *deadline_dispatch_next(struct seq_file *m, void *v, loff_t =
*pos)
+{
+	struct request_queue *q =3D m->private;
+	struct deadline_data *dd =3D q->elevator->elevator_data;
+
+	return seq_list_next(v, &dd->dispatch, pos);
+}
+
+static void deadline_dispatch_stop(struct seq_file *m, void *v)
+	__releases(&dd->lock)
+{
+	struct request_queue *q =3D m->private;
+	struct deadline_data *dd =3D q->elevator->elevator_data;
+
+	spin_unlock(&dd->lock);
+}
+
+static const struct seq_operations deadline_dispatch_seq_ops =3D {
+	.start	=3D deadline_dispatch_start,
+	.next	=3D deadline_dispatch_next,
+	.stop	=3D deadline_dispatch_stop,
+	.show	=3D blk_mq_debugfs_rq_show,
+};
=20
 #define DEADLINE_QUEUE_DDIR_ATTRS(name)					\
 	{#name "_fifo_list", 0400,					\
@@ -1014,9 +1003,7 @@ static const struct blk_mq_debugfs_attr deadline_qu=
eue_debugfs_attrs[] =3D {
 	{"batching", 0400, deadline_batching_show},
 	{"starved", 0400, deadline_starved_show},
 	{"async_depth", 0400, dd_async_depth_show},
-	{"dispatch0", 0400, .seq_ops =3D &deadline_dispatch0_seq_ops},
-	{"dispatch1", 0400, .seq_ops =3D &deadline_dispatch1_seq_ops},
-	{"dispatch2", 0400, .seq_ops =3D &deadline_dispatch2_seq_ops},
+	{"dispatch", 0400, .seq_ops =3D &deadline_dispatch_seq_ops},
 	{"owned_by_driver", 0400, dd_owned_by_driver_show},
 	{"queued", 0400, dd_queued_show},
 	{},
