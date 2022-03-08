Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F51C433F5
	for <linux-block@archiver.kernel.org>; Tue,  8 Mar 2022 16:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346020AbiCHQzh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 11:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345576AbiCHQzg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 11:55:36 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A414EF4F
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 08:54:39 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220308165438euoutp01e69bb84fa05d964df171853a44209b70~adhxiBZoL0386603866euoutp01G
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 16:54:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220308165438euoutp01e69bb84fa05d964df171853a44209b70~adhxiBZoL0386603866euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646758478;
        bh=1YzBI3QOSlc4vPAYHgBOHlD+7Cnh780oelqWpe0CZLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qiVrbmqb2B02iEBlaeQJFTCKPvOlam3LT2rjEc80myIaI+UP6JXdhPzLtv3OkLQa6
         J2kOeto6JOBPRJu6Zknc0zJbov9WyDxQO3ChvCNbbcYscOXhpJqWuWQkZ8YB885EXz
         H833vC6WLXcAlGMlEoAQKoJhGJQKcKkVb1topilw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220308165437eucas1p14fa8fd82729768844de4893ee65e8abc~adhxJ-35N0451504515eucas1p1s;
        Tue,  8 Mar 2022 16:54:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5D.AD.09887.D4A87226; Tue,  8
        Mar 2022 16:54:37 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220308165436eucas1p1b76f3cb5b4fa1f7d78b51a3b1b44d160~adhwilQOX0435704357eucas1p1s;
        Tue,  8 Mar 2022 16:54:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220308165436eusmtrp180830eb17cf9b45f8c930b427af213f6~adhwh1WUh0499204992eusmtrp1u;
        Tue,  8 Mar 2022 16:54:36 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-32-62278a4d1d44
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id FE.73.09522.C4A87226; Tue,  8
        Mar 2022 16:54:36 +0000 (GMT)
Received: from localhost (unknown [106.210.248.181]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220308165436eusmtip1107f453e4fcdf8dc5ce8e2ba013b6b07~adhwNRgXf0238202382eusmtip1g;
        Tue,  8 Mar 2022 16:54:36 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        jiangbo.365@bytedance.com
Cc:     Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 4/6] nvme: zns: Add support for power_of_2 emulation to NVMe
 ZNS devices
Date:   Tue,  8 Mar 2022 17:53:47 +0100
Message-Id: <20220308165349.231320-5-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308165349.231320-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsWy7djP87q+XepJBm9eyFtMP6xosfpuP5vF
        77PnmS1Wrj7KZPH4zmd2i54DH1gsjv5/y2Zx/u1hJotJh64xWuy9pW0xf9lTdosJbV+ZLW5M
        eMpo8XlpC7vFmptPWSzWvX7P4iDg8e/EGjaPnbPusnucv7eRxePy2VKPTas62Tw2L6n32H2z
        ASjXep/Vo2/LKkaPz5vkPNoPdDMFcEdx2aSk5mSWpRbp2yVwZdw/cYa14HxxxZGJU9kaGP/F
        dzFyckgImEhc2NnC2sXIxSEksIJRYt7V14wQzhdGid0H/7FDOJ8ZJVbe3M0K09L5fBFUYjmj
        xPrVz5ghnJeMEn+//AbKcHCwCWhJNHaygzSICFxglvhxUxGkhllgM6PEh0krWEFqhAWiJBp7
        K0FqWARUJfav6wVbwCtgJTHh+0wmiGXyEjMvfQebwylgLfG0cyYbRI2gxMmZT1hAbGagmuat
        s8FukBBYzCnR/ukSVLOLxKO5D1kgbGGJV8e3sEPYMhKnJ/ewQDT0M0pMbfnDBOHMYJToObyZ
        CeQ6CaB1fWdyQExmAU2J9bv0IaKOEi8/F0CYfBI33gpCnMAnMWnbdGaIMK9ER5sQxCIliZ0/
        n0AtlZC43DQH6hgPiRmn/zFOYFScheSZWUiemYWwdgEj8ypG8dTS4tz01GKjvNRyveLE3OLS
        vHS95PzcTYzAtHf63/EvOxiXv/qod4iRiYPxEKMEB7OSCO/98ypJQrwpiZVVqUX58UWlOanF
        hxilOViUxHmTMzckCgmkJ5akZqemFqQWwWSZODilGphKHuZ96DC0q734b/msU3a5Lh7/lif+
        nNoREXxiQX+ei47JzevR7pYFbEUKMxbs3C8uYNq7XfT1Wo+nYtb2L1+WzHkizXigOUzP4L0O
        N9Mn3R8m/AoFaldKBX5ly0//HljguIp36rm/fR93hb547XlwVfwC61f2kquqbWYfnd6t5M8a
        JbU4etmUsi7zr58/TmdkC/qxs1/KQvJx5uWQg9Z7N3sWx4rssp+uEHu753Dao4MmdT1uSkrr
        WLkfT+Fbdmzn86oNE2/6GDVPbX9UaFj4/1l3fL1l1+zdite5F9x6s3ZK+o99Dp922Zwp/nBb
        +f4pHonrO0yu6Ns4rL+S2rPR2OKWa8ijnjC2RIfdxROUWIozEg21mIuKEwG2Vpy96gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xu7o+XepJBo8bzCymH1a0WH23n83i
        99nzzBYrVx9lsnh85zO7Rc+BDywWR/+/ZbM4//Ywk8WkQ9cYLfbe0raYv+wpu8WEtq/MFjcm
        PGW0+Ly0hd1izc2nLBbrXr9ncRDw+HdiDZvHzll32T3O39vI4nH5bKnHplWdbB6bl9R77L7Z
        AJRrvc/q0bdlFaPH501yHu0HupkCuKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1j
        rYxMlfTtbFJSczLLUov07RL0Mu6fOMNacL644sjEqWwNjP/iuxg5OSQETCQ6ny9i72Lk4hAS
        WMooceHbNRaIhITE7YVNjBC2sMSfa11sEEXPGSUadx0BSnBwsAloSTR2gjWLCNxgllg2tY0R
        xGEW2M4osWHlHDaQbmGBCImV2yaC2SwCqhL71/Wygti8AlYSE77PZILYIC8x89J3dhCbU8Ba
        4mnnTLB6IaCaXwdamSDqBSVOznwCdh0zUH3z1tnMExgFZiFJzUKSWsDItIpRJLW0ODc9t9hQ
        rzgxt7g0L10vOT93EyMwSrcd+7l5B+O8Vx/1DjEycTAeYpTgYFYS4b1/XiVJiDclsbIqtSg/
        vqg0J7X4EKMp0N0TmaVEk/OBaSKvJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1
        CKaPiYNTqoFpdehy2wSWwu/fJijPkxHtW3NTd8rTj5+E9NutHsgqMoYKBb56tNs13Kl4s4do
        6cUmZdPLG5pT3ydNUvTMXfn+UPWmGRJRTJ09OiteTip9sWJV+tVPDKsnB2V5tlVtOMR3mMVy
        lYKn8vKJ7ukfGMqP3RdunJp3L3HL16veOc9vb+338117ZeYbve2lUtZmAYJB53JdvtS4FKv9
        e+pWI7NQ0lnmowvHT/l1bdr72/7kWvku/y30JI8rL/B90CSBEMc95q0rfk3MP6p3x65/d33e
        +tV2SXuPb748p57n0O1JCYuT3iZmmJzg8GYwb5Bt9zzzwJbV+86V8rppiR33L3rZLDjDse9C
        rUGwUb1x8xUlluKMREMt5qLiRAAHLvEcWwMAAA==
X-CMS-MailID: 20220308165436eucas1p1b76f3cb5b4fa1f7d78b51a3b1b44d160
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220308165436eucas1p1b76f3cb5b4fa1f7d78b51a3b1b44d160
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220308165436eucas1p1b76f3cb5b4fa1f7d78b51a3b1b44d160
References: <20220308165349.231320-1-p.raghav@samsung.com>
        <CGME20220308165436eucas1p1b76f3cb5b4fa1f7d78b51a3b1b44d160@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

power_of_2(PO2) is not a requirement as per the NVMe ZNSspecification,
however we still have in place a lot of assumptions
for PO2 in the block layer, in FS such as F2FS, btrfs and userspace
applications.

So in keeping with these requirements, provide an emulation layer to
non-power_of_2 zone devices and which does not create a performance
regression to existing zone storage devices which have PO2 zone sizes.
Callbacks are provided where needed in the hot paths to reduce the
impact of performance regression.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/host/core.c |  28 +++++++----
 drivers/nvme/host/nvme.h | 100 ++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/pci.c  |   4 ++
 drivers/nvme/host/zns.c  |  79 +++++++++++++++++++++++++++++--
 include/linux/blk-mq.h   |   2 +
 5 files changed, 200 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fd4720d37cc0..c7180d512b08 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -327,14 +327,6 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 	return RETRY;
 }
 
-static inline void nvme_end_req_zoned(struct request *req)
-{
-	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
-	    req_op(req) == REQ_OP_ZONE_APPEND)
-		req->__sector = nvme_lba_to_sect(req->q->queuedata,
-			le64_to_cpu(nvme_req(req)->result.u64));
-}
-
 static inline void nvme_end_req(struct request *req)
 {
 	blk_status_t status = nvme_error_status(nvme_req(req)->status);
@@ -676,6 +668,12 @@ blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
 }
 EXPORT_SYMBOL_GPL(nvme_fail_nonready_command);
 
+blk_status_t nvme_fail_po2_zone_emu_violation(struct request *req)
+{
+	return nvme_zone_handle_po2_emu_violation(req);
+}
+EXPORT_SYMBOL_GPL(nvme_fail_po2_zone_emu_violation);
+
 bool __nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 		bool queue_live)
 {
@@ -879,6 +877,7 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	req->special_vec.bv_offset = offset_in_page(range);
 	req->special_vec.bv_len = alloc_size;
 	req->rq_flags |= RQF_SPECIAL_PAYLOAD;
+	nvme_verify_sector_value(ns, req);
 
 	return BLK_STS_OK;
 }
@@ -909,6 +908,7 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 			break;
 		}
 	}
+	nvme_verify_sector_value(ns, req);
 
 	return BLK_STS_OK;
 }
@@ -973,6 +973,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 
 	cmnd->rw.control = cpu_to_le16(control);
 	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
+	nvme_verify_sector_value(ns, req);
 	return 0;
 }
 
@@ -2105,8 +2106,14 @@ static int nvme_report_zones(struct gendisk *disk, sector_t sector,
 	return nvme_ns_report_zones(disk->private_data, sector, nr_zones, cb,
 			data);
 }
+
+static void nvme_npo2_zone_setup(struct gendisk *disk)
+{
+	nvme_ns_po2_zone_emu_setup(disk->private_data);
+}
 #else
 #define nvme_report_zones	NULL
+#define nvme_npo2_zone_setup	NULL
 #endif /* CONFIG_BLK_DEV_ZONED */
 
 static const struct block_device_operations nvme_bdev_ops = {
@@ -2116,6 +2123,7 @@ static const struct block_device_operations nvme_bdev_ops = {
 	.release	= nvme_release,
 	.getgeo		= nvme_getgeo,
 	.report_zones	= nvme_report_zones,
+	.npo2_zone_setup = nvme_npo2_zone_setup,
 	.pr_ops		= &nvme_pr_ops,
 };
 
@@ -3844,6 +3852,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	ns->disk = disk;
 	ns->queue = disk->queue;
 
+#ifdef CONFIG_BLK_DEV_ZONED
+	ns->sect_to_lba = __nvme_sect_to_lba;
+	ns->update_sector_append = nvme_update_sector_append_noop;
+#endif
 	if (ctrl->opts && ctrl->opts->data_digest)
 		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, ns->queue);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a162f6c6da6e..f584f760e8cc 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -457,6 +457,10 @@ struct nvme_ns {
 	u8 pi_type;
 #ifdef CONFIG_BLK_DEV_ZONED
 	u64 zsze;
+	u64 zsze_po2;
+	u32 zsze_diff;
+	u64 (*sect_to_lba)(struct nvme_ns *ns, sector_t sector);
+	sector_t (*update_sector_append)(struct nvme_ns *ns, sector_t sector);
 #endif
 	unsigned long features;
 	unsigned long flags;
@@ -562,12 +566,21 @@ static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
 	return ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 0x4E564D65);
 }
 
+static inline u64 __nvme_sect_to_lba(struct nvme_ns *ns, sector_t sector)
+{
+	return sector >> (ns->lba_shift - SECTOR_SHIFT);
+}
+
 /*
  * Convert a 512B sector number to a device logical block number.
  */
 static inline u64 nvme_sect_to_lba(struct nvme_ns *ns, sector_t sector)
 {
-	return sector >> (ns->lba_shift - SECTOR_SHIFT);
+#ifdef CONFIG_BLK_DEV_ZONED
+	return ns->sect_to_lba(ns, sector);
+#else
+	return __nvme_sect_to_lba(ns, sector);
+#endif
 }
 
 /*
@@ -578,6 +591,83 @@ static inline sector_t nvme_lba_to_sect(struct nvme_ns *ns, u64 lba)
 	return lba << (ns->lba_shift - SECTOR_SHIFT);
 }
 
+#ifdef CONFIG_BLK_DEV_ZONED
+static inline u64 __nvme_sect_to_lba_po2(struct nvme_ns *ns, sector_t sector)
+{
+	sector_t zone_idx = sector >> ilog2(ns->zsze_po2);
+
+	sector = sector - (zone_idx * ns->zsze_diff);
+
+	return sector >> (ns->lba_shift - SECTOR_SHIFT);
+}
+
+static inline sector_t
+nvme_update_sector_append_po2_zone_emu(struct nvme_ns *ns, sector_t sector)
+{
+	/* The sector value passed by the drive after a append operation is the
+	 * based on the actual zone layout in the device, hence, use the actual
+	 * zone_size to calculate the zone number from the sector.
+	 */
+	u32 zone_no = sector / ns->zsze;
+
+	sector += ns->zsze_diff * zone_no;
+	return sector;
+}
+
+static inline sector_t nvme_update_sector_append_noop(struct nvme_ns *ns,
+						      sector_t sector)
+{
+	return sector;
+}
+
+static inline void nvme_end_req_zoned(struct request *req)
+{
+	if (req_op(req) == REQ_OP_ZONE_APPEND) {
+		struct nvme_ns *ns = req->q->queuedata;
+		sector_t sector;
+
+		sector = nvme_lba_to_sect(ns,
+					  le64_to_cpu(nvme_req(req)->result.u64));
+
+		sector = ns->update_sector_append(ns, sector);
+
+		req->__sector = sector;
+	}
+}
+
+static inline void nvme_verify_sector_value(struct nvme_ns *ns, struct request *req)
+{
+	if (unlikely(blk_queue_is_po2_zone_emu(ns->queue))) {
+		sector_t sector = blk_rq_pos(req);
+		sector_t zone_idx = sector >> ilog2(ns->zsze_po2);
+		sector_t device_sector = sector - (zone_idx * ns->zsze_diff);
+
+		/* Check if the IO is in the emulated area */
+		if (device_sector - (zone_idx * ns->zsze) > ns->zsze)
+			req->rq_flags |= RQF_ZONE_EMU_VIOLATION;
+	}
+}
+
+static inline bool nvme_po2_zone_emu_violation(struct request *req)
+{
+	return req->rq_flags & RQF_ZONE_EMU_VIOLATION;
+}
+#else
+static inline void nvme_end_req_zoned(struct request *req)
+{
+}
+
+static inline void nvme_verify_sector_value(struct nvme_ns *ns, struct request *req)
+{
+}
+
+static inline bool nvme_po2_zone_emu_violation(struct request *req)
+{
+	return false;
+}
+
+#endif
+
 /*
  * Convert byte length to nvme's 0-based num dwords
  */
@@ -752,6 +842,7 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 		unsigned long arg);
 int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo);
+blk_status_t nvme_fail_po2_zone_emu_violation(struct request *req);
 
 extern const struct attribute_group *nvme_ns_id_attr_groups[];
 extern const struct pr_ops nvme_pr_ops;
@@ -873,11 +964,13 @@ static inline void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
 int nvme_revalidate_zones(struct nvme_ns *ns);
 int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 		unsigned int nr_zones, report_zones_cb cb, void *data);
+void nvme_ns_po2_zone_emu_setup(struct nvme_ns *ns);
 #ifdef CONFIG_BLK_DEV_ZONED
 int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf);
 blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req,
 				       struct nvme_command *cmnd,
 				       enum nvme_zone_mgmt_action action);
+blk_status_t nvme_zone_handle_po2_emu_violation(struct request *req);
 #else
 static inline blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns,
 		struct request *req, struct nvme_command *cmnd,
@@ -892,6 +985,11 @@ static inline int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 		 "Please enable CONFIG_BLK_DEV_ZONED to support ZNS devices\n");
 	return -EPROTONOSUPPORT;
 }
+
+static inline blk_status_t nvme_zone_handle_po2_emu_violation(struct request *req)
+{
+	return BLK_STS_OK;
+}
 #endif
 
 static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6a99ed680915..fc022df3f98e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -960,6 +960,10 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 		return nvme_fail_nonready_command(&dev->ctrl, req);
 
 	ret = nvme_prep_rq(dev, req);
+
+	if (unlikely(nvme_po2_zone_emu_violation(req)))
+		return nvme_fail_po2_zone_emu_violation(req);
+
 	if (unlikely(ret))
 		return ret;
 	spin_lock(&nvmeq->sq_lock);
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index ad02c61c0b52..25516a5ae7e2 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -3,7 +3,9 @@
  * Copyright (C) 2020 Western Digital Corporation or its affiliates.
  */
 
+#include <linux/log2.h>
 #include <linux/blkdev.h>
+#include <linux/math.h>
 #include <linux/vmalloc.h>
 #include "nvme.h"
 
@@ -46,6 +48,18 @@ static int nvme_set_max_append(struct nvme_ctrl *ctrl)
 	return 0;
 }
 
+static sector_t nvme_zone_size(struct nvme_ns *ns)
+{
+	sector_t zone_size;
+
+	if (blk_queue_is_po2_zone_emu(ns->queue))
+		zone_size = ns->zsze_po2;
+	else
+		zone_size = ns->zsze;
+
+	return zone_size;
+}
+
 int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 {
 	struct nvme_effects_log *log = ns->head->effects;
@@ -122,7 +136,7 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
 				   sizeof(struct nvme_zone_descriptor);
 
 	nr_zones = min_t(unsigned int, nr_zones,
-			 get_capacity(ns->disk) / ns->zsze);
+			 get_capacity(ns->disk) / nvme_zone_size(ns));
 
 	bufsize = sizeof(struct nvme_zone_report) +
 		nr_zones * sizeof(struct nvme_zone_descriptor);
@@ -147,6 +161,8 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
 				 void *data)
 {
 	struct blk_zone zone = { };
+	u64 zone_gap = 0;
+	u32 zone_idx;
 
 	if ((entry->zt & 0xf) != NVME_ZONE_TYPE_SEQWRITE_REQ) {
 		dev_err(ns->ctrl->device, "invalid zone type %#x\n",
@@ -159,10 +175,19 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
 	zone.len = ns->zsze;
 	zone.capacity = nvme_lba_to_sect(ns, le64_to_cpu(entry->zcap));
 	zone.start = nvme_lba_to_sect(ns, le64_to_cpu(entry->zslba));
+
+	if (blk_queue_is_po2_zone_emu(ns->queue)) {
+		zone_idx = zone.start / zone.len;
+		zone_gap = zone_idx * ns->zsze_diff;
+		zone.start += zone_gap;
+		zone.len = ns->zsze_po2;
+	}
+
 	if (zone.cond == BLK_ZONE_COND_FULL)
 		zone.wp = zone.start + zone.len;
 	else
-		zone.wp = nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));
+		zone.wp =
+			nvme_lba_to_sect(ns, le64_to_cpu(entry->wp)) + zone_gap;
 
 	return cb(&zone, idx, data);
 }
@@ -173,6 +198,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 	struct nvme_zone_report *report;
 	struct nvme_command c = { };
 	int ret, zone_idx = 0;
+	u64 zone_size = nvme_zone_size(ns);
 	unsigned int nz, i;
 	size_t buflen;
 
@@ -190,7 +216,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
 	c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
 
-	sector &= ~(ns->zsze - 1);
+	sector = rounddown(sector, zone_size);
 	while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
 		memset(report, 0, buflen);
 
@@ -214,7 +240,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 			zone_idx++;
 		}
 
-		sector += ns->zsze * nz;
+		sector += zone_size * nz;
 	}
 
 	if (zone_idx > 0)
@@ -226,6 +252,32 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 	return ret;
 }
 
+void nvme_ns_po2_zone_emu_setup(struct nvme_ns *ns)
+{
+	u32 nr_zones;
+	sector_t capacity;
+
+	if (is_power_of_2(ns->zsze))
+		return;
+
+	if (!get_capacity(ns->disk))
+		return;
+
+	blk_mq_freeze_queue(ns->disk->queue);
+
+	blk_queue_po2_zone_emu(ns->queue, 1);
+	ns->zsze_po2 = 1 << get_count_order_long(ns->zsze);
+	ns->zsze_diff = ns->zsze_po2 - ns->zsze;
+
+	nr_zones = get_capacity(ns->disk) / ns->zsze;
+	capacity = nr_zones * ns->zsze_po2;
+	set_capacity_and_notify(ns->disk, capacity);
+	ns->sect_to_lba = __nvme_sect_to_lba_po2;
+	ns->update_sector_append = nvme_update_sector_append_po2_zone_emu;
+
+	blk_mq_unfreeze_queue(ns->disk->queue);
+}
+
 blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *c, enum nvme_zone_mgmt_action action)
 {
@@ -239,5 +291,24 @@ blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req,
 	if (req_op(req) == REQ_OP_ZONE_RESET_ALL)
 		c->zms.select_all = 1;
 
+	nvme_verify_sector_value(ns, req);
+	return BLK_STS_OK;
+}
+
+blk_status_t nvme_zone_handle_po2_emu_violation(struct request *req)
+{
+	/*  The spec mentions that read from ZCAP until ZSZE shall behave
+	 *  like a deallocated block. Deallocated block reads are
+	 *  deterministic, hence we fill zero.
+	 * The spec does not clearly define the result for other opreation.
+	 */
+	if (req_op(req) == REQ_OP_READ) {
+		zero_fill_bio(req->bio);
+		nvme_req(req)->status = NVME_SC_SUCCESS;
+	} else {
+		nvme_req(req)->status = NVME_SC_WRITE_FAULT;
+	}
+	blk_mq_set_request_complete(req);
+	nvme_complete_rq(req);
 	return BLK_STS_OK;
 }
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 3a41d50b85d3..9ec59183efcd 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -57,6 +57,8 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_TIMED_OUT		((__force req_flags_t)(1 << 21))
 /* queue has elevator attached */
 #define RQF_ELV			((__force req_flags_t)(1 << 22))
+/* request to do IO in the emulated area with po2 zone emulation */
+#define RQF_ZONE_EMU_VIOLATION	((__force req_flags_t)(1 << 23))
 
 /* flags that prevent us from merging requests: */
 #define RQF_NOMERGE_FLAGS \
-- 
2.25.1

