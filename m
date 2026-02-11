Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F22B7262F;
	Wed, 11 Feb 2026 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770842933; cv=fail; b=Pkv7BXdWgaT/AI9+SkCiFRWlbLRvhsP9wk4TbfVPYQpmoR9H+hukUIH6WkbpQq0CxvcJK9subHRW+eIu/T6MVTmCZJQnaKQlZkMAx5I4Z+pChg4EJK2kOyHmwQk1ZEryryT2TZqyWl6/tapLXdhZXqwQjUKIEA2f0Qg7laUdVeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770842933; c=relaxed/simple;
	bh=0aSKmLEm1tocn/Gl0bHZ0EwduinbiOqZvbfAPvmITLM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WK3t7wvLvdS/qtL3d2AZ5HoVU2GJ7vT2kb+vI3L9zzjNYSNilOvuBqgmukNCGgQafjbDJ2m5buKpYAmMB9CfKpvbOS80JNNL3GEZKoQG2VrMDZJXlsXWxsIO/mfTFekAXrVjfYAcP+AkRpaVgXLDy7qtw1r6+limB0/p85pi9+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ggcdmkuY; arc=fail smtp.client-ip=52.101.62.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ggcdmkuY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYKjTX2RzpwC2uWBUB2MbSjAKP+ht8my5EX+9Y6z5m5mF5Z2n1P9idcblmi7NprfRh5QLMKGsM8BLZNUuTbHas1tV4mdfzX43jBT2z5I62JfUqDXbfUXXsrj0Qbx5kNy2JCGLMF+b8Qqe/tNwNv/hKFBRtbuNvouu19HBZNdz81oOFTxhaXOKL+U5GgmBxJgyWaQQq4OlUUU+eO+UBt9qCl2oTvobm7W3ThiPkT4eyQNfWie8sg1AoIzGsr/Jq2KP1bPdp2XtNa2UlijBZnkbmY6S5f83ghDAYYB2A97oGIcc2BJcWmh3C8KZHnJuzS/+8WdNGoMsWLrY2e9vnKMTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32Kt3VlWRMq4jXlCipCj32DGnhgjxN6bu98uIUEbqOg=;
 b=yHqj+ElU8axVMqWR/GaMouHYlnkroq1uet0Gi48wGy/AOOUOIk9blKdmFkyqyhjuqDmUskwlNb9w9XnwjhstauS55PwrW1rd4dX2eiVPo8AEjPkdnEbeJR/zybedg0yIM4dRLZBO4q+ZzvIsnDgJ7kPx1X+aeQj01WKe9IIQfJM5jHiY0rr33WRF36GePdrDe8mnR7qWzTG7QvRthlxfqZGly07YGBpbyt0RvZc1fz63tp8J13rNfg353jeHXqBoZRxYWXWbwEXWuU/2OaN4faX92Qfs64jUCzu1ZwcIaWMvL1vBuspgUs6TxU58Ssyx7LtmHAQ8Xja45wb8YTDmOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32Kt3VlWRMq4jXlCipCj32DGnhgjxN6bu98uIUEbqOg=;
 b=ggcdmkuYNIf+TiaLWZ89lGBbKhexX0lv1vflN65EKDffI5PMtiWmSb44s6VtTRVT7a2OltWvb+RzxhXCznXdsD+RkyZmXOBk332v6Q4epkg4fRj2x6Dib58pubQeIP96jTU+UgUyyUXmTukmhUJHgUU7+1/VAuw07km232NcK8yjCE41HiVeXTqyt+gCfzwTV4ZZMLUVhJcZ/zwfeiexZo1aEy1liXwlftthge4FpNBtOqK3PmtcxOH+Y6C/qLrXExdt5HsEpQxQYdFCaWsZVHGqd20/bBhfX4n8+dHBlVsOzCAtrcB7vXCyDDE+ICF3/w76DB10IWlWrnaW7mbtmQ==
Received: from SA9PR13CA0101.namprd13.prod.outlook.com (2603:10b6:806:24::16)
 by MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Wed, 11 Feb
 2026 20:48:41 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:24:cafe::94) by SA9PR13CA0101.outlook.office365.com
 (2603:10b6:806:24::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Wed,
 11 Feb 2026 20:48:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 20:48:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 12:48:20 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 12:48:19 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <axboe@kernel.dk>, <dlemoal@kernel.org>
CC: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<linux-block@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V4] blktrace: log dropped REQ_OP_ZONE_XXX events ver1
Date: Wed, 11 Feb 2026 12:47:52 -0800
Message-ID: <20260211204752.23061-1-kch@nvidia.com>
X-Mailer: git-send-email 2.39.5
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|MW4PR12MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: 655a6d2e-2e7c-4e79-cc43-08de69aef06b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cxyQjqQEylFwx9nf+SG/HitIUIiUguiTIWcTgFrKBI2CVzONfTU7W0poaTdI?=
 =?us-ascii?Q?xY5ArM7TtfuUZqmXeyaYkT5c6KKHYNSrYaOLXbVD0+76CTSd0iW7t1Q5AXhV?=
 =?us-ascii?Q?aQHdpC9pqiljXcmkvJe4D7PUv9rCmgYr1vEXEZbzuEUn2DXMo0rIKpLvjgRk?=
 =?us-ascii?Q?TO7pWkj8H2xogektY399phOm7e9pFvdoaf6C3hIAk9pAw3iCqcJeSDJVkAff?=
 =?us-ascii?Q?oNy8CMH6M6s9aNn0xoNVVcCXWIcsCkvVkr2FMbluNIr4d61J1uQk4VxBUM4O?=
 =?us-ascii?Q?VspdNB4q1iAA+uP7JZcsemSgC4f35rhIO7i176nCdsclhsKVr6QwMaGHlMId?=
 =?us-ascii?Q?/oyByyrJoLvY2oHtBqK/mUGvcdl4hBVTJD6Ha4/PkdtiNF/qwbh5cATwN7SQ?=
 =?us-ascii?Q?FDrIqZUJcHu2/0sq+GCBODGa67UjKJfxO70CN1Uvvya/mXNQNxpf+I6FJu4J?=
 =?us-ascii?Q?Wu1XOL9SbQcIGgxsF6+qO5KMjV7JaYw9l+Hua+fmaUk3qiDisQrbpKTalAcQ?=
 =?us-ascii?Q?yCzddTNM5n2YJgUgisC15G8qwPBn9dSQ+ONuSKu8G32UVoOCwQlLluhViAfE?=
 =?us-ascii?Q?9N4UrtkSPg5hOvxgjmbGpAUICPrSnnerc/lc8JxmledJkkYOmSRmxX0fEREE?=
 =?us-ascii?Q?MuA9+cBPTTYkhNXuP15YtifkAV5zCgX1d1O5+v2Onlcieq/VT3ltfgZoz4dQ?=
 =?us-ascii?Q?0w90OChLKYtLVTYn2L2C+CQ38QNeMX7GKwLKiISw5n5PKnRFeDkSIXuJF8w2?=
 =?us-ascii?Q?IBzW4iYSoKZRXKFmHw8gNdP6xFlc2iEyLWlyFF2hoDOpKQsS09qoUUfRd+rP?=
 =?us-ascii?Q?ReZ1Hqorcphxf6hYaPI+3+KHbi2LMQCnNqDXcRfkypjJTpLySKvQyxj5lwrh?=
 =?us-ascii?Q?51SDPhlKQx6sfDlKVCLX/Xep38GAm6/96tJsW3YiGz7Y5Anrouuq0VXtMNuN?=
 =?us-ascii?Q?pXuCPa88uEdiV63wbecOVSLzDWhg5m/7owBh3T91fB8Y/m3KjoqhfdCIm8XN?=
 =?us-ascii?Q?zeEriiTnwayrVLEPoznNZVWXEs0gMID3IkvW6mUMY6zGNwubMOa3It/9+VmS?=
 =?us-ascii?Q?XmzKd6OdDqn98cIwjk9UQ3arxVNEGowvMaEmm5K4WFERU0czAf6J/9S3u3V3?=
 =?us-ascii?Q?9HrLfrJPit5CM0v/NRAdvTY0dFaQmh12ezgH0Rq/nZgJ4Fmm8YyLjpOZ6N7Z?=
 =?us-ascii?Q?OKvtj3npXGGpJZZndZcwXFIU3LLMEq0gqrcibIpgi6B7mbDo02AO42K4jfqi?=
 =?us-ascii?Q?kfHtkV3dFDrwTbjsGI7+NvdsDQCt68UswvSdfnLLmyCUjjrax78hSU0x0oBw?=
 =?us-ascii?Q?XP5gXUA+16BWbYj25ma4VBgGqWvwDgIY1LIs2CGkPV3PU/+WxtMQctEV14W2?=
 =?us-ascii?Q?aw9BXhgJOR+y8Ttjapv5glt/yHgLjtWjP3EcjXJJcsfGikumHn5EWfogHCC/?=
 =?us-ascii?Q?5Sd2HP5T5J7kWcrVszsZg8eU/NXUvfcFPTnxVPYkJ7+9s8D634yzUZ2mlbKk?=
 =?us-ascii?Q?hdWNcE3r4jroVHkhIJCBSdy4BV0OZujrpimEJBhke0rzgAlAcCOZfT4GH3g1?=
 =?us-ascii?Q?vwX2aNyGPAywvkeLZi2wB4BKPYl6/OyOQ8b2yYO9RsjCRjbgK+97v9vBxap3?=
 =?us-ascii?Q?LCK4xniRWTTq2cakIYL37XJMrqxgQCpPr0+YyFvGg3xU0Age4fY/E2ZFFTmt?=
 =?us-ascii?Q?d/YtXg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FUSO/fSklpZ8cgUvxNX9e0zAjbBflMfLzW0mMiOoMlliXZ9kXkZBFBNmnHd6eUym/pmHMzusKji0P26Hyb6cftvoEQmWLyhpdqZXWpE0jKFULQhU38JpbTOuenQ7WMUW0YSTAHxGymYWFEjmXDq9/2WRyjK9mnuOGZsKqCIiUEfOLHKznW4dhg3AE8DqkBMMY7t+xNNLblMowYuzxopAXnG/eE6p4n7t2cZGRCwdBsJ3Xdr8d3NFBGB1jOFtgT/Wjd/2H370fVnvNhQgwRwR7d5Y7M9R+mId22FG2KujzlNzX1+Qv1wUvASfDeovVDgLMbTumFAFxCAihBLroX2YTIoAl6131eAYJd023+ZIeCqE8OOFFliAPDttq9ET4mpH9psShG2/aq7bt9fNSMA+mHCSLM8VECRM2xab6HsY9/pxaBDPl2U8CVpUF1qQXfFo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 20:48:41.0578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 655a6d2e-2e7c-4e79-cc43-08de69aef06b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949

Add informational messages during blktrace setup when version 1 tools
are used on kernels with CONFIG_BLK_DEV_ZONED enabled. This alerts users
that REQ_OP_ZONE_* events will be dropped and suggests upgrading to
blktrace tools version 2 or later.

The warning is printed once during trace setup to inform users about
the limitation without spamming the logs during tracing operations.
Version 2 blktrace tools properly handle zone management operations
(zone reset, zone open, zone close, zone finish, zone append) that
were added for zoned block devices.

* With old blktrace tool and this patch :-

blktests (master) # ./check blktrace/
blktrace/001 (blktrace zone management command tracing)      [passed]
    runtime  3.706s  ...  3.735s
blktrace/002 (blktrace ftrace corruption with sysfs trace)   [passed]
    runtime  0.479s  ...  0.456s
blktests (master) # dmesg  -c
[ 9455.610899] null_blk: disk nullb0 created
[ 9455.610916] null_blk: module loaded
[ 9455.634103] run blktests blktrace/001 at 2026-02-02 15:02:23
[ 9455.651710] null_blk: nullb1: using native zone append
[ 9455.662852] null_blk: disk nullb1 created
*[ 9455.714998] blktrace: nullb1: blktrace events for zone operations will be dropped*
*[ 9455.715065] blktrace: use blktrace tools version >= 2 to track zone operations*
[ 9459.480181] null_blk: disk nullb0 created
[ 9459.480199] null_blk: module loaded
[ 9459.514464] run blktests blktrace/002 at 2026-02-02 15:02:27
[ 9459.541772] null_blk: disk nullb1 created
blktests (master) #

* With new blktrace tools and this patch :-

blktests (master) # ./check blktrace/
blktrace/001 (blktrace zone management command tracing)      [passed]
    runtime  3.735s  ...  3.734s
blktrace/002 (blktrace ftrace corruption with sysfs trace)   [passed]
    runtime  0.456s  ...  0.496s
blktests (master) # dmesg  -c
[ 9490.395572] null_blk: disk nullb0 created
[ 9490.395591] null_blk: module loaded
[ 9490.419467] run blktests blktrace/001 at 2026-02-02 15:02:58
[ 9490.436416] null_blk: nullb1: using native zone append
[ 9490.447806] null_blk: disk nullb1 created
[ 9494.262176] null_blk: disk nullb0 created
[ 9494.262195] null_blk: module loaded
[ 9494.296653] run blktests blktrace/002 at 2026-02-02 15:03:02
[ 9494.322261] null_blk: disk nullb1 created
blktests (master) #

This helps users understand why zone operation traces may be missing
when using older blktrace tool versions with modern kernels that
support REQ_OP_ZONE_XXX in blktrace.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---

V3->V4:-

Replace REQ_OP_ZONE_XXX with "zone operations". (Damien, Jens)

---
 kernel/trace/blktrace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d031c8d80be4..04b41c698127 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -741,6 +741,12 @@ static void blk_trace_setup_finalize(struct request_queue *q,
 	 * to underscores for this to work as expected
 	 */
 	strreplace(buts->name, '/', '_');
+	if (version == 1 && IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
+		pr_info("%s: blktrace events for zone operations will be dropped\n",
+			name);
+		pr_info("use blktrace tools version >= 2 to track zone operations\n");
+
+	}
 
 	bt->version = version;
 	bt->act_mask = buts->act_mask;
-- 
2.39.5

