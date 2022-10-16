Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F421BC43217
	for <linux-block@archiver.kernel.org>; Sun, 16 Oct 2022 03:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJPDle (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 Oct 2022 23:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJPDld (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Oct 2022 23:41:33 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7A83ECFB
        for <linux-block@vger.kernel.org>; Sat, 15 Oct 2022 20:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665891691; x=1697427691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8darMFC4B1xrk6h3kNrWw1oEEwDVT7tMTrcQ6JUbz7U=;
  b=QkRXcdD+ZT3IsUHzzOGBl/EPTYCKFW1Clmm+/yc5MfwlhOcQo/luxlBf
   VB8Fd+C8Xb/2YAB5V32uyss//1kwwQ5HlDe6wY+zlry7qGrWJ7mxgSKOY
   L2N+tkBfMiNFI8MmEjhKYvHAzweoS7gQLQtpnvG2fwnPz+4qG7pduerDe
   zliKhVuZsq5rhGaZCANiIXAGBJ7weLZ80ETl5/ZVu8DSxuoxyoIQW6vva
   5KcuGOOEvtNErR3lr7/GarVsmSXe/kV53AT3g3r+R1mvLj5DDdH3eKBIN
   bVjMRPlveqrRRio4kLDgz6KnPQcLbzYCbIOqR4ardyojFyRJtBX/iZoLS
   g==;
X-IronPort-AV: E=Sophos;i="5.95,188,1661788800"; 
   d="scan'208";a="318226166"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Oct 2022 11:41:30 +0800
IronPort-SDR: kDMXwHJJdF68U70JP7lHfaOIO1t+Wx+SpL1uyAOyBmPO7+0TUEtxiOm6FU8h6b3zIX9TP9RYKR
 5XoiuvCDB8cM/6h1b7FoZfk9MeBbYyCy4Db5T/EpBdBIM9LPCQpZ7YXmatBs8WopaJu1fy8Lnt
 McUepmmK/Rip6I8md0F7jx2LnKzi6y4/EifH99yaHcGyKWNhFZW4eQZhIKnfDhTT/+KvooHX0C
 y029WA4KsablEr3A00tqygF4YiFY4xQFakXNEKuu5qL9bcO5H88QiTo2atNhKCYRyHiXfsC3Jq
 GeK+F9ciZvZiHgHVdk3Gdosi
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2022 20:01:05 -0700
IronPort-SDR: OjkhgeZDH+VRgztcKgAHQhTWTUU9UfqnnUwsvCUbBz4nPBwnT1QTags67TQmUgBX0R8jMRAvsY
 CEUPtPXlGGJGji1QGG2n+QW8xxxL6+3V99+kRdzXXeNHslA+lISxlXNOWOJl/meuuIP6+3fcaQ
 8PdNIvkLz59H5LFIT5n0UsxbC+Fej9Sfw4s9Gwp2x6wna8N8o+t6XYR3+rHfacRf9s/Abv+bRv
 WOHebJp9x0OpQnE7T+2S6aMNGYX1+sfxjCjFvkttRb3v/38/5x6i5uVkQ0644fPrjFUfFw5kbx
 Wzc=
WDCIronportException: Internal
Received: from unknown (HELO oryx.wdc.com) ([10.225.167.24])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Oct 2022 20:41:30 -0700
From:   Dmitry Fomichev <dmitry.fomichev@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>
Cc:     virtio-dev@lists.oasis-open.org,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: [PATCH v2 2/2] virtio-blk: add support for zoned block devices
Date:   Sat, 15 Oct 2022 23:41:27 -0400
Message-Id: <20221016034127.330942-3-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016034127.330942-1-dmitry.fomichev@wdc.com>
References: <20221016034127.330942-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds support for Zoned Block Devices (ZBDs) to the kernel
virtio-blk driver.

The patch accompanies the virtio-blk ZBD support draft that is now
being proposed for standardization. The latest version of the draft is
linked at

https://github.com/oasis-tcs/virtio-spec/issues/143 .

The QEMU zoned device code that implements these protocol extensions
has been developed by Sam Li and it is currently in review at the QEMU
mailing list.

A number of virtblk request structure changes has been introduced to
accommodate the functionality that is specific to zoned block devices
and, most importantly, make room for carrying the Zoned Append sector
value from the device back to the driver along with the request status.

The zone-specific code in the patch is heavily influenced by NVMe ZNS
code in drivers/nvme/host/zns.c, but it is simpler because the proposed
virtio ZBD draft only covers the zoned device features that are
relevant to the zoned functionality provided by Linux block layer.

Co-developed-by: Stefan Hajnoczi <stefanha@gmail.com>
Signed-off-by: Stefan Hajnoczi <stefanha@gmail.com>
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 drivers/block/virtio_blk.c      | 377 ++++++++++++++++++++++++++++++--
 include/uapi/linux/virtio_blk.h | 105 +++++++++
 2 files changed, 464 insertions(+), 18 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 3efe3da5f8c2..c9ad590816f8 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -80,22 +80,51 @@ struct virtio_blk {
 	int num_vqs;
 	int io_queues[HCTX_MAX_TYPES];
 	struct virtio_blk_vq *vqs;
+
+	/* For zoned device */
+	unsigned int zone_sectors;
 };
 
 struct virtblk_req {
+	/* Out header */
 	struct virtio_blk_outhdr out_hdr;
-	u8 status;
+
+	/* In header */
+	union {
+		u8 status;
+
+		/*
+		 * The zone append command has an extended in header.
+		 * The status field in zone_append_in_hdr must have
+		 * the same offset in virtblk_req as the non-zoned
+		 * status field above.
+		 */
+		struct {
+			u8 status;
+			u8 reserved[7];
+			u64 append_sector;
+		} zone_append_in_hdr;
+	};
+
+	size_t in_hdr_len;
+
 	struct sg_table sg_table;
 	struct scatterlist sg[];
 };
 
-static inline blk_status_t virtblk_result(struct virtblk_req *vbr)
+static inline blk_status_t virtblk_result(u8 status)
 {
-	switch (vbr->status) {
+	switch (status) {
 	case VIRTIO_BLK_S_OK:
 		return BLK_STS_OK;
 	case VIRTIO_BLK_S_UNSUPP:
 		return BLK_STS_NOTSUPP;
+	case VIRTIO_BLK_S_ZONE_OPEN_RESOURCE:
+		return BLK_STS_ZONE_OPEN_RESOURCE;
+	case VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE:
+		return BLK_STS_ZONE_ACTIVE_RESOURCE;
+	case VIRTIO_BLK_S_IOERR:
+	case VIRTIO_BLK_S_ZONE_UNALIGNED_WP:
 	default:
 		return BLK_STS_IOERR;
 	}
@@ -111,11 +140,11 @@ static inline struct virtio_blk_vq *get_virtio_blk_vq(struct blk_mq_hw_ctx *hctx
 
 static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr)
 {
-	struct scatterlist hdr, status, *sgs[3];
+	struct scatterlist out_hdr, in_hdr, *sgs[3];
 	unsigned int num_out = 0, num_in = 0;
 
-	sg_init_one(&hdr, &vbr->out_hdr, sizeof(vbr->out_hdr));
-	sgs[num_out++] = &hdr;
+	sg_init_one(&out_hdr, &vbr->out_hdr, sizeof(vbr->out_hdr));
+	sgs[num_out++] = &out_hdr;
 
 	if (vbr->sg_table.nents) {
 		if (vbr->out_hdr.type & cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_OUT))
@@ -124,8 +153,8 @@ static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr)
 			sgs[num_out + num_in++] = vbr->sg_table.sgl;
 	}
 
-	sg_init_one(&status, &vbr->status, sizeof(vbr->status));
-	sgs[num_out + num_in++] = &status;
+	sg_init_one(&in_hdr, &vbr->status, vbr->in_hdr_len);
+	sgs[num_out + num_in++] = &in_hdr;
 
 	return virtqueue_add_sgs(vq, sgs, num_out, num_in, vbr, GFP_ATOMIC);
 }
@@ -214,21 +243,22 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 				      struct request *req,
 				      struct virtblk_req *vbr)
 {
+	size_t in_hdr_len = sizeof(vbr->status);
 	bool unmap = false;
 	u32 type;
+	u64 sector = 0;
 
-	vbr->out_hdr.sector = 0;
+	/* Set fields for all request types */
+	vbr->out_hdr.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
 
 	switch (req_op(req)) {
 	case REQ_OP_READ:
 		type = VIRTIO_BLK_T_IN;
-		vbr->out_hdr.sector = cpu_to_virtio64(vdev,
-						      blk_rq_pos(req));
+		sector = blk_rq_pos(req);
 		break;
 	case REQ_OP_WRITE:
 		type = VIRTIO_BLK_T_OUT;
-		vbr->out_hdr.sector = cpu_to_virtio64(vdev,
-						      blk_rq_pos(req));
+		sector = blk_rq_pos(req);
 		break;
 	case REQ_OP_FLUSH:
 		type = VIRTIO_BLK_T_FLUSH;
@@ -243,16 +273,42 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 	case REQ_OP_SECURE_ERASE:
 		type = VIRTIO_BLK_T_SECURE_ERASE;
 		break;
-	case REQ_OP_DRV_IN:
-		type = VIRTIO_BLK_T_GET_ID;
+	case REQ_OP_ZONE_OPEN:
+		type = VIRTIO_BLK_T_ZONE_OPEN;
+		sector = blk_rq_pos(req);
 		break;
+	case REQ_OP_ZONE_CLOSE:
+		type = VIRTIO_BLK_T_ZONE_CLOSE;
+		sector = blk_rq_pos(req);
+		break;
+	case REQ_OP_ZONE_FINISH:
+		type = VIRTIO_BLK_T_ZONE_FINISH;
+		sector = blk_rq_pos(req);
+		break;
+	case REQ_OP_ZONE_APPEND:
+		type = VIRTIO_BLK_T_ZONE_APPEND;
+		sector = blk_rq_pos(req);
+		in_hdr_len = sizeof(vbr->zone_append_in_hdr);
+		break;
+	case REQ_OP_ZONE_RESET:
+		type = VIRTIO_BLK_T_ZONE_RESET;
+		sector = blk_rq_pos(req);
+		break;
+	case REQ_OP_ZONE_RESET_ALL:
+		type = VIRTIO_BLK_T_ZONE_RESET_ALL;
+		break;
+	case REQ_OP_DRV_IN:
+		/* Out header already filled in, nothing to do */
+		return 0;
 	default:
 		WARN_ON_ONCE(1);
 		return BLK_STS_IOERR;
 	}
 
+	/* Set fields for non-REQ_OP_DRV_IN request types */
+	vbr->in_hdr_len = in_hdr_len;
 	vbr->out_hdr.type = cpu_to_virtio32(vdev, type);
-	vbr->out_hdr.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
+	vbr->out_hdr.sector = cpu_to_virtio64(vdev, sector);
 
 	if (type == VIRTIO_BLK_T_DISCARD || type == VIRTIO_BLK_T_WRITE_ZEROES ||
 	    type == VIRTIO_BLK_T_SECURE_ERASE) {
@@ -266,10 +322,15 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 static inline void virtblk_request_done(struct request *req)
 {
 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
+	int status = virtblk_result(vbr->status);
 
 	virtblk_unmap_data(req, vbr);
 	virtblk_cleanup_cmd(req);
-	blk_mq_end_request(req, virtblk_result(vbr));
+
+	if (req_op(req) == REQ_OP_ZONE_APPEND)
+		req->__sector = le64_to_cpu(vbr->zone_append_in_hdr.append_sector);
+
+	blk_mq_end_request(req, status);
 }
 
 static void virtblk_done(struct virtqueue *vq)
@@ -455,6 +516,266 @@ static void virtio_queue_rqs(struct request **rqlist)
 	*rqlist = requeue_list;
 }
 
+#ifdef CONFIG_BLK_DEV_ZONED
+static void *virtblk_alloc_report_buffer(struct virtio_blk *vblk,
+					  unsigned int nr_zones,
+					  unsigned int zone_sectors,
+					  size_t *buflen)
+{
+	struct request_queue *q = vblk->disk->queue;
+	size_t bufsize;
+	void *buf;
+
+	nr_zones = min_t(unsigned int, nr_zones,
+			 get_capacity(vblk->disk) >> ilog2(zone_sectors));
+
+	bufsize = sizeof(struct virtio_blk_zone_report) +
+		nr_zones * sizeof(struct virtio_blk_zone_descriptor);
+	bufsize = min_t(size_t, bufsize,
+			queue_max_hw_sectors(q) << SECTOR_SHIFT);
+	bufsize = min_t(size_t, bufsize, queue_max_segments(q) << PAGE_SHIFT);
+
+	while (bufsize >= sizeof(struct virtio_blk_zone_report)) {
+		buf = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
+		if (buf) {
+			*buflen = bufsize;
+			return buf;
+		}
+		bufsize >>= 1;
+	}
+
+	return NULL;
+}
+
+static int virtblk_submit_zone_report(struct virtio_blk *vblk,
+				       char *report_buf, size_t report_len,
+				       sector_t sector)
+{
+	struct request_queue *q = vblk->disk->queue;
+	struct request *req;
+	struct virtblk_req *vbr;
+	int err;
+
+	req = blk_mq_alloc_request(q, REQ_OP_DRV_IN, 0);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	vbr = blk_mq_rq_to_pdu(req);
+	vbr->in_hdr_len = sizeof(vbr->status);
+	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_ZONE_REPORT);
+	vbr->out_hdr.sector = cpu_to_virtio64(vblk->vdev, sector);
+
+	err = blk_rq_map_kern(q, req, report_buf, report_len, GFP_KERNEL);
+	if (err)
+		goto out;
+
+	blk_execute_rq(req, false);
+	err = blk_status_to_errno(virtblk_result(vbr->status));
+out:
+	blk_mq_free_request(req);
+	return err;
+}
+
+static int virtblk_parse_zone(struct virtio_blk *vblk,
+			       struct virtio_blk_zone_descriptor *entry,
+			       unsigned int idx, unsigned int zone_sectors,
+			       report_zones_cb cb, void *data)
+{
+	struct blk_zone zone = { };
+
+	if (entry->z_type != VIRTIO_BLK_ZT_SWR &&
+	    entry->z_type != VIRTIO_BLK_ZT_SWP &&
+	    entry->z_type != VIRTIO_BLK_ZT_CONV) {
+		dev_err(&vblk->vdev->dev, "invalid zone type %#x\n",
+			entry->z_type);
+		return -EINVAL;
+	}
+
+	zone.type = entry->z_type;
+	zone.cond = entry->z_state;
+	zone.len = zone_sectors;
+	zone.capacity = le64_to_cpu(entry->z_cap);
+	zone.start = le64_to_cpu(entry->z_start);
+	if (zone.cond == BLK_ZONE_COND_FULL)
+		zone.wp = zone.start + zone.len;
+	else
+		zone.wp = le64_to_cpu(entry->z_wp);
+
+	return cb(&zone, idx, data);
+}
+
+static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
+				 unsigned int nr_zones, report_zones_cb cb,
+				 void *data)
+{
+	struct virtio_blk *vblk = disk->private_data;
+	struct virtio_blk_zone_report *report;
+	unsigned int zone_sectors = vblk->zone_sectors;
+	unsigned int nz, i;
+	int ret, zone_idx = 0;
+	size_t buflen;
+
+	if (WARN_ON_ONCE(!vblk->zone_sectors))
+		return -EOPNOTSUPP;
+
+	report = virtblk_alloc_report_buffer(vblk, nr_zones,
+					     zone_sectors, &buflen);
+	if (!report)
+		return -ENOMEM;
+
+	while (zone_idx < nr_zones && sector < get_capacity(vblk->disk)) {
+		memset(report, 0, buflen);
+
+		ret = virtblk_submit_zone_report(vblk, (char *)report,
+						 buflen, sector);
+		if (ret) {
+			if (ret > 0)
+				ret = -EIO;
+			goto out_free;
+		}
+		nz = min((unsigned int)le64_to_cpu(report->nr_zones), nr_zones);
+		if (!nz)
+			break;
+
+		for (i = 0; i < nz && zone_idx < nr_zones; i++) {
+			ret = virtblk_parse_zone(vblk, &report->zones[i],
+						 zone_idx, zone_sectors, cb, data);
+			if (ret)
+				goto out_free;
+			sector = le64_to_cpu(report->zones[i].z_start) + zone_sectors;
+			zone_idx++;
+		}
+	}
+
+	if (zone_idx > 0)
+		ret = zone_idx;
+	else
+		ret = -EINVAL;
+out_free:
+	kvfree(report);
+	return ret;
+}
+
+static void virtblk_revalidate_zones(struct virtio_blk *vblk)
+{
+	u8 model;
+
+	if (!vblk->zone_sectors)
+		return;
+
+	virtio_cread(vblk->vdev, struct virtio_blk_config,
+		     zoned.model, &model);
+	if (!blk_revalidate_disk_zones(vblk->disk, NULL))
+		set_capacity_and_notify(vblk->disk, 0);
+}
+
+static int virtblk_probe_zoned_device(struct virtio_device *vdev,
+				       struct virtio_blk *vblk,
+				       struct request_queue *q)
+{
+	u32 v;
+	u8 model;
+	int ret;
+
+	virtio_cread(vdev, struct virtio_blk_config,
+		     zoned.model, &model);
+
+	switch (model) {
+	case VIRTIO_BLK_Z_NONE:
+		return 0;
+	case VIRTIO_BLK_Z_HM:
+		break;
+	case VIRTIO_BLK_Z_HA:
+		/*
+		 * Present the host-aware device as a regular drive.
+		 * TODO It is possible to add an option to make it appear
+		 * in the system as a zoned drive.
+		 */
+		return 0;
+	default:
+		dev_err(&vdev->dev, "unsupported zone model %d\n", model);
+		return -EINVAL;
+	}
+
+	dev_dbg(&vdev->dev, "probing host-managed zoned device\n");
+
+	disk_set_zoned(vblk->disk, BLK_ZONED_HM);
+	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
+
+	virtio_cread(vdev, struct virtio_blk_config,
+		     zoned.max_open_zones, &v);
+	disk_set_max_open_zones(vblk->disk, le32_to_cpu(v));
+
+	dev_dbg(&vdev->dev, "max open zones = %u\n", le32_to_cpu(v));
+
+	virtio_cread(vdev, struct virtio_blk_config,
+		     zoned.max_active_zones, &v);
+	disk_set_max_active_zones(vblk->disk, le32_to_cpu(v));
+	dev_dbg(&vdev->dev, "max active zones = %u\n", le32_to_cpu(v));
+
+	virtio_cread(vdev, struct virtio_blk_config,
+		     zoned.write_granularity, &v);
+	if (!v) {
+		dev_warn(&vdev->dev, "zero write granularity reported\n");
+		return -ENODEV;
+	}
+	blk_queue_physical_block_size(q, le32_to_cpu(v));
+	blk_queue_io_min(q, le32_to_cpu(v));
+
+	dev_dbg(&vdev->dev, "write granularity = %u\n", le32_to_cpu(v));
+
+	/*
+	 * virtio ZBD specification doesn't require zones to be a power of
+	 * two sectors in size, but the code in this driver expects that.
+	 */
+	virtio_cread(vdev, struct virtio_blk_config, zoned.zone_sectors, &v);
+	vblk->zone_sectors = le32_to_cpu(v);
+	if (vblk->zone_sectors == 0 || !is_power_of_2(vblk->zone_sectors)) {
+		dev_err(&vdev->dev,
+			"zoned device with non power of two zone size %u\n",
+			vblk->zone_sectors);
+		return -ENODEV;
+	}
+	dev_dbg(&vdev->dev, "zone sectors = %u\n", vblk->zone_sectors);
+
+	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
+		dev_warn(&vblk->vdev->dev,
+			 "ignoring negotiated F_DISCARD for zoned device\n");
+		blk_queue_max_discard_sectors(q, 0);
+	}
+
+	ret = blk_revalidate_disk_zones(vblk->disk, NULL);
+	if (!ret) {
+		virtio_cread(vdev, struct virtio_blk_config,
+			     zoned.max_append_sectors, &v);
+		if (!v) {
+			dev_warn(&vdev->dev, "zero max_append_sectors reported\n");
+			return -ENODEV;
+		}
+		blk_queue_max_zone_append_sectors(q, le32_to_cpu(v));
+		dev_dbg(&vdev->dev, "max append sectors = %u\n", le32_to_cpu(v));
+	}
+
+	return ret;
+}
+
+#else
+
+/*
+ * Zoned block device support is not configured in this kernel.
+ * We only need to define a few symbols to avoid compilation errors.
+ */
+#define virtblk_report_zones       NULL
+static inline void virtblk_revalidate_zones(struct virtio_blk *vblk)
+{
+}
+static inline int virtblk_probe_zoned_device(struct virtio_device *vdev,
+			struct virtio_blk *vblk, struct request_queue *q)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_BLK_DEV_ZONED */
+
 /* return id (s/n) string for *disk to *id_str
  */
 static int virtblk_get_id(struct gendisk *disk, char *id_str)
@@ -462,18 +783,24 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
 	struct virtio_blk *vblk = disk->private_data;
 	struct request_queue *q = vblk->disk->queue;
 	struct request *req;
+	struct virtblk_req *vbr;
 	int err;
 
 	req = blk_mq_alloc_request(q, REQ_OP_DRV_IN, 0);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
+	vbr = blk_mq_rq_to_pdu(req);
+	vbr->in_hdr_len = sizeof(vbr->status);
+	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_ID);
+	vbr->out_hdr.sector = 0;
+
 	err = blk_rq_map_kern(q, req, id_str, VIRTIO_BLK_ID_BYTES, GFP_KERNEL);
 	if (err)
 		goto out;
 
 	blk_execute_rq(req, false);
-	err = blk_status_to_errno(virtblk_result(blk_mq_rq_to_pdu(req)));
+	err = blk_status_to_errno(virtblk_result(vbr->status));
 out:
 	blk_mq_free_request(req);
 	return err;
@@ -524,6 +851,7 @@ static const struct block_device_operations virtblk_fops = {
 	.owner  	= THIS_MODULE,
 	.getgeo		= virtblk_getgeo,
 	.free_disk	= virtblk_free_disk,
+	.report_zones	= virtblk_report_zones,
 };
 
 static int index_to_minor(int index)
@@ -594,6 +922,7 @@ static void virtblk_config_changed_work(struct work_struct *work)
 	struct virtio_blk *vblk =
 		container_of(work, struct virtio_blk, config_work);
 
+	virtblk_revalidate_zones(vblk);
 	virtblk_update_capacity(vblk, true);
 }
 
@@ -1150,6 +1479,15 @@ static int virtblk_probe(struct virtio_device *vdev)
 	virtblk_update_capacity(vblk, false);
 	virtio_device_ready(vdev);
 
+	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
+		err = virtblk_probe_zoned_device(vdev, vblk, q);
+		if (err)
+			goto out_cleanup_disk;
+	}
+
+	dev_info(&vdev->dev, "blk config size: %zu\n",
+		sizeof(struct virtio_blk_config));
+
 	err = device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
 	if (err)
 		goto out_cleanup_disk;
@@ -1251,6 +1589,9 @@ static unsigned int features[] = {
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
 	VIRTIO_BLK_F_SECURE_ERASE,
+#ifdef CONFIG_BLK_DEV_ZONED
+	VIRTIO_BLK_F_ZONED,
+#endif /* CONFIG_BLK_DEV_ZONED */
 };
 
 static struct virtio_driver virtio_blk = {
diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index 58e70b24b504..3744e4da1b2a 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -41,6 +41,7 @@
 #define VIRTIO_BLK_F_DISCARD	13	/* DISCARD is supported */
 #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
 #define VIRTIO_BLK_F_SECURE_ERASE	16 /* Secure Erase is supported */
+#define VIRTIO_BLK_F_ZONED		17	/* Zoned block device */
 
 /* Legacy feature bits */
 #ifndef VIRTIO_BLK_NO_LEGACY
@@ -137,6 +138,16 @@ struct virtio_blk_config {
 	/* Secure erase commands must be aligned to this number of sectors. */
 	__virtio32 secure_erase_sector_alignment;
 
+	/* Zoned block device characteristics (if VIRTIO_BLK_F_ZONED) */
+	struct virtio_blk_zoned_characteristics {
+		__virtio32 zone_sectors;
+		__virtio32 max_open_zones;
+		__virtio32 max_active_zones;
+		__virtio32 max_append_sectors;
+		__virtio32 write_granularity;
+		__u8 model;
+		__u8 unused2[3];
+	} zoned;
 } __attribute__((packed));
 
 /*
@@ -174,6 +185,27 @@ struct virtio_blk_config {
 /* Secure erase command */
 #define VIRTIO_BLK_T_SECURE_ERASE	14
 
+/* Zone append command */
+#define VIRTIO_BLK_T_ZONE_APPEND    15
+
+/* Report zones command */
+#define VIRTIO_BLK_T_ZONE_REPORT    16
+
+/* Open zone command */
+#define VIRTIO_BLK_T_ZONE_OPEN      18
+
+/* Close zone command */
+#define VIRTIO_BLK_T_ZONE_CLOSE     20
+
+/* Finish zone command */
+#define VIRTIO_BLK_T_ZONE_FINISH    22
+
+/* Reset zone command */
+#define VIRTIO_BLK_T_ZONE_RESET     24
+
+/* Reset All zones command */
+#define VIRTIO_BLK_T_ZONE_RESET_ALL 26
+
 #ifndef VIRTIO_BLK_NO_LEGACY
 /* Barrier before this op. */
 #define VIRTIO_BLK_T_BARRIER	0x80000000
@@ -193,6 +225,72 @@ struct virtio_blk_outhdr {
 	__virtio64 sector;
 };
 
+/*
+ * Supported zoned device models.
+ */
+
+/* Regular block device */
+#define VIRTIO_BLK_Z_NONE      0
+/* Host-managed zoned device */
+#define VIRTIO_BLK_Z_HM        1
+/* Host-aware zoned device */
+#define VIRTIO_BLK_Z_HA        2
+
+/*
+ * Zone descriptor. A part of VIRTIO_BLK_T_ZONE_REPORT command reply.
+ */
+struct virtio_blk_zone_descriptor {
+	/* Zone capacity */
+	__virtio64 z_cap;
+	/* The starting sector of the zone */
+	__virtio64 z_start;
+	/* Zone write pointer position in sectors */
+	__virtio64 z_wp;
+	/* Zone type */
+	__u8 z_type;
+	/* Zone state */
+	__u8 z_state;
+	__u8 reserved[38];
+};
+
+struct virtio_blk_zone_report {
+	__virtio64 nr_zones;
+	__u8 reserved[56];
+	struct virtio_blk_zone_descriptor zones[];
+};
+
+/*
+ * Supported zone types.
+ */
+
+/* Conventional zone */
+#define VIRTIO_BLK_ZT_CONV         1
+/* Sequential Write Required zone */
+#define VIRTIO_BLK_ZT_SWR          2
+/* Sequential Write Preferred zone */
+#define VIRTIO_BLK_ZT_SWP          3
+
+/*
+ * Zone states that are available for zones of all types.
+ */
+
+/* Not a write pointer (conventional zones only) */
+#define VIRTIO_BLK_ZS_NOT_WP       0
+/* Empty */
+#define VIRTIO_BLK_ZS_EMPTY        1
+/* Implicitly Open */
+#define VIRTIO_BLK_ZS_IOPEN        2
+/* Explicitly Open */
+#define VIRTIO_BLK_ZS_EOPEN        3
+/* Closed */
+#define VIRTIO_BLK_ZS_CLOSED       4
+/* Read-Only */
+#define VIRTIO_BLK_ZS_RDONLY       13
+/* Full */
+#define VIRTIO_BLK_ZS_FULL         14
+/* Offline */
+#define VIRTIO_BLK_ZS_OFFLINE      15
+
 /* Unmap this range (only valid for write zeroes command) */
 #define VIRTIO_BLK_WRITE_ZEROES_FLAG_UNMAP	0x00000001
 
@@ -219,4 +317,11 @@ struct virtio_scsi_inhdr {
 #define VIRTIO_BLK_S_OK		0
 #define VIRTIO_BLK_S_IOERR	1
 #define VIRTIO_BLK_S_UNSUPP	2
+
+/* Error codes that are specific to zoned block devices */
+#define VIRTIO_BLK_S_ZONE_INVALID_CMD     3
+#define VIRTIO_BLK_S_ZONE_UNALIGNED_WP    4
+#define VIRTIO_BLK_S_ZONE_OPEN_RESOURCE   5
+#define VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE 6
+
 #endif /* _LINUX_VIRTIO_BLK_H */
-- 
2.34.1

