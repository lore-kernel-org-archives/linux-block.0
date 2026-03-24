Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012065.outbound.protection.outlook.com [40.93.195.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A80387372;
	Tue, 24 Mar 2026 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774362930; cv=fail; b=suae+DJnVgQAo7hAZ+N19ONqHGFSPg1qIUAQsM47Q9iC41agPTs4EsONe+xqZJ2Yd5yE3AxyrXYIo5HaeMZ7uT58CuGY8EpSvHwdJGi/fT5MZkJcmJzGKndxMgyWqiDH5kJY/YykQ5HZWUPQ+1pUv5Oc6MFK1j4iQpY+8j2sEJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774362930; c=relaxed/simple;
	bh=uaRXE1AQ+4d0I8li1QaIR0xTOjuJK+5iZm8ToaZnc2I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uj5pYRRSWhNIjyL+ZZdXsC3tjwRR9TOyzYYW6gBVR/I0u4bQlfQiWpssK310cW2WJYRSmIGhn+7geUz29feb6PQX56LlmJtnJ9e3aHqS9hnjZjTO28V4ywGGYJzKWB788lk0XA3o2xkIaUgd/Fr5qmBrhl11bg+1qApn7Enmry0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WV9fTq0Z; arc=fail smtp.client-ip=40.93.195.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WV9fTq0Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlXdVO+zWf735ZB7Nu4ndcVJ296ifUrLZe/yADG/ylmMApVvJTQl8YHnmcUD/rIiN84/KVon2RVgvmBbG3J0pOgcBTA7Jc1SvG1tUSmpZ9aBzaVmtUw1typlsWOcAMW0tLIQmjEykzV3+zW2jF7dHj2MqS35cCUsPHwW27dR5kmUNEcyuWPRUzJkG6lgP5EP4UDcZh8gkpssse9gjMOsvsTEHhs4Rhkj3HiQBs1WSHQFOfyBFsHYZqUc3ACPHtsNActjVgjxwUzqCeNWL5317WKX0AUDYi65F40Zv5PlO9mbx1avT1QkKRW9JhQcmW8XytZb4HjN2jAHNcJEacy7tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8tOZWZnSyBXHUKu9+s7zAhXxMZI3BbbeGmEo4LTbPk=;
 b=C4Rkjg2Pc122WE32j1d7e11TdOepweDWjYOjN+0nVkcBIi5Izfymx3I5LhATwGrCuWqfG8FJdAl/Bgi4wUtyf3D0pVmxtps7nF3giVoY5gK1bkbCHPkYLZ3Lcw0pJ6djH3oVyazmGjPWR8ahKh1GYbjHxSTy62CQ/tiZkH7F/Gx3yD6EQcSw61Wz7K5YXUil8S6eJYOQPcU2j2aM5lGwQrc234iOZiZFjZIQmyaM9mBuvGlpYPqt8NuCHAynDISdjp9+uVhKkTnT/e/iMg7YGPK/CLfQvRUyBYc56UtJpkt6ALMJ1v4O6wsuJdaQSme2FyfCvqDW1oVRPwkvNMEhrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=linux.dev smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8tOZWZnSyBXHUKu9+s7zAhXxMZI3BbbeGmEo4LTbPk=;
 b=WV9fTq0Z89tLi5Y/IVRKsRGkmuLExOLUnWhyz+JUljrSddbsMMEFuNiqHIuYL0ncvbwtiWtTg5yFGZBSgWYM/J7WOXivvyL05/jSrSHwumc1rp3QZlpu8RWlo0mXf+6VAgMxq9pkbAWV92UKuHni2qQyvr7fJeUU4zlCMf/4wuU=
Received: from PH7PR17CA0039.namprd17.prod.outlook.com (2603:10b6:510:323::18)
 by DM4PR10MB6862.namprd10.prod.outlook.com (2603:10b6:8:105::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Tue, 24 Mar
 2026 14:35:18 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:510:323:cafe::f4) by PH7PR17CA0039.outlook.office365.com
 (2603:10b6:510:323::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 14:35:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.0 via Frontend Transport; Tue, 24 Mar 2026 14:35:16 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 09:34:48 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 09:34:48 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Mar 2026 09:34:48 -0500
Received: from uda0271908.dhcp.ti.com (uda0271908.dhcp.ti.com [128.247.77.70])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62OEYmfb2786579;
	Tue, 24 Mar 2026 09:34:48 -0500
From: Bin Liu <b-liu@ti.com>
To: <linux-block@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC: <ulf.hansson@linaro.org>, <axboe@kernel.dk>, <shawn.lin@linux.dev>, "Bin
 Liu" <b-liu@ti.com>
Subject: [PATCH v2 1/2] block: define new rqf_flags RQF_XFER_SINGLE_BLK
Date: Tue, 24 Mar 2026 09:34:47 -0500
Message-ID: <20260324143448.2631888-2-b-liu@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324143448.2631888-1-b-liu@ti.com>
References: <20260310160408.3976760-1-b-liu@ti.com>
 <20260324143448.2631888-1-b-liu@ti.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|DM4PR10MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: 8570fa48-99d2-4cb6-87cd-08de89b29120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	H5+w4LZOiqKlHLxRxowk5VjdXCNUi2F01WWlvqzmLkizdqenWZk7paVplU7hIJMxuFThUOP8HBgDGgVHY/sxZMYJixhAVQdH2/QjXuYOckqlcoehqVuGJswW707mt37Rb8t4MQIDn9FAJsRE6QgCiOV5ZoKwv0pAR+v2/cJLODPGsntw+ZTxqLnw7w4hem/1k7xDxuHPdWytH4OcL43YpJ1z0cbh+JZoTZfQzprgiemqB6QE4DmL8GKBOD2udZNrsAAHTmwPEEswO6zbMmkDBDSUf2/jYBvyhu2toTLqT6FwtnoNujYo7VYzOaJ2LZpMboIvUXkdNm/fGEAG8sP3i5Us694XZ3LHIvKQMewmUxOPU7merNbli7Pf46lJrTWhsdwx99zoMcIaRgdUQv/OjsaA2EbWyo93TR8CwxsWTQAJ80qEnrX1hG8UWQwWbG96Xn3e4aSzrAE2yIU4YC12XCCqX+J6lnM4TKDHJuolk9f7VWqXO2vUxhJysHfAVLg0AmQJWnKCUbovtBrbHH9zcv44ZeHTXwW0THJ4d6XB692RgZ7CllUrEQt0mJ9B/URyUGwYr4qcaowugtjje38hGjVwm1+vcQGbfoyrySYKUDEDur77N83IfSNNQi8Ci1ojvqwc5FBLai9DyY+xXre5uKBFPDekQuCvV9tULu/qgtHqWOr0RvePhtty1Gihp6tJW0w2fwyjJVzz9jMrOlVBebvU4r00sc8KkxCpltC8pcON782hvFnwAYxkuSQtXHldiYdS6djVVQRcjVqoITQ0Xg==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eySVEUaJIUsWG41pJ+iCIWgEWHj36wIpbIJsfgFJuGmRRSy2K/+YORKIABFQNUZYZ/d2n1smZuhv6faazsV+TG7gVp7zzBjxKuA7EbIKKWlXsPGGkmqi4uNsYmuVy2iUfzyGEeECivv/n8n6cRvmftaPzcP+DxJhWJHEfQdiQb0Q9khKTdYQHu/UdQPRwjRUYGTtxio5jRyU3g8cWNupWahMi2nu0mAgQi9X3I0gNolA4WVWLJWsfudUeO6bI3CehJlACRvpoCL9j01+kwcCRcjEu1vuCnlPEkbjBBPlICXISBU4793Ilnt7VIXdlWGAwfgrRhagB61DULOfwbiHlPTus9OyUfhXJ8GZPo2QWwyua81JcDLVM9C/6nDbctubRdmaukBT3wCgWXHgYqq2jzIyRl7eztF1l0ExPR7QqU9Y75FEsZXsIqaoshpuhxMS
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 14:35:16.3880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8570fa48-99d2-4cb6-87cd-08de89b29120
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6862

This new flag will be used to handle multi-block transfer failure, in
which case single-block transfer will be used.

Signed-off-by: Bin Liu <b-liu@ti.com>
---
v2: new patch, separate the new flag definition.

 block/blk-mq-debugfs.c | 1 +
 include/linux/blk-mq.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 28167c9baa55..5f97d07fa3c8 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -243,6 +243,7 @@ static const char *const rqf_name[] = {
 	RQF_NAME(ZONE_WRITE_PLUGGING),
 	RQF_NAME(TIMED_OUT),
 	RQF_NAME(RESV),
+	RQF_NAME(XFER_SINGLE_BLK),
 };
 #undef RQF_NAME
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 18a2388ba581..06b6e1c4fca3 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -64,6 +64,7 @@ enum rqf_flags {
 	/* ->timeout has been called, don't expire again */
 	__RQF_TIMED_OUT,
 	__RQF_RESV,
+	__RQF_XFER_SINGLE_BLK,
 	__RQF_BITS
 };
 
@@ -85,6 +86,8 @@ enum rqf_flags {
 			((__force req_flags_t)(1 << __RQF_ZONE_WRITE_PLUGGING))
 #define RQF_TIMED_OUT		((__force req_flags_t)(1 << __RQF_TIMED_OUT))
 #define RQF_RESV		((__force req_flags_t)(1 << __RQF_RESV))
+#define RQF_XFER_SINGLE_BLK	\
+			((__force req_flags_t)(1 << __RQF_XFER_SINGLE_BLK))
 
 /* flags that prevent us from merging requests: */
 #define RQF_NOMERGE_FLAGS \
-- 
2.34.1

