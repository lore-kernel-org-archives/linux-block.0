Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6921122FF2B
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 22:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866682; cv=none; b=mQzQt+YYgxFLezWewSI6Qe+KzgVeZ5E1Q4eHCaKzd/xYHfW0gawFxIQ8TJL1JDN8/Ah4v5fglxk4DBZBClCcXWXOZye8EvglOxEctEp5q8wqqHx1q8G0fB7kguQ5ohaof6jhNPPVX/aknTg19ya/vht030V5dFAaJ/150dgpTlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866682; c=relaxed/simple;
	bh=MgU7Q6eB9bo6GhCtTMdVgb7hT4SO9gMlY5mSoWjdQnA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jqjlO/YTvTq99whTWTeHgOmsYOF0g1SuZwqRl0OP031MkWOk79Y5yKNKiyOGW8K+dfG0+IPNyB6VNnUIrsacM3jzVGV1/1Qp6xWx5IpsVN1DSVBsoNjVOl0wnNkQYXfSDJtaMVINjFJPcasOyI/3JmDN30jEG4tfFz4JvRuC2rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=mVz0oXk/; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="mVz0oXk/"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LMQXch002432
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 15:31:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=Sio+V6cBojGrbSouaYLC1pCKV+UnLmFhRTgPGfKJ4KA=; b=mVz0oXk/v522
	8IgduQj0CuwXf3ymOgiD3kYiNyObAM7RotjP9UImESEj1lAQ8J4AzV6eahcPzeQz
	bHsDTvlCxGxEAQ3hMUwd8MEmmVgUr2vY2kk4vY8WGiO1JR9ly/4FS/RX/jdoySl9
	ma1oypmUkVH9HB7pDyUkYBxggegVgZ6n+dRIAf40jyd5bFrnzAz3kRbdb3HYqQis
	afkDNv/Y0+lhGuo8vDEkTFg9Kbe23xrJxBDzQT14lnbSLFVIdAG3rNIzVrvAX6xR
	sbVy8yc4gNDMyHW0W/21O8UbU4SYL+2NkcoH+nt/85bjijHH2VoJHgRrF6WvlIOu
	y//hveFxJg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46rwfgkp1x-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 15:31:19 -0700 (PDT)
Received: from twshared24170.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Wed, 21 May 2025 22:31:15 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id D4CFD1BE54ACB; Wed, 21 May 2025 15:31:10 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 5/5] nvmet: implement copy support for bdev backed target
Date: Wed, 21 May 2025 15:31:07 -0700
Message-ID: <20250521223107.709131-6-kbusch@meta.com>
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
X-Proofpoint-GUID: ztkucTfhMa-Grq_w3NrcnEs_cKm3LoNR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDIyNCBTYWx0ZWRfX/ia/IM2hMZBd YDWeqpqbQ1P+kzDE8uPcx1tJQRLBL9tqhp0YBs4Gs18Y45YHpISHxk99EXBdEKXcI722twsdy9y fa3kPPON2+q8/nXa75a6rGGG5SsppZAt1s5X6wuAH14gNojmpmo1Lzmc3viXWjL/48gDeMVw4HW
 sNfNuHIp55T1Cn7GLbFSi7roxbFm3VM84XLRCAFs2pj1DseXeO4NMEUvy5+ZMxZCC7ptCKwpVr+ wUzm7D5d5BvlpaKbKtoZtJOlAInRQiuQFjkf5wG5Rj+pV9ursrKHHPTiPxmWZSCYI1N85t1Vvf+ zG9jiMHhCTx5ETv/bz+fjfzLExXoaHHpcLXZ+6AjK0zeK61ide5A5ezhtkFeRPxEutbThV6GyDe
 CNbImkVeQI/7XTpM1NhQE46B6l0UUF7V9TlMq736pWvtVxUIjQSMm9t5hdIOkVpxqZWF3q4i
X-Authority-Analysis: v=2.4 cv=I9BlRMgg c=1 sm=1 tr=0 ts=682e5437 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=pyVl64N4sFQ6-zCv_koA:9
X-Proofpoint-ORIG-GUID: ztkucTfhMa-Grq_w3NrcnEs_cKm3LoNR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_07,2025-05-20_03,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

The nvme block device target type does not have any particular limits on
copy commands, so all the settings are the protocol's max.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/io-cmd-bdev.c | 52 +++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-c=
md-bdev.c
index 83be0657e6df4..d90dedcd2352f 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -46,6 +46,11 @@ void nvmet_bdev_set_limits(struct block_device *bdev, =
struct nvme_id_ns *id)
 	id->npda =3D id->npdg;
 	/* NOWS =3D Namespace Optimal Write Size */
 	id->nows =3D to0based(bdev_io_opt(bdev) / bdev_logical_block_size(bdev)=
);
+
+	/* Copy offload support */
+	id->mssrl =3D cpu_to_le16(U16_MAX);
+	id->mcl =3D cpu_to_le32(U32_MAX);
+	id->msrc =3D U8_MAX;
 }
=20
 void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
@@ -412,6 +417,50 @@ static void nvmet_bdev_execute_discard(struct nvmet_=
req *req)
 	}
 }
=20
+static void nvmet_bdev_execute_copy(struct nvmet_req *req)
+{
+	struct bio_vec *bv, fast_bv[UIO_FASTIOV];
+	struct nvme_copy_range range;
+	u64 dst_sector, slba;
+	u16 status, nlb, nr;
+	int ret, i;
+
+	nr =3D req->cmd->copy.nr_range + 1;
+	if (nr <=3D UIO_FASTIOV) {
+		bv =3D fast_bv;
+	} else {
+		bv =3D kmalloc_array(nr, sizeof(*bv), GFP_KERNEL);
+		if (!bv) {
+			status =3D NVME_SC_INTERNAL;
+			goto done;
+		}
+	}
+
+	for (i =3D 0; i < nr; i++) {
+		status =3D nvmet_copy_from_sgl(req, i * sizeof(range), &range,
+				sizeof(range));
+		if (status)
+			goto done;
+
+		slba =3D le64_to_cpu(range.slba);
+		nlb =3D le16_to_cpu(range.nlb) + 1;
+		bv[i].bv_sector =3D nvmet_lba_to_sect(req->ns, slba);
+		bv[i].bv_sectors =3D nvmet_lba_to_sect(req->ns, nlb);
+	}
+
+	dst_sector =3D nvmet_lba_to_sect(req->ns, req->cmd->copy.sdlba);
+	ret =3D blkdev_copy_range(req->ns->bdev, dst_sector, bv, nr, GFP_KERNEL=
);
+	if (ret) {
+		req->error_slba =3D le64_to_cpu(dst_sector);
+		status =3D errno_to_nvme_status(req, ret);
+	} else
+		status =3D NVME_SC_SUCCESS;
+done:
+	nvmet_req_complete(req, status);
+	if (bv !=3D fast_bv)
+		kfree(bv);
+}
+
 static void nvmet_bdev_execute_dsm(struct nvmet_req *req)
 {
 	if (!nvmet_check_data_len_lte(req, nvmet_dsm_len(req)))
@@ -474,6 +523,9 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_write_zeroes:
 		req->execute =3D nvmet_bdev_execute_write_zeroes;
 		return 0;
+	case nvme_cmd_copy:
+		req->execute =3D nvmet_bdev_execute_copy;
+		return 0;
 	default:
 		return nvmet_report_invalid_opcode(req);
 	}
--=20
2.47.1

