Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2194C1E32B7
	for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758572025; cv=none; b=VqVmib72mQkA2++8WugZ5WeWVfV6prqsgZUc9bPe8UKcQaozD8T3B9CcuZoI/uM38Pb8sdiDP+Xsp1BLiLUv84LjMIGWtQfA8Dw2DBhOF/OJxcwF0U02Lhc8RfSLjjFJYwQuOy7TNadSjejzYYhizFv2ESWyipv5eL2vQkwbjpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758572025; c=relaxed/simple;
	bh=eEOJIeESO305RTrn5Ml+HhIy98/k7CEOG4iv4pvGbk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uZUlf8iPIT+rN+UD3WMiTPdSM5n5A5sXIIZRnZEEdozarzdiAosPAgeso6EaCMbk0oGPocE0qWi4Q0E4ApI4+N2mj37TV0GvLZief4nlOlIoM6RVC/dAQOhmWx/CSAG8AldL/RdZDAGB665QdH78HVc8XVqwLkvmO1rn/5zbREE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZBzPAopa; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ZBzPAopa"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cVvSj74bkzm0ySQ;
	Mon, 22 Sep 2025 20:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1758572020; x=1761164021; bh=LWBWixuXHvvRvotlX/NhcfKLvls6+eSt08t
	hPu1S7yA=; b=ZBzPAopapDlHDJp6uaC6Rp3dC0c7PLNLbrIidWXmWiJw1O+HAxW
	Z9owUAO7j5eNsdK/Tfw7rwa58P82oyOLJdk14opo7jsGhQtdnoOe7NBeuOU9vzKB
	D7ISBTf9nQz+y8FBCYIAuftk7XczSPuZSfken6MFNk4Hr4W/XgfY59FDyu2ybXuJ
	LQS7FnTONFfdA9e+jUl7kjTRtRO3wF4begbLJ1gaIm761nYZKwlsvhjRluDi5dl/
	29ttRbz6EimMWJbkspbVL5PSCxlspfTrHdsRU4Zalk/4miw8odtjlSzy+ux/VsbY
	yl4BI3ThiJn32Mzb1fHFsBiOLVPjy/06kVQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 7tdbn7U4Sv9C; Mon, 22 Sep 2025 20:13:40 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cVvSb52chzm0yTR;
	Mon, 22 Sep 2025 20:13:34 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	John Garry <john.g.garry@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] blk-mq: Fix more tag iteration function documentation
Date: Mon, 22 Sep 2025 13:13:24 -0700
Message-ID: <20250922201324.106701-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit 8ab30a331946 ("blk-mq: Drop busy_iter_fn blk_mq_hw_ctx argument")
removed the hctx argument from the callback functions called by
bt_for_each() and blk_mq_queue_tag_busy_iter(). Commit 2dd6532e9591
("blk-mq: Drop 'reserved' arg of busy_tag_iter_fn") removed the
'reserved' argument of the busy_tag_iter_fn function pointer type. Bring
the documentation of the tag iteration functions in sync with these
changes.

Cc: John Garry <john.g.garry@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-tag.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 0602ca7f1e37..271fa005c51e 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -297,15 +297,15 @@ static bool bt_iter(struct sbitmap *bitmap, unsigne=
d int bitnr, void *data)
 /**
  * bt_for_each - iterate over the requests associated with a hardware qu=
eue
  * @hctx:	Hardware queue to examine.
- * @q:		Request queue to examine.
+ * @q:		Request queue @hctx is associated with (@hctx->queue).
  * @bt:		sbitmap to examine. This is either the breserved_tags member
  *		or the bitmap_tags member of struct blk_mq_tags.
  * @fn:		Pointer to the function that will be called for each request
  *		associated with @hctx that has been assigned a driver tag.
- *		@fn will be called as follows: @fn(@hctx, rq, @data, @reserved)
- *		where rq is a pointer to a request. Return true to continue
- *		iterating tags, false to stop.
- * @data:	Will be passed as third argument to @fn.
+ *		@fn will be called as follows: @fn(rq, @data) where rq is a
+ *		pointer to a request. Return %true to continue iterating tags;
+ *		%false to stop.
+ * @data:	Will be passed as second argument to @fn.
  * @reserved:	Indicates whether @bt is the breserved_tags member or the
  *		bitmap_tags member of struct blk_mq_tags.
  */
@@ -371,9 +371,9 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsi=
gned int bitnr, void *data)
  * @bt:		sbitmap to examine. This is either the breserved_tags member
  *		or the bitmap_tags member of struct blk_mq_tags.
  * @fn:		Pointer to the function that will be called for each started
- *		request. @fn will be called as follows: @fn(rq, @data,
- *		@reserved) where rq is a pointer to a request. Return true
- *		to continue iterating tags, false to stop.
+ *		request. @fn will be called as follows: @fn(rq, @data) where rq
+ *		is a pointer to a request. Return %true to continue iterating
+ *		tags; %false to stop.
  * @data:	Will be passed as second argument to @fn.
  * @flags:	BT_TAG_ITER_*
  */
@@ -406,10 +406,9 @@ static void __blk_mq_all_tag_iter(struct blk_mq_tags=
 *tags,
  * blk_mq_all_tag_iter - iterate over all requests in a tag map
  * @tags:	Tag map to iterate over.
  * @fn:		Pointer to the function that will be called for each
- *		request. @fn will be called as follows: @fn(rq, @priv,
- *		reserved) where rq is a pointer to a request. 'reserved'
- *		indicates whether or not @rq is a reserved request. Return
- *		true to continue iterating tags, false to stop.
+ *		request. @fn will be called as follows: @fn(rq, @priv) where rq
+ *		is a pointer to a request. Return %true to continue iterating
+ *		tags; %false to stop.
  * @priv:	Will be passed as second argument to @fn.
  *
  * Caller has to pass the tag map from which requests are allocated.
@@ -485,11 +484,10 @@ EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request)=
;
  * blk_mq_queue_tag_busy_iter - iterate over all requests with a driver =
tag
  * @q:		Request queue to examine.
  * @fn:		Pointer to the function that will be called for each request
- *		on @q. @fn will be called as follows: @fn(hctx, rq, @priv,
- *		reserved) where rq is a pointer to a request and hctx points
- *		to the hardware queue associated with the request. 'reserved'
- *		indicates whether or not @rq is a reserved request.
- * @priv:	Will be passed as third argument to @fn.
+ *		on @q. @fn will be called as follows: @fn(rq, @priv) where rq
+ *		is a pointer to a request and hctx points to the hardware queue
+ *		associated with the request.
+ * @priv:	Will be passed as second argument to @fn.
  *
  * Note: if @q->tag_set is shared with other request queues then @fn wil=
l be
  * called for all requests on all queues that share that tag set and not=
 only
