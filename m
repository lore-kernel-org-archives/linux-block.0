Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491C5D53C;
	Tue, 18 Jun 2024 01:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718673224; cv=none; b=dKw3MVSXKcwmSYqcd9UEKjft7/5FdjhLSuEJcA+zz/bS4Zc0dnTZNgl41fDICLp2n27pzerd7Tmmlve6On5TUkq21u5AF1xOEdJQNpCx4Qh7oTjmb+M4ZhCNWsH6nI+bSWdiNbi9VG3gyLbsBTZf/zJikLIpgCSQGj6kB4ksHz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718673224; c=relaxed/simple;
	bh=2q3KjrCveYm7zEelzeBNGmH4NznY5hnROPKn5O0Sjlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eOmlyQ5yrMz8c3DranTYVp02PqMPts87grkByIwzXlTCKzxIfrfv28mla7mcY3pZhoHfLojuKVC0Qth9UNS+9xlCbbCh6Tgo0jkSiLrG/kQjR4kjcN6IvHamvQNgwXuGa24e+63bJDgbEP6HsmfV193+3B8pnG2b/lIizBE7XSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Yk20lOlc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Yk20lOlc"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HI3G3N004485;
	Tue, 18 Jun 2024 01:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NSXKdxQJFkfKTfEH1eJ6aJ8NtLIKvt7cXSYsObEwAyU=; b=Yk20lOlchs4LeOo2
	uFctuwZEKcTDhMCiDDUlreaVtc4gkBR0LZqaBhi8aWlOTjNLHmQj0nsAgUUIB+Ak
	FQQtcuZxqzR2gMFVPVu2Zb683QqLk7EPqwCyQzcyrlGn3SHqqFikCkvsZ+hay9sY
	awv8JQM5ixd+xsuSjMzOUZS4G2jhBAlUPjCn1N0PhUxt9D4Uo6TDwRQm9fCsccNg
	xk8D1Tl9fc8QJZegwRZHOaP3j8aw4hBX0VVjXj/3DIWtDKC77EnKbbO6StVLL9Xo
	3nweM4vmIVBm/9UWPK+4Jpeg9PHefB2++wnjrd26fclu/LVLDClT6l4Rt31RLYkX
	TCOkwQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ytt378s1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 01:13:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45I1Dehu010408
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 01:13:40 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 18:13:40 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 17 Jun 2024 18:13:33 -0700
Subject: [PATCH 2/3] ataflop: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-md-m68k-drivers-block-v1-2-b200599a315e@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Tb8lg1iRkrnzYkQ758Arl_4paiqesf6q
X-Proofpoint-GUID: Tb8lg1iRkrnzYkQ758Arl_4paiqesf6q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=747 adultscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180006

With ARCH=m68k, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/ataflop.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/block/ataflop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index cacc4ba942a8..b19884da4376 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -2197,4 +2197,5 @@ static void __exit atari_floppy_exit(void)
 module_init(atari_floppy_init)
 module_exit(atari_floppy_exit)
 
+MODULE_DESCRIPTION("Atari floppy driver");
 MODULE_LICENSE("GPL");

-- 
2.42.0

