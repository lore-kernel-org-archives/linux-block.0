Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010021.outbound.protection.outlook.com [40.93.198.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241631C860B
	for <linux-block@vger.kernel.org>; Sun,  4 Jan 2026 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767516555; cv=fail; b=Wx5+XLCiQgijx4tL8HJW5qeJKgbxui7pvnENMbx+ccMMsu+AoKOC/OFkDlKsmAeG7fUklYcfN/KK+ejMRWcoexd+rqP4GaMddxN9E/52yo4pIiWwTwvW1ZM+5IS59159QNV42lXCDrLlVGIvM8Dz4e9n+OFLHy3Oj4MWNdz2Orw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767516555; c=relaxed/simple;
	bh=X4cC6h7Lp+NdhvrdzefvePOxN14wvvE84i0sdS5sj1o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QtvpRvxQ7pvv/o/FRzeSp6WGsj7tjr8/mKGuYCSN7W7N4u32fC6cFBPySpHfPswwwSLVJtdleycXyoVBXKMtt+KfUVszr2u1oPiP/QAzi4rAzzfiAZt3QsPHN4flj7ohCDBPXyXWcoq19FbEHNiEx7dDcclc4Cq3zXm1EHz1Vyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c+1sFaqO; arc=fail smtp.client-ip=40.93.198.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c+1sFaqO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1dIGYRVCNLxkkik3UCnMhrJyHA1bVGDubumcmx26EZPfkKw8CpTUonEppdq2urBTI+gD6Uk0iHPErmy7KO15gvJAZADeJLl7VUzxfFJqBPzJwRfQGmunI3WNiL585XiwGdss0C7ca2Oq4q3cyh7JxkULjE16Ydu/fO82P3BXcCXYp/ePJR+0zoLV7b71n+93eALd/9BTPfIeAScmzyZ/6dinlAyBEXJhqXcOQLBTwufSDnAVP+XJ2Z+5cQvEy0lfZd961H0Jn5pveG/1qP8J8ejb5rtTqr8ChZrLDUJJzpc+psKnYxY7OjLb+BM62h9U6CoNqhjP74rK4qD2p+c+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZag04TXRVfJ8nRxxJBv2dxyiIrJgdnWnB6Xm0FKrDc=;
 b=arzVnrQGR30eUYbf+QjvbE0kLFOjQ3WlTm3IdJ4+EYdpY6kefSwOaLU9O/cFQdV+opivaHHh6f4eArn9KHj5MIWCm4Pxg2SwAum7hqn1pQI7gMSG/TFepci4oWm8tGLdGWeI2MlR1UwXrz0uuYe8XPUn8NtDoDnngHd0ztkkYPqM2LLKIeNtdCtRw/SYOc7mnKQwiFUQZtcwr+HIkShw9rUPEXKc3gaQitj4oKy0h8o2qKdTHrdS/q1djnxfqFJ6BZKY1MvCP418+oc9w1xwq1iGq46cHoU52z/eLPe3+aeVNhlHmjmh3jpXGae0lWoxPWh4mwvg5wWGd7Rk3fMtvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZag04TXRVfJ8nRxxJBv2dxyiIrJgdnWnB6Xm0FKrDc=;
 b=c+1sFaqO87i0u6c5eo9kzjM5RruD4t6FKziOfPHr/p4jy2fTtq5Eit3bgnF0YzXHYd+byEd99ljhTiAMY/9J91QLIUa6OEWcq7qRFaCLaHx0US7sy1/KKJT5z90iXriTOiTE3fsEWWJs9dU70pO82e3XEYcpaQz1Fmwl8UDcDF4D5AcK1Q8iOc90vhgtQSDWUXipNOdYWKEVQ8PXTLIimoP2BKc/I21Firpyq1r9mdzyUrL62eKLMf/heYpoOFhZ8Dg/1/+0MPGmF9YPlH8q8/as4QURLKb6prdUfRM9Wz2pBnLtH2qKSvcPExPq8rD36V7QX7ci3iSsnseU1m1t/A==
Received: from BN9PR03CA0164.namprd03.prod.outlook.com (2603:10b6:408:f4::19)
 by CY5PR12MB6249.namprd12.prod.outlook.com (2603:10b6:930:23::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sun, 4 Jan
 2026 08:49:09 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::6a) by BN9PR03CA0164.outlook.office365.com
 (2603:10b6:408:f4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Sun, 4
 Jan 2026 08:49:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Sun, 4 Jan 2026 08:49:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 4 Jan
 2026 00:48:55 -0800
Received: from yoav-mlt.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 4 Jan
 2026 00:48:53 -0800
From: Yoav Cohen <yoav@nvidia.com>
To: <linux-block@vger.kernel.org>, <csander@purestorage.com>,
	<ming.lei@redhat.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, Yoav Cohen <yoav@nvidia.com>
Subject: [PATCH v2 1/2] ublk: make ublk_ctrl_stop_dev return void
Date: Sun, 4 Jan 2026 10:48:38 +0200
Message-ID: <20260104084839.30065-2-yoav@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260104084839.30065-1-yoav@nvidia.com>
References: <20260104084839.30065-1-yoav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|CY5PR12MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: b4bcfab4-0b8d-4127-bd9e-08de4b6e2009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SwD5TnIz2DwUk9x0k3G+sGvB1avUDGZQvivVof6X9n7hY535W37P/2ncev2g?=
 =?us-ascii?Q?20cg8VxZPSyEbGQwtiYc6QiSL2zNIslAx51tW3Nh0JcKPuIURwErl/DZQSnw?=
 =?us-ascii?Q?4G/fITxzE4bI9tHx9Hn6lBdKHcyFJIOggCPAw88Sy7OGMtzgv7C2RAx36nvF?=
 =?us-ascii?Q?BKkqcVjY2QyizsCVlBULVipPsXwgwJEnr8oUDYxkQMC4Fls3Nf6Dyk3R40pr?=
 =?us-ascii?Q?5coWLNnJTfRmCs779zroLlFOwkmEysul/ACOYN7Ch5pmlTnlryy9OPXLCgrP?=
 =?us-ascii?Q?GvyXcd1IBapQmiJlpQM84Ovg4h2pCt38TJQZx6ie8WDtQHbW1GbV9ild9lA+?=
 =?us-ascii?Q?rbJJgW69ufijuIIPGU0N+VysH7uYYcz+HEwDdOKGE7sokn4FLRVvNsXRE+Qt?=
 =?us-ascii?Q?WhGpqY6pXVnyq8V6t+woqfLO9rSqLfC5fX1T4no+U5SUvY4w7f/zqK9ftOTd?=
 =?us-ascii?Q?kdbssUoGf9fTISGCSPAjPr1KW6AniesXwa0wvepDJEkV4t9wtgPoHxkneE7U?=
 =?us-ascii?Q?8Ssi+pV6TRx7Y9kX+PSgSbAt2VPDJNjjdDt2AvxyQtcPNJf0fg4tTE0EoD5i?=
 =?us-ascii?Q?mpu52PLScg/uIb+x0RwoKRdN5a93+xJW4DJ8Pd4N6p6tVoCowZETOzfHwGha?=
 =?us-ascii?Q?Q1GtPgOvXVbX0uLXCtNWyoChpVD6hihrS98K4h1zltI0PhTx5IjfIUEX1A/Q?=
 =?us-ascii?Q?uPCFBGp0cOJKvIrmWNPG6LhUuQVoHMpNjN1ijbBvNUoRYE1D11/LnFm7zggA?=
 =?us-ascii?Q?fEd4q1dBIWXgEGD8kOXz+2f+MiozuxNNKKIz6g3II/+heJoalenilqAVjJqn?=
 =?us-ascii?Q?+03VBDX3a19rH2H2CtXPN4XZv/22Q1LN6FJA9bCcsJFurwg/vZOb36mXPp9w?=
 =?us-ascii?Q?fpaNcPEX1ADw2DZSEw8C1N6omjEyLerOWPXox4l6RL99s++ECBm0EMzcA30z?=
 =?us-ascii?Q?JESAE6EnF769z7V2KIIYSizi0h3ATut13gr0wZHMJFQRL2sRIXqnhBQ2EY97?=
 =?us-ascii?Q?MHaYc74vm8eoYDH3C2tJ6VZWfoq146JpPCvvEgEbvpjPqwWF7kuEauJ0MUwc?=
 =?us-ascii?Q?Z2Lb199T+14Gtfw6BKEBnMVrInmg6d2VqKiLkPh2bIMHBFMfPwyQqjhHZJX1?=
 =?us-ascii?Q?tVwyh33qbTEbqBmMc4DVVikFsJWjqtLVGpDvpkqg7hn74W5P4/UvnAqqMTU3?=
 =?us-ascii?Q?2J4PInNj5CLg5dmv1kfTjBJjcCgRM5dF8LKHw0j867SgZ3KG4eCfjY/UCwRW?=
 =?us-ascii?Q?JywDG1oF+cs1vg4iEodl/v3KUT+uwlvRjHa0z/Pg9PUc7FQFNg+nabn4KIKS?=
 =?us-ascii?Q?HFwqLpicbbBcOb/UXQVkRPHcYowQXqsvyLMUbrYJqKhSeSJB6EkgfGLYbA3c?=
 =?us-ascii?Q?7hPMMN9c8OEF319S6ksoklFK4IRFCBZaFgl0PLOgKtqJ03o7PAH6cA++l5tX?=
 =?us-ascii?Q?2gcEdWjzhwrpnxHCV1wNmPUKyBO4AcRZc4Wgt6EOW4CAa3vAUfopq++U4PrB?=
 =?us-ascii?Q?i6p7uNwIhL5d1MFbrRkQOrQ7eoNyIu+9cVnfZB7dmjEz9I7TUgRWvuKMyhiB?=
 =?us-ascii?Q?Mf/Uj1vUTfetYSPp+p8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2026 08:49:08.7432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4bcfab4-0b8d-4127-bd9e-08de4b6e2009
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6249

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

