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
Subject: [RFC PATCH 5/6] bsg: reduce unnecessary arguments for bsg_map_hdr()
Date: Wed,  9 Aug 2017 16:11:19 +0200
In-Reply-To: <cover.1502120928.git.bblock@linux.vnet.ibm.com>
References: <cover.1502120928.git.bblock@linux.vnet.ibm.com>
In-Reply-To: <cover.1502120928.git.bblock@linux.vnet.ibm.com>
References: <cover.1502120928.git.bblock@linux.vnet.ibm.com>
Message-Id: <6d4d39222a4b76f9b39ec52e0aca5b01a3fac9e1.1502120928.git.bblock@linux.vnet.ibm.com>
List-ID: <linux-block@vger.kernel.org>

Since struct bsg_command is now used in every calling case, we don't
need separation of arguments anymore that are contained in the same
bsg_command.

Signed-off-by: Benjamin Block <bblock@linux.vnet.ibm.com>
---
 block/bsg.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/bsg.c b/block/bsg.c
index 8517361a9b3f..6ee2ffca808a 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -212,11 +212,12 @@ bsg_validate_sgv4_hdr(struct sg_io_v4 *hdr, int *op)
  * map sg_io_v4 to a request.
  */
 static struct request *
-bsg_map_hdr(struct bsg_device *bd, struct sg_io_v4 *hdr, fmode_t has_write_perm,
-	    u8 *reply_buffer)
+bsg_map_hdr(struct bsg_device *bd, struct bsg_command *bc,
+	    fmode_t has_write_perm)
 {
 	struct request_queue *q = bd->queue;
 	struct request *rq, *next_rq = NULL;
+	struct sg_io_v4 *hdr = &bc->hdr;
 	int ret;
 	unsigned int op, dxfer_len;
 	void __user *dxferp = NULL;
@@ -244,7 +245,7 @@ bsg_map_hdr(struct bsg_device *bd, struct sg_io_v4 *hdr, fmode_t has_write_perm,
 	if (IS_ERR(rq))
 		return rq;
 
-	ret = blk_fill_sgv4_hdr_rq(q, rq, hdr, bd, reply_buffer,
+	ret = blk_fill_sgv4_hdr_rq(q, rq, hdr, bd, bc->reply_buffer,
 				   has_write_perm);
 	if (ret)
 		goto out;
@@ -633,8 +634,7 @@ static int __bsg_write(struct bsg_device *bd, const char __user *buf,
 		/*
 		 * get a request, fill in the blanks, and add to request queue
 		 */
-		rq = bsg_map_hdr(bd, &bc->hdr, has_write_perm,
-				 bc->reply_buffer);
+		rq = bsg_map_hdr(bd, bc, has_write_perm);
 		if (IS_ERR(rq)) {
 			ret = PTR_ERR(rq);
 			rq = NULL;
@@ -934,8 +934,7 @@ static long bsg_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			goto sg_io_out;
 		}
 
-		bc->rq = bsg_map_hdr(bd, &bc->hdr, file->f_mode & FMODE_WRITE,
-				     bc->reply_buffer);
+		bc->rq = bsg_map_hdr(bd, bc, file->f_mode & FMODE_WRITE);
 		if (IS_ERR(bc->rq)) {
 			ret = PTR_ERR(bc->rq);
 			goto sg_io_out;
-- 
2.12.2
