Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF41843C05B
	for <linux-block@vger.kernel.org>; Mon, 11 May 2026 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517078; cv=none; b=SRmCTu/xxRPnBOpndIVLw85pPgjTsD7kJmyS+usi8H5+t8wBTK07R/8qoqZhFa+fMtc5kBnT+1qDliX51Qir8tnEAbfQYNacNR8dYim0vbeEkk0hosVyT0qKwmF/dacMlcB3L2VUOvq39c3ExfpAuLYvGdg6qNG2Hmb8kargl8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517078; c=relaxed/simple;
	bh=uM5EdW/OlUVkUg4gC7tqT9lI0hRifXJIrBwBq2Umt6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgzKTLPWmQsiOVQs5A/BNDS/JflOs+Xi9Qgmy3e3zzhr7ZyXPlilejvlpjIb4EXb/zEetUBmo2XIMDqNP9ug+vlKxdA5REUd/Rg5VDgXZhiOxqWYcp7huVCcqIDQJYPnb4RmTJklQcpeWCNMIbvclXyr17dmpRdSY9vqkGmBuqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=xCicKAFv; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="xCicKAFv"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gDlbS2Rdhzlfl8H;
	Mon, 11 May 2026 16:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1778517072; x=1781109073; bh=SC881
	DCneUnD8o49nD6S9IfchQhY8TFUSl0lxWzq8aI=; b=xCicKAFvbQBDXNEQq5HPD
	wBPO2PrtT3xL33qZ3LAoFioGmNqY1eNHi8kXxlGZQYBWYV44rX6KKixqqpo6dF/M
	qgI0KY77FcOFIpkYZiRydl6iGASHyJvkthHdHxAToQtFiFkdZ5UQXYprKokVYk5J
	c5TBjLpXBOtsIxfZIqc/dcZwIPG4SKkGHFUXH/VL+dHXxIL2KPTUYXavVpVvU3K+
	1/y215NXCWrMYp1xbN+ToKqr/RH8gBUiGN7jThXy/tnxWF4tzC0mI1r+DdxdbrG2
	6JLVaXqED8SRFP/uioNE+U3rjRgJzSM79svWbifnchY84SEkysDYz8cf2K1SGLRJ
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ck_OwzOdlpn1; Mon, 11 May 2026 16:31:12 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gDlbM4zr2zlfgRw;
	Mon, 11 May 2026 16:31:11 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v4 01/12] block: Annotate the queue limits functions
Date: Mon, 11 May 2026 09:30:43 -0700
Message-ID: <20260511163100.1887263-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
In-Reply-To: <20260511163100.1887263-1-bvanassche@acm.org>
References: <20260511163100.1887263-1-bvanassche@acm.org>
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
index 890128cdea1c..8651af4fe9d7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1093,15 +1093,17 @@ static inline unsigned int blk_boundary_sectors_l=
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
@@ -1113,6 +1115,7 @@ int blk_validate_limits(struct queue_limits *lim);
  * starting update.
  */
 static inline void queue_limits_cancel_update(struct request_queue *q)
+	__releases(&q->limits_lock)
 {
 	mutex_unlock(&q->limits_lock);
 }
