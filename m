Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2793C108E
	for <linux-block@vger.kernel.org>; Tue,  6 Oct 2026 08:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276964; cv=fail; b=cA8/YjeeOrpbL9GTJq2ynUiAbMJtAhgq/RI4Rzd6TIaNHGv3xmsipoLAUaPsA9zfdoJrBsA9HCJg6mloN3WCRB8FUyVZWeaZ+Gyw4RZ9YGFESJPQmEUhGbtUjs2wiQGlJ608IYkCAKZalYtG9GVH9w7ie/8Jeh8f8FTxZJrKPJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276964; c=relaxed/simple;
	bh=FiRm0Ms2T4ctR4oTI+2YCI4+Yhot86zUW7XwB2hVbuI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7EDHrRsBAmFMd1VAAGhZot4iOJl+DuUPtjDEE4qW7vmWmCnqZp+IZdGdPAdAYW7aZuTN4ANTqf3m+t1NyC+xgm03kOL2KIGRY6YTaph/OvRk8oMXpN9R0hidkPOtSVILjsQisR25cPe4vFjwHQEZVJM2sU10aHwmrQ3kbOE/hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OnDhAO7P; arc=fail smtp.client-ip=52.101.48.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OnDhAO7P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVsZBWkN/M++2ESjwB8nKZ4ctMOrTc9V4gaDIQdsorPyhfHeaYFWXZ+doDp+iU29k4VCVYI5ApNnGUx6e62BpsGMpqZruTgrlfl6X9IxEJlCPZ0WPqCdSsrOoO6DuVLeGz/siGZjr9UkRgtja9sjfEF0Vxf+7QbGITL9Lqp+BNR9kOe0/fc10STEy40y5BPl9DvXcS20Dbs8fh/cAAiezcqOhPhXdP45Pr/+lrtEJe+SbEYOABtn1SUJ1MU4IYy6nSi/GzO2L/T+l+8vJIHqaVipyGyBtcTAHvy3WtuDUeMT4Vpx6cbLI4bAaOZFANclpzeWVfswCPRTI4+NYLQGaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGRErY/bwGb/MOf7gUnnO55rJ3sWBQUc4AfbhoSDpbY=;
 b=dXhbp/wUWtKEt5JsvI9oMg1SzDgiUhJ7r45R35VQeuknlQlQWFUNVqURRym0u8TT02Qfagum7p/EplKZ8b4fryReTKAmcwVg/8axO4VacOlz5CghPUTjvlMcmrzNkp6o7m2zPVZZIFkV44jJ9x+L+OG8kUIwyxAXg315KUgP5/tdRWB6QTpp/fUocig1plilyISx4ycWSo3rW0xK7zbC+VDgigugXe/8lZjUHW6i6dfdOy7WdTTOL8QWzpw2aQFjpao8Nzhuqh+0FqMQY9kJ1F2J+rSxS3vx47P0kql7vsn347n5eYYz6zCEY9FmJjrXUK/SlnC1zmjxtORWRDczAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGRErY/bwGb/MOf7gUnnO55rJ3sWBQUc4AfbhoSDpbY=;
 b=OnDhAO7PFHbot1s3c00oF3QL4F3zrOJ0xVv0yyXppwsInEwr7gUky3weUBF5dJ6FwuXPWZJuvdvpeE3qQyqi3UZ1mjn9kz6jBcfkSPy23J+zXsd7rxQu3lMZ6bZbiwbwblspN966ww3SdOzVzewrA3c2CcVsKs+NsMq4gUojYhwaeESHGCUF/Fa7lELHGGLn6LRZyS4MgybbzjhZ2HN819rwqgVzU/iVy4z2DsjVHB4Z1XvYilaoeULQSL32GIy8ODTdjAPADlVnsMuEl6CC93QItyLRrhclK+ZQS2zpu/TmXEHHjWZ2w9YjXwB9RYn1jhj9K4hznZfjJNtqx88AaA==
Received: from CH2PR14CA0030.namprd14.prod.outlook.com (2603:10b6:610:60::40)
 by PH8PR12MB999274.namprd12.prod.outlook.com (2603:10b6:510:40d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:55:59 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::43) by CH2PR14CA0030.outlook.office365.com
 (2603:10b6:610:60::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 08:55:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 08:55:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 01:55:37 -0700
Received: from yoav-mlt.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 01:55:35 -0700
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, Yoav Cohen <yoav@nvidia.com>
Subject: [PATCH 2/2] selftests: ublk: add test for rq_affinity completion redirection
Date: Tue, 6 Oct 2026 11:55:17 +0300
Message-ID: <20261006085517.33974-3-yoav@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261006085517.33974-1-yoav@nvidia.com>
References: <20261006085517.33974-1-yoav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|PH8PR12MB999274:EE_
X-MS-Office365-Filtering-Correlation-Id: fb927363-b3bf-4074-da85-08df2387a40f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|18002099003|22082099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	tXgBRPPTPaCFmbA8dYoJx+cLphx1WiI7FIpzX0HGYMgaIqmoPGUBFQ++EMBy2xoGW5SJ84c771opnEIRgYzgz5d9ZVi4Y7tSDw99zOuBeeZHUuGIHlQEt44jPlaqUjb6IFYBCtwXKfarTBfKSzhalCT1aTm9laep66wouUsEhU5Lvc59wcCYFpZC+UDB9yeSDPSU5xdXUTc2ZxIkd0l7KBbcVeJKRe9D0PYQG3pCCt+CL9dwK3bvpABvV1ifIXLRi02zC5LeRTdQv+OzJrra1WXgUSc1tKApeHh0lj0lcXC6sbwuI4dmC8W/7yc69rkCL/5ocvjOB6W1xWP+6GODIfHZbuOAI08fYDPhF36ybJq6fUow0Dy3i2GKlp7mdzuXa5RNYOdvmF+haTEh1YD5YdYE15tnAbSosTuYD4ee+3f/vJjwR7/9N3u5J6ygqUvbnWGO3BsmyISyd238EU8a7y2ZjaVzPgk6Xud0R2zYycs1cryEj3HTjFyOlScOoDZc9uG0pw0U21XWWJArNH2zL40axICi0PT46K4A68XCffCpKjakUHV/yfU3cp6XYi1u6Rk4OuHREQJIHG/LSY4vdxf9THzWA/28YorUbOKNb0iMVD6Ti4jMGvn/UMeA7iMgq0qSsBy2AWrQJTQM1p4gDNCMcOq0zHuKfVmRQ8B0feoBAUOHVD9/x4aaS8JoGKmi5a0tYdHyYzJErcb4cT09lQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GPkCdlUiUbkMH5vFvHYWEL58jYY7aC+xM1cWXEt463slyRsr6f8fSY/jdAbRBUJYPsZV34I0R8u+TGVis0Z6/1eibpYSwmnC1QrLOXZG98ILrwqEpKCC/POOHMNH5bIGiBtgbO8nlFWn6qsISuDMED07naJQyCNqADJiiY1L3Dzxv371rW6JZ6l0lQGxPWPg2Jk/DRbz3UEGyzlfYI+yovb9SwgwQ1fW+bMJsOm/JgVomFNa2bty/Q5/Wfl+FWdze1uLKy2su+wDvSCcSsLDCGJCFk/9QoAww6Wy+l9I+Thnl/r5ZDRckzX7+vO3YNTznzjRgEauFhArsA2kMUcF9CyZS+d+eTO/rtR4p3yd239HR1Km6y1tJ8Eyt2I/i5UPDq5Xcd7/XncPrMQ6+09pdcMQkom0CJcHYdpSVgfbmOB8wvWQ3CXn5t6yCEBDIXqJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:55:58.8483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb927363-b3bf-4074-da85-08df2387a40f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB999274

Add UBLK_F_SUPPORT_RQ_AFFINITY to kublk's feature table, and add
test_generic_18.sh: writes and verifies data on a loop device with
I/O pinned to one CPU while cycling rq_affinity through 0, 1 and 2.
Skipped on kernels without UBLK_F_SUPPORT_RQ_AFFINITY.

Signed-off-by: Yoav Cohen <yoav@nvidia.com>
---
 tools/testing/selftests/ublk/Makefile         |  1 +
 tools/testing/selftests/ublk/kublk.c          |  1 +
 .../testing/selftests/ublk/test_generic_18.sh | 42 +++++++++++++++++++
 3 files changed, 44 insertions(+)
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
index 2400b4615766..c750e10a69bf 100644
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
diff --git a/tools/testing/selftests/ublk/test_generic_18.sh b/tools/testing/selftests/ublk/test_generic_18.sh
new file mode 100755
index 000000000000..5afb202f1ef5
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
+dev_id=$(_add_ublk_dev -t loop "${UBLK_BACKFILES[0]}")
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

