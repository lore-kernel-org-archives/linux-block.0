Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9309B17A2F0
	for <linux-block@vger.kernel.org>; Tue, 30 Dec 2025 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767099144; cv=fail; b=mbUJjEro3GRDAC1SYYP8AErolzlh0Z7sV8147GETyNjayPhP3Y1vIgZozRxYYzTANjNO/bdf7tx4whTiIxUA0Md6cjFKpCQtQYJAAVRi6Ca8T0zZ85h7NIsjPER8QgzTpNw+v1Jjoizr2yW3skP6x7vGk+Uy/xNQ1RoqMuv+45Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767099144; c=relaxed/simple;
	bh=X4cC6h7Lp+NdhvrdzefvePOxN14wvvE84i0sdS5sj1o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5QFUIhEhHIuf3+WXW2AE0hFveuU/6C/8Vb3ovH9yV8Rn9RLkUN5YNgSbGNZ7Y7BflEpAxlChTFHWJv7N5MfP3mhYB7rcIs2clNV1P/oEobRgrtAe6NJ49px2LEYKmFqTJqJlA/JHTvmCI8LkFfZUCracrUoAWbgkkpV8gQWXSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lR7PLjwj; arc=fail smtp.client-ip=52.101.56.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lR7PLjwj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COj2ILTlBapa+APHIIBVpQmrZuRqipWsN3Z5gOxRDQkS+bgwrhr6Nel+H2cJJMvxjEICkH7Wl5vgTVJYgpPdITFkuyWU/XX0MWvmqMLD95BrgjiJtxkl9BnU5Ad/wl/lKXXqX/YgyEJmmYfSpFPOsP6jf0HiNJeu2DNq3JNxwgQhSF6h1AeMfNn8fAnr3rz+WbMYKUHcV7bIzhWW8PKlCILeVRnSMZ/eSjSzSUNokxYxAssAvI+soK4qjizUMo8xUcY6KVTwUbMO5x0m3XoYhdY0nmO3bFW57rvzTSz6BcvMm+H6jduJCVak1kDMWJ+CJw5yGQYwXPhz4dL4xxWTwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZag04TXRVfJ8nRxxJBv2dxyiIrJgdnWnB6Xm0FKrDc=;
 b=BQ8C+tBUxLABV1eoM5YtsYa5bwGp5oHoN0gtIYu6GGfQ46cQ+mXPCbsAGPY21pEzW42kE25NmmpV/ogFsczFmzLMxpQEQ7grzaGhe1e5GOUL7HnB1m9D9ENxyaXtlf7IT+o/e/CaQNYiFZ3LRRL/rVEumpi8qgj2aRxYwf47pGpCbFj43zGCxXl6lbfOy1G816a2KI5Jg6BI84ac4ggERItXlQ64P4brEbmhdQ5/UtlmZerm7xg5JzaOBubp4Q2yugYZAKx2/cfvRZ0ezYSc/PVAOvHVeGoeAEG56BjaklxZizBd83KHZYBrmwRsLs92ae5iOPwLstFvUIrL0stdyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZag04TXRVfJ8nRxxJBv2dxyiIrJgdnWnB6Xm0FKrDc=;
 b=lR7PLjwj/meg8bwCNgGSraeG/xQLDN5MeGmeulVr0M8thCpZsDLCjPL0OmBkmGh9oOGkIQCNj//qdJk0+evD8B6/Ekz79fCWYgtXSpiv+ez4233MKdpeukCdBEv9pkURiRgTKOP1usDjQk8xkm4vFoGQwErEm4bpE+r9QeKGsqUQPlYMjQlvaYCzjEGfGIQ4e99Fl+uuSHInndXuUnmBRuN+ReDhGxcyLoJujqp8pbgt9cftXOgBzqjZEaEYmUShlKjL9yc+ajZEvCsnPglO6UJnm0Y6sT3q0uWghDRnY68KrGqQfL9lx8pi/N4BWM8oaXUxIz3vRlKr6K7DkjqZJw==
Received: from SJ0PR05CA0095.namprd05.prod.outlook.com (2603:10b6:a03:334::10)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 12:52:19 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::ed) by SJ0PR05CA0095.outlook.office365.com
 (2603:10b6:a03:334::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue,
 30 Dec 2025 12:52:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Tue, 30 Dec 2025 12:52:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Dec
 2025 04:52:06 -0800
Received: from yoav-mlt.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Dec
 2025 04:52:04 -0800
From: Yoav Cohen <yoav@nvidia.com>
To: <ming.lei@redhat.com>, <linux-block@vger.kernel.org>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, <ofer@nvidia.com>, Yoav Cohen
	<yoav@nvidia.com>
Subject: [PATCH 1/2] ublk: make ublk_ctrl_stop_dev return void
Date: Tue, 30 Dec 2025 14:51:39 +0200
Message-ID: <20251230125140.43760-2-yoav@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251230125140.43760-1-yoav@nvidia.com>
References: <20251230125140.43760-1-yoav@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|DM4PR12MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 50230018-eba3-47e8-275f-08de47a24427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6DGWDy5cE6e3KQ2DnR46H4G3fu6vx/gaOPy8SzIOlbTQZpJVa5OcAJmE7O8A?=
 =?us-ascii?Q?mERArT/NWBuYxdKiXVYi+L7PT1zuFmTHdDT0Lv11H+KwHladqan2/QUGS/Ui?=
 =?us-ascii?Q?g3LJiyO7LYEmPbvx3UlVjvy6kVloeJQvuNXGAlzJz62lTj5IZdwE0+g+d6Tn?=
 =?us-ascii?Q?FvI630n9wXsIAikqm6tm8b5j6W0dxS+PzbpLTNvSSb2vqIXhqKnSVFN4aHIg?=
 =?us-ascii?Q?nLmGHSH4WF4cQWrzikZr5bBJuBbGz4nUNofvtXf1bddAK6v9vXXxOa9ACblG?=
 =?us-ascii?Q?TEdAlxWP0xgEUPVptM4vFmI75iVJX6zxbZiKU8MPYGBDC93dTZF/W/1qNSsg?=
 =?us-ascii?Q?6cWRFiL5AjavARqvDp/ovZ3c0bC6wbyXP+N0pu+0TzqjVx+Cu99fxAre4lHs?=
 =?us-ascii?Q?Jp+C1emhxvl2s5K2pOrfNtGtEkzOqjOGBo7TSRHpf4W5uhuy+IhuSNgJt9Qa?=
 =?us-ascii?Q?VxEA4Dmb8EobzENFMeWemS0OpBgdfvuI2DP/6X2tCB3NeY9M817dGDjs+UmW?=
 =?us-ascii?Q?LNWLS0HFAqZBt1UqCZWI93bbDPpUoyaXj1l7qPjjIVaNGITPaU4jizcI4RRQ?=
 =?us-ascii?Q?d8dx2y8Iy9SXe8gp+AKcx95bkxc0zorJngmVhn5vk99aCaJoxI/LXLHivws/?=
 =?us-ascii?Q?EjA1Pnut7zMvhI/8ZEbiok32H87FWWFRixmc7v3uH8V/dX0/1E0srko81xI8?=
 =?us-ascii?Q?V5vYSGgRNbhKc7S3TLdd7+kPycTQcQDQaALpkPLXubO+e8lyAgyntf6QzqpA?=
 =?us-ascii?Q?9ZndPy39tZHn3TLavsbSbc0LDV27dmWFHdMgCddFV3XrTfWLgyWZJjlE9l8H?=
 =?us-ascii?Q?mmeBzofN9cMBJz3uak7eEeQAUEjUCq/ihgUrm1ywdqwQ4u469vMjBtr0ubAr?=
 =?us-ascii?Q?FuxEQMzCNWXQYyJC8Vt8yXi2GEayOI9lGRQuqOQbCwX09MCaMkPsW2ljt2ZP?=
 =?us-ascii?Q?AyfvBFjB4hl0i8gqRrFyr+M5BXA9oJ+b6bGqPTY1/0IoV8zTzb3lwNSLrfd6?=
 =?us-ascii?Q?2gUjWKq/amQmTtQnWK+LkqOtCyTo3tykvHiz1Ub5UrgdsBMJKWzDsW+xWbkc?=
 =?us-ascii?Q?5NAstJ9yKqo6WiORf1lqJ4PoCeEPxBKSXqoggpQ7/cVytS2psXZWMw1soqvf?=
 =?us-ascii?Q?F+YCi5qvpPqYWY+sY/6cknv0IVMe8UnSUUC5BbV6wsgVrGr4uaG/QcNHt/gT?=
 =?us-ascii?Q?yDg+4d0eiu8FYrPAENQk4It0HbZLyJ5onRoyN8i5vTRqtVr/kI9Y37pfChnk?=
 =?us-ascii?Q?7gFaA7MnzK73bLgYQrbOjweRTqXBl//juXf8Rbzglu1itYa8RvwvQboeF0Hh?=
 =?us-ascii?Q?WZkIjkTDZCEZtldtCPHUVuRO5QZpo7ZhgrM+iMtaXPFkezJs3OLURU+3gFTL?=
 =?us-ascii?Q?3N5aec2hhkXdA791bgutsDII5OpvwvsL4uSzqh6cylYbt3fBWv1zWel7wzq7?=
 =?us-ascii?Q?b0UuAM24ixVE0eICcNQuuubSxJ90FOtfScys6avOpfhJk+tJnKrEQA0UfnNd?=
 =?us-ascii?Q?RPpWWofTkRZ2eDV1zkLDHhEEfY5r7O+mL+bRvH877sHkFtlDss3GyqxYqvxx?=
 =?us-ascii?Q?a0d2ar079eJ01qRlOSQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 12:52:18.5953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50230018-eba3-47e8-275f-08de47a24427
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526

This function always returns 0, so there is no need to return a value.

Signed-off-by: Yoav Cohen <yoav@nvidia.com>
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

