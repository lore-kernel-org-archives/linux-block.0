Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FDC2D63EC
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 20:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751488763; cv=none; b=siYbj1/YCDAXVTV1aTwbG7I5AHqr0QZ/ibMGNZuYQUTeAjSCZxaDh0LOrNpgOCiXj6F1LLrhEhKz8mbEfiIWOZn7N0YMOtKxibra3xDQZXKDAfalAVtWx6exMxuU9yP1DPtjZUCHpo9sPZl4iwALN+bIOvGuAxbseclWS1lknIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751488763; c=relaxed/simple;
	bh=HDCcP0ThdIgF7+82luXFuWLZ6m7jh7IaYrovt7dGLiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sai2dQbYURBa4H5issBmkMG97TiAz3AwSl87vgLoEhf/c3W0ZDC9oqoxhBOuCCydVgQvrX0qLu1hRzR58b5sXYGu6Ux+xnYMVgUh5+9p7MDsq3pKwNqRmpQd9escRagsWAFRiFl2pjV59rBo0uZLJ3uIEHJDDE0rfIov8U5W69Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=UgsnpKRB; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="UgsnpKRB"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bXWw85Hx2zm0NB4;
	Wed,  2 Jul 2025 20:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1751488759; x=1754080760; bh=vQHDb
	sgoGDmgt8ZBpgyQGIv7ggSHekzYat0Nm/s7i9s=; b=UgsnpKRB1c6LcB1vkgndZ
	OGQg2jiPyMc0jN8pvSdtNq2AyLZQZ+MxMx6+V0PgLr21h4pkMKu6BZiNa2RX6XS9
	CFxXaAGrbrbxSgTBw+WC8GZVZ2iHwdEKxkOlIuZmiysEN4QEfw/vEQRIv7vGiTBH
	hbgGqqxRVIdC4LFQYmLEhrKfZ+Ps9xcO9O3k+2mEIRbW8WBX1r4v/T5mnilwE5ks
	pOQt0kn12faEFySBH3668zZ6ocHf2H/x3pbLIZIv3lIX1MHLIlfkCvyaxysIzA8/
	KE2/RkCMqKps+vWqIt51Xe1qkkVqQO9MFnYl5WbYPqc0U9UAu//WQE7pBf9kbn3h
	A==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0aOm2YmnQ5jF; Wed,  2 Jul 2025 20:39:19 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bXWw32Zk4zm0XC1;
	Wed,  2 Jul 2025 20:39:14 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Justin Sanders <justin@coraid.com>
Subject: [PATCH 4/8] aoe: Remove the quiesce/unquiesce calls on frozen queues
Date: Wed,  2 Jul 2025 13:38:39 -0700
Message-ID: <20250702203845.3844510-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250702203845.3844510-1-bvanassche@acm.org>
References: <20250702203845.3844510-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Because blk_mq_hw_queue_need_run() now returns false if a queue is frozen=
,
protecting request queue changes with blk_mq_quiesce_queue() and
blk_mq_unquiesce_queue() while a queue is frozen is no longer necessary.
Hence this patch that removes quiesce/unquiesce calls on frozen queues.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/aoe/aoedev.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index 3a240755045b..b765be7765e7 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -236,11 +236,8 @@ aoedev_downdev(struct aoedev *d)
=20
 	/* fast fail all pending I/O */
 	if (d->blkq) {
-		/* UP is cleared, freeze+quiesce to insure all are errored */
+		/* UP is cleared, freeze to ensure all are errored */
 		unsigned int memflags =3D blk_mq_freeze_queue(d->blkq);
-
-		blk_mq_quiesce_queue(d->blkq);
-		blk_mq_unquiesce_queue(d->blkq);
 		blk_mq_unfreeze_queue(d->blkq, memflags);
 	}
=20
