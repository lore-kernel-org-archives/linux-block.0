Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB79346E71
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768418900; cv=none; b=PspZ1IjZh1PRWiEU4dierlnIpygfUCaxLce+BPrWNcFCSN0Rv5bpME1DECpASPO6Ss8yDL/mjHuahX2LhyT+/WoIrhZs+hVg64YV71kBZpSRQfJ0URGkq+VoS1qz7QwvexHD6aDgh3YA5EDUO+Ny/GdsF9Y0ruvyQg65iQ9DOb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768418900; c=relaxed/simple;
	bh=W2HYPF3pczD/mgRQT0FfOuU2sArd+s0srt+VDk4qFLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsoYVwoutiZQnpvMtF0aqXRAcggD7tAN/cbhQAw75VGkzix2w/gmKYR3Pti44mXHTFyEWz6yLVHcPq/4utTnnw0OL/tjX7VpHaIn2VW2Vm0CoVKC3RCD1n8dieKK5/+ho9rHZvEv9paeCawxLTjvOkKCyQHPmK/t83aToQnrzj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=mEiL8rwU; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="mEiL8rwU"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4drx3k5lJqzllB7X;
	Wed, 14 Jan 2026 19:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1768418897; x=1771010898; bh=Y6LK4
	1RIfhB/TMgKjOP3dbhzCcN5tc5LGsiBr8prUZo=; b=mEiL8rwUFVXVeM4ZlSP6W
	PrLstY8zjobzgaTZfVYAKz9l3y2ht1qo6SyraoSSSVv5nqawBI7/9eWpC36Bw4k1
	onURzsmWrZsTe88f8M1MsOqcOk1MbjDv2H3re/cPOIKfny8qXuDY9lJh9Z3fbETw
	1XAY/YLR7DcrhmAILsnHdbhz5ahB9QtV62Bf6LG7Fd7Pz00G+o1i3GIcrw6ZM98J
	xP594wJObiSWA3FNwSY7sYTvMT3rbgDvvYimLpAGKTB76621jxhbwancIxvzFl3P
	NttWRgK6DDcPG4YMKPPAnhmPJ8Lwl4KCMMR2kQFh4ix96Wt2GOOGq/pgv6y5ghWz
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Ai3oQ8A0htVK; Wed, 14 Jan 2026 19:28:17 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4drx3h4105zlfc3w;
	Wed, 14 Jan 2026 19:28:16 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 1/2] block: Annotate the queue limits functions
Date: Wed, 14 Jan 2026 11:28:01 -0800
Message-ID: <20260114192803.4171847-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260114192803.4171847-1-bvanassche@acm.org>
References: <20260114192803.4171847-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blkdev.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 72e34acd439c..66bf11cfcb37 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1084,14 +1084,17 @@ static inline unsigned int blk_boundary_sectors_l=
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
+		struct queue_limits *lim)
+	__releases(&q->limits_lock);
 int queue_limits_commit_update(struct request_queue *q,
-		struct queue_limits *lim);
+		struct queue_limits *lim)
+	__releases(&q->limits_lock);
 int queue_limits_set(struct request_queue *q, struct queue_limits *lim);
 int blk_validate_limits(struct queue_limits *lim);
=20
@@ -1104,6 +1107,7 @@ int blk_validate_limits(struct queue_limits *lim);
  * starting update.
  */
 static inline void queue_limits_cancel_update(struct request_queue *q)
+	__releases(&q->limits_lock)
 {
 	mutex_unlock(&q->limits_lock);
 }
