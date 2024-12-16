Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3776F1FFC56
	for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 08:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734336158; cv=none; b=j1/hFNvvPJqQZSciTVKl3k7JelLs0q2rPEhT9BRlQaCphvifMhOAIMDuti4gkYjy1vWJ8JBlNgri0/NMnnu+VO9PxKfkN4aT1bD+kxu3noeJ3ZEIREd6dHVjPodloV/yCeFy/MugjMkFSsvy+q+fci+5wRkUWfK+rKA7YYRuWX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734336158; c=relaxed/simple;
	bh=kQ5hYPWxOXYZPwXBb4EAMXQtjCs6eOmMXeRq9pnEsEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3x5EBUREPPpcpNZfEH/lmvqObLpBP/JpmYKBMJPgRWW+1EjYTy9Z2VJ+v99psv5QMSy55WpGKPZy7OH9VMMTg7T5mRvMgbgScKJ/baIhvm3UeT9BC2ClmN2a9dDM4n3GPUOVaIFf5/kAXnCHQ1IJtd4Ah9AgUEh7zA3M54/RyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gdurvRVe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gdurvRVe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734336155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O8sXC6LXjUiv5a6g1mpO360gKJtsqaNC6Rbu/MiAQOM=;
	b=gdurvRVe7WDOjd4ppaav7LGScW4AFXWmevwDDaW5HzYV3NFlPXfPm4qF77vtUE5sPjffpe
	qzqu3W1AgHN/qTpaJudODdLbt6vDt6+u3MsrEAh+D+jWY+q6wfudPSKNlqMp8CbTrq0Kg2
	+oh9ji5bAx+aL04HQZqLam6I1ypQk8k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-bDYAs3GpPz6hsOCnbz3dBA-1; Mon,
 16 Dec 2024 03:02:31 -0500
X-MC-Unique: bDYAs3GpPz6hsOCnbz3dBA-1
X-Mimecast-MFC-AGG-ID: bDYAs3GpPz6hsOCnbz3dBA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5268A1955F2D;
	Mon, 16 Dec 2024 08:02:30 +0000 (UTC)
Received: from localhost (unknown [10.72.116.154])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC02A1956052;
	Mon, 16 Dec 2024 08:02:28 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] block: avoid to hold q->limits_lock across APIs for atomic update queue limits
Date: Mon, 16 Dec 2024 16:02:03 +0800
Message-ID: <20241216080206.2850773-2-ming.lei@redhat.com>
In-Reply-To: <20241216080206.2850773-1-ming.lei@redhat.com>
References: <20241216080206.2850773-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Commit d690cb8ae14b ("block: add an API to atomically update queue limits")
adds APIs for updating queue limits atomically. And q->limits_lock is
grabbed in queue_limits_start_update(), and released in queue_limits_commit_update().

This way is very fragile and easy to introduce deadlock[1][2].

More importantly, queue_limits_start_update() returns one local copy of
q->limits, then the API user overwrites the local copy, and commit the
copy by queue_limits_commit_update() finally.

So holding q->limits_lock protects nothing for the local copy, and not see
any real help by preventing new update & commit from happening, cause
what matters is that we do validation & commit atomically.

Changes the API to not hold q->limits_lock across atomic queue limits update
APIs for fixing deadlock & making it easy to use.

[1] https://lore.kernel.org/linux-block/Z1A8fai9_fQFhs1s@hovoldconsulting.com/
[2] https://lore.kernel.org/linux-scsi/ZxG38G9BuFdBpBHZ@fedora/

Fixes: d690cb8ae14b ("block: add an API to atomically update queue limits")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-settings.c   | 2 +-
 include/linux/blkdev.h | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 8f09e33f41f6..b737428c6084 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -422,6 +422,7 @@ int queue_limits_commit_update(struct request_queue *q,
 {
 	int error;
 
+	mutex_lock(&q->limits_lock);
 	error = blk_validate_limits(lim);
 	if (error)
 		goto out_unlock;
@@ -456,7 +457,6 @@ EXPORT_SYMBOL_GPL(queue_limits_commit_update);
  */
 int queue_limits_set(struct request_queue *q, struct queue_limits *lim)
 {
-	mutex_lock(&q->limits_lock);
 	return queue_limits_commit_update(q, lim);
 }
 EXPORT_SYMBOL_GPL(queue_limits_set);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 378d3a1a22fc..6cc20ca79adc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -944,8 +944,13 @@ static inline unsigned int blk_boundary_sectors_left(sector_t offset,
 static inline struct queue_limits
 queue_limits_start_update(struct request_queue *q)
 {
+	struct queue_limits lim;
+
 	mutex_lock(&q->limits_lock);
-	return q->limits;
+	lim = q->limits;
+	mutex_unlock(&q->limits_lock);
+
+	return lim;
 }
 int queue_limits_commit_update(struct request_queue *q,
 		struct queue_limits *lim);
@@ -962,7 +967,6 @@ int blk_validate_limits(struct queue_limits *lim);
  */
 static inline void queue_limits_cancel_update(struct request_queue *q)
 {
-	mutex_unlock(&q->limits_lock);
 }
 
 /*
-- 
2.47.0

