Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795071968;
	b=mepW4DkVPGK+H6JQQgXx9j4JEatwheuOv8y5zT7s+Wb8bS03gevwUCXw9kFjlYUtsfom
	 4zQzkjZih4Fw64c5UI5GBOfExXVj6PsYr7zl8SmsMFRFdV+/m8cTc47R77DeW36HG/X1n
	 bGMib+kGTeTGTC23L2AFfG53/5qmZlzrA25i5LlWz/3zucP17HP2c9iw6xYE3R82P1toA
	 I8nM1flAZ0G2zdlRYgJSdz97zXRIf324+YI/ux9kLHSgHHvZWYd5UKM2hBq+wsjyWjJtz
	 ysImQi5isU8lSRCiJzU9edg0KNsBwzyZImyEsPo9seZyUZBxFOt/A+8T8FmXy+9xlVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795071968;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gzS1LHFp65SD1UCrporzHKX/WpvFu5cvA8Vm7v+e8qY=;
	b=Ym8wqAOZMjlS+u6M0IRNBxLzVh5EhDY10E0xFo7YxaPnHbAvgDHjif5E5OW66MJ3pPFS
	 WrAq3o01ppaV+BK1/RCbq1k3wt8B8L9cTuJJvuF0UJHP629wC1Ub/sm6g8NfpZ4t7Z+4s
	 8rPUrp0UBEwE+Rei4F6wpHEeO59Qx6ReS7kIs9qU9AVcUV/+6ci7IXKzFGqOwVTOveCBQ
	 4gd9YPNFUN+C7rHGO4J8rktbeb4diDz7vSdrgDe8aroZr/TODy9+kXOdZyg75uvmtcbox
	 K5QeAHD6FQlZtdG69iIqewOAoMOpQI3CQi4QSM006eLyYnq6f5NgX6dItHtyB3a+o+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UAAq+MQW;
	arc=none smtp.remote-ip=115.124.30.113
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A56606A32C
	for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 07:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2A56606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UAAq+MQW
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795071959; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=gzS1LHFp65SD1UCrporzHKX/WpvFu5cvA8Vm7v+e8qY=;
	b=UAAq+MQW4yRmqoeaNaDbppqAUB16EMRln8bTl/C6TQDFMzKyAcD84PETLgNxBQu4jlChcFrcE1o1TFwoPuBH20uLenylxH9g3HjY7qwjAxmkKxZYxMfxGyWd951VhZ9VtU9OhEVut5Bjtgms8p7g+vzd3E8oUphWYEO9zpv1ERg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XF2mP0E_1795071958;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XF2mP0E_1795071958 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Nov 2026 15:05:58 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 3/7] blk-iocost: don't take rq_qos_mutex before the queue is frozen in cost model write
Date: Thu, 19 Nov 2026 15:05:44 +0800
Message-ID: <20261119070548.3125491-4-kanie@linux.alibaba.com>
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

ioc_cost_model_write() freezes the queue while holding rq_qos_mutex,
which blkg_conf_open_bdev() acquired first. Every other path takes
rq_qos_mutex only after the queue is frozen: ioc_qos_write() releases
and re-acquires the mutex around blk_mq_freeze_queue(), and rq_qos_add()
documents that its caller holds the mutex with the queue frozen.
Waiting for in-flight IO while holding rq_qos_mutex breaks that rule,
and on the first write to a queue without iocost the path even calls
blk_iocost_init() -> rq_qos_add() -> blk_mq_freeze_queue() while
nothing has frozen the queue yet.

Mirror the release-freeze-reacquire sequence of ioc_qos_write(). The
unfreeze moves to the close_bdev label so the error exits after the
freeze don't leave the queue frozen, and it runs before
blkg_conf_close_bdev() drops the bdev reference, while the queue is
still pinned.

Fixes: 2b2da2f6dc80 ("blk-iocost: prevent configuration update concurrent with io throttling")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 block/blk-iocost.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 1c1025157d8e..8e06b83691aa 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3589,6 +3589,15 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	ret = blkg_conf_open_bdev(&ctx);
 	if (ret)
 		return ret;
+	/*
+	 * Nothing is protecting QoS state yet, so release q->rq_qos_mutex,
+	 * which was first acquired in blkg_conf_open_bdev, and re-acquire it
+	 * after freezing the queue to maintain the correct locking order.
+	 */
+	mutex_unlock(&ctx.bdev->bd_queue->rq_qos_mutex);
+
+	memflags = blk_mq_freeze_queue(ctx.bdev->bd_queue);
+	mutex_lock(&ctx.bdev->bd_queue->rq_qos_mutex);
 
 	body = ctx.body;
 	q = bdev_get_queue(ctx.bdev);
@@ -3605,7 +3614,6 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 		ioc = q_to_ioc(q);
 	}
 
-	memflags = blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue(q);
 
 	spin_lock_irq(&ioc->lock);
@@ -3663,9 +3671,9 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	spin_unlock_irq(&ioc->lock);
 
 	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q, memflags);
 
 close_bdev:
+	blk_mq_unfreeze_queue(q, memflags);
 	blkg_conf_close_bdev(&ctx);
 	return ret ?: nbytes;
 }
-- 
2.43.7

