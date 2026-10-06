Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010001.outbound.protection.outlook.com [40.93.198.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D6037269C
	for <linux-block@vger.kernel.org>; Tue,  6 Oct 2026 19:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791313512; cv=fail; b=juNhdg62LDJo3k4dIswO0mGZQAElVKArPGPJz7ZbqGHR2YfgbpYDNkIu0NW71l8ycj8iyztDiWLcJ76bpfPsLl4AxvknohqdQ567PaPeeBwi6VhoEmhQo/ZHyg6uI0MqbYYmFVG6dOuMdCGpZSclditHdC9vW5LXzCwCfOvnhQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791313512; c=relaxed/simple;
	bh=u2ffhxH0toMFWgL12r7QniyZmHA0vXCbHgNqf4dOiAg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bm06aOlX8eBU6cWYKp95eN6XxSLysO3qpcdaGKoznR7rrVi6T2bEtoJNHrf3zbXesg1BlNGb1IOmXA9fmo5AeH8gy9Tm8mjb+eKvBCKpfIPZgFN16mxmJGRfobLpOPtFObVHFJQc0QSXBjVOH19qqhp1ofljaBcPJJLrgjwANmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=olKc8LH8; arc=fail smtp.client-ip=40.93.198.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="olKc8LH8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bA2Xo0J7CLgQYt+fEKAH5uU5Q6Upo9VpRzlPDSNIrWLEczQ+8E9k4n9kdB3QWMltEBpqM35PcxbHXFPWmleSrZ1/ClnSD6Jrbl0NH2zqO6tO46e2zzjGbcSZP4ZPv5ZoVFOwfCbGONMGpgk9MEGmYrhEejKDyYogx+iVHxqgjvlieFiY1Bny9IdhrtaQb8Mc1hBlb6WCJhXcHCIoPNPBNFZzpSGhT8MsGsEl+9F2TzhhX8RbcNKmohPWmVLN6q7nRT3rKU0uv5X1A+hyCXZaMs2CaewPglWxve8jXKyF8NZ7QekxWYPHvRwOqV1eHIjq4YdOmLdmfp+gNQY+cZZSMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3nx1Fw56glWLME0X9jqBWRJTizFu7PPhAaxXpze1AU=;
 b=GQ4taJlkHrXjhhZ7KeWsBCl7MWy6X7z8jEn0EjXvmkossJge0LmP+LUxTrIYLFJfENwPZbOP12mIdPcYhqTMJtTU0gtxRflOW0IK4ym7DWqNyHCdPBS6KpUMgO5FPq2VghZIe2kOea3OLfFTw/W9E1jH2vQly4lgMWHo2DjEPCJsWDWahiWIV8aCnc9RWUnDlowuZfkyM/NTvRRtzUHsrBjEUNEuTEsCWsPtP5kjKTL827k3uqb7K7q4OmHIPZz3vqVlZgHu6azzpHqIfU0CIFaPBDcKoPWJYIYY/QbXUO7H1qg9a5D7cMIH7WcQSYklMsejMHRRVv2kz0VYm5tiEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3nx1Fw56glWLME0X9jqBWRJTizFu7PPhAaxXpze1AU=;
 b=olKc8LH8W1O1sFt1WS0ocwAPBUamX9PeBrPe421FRgN7PcH4FazwKz76WaYRBiQ+iUPs+nSi3U/6btldD2Rt5KNgQoSmnQ3cMWTEyBfbY5HWDEwMJ4aryim2/AURdjaAZRXmHPLakGH9V0+ngb6zX8KP4f1ynF9TaESX0oEoeoGvs13d5r7eOH1LXFDtN81feJO5oNjXRlGQ2YpgFL6NtvEfjtRA77QTxjIPCznKS8H9DCfCExOLZWApdrV7CN66x/o885PICZisMDPzkCnYkJZBvgM/kaRpwmUlXVD+0qzu6LM6+bLALY2aZtmp18G+LXT2CgzFIXeLa2DrIMNlbg==
Received: from DM6PR07CA0128.namprd07.prod.outlook.com (2603:10b6:5:330::20)
 by SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 19:04:44 +0000
Received: from DS2PEPF000061C2.namprd02.prod.outlook.com
 (2603:10b6:5:330:cafe::28) by DM6PR07CA0128.outlook.office365.com
 (2603:10b6:5:330::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 6
 Oct 2026 19:04:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C2.mail.protection.outlook.com (10.167.23.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 19:04:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 12:04:13 -0700
Received: from yoav-mlt.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 12:04:10 -0700
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, Yoav Cohen <yoav@nvidia.com>
Subject: [PATCH v2 2/2] selftests: ublk: add rq_affinity test
Date: Tue, 6 Oct 2026 22:03:48 +0300
Message-ID: <20261006190348.85094-3-yoav@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261006190348.85094-1-yoav@nvidia.com>
References: <20261006190348.85094-1-yoav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C2:EE_|SJ0PR12MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a616823-3c7d-4d05-bd20-08df23dcad17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|11063799006|5023799004|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	7z0gfnvVQo0vgKKprM1U4EzXUoTnUedTDY61XhiUPYBl46Wqu1m/agiM0Gt2Lx+4D0nDfzBrIIvBs7l7YZRE6SuRZ1kS6oPtQhKXyFrz3snpOJk/4OScC5qySO27ykAoWzXP5Nbq0Gaqclb1lzINsj2zcKaev91271WJ39r0NnfF1xq+ytzzCCd+1x11aNnlnlqQui5bHWnwZtbfd9Vy7Z9LY/jH2I19iC2HOf1IAZ7j7xG1UhZXFIC5xnCiSA63zkoFq1wUXLmp9IoBYMKT/0YITJLq58z1qBIEesSBgtPt5EMNSTd1JqxECI/SaeBW5y3Satw+fdlOjtk3E2oFYx/jtTsa5liZHCcqtBc6D0B7ixrUs9/nUKZaGP9f8R+DQUdTiKcpEWOB5mJdCuUs42PP0//PSoy+13AO16AIxFJ3fAU+Qf5gfc1gT/Pr93WyuqOvXjCr8xs0L0XS3OmF3aUR65crgr+bp1r+x01Ocy9FJslSOAuNU+RvcXpRuz2Uc9Fx0NwcOZrbkD4B+9uxUEYqetl++XxynUMec45UWVJrQEXsHBs3OOqCyonpheT9aEkfISbsm4Xe1ihdJJyTVrnCb79d3asMfJV2RMTEhMly3KMzIfu3LxcInPWIlUbYK8iSC7JYL3FgKKalLyA9g/6SOPDGQC5vxb9GPSErOdabLLySah/dk7q/tUlTgOsZYBWrnep2DFN0DiCQzlNEAw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(11063799006)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5WsRO9KfOZLuM00M8TM+je0iensOxkvW8EGTw4lFsr3bpsKTMUaCOZKqzKBpwbClxuvDuGCg7h5aUH2vl3SWT3ArLME6KgoBLzc+kwYhGvciuM7M6AsgvpMywbmYkchRHTtVBJm72CbTbywnJ4+bu3qs8kjCTlywUpR5+ADzZPeZAze+MWpIIwFRIcxmQGPfK8ZTUpWyKJWT5RcBp3tY8JvhGbY49Qi0VKvGMKHMcHbXop+yUBW+tysrzkb0amq+2jgDmZfA3IHGdVwSG9naimtRFD6dpGd+sZfHCrJ4GCR5/5SRA5nNwYWCeOEnOfk1x3+pyQpKnfw6K49vJ1rnAIY3d4hMHq1n5xUED4a2SCTu5M+BUMnbk6lyAJVqfMYxv2YWndcx6JVm50Gz2QkY9OOCUGPRsuzrc31XjjBlDzqlKHOlpFeAeSQDOnK61sLl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 19:04:41.2266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a616823-3c7d-4d05-bd20-08df23dcad17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5676

Add UBLK_F_SUPPORT_RQ_AFFINITY to kublk's feature table and a
--rq_affinity flag to request it at ADD_DEV time, and add
test_generic_18.sh: writes and verifies data on a loop device with
I/O pinned to one CPU while cycling rq_affinity through 0, 1 and 2.
Skipped on kernels without UBLK_F_SUPPORT_RQ_AFFINITY.

Signed-off-by: Yoav Cohen <yoav@nvidia.com>
---
 tools/testing/selftests/ublk/Makefile         |  1 +
 tools/testing/selftests/ublk/kublk.c          |  6 ++-
 .../testing/selftests/ublk/test_generic_18.sh | 42 +++++++++++++++++++
 3 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_18.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 37883e9d50ec..d12e9879b89a 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -19,6 +19,7 @@ TEST_PROGS += test_generic_12.sh
 TEST_PROGS += test_generic_13.sh
 TEST_PROGS += test_generic_16.sh
 TEST_PROGS += test_generic_17.sh
+TEST_PROGS += test_generic_18.sh
 
 TEST_PROGS += test_batch_01.sh
 TEST_PROGS += test_batch_02.sh
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 2400b4615766..e3afef0e7628 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -2083,6 +2083,7 @@ static int cmd_dev_get_features(void)
 		FEAT_NAME(UBLK_F_NO_AUTO_PART_SCAN),
 		FEAT_NAME(UBLK_F_SHMEM_ZC),
 		FEAT_NAME(UBLK_F_IO_DESC_SIZE),
+		FEAT_NAME(UBLK_F_SUPPORT_RQ_AFFINITY),
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;
@@ -2180,7 +2181,7 @@ static void __cmd_create_help(char *exe, bool recovery)
 	printf("\t[--nthreads threads] [--per_io_tasks]\n");
 	printf("\t[--integrity_capable] [--integrity_reftag] [--metadata_size SIZE] "
 		 "[--pi_offset OFFSET] [--csum_type ip|t10dif|nvme] [--tag_size SIZE]\n");
-	printf("\t[--batch|-b] [--rotate_auto_buf] [--no_auto_part_scan]\n");
+	printf("\t[--batch|-b] [--rotate_auto_buf] [--no_auto_part_scan] [--rq_affinity]\n");
 	printf("\t[--io_desc_size SIZE]\n");
 	printf("\t[target options] [backfile1] [backfile2] ...\n");
 	printf("\tdefault: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
@@ -2260,6 +2261,7 @@ int main(int argc, char *argv[])
 		{ "batch",              0,      NULL, 'b'},
 		{ "rotate_auto_buf",	0,	NULL,  0 },
 		{ "no_auto_part_scan",	0,	NULL,  0 },
+		{ "rq_affinity",	0,	NULL,  0 },
 		{ "shmem_zc",		0,	NULL,  0  },
 		{ "htlb",		1,	NULL,  0  },
 		{ "rdonly_shmem_buf",	0,	NULL,  0  },
@@ -2407,6 +2409,8 @@ int main(int argc, char *argv[])
 				ctx.safe_stop = 1;
 			if (!strcmp(longopts[option_idx].name, "no_auto_part_scan"))
 				ctx.flags |= UBLK_F_NO_AUTO_PART_SCAN;
+			if (!strcmp(longopts[option_idx].name, "rq_affinity"))
+				ctx.flags |= UBLK_F_SUPPORT_RQ_AFFINITY;
 			if (!strcmp(longopts[option_idx].name, "shmem_zc"))
 				ctx.flags |= UBLK_F_SHMEM_ZC;
 			if (!strcmp(longopts[option_idx].name, "htlb"))
diff --git a/tools/testing/selftests/ublk/test_generic_18.sh b/tools/testing/selftests/ublk/test_generic_18.sh
new file mode 100755
index 000000000000..c899a5bf0364
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_18.sh
@@ -0,0 +1,42 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+ERR_CODE=0
+
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+if ! _have_feature "SUPPORT_RQ_AFFINITY"; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "loop" "write and verify I/O across rq_affinity settings"
+
+_create_backfile 0 256M
+
+dev_id=$(_add_ublk_dev -t loop --rq_affinity "${UBLK_BACKFILES[0]}")
+_check_add_dev $TID $?
+
+rq_affinity_path=/sys/block/ublkb"${dev_id}"/queue/rq_affinity
+
+for affinity in 0 1 2; do
+	echo "${affinity}" > "${rq_affinity_path}"
+
+	# Pin submission to a single CPU so rq_affinity has somewhere to
+	# redirect completion to.
+	taskset -c 0 fio --name=verify --rw=randwrite --direct=1 \
+		--ioengine=libaio --bs=8k --iodepth=32 --verify=crc32c \
+		--do_verify=1 --verify_state_save=0 \
+		--filename=/dev/ublkb"${dev_id}" --size=256M > /dev/null
+	if [ $? -ne 0 ]; then
+		echo "fio verify failed with rq_affinity=${affinity}"
+		ERR_CODE=255
+		break
+	fi
+done
+
+_cleanup_test
+_show_result $TID $ERR_CODE
-- 
2.50.1 (Apple Git-155)

