Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CFA399031
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475135; cv=none; b=k03OC+HoOZ539ollXvf/mneTe4p8JYHyj6Zn6teD4VgxiBMVT49dNruMx/4nHnRw/mR1Cv5yaJazmTyBp/bkPcjF8R0013gcpcka3kK9qCY4/jD9Xi64SmGJfmX8sB0rLbPwlCv8UqC1sFowkGBmuKDWSo0LX2gX4um/INzqQuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475135; c=relaxed/simple;
	bh=7E1narWbmpJ6bmcKcSXo0Q2elkJU4aYFJQqDSmOGSwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9ZQat1x++1d7Wrhd/9XV7bCzISE000GIpQMQn8LETAWidyqdhbLuijFvEKWZQYDhfZmGeZ4hCmNcQouAO6sgdE25pycCIFKVvsPav6NETtIVmP6pniKo/xIjP9pmA30+hSUMDzV21Vp9CvQN32ajjLHkazZJq7sQBAE2pM1qSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=dL1oklIR; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="dL1oklIR"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0nn5QzPzlfvpM;
	Wed, 25 Mar 2026 21:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774475130; x=1777067131; bh=nqDfX
	ADgwSfDLa7yGFUxUmQ2voBfYIWX5WcpLxorLlg=; b=dL1oklIRFldr6P8rIAM3T
	oIF6j8OhqWhZQLGon6DPdXVJ6DunbYdE6HDW6W4XMLqup9Uc/l9D/GTEPOSAVyYe
	pHmzBYZC0HalU2XhSzNy97rnN7Mw/bZQQW1VZNRqo0ABkRksNR3l3wCsvHC/nMNj
	wVf9ekTEbZHonpHKSUX5t/AOODUf5qVU1r5zbRpjMxL3kw6mEyHj6gh2rhiMTSHP
	XJ7HxodrpwSlFrXHXPntvmRrJLHqdTYJXjXp3gOseTtQ809bLvFB9bTaE2RJO8Et
	ixuWPRrbaWepWaPiz2hnoCyE54RpP/VPTTatFo0ol3COFgiGOx1eo92Ql6pHtUh/
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id a2QYdw_pyRIl; Wed, 25 Mar 2026 21:45:30 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0nj12SpzlgyGm;
	Wed, 25 Mar 2026 21:45:28 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 01/26] block: Annotate the queue limits functions
Date: Wed, 25 Mar 2026 14:44:42 -0700
Message-ID: <20260325214518.2854494-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325214518.2854494-1-bvanassche@acm.org>
References: <20260325214518.2854494-1-bvanassche@acm.org>
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
