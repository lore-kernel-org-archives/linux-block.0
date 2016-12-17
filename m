Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34779 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752729AbcLQKth (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Dec 2016 05:49:37 -0500
From: Ming Lei <ming.lei@canonical.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Dexuan Cui <decui@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ming Lei <ming.lei@canonical.com>,
        Keith Busch <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Christie <mchristi@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Damien Le Moal <damien.lemoal@hgst.com>
Subject: [PATCH] block: loose check on sg gap
Date: Sat, 17 Dec 2016 18:49:09 +0800
Message-Id: <1481971751-4016-1-git-send-email-ming.lei@canonical.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

If the last bvec of the 1st bio and the 1st bvec of the next
bio are contineous physically, and the latter can be merged
to last segment of the 1st bio, we should think they don't
violate sg gap(or virt boundary) limit.

Both Vitaly and Dexuan reported lots of unmergeable small bios
are observed when running mkfs on Hyper-V virtual storage, and
performance becomes quite low, so this patch is figured out for
fixing the performance issue.

The same issue should exist on NVMe too sine it sets virt boundary too.

Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reported-by: Dexuan Cui <decui@microsoft.com>
Tested-by: Dexuan Cui <decui@microsoft.com>
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 include/linux/blkdev.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 286b2a264383..1ce26e771bcc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1608,6 +1608,25 @@ static inline bool bvec_gap_to_prev(struct request_queue *q,
 	return __bvec_gap_to_prev(q, bprv, offset);
 }
 
+/*
+ * Check if the two bvecs from two bios can be merged to one segment.
+ * If yes, no need to check gap between the two bios since the 1st bio
+ * and the 1st bvec in the 2nd bio can be handled in one segment.
+ */
+static inline bool bios_segs_mergeable(struct request_queue *q,
+		struct bio *prev, struct bio_vec *prev_last_bv,
+		struct bio_vec *next_first_bv)
+{
+	if (!BIOVEC_PHYS_MERGEABLE(prev_last_bv, next_first_bv))
+		return false;
+	if (!BIOVEC_SEG_BOUNDARY(q, prev_last_bv, next_first_bv))
+		return false;
+	if (prev->bi_seg_back_size + next_first_bv->bv_len >
+			queue_max_segment_size(q))
+		return false;
+	return true;
+}
+
 static inline bool bio_will_gap(struct request_queue *q, struct bio *prev,
 			 struct bio *next)
 {
@@ -1617,7 +1636,8 @@ static inline bool bio_will_gap(struct request_queue *q, struct bio *prev,
 		bio_get_last_bvec(prev, &pb);
 		bio_get_first_bvec(next, &nb);
 
-		return __bvec_gap_to_prev(q, &pb, nb.bv_offset);
+		if (!bios_segs_mergeable(q, prev, &pb, &nb))
+			return __bvec_gap_to_prev(q, &pb, nb.bv_offset);
 	}
 
 	return false;
-- 
2.7.4

