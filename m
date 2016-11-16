Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHSET] Add support for simplified async direct-io
To: Christoph Hellwig <hch@infradead.org>
References: <20161114173728.GA22167@infradead.org>
 <71ce9ae3-214d-b248-3507-cc96bea41a9b@fb.com>
 <20161114180052.GA24476@infradead.org>
 <4f30a528-9996-4c6a-9513-8aa2054e4d4b@fb.com>
 <20161114180503.GA31126@infradead.org>
 <d9baad75-d105-2968-1b59-608a8598e3bb@fb.com>
 <20161114181119.GA9396@infradead.org>
 <f8c29e81-7323-7362-b507-1b7c61e8a19a@fb.com>
 <20161116163147.GA25038@infradead.org>
 <72b1725a-0363-d33e-f890-251b1ac88998@kernel.dk>
 <20161116171652.GA30008@infradead.org>
 <c46c5e60-a5eb-2862-2b1b-f994fd0d3fe3@kernel.dk>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ee72e7d0-e885-7b0a-b9cc-6572b0614c20@kernel.dk>
Date: Wed, 16 Nov 2016 13:36:36 -0700
MIME-Version: 1.0
In-Reply-To: <c46c5e60-a5eb-2862-2b1b-f994fd0d3fe3@kernel.dk>
Content-Type: multipart/mixed;
 boundary="------------116CEF85CD4B7EB85C0E48D0"
List-ID: <linux-block@vger.kernel.org>

This is a multi-part message in MIME format.
--------------116CEF85CD4B7EB85C0E48D0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 11/16/2016 01:02 PM, Jens Axboe wrote:
> On 11/16/2016 10:16 AM, Christoph Hellwig wrote:
>> I've pushed out a new version of my code that avoids atomic ops
>> for the single bio case:
>>
>> http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/new-dio
>>
>> I think we should take your extension of the existing
>> __blkdev_direct_IO_simple to kmalloc up to BIO_MAX_PAGES and then use
>> the above implementation for AIO and large synchronous I/O.
>>
>> I think I can also kill of blkdev_dio_pool by simply using bio_kmalloc
>> as we're only doing the allocation at the beginning of the call,
>> but I'd like to agree on an approach before spending too much time on
>> it.
>>
>
> I'm fine with this approach, but I would still REALLY like to see
> blkdev_bio_end_io() split in two, once for sync and once for async. That
> would be a lot cleaner, imho.
>
> Let me know how you want to do it. I added SYNC support for mine here,
> the branch is here:
>
> http://git.kernel.dk/cgit/linux-block/log/?h=for-4.10/dio

Attaching two patches here that add the BIO_MAX_PAGES extension, and the 
SYNC support for your branch. Latter is untested... You can add my 
reviewed-by to:

7bed5be4f28cc86e3929c0c0fbba24ca0344f36c
57c2cf5c2595c0054855d7402d3796b5924fd05c

I'd like to get this in for 4.10.

-- 
Jens Axboe


--------------116CEF85CD4B7EB85C0E48D0
Content-Type: text/x-patch;
 name="0002-block-add-suppor-for-flushing-cache-for-O_SYNC-DSYNC.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-block-add-suppor-for-flushing-cache-for-O_SYNC-DSYNC.pa";
 filename*1="tch"

>From f28e75e618e578b6763dfc7bb44df88619bfdbdf Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@fb.com>
Date: Wed, 16 Nov 2016 13:33:42 -0700
Subject: [PATCH 2/2] block: add suppor for flushing cache for O_SYNC/DSYNC

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 fs/block_dev.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 59 insertions(+), 8 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index d34ec663f538..052f1cf605cc 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -186,6 +186,18 @@ static void blkdev_bio_end_io_simple(struct bio *bio)
 	wake_up_process(waiter);
 }
 
+static bool dio_should_flush_cache(struct file *file)
+{
+	if ((file->f_flags & O_DSYNC) || IS_SYNC(file->f_mapping->host)) {
+		struct block_device *bdev = I_BDEV(bdev_file_inode(file));
+		struct request_queue *q = bdev_get_queue(bdev);
+
+		return test_bit(QUEUE_FLAG_WC, &q->queue_flags) != 0;
+	}
+
+	return false;
+}
+
 static ssize_t
 __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 		int nr_pages)
@@ -256,22 +268,52 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 
 	if (unlikely(bio.bi_error))
 		return bio.bi_error;
-	iocb->ki_pos += ret;
+
+	if (bio_op(&bio) == REQ_OP_WRITE && dio_should_flush_cache(file)) {
+		struct request_queue *q = bdev_get_queue(bdev);
+
+		if (test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
+			int err;
+
+			err = blkdev_issue_flush(bdev, GFP_KERNEL, NULL);
+			if (err && err != -EOPNOTSUPP)
+				ret = ret;
+		}
+	}
+
+	if (ret > 0)
+		iocb->ki_pos += ret;
+
 	return ret;
 }
 
 struct blkdev_dio {
 	struct kiocb		*iocb;
 	struct task_struct	*waiter;
+	struct block_device	*bdev;
 	size_t			size;
 	atomic_t		ref;
 	bool			multi_bio : 1;
 	bool			should_dirty : 1;
+	bool			should_flush : 1;
+	struct work_struct	work;
 	struct bio		bio;
 };
 
 static struct bio_set *blkdev_dio_pool __read_mostly;
 
+static void blkdev_flush_cache_fn(struct work_struct *work)
+{
+	struct blkdev_dio *dio = container_of(work, struct blkdev_dio, work);
+	int ret;
+
+	ret = blkdev_issue_flush(dio->bdev, GFP_KERNEL, NULL);
+	if (!ret || ret == -EOPNOTSUPP)
+		ret = dio->size;
+
+	dio->iocb->ki_complete(dio->iocb, ret, 0);
+}
+
 static void blkdev_bio_end_io(struct bio *bio)
 {
 	struct blkdev_dio *dio = bio->bi_private;
@@ -282,15 +324,19 @@ static void blkdev_bio_end_io(struct bio *bio)
 			dio->bio.bi_error = bio->bi_error;
 	} else {
 		if (iocb) {
-			ssize_t ret = dio->bio.bi_error;
+			if (dio->should_flush)
+				kblockd_schedule_work(&dio->work);
+			else {
+				ssize_t ret = dio->bio.bi_error;
+
+				if (likely(!ret)) {
+					ret = dio->size;
+					iocb->ki_pos += ret;
+				}
 
-			if (likely(!ret)) {
-				ret = dio->size;
-				iocb->ki_pos += ret;
+				dio->iocb->ki_complete(iocb, ret, 0);
+				bio_put(&dio->bio);
 			}
-
-			dio->iocb->ki_complete(iocb, ret, 0);
-			bio_put(&dio->bio);
 		} else {
 			struct task_struct *waiter = dio->waiter;
 
@@ -335,10 +381,15 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 	dio = container_of(bio, struct blkdev_dio, bio);
 	dio->iocb = is_sync ? NULL : iocb;
 	dio->waiter = current;
+	dio->bdev = bdev;
 	dio->size = 0;
 	dio->multi_bio = false;
 	dio->should_dirty = is_read && (iter->type == ITER_IOVEC);
 
+	dio->should_flush = !is_read && dio_should_flush_cache(file);
+	if (dio->should_flush)
+		INIT_WORK(&dio->work, blkdev_flush_cache_fn);
+
 	for (;;) {
 		bio->bi_bdev = bdev;
 		bio->bi_iter.bi_sector = pos >> blkbits;
-- 
2.7.4


--------------116CEF85CD4B7EB85C0E48D0
Content-Type: text/x-patch;
 name="0001-block-support-any-sized-IO-for-simplified-bdev-direc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-block-support-any-sized-IO-for-simplified-bdev-direc.pa";
 filename*1="tch"

>From 84629aca0c25cab79b2e03f2e046b5691255bf17 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@fb.com>
Date: Mon, 14 Nov 2016 10:19:47 -0700
Subject: [PATCH 1/2] block: support any sized IO for simplified bdev direct-io

Just alloc the bio_vec array if we exceed the inline limit.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 fs/block_dev.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 6c8b6dfac1e5..d34ec663f538 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -193,7 +193,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	struct file *file = iocb->ki_filp;
 	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
 	unsigned blkbits = blksize_bits(bdev_logical_block_size(bdev));
-	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *bvec;
+	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *vecs, *bvec;
 	loff_t pos = iocb->ki_pos;
 	bool should_dirty = false;
 	struct bio bio;
@@ -204,9 +204,17 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	if ((pos | iov_iter_alignment(iter)) & ((1 << blkbits) - 1))
 		return -EINVAL;
 
+	if (nr_pages <= DIO_INLINE_BIO_VECS)
+		vecs = inline_vecs;
+	else {
+		vecs = kmalloc(nr_pages * sizeof(struct bio_vec), GFP_KERNEL);
+		if (!vecs)
+			return -ENOMEM;
+	}
+
 	bio_init(&bio);
 	bio.bi_max_vecs = nr_pages;
-	bio.bi_io_vec = inline_vecs;
+	bio.bi_io_vec = vecs;
 	bio.bi_bdev = bdev;
 	bio.bi_iter.bi_sector = pos >> blkbits;
 	bio.bi_private = current;
@@ -243,6 +251,9 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 		put_page(bvec->bv_page);
 	}
 
+	if (vecs != inline_vecs)
+		kfree(vecs);
+
 	if (unlikely(bio.bi_error))
 		return bio.bi_error;
 	iocb->ki_pos += ret;
@@ -408,7 +419,7 @@ blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
 	if (!nr_pages)
 		return 0;
-	if (is_sync_kiocb(iocb) && nr_pages <= DIO_INLINE_BIO_VECS)
+	if (is_sync_kiocb(iocb))
 		return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
 	return __blkdev_direct_IO(iocb, iter, nr_pages);
 }
-- 
2.7.4


--------------116CEF85CD4B7EB85C0E48D0--
