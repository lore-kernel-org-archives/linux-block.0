Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793016423;
	b=n5Yfcf/kP8SmKoKpjRpP4rUQ2+0G/fXPmh822FeYt2CUaKF4gyRb9GhUJZ+1OYXdxEvo
	 X/HCk9YK07PjrMKOGhzonER4C4Oh6GNZ1FhfadSHQB+iAk3Q7bESx4vqMtSYBbH71LwkG
	 rPHtHvbrfccQlmG7+EcJawbM3rl7zh95ZQyOYsW3G0A+MOz4SYM2M6E86KwfNVONszcA/
	 Y1pNeI2IOn36tJW537gtex7O4ywgBK3c6q+Mns7+dyP7ReO2Ps/SFrdfV40uputj+d9le
	 F8JVwfki33gOiSGsZyyaOPCkyKtHmWK1HxVwNxNhxCLCxWT1LcEbwpDIWUVukPRo9Ww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016423;
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
	bh=y3nx1Fw56glWLME0X9jqBWRJTizFu7PPhAaxXpze1AU=;
	b=4NlEb8KSnK5KVcUn0recglzSi9OMqRWqUYJeaDwhulbl7SnUultqc4R8fr2+qBXaTDqI
	 BjacaVYjwSxnq91O24lTy9u22lV+MqH+IcZZMbmWGye4Eyd8By3okIrdGBaAPPXwiDA3q
	 u/WnqbGTnBOprU/T8QSsjMdcUIQuqYEhQ2UNY6lSb/eKqCBLwHX5Ahga5Y3DupRSK9Po4
	 Tj+ANqcUfUpGE6HCZ5ES/Km4OUoM1T2j1T6lfKaM+Bog44IfwLKrZZPOdkbLlM6E0MVpR
	 VvQwaFNpDBYaPmPRphrU+htXbWHvYHuE0xM/57krtWKQaZ4uz/xNdr2yQk4qMclpgeg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=a5m+EyPG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.18
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013018.outbound.protection.outlook.com [40.93.196.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57111606A321
	for <linux-block@vger.kernel.org>; Mon, 26 Oct 2026 12:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57111606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=a5m+EyPG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFIG9bmC+aN7jEUglHGVIhDDSVsOQ+yOUArbnHVmFomWOFTUpwWKs6tOLMJjA2P9e9k8iWLd8QULhtBIXQBtpmYOwIaGrfEcH56uMQg/3ElbFKUwLsgTe+pIlnIe/dX452RW2EQWR77S0w+UMFBKmreiAr7Zs5twie6TYqUdfLH9SYjvq+yIAv0cY1fGPCRJ0+9xi2YA7uNh0kmHvDvj/K3/dd2deAh+0US/TEwSAbh81pGUcsckGG6jugHyj4lQh+xtg7QHSiX2Bpq/x/MblxqezAuuGnBNY92el7dYbIpcEO8KvDaJbQ/iCD5tAtPu0sEQ8jlcypqBgVpHPgx94A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3nx1Fw56glWLME0X9jqBWRJTizFu7PPhAaxXpze1AU=;
 b=Vf1hvOU7n9jfqYqOeVvhKdMiJxacEG3GtcTehckCy7Hj0TLrYQfVsEjPPah6++qfE5R3huFCG+flltcN/EJdtoC0j08U+bTzAZ4DdNAmY6WZ70rAEhG3k0N7+oh78Pw4YMsGo/q596FbDa8o/CgA8VZs/4qM2X6BQ709+DjBjNSuPNk4S1CUx/RTeaNchXTLSxmhm0kDu8cUXWQ5ly/SP2+TmEa5l4BfGBPuBrtkTJ2ZwVRje4ol/VFe0ejHh35EMXiOMjzso2qzG3sXD6iLz+/5pk/XRyygbWrH/8DiEnNrdkHa7OcTrQlATynP5l+4yOL4K+T+ySspozp/CdG5uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3nx1Fw56glWLME0X9jqBWRJTizFu7PPhAaxXpze1AU=;
 b=a5m+EyPG8FWRmRYq75GNU5hhC95gOCcXwduZFiSQB+JAJrQGeriFFxsewgWUw5QQjJRZABrhSWeSK5zxeRlY74/QqbgTpnAygGGSkN2b8AyC3S16pT6MFWpcmuthn8VykKQf9JmTjX6XsA71+z8RnmLG/rCCYxDK6DipuYr6McJEipsAbVX5PXCqWmKFIWub0xBfkWkuv9rDxu5nlxOee/VgqKFHB0+DR2/+jftfKYtj9XEfEd0wQdLkkKI88uTK+vE92D4FQ6ELT/IZ+P1ig8VLwtYBtN8WvWxOJRn8WuyNphqG/z5Y28oab7LOXmUHRz5zKg2bnEUoGGcT+zGSDQ==
Received: from CH0PR03CA0243.namprd03.prod.outlook.com (2603:10b6:610:e5::8)
 by PH7PR12MB5782.namprd12.prod.outlook.com (2603:10b6:510:1d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 12:06:57 +0000
Received: from CH1PEPF0005BD5C.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::2) by CH0PR03CA0243.outlook.office365.com
 (2603:10b6:610:e5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 12:06:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0005BD5C.mail.protection.outlook.com (10.167.244.245) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 12:06:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 05:06:40 -0700
Received: from yoav-mlt.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 05:06:37 -0700
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, <ofer@nvidia.com>, Yoav Cohen
	<yoav@nvidia.com>
Subject: [PATCH v3 2/2] selftests: ublk: add rq_affinity test
Date: Mon, 26 Oct 2026 14:06:19 +0200
Message-ID: <20261026120619.47629-3-yoav@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261026120619.47629-1-yoav@nvidia.com>
References: <20261026120619.47629-1-yoav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0005BD5C:EE_|PH7PR12MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b8a848-b7ae-4984-555a-08df3359a248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|6133799003|22082099003|18002099003|56012099006|5023799004|11063799006|261022105027099003|261021121427099003|10067099003|261021123027099003|261009223027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	KckY2qjS9GnF1W2hIIWjqd8Jh0PIDXfeiagEtLmchAvXr8XhNE9U09i8OoGS0uk/uM31PZH+Tqvy76NUyNNwfokmMr2N4n7LEWJHYvQ5Ldkr7Qzq+8WCVf/4HZgWguc8reYXCGBQv7mtjYTXqznzLdmV+J6/7GaDLUn/h0uc3AUYdQbOsnomJ3fO5o/kIJidw92CdSVIc0iTWsUK3FSFNHCzKXI7hWdu+b71dQ/sBQvXDjyHenegRetwK5z5hBsdt5tJ8jyYBvepYCFhV+9tohweiRLZqMnDyxIkzSoPx+exH7uEhBs+rZieISo6fOLn7chivCUpOBNBgtcyi1Ak51FhrlT19ppAtOUPZVqlth/q5yAm74Iex4EJ8El062NlYJ+jMpW31f3kabdMJQdYVy06Z4QstkLCpF8BHtnfGuD8fDCr5PDL4No8+ptMsY54hJqIQX+QLmWuyjw5YzuAwR/+9GbJKfJBJhI2OIcvpA7Gd6VN2bUNH7V/e4WMLRUYkKRHhBE88ZPBfkM7oZnatvPvwI3xb/+Mr/OXnXpHMAcQLzSl8pNOITB6MVpl8iufPi898sky7j5ovegacBtai/xgf4VeCde4om3kbX+wJd5g51vBd772FLdiGbbrhols5wtbCVdPXDY0tZYnan43jX55/f904qahWtrtzK18Ar6mdLbMtUfRh/jdsz97rqlDDfvk66e2Lew7qKJLzL+6CQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006)(261022105027099003)(261021121427099003)(10067099003)(261021123027099003)(261009223027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Rhm8ew+GioK1qNprErS0uc48WPGSW+9iuE5OHTChtKz6Cbc+XnfotYmgY5S2Q2j9rPP2OcinksI8e84A0TDQ06fY/olHq68CiGeMoNLVNuoUiMEX/XLXEYhcCCNS/sMzShoTOkzEr5NRuyYgBis0weWgtoAr4IveoT+Yi96UCEgFGH4AWMKGUGCzHIdcPaqqdi4m1sqxd0tBUquZxJNpL/TQRWvAXemP+hASPY3MDVwmhlg9POWzKwrhB6jEyhTk0ucIUGS9X0PAlEYWBNImTbPEKj0zAgROvF23jHVaMHO6sFhdS0WNCbMgBEG98ifmxd7qiMPO3fAYrwA4FmX3tqzuGchWRu42rzvV/SIq0tuPUNXVlyahVzvwlRGpJgiw7EoRVoH2nuihFwUmlOnlxexd9tN92h1TWxPUlmBDSsVLRlr9dqrfHlryMgNQ/G5p
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 12:06:57.6024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b8a848-b7ae-4984-555a-08df3359a248
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0005BD5C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5782

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

