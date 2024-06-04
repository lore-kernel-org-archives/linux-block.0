Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE5B1EB27
	for <linux-block@vger.kernel.org>; Tue,  4 Jun 2024 06:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717483722; cv=none; b=RUiVRa72OZ041tTg0v/Ujo1vLIeLhug7l46+YvnHLAuLH7RnZijh1z1y4XoYVT9MRyFCLNpq8pBIR+I2vss8VR/gMm0EfnU3AmOglqIOcX6k6yZoPHUPch0JF5il99McFI/ZuAZdaLjnOAR8RbEhHYrWiljKWXfcOATVOXAu/qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717483722; c=relaxed/simple;
	bh=tPHvpfbicx4bIIGo88KcWt4EvJuqworlHYnnK6kTbVU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hvUu8GCj5rk0KfjG+AagUG/3HyhP/b5Tf3kByreBHq40tIbsX8P+hobgshU0hXDhpZ25lKeX5dklUjg0oCTTURlrfYlDm6xGF9k/VFtOLqfuFM7lJN1ChisU5br8nCORwSxIBw4+WWLsw+YODHMNej1g9yXJs3GAFRtfKseBNZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wv6ZXi8R; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wv6ZXi8R"
X-Envelope-To: axboe@kernel.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717483717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4r9HLX4g8Q6c88HvJbXRFepUMDoGcBwz+Eo9OhwtTvI=;
	b=Wv6ZXi8RcMarEJRuY4/ayoBOcG3GaFhWwF/Ao6+DFn3lW58hjVhZS8tBaoAda5D2092sl7
	nPXx+SXkWFConykUQKr781pIc+2K3xRMBz+nzeLp5MgQATPODSqAy5hNAnaLr7lAhW3J0n
	PPi3Tn7PncVpxPGFmny6PSlPXQT6B0M=
X-Envelope-To: ming.lei@redhat.com
X-Envelope-To: hch@lst.de
X-Envelope-To: f.weber@proxmox.com
X-Envelope-To: bvanassche@acm.org
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: chengming.zhou@linux.dev
X-Envelope-To: zhouchengming@bytedance.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
To: axboe@kernel.dk,
	ming.lei@redhat.com,
	hch@lst.de,
	f.weber@proxmox.com,
	bvanassche@acm.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chengming.zhou@linux.dev,
	zhouchengming@bytedance.com
Subject: [PATCH] block: fix request.queuelist usage in flush
Date: Tue,  4 Jun 2024 14:47:45 +0800
Message-Id: <20240604064745.808610-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Friedrich Weber reported a kernel crash problem and bisected to commit
81ada09cc25e ("blk-flush: reuse rq queuelist in flush state machine").

The root cause is that we use "list_move_tail(&rq->queuelist, pending)"
in the PREFLUSH/POSTFLUSH sequences. But rq->queuelist.next == xxx since
it's popped out from plug->cached_rq in __blk_mq_alloc_requests_batch().
We don't initialize its queuelist just for this first request, although
the queuelist of all later popped requests will be initialized.

Fix it by changing to use "list_add_tail(&rq->queuelist, pending)" so
rq->queuelist doesn't need to be initialized. It should be ok since rq
can't be on any list when PREFLUSH or POSTFLUSH, has no move actually.

Please note the commit 81ada09cc25e ("blk-flush: reuse rq queuelist in
flush state machine") also has another requirement that no drivers would
touch rq->queuelist after blk_mq_end_request() since we will reuse it to
add rq to the post-flush pending list in POSTFLUSH. If this is not true,
we will have to revert that commit IMHO.

Reported-by: Friedrich Weber <f.weber@proxmox.com>
Closes: https://lore.kernel.org/lkml/14b89dfb-505c-49f7-aebb-01c54451db40@proxmox.com/
Fixes: 81ada09cc25e ("blk-flush: reuse rq queuelist in flush state machine")
Cc: Christoph Hellwig <hch@lst.de>
Cc: ming.lei@redhat.com
Cc: bvanassche@acm.org
Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 block/blk-flush.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index c17cf8ed8113..e7aebcf00714 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -185,7 +185,7 @@ static void blk_flush_complete_seq(struct request *rq,
 		/* queue for flush */
 		if (list_empty(pending))
 			fq->flush_pending_since = jiffies;
-		list_move_tail(&rq->queuelist, pending);
+		list_add_tail(&rq->queuelist, pending);
 		break;
 
 	case REQ_FSEQ_DATA:
-- 
2.20.1

