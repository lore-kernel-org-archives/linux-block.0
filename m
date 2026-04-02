Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03D33CCFC3
	for <linux-block@vger.kernel.org>; Thu,  2 Apr 2026 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155212; cv=none; b=CODSKK1QX9w5D7MCPz2+ffD7MGyzthysEA8loxaph4ZSNGfZA8dKvPfw7Y/dx4uz+uQ+uaCxhyO4SwUraQEzOrXcfKtuJWQ+wqjZSOXTc01YzklxtCBMgLCm3oQJaQeTJ9qf3zsJbcJHY7KA590i0ZxQ5I1RBr4EsN8kXk1otBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155212; c=relaxed/simple;
	bh=yBKZv1tF5ZCEDFWu8GkqYBMIfONgspQbHNS4QYuDPOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=loMhObcGJb7JwMM6TAbzbVbdxWcVukSoC2IzWrQ9sOL0IjJt7/0RQwa2eFfZl8vXN9XPNMqXoBH6njlLAYtUFE3wNHhxhzxioXBW04zvLRmx8HNXIUDjgONhnvw94OXdhSsQa/iEth4FYby4Z0swWsliHCKgE1pUcEniKaBXiiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=hsirNiuU; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="hsirNiuU"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fmrJ85FWyzlh2fy;
	Thu,  2 Apr 2026 18:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1775155205; x=1777747206; bh=07Z2i
	mVd8wLgETNytZrWyToOFdE/uaqZHKxWv72EBJU=; b=hsirNiuUh24VFa/SgCLBh
	IgTTDBktM+TuWbT1CjDU8+IdZLlHMYsqUCuXfZlpgRsBNafeOghDh/7CyjHGNFxy
	2AgOsAYebNZm8ENaRmG28n+ofFyUsQ6Z7vDMvVL4LE7ChvHQMNceKfUtZ7+PdMP4
	JMHhjujho+dykp9wTfJU+It5m+WNPLmmMag0UP7ydF2dHbwKxLxNJ1d5Oa6hW11e
	cbMFq3Qp1Uqlyh+gIp1oz7VeZFMKsdnKy/W9locL1+70ZG2J7wpY7+WYu2annyOW
	a09Kk3V/igAbFtlTWquWmywO1YNs7oagMaUv4P+HEvQ42l8ix3X4oGrmb0ZabUVr
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Zbfe2peIK43U; Thu,  2 Apr 2026 18:40:05 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fmrJ33wPLzlfwHM;
	Thu,  2 Apr 2026 18:40:03 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 01/12] block: Annotate the queue limits functions
Date: Thu,  2 Apr 2026 11:39:33 -0700
Message-ID: <20260402183950.3626956-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <20260402183950.3626956-1-bvanassche@acm.org>
References: <20260402183950.3626956-1-bvanassche@acm.org>
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
index b8e7f42aee71..57b256948ee9 100644
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
