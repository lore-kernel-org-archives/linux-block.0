Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF5533A717
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 20:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767731656; cv=fail; b=e8wZxBZMgIgFfD3hAZ/qcDBIq0bFoXuIxogYfAmM41ZKTcnEIA8iiTNMfS6clqXGIIHoK/AdJH4+lJ0I+D+2mAQg5X8UNiRye4CKRPinzCLp8ybl1zlfBnFs1Wf/wt/zB5e9zLiAhVd1c3ftIJgPDmVrptYUt4ZpO7KSuCuPLak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767731656; c=relaxed/simple;
	bh=nZdvFp2oJcMHjbI+PLasZh18GqMiBbq21xQeuSNWuLw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b5yjQgZ1aB5Fjwb/JwQ3nITZR4frfFxKBGLR0jzfRQrGgkXJuk2ZFph0VRNtqvqWZgSRBY2m+YS7aKuK3W4gD8d8Ernbi+N+UnLbIAMztAw6m3PyJEf8oTqewTPKSh4KBkC30zMh5eez+KWO6H1Ry/k3zUPuUjiT451EkauOCX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jUQnccIT; arc=fail smtp.client-ip=52.101.56.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jUQnccIT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZE6av/Kmd4Gx7PbxE7WVcmi7I4RoprlzxPK91bH+YHwO5ykQJEa7ouDoJJQtxryx1691IRkedBQT+rETaHDJlnzEAE1e81MxqdDK85TRfd5XLXnsBi+j0v//S4z/5mTIyexYGlJ2qd8bpkPwbgH3FY3G5bkiU1IywtEKoNP02KOpa9sigJOfaRe0msqQOEMIxDo1kRbcaWWl+deKwCcGA28aAI4xJ4wfLKbfTsIZ5XLlHv6/YO7oSjpq/NTpkJ7ab0cMeeASpXxqECtYDa3sf9YOgk0JV8dyM0jHZ3OSJWXxwXp7D3az2acOkQfH3ZjHVf1bi8hr/C/PR8CxZ25otw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOZGP2pn7WVQJLWgZGqMetV/0RWfcB8fT5k5vJm0D4Q=;
 b=nZ9ulLrxW3iBIcwQGbCI/lw5G7sFToa6ANVMHHqew5wyOTVxcK+vyYhp1uJ0Wgffe8b1qDD6N9UFM2RyPd/OBNmBEpuuKw/6NjuxsgSuDE9bxznlr+/PRyfOatTuYkrCaekqh6plz9DvxhhSqfGOG1LXtQuka8c3FOupgApxrGUR8FqF0MZ1sm5m7396KcKAYv0SpM7b9vIGAqHMZCGVWi4PTTg7ByMhVhJTKDqXeRHwjLTyBbP2/ja/34T50w/HUsxG34NdaTDp26gL8h+WpgTaLE0f9ElGk6sfi5bdGSINxmZEO3AoDOSq1RSuJprk4B6juSlIdeKtXvQddLXZ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOZGP2pn7WVQJLWgZGqMetV/0RWfcB8fT5k5vJm0D4Q=;
 b=jUQnccIT1MW2B1xu4Iw1k9oT98zquCXAUxmEED8zVu+ekPk4JtXtNFyY/fS6/1P0q9d/CMX/Qo/L6d0BTN3keAdYorLrmcWlln3Fl6ougoTYhIii0+YgKhNAGYYRh3hNRSslOAhxj/kwgsbPdWYV5sH+69we5ElZDH4j7RlXAix8B6JAFdClp2pNnl8tM2FAQJY63kQFZI1aD9lc1OL3CISEfYmPRMNm31c+cI1U0jTxNq6W0vg/1II4fhAXsP5oxAVT4gKa3mjLsp+xfWshmtfvxEok/N/MfPDXzBOGIt+iTVC1iO4iEk4MPP4ejgI08yVBKzadvMNTNjdxtu1ygA==
Received: from BL1P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::21)
 by CH3PR12MB9145.namprd12.prod.outlook.com (2603:10b6:610:19b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 20:34:10 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::b1) by BL1P221CA0030.outlook.office365.com
 (2603:10b6:208:2c5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 20:33:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 20:34:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 12:33:53 -0800
Received: from yoav-mlt.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 12:33:49 -0800
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, Yoav Cohen <yoav@example.com>,
	Yoav Cohen <yoav@nvidia.com>
Subject: [PATCH v4 1/2] ublk: make ublk_ctrl_stop_dev return void
Date: Tue, 6 Jan 2026 22:33:32 +0200
Message-ID: <20260106203333.30589-2-yoav@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260106203333.30589-1-yoav@nvidia.com>
References: <20260106203333.30589-1-yoav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|CH3PR12MB9145:EE_
X-MS-Office365-Filtering-Correlation-Id: 99eb906a-6f20-4d49-734a-08de4d62f249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iXZc2GYlTBcdfWEMEQCcTx4iqQSCD5G3M6/+eAB7pxCyzgjSCMoQdJ8iLn0u?=
 =?us-ascii?Q?3ka1ebTzWuy4GrBfvPavvapfIBbqkUPG9n4ZAsswq/WIRD2XwZq7KqLiNteS?=
 =?us-ascii?Q?j+9FQg4mL6mqOxPmdh2U09DbsNylstancoSi1BKArgc6RJ+KGMbkvaPG0CXb?=
 =?us-ascii?Q?66PrJPJlt4j/swouAaT/vhKtCNti59opyzRlxMv7nv4p5P/SyJdalyVOWDBr?=
 =?us-ascii?Q?LNzC1YEzcl+j5lPXXhyBuu9g2PqwRGshKcIKNdOs3jWx633Sn9PHNpqjKKKo?=
 =?us-ascii?Q?h6AO5Fp9GmcrCNxc+2TmhNibhe3Y+NZ0mN4xrTDdgjumqnYyE/G6s0I7maOl?=
 =?us-ascii?Q?XPTRvtjhFkpeFHCM3yWUgzcVv8UvaE25mjDvsQn6VFkB0HB/NNdRIUAKtWsq?=
 =?us-ascii?Q?27Uk2wsQ/8tFTY66VfodQizwoi7/7sz9rBs8Z1ZSxtM74aXDlDdNgGBwj5E4?=
 =?us-ascii?Q?YC1rWG7jTx7OwvMKkl6vEa6ZbD0H0ihG3AK2oSZtNemyNvDsXx5Pp92+wXZE?=
 =?us-ascii?Q?uDw2VGbhTieD57O74LkH2wdTqa3s8xgjm8W9YP7aVYxg7GsJjhRW7E/0uUXA?=
 =?us-ascii?Q?y0tpZSoztiiM4rGiPnxS8zVnlQLETLYv6nr9Brmy99B2ODBKnTuwy5Xe4dsn?=
 =?us-ascii?Q?S/4LNtJp2GfGoJTpaNNaRiQxHisymP7CxHnHELU73AHIKc1A9DQvQ5tzHQin?=
 =?us-ascii?Q?sj/Y5Kfzen1r8NaXFtUYaueaXqP4AuWzktNOWLBd/RG2xFPc1d3X581drNfX?=
 =?us-ascii?Q?CFBHMESaP3LluRmKXsfB5/p84EfLa2s/PstP3wPoW+kYGTmZt04s3IgpderR?=
 =?us-ascii?Q?9gXa2uwMwFp4liV82o43uxYYzPcKgyVetooqU8mC+kpvMkRdMpm18s0o/uqG?=
 =?us-ascii?Q?h0YemBo+1a52MXuI/Vb/CRmwHEE8XGcujH4ne1vD9Ibgrx2fXt4sNyFqrrbH?=
 =?us-ascii?Q?hxOIN4gVMRiprkrC3/kQPN1N/b83DJV6tYDFHcEYw1pP39RC8u7kmixdhtW2?=
 =?us-ascii?Q?2kwFU/q3swbM58drnEb2xrTQip/o4BmOdIynS+EeuhhtNJ03sC2NnI/U6w9E?=
 =?us-ascii?Q?Lhw8BkegDlm2Q1tl5uYR4wA4T9zDHCusCQ4P+cx6PB+s3WM4wcpoKL57gJ3p?=
 =?us-ascii?Q?DKyS/Ivv2PTxM6lCOiNonui+KYPwTFUaDtpA1kKyn5Efg7bshtv3C5RTKXg7?=
 =?us-ascii?Q?RjfmFL1u4gL4rTitmsu1Vfc+PFaNBZGnVzRkvztV0PIGnfYjhe5A6tEUQPVH?=
 =?us-ascii?Q?bDeGkrC6O3gAoE4adY2de71hER4XwpjIl6jkZ9SJq/HbSaAzr1bVBMFEdCZ9?=
 =?us-ascii?Q?i6+Ynk3ni/0JNblfA3+XJ5o7fWvqG6UDIcG8g2aeFzV1wgTEENCsxnnLaowT?=
 =?us-ascii?Q?7R4kC3fO9Uon4++XRaFi8GgiQhSfzYdUgPs5F2JzjZ7oHEyr3Q5SYxy6/7Ef?=
 =?us-ascii?Q?yRRXXHf8KgsZWZJITCtxCnWqZnhfGdXdgj5+/FjLr8kogGqm2RMOkEJEk5H+?=
 =?us-ascii?Q?2aG0MNCdDwHr0OJFjX6oVhO8OBWkrw3AAoK0jiEYXour8hmgso0xMHBBgi6N?=
 =?us-ascii?Q?MlhfNdt/r5DDQY24vQ8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 20:34:09.8381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99eb906a-6f20-4d49-734a-08de4d62f249
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9145

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

