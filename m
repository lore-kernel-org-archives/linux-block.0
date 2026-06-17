Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B446E480946
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781709459; cv=none; b=uNJxw2Wdb5q5M2nXLhTpz9XSWb0X66s43bD5KOzwH8YcAaR+OHXubXYnGmnxT9zMMUoBdOeninjZkd/sDP9vxL0IZD8fqnx+gf+8UorBYEo1264fDonh+04bi7qJJjRhniuwhTp6UbVIyb218ltWxXRPiyt3tQl0BDnRNLqXfeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781709459; c=relaxed/simple;
	bh=ZiZeqj5W4TjeYd1jGBGSd3ef16TSkam+PtO0+bHiYNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uPGkYaEgZHLeDXJzaX5Pxqq6dhH0bdGXsREzmsIUKl7dWczc2orYc2PesG8iBlY4ulwBiHg8xYcJTAOOFzEWSqTaEzSJI/sF1cSS8+Rmmk8PsclCQMRKtqzVXHhBAckr4isu91ilZaJNGmo59qzO1g66ci+XMeFKels/Jrfko00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f51Ni+gm; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f51Ni+gm"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-91587626a3eso616563285a.2
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 08:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781709454; x=1782314254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DwJ11BUFvQpn5D9oDUa4PWQ9xRUr33OFEcUVw3lutuo=;
        b=f51Ni+gmru80FXgUwLYEvqOrf2SM0f24eYwAMgUsBQ9lgNaMJti2Rkr6yg/KWyZCym
         p2fO7feqFpLktoc7fxb6ZlxrvKmjRrVUHUTZfke4OZ370Lzmz2AwnPlbax23BSmE1zZq
         Lq6GNEcO1QtWhlXo72in+nLHBhMFtbj+P73/K2h4LGgSzCymiR9LsXFVohVOhcuVoU/8
         BFF35R/EKrQrufRH4k+SGur5PalMUCKJ0tCVDpGZqfWLjR9QD1Mzxtq8Og+a5Fcoc0X4
         y5mvMaQ0ggnxY9QRsGcYsTkgRKk1kstwpAjQ/ZLCDLUJSd6AzNVDL2Z0nJN0FfnsI+Qf
         YpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781709454; x=1782314254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwJ11BUFvQpn5D9oDUa4PWQ9xRUr33OFEcUVw3lutuo=;
        b=eEccc7DzVV7JdPBn8/vRMa1eCnlP1kqsM76t99EIpP9Y97iNBQvHRrnEt/ILieWhd+
         ifsFsWloQltWhmNnpeweQSY5fTnrim+gbgVIuhydYiQ/7VhqjI86hnoDhfvvLXAaJb7u
         iF5ohl5/c9RqRyRy6EmFS7XOR87i7A9Q6NYdaISx6Ehi65hnEz5l/pXFrdggJYDsX/Pm
         rMAQccr2h7fxQemTZjdbp6v3TJtCDL31lTXrP9qUhs/BEeqAOCk3oBs4kNtMy81SDuLa
         imPAVYiEM6f0Xf9bwR5yhRFNdvSKMXn+6PaI7+xMixifvku2bumoDP4Oiz/yJHaDcnHf
         kcuQ==
X-Forwarded-Encrypted: i=1; AFNElJ87l1396H7WBsrIEtbYpkjrb4Vj90OEeX06dMKd/3d3NykUlLnM/AZT7N9PI/X+Le0vvZdY4S/l8ohPFg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/WTxg0AWSIFXZ1e0ivCSs5CquISl0KuljrhW6m+NAmpYEQ0wl
	J77NrVgPI4uGnYg5SE6pr2pB/goolq09BWfodoQPOQcuIlVx/sSWZHhX
X-Gm-Gg: Acq92OH7zNK/Nb+KREBOK/r0IsVWPcJX3hatLey+XWwJOpHbBIvDZ/PnGkr3cjQPT0B
	PHt2KebFz9o67dNuHh99slvKqIEp/4kkW5YhUwbo5Wun+LgKkrFxJrZkvkTM9e28eMdbNv5xq1t
	O+3lWw7844vp3dymP/+2Z5yUvxEfqK4wzJQGsiFTZYbfDs5ju6UZr59W2Vw7TF/PfYdj4M+T5XJ
	9Xy5LcD5x2qHlOztsbPjTEliYoOpxLWbM9gTLMxSdIy+1vEHWyKZWUnT9jL7tm6YnbWgrwr3BCE
	WTeYzc78lLeX9oaPVvHl+VLm+upFbpWdcj85N/3a0UptGwSw7z98t3SzEJ+0G2s2EoX18GJto0P
	1uqtGco50Ffc01E+G/ht7E48BkSmHlI12qFh5Hg8HjrE5tFT2+2othl3LU2Mkltk5Diev5BAIJJ
	Iut0zUZWdf4j1ERaq0Rd9MdHPCyCobyR302VUPnv3sNJcddSvw0aGpjxUc73FN8KkoSsMOxJEm8
	+dHNhWxaYDOB8NtRGyJsc7tI6+b38Xo
X-Received: by 2002:a05:620a:444f:b0:915:b9f6:71ab with SMTP id af79cd13be357-91dbcf10e12mr600897885a.44.1781709454250;
        Wed, 17 Jun 2026 08:17:34 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a061028sm1787280985a.42.2026.06.17.08.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:17:33 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Dmitry Fomichev <dmitry.fomichev@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Paolo Bonzini <pbonzini@redhat.com>,
	virtualization@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio-blk: use little-endian types for the zoned fields
Date: Wed, 17 Jun 2026 11:17:27 -0400
Message-ID: <20260617151727.4071754-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

The zoned block-device fields in the virtio-blk header are typed
__virtio{32,64}, so their endianness follows VIRTIO_F_VERSION_1. The
zoned feature is only defined for VIRTIO 1.x devices, and the virtio
specification defines all of its fields as little-endian. Commit
b16a1756c716 ("virtio_blk: mark all zone fields LE") tagged them
__le* for exactly this reason, but commit f1ba4e674feb ("virtio-blk:
fix to match virtio spec") re-applied the reviewed version of the
original zoned series -- which predated b16a1756 -- and silently
restored the __virtio* typing together with the matching
virtio*_to_cpu() / virtio_cread() accessors in the driver.

Restore the little-endian typing for the zoned configuration-space
characteristics, the zone descriptor, the zone report header and the
ZONE_APPEND in-header sector, and read them with le*_to_cpu() and
virtio_cread_le() to match.

There is no functional change on any spec-compliant device: zoned
requires VIRTIO_F_VERSION_1, and for a VERSION_1 device
virtio*_to_cpu() is identical to le*_to_cpu(). The change makes the
uapi types describe the actual wire format and removes a latent
endianness mismatch for a (non-conformant) legacy device on a
big-endian guest.

Fixes: f1ba4e674feb ("virtio-blk: fix to match virtio spec")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Testing:
 - Builds with no new warnings; sparse endian-clean (C=2,
   __CHECK_ENDIAN__, CONFIG_BLK_DEV_ZONED=y) both before and after.
 - Booted under QEMU with a host-managed zoned device exposed through
   virtio-blk. Zone revalidation, blkzone report and a sequential
   write / write-pointer check return correct values; blktests zbd
   device tests 001-006 (sysfs+ioctl, report zone, reset, write split,
   write ordering, revalidate) pass, with results identical before and
   after this change -- expected, since on a VIRTIO_F_VERSION_1 device
   virtio*_to_cpu() == le*_to_cpu().

 drivers/block/virtio_blk.c      | 38 +++++++++++++++------------------
 include/uapi/linux/virtio_blk.h | 18 ++++++++--------
 2 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index b1c9a27fe00f3..5532cfbde7bfe 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -99,7 +99,7 @@ struct virtblk_req {
 		 * be the last byte.
 		 */
 		struct {
-			__virtio64 sector;
+			__le64 sector;
 			u8 status;
 		} zone_append;
 	} in_hdr;
@@ -335,14 +335,12 @@ static inline void virtblk_request_done(struct request *req)
 {
 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
 	blk_status_t status = virtblk_result(virtblk_vbr_status(vbr));
-	struct virtio_blk *vblk = req->mq_hctx->queue->queuedata;
 
 	virtblk_unmap_data(req, vbr);
 	virtblk_cleanup_cmd(req);
 
 	if (req_op(req) == REQ_OP_ZONE_APPEND)
-		req->__sector = virtio64_to_cpu(vblk->vdev,
-						vbr->in_hdr.zone_append.sector);
+		req->__sector = le64_to_cpu(vbr->in_hdr.zone_append.sector);
 
 	blk_mq_end_request(req, status);
 }
@@ -589,13 +587,13 @@ static int virtblk_parse_zone(struct virtio_blk *vblk,
 {
 	struct blk_zone zone = { };
 
-	zone.start = virtio64_to_cpu(vblk->vdev, entry->z_start);
+	zone.start = le64_to_cpu(entry->z_start);
 	if (zone.start + vblk->zone_sectors <= get_capacity(vblk->disk))
 		zone.len = vblk->zone_sectors;
 	else
 		zone.len = get_capacity(vblk->disk) - zone.start;
-	zone.capacity = virtio64_to_cpu(vblk->vdev, entry->z_cap);
-	zone.wp = virtio64_to_cpu(vblk->vdev, entry->z_wp);
+	zone.capacity = le64_to_cpu(entry->z_cap);
+	zone.wp = le64_to_cpu(entry->z_wp);
 
 	switch (entry->z_type) {
 	case VIRTIO_BLK_ZT_SWR:
@@ -687,8 +685,7 @@ static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
 		if (ret)
 			goto fail_report;
 
-		nz = min_t(u64, virtio64_to_cpu(vblk->vdev, report->nr_zones),
-			   nr_zones);
+		nz = min_t(u64, le64_to_cpu(report->nr_zones), nr_zones);
 		if (!nz)
 			break;
 
@@ -698,8 +695,7 @@ static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
 			if (ret)
 				goto fail_report;
 
-			sector = virtio64_to_cpu(vblk->vdev,
-						 report->zones[i].z_start) +
+			sector = le64_to_cpu(report->zones[i].z_start) +
 				 vblk->zone_sectors;
 			zone_idx++;
 		}
@@ -725,18 +721,18 @@ static int virtblk_read_zoned_limits(struct virtio_blk *vblk,
 
 	lim->features |= BLK_FEAT_ZONED;
 
-	virtio_cread(vdev, struct virtio_blk_config,
-		     zoned.max_open_zones, &v);
+	virtio_cread_le(vdev, struct virtio_blk_config,
+			zoned.max_open_zones, &v);
 	lim->max_open_zones = v;
 	dev_dbg(&vdev->dev, "max open zones = %u\n", v);
 
-	virtio_cread(vdev, struct virtio_blk_config,
-		     zoned.max_active_zones, &v);
+	virtio_cread_le(vdev, struct virtio_blk_config,
+			zoned.max_active_zones, &v);
 	lim->max_active_zones = v;
 	dev_dbg(&vdev->dev, "max active zones = %u\n", v);
 
-	virtio_cread(vdev, struct virtio_blk_config,
-		     zoned.write_granularity, &wg);
+	virtio_cread_le(vdev, struct virtio_blk_config,
+			zoned.write_granularity, &wg);
 	if (!wg) {
 		dev_warn(&vdev->dev, "zero write granularity reported\n");
 		return -ENODEV;
@@ -750,8 +746,8 @@ static int virtblk_read_zoned_limits(struct virtio_blk *vblk,
 	 * virtio ZBD specification doesn't require zones to be a power of
 	 * two sectors in size, but the code in this driver expects that.
 	 */
-	virtio_cread(vdev, struct virtio_blk_config, zoned.zone_sectors,
-		     &vblk->zone_sectors);
+	virtio_cread_le(vdev, struct virtio_blk_config, zoned.zone_sectors,
+			&vblk->zone_sectors);
 	if (vblk->zone_sectors == 0 || !is_power_of_2(vblk->zone_sectors)) {
 		dev_err(&vdev->dev,
 			"zoned device with non power of two zone size %u\n",
@@ -767,8 +763,8 @@ static int virtblk_read_zoned_limits(struct virtio_blk *vblk,
 		lim->max_hw_discard_sectors = 0;
 	}
 
-	virtio_cread(vdev, struct virtio_blk_config,
-		     zoned.max_append_sectors, &v);
+	virtio_cread_le(vdev, struct virtio_blk_config,
+			zoned.max_append_sectors, &v);
 	if (!v) {
 		dev_warn(&vdev->dev, "zero max_append_sectors reported\n");
 		return -ENODEV;
diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index 3744e4da1b2a7..5af2a0300bb9d 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -140,11 +140,11 @@ struct virtio_blk_config {
 
 	/* Zoned block device characteristics (if VIRTIO_BLK_F_ZONED) */
 	struct virtio_blk_zoned_characteristics {
-		__virtio32 zone_sectors;
-		__virtio32 max_open_zones;
-		__virtio32 max_active_zones;
-		__virtio32 max_append_sectors;
-		__virtio32 write_granularity;
+		__le32 zone_sectors;
+		__le32 max_open_zones;
+		__le32 max_active_zones;
+		__le32 max_append_sectors;
+		__le32 write_granularity;
 		__u8 model;
 		__u8 unused2[3];
 	} zoned;
@@ -241,11 +241,11 @@ struct virtio_blk_outhdr {
  */
 struct virtio_blk_zone_descriptor {
 	/* Zone capacity */
-	__virtio64 z_cap;
+	__le64 z_cap;
 	/* The starting sector of the zone */
-	__virtio64 z_start;
+	__le64 z_start;
 	/* Zone write pointer position in sectors */
-	__virtio64 z_wp;
+	__le64 z_wp;
 	/* Zone type */
 	__u8 z_type;
 	/* Zone state */
@@ -254,7 +254,7 @@ struct virtio_blk_zone_descriptor {
 };
 
 struct virtio_blk_zone_report {
-	__virtio64 nr_zones;
+	__le64 nr_zones;
 	__u8 reserved[56];
 	struct virtio_blk_zone_descriptor zones[];
 };
-- 
2.53.0

