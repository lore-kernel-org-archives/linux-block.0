Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012002.outbound.protection.outlook.com [40.107.200.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A45A3590A3
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768225064; cv=fail; b=bLBA1pc/eILT6M5qqbNOBbZ/wVl05F/07vk3KbhhpAHDpFFteBhMlDVZyRXg1woBsi55Tu+rjyiJAbDFdJHgoqU9JXLrCmLavAZCVBW1ecenC8D/1Aj5+adX6AnX1Jl75Zrgiw82lD0Hfz6JCcPvLfu7E41aVVp/mU0hQdWLSLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768225064; c=relaxed/simple;
	bh=oHKOACg2At8o1UY+V+6TqjccrjIX6qm6lNrZtj8JKNA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EV3yZqP6V04H81cpwnCzt4HrtUHb/wSsi4EPd+k+Xe130j+6doMOP3tG6iVF51kn81qXR6YnTRXKqThPdcuJJJHBJdWh5DrYeu1KfZZWuDoUAsFJtvkLk3bXDodwXOfPQZ9TlGWUCNvma63whSrdKMQPkWF5CuKa4ksJAWGSamQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sf3TSWfY; arc=fail smtp.client-ip=40.107.200.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sf3TSWfY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHP63aB+kLnlhyCf9FxprpFxMMvx1vu4puWSKV/1c9IS1ICqB2CmqY+W72q5W1yp5swcKqe9TdTAvIFZZ0jsrN92vYVyxDiIWWC7W/6LJk3Ex/DVaZLcdKE8ebf8yFy+s2v1x7itueFDkJjNN5QFBR+IZ50J4vpKGjHXaoSDvvPPqYmK5qPc9GfBtyZDoZVBL14SAInfYT71mqFBjhY5hPDJ4wd5fGvZYVaWlF1F90O9jRxw7u/SCAIxWKCHd1XjmSQ4ty0cIsR1QNXexsZmAcx882nKQXmBpxWe4i52Q5NXZQ3Rp/vKhgEilmrssrVAyW3DQVl05dzHg7E3cNNXug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OG84x3F4FtW0xaQ7MeBqZPDUCPuIm3si7SjGtnP7YtQ=;
 b=qlL6L5GYC+MzevgjudsNfBO6rhpmYw6m8K1CkOjIz0bXL4HWNJKmwNfeiMD+c+tpzgw62ZbOO4DKwu52i//k/aL1vUsl5cetGbzLI7LzfBTA436NweRx7EP9bqnCRBacWo5SYy4S7EMjeI1KpxMwkqG5cnG90m3QVQolHASrTQIaq6kZdcqFZy53sHvxB9RMwkJy6W0WR0VR1hABW/VN27gSHC5MxdAnQfoq/5ryi11epZfebFf1mY/E/99L4dwNaTy8tSvNWSPdgIsqNp6Ua9n+Uskyd/ArKF5C4uFaQURIduhC+PHTjXeymOM9HyWFHR05BI8kV+IDAAD421G3ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OG84x3F4FtW0xaQ7MeBqZPDUCPuIm3si7SjGtnP7YtQ=;
 b=sf3TSWfYCsthWjL7q/CfD2ILkwKtLy5h8q1l4OYYBF6uq9KCGFDM0IlVHZtBA25wz+EGcCnLawlnOQiU47jIgQt3fdCL8cTJeL0csXswQ7mML9vAIs1PXQlkj7VYwAOjnzVXQr8lVvOOraJL2TQU5g1QFT416jBoTQz4+5xgZ4pb0bGMx7SQXTF1J2PxfdTjdjN1Dbk4EuYGeYseCgf/IPRESpOMftoXhww8ujuPsSCZLN2w3wnj4H8HiMQhdaeOSAEkDkfUYfnBIJsN6UygzWnvsvCNrRpvPFtvkTxvb21VoOBYBsO2eJhEwfgN4Ya2vuUgPeJjeFJV/KYZiQmBEg==
Received: from CH0PR04CA0052.namprd04.prod.outlook.com (2603:10b6:610:77::27)
 by SA1PR12MB8118.namprd12.prod.outlook.com (2603:10b6:806:333::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 13:37:38 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::d6) by CH0PR04CA0052.outlook.office365.com
 (2603:10b6:610:77::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 13:37:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 13:37:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 05:37:19 -0800
Received: from yoav-mlt.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 05:37:16 -0800
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>, <alex@zazolabs.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, Yoav Cohen <yoav@example.com>
Subject: [PATCH v6 3/3] selftests: ublk: add stop command with --safe option
Date: Mon, 12 Jan 2026 15:36:47 +0200
Message-ID: <20260112133648.51722-4-yoav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|SA1PR12MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7a7f0f-7df9-4fde-d95b-08de51dfc03f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|7142099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t771rNcGnYlLEDHERF9b1emytZ0VEXp6+40S9jusIJmTOp4rkoP/YujWnJGl?=
 =?us-ascii?Q?1Of0uhowIb95OyZKGtn1QT5tvWWCsSscIrce/WN5YQXCY13XQ6rl5GE4Whcs?=
 =?us-ascii?Q?KkFP10wIsO9FjWUYsorVJ4ZiKBX4NRFCTrFGQ4IZH+XHKdxbqXUdPW8ReX95?=
 =?us-ascii?Q?W7slvF4cG+PxzzScqPeW8RnKo+PO5FBu/CSaH/K9se7+ujMean5sdxCbQazJ?=
 =?us-ascii?Q?sWw5PKCBVF+qYI+9TZcdxbstSKJsXvaisYR7OElnCdz1SSqOt7/yJ1Jm+ex9?=
 =?us-ascii?Q?iXRQeG1vRALKMQDmRQL7ow+ZC9YSqjRrg1YcIZamtD81/jgqzO+Noi8fZV4S?=
 =?us-ascii?Q?oL8b9KRWqVfQm4/cNdpN/+kT5tV+UhSw982D03IZ62iya/XNtFpkTfL4Evhl?=
 =?us-ascii?Q?PdqooX3U/+9KC/hMBAu25VngNWMqC08anT/Kq55qGFyt6pYSlCSEgmFb5WYW?=
 =?us-ascii?Q?uUXLmgoWcjdggrQ7x9ZRzSsmcjS+bwBrqDIVlHfKh1UMPe/bPBkudLm8qECJ?=
 =?us-ascii?Q?kU1X7IgDYy3xRGRbF2T+hGVWsuWs3IraLIuVLbryVxBpR3tniykchEQq443k?=
 =?us-ascii?Q?tCK/rx/0eXVehyIENPhwNUQYiQJQaYqWpPlDVOpD794iPSDAwwrXW0b3Pt3b?=
 =?us-ascii?Q?JbixskvsmUpw3uhCel1YwNHfAvhoDtNzv1zexqb7eastICtNW3slfDRCVnaE?=
 =?us-ascii?Q?QquWi9ViMXdzXi51d8FrAb5UYmRNBDvLXmgZbWqmrYBZKsIJ4wykbn/pokAS?=
 =?us-ascii?Q?gNF2ycW/epJuccK9VWBlhThZHHCSeHp7UD1Je+ZK7MvPFRYxHX5m5WJNlnfa?=
 =?us-ascii?Q?mSM3akIL6MMUjto7A46M6oTLSCOHsKakPj3JcIfTQ3mRQCjWBM1yjAe6jPCC?=
 =?us-ascii?Q?QYF6v18KILUWYt+sqXwahOABF87a7HTsWrU6mYvsRqRZvmLW3bbUthX1+UQi?=
 =?us-ascii?Q?qlgOeuhOAzjl0CMWhR4oUSZFJAwSefmzCS6ZWBb6/yAVlRuBS5y8fBsD9DjE?=
 =?us-ascii?Q?zwdBA4zpPJi1FUVJRL+Ufmqrnu+5Ui7xGIeABWnqa4eFS51wkAeZSXhONCoY?=
 =?us-ascii?Q?/eyHY9LntiQ2XOjLQOZrVyK8EPJOqHL2QWGmWCiydi0LamAhYzsEyPtaTwk3?=
 =?us-ascii?Q?h8Xu/BtXvs3X/7PeMJT8sZrzwLlKSAvykGaFBHF8NbXTNs6c9AO5MO3pOxuV?=
 =?us-ascii?Q?W/sXGuFELh6g8a2rX+fWNz+UjbZkGgPooyZ9MGlZA9Zp9HXK/vSTxWgAtk00?=
 =?us-ascii?Q?tDOPSNT/OSX2eDubsRb44GSMwcH7GdsIQ+y80w6AxVh5BZ2yiFZuC23UsmX2?=
 =?us-ascii?Q?5/j9oaG8Hqwa+5y1rJR+h2YYDL/DrbS2vrtkx3lMFN2j/FZOFlWesx4+MKby?=
 =?us-ascii?Q?MSd35bK0iX2vosPHQTc9Igg7ZtMzU0hhVKE1WDHKDFyzzIbNBLvEpFjjAEiT?=
 =?us-ascii?Q?7UgyEFOUrILYfzeMKe9aBZQsDPTBGgXN2eKVnAsBdlGpLe+sNUuuQlAv3zOj?=
 =?us-ascii?Q?5qCEbgqMtnGtu8h9XDEgeQ/0lSwDPDK4Xw5McCAzOO3sj4PEV7Z0LRjmhVno?=
 =?us-ascii?Q?Q2xylgtNuQ2VgA6OU+U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7142099003)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 13:37:37.6707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7a7f0f-7df9-4fde-d95b-08de51dfc03f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8118

From: Ming Lei <ming.lei@redhat.com>

Add 'stop' subcommand to kublk utility that uses the new
UBLK_CMD_TRY_STOP_DEV command when --safe option is specified.
This allows stopping a device only if it has no active openers,
returning -EBUSY otherwise.

Also add test_generic_16.sh to test the new functionality.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |  1 +
 tools/testing/selftests/ublk/kublk.c          | 53 +++++++++++++++++
 tools/testing/selftests/ublk/kublk.h          |  1 +
 .../testing/selftests/ublk/test_generic_16.sh | 57 +++++++++++++++++++
 4 files changed, 112 insertions(+)
 create mode 100755 tools/testing/selftests/ublk/test_generic_16.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 06ba6fde098d..e9614f77b809 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -23,6 +23,7 @@ TEST_PROGS += test_generic_12.sh
 TEST_PROGS += test_generic_13.sh
 TEST_PROGS += test_generic_14.sh
 TEST_PROGS += test_generic_15.sh
+TEST_PROGS += test_generic_16.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 185ba553686a..c217745b0523 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -107,6 +107,15 @@ static int ublk_ctrl_stop_dev(struct ublk_dev *dev)
 	return __ublk_ctrl_cmd(dev, &data);
 }
 
+static int ublk_ctrl_try_stop_dev(struct ublk_dev *dev)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_U_CMD_TRY_STOP_DEV,
+	};
+
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
 static int ublk_ctrl_start_dev(struct ublk_dev *dev,
 		int daemon_pid)
 {
@@ -1392,6 +1401,42 @@ static int cmd_dev_del(struct dev_ctx *ctx)
 	return 0;
 }
 
+static int cmd_dev_stop(struct dev_ctx *ctx)
+{
+	int number = ctx->dev_id;
+	struct ublk_dev *dev;
+	int ret;
+
+	if (number < 0) {
+		ublk_err("%s: device id is required\n", __func__);
+		return -EINVAL;
+	}
+
+	dev = ublk_ctrl_init();
+	dev->dev_info.dev_id = number;
+
+	ret = ublk_ctrl_get_info(dev);
+	if (ret < 0)
+		goto fail;
+
+	if (ctx->safe_stop) {
+		ret = ublk_ctrl_try_stop_dev(dev);
+		if (ret < 0)
+			ublk_err("%s: try_stop dev %d failed ret %d\n",
+					__func__, number, ret);
+	} else {
+		ret = ublk_ctrl_stop_dev(dev);
+		if (ret < 0)
+			ublk_err("%s: stop dev %d failed ret %d\n",
+					__func__, number, ret);
+	}
+
+fail:
+	ublk_ctrl_deinit(dev);
+
+	return ret;
+}
+
 static int __cmd_dev_list(struct dev_ctx *ctx)
 {
 	struct ublk_dev *dev = ublk_ctrl_init();
@@ -1454,6 +1499,7 @@ static int cmd_dev_get_features(void)
 		FEAT_NAME(UBLK_F_QUIESCE),
 		FEAT_NAME(UBLK_F_PER_IO_DAEMON),
 		FEAT_NAME(UBLK_F_BUF_REG_OFF_DAEMON),
+		FEAT_NAME(UBLK_F_SAFE_STOP_DEV)
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;
@@ -1581,6 +1627,8 @@ static int cmd_dev_help(char *exe)
 
 	printf("%s del [-n dev_id] -a \n", exe);
 	printf("\t -a delete all devices -n delete specified device\n\n");
+	printf("%s stop -n dev_id [--safe]\n", exe);
+	printf("\t --safe only stop if device has no active openers\n\n");
 	printf("%s list [-n dev_id] -a \n", exe);
 	printf("\t -a list all devices, -n list specified device, default -a \n\n");
 	printf("%s features\n", exe);
@@ -1612,6 +1660,7 @@ int main(int argc, char *argv[])
 		{ "nthreads",		1,	NULL,  0 },
 		{ "per_io_tasks",	0,	NULL,  0 },
 		{ "no_ublk_fixed_fd",	0,	NULL,  0 },
+		{ "safe",		0,	NULL,  0 },
 		{ 0, 0, 0, 0 }
 	};
 	const struct ublk_tgt_ops *ops = NULL;
@@ -1696,6 +1745,8 @@ int main(int argc, char *argv[])
 				ctx.per_io_tasks = 1;
 			if (!strcmp(longopts[option_idx].name, "no_ublk_fixed_fd"))
 				ctx.no_ublk_fixed_fd = 1;
+			if (!strcmp(longopts[option_idx].name, "safe"))
+				ctx.safe_stop = 1;
 			break;
 		case '?':
 			/*
@@ -1763,6 +1814,8 @@ int main(int argc, char *argv[])
 		}
 	} else if (!strcmp(cmd, "del"))
 		ret = cmd_dev_del(&ctx);
+	else if (!strcmp(cmd, "stop"))
+		ret = cmd_dev_stop(&ctx);
 	else if (!strcmp(cmd, "list")) {
 		ctx.all = 1;
 		ret = cmd_dev_list(&ctx);
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 8a83b90ec603..4b6b4992f78e 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -78,6 +78,7 @@ struct dev_ctx {
 	unsigned int	auto_zc_fallback:1;
 	unsigned int	per_io_tasks:1;
 	unsigned int	no_ublk_fixed_fd:1;
+	unsigned int	safe_stop:1;
 
 	int _evtfd;
 	int _shmid;
diff --git a/tools/testing/selftests/ublk/test_generic_16.sh b/tools/testing/selftests/ublk/test_generic_16.sh
new file mode 100755
index 000000000000..e08af7b685c9
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_16.sh
@@ -0,0 +1,57 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_16"
+ERR_CODE=0
+
+_prep_test "null" "stop --safe command"
+
+# Check if SAFE_STOP_DEV feature is supported
+if ! _have_feature "SAFE_STOP_DEV"; then
+	_cleanup_test "null"
+	exit "$UBLK_SKIP_CODE"
+fi
+
+# Test 1: stop --safe on idle device should succeed
+dev_id=$(_add_ublk_dev -t null -q 2 -d 32)
+_check_add_dev $TID $?
+
+# Device is idle (no openers), stop --safe should succeed
+if ! ${UBLK_PROG} stop -n "${dev_id}" --safe; then
+	echo "stop --safe on idle device failed unexpectedly!"
+	ERR_CODE=255
+fi
+
+# Clean up device
+${UBLK_PROG} del -n "${dev_id}" > /dev/null 2>&1
+udevadm settle
+
+# Test 2: stop --safe on device with active opener should fail
+dev_id=$(_add_ublk_dev -t null -q 2 -d 32)
+_check_add_dev $TID $?
+
+# Open device in background (dd reads indefinitely)
+dd if=/dev/ublkb${dev_id} of=/dev/null bs=4k iflag=direct > /dev/null 2>&1 &
+dd_pid=$!
+
+# Give dd time to start
+sleep 0.2
+
+# Device has active opener, stop --safe should fail with -EBUSY
+if ${UBLK_PROG} stop -n "${dev_id}" --safe 2>/dev/null; then
+	echo "stop --safe on busy device succeeded unexpectedly!"
+	ERR_CODE=255
+fi
+
+# Kill dd and clean up
+kill $dd_pid 2>/dev/null
+wait $dd_pid 2>/dev/null
+
+# Now device should be idle, regular delete should work
+${UBLK_PROG} del -n "${dev_id}"
+udevadm settle
+
+_cleanup_test "null"
+_show_result $TID $ERR_CODE
-- 
2.39.5 (Apple Git-154)

