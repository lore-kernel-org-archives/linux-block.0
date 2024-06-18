Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6146D26A;
	Tue, 18 Jun 2024 01:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718673225; cv=none; b=YeH0xWYphpT8nhqhOM2s7/ewYt8fKLaS/JwbKlHDQCNaIoyLM1Hcz5lLivTPshTba65CrJfWgwRsKrMOBVWxvE+4BHJQxJjXBusYT4Xfojded6lSANeZv6baSqhrxr3jVaaG/g+P55s0grfwQvy8joZFVD8UiVCuSq3zRQDiiFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718673225; c=relaxed/simple;
	bh=lTBHItdimrrXStpZI2RRe0UXgRMIc4xH+pNaE3Qlr34=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=HzoaeCDK35UMnswUmZ/FNl6s2M0IzA/2tUUlcBUvhTfEdcq7/KbN7yUKpaZWFnDT4qR/xLG6c52zSW3TwzYDOtKcNgl1A/94rUMIHi6u/9Q9H4L7tIrJ+9FBrd3ZCzFPmbWzKbrQBPQOS9tB8uiz/M7aOKaBzqFazp8iew1Bwjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AZvk7yQW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AZvk7yQW"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HI3c69005285;
	Tue, 18 Jun 2024 01:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=gkZix0uFGvyywJejXmC0Rt
	osMBKtHuAiIH57oqbGfPE=; b=AZvk7yQWInkf0BQTJB5jn26kaVkp8pixlKSi79
	tRWjYDdHUSWhlZKv3PIyeOV4ZVZu/zikeZVcU4kd+MsKyB2sISjhvlarp/eu6v79
	fdwIV4ldNA+YIbUtBxXgM+kxkr+td/MW7dtV4T9p131w10cPVeIUZ5BP0voV5hVU
	f9xqftnBPMCVCC8wGGy9jl3T0acTfMRCpHPKbL2DuEv5QJwqnbtW/yHdFX3qAa5G
	ZlG6dSJijKOAVjzNGnQzUIY+TZj8SvKw04axnMxKLmHCYiwNxE5sSc3zo37JtCv/
	xGh57gneMsnss6suJA6nb5OvmfVwuuIxW7bayrdGDUWgvFKg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ytt378s1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 01:13:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45I1DdhO028892
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 01:13:39 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 18:13:39 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH 0/3] block: m68k: add missing MODULE_DESCRIPTION() macros
Date: Mon, 17 Jun 2024 18:13:31 -0700
Message-ID: <20240617-md-m68k-drivers-block-v1-0-b200599a315e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADvfcGYC/x3MSQ6DMAxA0asgr2spoVE6XKVikcEUCwiV3SIkx
 N2bdvkW/++gJEwK92YHoZWVl1JhTw2kIZQnIedqaE3rjLcXnDPO/jpiFl5JFOO0pBGdT2djo/O
 9u0FtX0I9b//vo6uOQQmjhJKG323i8tlwDvomgeP4Aqv8eMKGAAAA
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qDUtHXHYVvWY135Db-3SKqQGaQA4q0Hg
X-Proofpoint-GUID: qDUtHXHYVvWY135Db-3SKqQGaQA4q0Hg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=790 adultscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180006

With ARCH=m68k, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/amiflop.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/ataflop.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/z2ram.o

Since these have traditionally had different commit prefixes, I
submitted individual patches. Let me know if you want me to squash
them.

In addition, drivers/block/swim3.c is also missing a
MODULE_DESCRIPTION(), but I haven't yet actually triggered the
warning. I need to customize a PPC configuration which enables
MAC_FLOPPY in order to trigger the warning and verify the fix.

I'll get around to that when I finish the remaining m68k issues.

---
Jeff Johnson (3):
      amiflop: add missing MODULE_DESCRIPTION() macro
      ataflop: add missing MODULE_DESCRIPTION() macro
      z2ram: add missing MODULE_DESCRIPTION() macro

 drivers/block/amiflop.c | 1 +
 drivers/block/ataflop.c | 1 +
 drivers/block/z2ram.c   | 1 +
 3 files changed, 3 insertions(+)
---
base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
change-id: 20240617-md-m68k-drivers-block-46c301b46f49

