Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233C87E8;
	Mon,  3 Jun 2024 00:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717374221; cv=none; b=QyYkPFrS5//Bvfg6RUhC3TE4ip/olEyn3ydoAwEOcVG1Qt7DAqYO22C63jpTq1GvZSLz9Z+KZOJWyHqMN0GjGZlsGFOQE2iyb4yDpzPLa0GldJ+UF1MrvyegCaLN7hYlWHxO83L3y5ZOxKsdMeJQGnYJ1KekcoWfRc2jv/Hyt4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717374221; c=relaxed/simple;
	bh=oVwIw/4/q1TC18VGQ+PRIRB4JDznam0T9iKRu1hyQ/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Veuxv0V52Q2Mfy+leHgn3RQ2KVQYsrfrT9+OWn5Y//Lp7F081Cu7jL6xwtZEVw7cQvYjuqGLXIPeXtgOfPhahwyqdZnSDgC+g3Fse0p0q/TuHE3GCW/47GgDwEGQ8r7Mitj9b+mAPpTqJlwoftfPqUWNyU3aepLofCL3RCRTbRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VXHHKdip; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VXHHKdip"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 452NqfsH013372;
	Mon, 3 Jun 2024 00:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=073kHdKzGn1Ra0KLlAs1Hl
	sRhqT70W/vazQ7/xmTLMQ=; b=VXHHKdipqYbUGnQgSFeSB2fWPvwL+hWpBXNwkB
	uvfDzTyNnqO47MRp0Oj66pPwmtaIVwtDT+V72HfN1gnsKq/wXcDKjHWiP6M1NpVL
	/F7gf2RtjyOs9/kpo++uwCt37a3cDKw0Pksx+mHxQeqBTBKI9EjC99NxxB0L7fgS
	h4nyFfiotNhBDAHehnq1dpWbl5dl+OGW34Z6KzI+csL3E7H4EiL9YCR9vrXVizuy
	m5ebz7f6qJq8PTNLDQQn0wyR4UdA1XXlX1FUgloqeWqm85Sr6Q5dSnYV70hw2olj
	VgFiebDnqpWGD0KbkSn6plar3rtgMaGvDJmtMzZieQnPSgFA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw42tn26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 00:23:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4530NYG8014774
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 00:23:34 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 2 Jun 2024
 17:23:28 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sun, 2 Jun 2024 17:23:26 -0700
Subject: [PATCH] ublk_drv: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240602-md-block-ublk_drv-v1-1-995474cafff0@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAP0MXWYC/x3M0QrCMAxA0V8ZeTaQFZ3gr4hI02YurOskdWMw9
 u9WH8/DvTsUMZUCt2YHk1WLzrmiPTUQBp9fghqrwZE7U0cOp4ic5jDiwml8RluR2gtdPbHveob
 avU163f7P+6OafRFk8zkMv1PSvGw4+fIRg+P4AneYzZ6CAAAA
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V4nv9X0vEL1ByMMSDI35ROfz21lkW5dM
X-Proofpoint-ORIG-GUID: V4nv9X0vEL1ByMMSDI35ROfz21lkW5dM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_15,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1011 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406030001

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/ublk_drv.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/block/ublk_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 4e159948c912..59916895ee2e 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -3017,4 +3017,5 @@ module_param_cb(ublks_max, &ublk_max_ublks_ops, &ublks_max, 0644);
 MODULE_PARM_DESC(ublks_max, "max number of ublk devices allowed to add(default: 64)");
 
 MODULE_AUTHOR("Ming Lei <ming.lei@redhat.com>");
+MODULE_DESCRIPTION("Userspace block device");
 MODULE_LICENSE("GPL");

---
base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
change-id: 20240602-md-block-ublk_drv-01507a0ba6fb

