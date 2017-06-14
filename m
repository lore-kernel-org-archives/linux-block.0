Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHSET v2] Add support for write life time hints
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca
References: <1497412919-19400-1-git-send-email-axboe@kernel.dk>
 <yq160fyvah7.fsf@oracle.com> <d3e724ea-38f8-213f-a9ce-f78adc028e47@kernel.dk>
 <20170614160127.GA30644@infradead.org> <yq1shj2tv1z.fsf@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7ba27f20-ef1c-b5a5-4fd2-fc756590e6f7@kernel.dk>
Date: Wed, 14 Jun 2017 11:22:20 -0600
MIME-Version: 1.0
In-Reply-To: <yq1shj2tv1z.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/14/2017 10:04 AM, Martin K. Petersen wrote:
> 
> Christoph,
> 
>> I think what Martin wants (or at least what I'd want him to want) is
>> to define a few REQ_* bits that mirror the RWF bits, use that to
>> transfer the information down the stack, and then only translate it
>> to stream ids in the driver.
> 
> Yup. If we have enough space in the existing flags that's perfect (I
> lost count after your op/flag shuffle).

OK, diff on top of the current stuff, so you can see how that changes
things. If this looks good to folks, I'll update the series to achieve
the same final result.

diff --git a/block/bio.c b/block/bio.c
index 77f4be1f..25ea7c3 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -595,7 +595,6 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 	bio->bi_opf = bio_src->bi_opf;
 	bio->bi_iter = bio_src->bi_iter;
 	bio->bi_io_vec = bio_src->bi_io_vec;
-	bio->bi_stream = bio_src->bi_stream;
 
 	bio_clone_blkcg_association(bio, bio_src);
 }
@@ -679,7 +678,6 @@ struct bio *bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
 	bio->bi_opf		= bio_src->bi_opf;
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
-	bio->bi_stream		= bio_src->bi_stream;
 
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
@@ -2084,6 +2082,22 @@ void bio_clone_blkcg_association(struct bio *dst, struct bio *src)
 
 #endif /* CONFIG_BLK_CGROUP */
 
+static const unsigned int rwf_write_to_opf_flag[] = {
+	0, REQ_WRITE_SHORT, REQ_WRITE_MEDIUM, REQ_WRITE_LONG, REQ_WRITE_EXTREME
+};
+
+/*
+ * 'stream_flags' is one of RWF_WRITE_LIFE_* values
+ */
+void bio_set_streamid(struct bio *bio, unsigned int rwf_flags)
+{
+	if (WARN_ON_ONCE(rwf_flags >= ARRAY_SIZE(rwf_write_to_opf_flag)))
+		return;
+
+	bio->bi_opf |= rwf_write_to_opf_flag[rwf_flags];
+}
+EXPORT_SYMBOL_GPL(bio_set_streamid);
+
 static void __init biovec_init_slabs(void)
 {
 	int i;
diff --git a/block/blk-core.c b/block/blk-core.c
index 3f4a206..a7421b7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2057,12 +2057,6 @@ blk_qc_t generic_make_request(struct bio *bio)
 	do {
 		struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 
-		if (bio_op(bio) == REQ_OP_WRITE &&
-		    bio_stream(bio) < BLK_MAX_STREAM) {
-			q->stream_writes[bio_stream(bio)] +=
-						bio->bi_iter.bi_size >> 9;
-		}
-
 		if (likely(blk_queue_enter(q, false) == 0)) {
 			struct bio_list lower, same;
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 28998ac..7d299df 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -696,7 +696,8 @@ static struct request *attempt_merge(struct request_queue *q,
 	 * Don't allow merge of different streams, or for a stream with
 	 * non-stream IO.
 	 */
-	if (req->bio->bi_stream != next->bio->bi_stream)
+	if ((req->cmd_flags & REQ_WRITE_LIFE_MASK) !=
+	    (next->cmd_flags & REQ_WRITE_LIFE_MASK))
 		return NULL;
 
 	/*
@@ -822,7 +823,8 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	 * Don't allow merge of different streams, or for a stream with
 	 * non-stream IO.
 	 */
-	if (rq->bio->bi_stream != bio->bi_stream)
+	if ((rq->cmd_flags & REQ_WRITE_LIFE_MASK) !=
+	    (bio->bi_opf & REQ_WRITE_LIFE_MASK))
 		return false;
 
 	return true;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d7cbd05..8988133 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -335,6 +335,20 @@ static inline int nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	return BLK_MQ_RQ_QUEUE_OK;
 }
 
+static inline unsigned int req_to_streamid(struct request *req)
+{
+	if (req->cmd_flags & REQ_WRITE_SHORT)
+		return 1;
+	else if (req->cmd_flags & REQ_WRITE_MEDIUM)
+		return 2;
+	else if (req->cmd_flags & REQ_WRITE_LONG)
+		return 3;
+	else if (req->cmd_flags & REQ_WRITE_EXTREME)
+		return 4;
+
+	return 0;
+}
+
 static inline void nvme_setup_rw(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *cmnd)
 {
@@ -355,13 +369,15 @@ static inline void nvme_setup_rw(struct nvme_ns *ns, struct request *req,
 	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
 	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
 
-	if (req_op(req) == REQ_OP_WRITE) {
-		if (bio_stream_valid(req->bio) && ns->nr_streams) {
-			unsigned stream = bio_stream(req->bio) & 0xffff;
+	if (req_op(req) == REQ_OP_WRITE && blk_stream_valid(req->cmd_flags) &&
+	    ns->nr_streams) {
+		unsigned stream = req_to_streamid(req);
 
-			control |= NVME_RW_DTYPE_STREAMS;
-			dsmgmt |= ((stream % (ns->nr_streams + 1)) << 16);
-		}
+		control |= NVME_RW_DTYPE_STREAMS;
+		dsmgmt |= ((stream % (ns->nr_streams + 1)) << 16);
+
+		if (stream < BLK_MAX_STREAM)
+			req->q->stream_writes[stream] += blk_rq_bytes(req) >> 9;
 	}
 
 	if (ns->ms) {
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 284b8a7..31ba4a8 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -227,7 +227,6 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	bio.bi_iter.bi_sector = pos >> 9;
 	bio.bi_private = current;
 	bio.bi_end_io = blkdev_bio_end_io_simple;
-	bio.bi_stream = iocb_streamid(iocb);
 
 	ret = bio_iov_iter_get_pages(&bio, iter);
 	if (unlikely(ret))
@@ -240,6 +239,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 			should_dirty = true;
 	} else {
 		bio.bi_opf = dio_bio_write_op(iocb);
+		bio_set_streamid(&bio, iocb_streamid(iocb));
 		task_io_account_write(ret);
 	}
 
@@ -361,7 +361,6 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		bio->bi_iter.bi_sector = pos >> 9;
 		bio->bi_private = dio;
 		bio->bi_end_io = blkdev_bio_end_io;
-		bio->bi_stream = iocb_streamid(iocb);
 
 		ret = bio_iov_iter_get_pages(bio, iter);
 		if (unlikely(ret)) {
@@ -376,6 +375,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 				bio_set_pages_dirty(bio);
 		} else {
 			bio->bi_opf = dio_bio_write_op(iocb);
+			bio_set_streamid(bio, iocb_streamid(iocb));
 			task_io_account_write(bio->bi_iter.bi_size);
 		}
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index db0558a..ef3c98c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8608,7 +8608,6 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 	atomic_set(&dip->pending_bios, 0);
 	btrfs_bio = btrfs_io_bio(io_bio);
 	btrfs_bio->logical = file_offset;
-	bio_set_streamid(io_bio, bio_stream(dio_bio));
 
 	if (write) {
 		io_bio->bi_end_io = btrfs_endio_direct_write;
diff --git a/fs/direct-io.c b/fs/direct-io.c
index c9c8b9f..a770e82 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -386,7 +386,7 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 	else
 		bio->bi_end_io = dio_bio_end_io;
 
-	bio->bi_stream = iocb_streamid(dio->iocb);
+	bio_set_streamid(bio, iocb_streamid(dio->iocb));
 
 	sdio->bio = bio;
 	sdio->logical_offset_in_bio = sdio->cur_page_fs_offset;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d1b04b0..a1b3145 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -443,6 +443,7 @@ extern struct bio *bio_copy_kern(struct request_queue *, void *, unsigned int,
 				 gfp_t, int);
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);
+extern void bio_set_streamid(struct bio *bio, unsigned int rwf_flags);
 
 void generic_start_io_acct(int rw, unsigned long sectors,
 			   struct hd_struct *part);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 1940876..06c8c35 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -36,8 +36,6 @@ struct bio {
 	unsigned short		bi_flags;	/* status, etc and bvec pool number */
 	unsigned short		bi_ioprio;
 
-	unsigned int		bi_stream;	/* write life time hint */
-
 	struct bvec_iter	bi_iter;
 
 	/* Number of segments in this BIO after
@@ -203,6 +201,10 @@ enum req_flag_bits {
 	__REQ_PREFLUSH,		/* request for cache flush */
 	__REQ_RAHEAD,		/* read ahead, can fail anytime */
 	__REQ_BACKGROUND,	/* background IO */
+	__REQ_WRITE_SHORT,	/* short life time write */
+	__REQ_WRITE_MEDIUM,	/* medium life time write */
+	__REQ_WRITE_LONG,	/* long life time write */
+	__REQ_WRITE_EXTREME,	/* extremely long life time write */
 
 	/* command specific flags for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
@@ -223,6 +225,13 @@ enum req_flag_bits {
 #define REQ_PREFLUSH		(1ULL << __REQ_PREFLUSH)
 #define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
 #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
+#define REQ_WRITE_SHORT		(1ULL << __REQ_WRITE_SHORT)
+#define REQ_WRITE_MEDIUM	(1ULL << __REQ_WRITE_MEDIUM)
+#define REQ_WRITE_LONG		(1ULL << __REQ_WRITE_LONG)
+#define REQ_WRITE_EXTREME	(1ULL << __REQ_WRITE_EXTREME)
+
+#define REQ_WRITE_LIFE_MASK	(REQ_WRITE_SHORT | REQ_WRITE_MEDIUM | \
+					REQ_WRITE_LONG | REQ_WRITE_EXTREME)
 
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
 
@@ -314,19 +323,9 @@ struct blk_rq_stat {
 	u64 batch;
 };
 
-static inline void bio_set_streamid(struct bio *bio, unsigned int stream)
-{
-	bio->bi_stream = stream;
-}
-
-static inline bool bio_stream_valid(struct bio *bio)
-{
-	return bio->bi_stream != 0;
-}
-
-static inline unsigned int bio_stream(struct bio *bio)
+static inline bool blk_stream_valid(unsigned int opf)
 {
-	return bio->bi_stream;
+	return (opf & REQ_WRITE_LIFE_MASK) != 0;
 }
 
 #endif /* __LINUX_BLK_TYPES_H */

-- 
Jens Axboe
