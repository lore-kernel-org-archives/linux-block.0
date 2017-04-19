Return-Path: <BATV+37a85350ad3536f8a084+4987+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <jbacik@fb.com>,
	James Smart <james.smart@broadcom.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	dm-devel@redhat.com
Subject: [PATCH 21/23] swim3: remove (commented out) printing of req->errors
Date: Wed, 19 Apr 2017 21:27:06 +0200
Message-Id: <20170419192708.22098-22-hch@lst.de>
In-Reply-To: <20170419192708.22098-1-hch@lst.de>
References: <20170419192708.22098-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

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
