Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795071965;
	b=whivRwiXIhlEA5wHllJ7rnHlhtf1BW42d+tU9/6EIaGbpRdjnlDXinBAdczHy41Lviyj
	 MaCakNSel7CIDihs4f51TACK3Ite8u5PP1bJhmYDnx3YSt66tD4IZihP+/7jLawtniTls
	 Gf/a4+PGA8VI58YxXQDrQNb6wTPuEq+XvFNNl9QFyhAlCtnfJ8UqWn8ESfhI4iY6YA568
	 U3g61Yr7PDj1aph7khKsiSpDC8tLwzvbNYG8pr3PXMSBCNvMoBYikxHTY+KeqhVQZNtqO
	 OmflgM7QXlZZhvSvqNDjSWqIn2QdC2GmzbPRfVuPpLabNgljyQvUmfN9lB6o3rd5D1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795071965;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=o5mqeLGQ/wjZwT42YkF8lsa0sym3EIBk14YG4svJ0cc=;
	b=Ezjjblda4agfUvdCscG8PoMt+FrAuc+D7t9mvXP01Wto116wJQrD0MUvtFFyYZsev/ov
	 I37OK63DeRNRqrDu5sbEPFWPqfmlvCswb8Clep545B8M+KCpaWALLVqt+1Rl/2h32gyMg
	 sQFlcdZfYV283wNV2eHKeKyJz62r/GwL2h8ltqoi0/NNrrXvArQ1v/+uQfEsB6NU0fc3Y
	 8/b/yaN2ueap8a8m3XQieb3XsQ9hl+3Exb10o2ONThf7JkYXDVoKNMYY1SjSyW9JkCWH+
	 zaGF8luJ2xsrq0NaZ5FiTfUNPmYtOS4RI5dlR+KzcNMN02HvorZBy7ObsfoIx+V6MSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=T7DaA2M6;
	arc=none smtp.remote-ip=115.124.30.119
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629F5606A320
	for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 07:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 629F5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=T7DaA2M6
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795071958; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=o5mqeLGQ/wjZwT42YkF8lsa0sym3EIBk14YG4svJ0cc=;
	b=T7DaA2M6wDIDMe2yIBJARfzWgIwN3jG2akzO3BwIE30B+c55guuvD/gbz8YC8sL5J6v5K9lLUUV7CL2BYjVckJmKEj7By5YeZbTokxu4MLToqar9UPQfePqoq7XMnBbwfIPTBQQa2nCDe9WRtn0rzSzbJqmkK0v5S3n3cmXV5ZY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XF2hAX-_1795071957;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XF2hAX-_1795071957 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Nov 2026 15:05:57 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/7] blk-mq: clear stale stopped flag on hctx reuse
Date: Thu, 19 Nov 2026 15:05:43 +0800
Message-ID: <20261119070548.3125491-3-kanie@linux.alibaba.com>
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

When a driver stops a hardware queue with blk_mq_stop_hw_queues() and
the number of hardware queues shrinks before it calls
blk_mq_start_stopped_hw_queues() again, the parked hctx keeps its
BLK_MQ_S_STOPPED flag: the exit path does not clear it, and
blk_mq_start_stopped_hw_queues() only walks the live hctxs. A later
update that reuses the parked hctx via blk_mq_alloc_and_init_hctx()
inherits the flag, so blk_mq_run_hw_queue() refuses to run requests
queued on it until the driver happens to stop and restart the queue
again.

Clear BLK_MQ_S_STOPPED in blk_mq_init_hctx() so a reused hctx starts
like a freshly allocated one, matching the BLK_MQ_S_INACTIVE handling.

Fixes: 2f8f1336a48b ("blk-mq: always free hctx after request queue is freed")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 block/blk-mq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ae12f2a52cc9..87c1ccdf66ab 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4016,6 +4016,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
 
 	hctx->queue_num = hctx_idx;
 	clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
+	clear_bit(BLK_MQ_S_STOPPED, &hctx->state);
 
 	hctx->tags = set->tags[hctx_idx];
 
-- 
2.43.7

