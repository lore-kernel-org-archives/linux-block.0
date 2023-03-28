Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCD6C76195
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 02:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjC1CbP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 22:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjC1CbO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 22:31:14 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DF8173A
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 19:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679970655; x=1711506655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DeFYHqiGfbEWbVrTwr3vyNnGk+eDNy6MZYGmrBV5dLc=;
  b=OBlCTWwGlPedPtnf6278qKz1LtREYOG3Ia0R6G3rC1DYJeceeaVr7W7M
   KwIcWlzF0m3CzCLJy/gmDAkSffArStCmxVyyH/t42YfDpKlbaJ0dw+Lm3
   Wo7GNGl+IAUZV7u85H771Chr1Nh0CcWZ0+P57AYVIZxvkSghZ3RcrbFVl
   dYVwb4oTr2shWHwkkHXyKd5p7j751z1iVcjoU+HRjokimwgIgQoCnxTk8
   sm621RMkaMaGcxhzlXctuMfxMeH7dnj3vjLDyVMcE0lKMSQFvksHcLB3p
   WSzFu56wMCc66scYItRD281kXhvaYQlZLVhViqAP4sbiupEyc0bNK4NEd
   A==;
X-IronPort-AV: E=Sophos;i="5.98,295,1673884800"; 
   d="scan'208";a="226460236"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2023 10:29:34 +0800
IronPort-SDR: iwvLc2TDqK3A/wOa98KixJQ7xbyT15maIHiyJsT8WIcR0QMwJrLiXEzw2w6pntHPjuT7FGXmpz
 6VxhmYwFymNOksfDZ1l1U2JecN9jnPK6If4FW9BiVBuQjxBkHoQP70RfywfT3/PykXFkFTbfF/
 Wlkt3oAe7o6zwCqWE9P7zFz7iogE5XsZ+T9n1yoUtQwtK9ScXUW1ewGW1Ald8/UDvdIdM9rn+q
 JO9yygTcugBVKGPwdaNPlMBzi6sTpgdGz4v6y9UCOzbQPX2iPsz/WZ0JetfEpGnF800Vj7I6av
 tc0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2023 18:45:45 -0700
IronPort-SDR: Ua50pK4YbVhSHlo64QamkbrTG4SRfj/50Pp1+/5FC6Z64oLHv+/gF5Ky5X4WrLOhbgWZESS1FJ
 AP7DDb1smuHwWOTES8jJxkgLJvsj+A+Czd0LJ3jxMWKQ1xSGrKgvIr6LXlUjccKrLZlQF9Hk77
 cm9MRdl3WI0ZOEzH2xE0CalFZDar+K0LfFyb+LzzC6GRg8loep0Cl43hEDY0EKCeXTHZZFfSGo
 hJ/uJo8VqBGifhQ7bHtxE8mPVnuaIZF5egJHXTYAdphNu3oZdoSFQVE+B+RkFhYyhdKzCiZ3kn
 TpM=
WDCIronportException: Internal
Received: from unknown (HELO oryx.wdc.com) ([10.225.167.80])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Mar 2023 19:29:32 -0700
From:   Dmitry Fomichev <dmitry.fomichev@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>
Cc:     virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: [PATCH 1/2] virtio-blk: migrate to the latest patchset version
Date:   Mon, 27 Mar 2023 22:29:27 -0400
Message-Id: <20230328022928.1003996-2-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328022928.1003996-1-dmitry.fomichev@wdc.com>
References: <20230328022928.1003996-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The merged patch series to support zoned block devices in virtio-blk
is not the most up to date version. The merged patch can be found at

https://lore.kernel.org/linux-block/20221016034127.330942-3-dmitry.fomichev@wdc.com/

, but the latest and reviewed version is

https://lore.kernel.org/linux-block/20221110053952.3378990-3-dmitry.fomichev@wdc.com/

The differences between the two are mostly cleanups, but there is one
change that is very important in terms of compatibility with the
approved virtio-zbd specification.

Before it was approved, the OASIS virtio spec had a change in
VIRTIO_BLK_T_ZONE_APPEND request layout that is not reflected in the
current virtio-blk driver code. In the running code, the status is
the first byte of the in-header that is followed by some pad bytes
and the u64 that carries the sector at which the data has been written
to the zone back to the driver, aka the append sector.

This layout turned out to be problematic for implementing in QEMU and
the request status byte has been eventually made the last byte of the
in-header. The current code doesn't expect that and this causes the
append sector value always come as zero to the block layer. This needs
to be fixed ASAP.

Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 drivers/block/virtio_blk.c      | 238 +++++++++++++++++++++-----------
 include/uapi/linux/virtio_blk.h |  18 +--
 2 files changed, 165 insertions(+), 91 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2723eede6f21..0b49fd2bd3bf 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -96,16 +96,14 @@ struct virtblk_req {
 
 		/*
 		 * The zone append command has an extended in header.
-		 * The status field in zone_append_in_hdr must have
-		 * the same offset in virtblk_req as the non-zoned
-		 * status field above.
+		 * The status field in zone_append_in_hdr must always
+		 * be the last byte.
 		 */
 		struct {
+			__virtio64 sector;
 			u8 status;
-			u8 reserved[7];
-			__le64 append_sector;
-		} zone_append_in_hdr;
-	};
+		} zone_append;
+	} in_hdr;
 
 	size_t in_hdr_len;
 
@@ -154,7 +152,7 @@ static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr)
 			sgs[num_out + num_in++] = vbr->sg_table.sgl;
 	}
 
-	sg_init_one(&in_hdr, &vbr->status, vbr->in_hdr_len);
+	sg_init_one(&in_hdr, &vbr->in_hdr.status, vbr->in_hdr_len);
 	sgs[num_out + num_in++] = &in_hdr;
 
 	return virtqueue_add_sgs(vq, sgs, num_out, num_in, vbr, GFP_ATOMIC);
@@ -242,11 +240,15 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 				      struct request *req,
 				      struct virtblk_req *vbr)
 {
-	size_t in_hdr_len = sizeof(vbr->status);
+	size_t in_hdr_len = sizeof(vbr->in_hdr.status);
 	bool unmap = false;
 	u32 type;
 	u64 sector = 0;
 
+	if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
+		op_is_zone_mgmt(req_op(req)))
+		return BLK_STS_NOTSUPP;
+
 	/* Set fields for all request types */
 	vbr->out_hdr.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
 
@@ -287,7 +289,7 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 	case REQ_OP_ZONE_APPEND:
 		type = VIRTIO_BLK_T_ZONE_APPEND;
 		sector = blk_rq_pos(req);
-		in_hdr_len = sizeof(vbr->zone_append_in_hdr);
+		in_hdr_len = sizeof(vbr->in_hdr.zone_append);
 		break;
 	case REQ_OP_ZONE_RESET:
 		type = VIRTIO_BLK_T_ZONE_RESET;
@@ -297,7 +299,10 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 		type = VIRTIO_BLK_T_ZONE_RESET_ALL;
 		break;
 	case REQ_OP_DRV_IN:
-		/* Out header already filled in, nothing to do */
+		/*
+		 * Out header has already been prepared by the caller (virtblk_get_id()
+		 * or virtblk_submit_zone_report()), nothing to do here.
+		 */
 		return 0;
 	default:
 		WARN_ON_ONCE(1);
@@ -318,16 +323,28 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 	return 0;
 }
 
+/*
+ * The status byte is always the last byte of the virtblk request
+ * in-header. This helper fetches its value for all in-header formats
+ * that are currently defined.
+ */
+static inline u8 virtblk_vbr_status(struct virtblk_req *vbr)
+{
+	return *((u8 *)&vbr->in_hdr + vbr->in_hdr_len - 1);
+}
+
 static inline void virtblk_request_done(struct request *req)
 {
 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
-	blk_status_t status = virtblk_result(vbr->status);
+	blk_status_t status = virtblk_result(virtblk_vbr_status(vbr));
+	struct virtio_blk *vblk = req->mq_hctx->queue->queuedata;
 
 	virtblk_unmap_data(req, vbr);
 	virtblk_cleanup_cmd(req);
 
 	if (req_op(req) == REQ_OP_ZONE_APPEND)
-		req->__sector = le64_to_cpu(vbr->zone_append_in_hdr.append_sector);
+		req->__sector = virtio64_to_cpu(vblk->vdev,
+						vbr->in_hdr.zone_append.sector);
 
 	blk_mq_end_request(req, status);
 }
@@ -355,7 +372,7 @@ static int virtblk_handle_req(struct virtio_blk_vq *vq,
 
 		if (likely(!blk_should_fake_timeout(req->q)) &&
 		    !blk_mq_complete_request_remote(req) &&
-		    !blk_mq_add_to_batch(req, iob, vbr->status,
+		    !blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr),
 					 virtblk_complete_batch))
 			virtblk_request_done(req);
 		req_done++;
@@ -550,7 +567,6 @@ static void virtio_queue_rqs(struct request **rqlist)
 #ifdef CONFIG_BLK_DEV_ZONED
 static void *virtblk_alloc_report_buffer(struct virtio_blk *vblk,
 					  unsigned int nr_zones,
-					  unsigned int zone_sectors,
 					  size_t *buflen)
 {
 	struct request_queue *q = vblk->disk->queue;
@@ -558,7 +574,7 @@ static void *virtblk_alloc_report_buffer(struct virtio_blk *vblk,
 	void *buf;
 
 	nr_zones = min_t(unsigned int, nr_zones,
-			 get_capacity(vblk->disk) >> ilog2(zone_sectors));
+			 get_capacity(vblk->disk) >> ilog2(vblk->zone_sectors));
 
 	bufsize = sizeof(struct virtio_blk_zone_report) +
 		nr_zones * sizeof(struct virtio_blk_zone_descriptor);
@@ -592,7 +608,7 @@ static int virtblk_submit_zone_report(struct virtio_blk *vblk,
 		return PTR_ERR(req);
 
 	vbr = blk_mq_rq_to_pdu(req);
-	vbr->in_hdr_len = sizeof(vbr->status);
+	vbr->in_hdr_len = sizeof(vbr->in_hdr.status);
 	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_ZONE_REPORT);
 	vbr->out_hdr.sector = cpu_to_virtio64(vblk->vdev, sector);
 
@@ -601,7 +617,7 @@ static int virtblk_submit_zone_report(struct virtio_blk *vblk,
 		goto out;
 
 	blk_execute_rq(req, false);
-	err = blk_status_to_errno(virtblk_result(vbr->status));
+	err = blk_status_to_errno(virtblk_result(vbr->in_hdr.status));
 out:
 	blk_mq_free_request(req);
 	return err;
@@ -609,29 +625,72 @@ static int virtblk_submit_zone_report(struct virtio_blk *vblk,
 
 static int virtblk_parse_zone(struct virtio_blk *vblk,
 			       struct virtio_blk_zone_descriptor *entry,
-			       unsigned int idx, unsigned int zone_sectors,
-			       report_zones_cb cb, void *data)
+			       unsigned int idx, report_zones_cb cb, void *data)
 {
 	struct blk_zone zone = { };
 
-	if (entry->z_type != VIRTIO_BLK_ZT_SWR &&
-	    entry->z_type != VIRTIO_BLK_ZT_SWP &&
-	    entry->z_type != VIRTIO_BLK_ZT_CONV) {
-		dev_err(&vblk->vdev->dev, "invalid zone type %#x\n",
-			entry->z_type);
-		return -EINVAL;
+	zone.start = virtio64_to_cpu(vblk->vdev, entry->z_start);
+	if (zone.start + vblk->zone_sectors <= get_capacity(vblk->disk))
+		zone.len = vblk->zone_sectors;
+	else
+		zone.len = get_capacity(vblk->disk) - zone.start;
+	zone.capacity = virtio64_to_cpu(vblk->vdev, entry->z_cap);
+	zone.wp = virtio64_to_cpu(vblk->vdev, entry->z_wp);
+
+	switch (entry->z_type) {
+	case VIRTIO_BLK_ZT_SWR:
+		zone.type = BLK_ZONE_TYPE_SEQWRITE_REQ;
+		break;
+	case VIRTIO_BLK_ZT_SWP:
+		zone.type = BLK_ZONE_TYPE_SEQWRITE_PREF;
+		break;
+	case VIRTIO_BLK_ZT_CONV:
+		zone.type = BLK_ZONE_TYPE_CONVENTIONAL;
+		break;
+	default:
+		dev_err(&vblk->vdev->dev, "zone %llu: invalid type %#x\n",
+			zone.start, entry->z_type);
+		return -EIO;
 	}
 
-	zone.type = entry->z_type;
-	zone.cond = entry->z_state;
-	zone.len = zone_sectors;
-	zone.capacity = le64_to_cpu(entry->z_cap);
-	zone.start = le64_to_cpu(entry->z_start);
-	if (zone.cond == BLK_ZONE_COND_FULL)
+	switch (entry->z_state) {
+	case VIRTIO_BLK_ZS_EMPTY:
+		zone.cond = BLK_ZONE_COND_EMPTY;
+		break;
+	case VIRTIO_BLK_ZS_CLOSED:
+		zone.cond = BLK_ZONE_COND_CLOSED;
+		break;
+	case VIRTIO_BLK_ZS_FULL:
+		zone.cond = BLK_ZONE_COND_FULL;
 		zone.wp = zone.start + zone.len;
-	else
-		zone.wp = le64_to_cpu(entry->z_wp);
+		break;
+	case VIRTIO_BLK_ZS_EOPEN:
+		zone.cond = BLK_ZONE_COND_EXP_OPEN;
+		break;
+	case VIRTIO_BLK_ZS_IOPEN:
+		zone.cond = BLK_ZONE_COND_IMP_OPEN;
+		break;
+	case VIRTIO_BLK_ZS_NOT_WP:
+		zone.cond = BLK_ZONE_COND_NOT_WP;
+		break;
+	case VIRTIO_BLK_ZS_RDONLY:
+		zone.cond = BLK_ZONE_COND_READONLY;
+		zone.wp = ULONG_MAX;
+		break;
+	case VIRTIO_BLK_ZS_OFFLINE:
+		zone.cond = BLK_ZONE_COND_OFFLINE;
+		zone.wp = ULONG_MAX;
+		break;
+	default:
+		dev_err(&vblk->vdev->dev, "zone %llu: invalid condition %#x\n",
+			zone.start, entry->z_state);
+		return -EIO;
+	}
 
+	/*
+	 * The callback below checks the validity of the reported
+	 * entry data, no need to further validate it here.
+	 */
 	return cb(&zone, idx, data);
 }
 
@@ -641,39 +700,47 @@ static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
 {
 	struct virtio_blk *vblk = disk->private_data;
 	struct virtio_blk_zone_report *report;
-	unsigned int zone_sectors = vblk->zone_sectors;
-	unsigned int nz, i;
-	int ret, zone_idx = 0;
+	unsigned long long nz, i;
 	size_t buflen;
+	unsigned int zone_idx = 0;
+	int ret;
 
 	if (WARN_ON_ONCE(!vblk->zone_sectors))
 		return -EOPNOTSUPP;
 
-	report = virtblk_alloc_report_buffer(vblk, nr_zones,
-					     zone_sectors, &buflen);
+	report = virtblk_alloc_report_buffer(vblk, nr_zones, &buflen);
 	if (!report)
 		return -ENOMEM;
 
+	mutex_lock(&vblk->vdev_mutex);
+
+	if (!vblk->vdev) {
+		ret = -ENXIO;
+		goto fail_report;
+	}
+
 	while (zone_idx < nr_zones && sector < get_capacity(vblk->disk)) {
 		memset(report, 0, buflen);
 
 		ret = virtblk_submit_zone_report(vblk, (char *)report,
 						 buflen, sector);
-		if (ret) {
-			if (ret > 0)
-				ret = -EIO;
-			goto out_free;
-		}
-		nz = min((unsigned int)le64_to_cpu(report->nr_zones), nr_zones);
+		if (ret)
+			goto fail_report;
+
+		nz = min_t(u64, virtio64_to_cpu(vblk->vdev, report->nr_zones),
+			   nr_zones);
 		if (!nz)
 			break;
 
 		for (i = 0; i < nz && zone_idx < nr_zones; i++) {
 			ret = virtblk_parse_zone(vblk, &report->zones[i],
-						 zone_idx, zone_sectors, cb, data);
+						 zone_idx, cb, data);
 			if (ret)
-				goto out_free;
-			sector = le64_to_cpu(report->zones[i].z_start) + zone_sectors;
+				goto fail_report;
+
+			sector = virtio64_to_cpu(vblk->vdev,
+						 report->zones[i].z_start) +
+				 vblk->zone_sectors;
 			zone_idx++;
 		}
 	}
@@ -682,7 +749,8 @@ static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
 		ret = zone_idx;
 	else
 		ret = -EINVAL;
-out_free:
+fail_report:
+	mutex_unlock(&vblk->vdev_mutex);
 	kvfree(report);
 	return ret;
 }
@@ -691,20 +759,28 @@ static void virtblk_revalidate_zones(struct virtio_blk *vblk)
 {
 	u8 model;
 
-	if (!vblk->zone_sectors)
-		return;
-
 	virtio_cread(vblk->vdev, struct virtio_blk_config,
 		     zoned.model, &model);
-	if (!blk_revalidate_disk_zones(vblk->disk, NULL))
-		set_capacity_and_notify(vblk->disk, 0);
+	switch (model) {
+	default:
+		dev_err(&vblk->vdev->dev, "unknown zone model %d\n", model);
+		fallthrough;
+	case VIRTIO_BLK_Z_NONE:
+	case VIRTIO_BLK_Z_HA:
+		disk_set_zoned(vblk->disk, BLK_ZONED_NONE);
+		return;
+	case VIRTIO_BLK_Z_HM:
+		WARN_ON_ONCE(!vblk->zone_sectors);
+		if (!blk_revalidate_disk_zones(vblk->disk, NULL))
+			set_capacity_and_notify(vblk->disk, 0);
+	}
 }
 
 static int virtblk_probe_zoned_device(struct virtio_device *vdev,
 				       struct virtio_blk *vblk,
 				       struct request_queue *q)
 {
-	u32 v;
+	u32 v, wg;
 	u8 model;
 	int ret;
 
@@ -713,16 +789,11 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
 
 	switch (model) {
 	case VIRTIO_BLK_Z_NONE:
+	case VIRTIO_BLK_Z_HA:
+		/* Present the host-aware device as non-zoned */
 		return 0;
 	case VIRTIO_BLK_Z_HM:
 		break;
-	case VIRTIO_BLK_Z_HA:
-		/*
-		 * Present the host-aware device as a regular drive.
-		 * TODO It is possible to add an option to make it appear
-		 * in the system as a zoned drive.
-		 */
-		return 0;
 	default:
 		dev_err(&vdev->dev, "unsupported zone model %d\n", model);
 		return -EINVAL;
@@ -735,32 +806,31 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
 
 	virtio_cread(vdev, struct virtio_blk_config,
 		     zoned.max_open_zones, &v);
-	disk_set_max_open_zones(vblk->disk, le32_to_cpu(v));
-
-	dev_dbg(&vdev->dev, "max open zones = %u\n", le32_to_cpu(v));
+	disk_set_max_open_zones(vblk->disk, v);
+	dev_dbg(&vdev->dev, "max open zones = %u\n", v);
 
 	virtio_cread(vdev, struct virtio_blk_config,
 		     zoned.max_active_zones, &v);
-	disk_set_max_active_zones(vblk->disk, le32_to_cpu(v));
-	dev_dbg(&vdev->dev, "max active zones = %u\n", le32_to_cpu(v));
+	disk_set_max_active_zones(vblk->disk, v);
+	dev_dbg(&vdev->dev, "max active zones = %u\n", v);
 
 	virtio_cread(vdev, struct virtio_blk_config,
-		     zoned.write_granularity, &v);
-	if (!v) {
+		     zoned.write_granularity, &wg);
+	if (!wg) {
 		dev_warn(&vdev->dev, "zero write granularity reported\n");
 		return -ENODEV;
 	}
-	blk_queue_physical_block_size(q, le32_to_cpu(v));
-	blk_queue_io_min(q, le32_to_cpu(v));
+	blk_queue_physical_block_size(q, wg);
+	blk_queue_io_min(q, wg);
 
-	dev_dbg(&vdev->dev, "write granularity = %u\n", le32_to_cpu(v));
+	dev_dbg(&vdev->dev, "write granularity = %u\n", wg);
 
 	/*
 	 * virtio ZBD specification doesn't require zones to be a power of
 	 * two sectors in size, but the code in this driver expects that.
 	 */
-	virtio_cread(vdev, struct virtio_blk_config, zoned.zone_sectors, &v);
-	vblk->zone_sectors = le32_to_cpu(v);
+	virtio_cread(vdev, struct virtio_blk_config, zoned.zone_sectors,
+		     &vblk->zone_sectors);
 	if (vblk->zone_sectors == 0 || !is_power_of_2(vblk->zone_sectors)) {
 		dev_err(&vdev->dev,
 			"zoned device with non power of two zone size %u\n",
@@ -783,8 +853,15 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
 			dev_warn(&vdev->dev, "zero max_append_sectors reported\n");
 			return -ENODEV;
 		}
-		blk_queue_max_zone_append_sectors(q, le32_to_cpu(v));
-		dev_dbg(&vdev->dev, "max append sectors = %u\n", le32_to_cpu(v));
+		if ((v << SECTOR_SHIFT) < wg) {
+			dev_err(&vdev->dev,
+				"write granularity %u exceeds max_append_sectors %u limit\n",
+				wg, v);
+			return -ENODEV;
+		}
+
+		blk_queue_max_zone_append_sectors(q, v);
+		dev_dbg(&vdev->dev, "max append sectors = %u\n", v);
 	}
 
 	return ret;
@@ -794,6 +871,7 @@ static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
 {
 	return virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED);
 }
+
 #else
 
 /*
@@ -809,7 +887,6 @@ static inline int virtblk_probe_zoned_device(struct virtio_device *vdev,
 {
 	return -EOPNOTSUPP;
 }
-
 static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
 {
 	return false;
@@ -831,7 +908,7 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
 		return PTR_ERR(req);
 
 	vbr = blk_mq_rq_to_pdu(req);
-	vbr->in_hdr_len = sizeof(vbr->status);
+	vbr->in_hdr_len = sizeof(vbr->in_hdr.status);
 	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_ID);
 	vbr->out_hdr.sector = 0;
 
@@ -840,7 +917,7 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
 		goto out;
 
 	blk_execute_rq(req, false);
-	err = blk_status_to_errno(virtblk_result(vbr->status));
+	err = blk_status_to_errno(virtblk_result(vbr->in_hdr.status));
 out:
 	blk_mq_free_request(req);
 	return err;
@@ -1504,9 +1581,6 @@ static int virtblk_probe(struct virtio_device *vdev)
 			goto out_cleanup_disk;
 	}
 
-	dev_info(&vdev->dev, "blk config size: %zu\n",
-		sizeof(struct virtio_blk_config));
-
 	err = device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
 	if (err)
 		goto out_cleanup_disk;
diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index 5af2a0300bb9..3744e4da1b2a 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -140,11 +140,11 @@ struct virtio_blk_config {
 
 	/* Zoned block device characteristics (if VIRTIO_BLK_F_ZONED) */
 	struct virtio_blk_zoned_characteristics {
-		__le32 zone_sectors;
-		__le32 max_open_zones;
-		__le32 max_active_zones;
-		__le32 max_append_sectors;
-		__le32 write_granularity;
+		__virtio32 zone_sectors;
+		__virtio32 max_open_zones;
+		__virtio32 max_active_zones;
+		__virtio32 max_append_sectors;
+		__virtio32 write_granularity;
 		__u8 model;
 		__u8 unused2[3];
 	} zoned;
@@ -241,11 +241,11 @@ struct virtio_blk_outhdr {
  */
 struct virtio_blk_zone_descriptor {
 	/* Zone capacity */
-	__le64 z_cap;
+	__virtio64 z_cap;
 	/* The starting sector of the zone */
-	__le64 z_start;
+	__virtio64 z_start;
 	/* Zone write pointer position in sectors */
-	__le64 z_wp;
+	__virtio64 z_wp;
 	/* Zone type */
 	__u8 z_type;
 	/* Zone state */
@@ -254,7 +254,7 @@ struct virtio_blk_zone_descriptor {
 };
 
 struct virtio_blk_zone_report {
-	__le64 nr_zones;
+	__virtio64 nr_zones;
 	__u8 reserved[56];
 	struct virtio_blk_zone_descriptor zones[];
 };
-- 
2.34.1

