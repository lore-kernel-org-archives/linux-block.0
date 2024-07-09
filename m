Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F2812C552
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 04:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720500959; cv=fail; b=hOCNvpYTZTeAhpsIMak0m+L8cdOWOHzUPTA2cc2wcmo7dFr1dfWJ9Zub/dQFVm4iOOI1as8GIdhBdqqBliiggIpS5EVi0WFMgv50njImd7uzjZcixsXbz7JYtHPjXRcCQNW91nCOC+o7glzVtt4fDyBo54sN6O8eOBWAEzLGq5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720500959; c=relaxed/simple;
	bh=7HGP7sIdzPt2270y/6BQwssv4FeSvFRYf6VrAH158Bk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qeV4iIcbKj5U02Ww2FVP1a7MKVZPX9rm8QAABew20Pf7dHaFH3dGuSVfQA7fSyrVl5VgOkCaM3HSvrkbQdgb3VcDIwfIayWwsQSzUsLZxtg/x0I8kY6x3P41zF4Gm3/Iz5F9ciX1s3NCejY4qwEshgSuVvITf1YSQgnZ3kd+xXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Se7+uSW4; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Se7+uSW4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYfzO/UCFIex/30f4P/PCFLhxFk78S1gNHbSyySoaHuKh2fXtqTC4L/+GxUGofhVctUhsRHGBfup5V8tn6MFk3a9R8LA/L4VkOepxRUbenIYm45NfcdUo9DJnQmOV5XriLkRBJ+X9+MvzxpFm2BkNnUqpf5Pe+fx2e7Dwr5PBLiryPaIaN6zasa3BKlUKmYLMPE+VwR1OvzQFOgvgb1BgYbjga3CKl+KCvcRgolkuTr94SflxKo6rf8E8gYpF8c1NgBDbUCAeepxaV4d1IEDLIzRwf8koNcfORUQzf6oH7C4Dc+gJ6Sc/qbh1x2LQmXQUAHy7wGMcWh2PPlQu5RlyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24pEjgX2jgQNPm73DYqQyEu72P8fdWxBEr06shSInck=;
 b=Rg9knIfggl0P4rD8zpYSIpQjNJmbdeeT5dZaugRz7fduwOfPyWMKBJOrlTUex/eqJvLne33PstLpa7KPIOZW/e9WuWHVoR5fXEtR8XGcxK9RqVvXG8FGptAhp4ACubKRqn7XRyIyOEUuSJyw0OEsHOFW8U1XsTOBY+q34LiCwcpNAyND5dL4AWybzT7321QV8GAH5rRmr6m5cSiBAx08hPFwwwIajNmVxotQPnW+eNeQgBJu5zKeGOuJ8NRL8Bkwmc/GY+V+Jv3j//B6UnBKKjBPIgE9LsEhAr2KDaAsU+P5Ws53nvOIK7m63HuYC0XQeipO/NpFCECOaBYNvTqpvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24pEjgX2jgQNPm73DYqQyEu72P8fdWxBEr06shSInck=;
 b=Se7+uSW4ImnEwYlkgPUuskE6OAPcN+bEnBX0sPc0asNBXBn9jAjX7ZgPz3tVcWNR1X/RflpxmRFYPmMzx4afolauO2BCDb8KW637QG8s/a+o1SLje3Bv/rCz8GrLenIHvbdHDiw+StfPQnmYam6fu2EThuqreCj3lNmHAFViDTockZJ+JEFAbbp+QBRLAWRrOTLRCXgEloq36QIcFxRWYk4Jr2KokszP6hbzy9RX8M54397/+CKpCdtTwY4CNqfR+b9pIeJjhIe5xiM9Z1eO+TXBB5SefREYx8fDmkrj/TuphKDBGIZwSlMxvXPZsHjwacI1kSraicw/Lc1JWN1GEA==
Received: from DM6PR03CA0085.namprd03.prod.outlook.com (2603:10b6:5:333::18)
 by CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 04:55:53 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::da) by DM6PR03CA0085.outlook.office365.com
 (2603:10b6:5:333::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Tue, 9 Jul 2024 04:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Tue, 9 Jul 2024 04:55:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 21:55:45 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 21:55:45 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] block: fix get_max_segment_size() warning
Date: Mon, 8 Jul 2024 21:54:32 -0700
Message-ID: <20240709045432.8688-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|CH3PR12MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: 24db11e1-46a9-455e-2a1e-08dc9fd3690c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GjghXYEFTwzgu5KQkbRdDWWe6cURBIXyZoqDiyoN8lxouBVtbgpB5ExjB9h8?=
 =?us-ascii?Q?TzRNn/xtOu5dpLnWewIfcG/6Eu+kVLOnHFHj5xHkSmR4YMcoyEgOUIqQmiIL?=
 =?us-ascii?Q?BJ5KurVKUoCw0oZyXZFPrVzYktl8doc83pFXwki+Imaf5f7WQ7zzJ5xkV6h2?=
 =?us-ascii?Q?QiGmoujMKKPcJfNHvnKk9o5HIrHYoOvg5ESjPtIa9+K1gynHmfm/g9PTN2oU?=
 =?us-ascii?Q?VAAXUk3kqFM6UCc3dEyIi+FngVkLOOXCHWkG6QwZRbMY3QhQJJZLLLugfiAH?=
 =?us-ascii?Q?XyWRzpnyRKSLQbhPeVVHvkWVZwW2OM1v/L9RaDtkkatRdiw/MVhx391PB+rF?=
 =?us-ascii?Q?KZ1tLBAqPjzzRMU3tdw2V4ZJ/vwPa3dVEHQoJFhUz3rNhQOCnEdMGxNDHUh4?=
 =?us-ascii?Q?EWCEG1/GO90UBnolSfGGqzNcu9i257a1BRI2QvyMtnidA3W4ep5X/e5Z8L8s?=
 =?us-ascii?Q?cXIGDGunesI4f/gYlNv9cMVSsczwDkq8LA8zO3Bp4Qz3z1sgbhD1BETQ8EJg?=
 =?us-ascii?Q?UQziLkrhkYvQc8RFp80IBa1QR8MYSteC4dMdaLYG6RTmKbUPD88WMb9P4Gfh?=
 =?us-ascii?Q?JjsDcZH2FqFuWNwVsdELYC9w9TTeb1yGDMzKTuhvEOuPhazK7KzQkVeWU+Ze?=
 =?us-ascii?Q?ptRiGQDeh/nWhiPn3w7wUpOtzlCcjl9ArCjWfk3G/0tGN2ymqas/mdxUnYsp?=
 =?us-ascii?Q?LTrNqik26fZ3TiWDrFounYdPBv5Z/fCYxWHajbiBcn8tibiej+C25+1q0/Hn?=
 =?us-ascii?Q?Gee6+aDh7MZokgwTYp254d5O+79R8dS0sa99MX4MRRI78gQdN2feaH2BNc5C?=
 =?us-ascii?Q?HRsTtt1FDRZKOvz+GujD4pNY+a6m0zeHL262WSC8Z6P1/4A4+bGJdivRMCuV?=
 =?us-ascii?Q?LbNtbb70x46jMetrQ0hK4abZAi+nVjKg7dz7j9kMVeMFMq4esvYQp7ATnBK0?=
 =?us-ascii?Q?xfesvYI0kyWHJmOr1OhLLWHPFdKtYavMnkZvo+DlDkCeBKqIJsF8urScv25u?=
 =?us-ascii?Q?tbW2zxrhGAdj++CJ1Y5d/fFA/9xgNOV0+TfmaYQlhIWm+biXEU2KNk4y3Rm9?=
 =?us-ascii?Q?0k1j0P/aEcIRwltaa4bdNPNzbQBGKUF5wUyP4r3GLByEfGubY4WQvq0iZa73?=
 =?us-ascii?Q?GMUySjJ3GhIDUj74vYTIR+NInrXrPVzJnw0hauJ3SV5UxP/pSp/Cd6F1Wfvc?=
 =?us-ascii?Q?S/GtHF6x8orcAdlDzBrOYM3e7gq/Z4giRox4eb9JzUhTjnRzzH2CqK/uLDyR?=
 =?us-ascii?Q?cBNGYwI7oKzEzphmu30h9XkoPStVuaddd8blzJ/1UuOWrd5UPSH0YrXbMecU?=
 =?us-ascii?Q?qSUZizE7z15Ld7x3mM5jFOsQPgAw4dg62FeoTn08juBrjL9ff27ndBaQKQO2?=
 =?us-ascii?Q?9k5Nzzxdjes0UEvavb9e4BCBGeZFloqSYH3suzgoYMH3eKzjGB3bFzl0pzVz?=
 =?us-ascii?Q?3Pg3kexOLz+4LJekEY6JWoWYFpowuphl?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 04:55:52.7994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24db11e1-46a9-455e-2a1e-08dc9fd3690c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395

Correct the parameter name in the comment of get_max_segment_size()
to fix following warning:-

block/blk-merge.c:220: warning: Function parameter or struct member 'len' not described in 'get_max_segment_size'
block/blk-merge.c:220: warning: Excess function parameter 'max_len' description in 'get_max_segment_size'

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/blk-merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 94502261e24a..668b784bc246 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -210,7 +210,7 @@ static inline unsigned get_max_io_size(struct bio *bio,
  * get_max_segment_size() - maximum number of bytes to add as a single segment
  * @lim: Request queue limits.
  * @paddr: address of the range to add
- * @max_len: maximum length available to add at @paddr
+ * @len: maximum length available to add at @paddr
  *
  * Returns the maximum number of bytes of the range starting at @paddr that can
  * be added to a single segment.
-- 
2.40.0

