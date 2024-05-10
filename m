Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DA012C48F
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715348875; cv=none; b=hCxQnV8P2iqufblVaPHRbnwkOz9NHGFTErYD3vauT0ybTSiU7tFk7Q0q0grb7GtKXlOk19mPT85UT+Zm1aqeJGVCMGt4gFV/lFeCSsPy/sO1U4zSOdW5TELsKMlh/fdXWZZ4Ag53T60yd9Oh0tLUFptzY85fE5lxoz+nrPr+TY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715348875; c=relaxed/simple;
	bh=fCY8RdSita7Wzec+OVmDbIW+QKuuAQsdD3wT5ovbvt0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=fJAdnVW53iw5agARI2PXVhlbkMF/Ga9c/V91MkDCEK3U46g7MpLvkpM6QMRo0fqA2/WQ+APFaOlfFfR+yDBvo6Ss0bxKT64Ho6CxSz6DTsrk+jhx0q602PXYW0AEQ3eqIiyy6RRzuWC931ln845A4bv+79JLOs1fegdID/phPsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uqIT4v2D; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uqIT4v2D"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240510134743epoutp039d5ba661d72b6a2ae05df1500d991578~OJLQAUc112877828778epoutp03w
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 13:47:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240510134743epoutp039d5ba661d72b6a2ae05df1500d991578~OJLQAUc112877828778epoutp03w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715348863;
	bh=2uqy5c3cXO+FBejMvjh5tS4H8j3VD4n0/AUG7aIY4I8=;
	h=From:To:Cc:Subject:Date:References:From;
	b=uqIT4v2DaIGSK56Kd9s2UbTOE+aF0niljCN61HoHue7XyMgDhbkwZldH9NKkwZ192
	 1e5y/Fq8bY2KKrIXoIzQXEmpbvCkhgs7YD/G8bMdo4+cn8N3XdAbrJ/LkuGGbB8Mi/
	 FGROWsQ9RRKaWSgvyCG5yCgx2Gy80oTfR3bDbwwg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240510134743epcas5p443098c2f5128f5a6692a5c483f4e8e6e~OJLPhwOSr0394803948epcas5p44;
	Fri, 10 May 2024 13:47:43 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VbVZ56QBjz4x9Pp; Fri, 10 May
	2024 13:47:41 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DF.59.09665.D752E366; Fri, 10 May 2024 22:47:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240510134740epcas5p24ef1c2d6e8934c1c79b01c849e7ccb41~OJLNIWKZB0383303833epcas5p26;
	Fri, 10 May 2024 13:47:40 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240510134740epsmtrp197c7b75541e85f37a0c995b847c819ca~OJLNHiKrN2682726827epsmtrp1T;
	Fri, 10 May 2024 13:47:40 +0000 (GMT)
X-AuditID: b6c32a4b-829fa700000025c1-6b-663e257d7a3a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CB.3D.08390.C752E366; Fri, 10 May 2024 22:47:40 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240510134738epsmtip18d16323614d1dcf26ce66e1ab75b4257~OJLLNwann2890228902epsmtip1E;
	Fri, 10 May 2024 13:47:38 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	javier.gonz@samsung.com, bvanassche@acm.org, david@fromorbit.com,
	slava@dubeyko.com, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>, Hui Qi <hui81.qi@samsung.com>, Nitesh Shetty
	<nj.shetty@samsung.com>
Subject: [PATCH] nvme: enable FDP support
Date: Fri, 10 May 2024 19:10:15 +0530
Message-Id: <20240510134015.29717-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmum6tql2awbYfuhar7/azWUz78JPZ
	Ysuxe4wWNw/sZLJYufook8XOZWvZLR7f+cxucfT/WzaLSYeuMVrsvaVtMX/ZU3aLbb/nM1t8
	2jKbyYHX4/IVb4+D69+weJxaJOFx+Wypx6ZVnWwem5fUe+y+2cDm0bdlFaPH501yAZxR2TYZ
	qYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QDcrKZQl5pQC
	hQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7Izbrxv
	ZCm4bVgxfeYmxgbG+RpdjJwcEgImEssuv2fqYuTiEBLYzSixe91rVgjnE6NE49EGdpAqIYFv
	jBLb++xhOi4+PsYMUbSXUeJf3wWojs+MEp/+nwKaxcHBJqApcWFyKUiDiICRxM6/r9lAapgF
	5jJJTJzygRkkIQxUs3PxIzCbRUBVYs7N7WDbeAUsJM6dus0OsU1eYual71BxQYmTM5+wgNjM
	QPHmrbPBrpAQmMghcXbrFqgGF4l9pyCGSggIS7w6DhOXknjZ3wZlJ0tcmnmOCcIukXi85yCU
	bS/ReqqfGeQBZqDj1u/Sh9jFJ9H7+wnYXxICvBIdbUIQ1YoS9yY9ZYWwxSUezlgCZXtILJrQ
	zAhSLiQQK9H1OXECo9wsJA/MQvLALIRdCxiZVzFKphYU56anFpsWGOellsOjMjk/dxMjOLFq
	ee9gfPTgg94hRiYOxkOMEhzMSiK8VTXWaUK8KYmVValF+fFFpTmpxYcYTYGhOpFZSjQ5H5ja
	80riDU0sDUzMzMxMLI3NDJXEeV+3zk0REkhPLEnNTk0tSC2C6WPi4JRqYOrbkp39veOCKP/b
	Bv+HKxn12uQ3Z8QFsphus5YIFVnruevr4wuvt/j8cXJ5/G7z8z62R2YtEezz07rMdjxJmmcq
	oDppo6Vw+4smyVkWxYtFlC66ajOp6cRfydpY7yF7bo/Q3ccSf7p5F/EV7r2822czs3fVzds/
	9/9Usntt/LWhMDCndVXG/M3ts+T4lXoVmUtm6HrrM8zKfGbndSDd//AEm+pe9oWKH7bbeizQ
	fNBit/V8/MZD98q5Q4WeX05dVZUwf1pR80u5f+bXeeysFfuMtT6eEm+xNVxsEbn/270vAc/4
	+ZJXWDywuOPTymSkIGF17UFvt81/sQZth/1q0+K75JhL3ygFPVW11zmoxFKckWioxVxUnAgA
	u1PgvTUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSnG6Nql2awYx1khar7/azWUz78JPZ
	Ysuxe4wWNw/sZLJYufook8XOZWvZLR7f+cxucfT/WzaLSYeuMVrsvaVtMX/ZU3aLbb/nM1t8
	2jKbyYHX4/IVb4+D69+weJxaJOFx+Wypx6ZVnWwem5fUe+y+2cDm0bdlFaPH501yAZxRXDYp
	qTmZZalF+nYJXBk33jeyFNw2rJg+cxNjA+N8jS5GTg4JAROJi4+PMXcxcnEICexmlHg6q4EJ
	IiEu0XztBzuELSyx8t9zdoiij4wSXZf6WbsYOTjYBDQlLkwuBakRETCT2H9uI9ggZoHlTBJb
	Zu9nBUkIA9XsXPyIGcRmEVCVmHNzO9hQXgELiXOnbkMtkJeYeek7VFxQ4uTMJywgNjNQvHnr
	bOYJjHyzkKRmIUktYGRaxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHAFaWjsY96z6
	oHeIkYmD8RCjBAezkghvVY11mhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeb697U4QE0hNLUrNT
	UwtSi2CyTBycUg1MAvWy+ZcN9vZrLMpZPfnnm8deavv722993hivknZqkXd0CQtLZO/+lthF
	bXeLX2XKFGncvj1x+XtpsRPsRplBB3Kuttt8VDl56uGNutUbvv/jSNb3srJkecm5ul41Y/6P
	J2JPZx153OF8c4lkVnPBLvaCQ2c2hZtUPJd/9pClVtfope2nnHPrG8ra58z3Vn+S7XPd2F1d
	KTm95pnrz+g1t/qY7H86eT9jmOd+NdgnIV66oe7Liu0CvIZ/q0+UX79duuNIRvwVzc7aoshb
	743OJbssucL0bMGr5msXm1bFhh1Mfnv/Bvecw7KfjjCeWhQne2vPoxTuqw9W+/HaRqfdO1ge
	LXXz7qeLLroX4gLrlFiKMxINtZiLihMBhKlfse8CAAA=
X-CMS-MailID: 20240510134740epcas5p24ef1c2d6e8934c1c79b01c849e7ccb41
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240510134740epcas5p24ef1c2d6e8934c1c79b01c849e7ccb41
References: <CGME20240510134740epcas5p24ef1c2d6e8934c1c79b01c849e7ccb41@epcas5p2.samsung.com>

Flexible Data Placement (FDP), as ratified in TP 4146a, allows the host
to control the placement of logical blocks so as to reduce the SSD WAF.

Userspace can send the data lifetime information using the write hints.
The SCSI driver (sd) can already pass this information to the SCSI
devices. This patch does the same for NVMe.

Fetches the placement-identifiers (plids) if the device supports FDP.
And map the incoming write-hints to plids.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Hui Qi <hui81.qi@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/nvme/host/core.c | 67 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  4 +++
 include/linux/nvme.h     | 19 ++++++++++++
 3 files changed, 90 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8ae0a2dc5eda..c3de06cff12f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -42,6 +42,20 @@ struct nvme_ns_info {
 	bool is_removed;
 };
 
+struct nvme_fdp_ruh_status_desc {
+	u16 pid;
+	u16 ruhid;
+	u32 earutr;
+	u64 ruamw;
+	u8  rsvd16[16];
+};
+
+struct nvme_fdp_ruh_status {
+	u8  rsvd0[14];
+	u16 nruhsd;
+	struct nvme_fdp_ruh_status_desc ruhsd[];
+};
+
 unsigned int admin_timeout = 60;
 module_param(admin_timeout, uint, 0644);
 MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin commands");
@@ -943,6 +957,16 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 	return BLK_STS_OK;
 }
 
+static inline void nvme_assign_placement_id(struct nvme_ns *ns,
+					struct request *req,
+					struct nvme_command *cmd)
+{
+	enum rw_hint h = min(ns->head->nr_plids, req->write_hint);
+
+	cmd->rw.control |= cpu_to_le16(NVME_RW_DTYPE_DPLCMT);
+	cmd->rw.dsmgmt |= cpu_to_le32(ns->head->plids[h] << 16);
+}
+
 static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		struct request *req, struct nvme_command *cmnd,
 		enum nvme_opcode op)
@@ -1058,6 +1082,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 		break;
 	case REQ_OP_WRITE:
 		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_write);
+		if (!ret && ns->head->nr_plids)
+			nvme_assign_placement_id(ns, req, cmd);
 		break;
 	case REQ_OP_ZONE_APPEND:
 		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_zone_append);
@@ -2070,6 +2096,40 @@ static int nvme_update_ns_info_generic(struct nvme_ns *ns,
 	return ret;
 }
 
+static int nvme_fetch_fdp_plids(struct nvme_ns *ns, u32 nsid)
+{
+	struct nvme_command c = {};
+	struct nvme_fdp_ruh_status *ruhs;
+	struct nvme_fdp_ruh_status_desc *ruhsd;
+	int size, ret, i;
+
+	size = sizeof(*ruhs) + NVME_MAX_PLIDS * sizeof(*ruhsd);
+	ruhs = kzalloc(size, GFP_KERNEL);
+	if (!ruhs)
+		return -ENOMEM;
+
+	c.imr.opcode = nvme_cmd_io_mgmt_recv;
+	c.imr.nsid = cpu_to_le32(nsid);
+	c.imr.mo = 0x1;
+	c.imr.numd =  cpu_to_le32((size >> 2) - 1);
+
+	ret = nvme_submit_sync_cmd(ns->queue, &c, ruhs, size);
+	if (ret)
+		goto out;
+
+	ns->head->nr_plids = le16_to_cpu(ruhs->nruhsd);
+	ns->head->nr_plids =
+		min_t(u16, ns->head->nr_plids, NVME_MAX_PLIDS);
+
+	for (i = 0; i < ns->head->nr_plids; i++) {
+		ruhsd = &ruhs->ruhsd[i];
+		ns->head->plids[i] = le16_to_cpu(ruhsd->pid);
+	}
+out:
+	kfree(ruhs);
+	return ret;
+}
+
 static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		struct nvme_ns_info *info)
 {
@@ -2157,6 +2217,13 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		if (ret && !nvme_first_scan(ns->disk))
 			goto out;
 	}
+	if (ns->ctrl->ctratt & NVME_CTRL_ATTR_FDPS) {
+		ret = nvme_fetch_fdp_plids(ns, info->nsid);
+		if (ret)
+			dev_warn(ns->ctrl->device,
+				"FDP failure status:0x%x\n", ret);
+	}
+
 
 	ret = 0;
 out:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d0ed64dc7380..67dad29fe289 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -440,6 +440,8 @@ struct nvme_ns_ids {
 	u8	csi;
 };
 
+#define NVME_MAX_PLIDS   (128)
+
 /*
  * Anchor structure for namespaces.  There is one for each namespace in a
  * NVMe subsystem that any of our controllers can see, and the namespace
@@ -457,6 +459,8 @@ struct nvme_ns_head {
 	bool			shared;
 	bool			passthru_err_log_enabled;
 	int			instance;
+	u16			nr_plids;
+	u16			plids[NVME_MAX_PLIDS];
 	struct nvme_effects_log *effects;
 	u64			nuse;
 	unsigned		ns_id;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 425573202295..fc07ba1b5ec5 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -270,6 +270,7 @@ enum nvme_ctrl_attr {
 	NVME_CTRL_ATTR_HID_128_BIT	= (1 << 0),
 	NVME_CTRL_ATTR_TBKAS		= (1 << 6),
 	NVME_CTRL_ATTR_ELBAS		= (1 << 15),
+	NVME_CTRL_ATTR_FDPS		= (1 << 19),
 };
 
 struct nvme_id_ctrl {
@@ -829,6 +830,7 @@ enum nvme_opcode {
 	nvme_cmd_resv_register	= 0x0d,
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
+	nvme_cmd_io_mgmt_recv	= 0x12,
 	nvme_cmd_resv_release	= 0x15,
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
@@ -850,6 +852,7 @@ enum nvme_opcode {
 		nvme_opcode_name(nvme_cmd_resv_register),	\
 		nvme_opcode_name(nvme_cmd_resv_report),		\
 		nvme_opcode_name(nvme_cmd_resv_acquire),	\
+		nvme_opcode_name(nvme_cmd_io_mgmt_recv),	\
 		nvme_opcode_name(nvme_cmd_resv_release),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_send),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_recv),	\
@@ -1001,6 +1004,7 @@ enum {
 	NVME_RW_PRINFO_PRCHK_GUARD	= 1 << 12,
 	NVME_RW_PRINFO_PRACT		= 1 << 13,
 	NVME_RW_DTYPE_STREAMS		= 1 << 4,
+	NVME_RW_DTYPE_DPLCMT		= 2 << 4,
 	NVME_WZ_DEAC			= 1 << 9,
 };
 
@@ -1088,6 +1092,20 @@ struct nvme_zone_mgmt_recv_cmd {
 	__le32			cdw14[2];
 };
 
+struct nvme_io_mgmt_recv_cmd {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__le64			rsvd2[2];
+	union nvme_data_ptr	dptr;
+	__u8			mo;
+	__u8			rsvd11;
+	__u16			mos;
+	__le32			numd;
+	__le32			cdw12[4];
+};
+
 enum {
 	NVME_ZRA_ZONE_REPORT		= 0,
 	NVME_ZRASF_ZONE_REPORT_ALL	= 0,
@@ -1808,6 +1826,7 @@ struct nvme_command {
 		struct nvmf_auth_receive_command auth_receive;
 		struct nvme_dbbuf dbbuf;
 		struct nvme_directive_cmd directive;
+		struct nvme_io_mgmt_recv_cmd imr;
 	};
 };
 
-- 
2.25.1

