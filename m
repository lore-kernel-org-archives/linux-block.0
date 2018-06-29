Return-Path: <prvs=711f77cb4=bart.vanassche@wdc.com>
Subject: Re: [PATCH 0/3] Fix blk_mq_end_request() and blk_end_request() for
 WRITE SAME
To: Christoph Hellwig <hch@lst.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20180626001009.16557-1-bart.vanassche@wdc.com>
 <yq1a7rh5yu6.fsf@oracle.com> <20180629085827.GA16441@lst.de>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <9c9f117b-0d70-bb31-1dd1-febe1be21645@wdc.com>
Date: Fri, 29 Jun 2018 08:50:04 -0700
MIME-Version: 1.0
In-Reply-To: <20180629085827.GA16441@lst.de>
Content-Type: multipart/mixed;
 boundary="------------52B1EF09F6D2FB086B0CF842"
List-ID: <linux-block@vger.kernel.org>

This is a multi-part message in MIME format.
--------------52B1EF09F6D2FB086B0CF842
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/29/18 01:58, Christoph Hellwig wrote:
> Maybe it is time to remove REQ_OP_WRITE_SAME finally.  We don't have
> a user except for drbd which is passing it from the other side, and
> it creates way too many special cases like this.

Hello Christoph,

If REQ_OP_WRITE_SAME would be removed from the block layer, how is 
software like e.g. LIO ever expected to pass down WRITE SAME requests to 
block devices? What if in the future we would want to add support for a 
new request type to the block layer for which - just like for write same 
commands - the number of bytes affected on the medium differs from the 
data out buffer size? The SCSI spec already support several such 
commands today. One variant of the SCSI VERIFY command verifies multiple 
logical blocks on the medium but does not have a Data Out buffer. 
Another example is the COMPARE AND WRITE command, for which the size of 
the Data Out buffer is the double of the number of bytes affected on the 
medium. It's not impossible that an equivalent of COMPARE AND WRITE will 
ever be added to the NVMe spec.

Have you considered to modify the block layer such that 
blk_rq_payload_bytes() does not have to be made more complicated than 
returning a single member from the request data structure? How about the 
following approach:
* Add a new member to struct request that represents what is called the 
Data Out buffer size in the SCSI specs and keep using __data_len for the 
number of bytes affected on the medium. Modify blk_rq_bio_prep() and 
__blk_rq_prep_clone() such that these functions set both __data_len and 
the new struct request member instead of only __data_len.
* Remove RQF_SPECIAL_PAYLOAD and request.special_vec. Modify all block 
driver code that sets the RQF_SPECIAL_PAYLOAD and request.special_vec 
such that rq->bio is replaced by a bio with the proper payload and such 
that the original bio is restored before completing the request. As you 
are most likely aware there is already code in the block layer that 
replaces and restores the original request bio, namely the code in 
blk-flush.c.

If you would like to see the patches I came up with to add 
REQ_OP_WRITE_SAME support to LIO, I have attached these to this e-mail.

Thanks,

Bart.

--------------52B1EF09F6D2FB086B0CF842
Content-Type: text/x-patch;
 name="0001-block-Add-blkdev_submit_write_same.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-block-Add-blkdev_submit_write_same.patch"

>From 44c0b07191629e4d9b1cefb43cc9f84e5491bb81 Mon Sep 17 00:00:00 2001
From: Bart Van Assche <bart.vanassche@wdc.com>
Date: Thu, 28 Jun 2018 10:44:35 -0700
Subject: [PATCH 1/2] block: Add blkdev_submit_write_same()

Add an asynchronous version of blkdev_issue_write_same().

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 block/blk-lib.c        | 37 ++++++++++++++++++++++++++++++++++++-
 include/linux/blkdev.h |  3 +++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 8faa70f26fcd..680e2dadb2b8 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -212,7 +212,8 @@ static int __blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
  * @page:	page containing data
  *
  * Description:
- *    Issue a write same request for the sectors in question.
+ *    Issue a write same request for the sectors in question and wait until it
+ *    has finished.
  */
 int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 				sector_t nr_sects, gfp_t gfp_mask,
@@ -234,6 +235,40 @@ int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 }
 EXPORT_SYMBOL(blkdev_issue_write_same);
 
+/**
+ * blkdev_submit_write_same - queue a write same operation
+ * @bdev:	target blockdev
+ * @sector:	start sector
+ * @nr_sects:	number of sectors to write
+ * @gfp_mask:	memory allocation flags (for bio_alloc)
+ * @page:	page containing data
+ * @bi_end_io:  will be called upon completion
+ * @bi_private: will be stored in the bio->bi_private field of the bio passed
+ *		to @bi_end_io.
+ *
+ * Description:
+ *    Submit a write same request asynchronously for the sectors in question.
+ *    @bi_end_io will be called upon request completion.
+ */
+int blkdev_submit_write_same(struct block_device *bdev, sector_t sector,
+			     sector_t nr_sects, gfp_t gfp_mask,
+			     struct page *page, bio_end_io_t bi_end_io,
+			     void *bi_private)
+{
+	struct bio *bio = NULL;
+	int ret;
+
+	ret = __blkdev_issue_write_same(bdev, sector, nr_sects, gfp_mask, page,
+					&bio);
+	if (ret)
+		return ret;
+	bio->bi_end_io = bi_end_io;
+	bio->bi_private = bi_private;
+	submit_bio(bio);
+	return 0;
+}
+EXPORT_SYMBOL(blkdev_submit_write_same);
+
 static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop, unsigned flags)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9154570edf29..771d37c347ea 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1388,6 +1388,9 @@ static inline struct request *blk_map_queue_find_tag(struct blk_queue_tag *bqt,
 extern int blkdev_issue_flush(struct block_device *, gfp_t, sector_t *);
 extern int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct page *page);
+extern int blkdev_submit_write_same(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp_mask, struct page *page,
+		bio_end_io_t bi_end_io, void *bi_private);
 
 #define BLKDEV_DISCARD_SECURE	(1 << 0)	/* issue a secure erase */
 
-- 
2.17.1


--------------52B1EF09F6D2FB086B0CF842
Content-Type: text/x-patch;
 name="0002-target-Use-REQ_OP_WRITE_SAME-to-implement-WRITE-SAME.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-target-Use-REQ_OP_WRITE_SAME-to-implement-WRITE-SAME.pa";
 filename*1="tch"

>From 3d8c13d953221411d5d803e76e2e6cabd506d0d4 Mon Sep 17 00:00:00 2001
From: Bart Van Assche <bart.vanassche@wdc.com>
Date: Thu, 28 Jun 2018 10:12:58 -0700
Subject: [PATCH 2/2] target: Use REQ_OP_WRITE_SAME to implement WRITE SAME

Use blkdev_submit_write_same() instead of open-coding it.

Note: as one can see in target_alloc_sgl(), the target core sets the
offset in a scatter/gather list to zero for all allocated pages.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 drivers/target/target_core_iblock.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 1bc9b14236d8..fa4dd4f5c8b3 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -465,6 +465,8 @@ iblock_execute_write_same(struct se_cmd *cmd)
 	sector_t block_lba = target_to_linux_sector(dev, cmd->t_task_lba);
 	sector_t sectors = target_to_linux_sector(dev,
 					sbc_get_write_same_sectors(cmd));
+	struct blk_plug plug;
+	int ret;
 
 	if (cmd->prot_op) {
 		pr_err("WRITE_SAME: Protection information with IBLOCK"
@@ -481,6 +483,7 @@ iblock_execute_write_same(struct se_cmd *cmd)
 		return TCM_INVALID_CDB_FIELD;
 	}
 
+	/* 1. Use REQ_OP_WRITE_ZEROES if supported and if appropriate. */
 	if (bdev_write_zeroes_sectors(bdev)) {
 		if (!iblock_execute_zero_out(bdev, cmd))
 			return 0;
@@ -491,6 +494,20 @@ iblock_execute_write_same(struct se_cmd *cmd)
 		goto fail;
 	cmd->priv = ibr;
 
+	/* 2. Try REQ_OP_WRITE_SAME. */
+	blk_start_plug(&plug);
+	ret = blkdev_submit_write_same(bdev, block_lba, sectors, GFP_KERNEL,
+				       sg_page(sg), iblock_bio_done, cmd);
+	blk_finish_plug(&plug);
+	if (ret == 0)
+		return 0;
+	if (ret != -EOPNOTSUPP)
+		goto fail;
+
+	/*
+	 * 3. If neither REQ_OP_WRITE_SAME nor REQ_OP_WRITE_ZEROES are
+	 * supported, use REQ_OP_WRITE.
+	 */
 	bio = iblock_get_bio(cmd, block_lba, 1, REQ_OP_WRITE, 0);
 	if (!bio)
 		goto fail_free_ibr;
-- 
2.17.1


--------------52B1EF09F6D2FB086B0CF842--
