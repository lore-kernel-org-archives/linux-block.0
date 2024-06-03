Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A08A19E;
	Mon,  3 Jun 2024 00:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717373138; cv=none; b=Wh6UFn3wxjbztUlERtzC1Ujn5lO4PACJlmQZsyfVUmhe5bjfFnwVcypehbaamFOX/X60od+MZdUDEtifUxxewvy+AXr2J3X/HLlaRFxvJ7xibvwezleEo2+FZDTX7De8uyqjwe6GK6O1o8OOO1F8gzPr9B2caRleSJKuz4fOo+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717373138; c=relaxed/simple;
	bh=zy1trVZNXdzSYKGFjksmzJXN/QGq0Sj95jtxuW3Bblc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=FGmmYSkknmqlArf9FtYqkZOI6JCZXUONjgRc91VOVaLynbEUhevHom4kPFC8u80gSP7PM611WjRm9LzupRNLvggCs2/y7v2/ngip6zWM1/GH8LPFSMH7s/aG+a+8ZTc//OxgBWvhhydUZ+UP9MaIqQT8ulT1/FdTiVM+wVozSMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oiQouVkv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oiQouVkv"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 452Np6bX026166;
	Mon, 3 Jun 2024 00:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=e1fRDQ19gGIsI4uZjga8MO
	ag9mx43TrLxWHagrL2+Oc=; b=oiQouVkvC1uiW8lu8wLf/lEVngYqY9vmd9PBnb
	sO5KDXEb2gi4o8IJDtN0oV2DUZ986beUpQeSUA5gFrXE9uCC+1uyTOrp2e7bz88n
	DTvpZbx2jzgtKPqHUuYe7kw+iFIhSvwwuCQqjceHyIL0FJrdwh/KzFamCu6OF8Xo
	bhe+jbBwg01tvyht/z9O7A13iP5RVLu59E6ONq+JiTkyIX5nE4/N4rmoTQLYGN7B
	Hc7aqbbgHpRXLAkBOaLUvm0CH9omk2/ge9je0a4QN2ojLI3DGOqHZeHC7VmY2kpR
	dZKe2QZyHVOLsLY10XlUm9NMbsSh0EqOe1HBhkbk0fBgcSvQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw6qjm0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 00:05:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 45305WJo030020
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 00:05:32 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 2 Jun 2024
 17:05:31 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sun, 2 Jun 2024 17:05:31 -0700
Subject: [PATCH] floppy: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240602-md-block-floppy-v1-1-bc628ea5eb84@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAMoIXWYC/x3MTQ7CIBBA4as0s3YSwNa/qzQugE7tRApkUFPT9
 O5Fl9/ivRUKCVOBW7OC0IcLp1ihDw34ycYHIQ/VYJRp1UkZnAd0IfknjiHl/EV9vbRan4+dIg+
 1ykIjL/9jf692thA6sdFPv0/g+F5wtuVFAtu2A8kF3tuAAAAA
To: Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GQmSe479sB2skAGlDyFgRaaaZbsc3AQn
X-Proofpoint-ORIG-GUID: GQmSe479sB2skAGlDyFgRaaaZbsc3AQn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_15,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=929 clxscore=1011 impostorscore=0 malwarescore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406020211

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/floppy.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/block/floppy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 25c9d85667f1..854a88cf56bd 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -5016,6 +5016,7 @@ module_param(floppy, charp, 0);
 module_param(FLOPPY_IRQ, int, 0);
 module_param(FLOPPY_DMA, int, 0);
 MODULE_AUTHOR("Alain L. Knaff");
+MODULE_DESCRIPTION("Normal floppy disk support");
 MODULE_LICENSE("GPL");
 
 /* This doesn't actually get used other than for module information */

---
base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
change-id: 20240602-md-block-floppy-1984117350ec

