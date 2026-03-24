Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010054.outbound.protection.outlook.com [52.101.61.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C622221F06;
	Tue, 24 Mar 2026 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774362893; cv=fail; b=RBCChyXYZBjePMNX9PpA5zRoRjBlw/ndg1UhuIIfCktzPnvc25MthzbZ7FV4psNaXDCmivpaQ0pBrY3ibM83M/SG4WOPCsTM/PVKmu0iDqLaom6KG2a2K3ibMKReqnDbBsKcSFkLB2TGNH60zGS6bwVRDQyo76dx9cAsewDFDS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774362893; c=relaxed/simple;
	bh=ffyZsuWsPL8yO4xfM8WiA/h1OegZauqKr6GCLz9iqWM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bOPE4b/uDcJego0nzD1l4h3gReCy2h6bNjx2HrGuMAou2SO4xX/PDzIKy2dji9i136Y/z+in4aDxHkgpk0Qr1tHQpYOGK5YbmBboMtfJFXvoZgMBRpMzUdYpbitLGMv7clRsP6TlT4H9WufugeHDKUM7R2ZhNVtUZwiQ7xIo7Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bmW1POql; arc=fail smtp.client-ip=52.101.61.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bmW1POql"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkr351YqQORy76h5jdh+BLKmsCf4k82qbrcbNyHu7vnoL89csBymV7m+/7OdaghM4e8qmj88znuPaV1XpcOHAuq7cM9YWGHVzEIZ2u+NLfCYqVyrGbPhuyJu0HIgt2w6r8szkWU6RINiWxjGOBWgG/I5JgHVdocWRbyURLIqxvxknX9rYofKjeq7nixrt9PVg5T4Lif10cULsJiKdvpVVsENkHxcH/QGoGETWq+G3gE2kaf6o5XzDvw245X8tK7kl5Ajz0I4KdK45dk5CnBXcLiGBc+bik/Hv5IEXFHI9IgOIj1jWJCBynuM6jHeu/VX8ej8UAjzufODljEVfE/Cfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDcDXFOTHtQRGF846DmjUxcgBqQBDOpEWM9CufSwYDE=;
 b=HkRKeBoGN0RUkAAwJ+xpWv5ZE7bkYzBgMiMz7M6zPQKFgVCTbdJo1qKs3pQRWhz/HX7lvHrAU+UNWRA4hMHq0/A4tPG01YMtpr54eYdKmnBRPSE5hlmZxqxfQTk3NIAHReTZPE8zCC/SU6vvLOQ90fWT6tOagv7v6RHP1inJRQJGWLH4iQAWHhLwPQciDvsVb4bk7CDcTGXFPvxhKpGHkDdASaz05bUj+DBFQShxU8GZoKJfrHGFdDeyKjU7Uv4kJy/obShnwR29vGS6aFrJJVlaw4bZpPL7kCqoapAc9N55O6bgShb/9ScVfSRd9RDKbvGxYO8p+/+W6gMQlZbfLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=linux.dev smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDcDXFOTHtQRGF846DmjUxcgBqQBDOpEWM9CufSwYDE=;
 b=bmW1POqlvCoaslR8nQ/DYSvaJUmJvRQKpzkOV92m52iqHQ4FmfeUlxXIoqypIcQzxU2vX9tWXznDecdscZ6OQ4eLxwGCPNFhOsEqNuGG3xez6C8CikH6MdoGflDrI61ixjshyJ/BcvHRZ9sDwANwwoj5j1d2UnnbldKOddkx+qk=
Received: from BN9PR03CA0277.namprd03.prod.outlook.com (2603:10b6:408:f5::12)
 by SA6PR10MB8086.namprd10.prod.outlook.com (2603:10b6:806:446::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Tue, 24 Mar
 2026 14:34:50 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:f5:cafe::a6) by BN9PR03CA0277.outlook.office365.com
 (2603:10b6:408:f5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 14:34:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 14:34:49 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 09:34:48 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 09:34:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Mar 2026 09:34:48 -0500
Received: from uda0271908.dhcp.ti.com (uda0271908.dhcp.ti.com [128.247.77.70])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62OEYmfc2786579;
	Tue, 24 Mar 2026 09:34:48 -0500
From: Bin Liu <b-liu@ti.com>
To: <linux-block@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC: <ulf.hansson@linaro.org>, <axboe@kernel.dk>, <shawn.lin@linux.dev>, "Bin
 Liu" <b-liu@ti.com>
Subject: [PATCH v2 2/2] mmc: block: use single block write in retry
Date: Tue, 24 Mar 2026 09:34:48 -0500
Message-ID: <20260324143448.2631888-3-b-liu@ti.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SA6PR10MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: a669752a-70bb-464c-15b4-08de89b28125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9+Ung5bVHI+k8v07L8kLxZpGu01XUAK+460jZgn+WjE66uaIxeV9Nt5+AeJdP2U/GLxPIDRFBHCprhvf5T8KFOGOVOx0lpb+3rXyTRDYGz/SKaHuIvlnYK840SrwTSqyRnxefj4s2Ep5qDMpEFrgV8WC+/T/ANlOreXnyR3mKovycpiyaeClFYqiJ5k2nfoT/TJytAfu6Qm+HIBffwiADQZ+s92YvD/1+H99Ymh/l4jfa909SMVVYlk3JCC8f//EBx7OTaVt/H0qlafxuvA2NAcrGZWTiEIFLNwj7dzZignNzyX0AbtqMueqSmAV0K6TFuq9OCRAdGpvP7tnBKR4tH6+84PV0yawbaFQgHQg51GVTzZs1I65UKFSsdeRFub5547eIP3GO6Jii8E9RTJgD7ku8lLWhSl4xfELoTBoe2OMAG+6atZMXNDfCxwOTKPW8LvJq3Q59X/s0qcHQnPWArCIUnjfdICUR7r1kGky1uM4bRCqUg3QXCW2q9Vb1zXg6EJdtvBw/s7Xw5Q+Xd/Kav0/9+8LzkUSkqheUm0SSPuepgL+9RaOmFBbmky4BZRJdPpL3UG/U562DLZuKsm+PAMZYgNGYhyqbBooIsMyK6BYoulpVn7GSJVNAkjcivI8pyBcujlIw9+eUucCq0zU2ZG+MrrfRCpB8aRKEAjaJKitSQwPgUH2pr/5V9G5uwtAxjUdQOC5qCsYGcrIPTU11cpslvMK7tfZgBmGLj8N4VpbJ5O8c2kD7eb6co5/3OqmJUUBlmNiA2w6W33Q9aXOOA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4F/2F6TxopDMExClBDl/Atq6n6ZidMcLPav3LAFPYl2oFPDqZ3oAvNONXLyLFjszGmaM5LzSoXlm5N+uAAWpYtLzWTWO5I2RAmHJ8UkbavQTJMQwEDs5BJurRQTRAwa7JFEEyfR4FSWrEBa9rzxdoZyh6v+t3chwppOy0ub3bU7AJw/or4IYYk0skKqfaKBX3muPBRlp6Z+vkC/MpIQFVq9i5jxVCuRjosuKpYIhKFCDTSmPp/nvtqHlBdNhqZkR/PUQrlinErbbxJ7l22QTAuMstvU9jnZqSL2OgFlI6b2Xo6kC2YMYRH4AOzzLLX/XoKhH7uOsSjc2zJKA9CWan/xoiyVpAAgFl1Wt2EWn/WBDB3nHG110STkZ6mF8Nnkd89G6osogK6gMlZMSOO64YHdVnM8iQXfhCFj68C3C6atEaedGNY4phObYLmrHKyeq
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 14:34:49.5900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a669752a-70bb-464c-15b4-08de89b28125
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8086

Due to errata i2493[0], multi-block write would still fail in retries.

With i2493, the MMC interface has the potential of write failures when
issuing multi-block writes operating in HS200 mode with excessive IO
supply noise.

While the errata provides guidance in hardware design and layout to
minimize the IO supply noise, in theory the write failure cannot be
resolved in hardware. The software solution to ensure the data integrity
is to add minimum 5us delay between block writes. Single-block write is
the practical way to introduce the delay.

This patch reuses recovery_mode flag, and switches to single-block
write in retry when multi-block write fails. It covers both CQE and
non-CQE cases.

[0] https://www.ti.com/lit/pdf/sprz582
Signed-off-by: Bin Liu <b-liu@ti.com>
---
v2: add errata details in the commit message.

 drivers/mmc/core/block.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 05ee76cb0a08..00016584d70d 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1401,6 +1401,9 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 		    rq_data_dir(req) == WRITE &&
 		    (md->flags & MMC_BLK_REL_WR);
 
+	if (req->rq_flags & RQF_XFER_SINGLE_BLK)
+		recovery_mode = 1;
+
 	memset(brq, 0, sizeof(struct mmc_blk_request));
 
 	mmc_crypto_prepare_req(mqrq);
@@ -1540,10 +1543,13 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
 		err = 0;
 
 	if (err) {
-		if (mqrq->retries++ < MMC_CQE_RETRIES)
+		if (mqrq->retries++ < MMC_CQE_RETRIES) {
+			if (rq_data_dir(req) == WRITE)
+				req->rq_flags |= RQF_XFER_SINGLE_BLK;
 			blk_mq_requeue_request(req, true);
-		else
+		} else {
 			blk_mq_end_request(req, BLK_STS_IOERR);
+		}
 	} else if (mrq->data) {
 		if (blk_update_request(req, BLK_STS_OK, mrq->data->bytes_xfered))
 			blk_mq_requeue_request(req, true);
@@ -2085,6 +2091,8 @@ static void mmc_blk_mq_complete_rq(struct mmc_queue *mq, struct request *req)
 	} else if (!blk_rq_bytes(req)) {
 		__blk_mq_end_request(req, BLK_STS_IOERR);
 	} else if (mqrq->retries++ < MMC_MAX_RETRIES) {
+		if (rq_data_dir(req) == WRITE)
+			req->rq_flags |= RQF_XFER_SINGLE_BLK;
 		blk_mq_requeue_request(req, true);
 	} else {
 		if (mmc_card_removed(mq->card))
-- 
2.34.1

