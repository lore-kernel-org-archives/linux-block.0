Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1447262B6;
	Sun,  2 Jun 2024 23:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717372003; cv=none; b=GDuFOui+my9mfnl2aSWGI0I6NqzgPEYNH9T1eZ0oZUQLS2dsGnVxeHcuYsqunltTGe4t4i394uLEYazvrYnHlJo3SSB7G2ws46DO1pqbSM3BMn+46hyZs/8x57X8NmBFt499KTbIgck7uprQm0jzsrkcZWX+d2QOkEWXB9oOxEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717372003; c=relaxed/simple;
	bh=+AVY8B406UA3Sr2AeXmjZg3eG/SM31mhuFjExpBndOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=GspmxeaFe0dAcbmdkFuBPJYIoDsi2Zr77tXIhqhj9sqUNJLxFXzegW8f7i0pIaGvc/VUt5X7IfUKzMqqIxeaj6VtzeeiMFHh4XkW3+dIYtlsortOEe3y55kna29Ncm9gxZUM6XIoODC8N45MvIb/BKNYWzQyPYQdV47ec39oCb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hy1dzwrx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hy1dzwrx"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 452LjQWw019693;
	Sun, 2 Jun 2024 23:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qMSKmHzTNfqaAlTk93UL3e
	Iha71pItJolPFNbiTHD+c=; b=hy1dzwrxRxkuhr1MUYqhxJHzGrs9CcMClcrHAc
	96tBn3BD7KNrWzorlfReqY8yLN/OHQBf5lLHJP+KbqDwa5txq0z5LHv/+4EA5LqY
	/rN2y7abw7JUP5YxNBVX4a1hR+seE/kg9MKzi7ivoT8qKeYcaTGud4lXIa+7bcWM
	bXvUGEOTlBnlcgYi2i7EPqpGJWHTo8UZm83p0rFRBt/4XZrijvwvG3dPQK/aAyrS
	82WoIuDn+0vh4gFZ8zf6cJvUMf5J4UuTDBNh59UqXdcQjvY1xnjSd+Pb4dgICCGc
	9OcYuOYTuOlsMe1kCMmh1WQ3ap1U1FX/M7Bb3Shr7uEsTqOw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw5wjk79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Jun 2024 23:46:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 452NkWjn017158
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 2 Jun 2024 23:46:32 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 2 Jun 2024
 16:46:25 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sun, 2 Jun 2024 16:46:25 -0700
Subject: [PATCH] brd: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240602-md-block-brd-v1-1-e71338e131b6@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAFAEXWYC/x3MywrCQAyF4VcpWRsYh1ovryJdZGaiDbZTSVQKp
 e9udPnBOf8KxipscGlWUP6IyVwd+10DeaB6Z5TihhhiG7oQcSqYxjk/MGlBbimfzt3hSJHAL0/
 lmyz/3LV3JzL2IdU8/CKj1PeCE9mLFbbtC8u0lYh9AAAA
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WTJvNnTsNT_634DVFL4EkwRVN1HKr2YH
X-Proofpoint-ORIG-GUID: WTJvNnTsNT_634DVFL4EkwRVN1HKr2YH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_15,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406020208

make allmodconfig && make W=1 C=1 reports:
modpost: missing MODULE_DESCRIPTION() in drivers/block/brd.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/block/brd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 558d8e670566..3fb2f37ab893 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -296,6 +296,7 @@ static int max_part = 1;
 module_param(max_part, int, 0444);
 MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");
 
+MODULE_DESCRIPTION("Ram backed block device driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(RAMDISK_MAJOR);
 MODULE_ALIAS("rd");

---
base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
change-id: 20240602-md-block-brd-e4ac89657a2a

