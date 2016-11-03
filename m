Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754341AbcKCJjJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Nov 2016 05:39:09 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Jens Axboe <axboe@fb.com>
Cc: Hannes Reinecke <hare@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] block: drop q argument from bsg_validate_sgv4_hdr
Date: Thu,  3 Nov 2016 03:38:54 -0600
Message-Id: <20161103093854.3690-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

bsg_validate_sgv4_hdr() doesn't care about the request_queue, so drop it
from it's arguments.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/bsg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bsg.c b/block/bsg.c
index d214e92..8a05a40 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -176,7 +176,7 @@ static int blk_fill_sgv4_hdr_rq(struct request_queue *q, struct request *rq,
  * Check if sg_io_v4 from user is allowed and valid
  */
 static int
-bsg_validate_sgv4_hdr(struct request_queue *q, struct sg_io_v4 *hdr, int *rw)
+bsg_validate_sgv4_hdr(struct sg_io_v4 *hdr, int *rw)
 {
 	int ret = 0;
 
@@ -226,7 +226,7 @@ bsg_map_hdr(struct bsg_device *bd, struct sg_io_v4 *hdr, fmode_t has_write_perm,
 		hdr->dout_xfer_len, (unsigned long long) hdr->din_xferp,
 		hdr->din_xfer_len);
 
-	ret = bsg_validate_sgv4_hdr(q, hdr, &rw);
+	ret = bsg_validate_sgv4_hdr(hdr, &rw);
 	if (ret)
 		return ERR_PTR(ret);
 
-- 
2.10.0

