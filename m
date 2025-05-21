Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FE322FF2B
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 22:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866679; cv=none; b=BQFrsozw6AYHzN2e2cG2dBAwpFiEoz43TW6RGuf4zGj4sAo4gZMwZaDoxp0NNswqIb7fVNeJk3cteN4IuTbFG/SwHWBkRFzb1nMm7URKlGFMoze0PFFSKJKLJ6PVgYeuyFO9IQpd5D7UpNFtXhF7c+FEye+nSY9Ln/1XLmnUVls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866679; c=relaxed/simple;
	bh=lhKWA84o6gMu4gpdx2PiQQtOgJIMkDzMFso6RzGXANE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtYUqp75VHi3WP7cS7OJ0KFl9IchMr+1MmnFJfIKFrUn591IVQOs64ETrzWiRKxQ31HvllQdxHlmKV+JWoQibyEX2FcSWGeE3oXCpqj6oB9vZZNdXWzvxStDq5rTUExYK7HDyYSuRy05xJ3Jcy+0noevONTp3NjmRQo+TE6PqVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=i9qHI8l6; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="i9qHI8l6"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LMQXcc002432
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 15:31:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=ADIhLn5VjOQ+8E1c0cuERM2aLwK/zTifB7KESawKdy8=; b=i9qHI8l6y+pr
	L+zPY33Q6cmW3arDE8EVR/aZ2/3buDK33u3rV8zlKbrYuf19xe0tdWcqLZbRFI7c
	agYN7PF4vXO+p9BlTsH4pLFKuQFqVBF3yvbhXVlCepqP0yH2A054jR6QoGqd5aLB
	pMyICemL0pHI55/nyKBMEZoBZP5z8edPAMG10uf2RnAbq0tOBPhjYHfStLexcaOM
	VmPqNFo9u+74sXsqPUV0WBTWM6kCZDWjLtLb35x0mT7HEIeUqg1JRpYsNzEr4boZ
	7zmI7SGRoVAFUxzdr/2oLn0VBqE5JWs5+1bF7us8D0tTMpN6SS7p9yY82TFM2qiW
	92nYUj35gg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46rwfgkp1x-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 15:31:17 -0700 (PDT)
Received: from twshared24170.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Wed, 21 May 2025 22:31:14 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id B02F21BE54AC7; Wed, 21 May 2025 15:31:10 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 3/5] nvme: add support for copy offload
Date: Wed, 21 May 2025 15:31:05 -0700
Message-ID: <20250521223107.709131-4-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250521223107.709131-1-kbusch@meta.com>
References: <20250521223107.709131-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: SxCk4xmaQBUpEInTk9gCJbxWbOjeSdth
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDIyNCBTYWx0ZWRfX/l0cVcJcvgaI OkMAgPqRF8/00T/YI5tpxVLrXsPQl66gvuwms49KgQLo72ufyoazVXdqWd9Z/laZ67gb6XNbFbN R+Z/A253Io5zzYUhtPTslPbSdwpNqn2jcDE0KkbHbEB1E/OK/SX4mzRWU/X2q3R211pXAHbqJt9
 tBhTPGWUROtJhryHJkJucD94viVgPKdJWq6n1/h3BJwu0B2UClAp+IWgyWvCR9SYnCFEhnUE0Ye eOFxpoF7+V6r1lhymbvgPYvSnYd74GmFIqMbvtHG4iGJQx2yeK5Caca110P73AGQF7qm93+S3at 6E9gm3hwLwIOv2Tw0Em7lzBv19ZaA7izNgWTQnhmLd9rPO6Ivl177aA+xwpW/xPzu9IrMaBL3Xf
 PoATZhgp9NLDeZw6glA5D+3vxLv/5/TpYhmwnw1jRRCkR0ktRePPX8ktEExCRVFIbwAdzcuO
X-Authority-Analysis: v=2.4 cv=I9BlRMgg c=1 sm=1 tr=0 ts=682e5435 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=p-wV8MGqm0ydJg34uK0A:9
X-Proofpoint-ORIG-GUID: SxCk4xmaQBUpEInTk9gCJbxWbOjeSdth
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_07,2025-05-20_03,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Register the nvme namespace copy capablities with the request_queue
limits and implement support for the REQ_OP_COPY operation.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 61 ++++++++++++++++++++++++++++++++++++++++
 include/linux/nvme.h     | 42 ++++++++++++++++++++++++++-
 2 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f69a232a000ac..3134fe85b1abc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -888,6 +888,52 @@ static blk_status_t nvme_setup_discard(struct nvme_n=
s *ns, struct request *req,
 	return BLK_STS_OK;
 }
=20
+static inline blk_status_t nvme_setup_copy(struct nvme_ns *ns,
+		struct request *req, struct nvme_command *cmnd)
+{
+	struct nvme_copy_range *range;
+	struct req_iterator iter;
+	struct bio_vec bvec;
+	u16 control =3D 0;
+	int i =3D 0;
+
+	static const size_t alloc_size =3D sizeof(*range) * NVME_COPY_MAX_RANGE=
S;
+
+	if (WARN_ON_ONCE(blk_rq_nr_phys_segments(req) >=3D NVME_COPY_MAX_RANGES=
))
+		return BLK_STS_IOERR;
+
+	range =3D kzalloc(alloc_size, GFP_ATOMIC | __GFP_NOWARN);
+	if (!range)
+		return BLK_STS_RESOURCE;
+
+	if (req->cmd_flags & REQ_FUA)
+	        control |=3D NVME_RW_FUA;
+	if (req->cmd_flags & REQ_FAILFAST_DEV)
+	        control |=3D NVME_RW_LR;
+
+	rq_for_each_copy_bvec(bvec, req, iter) {
+		u64 slba =3D nvme_sect_to_lba(ns->head, bvec.bv_sector);
+		u64 nlb =3D nvme_sect_to_lba(ns->head, bvec.bv_sectors) - 1;
+
+		range[i].slba =3D cpu_to_le64(slba);
+		range[i].nlb =3D cpu_to_le16(nlb);
+	        i++;
+	}
+
+	memset(cmnd, 0, sizeof(*cmnd));
+	cmnd->copy.opcode =3D nvme_cmd_copy;
+	cmnd->copy.nsid =3D cpu_to_le32(ns->head->ns_id);
+	cmnd->copy.nr_range =3D i - 1;
+	cmnd->copy.sdlba =3D cpu_to_le64(nvme_sect_to_lba(ns->head,
+						blk_rq_pos(req)));
+	cmnd->copy.control =3D cpu_to_le16(control);
+
+	bvec_set_virt(&req->special_vec, range, alloc_size);
+	req->rq_flags |=3D RQF_SPECIAL_PAYLOAD;
+
+	return BLK_STS_OK;
+}
+
 static void nvme_set_app_tag(struct request *req, struct nvme_command *c=
mnd)
 {
 	cmnd->rw.lbat =3D cpu_to_le16(bio_integrity(req->bio)->app_tag);
@@ -1106,6 +1152,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, str=
uct request *req)
 	case REQ_OP_DISCARD:
 		ret =3D nvme_setup_discard(ns, req, cmd);
 		break;
+	case REQ_OP_COPY:
+		ret =3D nvme_setup_copy(ns, req, cmd);
+		break;
 	case REQ_OP_READ:
 		ret =3D nvme_setup_rw(ns, req, cmd, nvme_cmd_read);
 		break;
@@ -2119,6 +2168,15 @@ static bool nvme_update_disk_info(struct nvme_ns *=
ns, struct nvme_id_ns *id,
 		lim->max_write_zeroes_sectors =3D UINT_MAX;
 	else
 		lim->max_write_zeroes_sectors =3D ns->ctrl->max_zeroes_sectors;
+
+	if (ns->ctrl->oncs & NVME_CTRL_ONCS_NVMCPYS && id->mssrl && id->mcl) {
+		u32 mcss =3D bs * le16_to_cpu(id->mssrl) >> SECTOR_SHIFT;
+		u32 mcs =3D bs * le32_to_cpu(id->mcl) >> SECTOR_SHIFT;
+
+		lim->max_copy_segment_sectors =3D mcss;
+		lim->max_copy_sectors =3D mcs;
+		lim->max_copy_segments =3D id->msrc + 1;
+	}
 	return valid;
 }
=20
@@ -2526,6 +2584,9 @@ static int nvme_update_ns_info(struct nvme_ns *ns, =
struct nvme_ns_info *info)
 			nvme_init_integrity(ns->head, &lim, info);
 		lim.max_write_streams =3D ns_lim->max_write_streams;
 		lim.write_stream_granularity =3D ns_lim->write_stream_granularity;
+		lim.max_copy_segment_sectors =3D ns_lim->max_copy_segment_sectors;
+		lim.max_copy_sectors =3D ns_lim->max_copy_sectors;
+		lim.max_copy_segments =3D ns_lim->max_copy_segments;
 		ret =3D queue_limits_commit_update(ns->head->disk->queue, &lim);
=20
 		set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 51308f65b72fd..14f46ad1330b6 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -404,6 +404,7 @@ enum {
 	NVME_CTRL_ONCS_WRITE_ZEROES		=3D 1 << 3,
 	NVME_CTRL_ONCS_RESERVATIONS		=3D 1 << 5,
 	NVME_CTRL_ONCS_TIMESTAMP		=3D 1 << 6,
+	NVME_CTRL_ONCS_NVMCPYS                  =3D 1 << 8,
 	NVME_CTRL_VWC_PRESENT			=3D 1 << 0,
 	NVME_CTRL_OACS_SEC_SUPP                 =3D 1 << 0,
 	NVME_CTRL_OACS_NS_MNGT_SUPP		=3D 1 << 3,
@@ -458,7 +459,10 @@ struct nvme_id_ns {
 	__le16			npdg;
 	__le16			npda;
 	__le16			nows;
-	__u8			rsvd74[18];
+	__le16			mssrl;
+	__le32			mcl;
+	__u8			msrc;
+	__u8			rsvd81[11];
 	__le32			anagrpid;
 	__u8			rsvd96[3];
 	__u8			nsattr;
@@ -956,6 +960,7 @@ enum nvme_opcode {
 	nvme_cmd_resv_acquire	=3D 0x11,
 	nvme_cmd_io_mgmt_recv	=3D 0x12,
 	nvme_cmd_resv_release	=3D 0x15,
+	nvme_cmd_copy		=3D 0x19,
 	nvme_cmd_zone_mgmt_send	=3D 0x79,
 	nvme_cmd_zone_mgmt_recv	=3D 0x7a,
 	nvme_cmd_zone_append	=3D 0x7d,
@@ -978,6 +983,7 @@ enum nvme_opcode {
 		nvme_opcode_name(nvme_cmd_resv_acquire),	\
 		nvme_opcode_name(nvme_cmd_io_mgmt_recv),	\
 		nvme_opcode_name(nvme_cmd_resv_release),	\
+		nvme_opcode_name(nvme_cmd_copy),		\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_send),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_recv),	\
 		nvme_opcode_name(nvme_cmd_zone_append))
@@ -1158,6 +1164,39 @@ struct nvme_dsm_range {
 	__le64			slba;
 };
=20
+struct nvme_copy_cmd {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u64			rsvd2;
+	__le64			metadata;
+	union nvme_data_ptr	dptr;
+	__le64			sdlba;
+	__u8			nr_range;
+	__u8			format;
+	__le16			control;
+	__le16			cev;
+	__le16			dspec;
+	__le32			lbtl;
+	__le16			lbat;
+	__le16			lbatm;
+};
+
+#define NVME_COPY_MAX_RANGES   128
+struct nvme_copy_range {
+	__le32			spars;
+	__u32			rsvd4;
+	__le64			slba;
+	__le16			nlb;
+	__le16			cetype;
+	__le16			cev;
+	__le16			sopt;
+	__le32			elbt;
+	__le16			elbat;
+	__le16			elbatm;
+};
+
 struct nvme_write_zeroes_cmd {
 	__u8			opcode;
 	__u8			flags;
@@ -1985,6 +2024,7 @@ struct nvme_command {
 		struct nvme_download_firmware dlfw;
 		struct nvme_format_cmd format;
 		struct nvme_dsm_cmd dsm;
+		struct nvme_copy_cmd copy;
 		struct nvme_write_zeroes_cmd write_zeroes;
 		struct nvme_zone_mgmt_send_cmd zms;
 		struct nvme_zone_mgmt_recv_cmd zmr;
--=20
2.47.1

