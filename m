Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013055.outbound.protection.outlook.com [40.107.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101A7238C3A
	for <linux-block@vger.kernel.org>; Sun, 11 Jan 2026 09:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768124751; cv=fail; b=ijNoyFtfyJvE7gaqKnXek8XyYP32TBcg1Eg3mbgiDAFISP+tOGamstYKfUliFxDEVqIlFURkd7ELRn2Ij8oRzFuHFwDu3Xobuk8iBlg3UA/F04aOqIgVvDxJHLgzjHGrYBmzRY2WouFrYZZwaEqsTdIP6bFC5g5/7l8JEBT9LZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768124751; c=relaxed/simple;
	bh=oHKOACg2At8o1UY+V+6TqjccrjIX6qm6lNrZtj8JKNA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gaBkbwHGZr0ah4NYZWx7gJVn6F09L0IyAvRoAlenoeQGgVIgLQsfnmMROfkuofIyqT4DHqrZ/a2rHbnzE3mmSz2iIFiC5i1FKVz9ibC10In+ZMrDgsHZMlsY8+hfd3ZIh2bHvsxMCjduX8BSw8SKsXN27J5FMcrZqR24tWQyi3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ENTysbQx; arc=fail smtp.client-ip=40.107.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ENTysbQx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBGEkH4yBPvylqh8i6+Cke89xeNEg/CcXYVy9rKEg6+CoBOwzS11V/+Xdc+9PYE5wUxWabXlwFlgcSFmwthlZVGZVB0/y1LdfDRaVQIRON7xU4vVfGFhf+W8sOyp93rwBT/PZQR3+taYAgObtRq+68um6ZXfFWp2j5ElhvdYI0fGM2BaRqZ5eEZtshE7YgKCgNul1rXtw48+IgNoSJtPCvdIj2Wvvb0xytPoPW17INYaQM9iCsBkzVDKBSBbEUA1q4MI9M0B7VCo33tO8ZJgY0g9R5ZaXPYFeL7LJy2O0gDNI3Ms1bQsE4fgBKQBrER8f2mQXY3QnfQxGFBfX4e/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OG84x3F4FtW0xaQ7MeBqZPDUCPuIm3si7SjGtnP7YtQ=;
 b=t+WocOIjy/ApedENLpAinBOYzq+VedoS72yeg8e0Yo53056xoZIfpmGyHmJZKrtfu7YkkeS4mk+vrDe/v8yVhtxXR14UCe4Hlv/FgZnKOntc4r6y6XrzrUbkT9X5l83C3Vyj4v1kCnfybIvvzCIsVpnHta4zqDDA6Y5a+JRQROVJnZJXYlRKfNvzt4k+k5FCQfqGzzglKFHDhyzmYMJBifV3SrnO6biqdTFG5nXo5p5dI1dSIbc9ljE2BaPA7khp7Y3iXCU8ihX/eF7BICnFDbjszl1TTya+CXF2foc/gHIGawOW6AJ8vn1KqCQ8gk1Mo8rPX2W96SG83uS/EMmpyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OG84x3F4FtW0xaQ7MeBqZPDUCPuIm3si7SjGtnP7YtQ=;
 b=ENTysbQxWqB8eFA4YkHEIbHABuGlPKyVCdsonkIN1oLVUnN97JgqJiTvW6VLZT4NkCPgwoMw+SkMWf1P6CD54YFAkCvrygHQ0/+Q0qUTyOlO97itw4jPDN8/+4su3QI3HCpcBQwzm5ASF1pDPNU8hwKb2PK9E1q3e9IdRpouhc6PG6EzIgLtVXuK7FdPTMP9TXmWyo2s9EZPJ4XlTDhC4R+mrcGSuaDmIzWnsLDD23FpsNSmnnxtDViY4TUC5/2g2FHL5YGo2YmBdmUEqrLBRa03Hqh7dOF49NVal6VjU4pd6zFo4Z6efyTfoSc/mx5mjjGBaB52vetE2zJ8j5qzeA==
Received: from CH2PR19CA0016.namprd19.prod.outlook.com (2603:10b6:610:4d::26)
 by DM4PR12MB6208.namprd12.prod.outlook.com (2603:10b6:8:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 09:45:46 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::32) by CH2PR19CA0016.outlook.office365.com
 (2603:10b6:610:4d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.6 via Frontend Transport; Sun,
 11 Jan 2026 09:45:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 09:45:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 01:45:28 -0800
Received: from yoav-mlt.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 01:45:26 -0800
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, Yoav Cohen <yoav@example.com>
Subject: [PATCH v5 3/3] selftests: ublk: add stop command with --safe option
Date: Sun, 11 Jan 2026 11:45:04 +0200
Message-ID: <20260111094504.24701-4-yoav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|DM4PR12MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: 3779ee90-14aa-4193-9ef0-08de50f631be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|7142099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PE8aU799ywWgpd7RHb0DzkiOw11dTYlVRG5hnYSEOC0gnEuJYuZwFqkK+4j2?=
 =?us-ascii?Q?QYnchLFtcKR/u+WHV7cbXFG4AQCDnPckV+ocAACRdes0kVr4UkeOzkig6cjG?=
 =?us-ascii?Q?gVct3lLXRQTCLdLm6EBylMsQ5OI1G4sR3yfQZxMOnG4vHW2O2dkdFOwwCbQL?=
 =?us-ascii?Q?XikstNAYL462TD+fDVNIthTgPDQqtlrgIMe7dy1kpruDtdBAyYceVlRKsNES?=
 =?us-ascii?Q?LsNK3s4DmxOvHoqcOZ/r8bTFqXF2VAL/ze/HBlGmf2wjMA0iM6EKLKj4fo1z?=
 =?us-ascii?Q?K2JmEuj4J5RO2YT+11leq6LL79aePHTf0e//tBKQqBwk0Xj0yA0rBQGz0obE?=
 =?us-ascii?Q?HNxOcczbLvIgSkydhpKeUW3axQ0ko/PLw9e5JinLdGXgKVfgCQc9AkRyRHGg?=
 =?us-ascii?Q?iWsfh0BNgjpwnNcsDY53UO3FDbxtN8h+3u7BQQFn1ksvH98h0wh8N28md6k9?=
 =?us-ascii?Q?cN4lOR84BLED+emDQfaCITOyIyVsAWJtoVdhqMP4MOJ66w93H/dvT9wgHTgq?=
 =?us-ascii?Q?P0uTNrdiQjJIcAMzc38PrU2RUzqMG1WyVJMV74r51F4izLL3BatExpNFd1Nr?=
 =?us-ascii?Q?57qTVEDWDaqleHpZaLADCNyjVLiMv1290Nbr3gsnIZue/BCgJcUK63pq9PL4?=
 =?us-ascii?Q?mdUqo8rHwvmOVhnGzgGHOvrzSpQoE+6VulhXFX2FXpvTbjiJRQPknSuT3epH?=
 =?us-ascii?Q?E+FOM0AG1JEstBlaD05Ew5NrNKCyY2TmLu51q/wBrpeABnZCK3rvw8Lmki3i?=
 =?us-ascii?Q?7BTz7isSMt8h2ZrxYs/KvVmjbW4/AIPmQFCpuQHJgQDSnPza5dPYhvXl3mZR?=
 =?us-ascii?Q?ZlqECiv+4s4vdk7H2LdmkwCO0Zn0AQy7hk/4JgaxOrkRxuMUv6GMQPC2u+Gf?=
 =?us-ascii?Q?lW/lR2mSPJMm/skX5KSUngfWiqz6xNMeHwRxlnEvf7TxfCbgbFmFpJFc+ffu?=
 =?us-ascii?Q?sSMteiA9eOW6+evIwPy6tG/T0BemkwQe8D0BtFIzennomiq5N1IiRt6AtLk4?=
 =?us-ascii?Q?MfGnEvdR2p9ZzQc9jnaiKRwMvd9jLT3/NmDvz8OFWIlhlM9zm0Xm29xzYORt?=
 =?us-ascii?Q?+WuWnMjpIJb7SvhuzVV3lMeHo8Qqzs74+GJWHNmxhF3bGxt+eZdBC26Pr0Bm?=
 =?us-ascii?Q?XV3J49DSWkX0ITt+2jvVcwp853YHNV7IqWgHpDdXAwY7uDmTZlRcTRzm1YfH?=
 =?us-ascii?Q?+44JXDcIWsDKCXXK7uXcCWw9GH6ZPrtW5c7LG7JYfKH8TrKwU1ksZufo34A/?=
 =?us-ascii?Q?Bdq+OExUrbTOjZ3lN9LDWYuTdqPPuv9hqy/dYGrSm207POtyYUkg/IiZdrf1?=
 =?us-ascii?Q?6DsVCaYMGACAZPW93V3x/NXEO9D4HXHpVqO5Kyfw4uHH55UdHHFNZTMmtIHV?=
 =?us-ascii?Q?OfDUkO/Gq31GNjfoUZ+kSJph5hu+WR8RxRsei/i9LfCtu5Luz2jTsu8eM8mp?=
 =?us-ascii?Q?FLCVIeGW0pDooHxkJDIEW82/QhGK0pxOGV2uVumP49nnQxPCpg8uC4cpmn8v?=
 =?us-ascii?Q?yHIO7KpyYRSuWQ0zEq+IRCQzs8MGJnF1kcUyDwjaNSfa/0TuT/UpPo4Tm9YI?=
 =?us-ascii?Q?zOGNNIbCT9VfZ9g899o=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7142099003)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 09:45:45.8361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3779ee90-14aa-4193-9ef0-08de50f631be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6208

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

