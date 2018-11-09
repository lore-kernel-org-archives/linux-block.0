Return-Path: <BATV+1ef63fdb319281f35549+5556+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 6/7] scsi: return blk_status_t from device handler ->prep_fn
Date: Fri,  9 Nov 2018 14:42:40 +0100
Message-Id: <20181109134241.29346-7-hch@lst.de>
In-Reply-To: <20181109134241.29346-1-hch@lst.de>
References: <20181109134241.29346-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Remove the last use of the old BLKPREP_* values, which get converted
to BLK_STS_* later anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/device_handler/scsi_dh_alua.c  | 21 +++++++++++----------
 drivers/scsi/device_handler/scsi_dh_emc.c   |  8 ++++----
 drivers/scsi/device_handler/scsi_dh_hp_sw.c |  7 +++----
 drivers/scsi/device_handler/scsi_dh_rdac.c  |  7 +++----
 drivers/scsi/scsi_lib.c                     | 18 +++---------------
 include/scsi/scsi_dh.h                      |  2 +-
 6 files changed, 25 insertions(+), 38 deletions(-)

diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
index 12dc7100bb4c..d7ac498ba35a 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -1071,28 +1071,29 @@ static void alua_check(struct scsi_device *sdev, bool force)
  * Fail I/O to all paths not in state
  * active/optimized or active/non-optimized.
  */
-static int alua_prep_fn(struct scsi_device *sdev, struct request *req)
+static blk_status_t alua_prep_fn(struct scsi_device *sdev, struct request *req)
 {
 	struct alua_dh_data *h = sdev->handler_data;
 	struct alua_port_group *pg;
 	unsigned char state = SCSI_ACCESS_STATE_OPTIMAL;
-	int ret = BLKPREP_OK;
 
 	rcu_read_lock();
 	pg = rcu_dereference(h->pg);
 	if (pg)
 		state = pg->state;
 	rcu_read_unlock();
-	if (state == SCSI_ACCESS_STATE_TRANSITIONING)
-		ret = BLKPREP_DEFER;
-	else if (state != SCSI_ACCESS_STATE_OPTIMAL &&
-		 state != SCSI_ACCESS_STATE_ACTIVE &&
-		 state != SCSI_ACCESS_STATE_LBA) {
-		ret = BLKPREP_KILL;
+
+	switch (state) {
+	case SCSI_ACCESS_STATE_OPTIMAL:
+	case SCSI_ACCESS_STATE_ACTIVE:
+	case SCSI_ACCESS_STATE_LBA:
+		return BLK_STS_OK;
+	case SCSI_ACCESS_STATE_TRANSITIONING:
+		return BLK_STS_RESOURCE;
+	default:
 		req->rq_flags |= RQF_QUIET;
+		return BLK_STS_IOERR;
 	}
-	return ret;
-
 }
 
 static void alua_rescan(struct scsi_device *sdev)
diff --git a/drivers/scsi/device_handler/scsi_dh_emc.c b/drivers/scsi/device_handler/scsi_dh_emc.c
index 95c47909a58f..bea8e13febb6 100644
--- a/drivers/scsi/device_handler/scsi_dh_emc.c
+++ b/drivers/scsi/device_handler/scsi_dh_emc.c
@@ -341,17 +341,17 @@ static int clariion_check_sense(struct scsi_device *sdev,
 	return SCSI_RETURN_NOT_HANDLED;
 }
 
-static int clariion_prep_fn(struct scsi_device *sdev, struct request *req)
+static blk_status_t clariion_prep_fn(struct scsi_device *sdev,
+		struct request *req)
 {
 	struct clariion_dh_data *h = sdev->handler_data;
-	int ret = BLKPREP_OK;
 
 	if (h->lun_state != CLARIION_LUN_OWNED) {
-		ret = BLKPREP_KILL;
 		req->rq_flags |= RQF_QUIET;
+		return BLK_STS_IOERR;
 	}
-	return ret;
 
+	return BLK_STS_OK;
 }
 
 static int clariion_std_inquiry(struct scsi_device *sdev,
diff --git a/drivers/scsi/device_handler/scsi_dh_hp_sw.c b/drivers/scsi/device_handler/scsi_dh_hp_sw.c
index e65a0ebb4b54..80129b033855 100644
--- a/drivers/scsi/device_handler/scsi_dh_hp_sw.c
+++ b/drivers/scsi/device_handler/scsi_dh_hp_sw.c
@@ -172,17 +172,16 @@ static int hp_sw_start_stop(struct hp_sw_dh_data *h)
 	return rc;
 }
 
-static int hp_sw_prep_fn(struct scsi_device *sdev, struct request *req)
+static blk_status_t hp_sw_prep_fn(struct scsi_device *sdev, struct request *req)
 {
 	struct hp_sw_dh_data *h = sdev->handler_data;
-	int ret = BLKPREP_OK;
 
 	if (h->path_state != HP_SW_PATH_ACTIVE) {
-		ret = BLKPREP_KILL;
 		req->rq_flags |= RQF_QUIET;
+		return BLK_STS_IOERR;
 	}
-	return ret;
 
+	return BLK_STS_OK;
 }
 
 /*
diff --git a/drivers/scsi/device_handler/scsi_dh_rdac.c b/drivers/scsi/device_handler/scsi_dh_rdac.c
index d27fabae8ddd..65f1fe343c64 100644
--- a/drivers/scsi/device_handler/scsi_dh_rdac.c
+++ b/drivers/scsi/device_handler/scsi_dh_rdac.c
@@ -642,17 +642,16 @@ static int rdac_activate(struct scsi_device *sdev,
 	return 0;
 }
 
-static int rdac_prep_fn(struct scsi_device *sdev, struct request *req)
+static blk_status_t rdac_prep_fn(struct scsi_device *sdev, struct request *req)
 {
 	struct rdac_dh_data *h = sdev->handler_data;
-	int ret = BLKPREP_OK;
 
 	if (h->state != RDAC_STATE_ACTIVE) {
-		ret = BLKPREP_KILL;
 		req->rq_flags |= RQF_QUIET;
+		return BLK_STS_IOERR;
 	}
-	return ret;
 
+	return BLK_STS_OK;
 }
 
 static int rdac_check_sense(struct scsi_device *sdev,
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 3e3bdeee8f14..5d83a162d03b 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1177,18 +1177,6 @@ void scsi_init_command(struct scsi_device *dev, struct scsi_cmnd *cmd)
 	scsi_add_cmd_to_list(cmd);
 }
 
-static inline blk_status_t prep_to_mq(int ret)
-{
-	switch (ret) {
-	case BLKPREP_OK:
-		return BLK_STS_OK;
-	case BLKPREP_DEFER:
-		return BLK_STS_RESOURCE;
-	default:
-		return BLK_STS_IOERR;
-	}
-}
-
 static blk_status_t scsi_setup_scsi_cmnd(struct scsi_device *sdev,
 		struct request *req)
 {
@@ -1227,9 +1215,9 @@ static blk_status_t scsi_setup_fs_cmnd(struct scsi_device *sdev,
 	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
 
 	if (unlikely(sdev->handler && sdev->handler->prep_fn)) {
-		int ret = sdev->handler->prep_fn(sdev, req);
-		if (ret != BLKPREP_OK)
-			return prep_to_mq(ret);
+		blk_status_t ret = sdev->handler->prep_fn(sdev, req);
+		if (ret != BLK_STS_OK)
+			return ret;
 	}
 
 	cmd->cmnd = scsi_req(req)->cmd = scsi_req(req)->__cmd;
diff --git a/include/scsi/scsi_dh.h b/include/scsi/scsi_dh.h
index c7bba2b24849..a862dc23c68d 100644
--- a/include/scsi/scsi_dh.h
+++ b/include/scsi/scsi_dh.h
@@ -69,7 +69,7 @@ struct scsi_device_handler {
 	int (*attach)(struct scsi_device *);
 	void (*detach)(struct scsi_device *);
 	int (*activate)(struct scsi_device *, activate_complete, void *);
-	int (*prep_fn)(struct scsi_device *, struct request *);
+	blk_status_t (*prep_fn)(struct scsi_device *, struct request *);
 	int (*set_params)(struct scsi_device *, const char *);
 	void (*rescan)(struct scsi_device *);
 };
-- 
2.19.1
