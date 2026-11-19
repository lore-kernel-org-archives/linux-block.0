Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795071969;
	b=BXyEnPxbY1ivSqatnHc5+jmoRQc1RX7VbMGqVq7J0OPH8nsLBjXOsimdBoC5fPknhyWd
	 L5uGCtZeskLndkDwoLsYBh0uDvsJ6NdDugSU3av3MR2RmB3smC3b1wimdXSBbLAui7K6Z
	 1cBTzj9vN1nPrIYS42l8ov5Rg//xUXIiRdbeJSGLZqq3yYFxxRmFITyinpuaXVnu4Wq0L
	 HU9/FTuOHIGly++RL7WIgDn73Yuf/VDHnFq62EzDdhjJ1RuCJlAyY5GX4RiA+OAs99cFU
	 YPKRhPgJY55wDF/WjXjuKLqoX73uJ6XO46rKLonEzxwzCn/IITCGeIk5d4+VE4XHNrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795071969;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8B5AVIXLEidDXzfM5otETGwMbGi9w/TxhNSx1EDQpxk=;
	b=fTYl+yNpn6d/tM0oJiafYZrX4C3zuRRxJdx/4pE2rcYKt1ScT4FVXw8dheJBYXC0C7jx
	 JJ+SSJhgVV26AYvVr+wghrtHLyFxcB+Yi4Pv9DIGyj2PBftS+lkkDgg+5BpZJS2cQ5530
	 Z4AX9hF3sz6fuURVy4CiP9wuG3nxM+0yPdS63iNDxRpv0RyOcnwKklISsNUgFGr9uzSAD
	 skGJxKkIclVazKHS0nWrBXD1Kf/uKkfwHhHSMm5AEVa7lntawlGnrfmUqk0qCWY34Vr+J
	 pbjfBP9LV1bq7PUEOriB5jqnfJZZDr36CPy6/C3z9YcCD+749qjj2ZMp6yM8qpV4s/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LB+QeCJZ;
	arc=none smtp.remote-ip=115.124.30.101
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC579606A326
	for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 07:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC579606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LB+QeCJZ
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795071961; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8B5AVIXLEidDXzfM5otETGwMbGi9w/TxhNSx1EDQpxk=;
	b=LB+QeCJZ8uywpZNp3hfO8EOAedFlRvt7rcjjXsuPAzB16r8pbQDA0vrGf+tf8ZXQYLrhLb9ZnCEGlP4omLLL6jkEU7ndZ2StIg/RUXM5aSgp+IdLOzlPfv/13Gpc5dYY3p3PpRx3QmnMu33oZHB0qtgs4vpjDnAk/6ibOXi1sQM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XF2hAXd_1795071959;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XF2hAXd_1795071959 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Nov 2026 15:05:59 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 4/7] blk-iocost: unfreeze the queue before dropping the bdev reference in qos write
Date: Thu, 19 Nov 2026 15:05:45 +0800
Message-ID: <20261119070548.3125491-5-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261119070548.3125491-1-kanie@linux.alibaba.com>
References: <20261119070548.3125491-1-kanie@linux.alibaba.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ioc_qos_write() calls blkg_conf_close_bdev() before
blk_mq_unfreeze_queue(). close_bdev drops the bdev reference the
writer holds; if that is the last reference, the queue enters its
release path and only the RCU-delayed free in blk_free_queue() keeps
it alive across the unfreeze. Unfreeze before the close instead,
while the writer's own bdev reference still pins the queue, matching
ioc_cost_model_write().

Fixes: 9730763f4756 ("block: correct locking order for protecting blk-wbt parameters")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 block/blk-iocost.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 8e06b83691aa..b251ecc66d8a 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3370,7 +3370,6 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 			     size_t nbytes, loff_t off)
 {
 	struct blkg_conf_ctx ctx;
-	struct request_queue *q;
 	struct gendisk *disk;
 	struct ioc *ioc;
 	u32 qos[NR_QOS_PARAMS];
@@ -3511,9 +3510,8 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	blk_mq_unquiesce_queue(disk->queue);
 
 close_bdev:
-	q = ctx.bdev->bd_queue;
+	blk_mq_unfreeze_queue(ctx.bdev->bd_queue, memflags);
 	blkg_conf_close_bdev(&ctx);
-	blk_mq_unfreeze_queue(q, memflags);
 	return ret ?: nbytes;
 
 einval:
-- 
2.43.7

