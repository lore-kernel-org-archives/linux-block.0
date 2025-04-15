Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7DF2DFA20
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 20:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744750358; cv=none; b=hjaO7m6j6ZZDSn5MyU+5mlqtgK+c/JDsRvcSxjdci4MAyvPGyDf8bQvjEkeh67/GwDJrCmIgpOWfI8IFCp5H7SUjs/dlLvvRM3jO+44ONypyT42/yoyt0Dt1IvqYjRnRHOtQJEvG1HNKe2YAkbN07xuYutjghj9UvPXJKvzm/xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744750358; c=relaxed/simple;
	bh=WhU7WmvW3fVyFBvQbYV0U+RQBS1dJl9yhcWMQE7CXPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ILFfzYnBWuhet8WGtnb9fcADUUQU+VRyeCg/8zH9j+/sBsGfxe9tmomyjVDBT1KpZhu5Tc8JF7ViOTiScPzPcg5iHvqpgzVWkCJZrjUfz43wkqjtoISrruAVR+VMtW7wskao9XpaeqCvhVIvg4NpoNWYEhjFwyp4HbwkLnsnzog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=GHic0Jdx; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="GHic0Jdx"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4ZcbvR0vq0zlw3g0;
	Tue, 15 Apr 2025 20:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1744750353; x=1747342354; bh=k07FZ8hLG8TBAbUVGyN7Rjd1ANWmv9J5jMd
	yX/2XacM=; b=GHic0Jdx6OlcmX388aajcjGTZ4BCqBDnwnudDSE9QMxNC45OSAH
	+DpCxaYxwZ3fBdWvNEQVhRXVlsvG860uKI0A7QX4O3E+ZNQH/CVUuuI9Sd+8hGNg
	X66I5PiZXqxdrmqSHx9IP7nzJdYBC6f/U0srUW4vBxbHIFWI81Cq4LudmRCaUb8m
	PLBZ+qmzwS+4U51fh4YGqtNOV6MoJxzy3yHGiN+CWxzcoWPxD25iKGKWqWzSLsBa
	RiFNl7jwl0/loyofDLCLkJVs46tLFlks57hf31zTcKqebx6kuzggA+3pevwyjlYu
	eqrK9I942aH1wNVfplw7/ZAUaB/ko+2ZJ9g==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id UpR6y_EgCDoy; Tue, 15 Apr 2025 20:52:33 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4ZcbvK4mN6zlw03x;
	Tue, 15 Apr 2025 20:52:28 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>,
	John Garry <john.g.garry@oracle.com>
Subject: [PATCH] block: Simplify blk_mq_dispatch_rq_list() and its callers
Date: Tue, 15 Apr 2025 13:51:34 -0700
Message-ID: <20250415205134.3650042-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The 'nr_budgets' argument of blk_mq_dispatch_rq_list() is either the
number of elements in the 'list' argument or zero. Instead of passing
the number of list elements to blk_mq_dispatch_rq_list(), pass a boolean
argument that indicates whether or not blk_mq_dispatch_rq_list() should
request the block driver for a budget for each request in 'list'.

Remove the code for counting list elements from blk_mq_dispatch_rq_list()
callers where possible. Remove the code that decrements nr_budgets from
blk_mq_dispatch_rq_list() because it is superfluous. Each request that
is processed by blk_mq_dispatch_rq_list() is in one of these two states
if 'get_budget' is false:
* Either the request is on 'list' and the budget for the request has to
  be released from the error path.
* Or the request is not on 'list' and q->mq_ops->queue_rq() has already
  released the budget (ret !=3D BLK_STS_OK) or q->mq_ops->queue_rq() will
  release the budget asynchronously (ret =3D=3D BLK_STS_OK).

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: John Garry <john.g.garry@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-sched.c | 12 +++++-------
 block/blk-mq.c       | 16 +++++++---------
 block/blk-mq.h       |  2 +-
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 109611445d40..9b81771774ef 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -59,19 +59,17 @@ static bool blk_mq_dispatch_hctx_list(struct list_hea=
d *rq_list)
 		list_first_entry(rq_list, struct request, queuelist)->mq_hctx;
 	struct request *rq;
 	LIST_HEAD(hctx_list);
-	unsigned int count =3D 0;
=20
 	list_for_each_entry(rq, rq_list, queuelist) {
 		if (rq->mq_hctx !=3D hctx) {
 			list_cut_before(&hctx_list, rq_list, &rq->queuelist);
 			goto dispatch;
 		}
-		count++;
 	}
 	list_splice_tail_init(rq_list, &hctx_list);
=20
 dispatch:
-	return blk_mq_dispatch_rq_list(hctx, &hctx_list, count);
+	return blk_mq_dispatch_rq_list(hctx, &hctx_list, false);
 }
=20
 #define BLK_MQ_BUDGET_DELAY	3		/* ms units */
@@ -167,7 +165,7 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_h=
w_ctx *hctx)
 			dispatched |=3D blk_mq_dispatch_hctx_list(&rq_list);
 		} while (!list_empty(&rq_list));
 	} else {
-		dispatched =3D blk_mq_dispatch_rq_list(hctx, &rq_list, count);
+		dispatched =3D blk_mq_dispatch_rq_list(hctx, &rq_list, false);
 	}
=20
 	if (busy)
@@ -261,7 +259,7 @@ static int blk_mq_do_dispatch_ctx(struct blk_mq_hw_ct=
x *hctx)
 		/* round robin for fair dispatch */
 		ctx =3D blk_mq_next_ctx(hctx, rq->mq_ctx);
=20
-	} while (blk_mq_dispatch_rq_list(rq->mq_hctx, &rq_list, 1));
+	} while (blk_mq_dispatch_rq_list(rq->mq_hctx, &rq_list, false));
=20
 	WRITE_ONCE(hctx->dispatch_from, ctx);
 	return ret;
@@ -298,7 +296,7 @@ static int __blk_mq_sched_dispatch_requests(struct bl=
k_mq_hw_ctx *hctx)
 	 */
 	if (!list_empty(&rq_list)) {
 		blk_mq_sched_mark_restart_hctx(hctx);
-		if (!blk_mq_dispatch_rq_list(hctx, &rq_list, 0))
+		if (!blk_mq_dispatch_rq_list(hctx, &rq_list, true))
 			return 0;
 		need_dispatch =3D true;
 	} else {
@@ -312,7 +310,7 @@ static int __blk_mq_sched_dispatch_requests(struct bl=
k_mq_hw_ctx *hctx)
 	if (need_dispatch)
 		return blk_mq_do_dispatch_ctx(hctx);
 	blk_mq_flush_busy_ctxs(hctx, &rq_list);
-	blk_mq_dispatch_rq_list(hctx, &rq_list, 0);
+	blk_mq_dispatch_rq_list(hctx, &rq_list, true);
 	return 0;
 }
=20
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c2697db59109..e0fe12f1320f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2080,7 +2080,7 @@ static void blk_mq_commit_rqs(struct blk_mq_hw_ctx =
*hctx, int queued,
  * Returns true if we did some work AND can potentially do more.
  */
 bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_hea=
d *list,
-			     unsigned int nr_budgets)
+			     bool get_budget)
 {
 	enum prep_dispatch prep;
 	struct request_queue *q =3D hctx->queue;
@@ -2102,7 +2102,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *=
hctx, struct list_head *list,
 		rq =3D list_first_entry(list, struct request, queuelist);
=20
 		WARN_ON_ONCE(hctx !=3D rq->mq_hctx);
-		prep =3D blk_mq_prep_dispatch_rq(rq, !nr_budgets);
+		prep =3D blk_mq_prep_dispatch_rq(rq, get_budget);
 		if (prep !=3D PREP_DISPATCH_OK)
 			break;
=20
@@ -2111,12 +2111,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx =
*hctx, struct list_head *list,
 		bd.rq =3D rq;
 		bd.last =3D list_empty(list);
=20
-		/*
-		 * once the request is queued to lld, no need to cover the
-		 * budget any more
-		 */
-		if (nr_budgets)
-			nr_budgets--;
 		ret =3D q->mq_ops->queue_rq(hctx, &bd);
 		switch (ret) {
 		case BLK_STS_OK:
@@ -2150,7 +2144,11 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx =
*hctx, struct list_head *list,
 			((hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED) ||
 			blk_mq_is_shared_tags(hctx->flags));
=20
-		if (nr_budgets)
+		/*
+		 * If the caller allocated budgets, free the budgets of the
+		 * requests that have not yet been passed to the block driver.
+		 */
+		if (!get_budget)
 			blk_mq_release_budgets(q, list);
=20
 		spin_lock(&hctx->lock);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 3011a78cf16a..d15ff1e130c8 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -48,7 +48,7 @@ void blk_mq_exit_queue(struct request_queue *q);
 int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
 void blk_mq_wake_waiters(struct request_queue *q);
 bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_hea=
d *,
-			     unsigned int);
+			     bool);
 void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head=
 *list);
 struct request *blk_mq_dequeue_from_ctx(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_ctx *start);
