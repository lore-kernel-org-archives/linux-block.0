Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012033.outbound.protection.outlook.com [40.93.195.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ACD308F28
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 22:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768255570; cv=fail; b=Yqi0R1pZJgkyhnTEA9mTRiB8kUo3mDDOwdfZsurfc72PcEnxy8eJ+9tUnez+jqMqHa+/Zfgq/HUsCWxpsIBKtbunHDARNEZx04SRC5h4RICC4a+TuqYNqpAcBjm0oNKc3HWT7DKZG/u0XBx3HPm2jAYanAzzoDSPuss28HgorHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768255570; c=relaxed/simple;
	bh=BJ1YhUyFTWYi4+I8OQ2F/GcjU+JCqeMe6NEh1jTnHjo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZPojNC+R5AhpnVDDh6vtmJqKgwj0OvE4PDulM84OOiCiAR+KEcP2yuhbfxS5QwAdB1WWXK2DTWE00x04QkDJ6kkI00kvqSuQMP/SK5t/pPxgta8ovcFy8+84A/4W+t6WW3wVb3A8MrviUmiZH1gGQBkl3Sp7S7b99jLLLhmWcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R+vnu832; arc=fail smtp.client-ip=40.93.195.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R+vnu832"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LkTPGUsV+B2hVOOvSov/3pLZx/5o0QyUje/OfsdWfnpzRiEYb+7vI4TW+jlaGUrCWMygPT6+rU0ncd8pX9BPYiK2htSUhiLIun13RQOFpFjfB7QKugMTcTMfc1OQokdsQJdCqUWs9pF4MSZVvLAL2YSNvEo8R4xFREWzY136QO4y3Pcn3PfxrtTjmwN6CpUeLqoYtrVzHKEG/EvCcBvuDxCDIdcjPFrWUZvEaghlUgaCt+BFpduyiblpGGyRDtP20AjUuAfdr3+nm9kaNkgjPV3LOpKPAkewDkAjbrjbJKOOnuJ6UlCe5G93I60bDQlMWTLJYpHGJDQLF8Y9q+LE0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdcV9q2iUVURxJRhxvqKh92WhXbbDeOszQG2rUaRsU0=;
 b=cRizcXSEjUCVt0C6ugbg/aiBfCfOMhkCuK1bBfPkvu5Q98rxHNA8q0WzHBlJguejjoARVgwiNsZnzXOK1hF3WQBrF3MUi+bTJOq6fepM6sKcMDjdlVFoxZKYiS3W/LTyuLyg+4BrXaJObpd+e8ICp+iKcEmXukbLUj5JX3D2KmBXvZsmDx+uUWr6b5o93jImGDFQSIG362k3ZTPRNP7fGVf2QzW4pVRKjMOW040DGiekJ0U6VgsdmT1CbG1kqcqzTZK0tfZ+j1qvUVCscC6oTCzbKHYY+q72PekakKXCJgmD0zUHWEYh8QYVCdMW8rLU+04mTtaDmaMLXkFhhP/Sww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdcV9q2iUVURxJRhxvqKh92WhXbbDeOszQG2rUaRsU0=;
 b=R+vnu832OMh0q+CuWn9sT3F+6G838GEa1SXawjAMKl33v/VP2TdSoXEgFJZly/hVJSVU86sFOe9X6sDP1zq4LmO/idrogp+ZbEz/oW9ncM/xh050gOeun/tiTv8Z9OzJRP6tY0qQPxfOp0Pk9bWAUYxpIySUNPWWXNfP0wcjGXt2jYQb5XvQieO1jIrOHeIVogNVwoxiW6APVdVqiz5mvtaSVwugGN8BKkxpT8zKnNxtcj/0xiBIYFzeFY5gYGPLMSG4u8bMQd2FFv0d8yd2AJnZXsrA9Jm6kJXl9hidiMP7ft1DppAVRc7JJCZoHE2cqKI2dhrJqLcuPYcJ3Q1v3g==
Received: from BY3PR05CA0058.namprd05.prod.outlook.com (2603:10b6:a03:39b::33)
 by PH7PR12MB7137.namprd12.prod.outlook.com (2603:10b6:510:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 22:06:01 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::e7) by BY3PR05CA0058.outlook.office365.com
 (2603:10b6:a03:39b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Mon,
 12 Jan 2026 22:05:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 22:06:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 14:05:36 -0800
Received: from yoav-mlt.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 14:05:33 -0800
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>, <alex@zazolabs.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, Yoav Cohen <yoav@example.com>
Subject: [PATCH v7 3/3] selftests: ublk: add stop command with --safe option
Date: Tue, 13 Jan 2026 00:05:02 +0200
Message-ID: <20260112220502.9141-4-yoav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|PH7PR12MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: d30dc774-da0f-402a-3af6-08de5226c5c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7053199007|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2TDpKJclTa/ktxi4sOSmwkYO9nAv8VfZB3XuDs33rmXBSBajUNz+1Vyh2tkt?=
 =?us-ascii?Q?XoHZk4QZuI01rYOs6TSF9wAdz3EMvAN54UCRrd/0P4hFgwpMpm9dgT3AFALu?=
 =?us-ascii?Q?O2IXy7hUsff7kjd6nMHqbv/Kvr6UQt2HMrc5TZnDKL5uGNXRG3ggibu/wTrH?=
 =?us-ascii?Q?K6VmfJTNWmYK1ik07rGcyToxVFOE9oxlceS+kv46EkC7j2lbKxZEglGh2Ya3?=
 =?us-ascii?Q?LwevKgswIinwKYE04P055S6CkmRZcvmvihCQPcIydUu3KfRuBUKMvVgD8gmk?=
 =?us-ascii?Q?v/+0yzH893+SF8rYWhstJX5cKJf99LIhdtkhdusZsLVJVA2h5ULxWkNUZkKV?=
 =?us-ascii?Q?H8YjNWrTFpaqJWf1ESxlZUUgUk7z38h2hbZsqtmSTVoGR+4A3jma/aOq5Q51?=
 =?us-ascii?Q?Q2UGTqAooDzWcIv41fS9pPrPlh/WoOXNSF4FiIAoI/c8yNFwx1GfvOmpjsUv?=
 =?us-ascii?Q?izxOPeJeKTLUS/W3oiq7bijpYy7IKyQ2AAsuJPiEgS+qKChVV2WHzWNn9sfd?=
 =?us-ascii?Q?41i/AKmxIjgph1nx0Jl7B68AtWpkRd51E69ap9QC/hjKOgtsPsOrAlKmBAln?=
 =?us-ascii?Q?/Qc8Roe8AVPW2IaZZ9tmORSwjzl26v3BXm4yDO8QFBb0kLr3mNdGKwX/4Fdp?=
 =?us-ascii?Q?aCrRZq029eWquRNQksrcOCQim+hMTSE85PEnJGTxU74fNh8ucJmSO+y6Elha?=
 =?us-ascii?Q?kDK0f5Fdw6FRXuMepnbMhYz9QrztnG6UMsJYp5KqnXsjuMGyjRespiE2gfOo?=
 =?us-ascii?Q?snG/khf6gIpjf+xYKBnTDY5Wd4Ezr2hJpb0gHlAmO1OJwE5weYcTwusuUvsm?=
 =?us-ascii?Q?cHE8RDcz3f5U93sQ74KYAaqaz/t7Bv9SgETMNjDkDcfvNH4ns+LDbV9RLB6W?=
 =?us-ascii?Q?XG/EX/tOwlxHL8rD5u2W30AJsqyuz44bg5kgTxFvLZondIa/VWffs2wlS16G?=
 =?us-ascii?Q?EXImo6GoifU2VJO2mOF3PmIEgiYj6xMZHT95IKZ9SchYItQMcy0pl96OGlNx?=
 =?us-ascii?Q?SAPeqClBYbtr6dMAeTGtFaRPQOycycNqyc1B/iGVPdHj/+QeMGBwotxLn6Wt?=
 =?us-ascii?Q?L85NM4NbnMQMxj1K19KDmzyUAejZZMCeKfEkcvkkNT2DybZKScLJyWdXvNzc?=
 =?us-ascii?Q?XKenpX6VEqjKhWHQuk26rhsAeymQbRfTXj00v5MoHyJxiXmM0WvidvI1jm5f?=
 =?us-ascii?Q?ysYYKnwmPV+fnpXJSETvU6nxmd8Y5Z9aGqW5JUCEh5IVFyJGVZgSFCKGg+eU?=
 =?us-ascii?Q?bmJ1IgEPvbkIu+BI/Ovr33g8zdjNHct/oztsw25S5ralIha72BVmmsUFnepJ?=
 =?us-ascii?Q?NilPCHrYERGLwU5dr9o+iVmDXa9Em1jtEIwje1f2kD97zRLh695Jy+iEiSXM?=
 =?us-ascii?Q?KtzjVtQyBq93FgZyPqwFX9FpmS3t6JuUZxhm0p75MyOC7BKzdI4RiGG2Zpfy?=
 =?us-ascii?Q?oA+xyGCE67Xp5QXUaNw95F7Al8PR8d401vcRbP159yShXc5KeQ9udY5Ep452?=
 =?us-ascii?Q?XC9qu8OA4Lg+7QlEk2Sg64Iqj3YyZxAbwsupLTS7pA6vN0ZerJQTBTYbgh5f?=
 =?us-ascii?Q?kZ/GS7MmGY0bMTuCRwk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7053199007)(7142099003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 22:06:01.2056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d30dc774-da0f-402a-3af6-08de5226c5c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7137

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
index 036a9f01b464..3a2498089b15 100644
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
index d95937dd6167..3472ce7426ba 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -108,6 +108,15 @@ static int ublk_ctrl_stop_dev(struct ublk_dev *dev)
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
@@ -1424,6 +1433,42 @@ static int cmd_dev_del(struct dev_ctx *ctx)
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
@@ -1487,6 +1532,7 @@ static int cmd_dev_get_features(void)
 		FEAT_NAME(UBLK_F_PER_IO_DAEMON),
 		FEAT_NAME(UBLK_F_BUF_REG_OFF_DAEMON),
 		FEAT_NAME(UBLK_F_INTEGRITY),
+		FEAT_NAME(UBLK_F_SAFE_STOP_DEV)
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;
@@ -1616,6 +1662,8 @@ static int cmd_dev_help(char *exe)
 
 	printf("%s del [-n dev_id] -a \n", exe);
 	printf("\t -a delete all devices -n delete specified device\n\n");
+	printf("%s stop -n dev_id [--safe]\n", exe);
+	printf("\t --safe only stop if device has no active openers\n\n");
 	printf("%s list [-n dev_id] -a \n", exe);
 	printf("\t -a list all devices, -n list specified device, default -a \n\n");
 	printf("%s features\n", exe);
@@ -1653,6 +1701,7 @@ int main(int argc, char *argv[])
 		{ "pi_offset",		1,	NULL,  0 },
 		{ "csum_type",		1,	NULL,  0 },
 		{ "tag_size",		1,	NULL,  0 },
+		{ "safe",		0,	NULL,  0 },
 		{ 0, 0, 0, 0 }
 	};
 	const struct ublk_tgt_ops *ops = NULL;
@@ -1760,6 +1809,8 @@ int main(int argc, char *argv[])
 			}
 			if (!strcmp(longopts[option_idx].name, "tag_size"))
 				ctx.tag_size = strtoul(optarg, NULL, 0);
+			if (!strcmp(longopts[option_idx].name, "safe"))
+				ctx.safe_stop = 1;
 			break;
 		case '?':
 			/*
@@ -1842,6 +1893,8 @@ int main(int argc, char *argv[])
 		}
 	} else if (!strcmp(cmd, "del"))
 		ret = cmd_dev_del(&ctx);
+	else if (!strcmp(cmd, "stop"))
+		ret = cmd_dev_stop(&ctx);
 	else if (!strcmp(cmd, "list")) {
 		ctx.all = 1;
 		ret = cmd_dev_list(&ctx);
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 96c66b337bc0..cb757fd9bf9d 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -83,6 +83,7 @@ struct dev_ctx {
 	__u8 pi_offset;
 	__u8 csum_type;
 	__u8 tag_size;
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

