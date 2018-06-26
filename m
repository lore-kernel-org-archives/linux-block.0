Return-Path: <prvs=708eb8c04=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/3] sd: Remove the __data_len hack for WRITE SAME again
Date: Mon, 25 Jun 2018 17:10:08 -0700
Message-Id: <20180626001009.16557-3-bart.vanassche@wdc.com>
In-Reply-To: <20180626001009.16557-1-bart.vanassche@wdc.com>
References: <20180626001009.16557-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Now that blk_rq_payload_bytes() has been fixed, remove the __data_len
hack again from sd_setup_write_same_cmnd(), the function that handles
REQ_OP_WRITE_SAME. See also commit 08965c2eba13 ("Revert "sd: remove
__data_len hack for WRITE SAME""). See also commit f80de881d8df ("sd:
remove __data_len hack for WRITE SAME").

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/sd.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 9421d9877730..89da86308aaf 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -947,8 +947,6 @@ static int sd_setup_write_same_cmnd(struct scsi_cmnd *cmd)
 	struct bio *bio = rq->bio;
 	sector_t sector = blk_rq_pos(rq);
 	unsigned int nr_sectors = blk_rq_sectors(rq);
-	unsigned int nr_bytes = blk_rq_bytes(rq);
-	int ret;
 
 	if (sdkp->device->no_write_same)
 		return BLKPREP_INVALID;
@@ -975,21 +973,7 @@ static int sd_setup_write_same_cmnd(struct scsi_cmnd *cmd)
 	cmd->transfersize = sdp->sector_size;
 	cmd->allowed = SD_MAX_RETRIES;
 
-	/*
-	 * For WRITE SAME the data transferred via the DATA OUT buffer is
-	 * different from the amount of data actually written to the target.
-	 *
-	 * We set up __data_len to the amount of data transferred via the
-	 * DATA OUT buffer so that blk_rq_map_sg sets up the proper S/G list
-	 * to transfer a single sector of data first, but then reset it to
-	 * the amount of data to be written right after so that the I/O path
-	 * knows how much to actually write.
-	 */
-	rq->__data_len = sdp->sector_size;
-	ret = scsi_init_io(cmd);
-	rq->__data_len = nr_bytes;
-
-	return ret;
+	return scsi_init_io(cmd);
 }
 
 static int sd_setup_flush_cmnd(struct scsi_cmnd *cmd)
-- 
2.17.1
