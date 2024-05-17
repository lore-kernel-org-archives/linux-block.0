Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D492384;
	Fri, 17 May 2024 00:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715904912; cv=none; b=oM65GNKQf4qWSFxWn9INzaN+JpzNxK5P39sVzPnRQgTbDcpc6TA0AJdd1a1ck5ruvJUkQjR0/OhKigdPAmtqy9P4z3U0vPyfnyGjJzyvf++fxmFubbJF7YqW6UPc6StWdueyEdoF1CFtbaQcDSZbvlz4ftJhnH5M319ezEhNmUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715904912; c=relaxed/simple;
	bh=dzbgQ5kXyuHHf4Rd7qLE/b09hD4yvr4dEoyuhrsPzVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=EubvB8BINfEF1yn1IzI7IsVoLw79tFVREhGGgOpKYslUC6wISgUj09h2tQWAjtmrQ3X2/W33/fp+wPOdMWxob1yrlilQUxefd63UzJTa+Q2tNkKd4aY1yNSy1qbc/UtSleKRp2gm2DKOn2T/RWQozgsB6fpg1kfNHQMauYUO5tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZB2JBlYb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZB2JBlYb"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44GKMkK7026066;
	Fri, 17 May 2024 00:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=ufL
	JAlLwiwPO4sBKjV4HGy1rzUArJknphO+UyQ1kH+o=; b=ZB2JBlYbQ26TOBk9xY4
	LfxcTrcfGzzulMvXaXo//8J+EjhNr3SFueFgIESLUpigJD/Z5Qab4rp23Y98mSrH
	IR1fhOPZIqRCBRDulwbJaLYUkZZ0Bxuu3m5UShhcnqlBsEKqEmygNCdNp8NVGMpY
	orA8VY4EE0xKAsz6wIbdv7IqtnYK94rMnu+PkpR9L5x+Rcz7ANB3vyfm3bokIdkV
	2sKrZ0er9pqXGxtpBCbY1V0xRpqqpojZJ99REJoQC/ysz5R8lY9XWXUi/7GuMoyT
	G+GoSVz+L12g0uJ9xeIhxTxso4+HclRf25rR1m9QgGGradoaoIyOJ2s/eNvXDoOy
	rGw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y49ft6kj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 00:15:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44H0F7RU023975
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 00:15:07 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 16 May
 2024 17:15:06 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 16 May 2024 17:15:06 -0700
Subject: [PATCH] block: t10-pi: add MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240516-md-t10-pi-v1-1-44a3469374aa@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAImhRmYC/x3MQQqDMBBA0avIrDuQmNiFVyldJGZSBzSVGRVBv
 Ltplw8+/wQlYVLomxOEdlb+lgr7aGAYQ/kQcqqG1rTedPaJc8LVGlwYXXbe+S6bmCzUfhHKfPx
 fr3d1DEoYJZRh/B0mLtuBc9CVBK7rBpZOnN16AAAA
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 10z5FL1NFhkZBSFm2QCJcxmWTBVYKlO9
X-Proofpoint-GUID: 10z5FL1NFhkZBSFm2QCJcxmWTBVYKlO9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 mlxlogscore=834 mlxscore=0 clxscore=1011 phishscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405170000

Fix the allmodconfig 'make W=1' issue:

WARNING: modpost: missing MODULE_DESCRIPTION() in block/t10-pi.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 block/t10-pi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index d90892fd6f2a..f4cc91156da1 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -495,5 +495,5 @@ const struct blk_integrity_profile ext_pi_type3_crc64 = {
 };
 EXPORT_SYMBOL_GPL(ext_pi_type3_crc64);
 
-MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("T10 Protection Information module");
 MODULE_LICENSE("GPL");

---
base-commit: 8c06da67d0bd3139a97f301b4aa9c482b9d4f29e
change-id: 20240516-md-t10-pi-3f34345f0bd1

