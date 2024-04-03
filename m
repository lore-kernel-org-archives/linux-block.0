Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1702C683
	for <linux-block@vger.kernel.org>; Wed,  3 Apr 2024 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179453; cv=none; b=jQ4h7Ul+X6iJzSFlimGQdQrCtArQFoHMgHFYeni+YgiRc39g+chYiY/p97EiyAZcgzMmZgmsk4nZqXbLWHy4qDZkxjU1WsCpBWgfGELfKSKs3WhkNiH3+6VpCEQX+SS9O187i5+3KHmBp4paT0TJyTPgw1GwzRW85jxz7vFilRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179453; c=relaxed/simple;
	bh=Mn7eMjnEFZnc6Qi1WLwB97ILODQhw5uwjhLX3NAhwhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9KuLlF7Dhl1B5HgJx/91h6uBgewNvFqiz0wamYfeGowOn9aPWwREB5nnwvpWRrX/jV1rTn+DcceQzE8knk1/YAY+ijxtmBLY3ko1gFvL9ErwU5rKgLzRDHd4cv0YlUbGypWvRRLxbB+JuQ4307h+6sT0uPwQcmUbU+cX5Z0EJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=LP9r+unw; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="LP9r+unw"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V8yRt61W8zlgTHp;
	Wed,  3 Apr 2024 21:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1712179447; x=1714771448; bh=RzmuY
	P+vl6PrSDvwC8WIzuhTDntY4YHBLJQWw+rmB08=; b=LP9r+unwRPmjEqG2jKkhB
	gDxhX0VgyTQFGvCjcwV5vocKuWw90k1sUhcBc6veQuEICzkZQUnDVjkH2IGkKf/x
	f6RV5EnnEGHMorCe6DlATgKNDW0N5uHjm9+BWou4dzA+UizzvYalYJ1lFHOk8AW9
	W6etVz8IO1wqQQMiMYkoL0wM9YC/XLenjybL1vxsQ5XJYpgsy/3l5o1N6QvXYAVA
	7evoAIDpF2RJy6fObjnGvfEGcCWjxSfcezI2HIMKHI1vDk5BmrGr2ALnzYT1TQhO
	ZZR8esL30yJnDam/e6Fq0ZUGjJ+FtRkORJuEQP5nI+zQRntB5CjzTIYjcvj47wYE
	A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id UnFX0HuKO02v; Wed,  3 Apr 2024 21:24:07 +0000 (UTC)
Received: from bvanassche-linux.mtv.corp.google.com (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V8yRq2fTnzlgTGW;
	Wed,  3 Apr 2024 21:24:07 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>
Subject: [PATCH 1/2] block: Call .limit_depth() after .hctx has been set
Date: Wed,  3 Apr 2024 14:23:53 -0700
Message-ID: <20240403212354.523925-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240403212354.523925-1-bvanassche@acm.org>
References: <20240403212354.523925-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Call .limit_depth() after data->hctx has been set such that data->hctx ca=
n
be used in .limit_depth() implementations.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>
Fixes: 07757588e507 ("block/mq-deadline: Reserve 25% of scheduler tags fo=
r synchronous requests")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 34060d885c5a..bcaa722896a0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -434,6 +434,7 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_dat=
a *data)
=20
 static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data =
*data)
 {
+	void (*limit_depth)(blk_opf_t, struct blk_mq_alloc_data *) =3D NULL;
 	struct request_queue *q =3D data->q;
 	u64 alloc_time_ns =3D 0;
 	struct request *rq;
@@ -459,13 +460,11 @@ static struct request *__blk_mq_alloc_requests(stru=
ct blk_mq_alloc_data *data)
 		 */
 		if ((data->cmd_flags & REQ_OP_MASK) !=3D REQ_OP_FLUSH &&
 		    !blk_op_is_passthrough(data->cmd_flags)) {
-			struct elevator_mq_ops *ops =3D &q->elevator->type->ops;
+			limit_depth =3D q->elevator->type->ops.limit_depth;
=20
 			WARN_ON_ONCE(data->flags & BLK_MQ_REQ_RESERVED);
=20
 			data->rq_flags |=3D RQF_USE_SCHED;
-			if (ops->limit_depth)
-				ops->limit_depth(data->cmd_flags, data);
 		}
 	}
=20
@@ -478,6 +477,9 @@ static struct request *__blk_mq_alloc_requests(struct=
 blk_mq_alloc_data *data)
 	if (data->flags & BLK_MQ_REQ_RESERVED)
 		data->rq_flags |=3D RQF_RESV;
=20
+	if (limit_depth)
+		limit_depth(data->cmd_flags, data);
+
 	/*
 	 * Try batched alloc if we want more than 1 tag.
 	 */
