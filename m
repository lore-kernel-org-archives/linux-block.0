Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BC5C4167B
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 11:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3726122A84
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 11:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387975AbgLDLDT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Dec 2020 06:03:19 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:59238 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387702AbgLDLDT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Dec 2020 06:03:19 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201204110237epoutp0122e3b017a9c0153bdb7556e032bfa1c0~NfoZATVXU1775217752epoutp01b
        for <linux-block@vger.kernel.org>; Fri,  4 Dec 2020 11:02:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201204110237epoutp0122e3b017a9c0153bdb7556e032bfa1c0~NfoZATVXU1775217752epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1607079757;
        bh=QEawhnHLuWf/3lYOyqbYtAwEeqa/idcrwD6MA5QVDP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XO2t6yHJkmI/3+BPr1zSFIStXAXqv+G0utw5w8DqQtyh3jTmNDU1cHcZKn7d8xxq7
         gkMjV8tgqdUQHzF33iN20tcQelAd2RcIwzFXV6ASZfzFxYvfz0CXc1XnV0cnMomS+q
         mC3EBJYpwSyFuTLBywYBvsse9nVwpTAyZZ1++0M8=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20201204110236epcas5p44e480a88dd5f4d1e09dc55b4c42755b6~NfoYZVYNE0722207222epcas5p4U;
        Fri,  4 Dec 2020 11:02:36 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6D.E1.33964.C471ACF5; Fri,  4 Dec 2020 20:02:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20201204094747epcas5p121b6eccf78a29ed4cba7c22d6b42d160~NenDZ3B4h1317013170epcas5p1K;
        Fri,  4 Dec 2020 09:47:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201204094747epsmtrp2cbf8c7f11ca1cc9bc229a92b68fad15e~NenDY1msY3021930219epsmtrp2f;
        Fri,  4 Dec 2020 09:47:47 +0000 (GMT)
X-AuditID: b6c32a4b-ea1ff700000184ac-a9-5fca174c5e3f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A3.38.13470.2C50ACF5; Fri,  4 Dec 2020 18:47:46 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201204094742epsmtip242cb2d31ecb62fb151ab37d94ac0c0a5~Nem-fZOEc0441104411epsmtip2E;
        Fri,  4 Dec 2020 09:47:42 +0000 (GMT)
From:   SelvaKumar S <selvakuma.s1@samsung.com>
To:     linux-nvme@lists.infradead.org
Cc:     kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        snitzer@redhat.com, selvajove@gmail.com, nj.shetty@samsung.com,
        joshi.k@samsung.com, javier.gonz@samsung.com,
        SelvaKumar S <selvakuma.s1@samsung.com>
Subject: [RFC PATCH v2 2/2] nvme: add simple copy support
Date:   Fri,  4 Dec 2020 15:16:59 +0530
Message-Id: <20201204094659.12732-3-selvakuma.s1@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201204094659.12732-1-selvakuma.s1@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsWy7bCmlq6P+Kl4g3OzxS1W3+1ns2ht/8Zk
        sffdbFaLlauPMlk8vvOZ3eLo/7dsFpMOXWO02HtL2+LyrjlsFvOXPWW32PZ7PrPFlSmLmC3W
        vX7PYvHg/XV2i9c/TrJZtG38yugg4LFz1l12j/P3NrJ4XD5b6rFpVSebx+Yl9R67bzawebzf
        d5XNo2/LKkaPz5vkPNoPdDMFcEVx2aSk5mSWpRbp2yVwZXyfu4W9YI9VxfaJV9gaGPv1uhg5
        OSQETCT6T35m7mLk4hAS2M0o8eDPEnYI5xOjxMNVs1kgnG+MEgeXXmCDaTnavgAqsZdR4uiO
        vawQzmdGicnNU1lBqtgEdCWuLdnEAmKLCChJ/F3fBNbBLHCKSaLp3y52kISwgKXEjfNfGbsY
        OThYBFQlJp3OBQnzCthKXPh0GWqbvMTMS9/ByjkF7CRWbHvHBlEjKHFy5hOw+cxANc1bZ4M9
        ISHwgEPi/J6dzCAzJQRcJJ61aUPMEZZ4dXwLO4QtJfH53V6o+eUSzzqnMUHYDYwSfe/LIWx7
        iYt7/jKBjGEW0JRYv0sfIiwrMfXUOiaItXwSvb+fQLXySuyY94QJYquaxKntZhBhGYkPh3dB
        bfKQ2PXtDRMkqCYySuxde4ptAqPCLCTfzELyzSyEzQsYmVcxSqYWFOempxabFhjnpZbrFSfm
        Fpfmpesl5+duYgSnPS3vHYyPHnzQO8TIxMF4iFGCg1lJhDdW9WS8EG9KYmVValF+fFFpTmrx
        IUZpDhYlcV6lH2fihATSE0tSs1NTC1KLYLJMHJxSDUx22g/LRU+ey+K+/32X+S/XOyJyvcd0
        j9U1et3lik7cajzbSLopUHFu2n2O+We/Hd6x7q+HPpfvZNlLRswNW4SOzltcreN8WGJvgdGU
        PH1Xvgc5HIuMldZ0mdsELLGoKm/KP/Kd/3ddpHj62Ysvd/zbyhe7WlN7X9G7vFkz7hq/ZlkY
        93Ra14uSt6e5LvBK+M8I/L4pI493t+iucxJ7/czuXz/T/e7HSxNNyX3TEtzu3pzwJ2jBrTuv
        sp3YuRbstFzsY60Wej/St4mP7eLLGc4aP/kOv3gcW1cUxz3v878FG19MfJ977oKpLn+kYrBr
        46o7538lHHh0TDysKfT5AbW6ltzjxd9llUtf7n3dHDlTiaU4I9FQi7moOBEASOiJxOoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsWy7bCSvO4h1lPxBvd32VisvtvPZtHa/o3J
        Yu+72awWK1cfZbJ4fOczu8XR/2/ZLCYdusZosfeWtsXlXXPYLOYve8puse33fGaLK1MWMVus
        e/2exeLB++vsFq9/nGSzaNv4ldFBwGPnrLvsHufvbWTxuHy21GPTqk42j81L6j1232xg83i/
        7yqbR9+WVYwenzfJebQf6GYK4IrisklJzcksSy3St0vgyvg+dwt7wR6riu0Tr7A1MPbrdTFy
        ckgImEgcbV/A0sXIxSEksJtRYs7nOcwQCRmJtXc72SBsYYmV/56zQxR9ZJT4/PI4E0iCTUBX
        4tqSTSwgtoiAksTf9U1gNrPAHSaJbT9cQWxhAUuJG+e/MnYxcnCwCKhKTDqdCxLmFbCVuPDp
        MtR8eYmZl76zg9icAnYSK7a9A4sLAdU0ty9khKgXlDg58wkLyBhmAXWJ9fOEIDbJSzRvnc08
        gVFwFpKqWQhVs5BULWBkXsUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERyHWpo7GLev
        +qB3iJGJg/EQowQHs5IIb6zqyXgh3pTEyqrUovz4otKc1OJDjNIcLErivBe6gFIC6Yklqdmp
        qQWpRTBZJg5OqQYmNgOdP9wzZj44/lFFVvq0+Qoh3cXPOOLdD0w+VHvj0NkSfm7FiZzbOa8c
        1M3dt/vDB7GNU56sWbP88ZmdKxhTfDomBzfVvA7Yv8Rrw/TL66/cWTy761nutStrrV+F3p35
        Z9pb/9krmCZrP9lYpsrnHdHQVf19nuVKY/OIzB8Pnlw82Zhptz1lwzTWE2w/Zk7mFVbX7zKN
        m/LE4uhKlfyv09+dn3+gwO5I2VrlOpUuLstjUXNnPXrIcLQ5Yo76kZn/pi5wLuXuL7NTt49d
        4hHhlOs6m3/H9ckfQ35JHs41P+J/+u7BRR2JHh57Pkek3vW/mhn+euIy9iP3/mae+lrSFxj4
        Nerw0aNupseCD13+kbxTiaU4I9FQi7moOBEAprCWNDIDAAA=
X-CMS-MailID: 20201204094747epcas5p121b6eccf78a29ed4cba7c22d6b42d160
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20201204094747epcas5p121b6eccf78a29ed4cba7c22d6b42d160
References: <20201204094659.12732-1-selvakuma.s1@samsung.com>
        <CGME20201204094747epcas5p121b6eccf78a29ed4cba7c22d6b42d160@epcas5p1.samsung.com>
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
 drivers/nvme/host/core.c | 87 ++++++++++++++++++++++++++++++++++++++++
 include/linux/nvme.h     | 43 ++++++++++++++++++--
 2 files changed, 127 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9b6ebeb29cca..ff45e57223f0 100644
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
+	unsigned short nr_range = 0;
+	u16 control = 0, ssrl;
+	u32 dsmgmt = 0;
+	u64 slba;
+	int i;
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
@@ -1850,6 +1912,29 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
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
+		queue->limits.max_copy_range_sectors = 0;
+		queue->limits.max_copy_nr_ranges = 0;
+		blk_queue_flag_clear(QUEUE_FLAG_COPY, queue);
+		return;
+	}
+
+	/* setting copy limits */
+	blk_queue_flag_test_and_set(QUEUE_FLAG_COPY, queue);
+	queue->limits.max_copy_sectors = le64_to_cpu(id->mcl) *
+		(1 << (ns->lba_shift - 9));
+	queue->limits.max_copy_range_sectors = le32_to_cpu(id->mssrl) *
+		(1 << (ns->lba_shift - 9));
+	queue->limits.max_copy_nr_ranges = id->msrc + 1;
+}
+
 static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_ns *ns)
 {
 	u64 max_blocks;
@@ -2045,6 +2130,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	set_capacity_and_notify(disk, capacity);
 
 	nvme_config_discard(disk, ns);
+	nvme_config_copy(disk, ns, id);
 	nvme_config_write_zeroes(disk, ns);
 
 	if (id->nsattr & NVME_NS_ATTR_RO)
@@ -4616,6 +4702,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_download_firmware) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_format_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_dsm_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_copy_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_write_zeroes_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_abort_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_get_log_page_command) != 64);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index d92535997687..11ed72a2164d 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -289,7 +289,7 @@ struct nvme_id_ctrl {
 	__u8			nvscc;
 	__u8			nwpc;
 	__le16			acwu;
-	__u8			rsvd534[2];
+	__le16			ocfs;
 	__le32			sgls;
 	__le32			mnan;
 	__u8			rsvd544[224];
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

