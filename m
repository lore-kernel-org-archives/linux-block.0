Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF511318BAF
	for <linux-block@vger.kernel.org>; Sun, 11 Jan 2026 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768124733; cv=fail; b=E97xQFCM2+Dz7ewYXTuJUZROnqg3bZUY2mSa9rajXylqBsTsijrwGC+z1V1UUsmOUDqKGPjZoQjCfqG6glv6q8h0w0/FMVQVojK5YvhUsj28KXz+URmvxa2TBq/W0ap0SLbtgWesh3JT51lQ5fY0Wmi0u8+MZFpen4SDr6G8VoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768124733; c=relaxed/simple;
	bh=nZdvFp2oJcMHjbI+PLasZh18GqMiBbq21xQeuSNWuLw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PmMrYtO3Ozbwqvv/Hwceqmw885okA9HpD69a6xncO5cpC1dqywHovFiO4nz6QBN7e2nOR9VPW6casaxYzY+QK+KjDk3V19AtRw9ITqbAziZoFAALKkwrW3FKE6eh/Y938lnxI0Tts34YCWQnHQbxPib9n8k6VGpkSPL2O7254c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=liqIz9qk; arc=fail smtp.client-ip=52.101.48.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="liqIz9qk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zO2jdK/LoR4jyPJ3LBzSY0GK4l7StvoeV2NsIF8w2Fmc3tJ2sxX4BM9aOSgDARUEUIj5ThxZdqZyInovX5n1YxbeNaejz0p/2ElYWPh8KLh8GEvjvUu5mcFLQneRgt8FI5gXuBt1L5C/9p9p7bNON1lvYp2ACRaGTVz/8dFwi6rdQT5SMRzwIWibKPmlcg6Qsevvxpi92XSOvC8tcSrXXofHc/3rDi2ijH4KmZoE3gIAy2W919AF92OaxOqHLT0myiSRBDjuFjNSZB9lfK89Nx5zNA2WNru+IRmTZ/gcz4GDKNBYK4oqkoKJg4sIz5xl6fczRY13NHLavElgNtMH6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOZGP2pn7WVQJLWgZGqMetV/0RWfcB8fT5k5vJm0D4Q=;
 b=KJKbCvN1NvepoWE7RAiCYNeSCetoNJrKfienKuMYU4PQ6kBefPVN8nsvIfYwhR5oYXkUtX8+ylbz4IWylwHSAdEagiTdczAdwJHGrdfSUBIW2gyMp+5rA3YGfKV7KImUgOjpYV0ZIV7bji5UQXkvc8IxjSu4B5lJlMrWrjnbQTBa6ZbStj1obFhxUK4NdmC3HFFgATVq1qFq4UN68gwLU8vwbzupEIHM0F54O9r/xImJHgO/W8GgE0MFQpVTFjjAFvZu36R9YfczGc31G0TmPhMvUKSgIr1yeD2QfCUUr6Xdlv2sOHm2GAoXEnKZPU6JH5U+b63SqiZgOpQpYO/tVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOZGP2pn7WVQJLWgZGqMetV/0RWfcB8fT5k5vJm0D4Q=;
 b=liqIz9qkxSabBqMDOc12FTEDIwlZE082d+wOB37e20FuVmVXUlB3B94bN+eRXZO9PToqvGzbfV1wUVTiCuAy4k6i5MKRsMPAnYKdQwiuK5H1nZHJQEnbMS2n4Pe0XpfPOiUf1ZyujSFK5wgn0bOipUaIwk5XZWUpSS+EihvFbSAu2WB7In57yPSAXj8Zni3srPa0W9ckiA+VjtQXCdWHb7OZWAdn34S/1m8Y8NIYg9KDM1oT3T7NS+N8+vOSFkcpeSiTWOtpKx5ognPH1UkodsLCRX48WxEOXg3pVEOwuiMhsbr5P3W3gi1xinfQU43fhLABwOAQz6Ib5t/mh3VSRw==
Received: from DM6PR03CA0034.namprd03.prod.outlook.com (2603:10b6:5:40::47) by
 DS2PR12MB9799.namprd12.prod.outlook.com (2603:10b6:8:270::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.6; Sun, 11 Jan 2026 09:45:29 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:40:cafe::c3) by DM6PR03CA0034.outlook.office365.com
 (2603:10b6:5:40::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 09:45:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 09:45:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 01:45:21 -0800
Received: from yoav-mlt.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 01:45:18 -0800
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, Yoav Cohen <yoav@example.com>,
	Yoav Cohen <yoav@nvidia.com>
Subject: [PATCH v5 1/3] ublk: make ublk_ctrl_stop_dev return void
Date: Sun, 11 Jan 2026 11:45:02 +0200
Message-ID: <20260111094504.24701-2-yoav@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260111094504.24701-1-yoav@nvidia.com>
References: <20260111094504.24701-1-yoav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|DS2PR12MB9799:EE_
X-MS-Office365-Filtering-Correlation-Id: e4897692-0f1a-48de-2be7-08de50f627d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?igE75HCXyMtUzfUhYKfvv7HKGYgm/U0fAoB2YI/mMfl1Ir/n0rG0FhmFlcke?=
 =?us-ascii?Q?OWgMrmkZtnhqBQG3zWofVsU2A+uQ4ITNZLglsO0vIcXgFqLmGuqcjqKyzJBR?=
 =?us-ascii?Q?hCszm8qqq9986vwDjqLPjo4JplGJiI0hg97NwMgd+17LBZLRjrxOCBcD3vXV?=
 =?us-ascii?Q?woC8Aa5pGztxmKd1PeJcaCTB+cf52h6eQWBwbRlFlPFRIEQ/slpiVyHlksSt?=
 =?us-ascii?Q?Z3EtCiHqw/KpaW+0MDEs2vC+zMSUYIHuUMDub9EGhvETH4jyQi5RMdTZw0/8?=
 =?us-ascii?Q?sWZf+oYo4xx5gEEHBdfu3d5yFtbp0l6VUvNI2OT1qDUx4A5AqDgJGEUn2Qi8?=
 =?us-ascii?Q?xRjlX4apdszc7GgxNxlDW+faaO8fGY4E+K0MiC65h+YtpfT+LatqwLaPjyUh?=
 =?us-ascii?Q?oHnPsvzKUAEWl+ZIQnwzhr80L5Fn/3h2+UM7dKRfIRCnBT0Oq4ekRaeS+b6H?=
 =?us-ascii?Q?CpoursQhB5uzy0Ih1klCs+dt5isbE5Zm9dSwIME2L1uE/tnJG6A9cnCTViLC?=
 =?us-ascii?Q?XsP1JArsjQqhNIHvCi7retLzMcDFOCX5PnXnlf2HCnpwfAIUFjvnR59aL7CT?=
 =?us-ascii?Q?Qn+5tPztIEatSJvdDdM/5lYX6e6dI/y7HpNz9tJY+YjSeYosxGzRBfXEXBi3?=
 =?us-ascii?Q?xHVViZMSBrsDEu3FRTxHZdMNH9Gd/DpRrWpQxhRjuKEhMkxaxMjLxgboyfSI?=
 =?us-ascii?Q?+5dSMRKPPZfL1zMBW6TWDUkumP4nkkYzRNet8xROoo1b9MCKeK81dopkzbDy?=
 =?us-ascii?Q?WPapAFwd+rGiiHXNXNlG5e3IOTmFz8FyPZp374MKskqHwVxZpTfOxnq9rhYs?=
 =?us-ascii?Q?FX1MJ0DDvYFF3RCmyZnSR89+r9IzdVWc/dtxNItp6ili4dJ90QCebtACU8Hn?=
 =?us-ascii?Q?9Xx0H5qs13jjH3O6zHFxB7dNoopBvEoOrg75lKumyYFoVtt0oovbmp4mG2lB?=
 =?us-ascii?Q?ronvmFphhByf3a+CVcQeo2FagdGs6lxXkI1qzuRVFNPa0pG9p8LqEkLDmv/n?=
 =?us-ascii?Q?hjC6LXxopjkt43QggvXUAg9VdVcpyc/YMrtClmza9YzaSmGoy8ZEE+xIuk1E?=
 =?us-ascii?Q?rhmp6Bv5CHomu9THj0M/kSBXnbNVf1My8fpDt40WdThOIrnCY+LGalhrIRSA?=
 =?us-ascii?Q?6WWqOM3duOJA3JnB88qXZaiEVa3KvWCY0spDUZwc/1lM81Jin+lKk/tq12U6?=
 =?us-ascii?Q?AD6fJo//baJaVTsohBq3G7uO2QzZK15UM67Ajd4hQrn+aYSAb3Tlx6dMS8WK?=
 =?us-ascii?Q?JpsMp4kP57pZupMbF6Q9CCkwRRdKSov18yvl0X8v/pCuBv9S1vk/NBX1Wf/E?=
 =?us-ascii?Q?IdDc3m3+xRFESum+JzD+CoGLfW9JtUPQ/V8GLhjgn2YAp9WXyfLKUSusTsza?=
 =?us-ascii?Q?mnOvfBVyIolCL28xH+pfPiNpnIj8mvT1zOk1YENnlQ4+fe22xv4T8jhpwY7Z?=
 =?us-ascii?Q?5tG11wp2phtbJZMrV+JwKM0MSuur3YZzzX5TIRsQE9cb9JuaEI7YjcmGNAlA?=
 =?us-ascii?Q?3ApPf0eKqQDJ9dzsgLdHF2lR+keF6PrrcmbEzBQ3Gr6TZFPRfBhuzQ0iaSij?=
 =?us-ascii?Q?FOhXMKRpKbD6VQh3ybs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 09:45:29.1910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4897692-0f1a-48de-2be7-08de50f627d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9799

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

