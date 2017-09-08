Return-Path: <prvs=4177119eb=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/5] scsi: Change the type of the second last argument of scsi_execute()
Date: Fri,  8 Sep 2017 16:52:23 -0700
Message-Id: <20170908235226.26622-3-bart.vanassche@wdc.com>
In-Reply-To: <20170908235226.26622-1-bart.vanassche@wdc.com>
References: <20170908235226.26622-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

The second last argument of scsi_execute() is either 0 or RQF_PM.
Change the type of that argument from req_flags_t into bool and
update the callers that pass RQF_PM. This patch does not change
any functionality.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi_lib.c    |  8 ++++----
 drivers/scsi/sd.c          |  4 ++--
 drivers/scsi/ufs/ufshcd.c  | 11 ++++++-----
 include/scsi/scsi_device.h |  2 +-
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index f6097b89d5d3..5be515c8c6bd 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -227,8 +227,8 @@ void scsi_queue_insert(struct scsi_cmnd *cmd, int reason)
  * @sshdr:	optional decoded sense header
  * @timeout:	request timeout in seconds
  * @retries:	number of times to retry request
- * @flags:	flags for ->cmd_flags
- * @rq_flags:	flags for ->rq_flags
+ * @flags:	REQ_* flags for ->cmd_flags
+ * @is_pm_req:	whether or not this is a power management request
  * @resid:	optional residual length
  *
  * Returns the scsi_cmnd result field if a command was executed, or a negative
@@ -237,7 +237,7 @@ void scsi_queue_insert(struct scsi_cmnd *cmd, int reason)
 int scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 		 int data_direction, void *buffer, unsigned bufflen,
 		 unsigned char *sense, struct scsi_sense_hdr *sshdr,
-		 int timeout, int retries, u64 flags, req_flags_t rq_flags,
+		 int timeout, int retries, u64 flags, bool is_pm_req,
 		 int *resid)
 {
 	struct request *req;
@@ -260,7 +260,7 @@ int scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 	rq->retries = retries;
 	req->timeout = timeout;
 	req->cmd_flags |= flags;
-	req->rq_flags |= rq_flags | RQF_QUIET | RQF_PREEMPT;
+	req->rq_flags |= (is_pm_req ? RQF_PM : 0) | RQF_QUIET | RQF_PREEMPT;
 
 	/*
 	 * head injection *required* here otherwise quiesce won't work
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index e2647f2d4430..ad22b16748c6 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1620,7 +1620,7 @@ static int sd_sync_cache(struct scsi_disk *sdkp, struct scsi_sense_hdr *sshdr)
 		 * flush everything.
 		 */
 		res = scsi_execute(sdp, cmd, DMA_NONE, NULL, 0, NULL, sshdr,
-				timeout, SD_MAX_RETRIES, 0, RQF_PM, NULL);
+				timeout, SD_MAX_RETRIES, 0, true, NULL);
 		if (res == 0)
 			break;
 	}
@@ -3469,7 +3469,7 @@ static int sd_start_stop_device(struct scsi_disk *sdkp, int start)
 		return -ENODEV;
 
 	res = scsi_execute(sdp, cmd, DMA_NONE, NULL, 0, NULL, &sshdr,
-			SD_TIMEOUT, SD_MAX_RETRIES, 0, RQF_PM, NULL);
+			SD_TIMEOUT, SD_MAX_RETRIES, 0, true, NULL);
 	if (res) {
 		sd_print_result(sdkp, "Start/Stop Unit failed", res);
 		if (driver_byte(res) & DRIVER_SENSE)
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 5bc9dc14e075..7798acd91331 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6976,7 +6976,7 @@ ufshcd_send_request_sense(struct ufs_hba *hba, struct scsi_device *sdp)
 
 	ret = scsi_execute(sdp, cmd, DMA_FROM_DEVICE, buffer,
 			UFSHCD_REQ_SENSE_SIZE, NULL, NULL,
-			msecs_to_jiffies(1000), 3, 0, RQF_PM, NULL);
+			msecs_to_jiffies(1000), 3, 0, true, NULL);
 	if (ret)
 		pr_err("%s: failed with err %d\n", __func__, ret);
 
@@ -7037,12 +7037,13 @@ static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
 	cmd[4] = pwr_mode << 4;
 
 	/*
-	 * Current function would be generally called from the power management
-	 * callbacks hence set the RQF_PM flag so that it doesn't resume the
-	 * already suspended childs.
+	 * This function is typically called from a power management
+	 * callback. Hence submit the START request as a power management
+	 * request too so that it doesn't resume the already suspended
+	 * children.
 	 */
 	ret = scsi_execute(sdp, cmd, DMA_NONE, NULL, 0, NULL, &sshdr,
-			START_STOP_TIMEOUT, 0, 0, RQF_PM, NULL);
+			START_STOP_TIMEOUT, 0, 0, true, NULL);
 	if (ret) {
 		sdev_printk(KERN_WARNING, sdp,
 			    "START_STOP failed for power mode: %d, result %x\n",
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 0979a5f3b69a..b23e771cd305 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -414,7 +414,7 @@ extern int scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 			int data_direction, void *buffer, unsigned bufflen,
 			unsigned char *sense, struct scsi_sense_hdr *sshdr,
 			int timeout, int retries, u64 flags,
-			req_flags_t rq_flags, int *resid);
+			bool is_pm_req, int *resid);
 static inline int scsi_execute_req(struct scsi_device *sdev,
 	const unsigned char *cmd, int data_direction, void *buffer,
 	unsigned bufflen, struct scsi_sense_hdr *sshdr, int timeout,
-- 
2.14.1
