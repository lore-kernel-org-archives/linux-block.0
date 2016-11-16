Subject: Re: [PATCHSET] Add support for simplified async direct-io
To: Christoph Hellwig <hch@infradead.org>
References: <1479144519-15738-1-git-send-email-axboe@fb.com>
 <20161114173728.GA22167@infradead.org>
 <71ce9ae3-214d-b248-3507-cc96bea41a9b@fb.com>
 <20161114180052.GA24476@infradead.org>
 <4f30a528-9996-4c6a-9513-8aa2054e4d4b@fb.com>
 <20161114180503.GA31126@infradead.org>
 <d9baad75-d105-2968-1b59-608a8598e3bb@fb.com>
 <20161114181119.GA9396@infradead.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <f8c29e81-7323-7362-b507-1b7c61e8a19a@fb.com>
Date: Wed, 16 Nov 2016 09:09:17 -0700
MIME-Version: 1.0
In-Reply-To: <20161114181119.GA9396@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/14/2016 11:11 AM, Christoph Hellwig wrote:
> On Mon, Nov 14, 2016 at 11:08:46AM -0700, Jens Axboe wrote:
>> It'd be cleaner to loop one level out, and avoid all that 'dio' stuff
>> instead. And then still retain the separate parts of the sync and async.
>> There's nothing to share there imho, and it just makes the code harder
>> to read.
>
> How do you avoid it for the async case?  We can only call ki_complete
> once all bios have finished, which means we need a tracking structure
> for it.  For the synchronous case we could in theory wait for the
> previous bio before sending the next, but there are plenty of RAID
> arrays that would prefer > 1MB I/O.  And we can pretty much reuse the
> async case for this anyway.

Another idea - just limit the max we can support in the simplified
version as a single bio. If the user is requesting more, fall back to
the old slow path. Doesn't really matter, since the transfer size will
be large enough to hopefully overcome any deficiencies in the old path.

That avoids having the atomic inc/dec in the fast path, and having to
loop for both aio/sync O_DIRECT.

Example below.

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 7c3ec60..becc78e 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -176,9 +176,68 @@ static struct inode *bdev_file_inode(struct file *file)
  	return file->f_mapping->host;
  }

+static void blkdev_bio_end_io_async(struct bio *bio)
+{
+	struct kiocb *iocb = bio->bi_private;
+
+	iocb->ki_complete(iocb, bio->bi_error, 0);
+
+	if (bio_op(bio) == REQ_OP_READ)
+		bio_check_pages_dirty(bio);
+	else
+		bio_put(bio);
+}
+
+static ssize_t
+__blkdev_direct_IO_async(struct kiocb *iocb, struct iov_iter *iter,
+			 int nr_pages)
+{
+	struct file *file = iocb->ki_filp;
+	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
+	unsigned blkbits = blksize_bits(bdev_logical_block_size(bdev));
+	loff_t pos = iocb->ki_pos;
+	struct bio *bio;
+	ssize_t ret;
+
+	if ((pos | iov_iter_alignment(iter)) & ((1 << blkbits) - 1))
+		return -EINVAL;
+
+	bio = bio_alloc(GFP_KERNEL, nr_pages);
+	if (!bio)
+		return -ENOMEM;
+
+	bio->bi_bdev = bdev;
+	bio->bi_iter.bi_sector = pos >> blkbits;
+	bio->bi_private = iocb;
+	bio->bi_end_io = blkdev_bio_end_io_async;
+
+	ret = bio_iov_iter_get_pages(bio, iter);
+	if (unlikely(ret))
+		return ret;
+
+	/*
+	 * Overload bio size in error. If it gets set, we lose the
+	 * size, but we don't need the size for that case. IO is limited
+	 * to BIO_MAX_PAGES, so we can't overflow.
+	 */
+	ret = bio->bi_error = bio->bi_iter.bi_size;
+
+	if (iov_iter_rw(iter) == READ) {
+		bio_set_op_attrs(bio, REQ_OP_READ, 0);
+		bio_set_pages_dirty(bio);
+	} else {
+		bio_set_op_attrs(bio, REQ_OP_WRITE, REQ_SYNC | REQ_IDLE);
+		task_io_account_write(ret);
+	}
+
+	submit_bio(bio);
+	iocb->ki_pos += ret;
+	return -EIOCBQUEUED;
+}
+
  #define DIO_INLINE_BIO_VECS 4

-static void blkdev_bio_end_io_simple(struct bio *bio)
+static void blkdev_bio_end_io_sync(struct bio *bio)
  {
  	struct task_struct *waiter = bio->bi_private;

@@ -187,13 +246,12 @@ static void blkdev_bio_end_io_simple(struct bio *bio)
  }

  static ssize_t
-__blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
-		int nr_pages)
+__blkdev_direct_IO_sync(struct kiocb *iocb, struct iov_iter *iter, int 
nr_pages)
  {
  	struct file *file = iocb->ki_filp;
  	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
  	unsigned blkbits = blksize_bits(bdev_logical_block_size(bdev));
-	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *bvec;
+	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *vecs, *bvec;
  	loff_t pos = iocb->ki_pos;
  	bool should_dirty = false;
  	struct bio bio;
@@ -204,13 +262,21 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, 
struct iov_iter *iter,
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
-	bio.bi_end_io = blkdev_bio_end_io_simple;
+	bio.bi_end_io = blkdev_bio_end_io_sync;

  	ret = bio_iov_iter_get_pages(&bio, iter);
  	if (unlikely(ret))
@@ -243,6 +309,9 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct 
iov_iter *iter,
  		put_page(bvec->bv_page);
  	}

+	if (vecs != inline_vecs)
+		kfree(vecs);
+
  	if (unlikely(bio.bi_error))
  		return bio.bi_error;
  	iocb->ki_pos += ret;
@@ -252,18 +321,25 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, 
struct iov_iter *iter,
  static ssize_t
  blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
  {
-	struct file *file = iocb->ki_filp;
-	struct inode *inode = bdev_file_inode(file);
  	int nr_pages;

-	nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
+	nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES + 1);
  	if (!nr_pages)
  		return 0;
-	if (is_sync_kiocb(iocb) && nr_pages <= DIO_INLINE_BIO_VECS)
-		return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
-	return __blockdev_direct_IO(iocb, inode, I_BDEV(inode), iter,
-				    blkdev_get_block, NULL, NULL,
-				    DIO_SKIP_DIO_COUNT);
+
+	if (nr_pages > BIO_MAX_PAGES) {
+		struct file *file = iocb->ki_filp;
+		struct inode *inode = bdev_file_inode(file);
+
+		return __blockdev_direct_IO(iocb, inode, I_BDEV(inode), iter,
+						blkdev_get_block, NULL, NULL,
+						DIO_SKIP_DIO_COUNT);
+	}
+
+	if (is_sync_kiocb(iocb))
+		return __blkdev_direct_IO_sync(iocb, iter, nr_pages);
+
+	return __blkdev_direct_IO_async(iocb, iter, nr_pages);
  }

  int __sync_blockdev(struct block_device *bdev, int wait)

-- 
Jens Axboe
