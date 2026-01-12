Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010043.outbound.protection.outlook.com [40.93.198.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9BA35970C
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768225058; cv=fail; b=NSVCAUeT43tKnW1f7jRDVxa9LeWJ7RmNj1j14F0COi9asw6GJuLZQq4RMUeHNy1ldcKsMvs/u3QJaxJz1PO3ac50Aeh5Ohy22kK4XUEkRuSdondcYrViTVaNtPfwB71UiCsdUIzKsLMoSTAq0Khp/O6Sp3FV77/Otlsqm0TpWNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768225058; c=relaxed/simple;
	bh=nZdvFp2oJcMHjbI+PLasZh18GqMiBbq21xQeuSNWuLw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PG+I52RvSln/Qo+6n1C/P7ZkmIok9atpC6T6xUEXsj6fEJntE12z7BlPsT1uOKgoi+R50TokJN6Ln/JIbgKPBrbt7A8q7uQ7naHvpfY6W+58YZrszHAIa8+rcFTNFg36vr+fTeY2rFEaAnff7ibb6zCNN3uejtWxQGrh8Zjh5IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nnBWYtcR; arc=fail smtp.client-ip=40.93.198.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nnBWYtcR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1jbAdVr3/Qh2pr8lpPPUVAEiOh5aekNQ/uogAOOJDz12yYLtyKvnp9c2JBIAUCHguQQVO096uyaKBWgS2Vn9lZWAHTSk3J/ZEwJtnmOoJestSeA+mS9+Z0Oe7b5D6OCyj+eDkzBFWXR/8McTTW4oH/mhpWPkO7uhJUhonDS7u6bjudnL1IhVHfgUu9OloxMaM8YTiCsXAdmP879rHhw+56aqyN4wTeWIz9qd8RSanHhnivsX2P3ll5Lj7RZN42BMwGwH6YSg89qc21ddxclFU9O6oRY5V1/F1sSVUz516bFaX4BmzDkjC0KbI8x4Y3NATdPBP7tILast0ZIyWJz4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOZGP2pn7WVQJLWgZGqMetV/0RWfcB8fT5k5vJm0D4Q=;
 b=hme+sx6Ge1eerG6eMfpAAWTgCHd/Mvysn6t2vI6r8V+p+YTcMBMYhZylnLqLC91/eTRi+EhVw3J/4sLaYjQn/EjXfT59MpGBub/dzMYQHjY9m2Gq00LRkySnfpEtUB/dV7tV9yFOHkhBLQapIOM9t7Y0Oyrr3fvagrYbQ5RHI+xf0ljQY6srFgFXoncoXjONA6v+Oa778aKTzjkiUfGRMQ+Cwfdm6hboJj4ayOGE+sP1jVjGLr/LhO74rPaQqgKFxPlCOgGeS0hAKenm/ksaQxWZCZchstqnawXFsfHZNd1aiL2Gt/OgNZaTpjtDTQ5C7a9xNHAAqX8Ww2J7PUhdmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOZGP2pn7WVQJLWgZGqMetV/0RWfcB8fT5k5vJm0D4Q=;
 b=nnBWYtcRNSKSJZ1XtvZORwB/TdSy62PxqWuPavWJlCjsTHYiE/gh/PLRMVh5oysdupqRALRwIqJvFPPwCqpGfYegXbacqusnFMEIUemOQOxmA/FwK8OZyAJSWHA+PsoUmcF9tTUgfibuMqS3uQQXDQNp58mBd4yw8d/3YXHXs3GdkTprV/L3Yl3JhUWF1VCGPmVoVultQopu/cZprlzKJj9x/8w3TyjvalGMuWiAU+Owo1g3KbuDFK6BWhDw+B/qEoPHFBYTsU/pGuIuJBQJPoDiZcwCk6juOIOsEZrIb105omanK8yDhYjPUPcukZJeG3qkAopQbwV/H65K+XY+Fw==
Received: from BN9PR03CA0520.namprd03.prod.outlook.com (2603:10b6:408:131::15)
 by SA5PPF37951B1C9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 13:37:24 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:131:cafe::18) by BN9PR03CA0520.outlook.office365.com
 (2603:10b6:408:131::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 13:37:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 13:37:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 05:37:07 -0800
Received: from yoav-mlt.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 05:37:04 -0800
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>, <alex@zazolabs.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, Yoav Cohen <yoav@example.com>,
	Yoav Cohen <yoav@nvidia.com>
Subject: [PATCH v6 1/3] ublk: make ublk_ctrl_stop_dev return void
Date: Mon, 12 Jan 2026 15:36:45 +0200
Message-ID: <20260112133648.51722-2-yoav@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260112133648.51722-1-yoav@nvidia.com>
References: <20260112133648.51722-1-yoav@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|SA5PPF37951B1C9:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a1f6ec9-7db8-4e21-8f0c-08de51dfb810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+sk4Nr6VczQjCsbUZnvdKMun9sdldVxyppvjOBvLQjRNVLujcqIRVgQov5uA?=
 =?us-ascii?Q?ZeRyy8X9ZwbNZhb80sopXf0WY0j8bTXjuP5XhlNaLyV+PnyREt5vsM93aK59?=
 =?us-ascii?Q?mzYWD6UbZWwqVXU9nS6Re1RRuEENdc9aRKc4iDpf+kFot6rMh/02fClKYiS2?=
 =?us-ascii?Q?ZfX5qIEVtLX0zUGRS5EPvYL82CMjlYlnhpPvZOOsa6iL/4PLAxaxZLcvBkNc?=
 =?us-ascii?Q?z/krMampSLUHVoALa+jFNv03GLEejfu0n7MPoDRcAzF7Aa50mdScQDBfNA1S?=
 =?us-ascii?Q?B4R1blS0JZyHoIHWpf2W4pNcnBG7PpFUQqmsUPzoVzLMNp23ieLS6sJqRefK?=
 =?us-ascii?Q?4VgYGBdfWrvJhaCMgMH7+neJSkZg5fIDXQcfblLSx3B4bcK4RoUlN+ttNA3F?=
 =?us-ascii?Q?i2/9Y77HaRTHzXsM8AIgeqPRsX5mceAjyJBeGEB9YWyn5I6MccHbKtgi/IXV?=
 =?us-ascii?Q?Uq7qXVT0ks5d7CEu/zKOwHiZLTeoY46ALWG2+/3Mqn49gbltQWYnHHlgB0bH?=
 =?us-ascii?Q?/1I1MMrqd28JwAhN8Wvq2XshJZy+6mE3vyxWbI9LGk20cW08D/STtwB36QLY?=
 =?us-ascii?Q?0JfDR31if6RmQBRMm+sk6qpMCJMYoMUiizRSxZ3YyB4fj8bTbpnaWRjD1MBb?=
 =?us-ascii?Q?fRIxckkeFpMgiAn0oPYxfAOK4zy7eU1VK9vlKr7anF8ZR5tKzKavp8XrPni8?=
 =?us-ascii?Q?nexyZKucvBp879fvi65WjI/LjHwlUCE6a1zxwFxv3eYJj88A4SSee+NHBw1I?=
 =?us-ascii?Q?jIslLjPjs5OH+iGdBQTLX7lkODlWZIL1AuNczSCTRwbjgub25BMNOIG9C4kn?=
 =?us-ascii?Q?Uu5uDtP36WvfFa+7WtUYotu4l8IoclxoWr/xu7is2+DpyNQ8Yt0r4bOIqWxi?=
 =?us-ascii?Q?hHvuwQBBnHwDX6R0IkA8PMYxpET6AlmX5hn8kpAGMjUlAkdO2q8c+ICKY5yX?=
 =?us-ascii?Q?IUiuWh/ng2Kh//KiBp65DE+0vViwwiYZ2Jx4FQ6cv661WonPHi7Q4dSriD4C?=
 =?us-ascii?Q?ykg7AXQLNSMLj6wwOFYog8DZuyAxH8Id1Z93q3F/Cv+1OhQruuJUi00n52sq?=
 =?us-ascii?Q?fxjgEKYqBLUp/IhRZLzlcAOI4FUb1iFp9kSvTXqeFWUKPlyefclg2up3FvXD?=
 =?us-ascii?Q?RE/eBrRJ5oXwTwpg3dtJ8fDWR4JGxiyKAeEVa48GlsFGbzWiEkAspSKPKOy1?=
 =?us-ascii?Q?ROL51zTKdyz8MNzLcCInaEU6abOepur/7UJ8VBbURcKHgnNpZ4QVY0AxAVJ4?=
 =?us-ascii?Q?ATD71mSUJ9pWiKlUVKP53AmDZC+tXz+3G1heHI5XOVoficlkV3NviU2Gupgr?=
 =?us-ascii?Q?58GBFTN2eNWWX/AetOhMPPWK5m8vjiDqe+53KYqqZpLXYoM5wCDBMmgop2hY?=
 =?us-ascii?Q?dGnfDDZ8ASxSYaCb8ZdpP1ztu+2UzFfvrB6/K1vRwIdMBW5qO8Bm1cmrX4KE?=
 =?us-ascii?Q?Ryo6A9eCl+DJo4AomRBlXuloN5mtgGVMamrIDbfU7yvQwkFAGvhLaPIzfvvE?=
 =?us-ascii?Q?PIDEu/npKQ0cougXvGV6A1MFFX2F+TdNJDN7fD7KnydePE/EDybID9e0ZDUg?=
 =?us-ascii?Q?Ue6c4CKm5RBhDByQhJw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 13:37:23.8614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1f6ec9-7db8-4e21-8f0c-08de51dfb810
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF37951B1C9

This function always returns 0, so there is no need to return a value.

Signed-off-by: Yoav Cohen <yoav@nvidia.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 837fedb02e0d..2d5602ef05cc 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -3304,10 +3304,9 @@ static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
 			header->data[0], header->addr, header->len);
 }
 
-static int ublk_ctrl_stop_dev(struct ublk_device *ub)
+static void ublk_ctrl_stop_dev(struct ublk_device *ub)
 {
 	ublk_stop_dev(ub);
-	return 0;
 }
 
 static int ublk_ctrl_get_dev_info(struct ublk_device *ub,
@@ -3780,7 +3779,8 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		ret = ublk_ctrl_start_dev(ub, header);
 		break;
 	case UBLK_CMD_STOP_DEV:
-		ret = ublk_ctrl_stop_dev(ub);
+		ublk_ctrl_stop_dev(ub);
+		ret = 0;
 		break;
 	case UBLK_CMD_GET_DEV_INFO:
 	case UBLK_CMD_GET_DEV_INFO2:
-- 
2.39.5 (Apple Git-154)

