Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F6F22066;
	Tue,  4 Jun 2024 03:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717470336; cv=none; b=YxUWqErGlJ/AMQ9lcPT+Vef7wC/oN9A2V4utFEHH4Qy9EiPqSiJu5mC2TuxvW5yIQM+4cvYBjTpoLmvOlrMigZM5bS26cZkZxBdjVqnBhgRsvjYmv8LLEbszPPJ9TxRjwqCnH0gWYZGZBZuMRdONsubdlKjwt6kwgvTot7fsalA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717470336; c=relaxed/simple;
	bh=TjaFwGrFwaGILWgco03ETMMoCWc9v2lfQI1Zp4UqB+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n5SceV7gu6tLiai08zdx6BgbewQ6yuJVidFFTJ3CApI0pOyZwlP01AdsuHInwQrUK2Va2EAEOHTprd3RXY02uqG7Ngnn3lSin0z1QXUCW3Fqp9rzZxXqqyqzrrOepJ4apaPPfy0b/fRqbXFBji6S3dxzbNJwQ5ZAM55NzhDB3Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vtb7D2tcjz4f3mHW;
	Tue,  4 Jun 2024 11:05:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 764471A0C1D;
	Tue,  4 Jun 2024 11:05:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFxhF5mc+oMOg--.44342S4;
	Tue, 04 Jun 2024 11:05:23 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	hch@infradead.org,
	linux-kernel@vger.kernel.org,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	yukuai3@huawei.com,
	libaokun1@huawei.com
Subject: [PATCH -next] blk-wbt: don't throttle swap writes in direct reclaim
Date: Tue,  4 Jun 2024 11:05:22 +0800
Message-Id: <20240604030522.3686177-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RFxhF5mc+oMOg--.44342S4
X-Coremail-Antispam: 1UD129KBjvJXoWxurWxKFyrJr15AF4xCry3Arb_yoW5Zr4kpr
	43K3WDtFyqvFs7Xrn7XayxX3yru3yUtr43Ary5Kr1SvrW3Kr1aqa1vkw13KF4UZrZ3uw42
	qr4Fyry7Jr43ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UuVbkUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

From: Baokun Li <libaokun1@huawei.com>

Now we avoid throttling swap writes by determining whether the current
process is kswapd (aka current_is_kswapd()), but swap writes can come
from either kswapd or direct reclaim, so the swap writes from direct
reclaim will still be throttled.

When a process holds a lock to allocate a free page, and enters direct
reclaim because there is no free memory, then it might trigger a hung
due to the wbt throttling that causes other processes to fail to get
the lock.

Both kswapd and direct reclaim set the REQ_SWAP flag, so use REQ_SWAP
instead of current_is_kswapd() to avoid throttling swap writes. Also
renamed WBT_KSWAPD to WBT_SWAP and WBT_RWQ_KSWAPD to WBT_RWQ_SWAP.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 block/blk-wbt.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 64472134dd26..aaacf2f5b223 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -37,7 +37,7 @@
 enum wbt_flags {
 	WBT_TRACKED		= 1,	/* write, tracked for throttling */
 	WBT_READ		= 2,	/* read */
-	WBT_KSWAPD		= 4,	/* write, from kswapd */
+	WBT_SWAP		= 4,	/* write, from swap_writepage() */
 	WBT_DISCARD		= 8,	/* discard */
 
 	WBT_NR_BITS		= 4,	/* number of bits */
@@ -45,7 +45,7 @@ enum wbt_flags {
 
 enum {
 	WBT_RWQ_BG		= 0,
-	WBT_RWQ_KSWAPD,
+	WBT_RWQ_SWAP,
 	WBT_RWQ_DISCARD,
 	WBT_NUM_RWQ,
 };
@@ -172,8 +172,8 @@ static bool wb_recent_wait(struct rq_wb *rwb)
 static inline struct rq_wait *get_rq_wait(struct rq_wb *rwb,
 					  enum wbt_flags wb_acct)
 {
-	if (wb_acct & WBT_KSWAPD)
-		return &rwb->rq_wait[WBT_RWQ_KSWAPD];
+	if (wb_acct & WBT_SWAP)
+		return &rwb->rq_wait[WBT_RWQ_SWAP];
 	else if (wb_acct & WBT_DISCARD)
 		return &rwb->rq_wait[WBT_RWQ_DISCARD];
 
@@ -528,7 +528,7 @@ static bool close_io(struct rq_wb *rwb)
 		time_before(now, rwb->last_comp + HZ / 10);
 }
 
-#define REQ_HIPRIO	(REQ_SYNC | REQ_META | REQ_PRIO)
+#define REQ_HIPRIO	(REQ_SYNC | REQ_META | REQ_PRIO | REQ_SWAP)
 
 static inline unsigned int get_limit(struct rq_wb *rwb, blk_opf_t opf)
 {
@@ -539,13 +539,13 @@ static inline unsigned int get_limit(struct rq_wb *rwb, blk_opf_t opf)
 
 	/*
 	 * At this point we know it's a buffered write. If this is
-	 * kswapd trying to free memory, or REQ_SYNC is set, then
+	 * swap trying to free memory, or REQ_SYNC is set, then
 	 * it's WB_SYNC_ALL writeback, and we'll use the max limit for
 	 * that. If the write is marked as a background write, then use
 	 * the idle limit, or go to normal if we haven't had competing
 	 * IO for a bit.
 	 */
-	if ((opf & REQ_HIPRIO) || wb_recent_wait(rwb) || current_is_kswapd())
+	if ((opf & REQ_HIPRIO) || wb_recent_wait(rwb))
 		limit = rwb->rq_depth.max_depth;
 	else if ((opf & REQ_BACKGROUND) || close_io(rwb)) {
 		/*
@@ -622,8 +622,8 @@ static enum wbt_flags bio_to_wbt_flags(struct rq_wb *rwb, struct bio *bio)
 	if (bio_op(bio) == REQ_OP_READ) {
 		flags = WBT_READ;
 	} else if (wbt_should_throttle(bio)) {
-		if (current_is_kswapd())
-			flags |= WBT_KSWAPD;
+		if (bio->bi_opf & REQ_SWAP)
+			flags |= WBT_SWAP;
 		if (bio_op(bio) == REQ_OP_DISCARD)
 			flags |= WBT_DISCARD;
 		flags |= WBT_TRACKED;
-- 
2.39.2

