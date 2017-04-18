Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:44464 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757438AbdDRPwq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2017 11:52:46 -0400
From: Christoph Hellwig <hch@bombadil.infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <jbacik@fb.com>,
        James Smart <james.smart@broadcom.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: swim3: remove (commented out) printing of req->errors
Date: Tue, 18 Apr 2017 08:52:26 -0700
Message-Id: <20170418155229.5977-21-hch@bombadil.infradead.org>
In-Reply-To: <20170418155229.5977-1-hch@bombadil.infradead.org>
References: <20170418155229.5977-1-hch@bombadil.infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/swim3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index 61b3ffa4f458..ba4809c9bdba 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -343,8 +343,8 @@ static void start_request(struct floppy_state *fs)
 			  req->rq_disk->disk_name, req->cmd,
 			  (long)blk_rq_pos(req), blk_rq_sectors(req),
 			  bio_data(req->bio));
-		swim3_dbg("           errors=%d current_nr_sectors=%u\n",
-			  req->errors, blk_rq_cur_sectors(req));
+		swim3_dbg("           current_nr_sectors=%u\n",
+			  blk_rq_cur_sectors(req));
 #endif
 
 		if (blk_rq_pos(req) >= fs->total_secs) {
-- 
2.11.0
