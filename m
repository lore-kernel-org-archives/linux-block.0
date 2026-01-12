Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013006.outbound.protection.outlook.com [40.107.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538EA308F28
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 22:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768255558; cv=fail; b=qsbF2BeeZ6Kn/0ZUO+p9M4cluOgOouVix4vPZcX5x7FmglZ2bfMUtnvCImzc/f+h0lFA5SmO2Y9KTt5SBUM6wxXg6Ksw3Dhyhjprys++uCkfC9ByugiOJQAUoV5jXD5bi1KsUA7dU9nMweQuGj9PWBMUqs4DWXSuXfLW9n4y0Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768255558; c=relaxed/simple;
	bh=+9hHbYBq32bWRKAHNgoGWg4xbim9My4dSeGNS5u+BWM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkNQRpXrgFSK+QvMiueMpllWBtpxQ83Qa8wY4wGNsgFlllGhSzfhihVgN81aHRAclv0IFtz4FiLZ7BQy/pXAZMpS4vvFcJLq8jJmlG87q/F41IvIqC/bhNp79OC0nNAxyswNNS0DtP/76qULTA58hIB+K1MxqPJ2PnogyQPgyGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jlvrqc1x; arc=fail smtp.client-ip=40.107.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jlvrqc1x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vzf6iM6FCjc3NEmzNB6B4DlsfHGCWsY8ArhbLPmexmcdpjgBTzqQaWsUwEQ0MDNZ5vvok0Rlx/1ksd09DpnDO82hplq1Uxc0n3Miuex+zWpurGDLcudD1Zg4FDPyA1lKUpJ2tuiWzeaBZ8ms2V+e9U36sOmWgGdgrUw8CjeRQGm2oX01rTe7PiiJhG8YPluxrtP+bAyORI3Ux/gihB8F3GggQY6s0WauqdzCePoWQ+y7+BcOFEpKQv+/2Jc1QaOJgmZCzzburqLOqnRiUCng/5O21uCPT4AqBD01DQGsEmk8HYrWwlffHyKru5nWYIaboJMq7w2zWyRrgeVVNiGQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxA7/zJHQJ+GB3JCeEYmt6BBjDdEQ2w4QNDZYxYpI9U=;
 b=MnEMrARQlLJAcATJTtzhDpKis45IurlnltkJRhXsz3mXxMCJcaAFO+0GLojyO7WUuD6myZaBFo5dZiqkHfKwvNl+dyvIIwNUxQXMadNoUntMg4PY7HrawvEVfdqY59gcT5G3PBV3rOS+T3sMXx1/bgOqXHka13OSCBBPG8dhKA+eb/BWvfiUV74H49+lVfPB3RU0jHERh+O5z76L+ivKJYbAeZ8s/4YB3FxTXdVUGHT5mf/gvKeSxc+5XiANWAWI0JUt/qaBqRBvTxnEtn00lYSOOQC+DetTEeWjoRZJ0mozLVPyu+MYhOLiUC4tGZRzziRKu/dGWiQ9Dx9enloRtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxA7/zJHQJ+GB3JCeEYmt6BBjDdEQ2w4QNDZYxYpI9U=;
 b=jlvrqc1x0quyeO+8tjfPJSj9HKtY3EJJZNfeJLLEMlG1TQAOrWAQF/6NScv6v7MbjD2TIGwJE80Z1Tgr51ftVgzKtCQCYqhftMnY9EA8vUHyT+/ti57YW0AgWjCsGbPn6GtDhEpR26XD2fDAyZ8pceUel9xl6gK5iWoQzs0xp/DGJaiN3wZR3BkVu2H3caNzDznwK4fAxiR6MuQwLkgRhwRb5gX4eB/b1O5Dsug5gAxgoxZ1DdbgZRp0YS3ZjB0c9UnbkQ/VirD/q7KA0eEhQv1cod4bWo9v2F+F7Fm4XrQdFPfdDx0HXIdVpgaDfa6VKulvCn1SwygDY/ZjA67inA==
Received: from SJ0PR03CA0051.namprd03.prod.outlook.com (2603:10b6:a03:33e::26)
 by MN0PR12MB6247.namprd12.prod.outlook.com (2603:10b6:208:3c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Mon, 12 Jan
 2026 22:05:50 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::fb) by SJ0PR03CA0051.outlook.office365.com
 (2603:10b6:a03:33e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 22:05:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 22:05:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 14:05:27 -0800
Received: from yoav-mlt.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 14:05:24 -0800
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>, <alex@zazolabs.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, Yoav Cohen <yoav@example.com>,
	Yoav Cohen <yoav@nvidia.com>
Subject: [PATCH v7 1/3] ublk: make ublk_ctrl_stop_dev return void
Date: Tue, 13 Jan 2026 00:05:00 +0200
Message-ID: <20260112220502.9141-2-yoav@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260112220502.9141-1-yoav@nvidia.com>
References: <20260112220502.9141-1-yoav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|MN0PR12MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d528c71-dd70-49eb-6d06-08de5226bec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8KNnCtj1n+NCpkudzPzttpLX4RFGTnDkUVQPUim0r9mAhLSOIwiy0zfponTI?=
 =?us-ascii?Q?S+aWUEsOfa6DgSRrEI3iOm7UwbKSqU09TStF2OYRGKXQ5/GLFJKvLzF1D3M7?=
 =?us-ascii?Q?Z6aXXmq761qTNAeQAZYkQ8XeBliVigIIm3ILy47vfmrMMi0ZSbEhzQQlIGGQ?=
 =?us-ascii?Q?5yBOiMScdhyhdryIM7xnBsAvviH9Hgdf26q5icgZk9UC0G3FeHQ79H1uaKc5?=
 =?us-ascii?Q?RSNAENobkawOYjBd9PfKlIEGHwWedMpYlhY7kG3i3Fhkpc2mNxV/jB+NI0+A?=
 =?us-ascii?Q?cd8j6g5oIzw7P7CCLpNhmORutIyWhfSYDrybLruIe5dln/nrtMwmObH6YyHZ?=
 =?us-ascii?Q?fIaYjQwIn6JeNZO4gSkU+bkVcYthP1dl+tOdZYtRQY05FhmQnk0Zo0qUxZnm?=
 =?us-ascii?Q?FcFNpyhwbMU8Dri5KPhwhznOeo2hViZzzt5GctCnTxtlSBbzCgEzWz6garVZ?=
 =?us-ascii?Q?oi85pj7FiefbXzRTYfanbtugDD1vJAI3lKu+2lI8KEr+SoL7skJY0hWUbLtH?=
 =?us-ascii?Q?zyYEgyyuVntzM1KUgNSk7VOgII1bdPRhtF/5z14d6j4CjgqyTr7juIZCxkAo?=
 =?us-ascii?Q?BxzhtFk8yrWewTfTtAGg7oI6vHby8ejpO2UDBmcYXpNzaowmmr2agF4vk59Z?=
 =?us-ascii?Q?vJR3MBxi9uDIovapWISkC/zoTAuQckLjOKiP6AOqSC1yhUGLPE9newPUzjf/?=
 =?us-ascii?Q?8Wp/MrjY7v/igEQTTCZJ1ZKFUJ8es9c8kxAKwLdsjxsCfhbfh/+TsD2D9Q/a?=
 =?us-ascii?Q?QKVFgeO/iohacLIC1DGc7B9z2mMhS4cHWsqnp78ZLfN7FDAR1uIhbYicaY8G?=
 =?us-ascii?Q?gAx9550lQuyuAaZi40lCmj3YyRlkuP1YmxwNklzrJDE8dartf8P8dp7vG2Fp?=
 =?us-ascii?Q?dsaSKGOlsIu2JUKAzqcpslYn4au1ZDKrj9QRdiMd1p1ehCfyUmYQlacUA1I/?=
 =?us-ascii?Q?sVOrEU6cu4gcUsFkLSbuoTkAbof8ouY8zlphxNRw/o8Cc4cRiW7ax8xX8l9f?=
 =?us-ascii?Q?dh7unEKD8OzGl/LPwCQa19IGh8tWB5wloQhlHw062iH7wPqDgODDzWuvp2Te?=
 =?us-ascii?Q?v3Vm6Yrarv28Kl3N8+qlozRJ6w9DY1ordjhl6M1f2QG47ZTyGZIJJy6nDQXK?=
 =?us-ascii?Q?qi9OSrr24xsCnkNjT6VF99+liEx0TJa+mTfFnftYsJ02bitHglXIgJ0CqXXb?=
 =?us-ascii?Q?qy0EUufK0W6Sviklies6qEH/zbwj8nLy43iWyKyoyO76xbofsl2FLRQ/LlSd?=
 =?us-ascii?Q?alCa0fx/IVXuHIydw2fX6wyqR8aI1EbfFr7CZJgbwT1IRnrfcIs2pOKBou9E?=
 =?us-ascii?Q?0+oG/xMcpXeKB7NPlw6xXFlQfCcESN3k6+AFasr7Mq0S8s5joKX3IVawfGRa?=
 =?us-ascii?Q?4U1A6tvw9rViZvkAvpkUBrl2otuf8DfEDMjzlU8IzZPcNcV5p9gUjEjRFePh?=
 =?us-ascii?Q?LoyG3xXJFWf8bdHtM3ZFNwY2OTEdnmAsfxCtPearbYn6ytw+4nsmfJ+VQGvu?=
 =?us-ascii?Q?NWVNBIVbE/7n+d2deByjIEqsmOOz40GBVF/lGip6VPZKKFJWtAvpOXviPkq/?=
 =?us-ascii?Q?uQSc1lOWfy1a3ADqA5M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 22:05:49.4636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d528c71-dd70-49eb-6d06-08de5226bec3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6247

This function always returns 0, so there is no need to return a value.

Signed-off-by: Yoav Cohen <yoav@nvidia.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index ec96d5afad7a..73490890242b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -3459,10 +3459,9 @@ static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
 			header->data[0], header->addr, header->len);
 }
 
-static int ublk_ctrl_stop_dev(struct ublk_device *ub)
+static void ublk_ctrl_stop_dev(struct ublk_device *ub)
 {
 	ublk_stop_dev(ub);
-	return 0;
 }
 
 static int ublk_ctrl_get_dev_info(struct ublk_device *ub,
@@ -3935,7 +3934,8 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
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

