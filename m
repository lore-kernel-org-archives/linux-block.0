Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD9A18DF89
	for <linux-block@vger.kernel.org>; Mon,  4 Nov 2024 19:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730748582; cv=fail; b=lW7Z14lztoaZCyvZiQTPpnRsTgaflp2SQ1bGHhh69vn5HTTeaC09ifo1xblAF+uw9JV0xAZWkYxgfkvGnZei1INwObPH5mApD3eiNXobN27Jn15jkXIEmyoKY0lVIZy8LWCyqPs/QdamWNtZewSG3oqP2xR+wRxpfCm8kKL2N3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730748582; c=relaxed/simple;
	bh=qFkbsiBXu3Kq5t+S4wHoBkQFWKIFrF3GOy1V6T6JbPc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VRZcR4mdKg66y/z6WVKhfrviVjq/vJ26K/t11ub/X+HtVtN1uDx8051fgktE6uIuQsY4acXJpCS/uMdiRNAMeFls/AUXIOE0zb8QD+Xu8++ORpeDNF5R/QNY97pN2Uh4x+cv0Z7Wilq34g353babvWN5VbOdLFYpCFR/k1fTdQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DUbFkfy5; arc=fail smtp.client-ip=40.107.102.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DUbFkfy5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVCpShp2k68JpGPA7SBlXgNFaRo7PmkWseI8BeNwuROELYl0icv3OF5tbv1ZtP+646F2WkejiIa7W0Kk9gGmWM0Eanl9X/6yrTlbT/mxrrhUBj21mCNTbB64LSfiL6qk1gPIW/3y+GFwsi0KFZ5AAeMbnkOeXKubWYxhd2dB/LnK2VMN1GaAl5fxtUWe7C2iEithpGXvhlW58JxuY5BNL4VIjhNGiwHT7ClzTsDCOw57aEVnIhULzUHA1zeUuhewv3P2XKc4x5DRk5yJkJ6B21kNT3BtG2U+Xl7xfhxSuw/rfZSIRo5EFFFUUK6X+3HZPXEJdcir8FzPca8Y85t2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ORt0OMc3h3XNFPCcQ2vzpDpd9QN/TzXj1dLH2Q/8IQ=;
 b=RzLTXZTkcdiDokgu5L4YFFdN65pMzcVKVaNZmU4pYxG+fRpkVwKI6Ed6xpU6wkrAfR3ZofTgwPUhw13pR31Gymr1LDD6Ne/RToQhQGTmavIcwVN2R1nvTY218uPZkW7eRYIoSGrA1wlyx6/s8pW+wV1iuD14WiBwavRJ9FsIdDL5VhxKSuaB8l48AQa0HOkNP+lA8pWlOQhAXaUx3Ywc8XfB0hT2tJufxS6HucPoEjj5o0fwyKRAvM47D1ZM6gnWzBFYfHMDbG94pwQLnl6FtKwH5iBYgDZW6UO2/P7c033UBBXTyD9xfGRxwdZmieDrV9PWBPSMCcMTG8viCM7Z3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.alibaba.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ORt0OMc3h3XNFPCcQ2vzpDpd9QN/TzXj1dLH2Q/8IQ=;
 b=DUbFkfy5oubI6uBgWajBVcC1up9Ucqmy2VKg1q8fxG2fdXifHv4RxHSBuhAfTwNqZBm+JN852rQ2nborIUl+C/DuU4sHITTo0anvClZqDD2D7ZiS75qgLcCKnhaGmKiYVIkZRzaVhDqQkU2qV0u18d4M3FrQdNlN1OwQWSgSH7oYSinF+yOxlkiZqiUzztKF/mC62gMw0sRfMwfTYIwzWwaaafgFHM+SvNydC59dEM1cINFNhFunDBr46zlYJrb0wYHyhazxEiwzec7bdcHqhcbzeMqA5eQUQMa2R07pir1LB7Z0N8dO5ACFswo/J6p9HGYB3qYvexRRggc/AcLXtQ==
Received: from BYAPR05CA0064.namprd05.prod.outlook.com (2603:10b6:a03:74::41)
 by MW4PR12MB8611.namprd12.prod.outlook.com (2603:10b6:303:1ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 19:29:33 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::ec) by BYAPR05CA0064.outlook.office365.com
 (2603:10b6:a03:74::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.16 via Frontend
 Transport; Mon, 4 Nov 2024 19:29:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 19:29:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 4 Nov 2024
 11:29:15 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 4 Nov 2024
 11:29:14 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <kanie@linux.alibaba.com>
CC: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
	<shinichiro.kawasaki@wdc.com>, <dwagner@suse.de>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH] nvme: test nvmet-wq sysfs interface
Date: Mon, 4 Nov 2024 11:29:07 -0800
Message-ID: <20241104192907.21358-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|MW4PR12MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: f3a17da0-f312-4c7c-64cb-08dcfd070248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m5LFCtS3zl2LFYf8+1fO1oxXsArc+HG5HF9EiBjfXHsg2HxdOFCdhT8jWbtF?=
 =?us-ascii?Q?ZRmsEddBFaNG4QWHq+p2gSfPXoiNMkOhoFH7PrcCMcWNHFp/AQYd4gy9aEiJ?=
 =?us-ascii?Q?KEx+vVTvYmVgh6jc/uDNJizGa/YbJJ0ZoX7hdk/X7/NxqSOWwuW8T5zsm4bn?=
 =?us-ascii?Q?AgpNa3rkokL5OX6Fpj4t4oRH5vGDhPXqXXSUoCXA1rlKZ8uXARnbHLsti0Pf?=
 =?us-ascii?Q?RV6agPfQIbP0LaRWatDayXsYKIXPoEHIGbuZLajeH7ykWNPKtSwDzJ7xdZbO?=
 =?us-ascii?Q?ym3bCxtTcTbxwC0igdiG2OeAiyBIVylY6oIe9eVQUPEH0x6candG67rRrZ4l?=
 =?us-ascii?Q?vMpTJLAjc+Cm9bv/oMWNw24kAy6RDT0BKx2gVnlYWrCyKAGbWaKxs9ZKs1fp?=
 =?us-ascii?Q?IiNpa2Gc2uBxBybxKpzk0lvmbwXsUtulcP3XKbQ0tH63Xup/emFnxFghoNGd?=
 =?us-ascii?Q?ydU6RUmMqvo+tL/vRlMV61UJoa8wkTZw2ikpXRf7jsJDHBtiM/m+Ev2xJmLQ?=
 =?us-ascii?Q?o7Id9uMsM1A81tmDvQVpoPI4Bfh5vp0zXoGURqgbvswgTft4h5Yk+t7j3fPY?=
 =?us-ascii?Q?K5ZI9l4CrjWg/xgGEabz1OOavHxkHxxvN++kdXXTcSPbiH0piof/QioTGsMV?=
 =?us-ascii?Q?FuLK/iMbrh7XBCN0vpoFhrUjJjjXXsqjUYYmWuyKw0GcYh7pQLN5EssSRm9H?=
 =?us-ascii?Q?3Ay6hezpRahkLy36ZpdPDNaZo8T/VdYoyp8HRb5Le1L9kdFAdnJD7Z9SKkmn?=
 =?us-ascii?Q?vURb3v60v0fAzBSWYUaTjX11PgdRR9QKQSSW8I6yg2QX4yIwXQaAGzREABLE?=
 =?us-ascii?Q?jLVp1zGSMVvn6BNkzxHbwQdzXSo4ZIfcIhi7dHPXeTEaWm1ePWoe2i0EH5S2?=
 =?us-ascii?Q?ZmmeTOAqAsQ1NN1ZFSxLGtuR7vxomgrZehByO90H61lXczu7ElfumVoLH9Lt?=
 =?us-ascii?Q?9+VKm2Ua2+k/HhdEJLOHyuB6nFaEeX3mzkahHbyFvufjq+AdC3L3NpeB6DZQ?=
 =?us-ascii?Q?7bx0McL8WIHgdvh0zK/M0/WADaynkU9HGui+LlEjOJBCW/vYmVulLtQRkh1N?=
 =?us-ascii?Q?d0Q03AgL0vsVrdKeu/psM4jt861uvngDJUzhKDxc1gFMnTMzV6VGDjM73fr7?=
 =?us-ascii?Q?np12RWv1QAe5CwhK+fMW0+W5jSe/LpONMS5kRQVMVSyblbyJ3eMdORf78Bbs?=
 =?us-ascii?Q?DJii3GBi/DHOHviDaHZNw2AqDyFUQl5yLqLKk/mkHBRTc4DvIc4nV+HvbQhk?=
 =?us-ascii?Q?JnDoHZPzhzd/TjZY4dOJ0pMwVTT/orYY4WdFReLys1nBveHPpqeJr9lEFJYd?=
 =?us-ascii?Q?kzkQVKRA68XtSEeCYqNLwrd+LhHBiBpGKO1gUeIONJAHmA8xauk3XE7blKlp?=
 =?us-ascii?Q?FYHevVdjQZdYfNbk62+LtyXvGgtAwa7+VQu54NICQk0AwElEBQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 19:29:32.3415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a17da0-f312-4c7c-64cb-08dcfd070248
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8611

Add a test that randomly sets the cpumask from available CPUs for
the nvmet-wq while running the fio workload. This patch has been
tested on nvme-loop and nvme-tcp transport.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 tests/nvme/055     | 99 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/055.out |  3 ++
 2 files changed, 102 insertions(+)
 create mode 100755 tests/nvme/055
 create mode 100644 tests/nvme/055.out

diff --git a/tests/nvme/055 b/tests/nvme/055
new file mode 100755
index 0000000..9fe27a3
--- /dev/null
+++ b/tests/nvme/055
@@ -0,0 +1,99 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2024 Chaitanya Kulkarni
+#
+# Test nvmet-wq cpumask sysfs attribute with NVMe-oF and fio workload
+#
+
+. tests/nvme/rc
+
+DESCRIPTION="Test nvmet-wq cpumask sysfs attribute with fio on NVMe-oF device"
+TIMED=1
+
+requires() {
+	_nvme_requires
+	 _have_fio && _have_loop
+	_require_nvme_trtype_is_fabrics
+}
+
+cleanup_setup() {
+	_nvme_disconnect_subsys
+	_nvmet_target_cleanup
+}
+
+test() {
+	local cpumask_path="/sys/devices/virtual/workqueue/nvmet-wq/cpumask"
+	local original_cpumask
+	local min_cpus
+	local max_cpus
+	local numbers
+	local idx
+	local ns
+
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+	_nvmet_target_setup
+	_nvme_connect_subsys
+
+	if [ ! -f "$cpumask_path" ]; then
+		SKIP_REASONS+=("nvmet_wq cpumask sysfs attribute not found.")
+		cleanup_setup
+		return 1
+	fi
+
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+
+	original_cpumask=$(cat "$cpumask_path")
+
+	num_cpus=$(nproc)
+	max_cpus=$(( num_cpus < 20 ? num_cpus : 20 ))
+	min_cpus=0
+	#shellcheck disable=SC2207
+	numbers=($(seq $min_cpus $max_cpus))
+
+	_run_fio_rand_io --filename="/dev/${ns}" --time_based --runtime=130s \
+			 --iodepth=8 --size="${NVME_IMG_SIZE}" &> "$FULL" &
+
+	# Let the fio settle down else we will break in the loop for fio check
+	sleep 1
+	for ((i = 0; i < max_cpus; i++)); do
+		if ! pgrep -x fio &> /dev/null ; then
+			break
+		fi
+
+		if [[ ${#numbers[@]} -eq 0 ]]; then
+			break
+		fi
+
+		idx=$((RANDOM % ${#numbers[@]}))
+
+		#shellcheck disable=SC2004
+		cpu_mask=$(printf "%X" $((1 << ${numbers[idx]})))
+		echo "$cpu_mask" > "$cpumask_path"
+		if [[ $(cat "$cpumask_path") =~ ^[0,]*${cpu_mask}\n$ ]]; then
+			echo "Test Failed: cpumask was not set correctly "
+			echo "Expected ${cpu_mask} found $(cat "$cpumask_path")"
+			cleanup_setup
+			return 1
+		fi
+		sleep 3
+		# Remove the selected number
+		numbers=("${numbers[@]:0:$idx}" "${numbers[@]:$((idx + 1))}")
+	done
+
+	killall fio &> /dev/null
+
+	# Restore original cpumask
+	echo "$original_cpumask" > "$cpumask_path"
+	restored_cpumask=$(cat "$cpumask_path")
+
+	if [[ "$restored_cpumask" != "$original_cpumask" ]]; then
+		echo "Failed to restore original cpumask."
+		cleanup_setup
+		return 1
+	fi
+
+	cleanup_setup
+	echo "Test complete"
+}
diff --git a/tests/nvme/055.out b/tests/nvme/055.out
new file mode 100644
index 0000000..427dfee
--- /dev/null
+++ b/tests/nvme/055.out
@@ -0,0 +1,3 @@
+Running nvme/055
+disconnected 1 controller(s)
+Test complete
-- 
2.40.0

