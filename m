Return-Path: <BATV+a67a43e55467fd1c3dfd+4677+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: mst@redhat.com,
	ooo@electrozaur.com,
	bhalevy@primarydata.com,
	nab@linux-iscsi.org,
	linux-block@vger.kernel.org
Subject: [PATCH 3/7] block: ensure bios return from blk_get_request are properly initialized
Date: Mon, 13 Jun 2016 17:21:14 +0200
Message-Id: <1465831278-23653-4-git-send-email-hch@lst.de>
In-Reply-To: <1465831278-23653-1-git-send-email-hch@lst.de>
References: <1465831278-23653-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

blk_get_request is used for BLOCK_PC and similar pass through requests.
Currently we always need to call blk_rq_set_block_pc or an opencoded
version of it to allow appending bios using the request mapping helpers
later on, which is a somewhat awkward API.  Instead move the
initialization part of blk_rq_set_block_pc into blk_get_request, so that
we always have a safe to use request.  blk_rq_set_block_pc now goes away
in favor of just setting cmd_type to REQ_TYPE_BLOCK_PC, or nothing in case
it was overriden with a different type a little later (or earlier in case
of the SCSI OSD code..)

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c                            | 27 +++++++++------------------
 block/blk-mq.c                              |  5 +++++
 block/bsg.c                                 |  2 +-
 block/scsi_ioctl.c                          |  6 +++---
 drivers/block/pktcdvd.c                     |  2 +-
 drivers/block/virtio_blk.c                  |  1 -
 drivers/cdrom/cdrom.c                       |  2 +-
 drivers/nvme/host/core.c                    |  4 ----
 drivers/scsi/device_handler/scsi_dh_emc.c   |  2 +-
 drivers/scsi/device_handler/scsi_dh_hp_sw.c |  4 ++--
 drivers/scsi/device_handler/scsi_dh_rdac.c  |  2 +-
 drivers/scsi/osd/osd_initiator.c            |  3 +--
 drivers/scsi/osst.c                         |  2 +-
 drivers/scsi/scsi_error.c                   |  2 +-
 drivers/scsi/scsi_lib.c                     |  2 +-
 drivers/scsi/sg.c                           |  2 +-
 drivers/scsi/st.c                           |  2 +-
 drivers/target/target_core_pscsi.c          |  2 +-
 fs/nfsd/blocklayout.c                       |  2 +-
 include/linux/blkdev.h                      |  1 -
 20 files changed, 32 insertions(+), 43 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index c94c7ad..2b179cd 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1294,10 +1294,16 @@ static struct request *blk_old_get_request(struct request_queue *q, int rw,
 
 	spin_lock_irq(q->queue_lock);
 	rq = get_request(q, rw, 0, NULL, gfp_mask);
-	if (IS_ERR(rq))
+	if (IS_ERR(rq)) {
 		spin_unlock_irq(q->queue_lock);
-	/* q->queue_lock is unlocked at this point */
+		return rq;
+	}
 
+	/* q->queue_lock is unlocked at this point */
+	rq->__data_len = 0;
+	rq->__sector = (sector_t) -1;
+	rq->bio = rq->biotail = NULL;
+	memset(rq->__cmd, 0, sizeof(rq->__cmd));
 	return rq;
 }
 
@@ -1351,7 +1357,7 @@ struct request *blk_make_request(struct request_queue *q, struct bio *bio,
 	if (IS_ERR(rq))
 		return rq;
 
-	blk_rq_set_block_pc(rq);
+	rq->cmd_type = REQ_TYPE_BLOCK_PC;
 
 	for_each_bio(bio) {
 		struct bio *bounce_bio = bio;
@@ -1370,21 +1376,6 @@ struct request *blk_make_request(struct request_queue *q, struct bio *bio,
 EXPORT_SYMBOL(blk_make_request);
 
 /**
- * blk_rq_set_block_pc - initialize a request to type BLOCK_PC
- * @rq:		request to be initialized
- *
- */
-void blk_rq_set_block_pc(struct request *rq)
-{
-	rq->cmd_type = REQ_TYPE_BLOCK_PC;
-	rq->__data_len = 0;
-	rq->__sector = (sector_t) -1;
-	rq->bio = rq->biotail = NULL;
-	memset(rq->__cmd, 0, sizeof(rq->__cmd));
-}
-EXPORT_SYMBOL(blk_rq_set_block_pc);
-
-/**
  * blk_requeue_request - put a request back on queue
  * @q:		request queue where request should be inserted
  * @rq:		request to be inserted
diff --git a/block/blk-mq.c b/block/blk-mq.c
index bc7166d..80dce26 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -263,6 +263,11 @@ struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
 		blk_queue_exit(q);
 		return ERR_PTR(-EWOULDBLOCK);
 	}
+
+	rq->__data_len = 0;
+	rq->__sector = (sector_t) -1;
+	rq->bio = rq->biotail = NULL;
+	memset(rq->__cmd, 0, sizeof(rq->__cmd));
 	return rq;
 }
 EXPORT_SYMBOL(blk_mq_alloc_request);
diff --git a/block/bsg.c b/block/bsg.c
index d214e92..c0199d7 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -236,7 +236,7 @@ bsg_map_hdr(struct bsg_device *bd, struct sg_io_v4 *hdr, fmode_t has_write_perm,
 	rq = blk_get_request(q, rw, GFP_KERNEL);
 	if (IS_ERR(rq))
 		return rq;
-	blk_rq_set_block_pc(rq);
+	rq->cmd_type = REQ_TYPE_BLOCK_PC;
 
 	ret = blk_fill_sgv4_hdr_rq(q, rq, hdr, bd, has_write_perm);
 	if (ret)
diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 0774799..3750ddb 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -318,7 +318,7 @@ static int sg_io(struct request_queue *q, struct gendisk *bd_disk,
 	rq = blk_get_request(q, writing ? WRITE : READ, GFP_KERNEL);
 	if (IS_ERR(rq))
 		return PTR_ERR(rq);
-	blk_rq_set_block_pc(rq);
+	rq->cmd_type = REQ_TYPE_BLOCK_PC;
 
 	if (hdr->cmd_len > BLK_MAX_CDB) {
 		rq->cmd = kzalloc(hdr->cmd_len, GFP_KERNEL);
@@ -449,7 +449,7 @@ int sg_scsi_ioctl(struct request_queue *q, struct gendisk *disk, fmode_t mode,
 		err = PTR_ERR(rq);
 		goto error_free_buffer;
 	}
-	blk_rq_set_block_pc(rq);
+	rq->cmd_type = REQ_TYPE_BLOCK_PC;
 
 	cmdlen = COMMAND_SIZE(opcode);
 
@@ -539,7 +539,7 @@ static int __blk_send_generic(struct request_queue *q, struct gendisk *bd_disk,
 	rq = blk_get_request(q, WRITE, __GFP_RECLAIM);
 	if (IS_ERR(rq))
 		return PTR_ERR(rq);
-	blk_rq_set_block_pc(rq);
+	rq->cmd_type = REQ_TYPE_BLOCK_PC;
 	rq->timeout = BLK_DEFAULT_SG_TIMEOUT;
 	rq->cmd[0] = cmd;
 	rq->cmd[4] = data;
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 9393bc7..66ad416 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -707,7 +707,7 @@ static int pkt_generic_packet(struct pktcdvd_device *pd, struct packet_command *
 			     WRITE : READ, __GFP_RECLAIM);
 	if (IS_ERR(rq))
 		return PTR_ERR(rq);
-	blk_rq_set_block_pc(rq);
+	rq->cmd_type = REQ_TYPE_BLOCK_PC;
 
 	if (cgc->buflen) {
 		ret = blk_rq_map_kern(q, rq, cgc->buffer, cgc->buflen,
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 963a130..0be7dd6 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -243,7 +243,6 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
 	req = blk_get_request(q, READ, GFP_KERNEL);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
-	blk_rq_set_block_pc(req);
 	req->cmd_type = REQ_TYPE_DRV_PRIV;
 
 	err = blk_rq_map_kern(q, req, id_str, VIRTIO_BLK_ID_BYTES, GFP_KERNEL);
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 1b257ea..6d20659 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2185,7 +2185,7 @@ static int cdrom_read_cdda_bpc(struct cdrom_device_info *cdi, __u8 __user *ubuf,
 			ret = PTR_ERR(rq);
 			break;
 		}
-		blk_rq_set_block_pc(rq);
+		rq->cmd_type = REQ_TYPE_BLOCK_PC;
 
 		ret = blk_rq_map_user(q, rq, NULL, ubuf, len, GFP_KERNEL);
 		if (ret) {
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9d7cee4..cb8ca1b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -201,10 +201,6 @@ struct request *nvme_alloc_request(struct request_queue *q,
 
 	req->cmd_type = REQ_TYPE_DRV_PRIV;
 	req->cmd_flags |= REQ_FAILFAST_DRIVER;
-	req->__data_len = 0;
-	req->__sector = (sector_t) -1;
-	req->bio = req->biotail = NULL;
-
 	req->cmd = (unsigned char *)cmd;
 	req->cmd_len = sizeof(struct nvme_command);
 
diff --git a/drivers/scsi/device_handler/scsi_dh_emc.c b/drivers/scsi/device_handler/scsi_dh_emc.c
index 375d818..f6ebf6f 100644
--- a/drivers/scsi/device_handler/scsi_dh_emc.c
+++ b/drivers/scsi/device_handler/scsi_dh_emc.c
@@ -277,7 +277,7 @@ static struct request *get_req(struct scsi_device *sdev, int cmd,
 		return NULL;
 	}
 
-	blk_rq_set_block_pc(rq);
+	rq->cmd_type = REQ_TYPE_BLOCK_PC;
 	rq->cmd_len = COMMAND_SIZE(cmd);
 	rq->cmd[0] = cmd;
 
diff --git a/drivers/scsi/device_handler/scsi_dh_hp_sw.c b/drivers/scsi/device_handler/scsi_dh_hp_sw.c
index 9406d5f..4ae6c15 100644
--- a/drivers/scsi/device_handler/scsi_dh_hp_sw.c
+++ b/drivers/scsi/device_handler/scsi_dh_hp_sw.c
@@ -113,7 +113,7 @@ retry:
 	if (IS_ERR(req))
 		return SCSI_DH_RES_TEMP_UNAVAIL;
 
-	blk_rq_set_block_pc(req);
+	req->cmd_type = REQ_TYPE_BLOCK_PC;
 	req->cmd_flags |= REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
 			  REQ_FAILFAST_DRIVER;
 	req->cmd_len = COMMAND_SIZE(TEST_UNIT_READY);
@@ -243,7 +243,7 @@ static int hp_sw_start_stop(struct hp_sw_dh_data *h)
 	if (IS_ERR(req))
 		return SCSI_DH_RES_TEMP_UNAVAIL;
 
-	blk_rq_set_block_pc(req);
+	req->cmd_type = REQ_TYPE_BLOCK_PC;
 	req->cmd_flags |= REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
 			  REQ_FAILFAST_DRIVER;
 	req->cmd_len = COMMAND_SIZE(START_STOP);
diff --git a/drivers/scsi/device_handler/scsi_dh_rdac.c b/drivers/scsi/device_handler/scsi_dh_rdac.c
index 06fbd0b..1b84b4a 100644
--- a/drivers/scsi/device_handler/scsi_dh_rdac.c
+++ b/drivers/scsi/device_handler/scsi_dh_rdac.c
@@ -275,7 +275,7 @@ static struct request *get_rdac_req(struct scsi_device *sdev,
 				"get_rdac_req: blk_get_request failed.\n");
 		return NULL;
 	}
-	blk_rq_set_block_pc(rq);
+	rq->cmd_type = REQ_TYPE_BLOCK_PC;
 
 	if (buflen && blk_rq_map_kern(q, rq, buffer, buflen, GFP_NOIO)) {
 		blk_put_request(rq);
diff --git a/drivers/scsi/osd/osd_initiator.c b/drivers/scsi/osd/osd_initiator.c
index daa4dc1..868ae29d 100644
--- a/drivers/scsi/osd/osd_initiator.c
+++ b/drivers/scsi/osd/osd_initiator.c
@@ -1567,7 +1567,7 @@ static struct request *_make_request(struct request_queue *q, bool has_write,
 		if (IS_ERR(req))
 			return req;
 
-		blk_rq_set_block_pc(req);
+		req->cmd_type = REQ_TYPE_BLOCK_PC;
 		return req;
 	}
 }
@@ -1605,7 +1605,6 @@ static int _init_blk_request(struct osd_request *or,
 				ret = PTR_ERR(req);
 				goto out;
 			}
-			blk_rq_set_block_pc(req);
 			or->in.req = or->request->next_rq = req;
 		}
 	} else if (has_in)
diff --git a/drivers/scsi/osst.c b/drivers/scsi/osst.c
index 5033223..6816089 100644
--- a/drivers/scsi/osst.c
+++ b/drivers/scsi/osst.c
@@ -367,7 +367,7 @@ static int osst_execute(struct osst_request *SRpnt, const unsigned char *cmd,
 	if (IS_ERR(req))
 		return DRIVER_ERROR << 24;
 
-	blk_rq_set_block_pc(req);
+	req->cmd_type = REQ_TYPE_BLOCK_PC;
 	req->cmd_flags |= REQ_QUIET;
 
 	SRpnt->bio = NULL;
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index a8b610e..b6b6d92 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1978,7 +1978,7 @@ static void scsi_eh_lock_door(struct scsi_device *sdev)
 	if (IS_ERR(req))
 		return;
 
-	blk_rq_set_block_pc(req);
+	req->cmd_type = REQ_TYPE_BLOCK_PC;
 
 	req->cmd[0] = ALLOW_MEDIUM_REMOVAL;
 	req->cmd[1] = 0;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index c71344a..292f713 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -191,7 +191,7 @@ int scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 	req = blk_get_request(sdev->request_queue, write, __GFP_RECLAIM);
 	if (IS_ERR(req))
 		return ret;
-	blk_rq_set_block_pc(req);
+	req->cmd_type = REQ_TYPE_BLOCK_PC;
 
 	if (bufflen &&	blk_rq_map_kern(sdev->request_queue, req,
 					buffer, bufflen, __GFP_RECLAIM))
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index ae7d9bd..398c04e 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1708,7 +1708,7 @@ sg_start_req(Sg_request *srp, unsigned char *cmd)
 		return PTR_ERR(rq);
 	}
 
-	blk_rq_set_block_pc(rq);
+	rq->cmd_type = REQ_TYPE_BLOCK_PC;
 
 	if (hp->cmd_len > BLK_MAX_CDB)
 		rq->cmd = long_cmdp;
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 7af5226..8179ee3 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -545,7 +545,7 @@ static int st_scsi_execute(struct st_request *SRpnt, const unsigned char *cmd,
 	if (IS_ERR(req))
 		return DRIVER_ERROR << 24;
 
-	blk_rq_set_block_pc(req);
+	req->cmd_type = REQ_TYPE_BLOCK_PC;
 	req->cmd_flags |= REQ_QUIET;
 
 	mdata->null_mapped = 1;
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 81564c8..1f30179 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -1022,7 +1022,7 @@ pscsi_execute_cmd(struct se_cmd *cmd)
 			goto fail;
 		}
 
-		blk_rq_set_block_pc(req);
+		req->cmd_type = REQ_TYPE_BLOCK_PC;
 	} else {
 		BUG_ON(!cmd->data_length);
 
diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index e55b524..cdadcf8 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -224,7 +224,7 @@ static int nfsd4_scsi_identify_device(struct block_device *bdev,
 		error = -ENOMEM;
 		goto out_free_buf;
 	}
-	blk_rq_set_block_pc(rq);
+	rq->cmd_type = REQ_TYPE_BLOCK_PC;
 
 	error = blk_rq_map_kern(q, rq, buf, bufflen, GFP_KERNEL);
 	if (error)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9d1e0a4..472b527 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -789,7 +789,6 @@ extern void __blk_put_request(struct request_queue *, struct request *);
 extern struct request *blk_get_request(struct request_queue *, int, gfp_t);
 extern struct request *blk_make_request(struct request_queue *, struct bio *,
 					gfp_t);
-extern void blk_rq_set_block_pc(struct request *);
 extern void blk_requeue_request(struct request_queue *, struct request *);
 extern void blk_add_request_payload(struct request *rq, struct page *page,
 		int offset, unsigned int len);
-- 
2.1.4
