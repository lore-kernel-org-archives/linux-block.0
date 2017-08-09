Return-Path: <bblock@linux.vnet.ibm.com>
From: Benjamin Block <bblock@linux.vnet.ibm.com>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: Benjamin Block <bblock@linux.vnet.ibm.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Steffen Maier <maier@linux.vnet.ibm.com>, open-iscsi@googlegroups.com
Subject: [RFC PATCH 6/6] bsg: reduce unnecessary arguments for blk_complete_sgv4_hdr_rq()
Date: Wed,  9 Aug 2017 16:11:20 +0200
In-Reply-To: <cover.1502120928.git.bblock@linux.vnet.ibm.com>
References: <cover.1502120928.git.bblock@linux.vnet.ibm.com>
In-Reply-To: <cover.1502120928.git.bblock@linux.vnet.ibm.com>
References: <cover.1502120928.git.bblock@linux.vnet.ibm.com>
Message-Id: <d95177abfa703a4f77a3d8ddb218eaead465f5ec.1502120928.git.bblock@linux.vnet.ibm.com>
List-ID: <linux-block@vger.kernel.org>

Since struct bsg_command is now used in every calling case, we don't
need separation of arguments anymore that are contained in the same
bsg_command.

Signed-off-by: Benjamin Block <bblock@linux.vnet.ibm.com>
---
 block/bsg.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/block/bsg.c b/block/bsg.c
index 6ee2ffca808a..09f767cdf816 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -399,13 +399,14 @@ static struct bsg_command *bsg_get_done_cmd(struct bsg_device *bd)
 	return bc;
 }
 
-static int blk_complete_sgv4_hdr_rq(struct request *rq, struct sg_io_v4 *hdr,
-				    struct bio *bio, struct bio *bidi_bio)
+static int blk_complete_sgv4_hdr_rq(struct bsg_command *bc)
 {
+	struct sg_io_v4 *hdr = &bc->hdr;
+	struct request *rq = bc->rq;
 	struct scsi_request *req = scsi_req(rq);
 	int ret = 0;
 
-	dprintk("rq %p bio %p 0x%x\n", rq, bio, req->result);
+	dprintk("rq %p bio %p 0x%x\n", rq, bc->bio, req->result);
 	/*
 	 * fill in all the output members
 	 */
@@ -432,7 +433,7 @@ static int blk_complete_sgv4_hdr_rq(struct request *rq, struct sg_io_v4 *hdr,
 	if (rq->next_rq) {
 		hdr->dout_resid = req->resid_len;
 		hdr->din_resid = scsi_req(rq->next_rq)->resid_len;
-		blk_rq_unmap_user(bidi_bio);
+		blk_rq_unmap_user(bc->bidi_bio);
 		blk_put_request(rq->next_rq);
 	} else if (rq_data_dir(rq) == READ)
 		hdr->din_resid = req->resid_len;
@@ -448,7 +449,7 @@ static int blk_complete_sgv4_hdr_rq(struct request *rq, struct sg_io_v4 *hdr,
 	if (!ret && req->result < 0)
 		ret = req->result;
 
-	blk_rq_unmap_user(bio);
+	blk_rq_unmap_user(bc->bio);
 	scsi_req_free_cmd(req);
 	blk_put_request(rq);
 
@@ -507,8 +508,7 @@ static int bsg_complete_all_commands(struct bsg_device *bd)
 		if (IS_ERR(bc))
 			break;
 
-		tret = blk_complete_sgv4_hdr_rq(bc->rq, &bc->hdr, bc->bio,
-						bc->bidi_bio);
+		tret = blk_complete_sgv4_hdr_rq(bc);
 		if (!ret)
 			ret = tret;
 
@@ -542,8 +542,7 @@ __bsg_read(char __user *buf, size_t count, struct bsg_device *bd,
 		 * after completing the request. so do that here,
 		 * bsg_complete_work() cannot do that for us
 		 */
-		ret = blk_complete_sgv4_hdr_rq(bc->rq, &bc->hdr, bc->bio,
-					       bc->bidi_bio);
+		ret = blk_complete_sgv4_hdr_rq(bc);
 
 		if (copy_to_user(buf, &bc->hdr, sizeof(bc->hdr)))
 			ret = -EFAULT;
@@ -944,8 +943,7 @@ static long bsg_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		blk_execute_rq(bd->queue, NULL, bc->rq, at_head);
 		bc->hdr.duration = jiffies_to_msecs(jiffies - bc->hdr.duration);
 
-		ret = blk_complete_sgv4_hdr_rq(bc->rq, &bc->hdr, bc->bio,
-					       bc->bidi_bio);
+		ret = blk_complete_sgv4_hdr_rq(bc);
 
 		if (copy_to_user(uarg, &bc->hdr, sizeof(bc->hdr)))
 			ret = -EFAULT;
-- 
2.12.2
