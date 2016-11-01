Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50190 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424284AbcKANkX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2016 09:40:23 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/16] blk-cgroup: use op_is_sync to check for synchronous requests
Date: Tue,  1 Nov 2016 07:40:03 -0600
Message-Id: <1478007617-18715-3-git-send-email-hch@lst.de>
In-Reply-To: <1478007617-18715-1-git-send-email-hch@lst.de>
References: <1478007617-18715-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk-cgroup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index ddaf28d..01b62e7 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -599,7 +599,7 @@ static inline void blkg_rwstat_add(struct blkg_rwstat *rwstat,
 
 	__percpu_counter_add(cnt, val, BLKG_STAT_CPU_BATCH);
 
-	if (op & REQ_SYNC)
+	if (op_is_sync(op))
 		cnt = &rwstat->cpu_cnt[BLKG_RWSTAT_SYNC];
 	else
 		cnt = &rwstat->cpu_cnt[BLKG_RWSTAT_ASYNC];
-- 
2.1.4

