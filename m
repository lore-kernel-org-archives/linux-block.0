Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD7835F19A
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 18:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682496; cv=none; b=RUCqzsH2DKBJrnB60EbjcoAxLwH/wDdkOuxgg7LEHxYDultaPpx6DDksuULLHpottdt/dynp9zFyT8QAgHZLZpSIN3BgU1Jp21EgEMw6b9vltprm8eJJhbnRvC7KQVmBBymxIWg3k8aZh+RESotqSevAQ1jd82guJ9R4/73yp8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682496; c=relaxed/simple;
	bh=6CnS1Lih9t8Ur3rPo6sMTtcWlap8HfsgO/fzYD+/YCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umJ6or2RN2/sPMCEoFXlbyWzgAmWfRQGivRzceFagIzEElHYHMOQcGRzUKAX3e6BFaZlO4LMMSe3/RZeqFvzUiBB5Aqu6VBBIh9pyzzB9O9MBRhhRhrZcsLEmMk2F2n5hBDLxfoYS9XRRctUxmq0vIEV1P7qcTeBS4yUWA6GZ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=GymBz+YI; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="GymBz+YI"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gX8Q63BhZz1XM0pR;
	Fri,  5 Jun 2026 18:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1780682490; x=1783274491; bh=bhDeH
	F497uJfss/Y/xchS+W78N+XBDaeXKb3kg2X/lc=; b=GymBz+YILzl0nT08TxZWo
	cnQHoTcyuYed+UgfeFaD3XVxdQHH/kE/AqofKEMhEw61NIhZKRnYcFlc7F/7fxCf
	YzUzcRiJLyiWNTYX+l/rIQuCKpLXrEkfsQpRXxekFIk/nGlIrIKFZHoQVsDXvww1
	lhx6frFfMJDkcSX5hEk9b4jhGJF++cPfJaL8ZVzKE8s2X+Vs0cbfoGuhoY3q90r+
	80x5YX3rX9mCjts1Wo5TNGDgUo4OAkbcYg6INMWjeEvzcwsMpumtt06hUTekKdzz
	W+eQMuxmOPrZbVBtuBzD2J8UaUP+J/tmWt00PvE0/FfULcKjkrDZBxzlMFH5Pi8O
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id hTHH-RlOs7K5; Fri,  5 Jun 2026 18:01:30 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gX8Q10YGgz1XM6Jh;
	Fri,  5 Jun 2026 18:01:28 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v7 01/14] block: Annotate the queue limits functions
Date: Fri,  5 Jun 2026 11:00:54 -0700
Message-ID: <8f71062b6d0fcf2b80bc8cda701c453224755439.1780682325.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <cover.1780682325.git.bvanassche@acm.org>
References: <cover.1780682325.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Let the thread-safety checker verify whether every start of a queue
limits update is followed by a call to a function that finishes a queue
limits update.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blkdev.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 17270a28c66d..65efbd7fe1a3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1092,15 +1092,17 @@ static inline unsigned int blk_boundary_sectors_l=
eft(sector_t offset,
  */
 static inline struct queue_limits
 queue_limits_start_update(struct request_queue *q)
+	__acquires(&q->limits_lock)
 {
 	mutex_lock(&q->limits_lock);
 	return q->limits;
 }
 int queue_limits_commit_update_frozen(struct request_queue *q,
-		struct queue_limits *lim);
+		struct queue_limits *lim) __releases(&q->limits_lock);
 int queue_limits_commit_update(struct request_queue *q,
-		struct queue_limits *lim);
-int queue_limits_set(struct request_queue *q, struct queue_limits *lim);
+		struct queue_limits *lim) __releases(&q->limits_lock);
+int queue_limits_set(struct request_queue *q, struct queue_limits *lim)
+	__must_not_hold(&q->limits_lock);
 int blk_validate_limits(struct queue_limits *lim);
=20
 /**
@@ -1112,6 +1114,7 @@ int blk_validate_limits(struct queue_limits *lim);
  * starting update.
  */
 static inline void queue_limits_cancel_update(struct request_queue *q)
+	__releases(&q->limits_lock)
 {
 	mutex_unlock(&q->limits_lock);
 }
