Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ED263A;
	Mon,  3 Jun 2024 00:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717373714; cv=none; b=Fx+UYevdE2q/cMehEb72ebD1QNwtt7MBm3FxyA4lN4hu9DigfeJDqbcN2ppGIS+E9AQ5hhVhSQzEuTW5cMkQjiyyZzYo3wMlZkN90dIrBEvYcbgS8ypxd+BANDxcLviGKRVRZlEPF6n5CrWv970MjUbrYe0P8JHi8pTTQET7cHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717373714; c=relaxed/simple;
	bh=2g+DapX9B+VuBy6viLb/y/X1QbnBYiKJPqNRiBMd4nY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=aapDyIpzBi5bjMUHzkF0TTI3xqAfz/RXlBNMpjnB1lTjnrSCklvGd316WK702z/gvJtXs23iFUCNKPBSVlCe0OTvzhLxQGfLOnBFB80w6J8am62dPC+W8rQZEiMZ5ZZTwobnHilHGrwQZ4o+LWSEikkr6f+8nDwnFxNzicmJ+4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SUzeHiXS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SUzeHiXS"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 452NYghi003580;
	Mon, 3 Jun 2024 00:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qO0Wn2EL3oTlAI9gvQbq5L
	v95Co0uVKIaihPIpud23Y=; b=SUzeHiXShFVjNHwBbwRwe4XEn8IBig7ttSO8rg
	SQiDb+AoNKueUW7Ap94fYDyhPM+MbhcNyAKqoJL8BBdbr6NOtuF++0IMriGCMRcr
	KGIddwNZkJjMYglwT+j5kE5EUjkKWvVx45sF6IOZW9OAg1Rsr8ZHiRQ7HsNmGMdX
	AluRhsGh92cbt2BGJbG63VbOKzwtEWulSzJ2FDiEilF+Da+wDQ9MVPejdcpvf/i4
	0is+Fdn+Attf2ePu8VK0YKDXxgqBjKQ5Dk6lOnSgA2iK7tmj4v5zcw5UDnq/TOTO
	sE5IBQln7C66sxXCHTGFiORBX6TUwMSBADsRAzgkLmxRBQvw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw6v2qft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 00:15:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4530FAtV007000
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 00:15:10 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 2 Jun 2024
 17:15:10 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sun, 2 Jun 2024 17:15:09 -0700
Subject: [PATCH] loop: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240602-md-block-loop-v1-1-b9b7e2603e72@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAA0LXWYC/x3MTQ6CMBBA4auQWTtJafhRr2JYTMsoE0tLOkpIC
 HenuvwW7+2gnIUV7tUOmVdRSbGgvlTgJ4ovRhmLwRrbmM5YnEd0Ifk3hpQW7NuObq2j/trUUJo
 l81O2/+8xFDtSRpcp+ul3CRK/G86kH85wHCfH4bt/fgAAAA==
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ETYOcuF_nipQiI37Vukt13kWf4KXX_lK
X-Proofpoint-ORIG-GUID: ETYOcuF_nipQiI37Vukt13kWf4KXX_lK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_15,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406030000

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/loop.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/block/loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 93780f41646b..9455c82451aa 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1830,6 +1830,7 @@ static const struct kernel_param_ops loop_hw_qdepth_param_ops = {
 device_param_cb(hw_queue_depth, &loop_hw_qdepth_param_ops, &hw_queue_depth, 0444);
 MODULE_PARM_DESC(hw_queue_depth, "Queue depth for each hardware queue. Default: " __stringify(LOOP_DEFAULT_HW_Q_DEPTH));
 
+MODULE_DESCRIPTION("Loopback device support");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(LOOP_MAJOR);
 

---
base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
change-id: 20240602-md-block-loop-756a95ba7841

