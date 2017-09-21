Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35825 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbdIURNG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 13:13:06 -0400
Received: by mail-wr0-f193.google.com with SMTP id n64so3477110wrb.2
        for <linux-block@vger.kernel.org>; Thu, 21 Sep 2017 10:13:05 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: cope with WRITE ZEROES failing in blkdev_issue_zeroout()
Date: Thu, 21 Sep 2017 19:12:52 +0200
Message-Id: <1506013972-23049-3-git-send-email-idryomov@gmail.com>
In-Reply-To: <1506013972-23049-1-git-send-email-idryomov@gmail.com>
References: <1506013972-23049-1-git-send-email-idryomov@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

sd_config_write_same() ignores ->max_ws_blocks == 0 and resets it to
permit trying WRITE SAME on older SCSI devices, unless ->no_write_same
is set.  Because REQ_OP_WRITE_ZEROES is implemented in terms of WRITE
SAME, blkdev_issue_zeroout() may fail with -EREMOTEIO:

  $ fallocate -zn -l 1k /dev/sdg
  fallocate: fallocate failed: Remote I/O error
  $ fallocate -zn -l 1k /dev/sdg  # OK
  $ fallocate -zn -l 1k /dev/sdg  # OK

The following calls succeed because sd_done() sets ->no_write_same in
response to a sense that would become BLK_STS_TARGET/-EREMOTEIO, causing
__blkdev_issue_zeroout() to fall back to generating ZERO_PAGE bios.

This means blkdev_issue_zeroout() must cope with WRITE ZEROES failing
and fall back to manually zeroing, unless BLKDEV_ZERO_NOFALLBACK is
specified.  For BLKDEV_ZERO_NOFALLBACK case, return -EOPNOTSUPP if
sd_done() has just set ->no_write_same thus indicating lack of offload
support.

Fixes: c20cfc27a473 ("block: stop using blkdev_issue_write_same for zeroing")
Cc: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 block/blk-lib.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 6b97feb71065..1cb402beb983 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -316,12 +316,6 @@ static void __blkdev_issue_zero_pages(struct block_device *bdev,
  *  Zero-fill a block range, either using hardware offload or by explicitly
  *  writing zeroes to the device.
  *
- *  Note that this function may fail with -EOPNOTSUPP if the driver signals
- *  zeroing offload support, but the device fails to process the command (for
- *  some devices there is no non-destructive way to verify whether this
- *  operation is actually supported).  In this case the caller should call
- *  retry the call to blkdev_issue_zeroout() and the fallback path will be used.
- *
  *  If a device is using logical block provisioning, the underlying space will
  *  not be released if %flags contains BLKDEV_ZERO_NOUNMAP.
  *
@@ -374,6 +368,27 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 			&bio, flags);
 	if (ret == 0 && bio) {
 		ret = submit_bio_wait(bio);
+		/*
+		 * Fall back to a manual zeroout on any error, if allowed.
+		 *
+		 * Particularly, WRITE ZEROES may fail with -EREMOTEIO if the
+		 * driver signals zeroing offload support, but the device
+		 * fails to process the command (for some devices there is no
+		 * non-destructive way to verify whether this operation is
+		 * actually supported).
+		 */
+		if (ret && bio_op(bio) == REQ_OP_WRITE_ZEROES) {
+			if (flags & BLKDEV_ZERO_NOFALLBACK) {
+				if (!bdev_write_zeroes_sectors(bdev))
+					ret = -EOPNOTSUPP;
+			} else {
+				bio_put(bio);
+				bio = NULL;
+				__blkdev_issue_zero_pages(bdev, sector,
+						    nr_sects, gfp_mask, &bio);
+				ret = submit_bio_wait(bio);
+			}
+		}
 		bio_put(bio);
 	}
 	blk_finish_plug(&plug);
-- 
2.4.3
