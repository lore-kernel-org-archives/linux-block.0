Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A264E556
	for <linux-block@vger.kernel.org>; Wed, 31 Jan 2024 04:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706675916; cv=fail; b=tqLH31Wx5BfoYiyiq5AS9ZaRVdMyH3lgCtGxmWl94umyNZjeitbdao/Smhi0snxTagCelRTdaFez+ZbP28tl9QdjW9ZKW4bw0IvhJE44MLXyRfuTfthheX1ma0xA4NoKMTLufqWhzNL2FLypw12ee+IkvYKYW20ZBstjzxrnRNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706675916; c=relaxed/simple;
	bh=KOK2R5q33cVBrrM+JlwFJdiknubkUdMfjBw4CsfW9iU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H6imuKqqLnwiob0KUNJ37nYq+sZ989e4mY3u02QbtOkfn06HJNXVR7VszGC5ECcgQLRiOKwmFShzt+5N32TYEsvu2uW7N6CG6OshxKMHJNuNJXul8AkEnOh2JKzmLY/kTqGZZhNWv1OMEsD9oUuhXV32TtXK1PI8tgZ4pg9JsXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gwLlO8qd; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gwLlO8qd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyAZ1C8oE224wKjolff4w092xqoh7USU4PFOc/SW+ktgSHVkHGyQeEmhSCHqvyo/P3GYYgZom81F5ZPaziLfsyCop4nQ6JHp3ZCy5+obalJ8UUn44RGr0huKG55yohqNleWYDwI6cVumFrdwfQ8YKOV8NVIdR7LfwpDRjXwTJC7ti9n+xmzZ7yKRunABGsjg8NacbtIxUNIptpsyK6AXb8ERlf8ehti4DuxM1w/wYulRzU2G1pw+JKCaz7zaoKYZfrx78MAFGMr/T9Phfx+nEZiqBubMn9drxAbMxgPLRS7glu9510Wb+/hRFDdnMGWFsqqTbl/cCr5GzjQ+sIt/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8rLGS/6lwG/uY+LNJFe/r9k79GKD83LTCN+Pyny9WU=;
 b=jDBr1WF39lEZ2CKkCZhoPTpC6S57Rpn4xjdom7dsnOhpKSe6y+MWJBB+vBKfKGqQs26eahq8+Gyz67SbBO14yPkILzJMAMcdIKnu4FWe4rXRqMl0PX2Lm3MKBSy7975tnXA0ID2/7LVScIF95ETh6/BfCk3U/wQ4fv4xk811jORsMHrwU0IsLYKT1SXe8dU49De1DS8ide4u9U9HAFyuSohk1DNIaBwwkGEWVJTX0IDOPj3nmbfhCkOhqnS2jhpc03JO3kIASkeHuFtjiBeZ4IwH6mOHxO5Ety/TQZIzFt893vLj4sGDBOin25p3lDU4tXBOp9/VSaQgl8ShVBWBaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8rLGS/6lwG/uY+LNJFe/r9k79GKD83LTCN+Pyny9WU=;
 b=gwLlO8qdy12kyCd8DJhNGcqrC6QFe91ArZfsQ9nF2lXxPeZr5phBfTsUz1/FCtj5Znzv02NGgJLM/ccgNqa+uOuulGfqxAc60AELCq32uCubz/LRGUIfNnqVwMivuYgB+V8pElMdyksWYKmAl1kcgsYYZvYjaMxog3+u59y5uWnxYoqN+6EYucm2s0a1aX/GwVvJZvZmKYB+18XaG2vxV2+S42MP8e8hipob0dZxRtDEyXN3n+1gselZfnjXuPPck7pI+xDKRaX8cp1XBdzP8qaD62GRmwYdlocMdQqIapcVVw6n4eQ33eAacuBNAANz7Lmyecl7ff5DQJxHTpqiQw==
Received: from BN9PR03CA0569.namprd03.prod.outlook.com (2603:10b6:408:138::34)
 by MN0PR12MB6032.namprd12.prod.outlook.com (2603:10b6:208:3cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.35; Wed, 31 Jan
 2024 04:38:30 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:138:cafe::e8) by BN9PR03CA0569.outlook.office365.com
 (2603:10b6:408:138::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23 via Frontend
 Transport; Wed, 31 Jan 2024 04:38:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.0 via Frontend Transport; Wed, 31 Jan 2024 04:38:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 30 Jan
 2024 20:38:18 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 30 Jan
 2024 20:38:18 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC: <shinichiro.kawasaki@wdc.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests V4] nvme: add nvme pci timeout testcase
Date: Tue, 30 Jan 2024 20:38:11 -0800
Message-ID: <20240131043811.12292-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|MN0PR12MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3194da-7b25-40d1-1599-08dc2216795e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RaP0VzogBIxlhQv+ZlixN3tbecGbYWmMt06R7RY1RKtoZqNR3iJ1XcwbDqCFiKMrROO0Ma5k56y8yItHozwNkQQ4wAsxffDWeAtPx2nqmekyyxk7aYMrbTIjtMg5qRbM4Pi++rvpRPDUHmAijF0gbaBnsOxHxUGB0VMDYkc+JZFbdFI723PPa+t0nOSgnoopNNPMc+Z/zpI6IhUo179AP5O2Vltznr2j4SgDr9fl64GL9nmAeKaGsXHJfAQQ3EMyRrTv9SN2hWz+As30pokVqT3XwXIM51kL8j/0SbRfIGc1cHhEjfIL7G1YkshmRVNzSKBt7VSZqlNTf8U+rOSQtkWfgyDc+GvI85W07S9Pv5iljHbPyuyvbf4vxQ5INds4Vc50M/8c/lc5hqpLfw71mlYZlp2JlpBSTkoDamsqzQTTiBjInw46rKc4VaFIQ/0ehVTqKWli+8pB86voPF0RbTxlAciROVfXnNXuLTC4iyOJGjDlZ2Yu/LVjDRxu64cHhkj8hDY01hzOYsaxb0++acK2/VhCpe2t4M0MwPMtXJT4xQj0qgGq9vW4UttRAWrhoXNmLIQ0QOiul3Q9NyqZEeS1LrPSQGehOb6Grgm3NEhdCmXpI/ucW0I3R/T6za+P1VGZEqX5MvhftYCeDaGZiZKDlXxQ/oGKrZ6Bks1bqmD+oMaGIqQgK4p9KYop6vSdkPOn5rS3EPjZWtAqpSOo10eX3AdUChLmxq/bTfQkygKSG2rKdZdLDBFb/dV45b9IlJrhu1MjmJPQmDG/PBiFXw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799012)(40470700004)(36840700001)(46966006)(316002)(8936002)(8676002)(4326008)(2906002)(5660300002)(110136005)(70586007)(70206006)(54906003)(36756003)(36860700001)(47076005)(82740400003)(7636003)(356005)(7696005)(478600001)(6666004)(83380400001)(16526019)(26005)(107886003)(1076003)(2616005)(426003)(336012)(41300700001)(40460700003)(40480700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 04:38:29.8570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3194da-7b25-40d1-1599-08dc2216795e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6032

Trigger and test nvme-pci timeout with concurrent fio jobs.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
V4:- 

remove timeout attr save restore and remove. rescan device. (Shinichiro)

 tests/nvme/050     | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/050.out |  2 ++
 2 files changed, 57 insertions(+)
 create mode 100755 tests/nvme/050
 create mode 100644 tests/nvme/050.out

diff --git a/tests/nvme/050 b/tests/nvme/050
new file mode 100755
index 0000000..c710832
--- /dev/null
+++ b/tests/nvme/050
@@ -0,0 +1,55 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Chaitanya Kulkarni
+#
+# Test NVMe-PCI timeout with FIO jobs by triggering the nvme_timeout function.
+#
+
+. tests/nvme/rc
+
+DESCRIPTION="test nvme-pci timeout with fio jobs"
+CAN_BE_ZONED=1
+
+#restrict test to nvme-pci only
+nvme_trtype=pci
+
+requires() {
+	_have_fio
+	_nvme_requires
+	_have_kernel_option FAIL_IO_TIMEOUT
+	_have_kernel_option FAULT_INJECTION_DEBUG_FS
+}
+
+test_device() {
+	local nvme_ns
+	local pdev
+
+	echo "Running ${TEST_NAME}"
+
+	pdev=$(_get_pci_dev_from_blkdev)
+	nvme_ns="$(basename "${TEST_DEV}")"
+	echo 1 > /sys/block/"${nvme_ns}"/io-timeout-fail
+
+	echo 100 > /sys/kernel/debug/fail_io_timeout/probability
+	echo   1 > /sys/kernel/debug/fail_io_timeout/interval
+	echo  -1 > /sys/kernel/debug/fail_io_timeout/times
+	echo   0 > /sys/kernel/debug/fail_io_timeout/space
+	echo   1 > /sys/kernel/debug/fail_io_timeout/verbose
+
+	fio --bs=4k --rw=randread --norandommap --numjobs="$(nproc)" \
+	    --name=reads --direct=1 --filename="${TEST_DEV}" --group_reporting \
+	    --time_based --runtime=1m >& "$FULL"
+
+	if grep -q "Input/output error" "$FULL"; then
+		echo "Test complete"
+	else
+		echo "Test failed"
+	fi
+
+	# Remove and rescan the NVME device to ensure that it has come back
+	echo 1 > "/sys/bus/pci/devices/${pdev}/remove"
+	echo 1 > /sys/bus/pci/rescan
+	if [[ ! -b ${TEST_DEV} ]]; then
+		echo "Failed to restore ${TEST_DEV}"
+	fi
+}
diff --git a/tests/nvme/050.out b/tests/nvme/050.out
new file mode 100644
index 0000000..b78b05f
--- /dev/null
+++ b/tests/nvme/050.out
@@ -0,0 +1,2 @@
+Running nvme/050
+Test complete
-- 
2.40.0

