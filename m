Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795071967;
	b=zcQY2sBL8PZKNFkv3452nynW2Ay5k+85uZ/TXoKB+UkN+qpENhizRULsAuUOlNLD1iM6
	 Wa0BfVthY4kzrzJF5/H+0h3loFiOTsZ/cJMOHyBpia4KbnsCFAf246hpMDob9henGUrje
	 d3KOzNfiTNUnippZjTI/L96ijPI0mZANevqcY4dTH/j5F6ei8bc6ZYaaWzlGDfxUDg6DR
	 6ERtE965y8k3u6ekrBWf5mIUgV5P5iBew7x69FYbmPpBIPCjC+vtDVv7IzmtIJYwDxg6a
	 W4O1vGD//oVrlgZnhCcUq3nXVE2PYcwLha1hMlJy+BwPjXuASmAV0/NZ2uo+MNwTWQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795071967;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b2oHOKkIVIFYmxWgnb/5q+IHBUc+S62NOaQv/v8cd7M=;
	b=eb8WXVESd0UmhhVv46DrKp3bdqbF/jJvCSoY9FWrbMAIKSCj7CQybZ28LPuTZN67VPUo
	 dQASmiVMRTcbMcQ5BlQbY5z3ogxCzO+5W1XrEg8OTI/rzbswKOV6stK3lC4oXOlSP7Tg6
	 V+nAV6lOP3dks7KJXnqS14YwE+bgRBMYQf3t44C39Way29KTbUHNCQ/fepp6oGpC+G+/9
	 qkWiGn7zSF78bu0A5TVFpS1j7h2flxmKD0cwKeHmKHNBXlH/8ELwaCCSXRlmPtJd/HEHp
	 r+iL4KzWJsB22CJYscsxDjOENtDF7yom3LGS6Rz1WD34G2XqMj2kIFTaDGozJ6Bt4QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mDkXs+U6;
	arc=none smtp.remote-ip=115.124.30.99
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A764606A32F
	for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 07:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A764606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mDkXs+U6
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795071963; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=b2oHOKkIVIFYmxWgnb/5q+IHBUc+S62NOaQv/v8cd7M=;
	b=mDkXs+U6dAJU7GBt/qW4bF//FoUiXIZwOkPD8LCnJUYU+X1vUvzciJGRypYaroKBCJ8576itQGWJDk8djZdR7aVZPIvwplsiPWh9r1pVc2JBw98E2IIgTTX3PWE/K9lliwOs4JQRDir3Q2d6LYdTfiT6/CAmMUzImx04xI1l2Do=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XF2mP1k_1795071961;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XF2mP1k_1795071961 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Nov 2026 15:06:02 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 7/7] blk-mq: unpublish the tags before deferring their free to SRCU
Date: Thu, 19 Nov 2026 15:05:48 +0800
Message-ID: <20261119070548.3125491-8-kanie@linux.alibaba.com>
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

__blk_mq_free_map_and_rqs() frees set->tags[hctx_idx] first, which
starts the tags_srcu grace period, and only then stores NULL into the
slot. The store is a plain store, unordered against the plain load in
blk_mq_tagset_busy_iter(), which reads set->tags[i] to find the tags to
walk. A reader that enters the SRCU read side after the grace period
snapshot, but still loads the old, non-NULL pointer, is not waited for
by that grace period, so blk_mq_free_tags_callback() can free the tags
and everything they point to while the iterator is about to walk them.

blk_mq_tagset_busy_iter() is reachable from the nvme and scsi timeout
and error recovery paths without any queue freeze gating the free, so
nothing else serializes the two.

Clear set->tags[hctx_idx] before blk_mq_free_map_and_rqs(), so a reader
either sees NULL and skips the tags, or loads the pointer before
entering the SRCU read side, in which case the grace period waits for
it.

Fixes: 995412e23bb25 ("blk-mq: Replace tags->lock with SRCU for tag iterators")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 block/blk-mq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 87c1ccdf66ab..b58f73256202 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4179,10 +4179,11 @@ void blk_mq_free_map_and_rqs(struct blk_mq_tag_set *set,
 static void __blk_mq_free_map_and_rqs(struct blk_mq_tag_set *set,
 				      unsigned int hctx_idx)
 {
-	if (!blk_mq_is_shared_tags(set->flags))
-		blk_mq_free_map_and_rqs(set, set->tags[hctx_idx], hctx_idx);
+	struct blk_mq_tags *tags = set->tags[hctx_idx];
 
 	set->tags[hctx_idx] = NULL;
+	if (!blk_mq_is_shared_tags(set->flags))
+		blk_mq_free_map_and_rqs(set, tags, hctx_idx);
 }
 
 static void blk_mq_map_swqueue(struct request_queue *q)
-- 
2.43.7

