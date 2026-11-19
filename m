Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795071970;
	b=b4NJ7ynu6RoPQ2XYq0zwnubChdlpYgzxo0HtvRqZQJc+BHzQKDoE4cBd6TRH8JKI7uXw
	 gz7G0uVmG41FcGyWwXKEiIvvJhUNVkU+LnQeK46zCsEpNAqoCnEvXyJ5fAP3WaCqDOx0r
	 q5DjdrqVLs/v/qU9fRaXJH/xpQ4X7JGmc4OkOC4AVkOYA6fDdGqZDc77vA5EnYz0IJB/l
	 78DgvoRhDWsTCinT5egp5HecWJ2f3ByAgMugTIZnSxFFTiO0IkFlnmfPb9NKazYG6ssd1
	 CJFyWAUx05ZZt4PTrWIwx8aIjO+aivgQl7bKRSWSIUQQmJigF6xq8gcf7dGC1hXSjIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795071970;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1eryADoLRL2SH8s9k4Aisqd/Q4v4Rs2GodZK6xdpTMY=;
	b=vUVgw1VkMqZXjsTpap/GmiL0PYQHOby5VnzHOpw66g/NSnLHg/gTRS1LgXaULZ8GeVDy
	 WATV9TgYs511mFpQKkO3/jN11N3x036DJyfSaoMxNoxb3h4epKeneRoabOc6n1RYHPioO
	 8PGt+YSANyUc0ARmLn3Q5TleAfvoWC0+FAIoxUsMAq9zQ9c48SGSylxF33sf6oYKXOX6q
	 PhAmhezfS3CgQz+6BBpDPudn6zIi2Lnoq1843GeWHfT4f6JpWb2tfOmJZuTqy3TfkrhMM
	 vIi2XmASNJGcjr16RT4X/sGodxyeCVqyTvIWDhDKOxd+5OSgVLb2hv7pbwk3ikoWmjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jhlmGKAp;
	arc=none smtp.remote-ip=115.124.30.97
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EA3606A331
	for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 07:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14EA3606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jhlmGKAp
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795071961; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=1eryADoLRL2SH8s9k4Aisqd/Q4v4Rs2GodZK6xdpTMY=;
	b=jhlmGKApQaH3h2Ct9BZYlfND2HY8KReDLjuAVCMkQNvFQfCBuUor1fqlXp0p6tcxYI95pFrD9+JHmTcz+CBkRhyM8Myf2vvbsEzzZYauObKyFMCNzR8R1q5PYyrnAD+BlEIO3/xgswtwdqSNtollRoKlJdQERRRdYCGOLTuqhtg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XF2mP0w_1795071960;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XF2mP0w_1795071960 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Nov 2026 15:06:00 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 5/7] blk-stat: account for the mean of the source in blk_rq_stat_sum()
Date: Thu, 19 Nov 2026 15:05:46 +0800
Message-ID: <20261119070548.3125491-6-kanie@linux.alibaba.com>
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

blk_rq_stat_sum() folds a src into a dst by combining dst->mean with
src->batch only, so it is only correct while src has never been folded
itself: its mean is then either zero or stale. blk-iolatency folds the
per-cpu stats into a window-local stat first and then folds that result
into iolat->cur_stat, so the second fold drops the whole window and
cur_stat.rqs.mean stays at zero. On rotating disks, where the mean
decides whether the accumulated window meets the latency target,
iolatency_check_latencies() therefore always considers the accumulated
window OK and scales up more aggressively than intended.

Fold src->mean * src->nr_samples into the result as well. The per-cpu
users keep their mean at zero through blk_rq_stat_init(), so their
behavior is unchanged.

Fixes: 451bb7c33197 ("blk-iolatency: keep track of previous windows stats")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 block/blk-stat.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-stat.c b/block/blk-stat.c
index d57c2fc6bf06..6345ae366658 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -24,7 +24,10 @@ void blk_rq_stat_init(struct blk_rq_stat *stat)
 	stat->batch = 0;
 }
 
-/* src is a per-cpu stat, mean isn't initialized */
+/*
+ * The mean of @src must have been calculated or set to zero by
+ * blk_rq_stat_init() before calling this.
+ */
 void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
 {
 	if (dst->nr_samples + src->nr_samples <= dst->nr_samples)
@@ -33,7 +36,8 @@ void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
 	dst->min = min(dst->min, src->min);
 	dst->max = max(dst->max, src->max);
 
-	dst->mean = div_u64(src->batch + dst->mean * dst->nr_samples,
+	dst->mean = div_u64(dst->mean * dst->nr_samples +
+				src->mean * src->nr_samples + src->batch,
 				dst->nr_samples + src->nr_samples);
 
 	dst->nr_samples += src->nr_samples;
-- 
2.43.7

