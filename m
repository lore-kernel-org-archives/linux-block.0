Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258F829DB61
	for <linux-block@vger.kernel.org>; Thu, 22 Jan 2026 04:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769056151; cv=none; b=HG4PubK80I1UJxgfq9LDjzJnLslvd1qjKnnwrhW1UZffp++NV170S4lFQ2N2FcaqPjPGi5m/1iIo4RLKVV6ZBueau/0ypFWtwX5qsR9SteaFw6iDfaKDAweyaRtCgubhEzqU4t/BczS1WLi7qXIodZbf9IEbJ9OQSxmcX3DuFAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769056151; c=relaxed/simple;
	bh=rKof281dAQBCJlv0GxvoXy77F+fxoW4ZvTEFaibLCRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t4RKLiAIjNzLjk5joLje8PLDzLMKXS7A3FivC265t47uL7O80cKYEEjAl4oFYsi3h8P99vKzEXla09YxBHTOXydRuw4bN+H/JjGJ3LB9faszxf0guO43VUZzMJQizH+gmuZpb1fTE/tQTeYoqLS23ekbxqnXrFiFoJHcX2npEb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d9E6TFRE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9E6TFRE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769056148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=djbUhpWziubZy0hG2pzCp8X0QPKkAgogfUKI+ywjDtg=;
	b=d9E6TFREnAITaL+I3ZQ/d7XEVEULPkM6bMHl3hUxH5ahBB0krxOysixysnEI5bzNMPtZoM
	QOpttunmjxQdKxHaeequ1y7LENgSnR+0YCF2br1WJrrEhvy9vxftavhUw2R9y1R4ZlmC0F
	fVrZpD4ZTqwqYwupIUwyWi6YvlwaVIY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-qMwXB48QMAa24md6RH_ZHg-1; Wed,
 21 Jan 2026 23:29:06 -0500
X-MC-Unique: qMwXB48QMAa24md6RH_ZHg-1
X-Mimecast-MFC-AGG-ID: qMwXB48QMAa24md6RH_ZHg_1769056145
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D40061956080;
	Thu, 22 Jan 2026 04:29:04 +0000 (UTC)
Received: from localhost (unknown [10.72.116.62])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 81A603000218;
	Thu, 22 Jan 2026 04:29:03 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Diangang Li <lidiangang@bytedance.com>,
	Fengnan Chang <changfengnan@bytedance.com>,
	Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH] blk-mq: use BLK_POLL_ONESHOT for synchronous poll completion
Date: Thu, 22 Jan 2026 12:28:58 +0800
Message-ID: <20260122042858.1877497-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

blk_execute_rq() with polling is used in kernel code paths such as
NVMe controller connect. The aggressive spinning in blk_hctx_poll()
can prevent the completion task from getting a chance to run, causing
a lockup.

The spinning with cpu_relax() doesn't yield CPU, so need_resched()
only becomes true on timer tick. This causes unnecessary spinning
while the completion task is already waiting to run.

Before commit f22ecf9c14c1, the loop would exit early because
task_is_running() was always true. After that commit removed the
check, the loop now spins until need_resched().

Fix this by using BLK_POLL_ONESHOT in blk_rq_poll_completion(). This
causes blk_hctx_poll() to poll once and return immediately, letting
the outer loop's cond_resched() yield CPU so the completion task can
run.

Fixes: f22ecf9c14c1 ("blk-mq: delete task running check in blk_hctx_poll()")
Cc: Diangang Li <lidiangang@bytedance.com>
Cc: Fengnan Chang <changfengnan@bytedance.com>
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a29d8ac9d3e3..968699277c3d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1480,7 +1480,7 @@ EXPORT_SYMBOL_GPL(blk_rq_is_poll);
 static void blk_rq_poll_completion(struct request *rq, struct completion *wait)
 {
 	do {
-		blk_hctx_poll(rq->q, rq->mq_hctx, NULL, 0);
+		blk_hctx_poll(rq->q, rq->mq_hctx, NULL, BLK_POLL_ONESHOT);
 		cond_resched();
 	} while (!completion_done(wait));
 }
-- 
2.47.1

