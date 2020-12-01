Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD8EC64E8A
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 07:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16C952087D
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 07:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ISOkT/s3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgLAHNE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 02:13:04 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:28100 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbgLAHND (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 02:13:03 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201201071219epoutp02d24bab8a2f8da950635641c01f10163d~Mhjd1IgBi0214702147epoutp02f
        for <linux-block@vger.kernel.org>; Tue,  1 Dec 2020 07:12:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201201071219epoutp02d24bab8a2f8da950635641c01f10163d~Mhjd1IgBi0214702147epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1606806739;
        bh=9nx9JveZWx90yOdl6QxPKFvWx8xA9ffuPuQA0SbSGE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ISOkT/s3ysIvjvFTX1ueACEh26/5ym09mYlBSD6jiAxkqmNuxoWBhgDSByRRRze5f
         ELTX+3Jk761xUGAYWavwohJPaqTtfN9igj2W74zGPZNNOy+S1o91SZrSJulePiXU4I
         Kr67r4dDTX7CjvWk+R35cX2XszsBFMnSMIQThht8=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20201201071219epcas5p37ac17a82785b10bdae6ae7ab44cdc369~MhjdWoHD42169821698epcas5p3a;
        Tue,  1 Dec 2020 07:12:19 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.48.33964.3DCE5CF5; Tue,  1 Dec 2020 16:12:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20201201054106epcas5p486fa3f85f6ba5568f6df85c2660b2e3e~MgT0A5W7W1775917759epcas5p4K;
        Tue,  1 Dec 2020 05:41:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201201054106epsmtrp29c961dddb5c1ce330db341bfc535fb81~MgT0AFsvl1422914229epsmtrp2N;
        Tue,  1 Dec 2020 05:41:06 +0000 (GMT)
X-AuditID: b6c32a4b-ea1ff700000184ac-5b-5fc5ecd3c7bd
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.7E.13470.177D5CF5; Tue,  1 Dec 2020 14:41:05 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201201054103epsmtip20337525127272ab3bcc19d12f5f3a18b~MgTyCNvx20268802688epsmtip2-;
        Tue,  1 Dec 2020 05:41:03 +0000 (GMT)
From:   SelvaKumar S <selvakuma.s1@samsung.com>
To:     linux-nvme@lists.infradead.org
Cc:     kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, selvajove@gmail.com,
        nj.shetty@samsung.com, joshi.k@samsung.com,
        javier.gonz@samsung.com, SelvaKumar S <selvakuma.s1@samsung.com>
Subject: [RFC PATCH 2/2] nvme: add simple copy support
Date:   Tue,  1 Dec 2020 11:09:49 +0530
Message-Id: <20201201053949.143175-3-selvakuma.s1@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201201053949.143175-1-selvakuma.s1@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7bCmhu7lN0fjDWZ081isvtvPZtHa/o3J
        YuXqo0wWj+98Zrc4+v8tm8WkQ9cYLfbe0ra4vGsOm8X8ZU/ZLbb9ns9scWXKImaLda/fs1g8
        eH+d3eL1j5NsDnweO2fdZfc4f28ji8fls6Uem1Z1snlsXlLvsftmA5tH35ZVjB6fN8l5tB/o
        ZgrgjOKySUnNySxLLdK3S+DK2L16FnvBaceKned/MTYwnjLuYuTkkBAwkeiY3s7UxcjFISSw
        m1Hi4cMZzBDOJ0aJ7d2/GCGcb4wS6y/3MMG0bN53jgUisRcoMe0FVP9nRomvD2ewg1SxCehK
        XFuyiQXEFhFQkvi7vgmsg1lgPpPE5NtXWUESwgJmEgdvnwJrYBFQlVjyeBrYCl4BO4nDs/sY
        IdbJS8y89B2shlPAXuLji36oGkGJkzOfgC1gBqpp3job7HAJgRMcEmtOTWeHaHaRWDb3ItTd
        whKvjm+BiktJfH63lw3CLpd41jkNqqaBUaLvfTmEbS9xcc9foDgH0AJNifW79CHCshJTT61j
        gtjLJ9H7+wlUK6/EjnlPwMolBNQkTm03gwjLSHw4vAtqk4fEslOvwS4QEpjEKPHzm9YERoVZ
        SL6ZheSbWQiLFzAyr2KUTC0ozk1PLTYtMM5LLdcrTswtLs1L10vOz93ECE5tWt47GB89+KB3
        iJGJg/EQowQHs5IIL8u/I/FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZV+nIkTEkhPLEnNTk0t
        SC2CyTJxcEo1MHH22x265ZsdtrQs4QbbNo7uPW3H55b1er3p4Z718tDkGyfKqyw2HPN1M9x1
        I2ZCot/6dsHy9QuqZlY+Em7R5amprTWRO6HO0/BB2/QP5xERHrbIPs5AHf+/DU3LYkxT2Rvz
        9U9KvFu+UT/0L6fNndU/3+3bfuY1g0CK867piy07TnJ+vbV20asbbttjrJZfsVo//ZiVtcAG
        k+Xy8fdPpq84buSW+2mX+tcgjZWL8lYY/1nYxXU8IvjJs3fl1Seu7lrmclJHzE5SYc0zhsBf
        U7Ptbxs21f66J7tuzdukM0GKRc7vAk8/6XvYIsWj4Wci9rJMokXb6otN5EmFGbK1hUzl83lE
        VhsvVCi+zMXIoMRSnJFoqMVcVJwIANg/oNzcAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSvG7h9aPxBs96rC1W3+1ns2ht/8Zk
        sXL1USaLx3c+s1sc/f+WzWLSoWuMFntvaVtc3jWHzWL+sqfsFtt+z2e2uDJlEbPFutfvWSwe
        vL/ObvH6x0k2Bz6PnbPusnucv7eRxePy2VKPTas62Tw2L6n32H2zgc2jb8sqRo/Pm+Q82g90
        MwVwRnHZpKTmZJalFunbJXBl7F49i73gtGPFzvO/GBsYTxl3MXJySAiYSGzed44FxBYS2M0o
        sX9pPERcRmLt3U42CFtYYuW/5+xdjFxANR+Bap4eYQZJsAnoSlxbsgmsWURASeLv+iYWkCJm
        gfVMErs2fgHrFhYwkzh4+xQ7iM0ioCqx5PE0JhCbV8BO4vDsPkaIDfISMy99B6vhFLCX+Pii
        nwniIjuJxy/ms0PUC0qcnPkEaAEH0AJ1ifXzhEDCzECtzVtnM09gFJyFpGoWQtUsJFULGJlX
        MUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEx5qW5g7G7as+6B1iZOJgPMQowcGsJMLL
        8u9IvBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeG4UL44QE0hNLUrNTUwtSi2CyTBycUg1M+yJY
        AiYU2xQFexbPvLitRTX/xEaZ9S8Xc12eOX+VUGhNldKKEOWL/K4PlpRVXyy99mzdy3Dfupb4
        GV/491bOXNv3zWLi1Z8nXk7udMs7HWTU02CZrci5sPeaxNctJ4UqrPfM9HI1c7pj/yBwbUl2
        pIfn0c2qV1a/vHa17YbSAo+FDzz5HzIFfDfe82v7179Wh0weCZxaKHbwYdb39Md7mvZ+nZac
        6VeR/j/dylnH0tO/KokrX+bESq6qBrFjB8v3vJe5vXoa36sCDcZoX7u93BO1D0wp8/Xq0n8d
        k5HZ/rsoIshg9aZtZ4+eW7StTu+rx1c7A/eeGbwTFm+N9L5WvrnTRX2PVve68tNvbj16ocRS
        nJFoqMVcVJwIAAO3o/skAwAA
X-CMS-MailID: 20201201054106epcas5p486fa3f85f6ba5568f6df85c2660b2e3e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20201201054106epcas5p486fa3f85f6ba5568f6df85c2660b2e3e
References: <20201201053949.143175-1-selvakuma.s1@samsung.com>
        <CGME20201201054106epcas5p486fa3f85f6ba5568f6df85c2660b2e3e@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add support for  TP 4065a ("Simple Copy Command"), v2020.05.04
("Ratified")

The implementation uses the payload passed from the block layer
to form simple copy command. Set the device copy limits to queue
limits.

Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Javier González <javier.gonz@samsung.com>
---
 drivers/nvme/host/core.c | 91 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  4 ++
 include/linux/nvme.h     | 45 ++++++++++++++++++--
 3 files changed, 136 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9b6ebeb29cca..eb6a3157cb2b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -647,6 +647,65 @@ static inline void nvme_setup_flush(struct nvme_ns *ns,
 	cmnd->common.nsid = cpu_to_le32(ns->head->ns_id);
 }
 
+static inline blk_status_t nvme_setup_copy(struct nvme_ns *ns,
+	       struct request *req, struct nvme_command *cmnd)
+{
+	struct nvme_ctrl *ctrl = ns->ctrl;
+	struct nvme_copy_range *range = NULL;
+	struct blk_copy_payload *payload;
+	u16 control = 0;
+	u32 dsmgmt = 0;
+	int nr_range = 0, i;
+	u16 ssrl;
+	u64 slba;
+
+	payload = bio_data(req->bio);
+	nr_range = payload->copy_range;
+
+	if (req->cmd_flags & REQ_FUA)
+		control |= NVME_RW_FUA;
+
+	if (req->cmd_flags & REQ_FAILFAST_DEV)
+		control |= NVME_RW_LR;
+
+	cmnd->copy.opcode = nvme_cmd_copy;
+	cmnd->copy.nsid = cpu_to_le32(ns->head->ns_id);
+	cmnd->copy.sdlba = cpu_to_le64(blk_rq_pos(req) >> (ns->lba_shift - 9));
+
+	range = kmalloc_array(nr_range, sizeof(*range),
+			GFP_ATOMIC | __GFP_NOWARN);
+	if (!range)
+		return BLK_STS_RESOURCE;
+
+	for (i = 0; i < nr_range; i++) {
+		slba = payload->range[i].src;
+		slba = slba >> (ns->lba_shift - 9);
+
+		ssrl = payload->range[i].len;
+		ssrl = ssrl >> (ns->lba_shift - 9);
+
+		range[i].slba = cpu_to_le64(slba);
+		range[i].nlb = cpu_to_le16(ssrl - 1);
+	}
+
+	cmnd->copy.nr_range = nr_range - 1;
+
+	req->special_vec.bv_page = virt_to_page(range);
+	req->special_vec.bv_offset = offset_in_page(range);
+	req->special_vec.bv_len = sizeof(*range) * nr_range;
+	req->rq_flags |= RQF_SPECIAL_PAYLOAD;
+
+	if (ctrl->nr_streams)
+		nvme_assign_write_stream(ctrl, req, &control, &dsmgmt);
+
+	//TBD end-to-end
+
+	cmnd->rw.control = cpu_to_le16(control);
+	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
+
+	return BLK_STS_OK;
+}
+
 static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *cmnd)
 {
@@ -829,6 +888,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 	case REQ_OP_DISCARD:
 		ret = nvme_setup_discard(ns, req, cmd);
 		break;
+	case REQ_OP_COPY:
+		ret = nvme_setup_copy(ns, req, cmd);
+		break;
 	case REQ_OP_READ:
 		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_read);
 		break;
@@ -1850,6 +1912,32 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
 }
 
+static void nvme_config_copy(struct gendisk *disk, struct nvme_ns *ns,
+				       struct nvme_id_ns *id)
+{
+	struct nvme_ctrl *ctrl = ns->ctrl;
+	struct request_queue *queue = disk->queue;
+
+	if (!(ctrl->oncs & NVME_CTRL_ONCS_COPY)) {
+		queue->limits.max_copy_sectors = 0;
+		blk_queue_flag_clear(QUEUE_FLAG_COPY, queue);
+		return;
+	}
+
+	/* setting copy limits */
+	ns->mcl = le64_to_cpu(id->mcl);
+	ns->mssrl = le32_to_cpu(id->mssrl);
+	ns->msrc = id->msrc;
+
+	if (blk_queue_flag_test_and_set(QUEUE_FLAG_COPY, queue))
+		return;
+
+	queue->limits.max_copy_sectors = ns->mcl * (1 << (ns->lba_shift - 9));
+	queue->limits.max_copy_range_sectors = ns->mssrl *
+		(1 << (ns->lba_shift - 9));
+	queue->limits.max_copy_nr_ranges = ns->msrc + 1;
+}
+
 static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_ns *ns)
 {
 	u64 max_blocks;
@@ -2045,6 +2133,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	set_capacity_and_notify(disk, capacity);
 
 	nvme_config_discard(disk, ns);
+	nvme_config_copy(disk, ns, id);
 	nvme_config_write_zeroes(disk, ns);
 
 	if (id->nsattr & NVME_NS_ATTR_RO)
@@ -3014,6 +3103,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->oaes = le32_to_cpu(id->oaes);
 	ctrl->wctemp = le16_to_cpu(id->wctemp);
 	ctrl->cctemp = le16_to_cpu(id->cctemp);
+	ctrl->ocfs = le32_to_cpu(id->ocfs);
 
 	atomic_set(&ctrl->abort_limit, id->acl + 1);
 	ctrl->vwc = id->vwc;
@@ -4616,6 +4706,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_download_firmware) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_format_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_dsm_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_copy_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_write_zeroes_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_abort_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_get_log_page_command) != 64);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 567f7ad18a91..30ce8d68f5ec 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -280,6 +280,7 @@ struct nvme_ctrl {
 	u8 vwc;
 	u32 vs;
 	u32 sgls;
+	u16 ocfs;
 	u16 kas;
 	u8 npss;
 	u8 apsta;
@@ -433,6 +434,9 @@ struct nvme_ns {
 	u16 ms;
 	u16 sgs;
 	u32 sws;
+	u32 mcl;
+	u16 mssrl;
+	u8 msrc;
 	u8 pi_type;
 #ifdef CONFIG_BLK_DEV_ZONED
 	u64 zsze;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index d92535997687..541a22897cd6 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -289,10 +289,10 @@ struct nvme_id_ctrl {
 	__u8			nvscc;
 	__u8			nwpc;
 	__le16			acwu;
-	__u8			rsvd534[2];
+	__le16			ocfs;
 	__le32			sgls;
 	__le32			mnan;
-	__u8			rsvd544[224];
+	__u8                    rsvd544[224];
 	char			subnqn[256];
 	__u8			rsvd1024[768];
 	__le32			ioccsz;
@@ -314,6 +314,7 @@ enum {
 	NVME_CTRL_ONCS_WRITE_ZEROES		= 1 << 3,
 	NVME_CTRL_ONCS_RESERVATIONS		= 1 << 5,
 	NVME_CTRL_ONCS_TIMESTAMP		= 1 << 6,
+	NVME_CTRL_ONCS_COPY			= 1 << 8,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
 	NVME_CTRL_OACS_DIRECTIVES		= 1 << 5,
@@ -362,7 +363,10 @@ struct nvme_id_ns {
 	__le16			npdg;
 	__le16			npda;
 	__le16			nows;
-	__u8			rsvd74[18];
+	__le16			mssrl;
+	__le32			mcl;
+	__u8			msrc;
+	__u8			rsvd91[11];
 	__le32			anagrpid;
 	__u8			rsvd96[3];
 	__u8			nsattr;
@@ -673,6 +677,7 @@ enum nvme_opcode {
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
 	nvme_cmd_resv_release	= 0x15,
+	nvme_cmd_copy		= 0x19,
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
 	nvme_cmd_zone_append	= 0x7d,
@@ -691,7 +696,8 @@ enum nvme_opcode {
 		nvme_opcode_name(nvme_cmd_resv_register),	\
 		nvme_opcode_name(nvme_cmd_resv_report),		\
 		nvme_opcode_name(nvme_cmd_resv_acquire),	\
-		nvme_opcode_name(nvme_cmd_resv_release))
+		nvme_opcode_name(nvme_cmd_resv_release),	\
+		nvme_opcode_name(nvme_cmd_copy))
 
 
 /*
@@ -863,6 +869,36 @@ struct nvme_dsm_range {
 	__le64			slba;
 };
 
+struct nvme_copy_command {
+	__u8                    opcode;
+	__u8                    flags;
+	__u16                   command_id;
+	__le32                  nsid;
+	__u64                   rsvd2;
+	__le64                  metadata;
+	union nvme_data_ptr     dptr;
+	__le64                  sdlba;
+	__u8			nr_range;
+	__u8			rsvd12;
+	__le16                  control;
+	__le16                  rsvd13;
+	__le16			dspec;
+	__le32                  ilbrt;
+	__le16                  lbat;
+	__le16                  lbatm;
+};
+
+struct nvme_copy_range {
+	__le64			rsvd0;
+	__le64			slba;
+	__le16			nlb;
+	__le16			rsvd18;
+	__le32			rsvd20;
+	__le32			eilbrt;
+	__le16			elbat;
+	__le16			elbatm;
+};
+
 struct nvme_write_zeroes_cmd {
 	__u8			opcode;
 	__u8			flags;
@@ -1400,6 +1436,7 @@ struct nvme_command {
 		struct nvme_download_firmware dlfw;
 		struct nvme_format_cmd format;
 		struct nvme_dsm_cmd dsm;
+		struct nvme_copy_command copy;
 		struct nvme_write_zeroes_cmd write_zeroes;
 		struct nvme_zone_mgmt_send_cmd zms;
 		struct nvme_zone_mgmt_recv_cmd zmr;
-- 
2.25.1

