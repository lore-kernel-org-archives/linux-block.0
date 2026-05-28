Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6C92E6CB8
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 19:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997575; cv=none; b=dihuMhQsp6iLKeHyEokEixM3e8ZT6pqUOF1+Y+wZwmSCEqfZwuB2aMxvISbqMr7RIwxq/fzyl3RsT4Wn2c+4tWpihv1mYp8vbqwkyHri1hRqL5u69BBGpiLF2DcJltd7YVzZCJKsEMMJdmTHm6Dw6Yy007oFvPhVEqPUGZqBUsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997575; c=relaxed/simple;
	bh=twRbIS1AtC3a2qgRmDu5qLa3ek5TdDi74kQYEv4sCM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iuyAPYXUKHo9uQedF8FVv6m6IRKtnM3mU3jyCEpVxK7YajUpShdOYzPUCRZ1E6kwUxyGy7KAsfhAfRI++e/PmONZ2BDOaWusFD8G+m4vu3I8Czj80Sw2SPwa5eWV9y0q18zd+J3zpAFqK9c9HCC8WGyvwSSNQDEUM4U3SHpSX3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=vofSK/rt; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="vofSK/rt"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gRH6Z0xbMz1XM0ph;
	Thu, 28 May 2026 19:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1779997570; x=1782589571; bh=mR/Jx
	ESC/83+Jki4KGF2JUFJBVHxtNbvVYrIThxxq+A=; b=vofSK/rtwF/UX13SBpCMM
	M3KFqSG0AMkuUKJUkHMmLTc5SjbvUY3Pp2cQw/qPdAPGid8/KkhWPV5ptBHykLIx
	65uNw7Ib3Zntmp6JGYYF6q5dijN5KExINziToa+xyEROwN0p6j9bqa3GH9XUPtu5
	NNqdyrrIhZg0iomFIBoop/9Mv7nGaWl+p7+obJRe4eDoJUurgeJVf9TTtd+Dktei
	XM/v8pPgZHwbUU4iwut+IzoNUp1K4JUHGe3lCAXBkEGM4RCHSYqFZ2jf38NZE/l7
	T2qebw4cT2NijV0kkWNBRvcJuEHLz5zGP9Voqe5SaJY1LpP9JAVeogpotbHR5a4n
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id OQgp2GTyg33C; Thu, 28 May 2026 19:46:10 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gRH6T5SNNz1XM0p3;
	Thu, 28 May 2026 19:46:09 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v5 01/12] block: Annotate the queue limits functions
Date: Thu, 28 May 2026 12:45:38 -0700
Message-ID: <ecdb2e97d3824a64292be86eacdf87684cc9af85.1779997063.git.bvanassche@acm.org>
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

Let the thread-safety checker verify whether every start of a queue
limits update is followed by a call to a function that finishes a queue
limits update.

Reviewed-by: Christoph Hellwig <hch@lst.de>
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
