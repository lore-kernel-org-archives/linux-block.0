Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E58DDA0;
	Tue, 18 Jun 2024 01:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718673225; cv=none; b=slFn2m93/lpT3aHX2okmJKPO0Tr1MiV7phUJigiwrwwqQlobU9fS+w0ZddD3jd0zDAr4CZTsR54ukDsIRo4Krlo+xsbnw3+/tUXFWN2A/BxMR5QGoyXtgRLwHJtdyh6iDimHiRCVM3uIxhBFkEubCTUnLD0PoiS86fD4CviU8kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718673225; c=relaxed/simple;
	bh=b2fRG19qqYAJR8tGqpGt/GCuiT1ld5ecMgMD2XMnBNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=o59nmCQEBBmWTK+Y0sJGfdZagtt6yLk9Khp1jHJUzcSD2Qmb8ScBto4T//fj9UpawCUntbse2OhQEIDN5Zfhk2HME+ielyHKlTZc+fTkAq0Z6b4dWx/zCIpkz/u7cH5/bjucHuBku3Dgjbheh4DXgJ5CAWMCekrJDpm+IpZN1XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NRVinaYW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NRVinaYW"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HLgmoL029690;
	Tue, 18 Jun 2024 01:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mRMOJSM2kNvOpnLEYDjtJLEIfxdj7gvZZZs0Lfx3oNM=; b=NRVinaYW4ZzziHne
	CvE4TvPwbXWgIBJ/lZ1Or2qYO/sWU9WWKOynYRDwP/49JNdxQfuYuJQH8edQyQrx
	Ig+qoLm0y4+uorEHPBALz1cWLlvAu2aGoJfV1O0aanYJ/5i3xVwIwukg8SOMt+RW
	vRgrHt1qenEClDdUzKkUP1FEyHGW+Yspu1L9TPsW6vHz3h/fMSxDItmVei476Ho5
	tCfVB0CbCewSl9Hdkk4kI/qrXx/cHU9e7Bb2aqFIB9fXsUXVt2AdrOqYXHHqJj+q
	hSYrwSU1NONTF0Z2wRh8D3AixVFNjvbNzrv2gSaEWR5rWnAGEgalRtpyWqOs63Z0
	ELyA+A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ytwa2g8wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 01:13:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45I1DfvP010412
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 01:13:41 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 18:13:40 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 17 Jun 2024 18:13:34 -0700
Subject: [PATCH 3/3] z2ram: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-md-m68k-drivers-block-v1-3-b200599a315e@quicinc.com>
References: <20240617-md-m68k-drivers-block-v1-0-b200599a315e@quicinc.com>
In-Reply-To: <20240617-md-m68k-drivers-block-v1-0-b200599a315e@quicinc.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: J8FZHS90MhE6C4cOE55eP_0IBh_nq-bv
X-Proofpoint-ORIG-GUID: J8FZHS90MhE6C4cOE55eP_0IBh_nq-bv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=944 bulkscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180007

With ARCH=m68k, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/z2ram.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/block/z2ram.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index 7c5f4e4d9b50..4b7219be1bb8 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -409,4 +409,5 @@ static void __exit z2_exit(void)
 
 module_init(z2_init);
 module_exit(z2_exit);
+MODULE_DESCRIPTION("Amiga Zorro II ramdisk driver");
 MODULE_LICENSE("GPL");

-- 
2.42.0

