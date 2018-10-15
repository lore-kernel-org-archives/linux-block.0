Return-Path: <hch@lst.de>
Date: Mon, 15 Oct 2018 10:45:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Richard Weinberger <richard@nod.at>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-um@lists.infradead.org,
	anton.ivanov@cambridgegreys.com
Subject: Re: [PATCH, RFC] ubd: remove use of blk_rq_map_sg
Message-ID: <20181015084541.GA27159@lst.de>
References: <20181015065637.1860-1-hch@lst.de> <4055590.4i3nx3fRmo@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4055590.4i3nx3fRmo@blindfold>
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 15, 2018 at 10:40:06AM +0200, Richard Weinberger wrote:
> hm, this breaks UML.
> Every filesystem fails to mount.
> 
> I did some very rough tests, it seems that the driver fails to read
> data correctly as soon the upper layer tries to get more than 4096 bytes
> at once out of the block device.
> 
> IOW:
> dd if=/dev/ubda bs=4096 count=1 skip=0 2>/dev/null| md5sum -
> is good.
> As soon I set bs to something greater it returns garbage.
> 
> Later this day I might have some cycles left to debug further.

It probably needs this on top:

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index aafe9c467fdc..5adce80a7ee3 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1290,7 +1290,7 @@ static void cowify_req(struct io_thread_req *req, unsigned long *bitmap,
 }
 
 static int ubd_queue_one_vec(struct blk_mq_hw_ctx *hctx, struct request *req,
-		sector_t pos, struct bio_vec *bvec)
+		u64 off, struct bio_vec *bvec)
 {
 	struct ubd *dev = hctx->queue->queuedata;
 	struct io_thread_req *io_req;
@@ -1311,7 +1311,7 @@ static int ubd_queue_one_vec(struct blk_mq_hw_ctx *hctx, struct request *req,
 	} else {
 		io_req->fds[1] = dev->fd;
 		io_req->cow_offset = -1;
-		io_req->offset = (unsigned long long)pos << 9;
+		io_req->offset = off;
 		io_req->length = bvec->bv_len;
 		io_req->error = 0;
 		io_req->sector_mask = 0;
@@ -1346,17 +1346,17 @@ static blk_status_t ubd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct bio *bio = req->bio;
 	struct bvec_iter iter;
 	struct bio_vec bvec;
-	sector_t pos = blk_rq_pos(req);
+	u64 off = (u64)blk_rq_pos(req) << 9;
 
 	blk_mq_start_request(req);
 
 	for_each_bio(bio) {
 		bio_for_each_segment(bvec, bio, iter) {
-			if (ubd_queue_one_vec(hctx, req, pos, &bvec) < 0) {
+			if (ubd_queue_one_vec(hctx, req, off, &bvec) < 0) {
 				blk_mq_requeue_request(req, true);
 				return BLK_STS_OK;
 			}
-			pos += bvec.bv_len;
+			off += bvec.bv_len;
 		}
 	}
 
