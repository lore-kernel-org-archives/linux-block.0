Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793193563;
	b=Khi3aE6OWzwAn/oMAaq/auTnnZ9q6jzJ2QWjOAmvnUPJ0IpBAFNr6NUGiDIq8nFDcIIF
	 MmsObYBu6/l33u41GrQY+Fz54xIQgCww5rUgLYL5Lw/suF9c1f4EwMutcHyvM0/63HvXc
	 OBS8wnZVACQ1uHP0vG9RszRJaQuGX672PJs6a+bHbf13GKNLMSjTHxjB2zJelyw1nBGh6
	 P+2O0BmgQUnqPXeFCQDqyhiDdRdZjq8sJ9Tu720XvPBRzLRyYkXngi2T+IMjfyvdwZO7i
	 +JALC/yF+LxHrg/jwoOmvEtoVrR8EgsUI0SnREfnBJO8MdAYtHP20jq6Pe2kmKkpBZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193563;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/oW9+Tz8iO9CqNcwyhjOMLBavW6Y0ynlmcriUvTcE8M=;
	b=RxFv5PDVjlxXjUsLkpETUqI9jXxzRWkx9SYdUrFT/IWZ9lERt0jePYmT/DsiovxsiyVr
	 l/+SpXOWvw7yQFp8PvFp/r4sh8VKbP5xfPqgiD/gkeOF63CBVTG7DYJtfjyABxIW3Ui5z
	 aaijvhH9D4AlRwFC9oi7CKiUUplCeUVP64ZTqSZ4WnNma+1x3DM32fhYTwuOLldJ034oY
	 o1aLy9LffQOj4Gh1LS4YT3QGD+PkuqYbPNi1F2SB1nlf0IGHVi+GW1RI8PMqYVJ76v4hJ
	 GzzrtpTspc3nbX541Z6ZaPz98zTmYDB5+rfIeLGB7FS9nHN9n11VWjvV6dJKptp1ciQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="j/p7nO+b";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.15
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD565606A31D
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 13:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD565606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=j/p7nO+b
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmW3ecUN+cf6fCr+10mFMurJ8Hkcw5OY5RBf5jILlZacGYP+qNRG/Ur80ZFJ7hbyZ5Ytre3bGXOyMh+PXGWHU8JD5PQC5oAfWtUzEuKaFCzKjEtMFLdMO+6dIGW+zj/M98GgZVKgoum4lvUD4EnrNbABO9yluIQ6394b3I2QSz7HN6pwyHDZMaAHBl+Kb/PyBEPh3gP1LRBSbnRqu3opcI5brNY7fz/GwH8PPbxHy1/VLSVQSS5ZoZnlQCikuVTove5cNX+m2GssYlXLv3RMAeoMlv34p8FfCMYFBjC/t58hzBY5vNkLcjmWZlF6MlU/Po3N0v62fQe2DeV1WApcfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oW9+Tz8iO9CqNcwyhjOMLBavW6Y0ynlmcriUvTcE8M=;
 b=DBXs8qle7QQ2cqshksC5pEg31gRYb4thTRKQ/k2CqkaxN5ec3tMkxVtvxdAW6yuGZd9ekTjYK5rS9+y75qXHvlFLbkfv8tx4qZCeV0qCUKcYi9ydAr9iISyTBPGkh+8RrRg8pTHMcJ0ZmZsObY8iafQtON9w7A4bHOs2m9aUh23+tWEg9RdAQUllVZ8mk9ghnvBQ4U3/revsXRZTbsITc/MI+4Bx85DxBnuAtaoPlwIOiKBXpYFHOcSaLVVAKP7H8k07UhVFOHGwLJjvA8UOsMmT/NhvPd4BZ4wCa1fEVVQgZOMqRY3wVzZz8J/J/IbsNk5y1IRC7lCIhAhHNt0nDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oW9+Tz8iO9CqNcwyhjOMLBavW6Y0ynlmcriUvTcE8M=;
 b=j/p7nO+bk9e+pBGe/bdMy3ISIYPtvB27MRBKa0t07LknRj/PgAJkCwUpCO3z4iYC5hMK3kWjEuXQbwRCa1rz/Jo+Fca8NBrgYDQYsSUvP9HJQv6rxaWgldFt7e56D/aKTB+yoiRYzNoOkzsKfPzD2ucPdoDaMOsT9scpcDQ1F2CdNq/5T9vkoT7x1I2E3wiloJbTi9elwQ0DVzxZbi9OiaGnuxhJoHiTqs11vVh4pRo2gdgRx2ZFckDTHc3mDQtWmSqZoTTBf9GcB+8wioc5BQ4jwZJxT2iOfcszBuqBSQEGMxSFC4NaQl4YmytlVKUSykOo1oeaSnVEO/KnhiN0Gg==
Received: from SJ0PR05CA0045.namprd05.prod.outlook.com (2603:10b6:a03:33f::20)
 by PH0PR12MB8051.namprd12.prod.outlook.com (2603:10b6:510:26d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 13:19:17 +0000
Received: from PH5PEPF00000031.namprd04.prod.outlook.com
 (2603:10b6:a03:33f:cafe::a2) by SJ0PR05CA0045.outlook.office365.com
 (2603:10b6:a03:33f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.3 via Frontend Transport; Wed, 28
 Oct 2026 13:19:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 PH5PEPF00000031.mail.protection.outlook.com (10.167.243.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 13:19:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 06:18:55 -0700
Received: from yoav-mlt.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 06:18:52 -0700
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, <ofer@nvidia.com>, Yoav Cohen
	<yoav@nvidia.com>
Subject: [PATCH v4 2/2] selftests: ublk: add rq_affinity test
Date: Wed, 28 Oct 2026 15:18:29 +0200
Message-ID: <20261028131829.45803-3-yoav@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261028131829.45803-1-yoav@nvidia.com>
References: <20261028131829.45803-1-yoav@nvidia.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PEPF00000031:EE_|PH0PR12MB8051:EE_
X-MS-Office365-Filtering-Correlation-Id: 76bfc475-1287-4568-5993-08df34f611eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|261026140227099003|5023799004|11063799006|10067099003|261026121527099003|261021123027099003|261021121427099003|261022075727099003|261009223027099003|56012099006|261022105027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	MAXLnqOxBotfUgOs2UJgPcdJ92v9k4j+rlN72IZvdYN4DjWl1l+1qsjMHvKZsOyV3Tvk+EyTTGm6y4Qh7fmPUuzzA9jPz5QP8OvgMUWMmKn+ksZiLDgyQSKQrAFnI7u1dn5hg2+iE5ALIp+fBGwzrjQsQb4t25KVN/HXoKID1ZwTCoN9NBbsEazTZ6RijMA4PLCg9x3LyBbuOMTpIvw64V0rZlGdY+dkE5+AJYVdN+bilvBvXIv0nT8EoN8ntbIZaj7slUtPoNCz641h3jHUDDxXjZd0cCZOX8sXqd8Y25qvIntnz0WUKADCnz5cLao5iarqzsrhzqetVKCIXV0crQTj5aSRgSZGZc0s700AISA2aSzdiDlcD6GX7ts4l34vm7K16/9D0TgW7zki5bgnce+HMcVQ9j3MZS8wgNVQmBIjPiIAUbABjUJTo+KF0cQmKWrYTMBM8oueBQ/ZlxoMTUj8TjMo7tH5rPnIVilw+vX26s8j39UDZvW8W/Fy9IFgxXrchGNTPs0y8q8kIESbNeKRUEOHSwzVERPtehvWrnbWRZfHpSkUiwV2I1npNNQ2oYWQkRidtvLqWc5RPJ97zxOtb9feBsp1tZi8p76asr+STsYJqkhmKYO4UzMwla4Ydir7PvbduL8bE4k9zskpH541W8n6JUo6RJNztowGjTUwklVkdqhB4zA/TJqf/JDtpypPkNddW5gz39T2Jj+kRw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(261026140227099003)(5023799004)(11063799006)(10067099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(56012099006)(261022105027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SN8kJ6ChqOwHnyXW9VYTiYDIsCSXyRAFCsECKOE2qPABQFDTJfTnjoZyGuRJHxmdAN9ThaY54y/sGJDqloQP3OpbmvErBQHI0w2Mt2VsGnkKsfzG39c/Y9areyQQaYbJOIFjCMRUiAxQFFN346li9PdITdSXeUBBtW5chWNCNcp8Ugg4g7F6OS9pHNIeHwKjkmkvKIl8iMlJYArC/ry+X3AbgP0H4aVUleb54mhGqcyPN77YJ5olIPLYSanFVvsxxWm2/5NH/qaR1T34p9iyerGw3gRhYmcmLr0FfIc14YEva4ZaHGr+ZbZ9YZE3vFVVdNKOZXGOvBRqMSN0hWFq3TdOrO/e62jjQBtzTcb24tbdaKz5J/KjsUHf5bR/XSySiSZ9WamQ3J1HC48FT9uerqtdfYiD5eQBt+/PjUusxvwfCAt5UWCXYCJzS6oxBffM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 13:19:17.6263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76bfc475-1287-4568-5993-08df34f611eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH5PEPF00000031.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8051

Add UBLK_F_SUPPORT_RQ_AFFINITY to kublk's feature table, a
--rq_affinity option, and a test that writes and verifies data on a
single-queue loop device with rq_affinity set to 0, 1 and 2.

kublk pins the queue thread to the first CPU of the hctx, so submit
from the last CPU in cpu_list. That way rq_affinity=2 always takes the
remote completion path.

Signed-off-by: Yoav Cohen <yoav@nvidia.com>
---
 tools/testing/selftests/ublk/Makefile         |  1 +
 tools/testing/selftests/ublk/kublk.c          |  6 ++-
 .../testing/selftests/ublk/test_generic_19.sh | 49 +++++++++++++++++++
 3 files changed, 55 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_19.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index fc64b8f02833..21941071a35a 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -20,6 +20,7 @@ TEST_PROGS += test_generic_13.sh
 TEST_PROGS += test_generic_16.sh
 TEST_PROGS += test_generic_17.sh
 TEST_PROGS += test_generic_18.sh
+TEST_PROGS += test_generic_19.sh
 
 TEST_PROGS += test_batch_01.sh
 TEST_PROGS += test_batch_02.sh
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 5a4ff689c1f7..ad42bb099d5b 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1812,6 +1812,7 @@ static int cmd_dev_get_features(void)
 		FEAT_NAME(UBLK_F_NO_AUTO_PART_SCAN),
 		FEAT_NAME(UBLK_F_SHMEM_ZC),
 		FEAT_NAME(UBLK_F_IO_DESC_SIZE),
+		FEAT_NAME(UBLK_F_SUPPORT_RQ_AFFINITY),
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;
@@ -1909,7 +1910,7 @@ static void __cmd_create_help(char *exe, bool recovery)
 	printf("\t[--nthreads threads] [--per_io_tasks]\n");
 	printf("\t[--integrity_capable] [--integrity_reftag] [--metadata_size SIZE] "
 		 "[--pi_offset OFFSET] [--csum_type ip|t10dif|nvme] [--tag_size SIZE]\n");
-	printf("\t[--batch|-b] [--rotate_auto_buf] [--no_auto_part_scan]\n");
+	printf("\t[--batch|-b] [--rotate_auto_buf] [--no_auto_part_scan] [--rq_affinity]\n");
 	printf("\t[--io_desc_size SIZE]\n");
 	printf("\t[target options] [backfile1] [backfile2] ...\n");
 	printf("\tdefault: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
@@ -1989,6 +1990,7 @@ int main(int argc, char *argv[])
 		{ "batch",              0,      NULL, 'b'},
 		{ "rotate_auto_buf",	0,	NULL,  0 },
 		{ "no_auto_part_scan",	0,	NULL,  0 },
+		{ "rq_affinity",	0,	NULL,  0 },
 		{ "shmem_zc",		0,	NULL,  0  },
 		{ "htlb",		1,	NULL,  0  },
 		{ "rdonly_shmem_buf",	0,	NULL,  0  },
@@ -2136,6 +2138,8 @@ int main(int argc, char *argv[])
 				ctx.safe_stop = 1;
 			if (!strcmp(longopts[option_idx].name, "no_auto_part_scan"))
 				ctx.flags |= UBLK_F_NO_AUTO_PART_SCAN;
+			if (!strcmp(longopts[option_idx].name, "rq_affinity"))
+				ctx.flags |= UBLK_F_SUPPORT_RQ_AFFINITY;
 			if (!strcmp(longopts[option_idx].name, "shmem_zc"))
 				ctx.flags |= UBLK_F_SHMEM_ZC;
 			if (!strcmp(longopts[option_idx].name, "htlb"))
diff --git a/tools/testing/selftests/ublk/test_generic_19.sh b/tools/testing/selftests/ublk/test_generic_19.sh
new file mode 100755
index 000000000000..1d412b4b3318
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_19.sh
@@ -0,0 +1,49 @@
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
+dev_id=$(_add_ublk_dev -q 1 -t loop --rq_affinity "${UBLK_BACKFILES[0]}")
+_check_add_dev $TID $?
+
+rq_affinity_path=/sys/block/ublkb"${dev_id}"/queue/rq_affinity
+cpu_list=$(tr -d ' ' < /sys/block/ublkb"${dev_id}"/mq/0/cpu_list)
+first_cpu=${cpu_list%%,*}
+last_cpu=${cpu_list##*,}
+
+if [ "${first_cpu}" = "${last_cpu}" ]; then
+	_cleanup_test
+	exit "$UBLK_SKIP_CODE"
+fi
+
+for affinity in 0 1 2; do
+	echo "${affinity}" > "${rq_affinity_path}"
+
+	# The queue thread runs on the first CPU, so submit from the last.
+	taskset -c "${last_cpu}" fio --name=verify --rw=randwrite --direct=1 \
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

