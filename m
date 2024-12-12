Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D78189916
	for <linux-block@vger.kernel.org>; Thu, 12 Dec 2024 21:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734039021; cv=none; b=Pxye9h8Bip7wnpUcGr02vaC1788d3QqLUUMNQ7GyzZgf8COiN1MJNJ0n1Ub3wGu6DjVRYoBJTPEnTQA7BoOwRsm8SdHKYjBqHRUGxA7mlv9/nzVKejSUsjPWCQPu9roJ8K4GhPru3LXg1UPqWzed1eMDO8ZxRNSpUOGeJlfVwm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734039021; c=relaxed/simple;
	bh=JFSWsD6hdy2hfNXwqkdGkYqJGp4WrcuIGJ7cDq8eOBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=roJi73I9g1rdozaZpRm+CyydO159eHpoBV3p/fLZtRtrw3buZFp2COFGl8yTymL9vFqLl4KmjUCJSId0DNuafB+jkHjAVY0oluzTycPKQ1o58CGTxPZpzFCWmYlAGcRDxCEJ7Y2QrRBA04VcQCZ53j1h3D6qn8coBnhC4oWaFLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=K1ceqTrL; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="K1ceqTrL"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Y8Qc874f5z6CmM6f;
	Thu, 12 Dec 2024 21:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1734039013; x=1736631014; bh=/v/2o
	aAhpNmFXKGucu891WTiG9lN0v0BeSsUJNzCyC0=; b=K1ceqTrL/xWJTO0UEz2ke
	ZOCKSleho2yrbVlOhtmAeeIx5XOOaf10Exh8p6WYVAgnOGilcJL5jyCBjPxOp5Yl
	+Gtfpv9pNo+F3nR0EK2zmzQotV4vOCUGI4u3Unu1eF/akjBp+d0s0laTblYPpIvl
	Fs5cFkr46ESioIUXL5BY/VNY+6H5pvRv7wd5/NMCPyJON/GYsZfqjK97kGqDfp1x
	UsXLsNe+RA76Qih5txyeA0p7gzP1TyuqFGHlitU3iaHMKIxS7rcZhzztkidPM/GF
	YYoCWAaQ2pPfPbO1w8FOlU49IgMQI2pcjLUxYkpifGtUov3wR9w6tU2yt+hFd3NG
	Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 5ui5BFocMAwN; Thu, 12 Dec 2024 21:30:13 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Y8Qc40185z6ClL8x;
	Thu, 12 Dec 2024 21:30:11 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 2/3] blk-mq: Clean up blk_mq_requeue_work()
Date: Thu, 12 Dec 2024 13:29:40 -0800
Message-ID: <20241212212941.1268662-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241212212941.1268662-1-bvanassche@acm.org>
References: <20241212212941.1268662-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Move a statement that occurs in both branches of an if-statement in front
of the if-statement. Fix a typo in a source code comment. No functionalit=
y
has been changed.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a6ab1757a21a..68dbac660256 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1535,19 +1535,17 @@ static void blk_mq_requeue_work(struct work_struc=
t *work)
=20
 	while (!list_empty(&rq_list)) {
 		rq =3D list_entry(rq_list.next, struct request, queuelist);
+		list_del_init(&rq->queuelist);
 		/*
-		 * If RQF_DONTPREP ist set, the request has been started by the
+		 * If RQF_DONTPREP is set, the request has been started by the
 		 * driver already and might have driver-specific data allocated
 		 * already.  Insert it into the hctx dispatch list to avoid
 		 * block layer merges for the request.
 		 */
-		if (rq->rq_flags & RQF_DONTPREP) {
-			list_del_init(&rq->queuelist);
+		if (rq->rq_flags & RQF_DONTPREP)
 			blk_mq_request_bypass_insert(rq, 0);
-		} else {
-			list_del_init(&rq->queuelist);
+		else
 			blk_mq_insert_request(rq, BLK_MQ_INSERT_AT_HEAD);
-		}
 	}
=20
 	while (!list_empty(&flush_list)) {
