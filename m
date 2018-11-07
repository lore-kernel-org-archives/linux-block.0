Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38580 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727168AbeKGX2t (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Nov 2018 18:28:49 -0500
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Jens Axboe <axboe@fb.com>
Cc: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Jan Kara <jack@suse.cz>, Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2] block: respect virtual boundary mask in bvecs
Date: Wed,  7 Nov 2018 14:58:14 +0100
Message-Id: <20181107135814.15727-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

With drivers that are settting a virtual boundary constrain, we are
seeing a lot of bio splitting and smaller I/Os being submitted to the
driver.

This happens because the bio gap detection code does not account cases
where PAGE_SIZE - 1 is bigger than queue_virt_boundary() and thus will
split the bio unnecessarily.

Cc: Jan Kara <jack@suse.cz>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Acked-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>

---
Changes to v1:
* Tried to re-phrase the commit message
* Add reviews
---
 block/blk-merge.c | 2 +-
 block/blk.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 6b5ad275ed56..208658a901c6 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -46,7 +46,7 @@ static inline bool bio_will_gap(struct request_queue *q,
 		bio_get_first_bvec(prev_rq->bio, &pb);
 	else
 		bio_get_first_bvec(prev, &pb);
-	if (pb.bv_offset)
+	if (pb.bv_offset & queue_virt_boundary(q))
 		return true;
 
 	/*
diff --git a/block/blk.h b/block/blk.h
index a1841b8ff129..c85e53f21cdd 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -169,7 +169,7 @@ static inline bool biovec_phys_mergeable(struct request_queue *q,
 static inline bool __bvec_gap_to_prev(struct request_queue *q,
 		struct bio_vec *bprv, unsigned int offset)
 {
-	return offset ||
+	return (offset & queue_virt_boundary(q)) ||
 		((bprv->bv_offset + bprv->bv_len) & queue_virt_boundary(q));
 }
 
-- 
2.16.4
