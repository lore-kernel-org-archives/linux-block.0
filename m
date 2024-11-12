Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F9F204921
	for <linux-block@vger.kernel.org>; Tue, 12 Nov 2024 01:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731374966; cv=fail; b=AkgFBKAGqmZ9zRsm55A04FWm+mdH4bHT2ttj5pMWz8TCQSHEF/poezugVuy64o+bR96akjBYg1eUyX0z1atWEntfrJEHvQRIZFh70qcWGwyw4rIdkEj4+8rcxhRLnfZtNyXmhwjFSqKB8AEn6lW1mH5cJnC7zeykd4VosXhIfQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731374966; c=relaxed/simple;
	bh=CFU+yTgAAwE0CAyRIuwwleFYzQsZvdouv9G0KLB8agg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=navFifLqPUNXT0rmbo1/xZLCkNrTt2t8wjEN8GbRCAtPmg1wf+TnT4eGdjX93bF4xVEGd97Gle3qZMow/8YH/V1YXY4rHRT+pEUImF6IpORqPoxjXlyth2eGqDyG4DXJ+dOtp3U1VITPqxGe139H5g3Eii+UFCijvjBkhD+IIS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ze5TV+L6; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ze5TV+L6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+IQVssFIYdYdrxf3ROsj7qrtgMHBNnGqpsk4dNQeneXAM1pdMOzL5Jk4AasJoPthkgCU7yAUf+nwvrTi6IIO8Xem9boSNP8p69FIlyEZCBQfMR2aeE9xJwmy3qg/h2O5+9fQPtEv2HbY6ETHK76o67o/7RuRH37AejD9G6WYjHeVbOdkZzRvSsqRE9EAIIudDOd/ZuUBNSccFk/XPCrCBNoeNEdl79DkQJQCF8rDngKM/tVSpDlWIhB3RQVb0whoCLa6bHK7Y3ffmkEKv5vweIQO32ux6vYu2i21gO+oFvCKPBJeSlIc59LoFxuu5WEej5k2Ax17ILmOw93MJzc5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7J/Ter1Dehc7CvvzIqb7UvCOH6N2WHvnEhXI9wImzHQ=;
 b=bfO+o+q5aKFxUVBQLPxv5dGKCH8SgSi+nJqTfGcYylApuSWztGmBsOPivX7EIqUzBbpolWIMxKKVfcJY+AhSMU1Y4ZHtS0W38/lOQqEBDIzkW5GA4e32KuOXEbypHzR5Meur1U6eTVGhxjo6KEecODlh/fd/o2MaOH2K43cqVUmsqDvZv9IGBgeezpNXCHsEHekIZbI4dNheknqY+a7YdFDvhpLbGScDNbEFWGza59nbCy+G7tur2yRQ6jy0dZawiF62BwpaqWwmMGEowUSJvs3AsPoeFoGjSpcVpF+c+pY9DJZle5dH8XOPWjvlYRE2MqKzPKg+tYssHcoqbpqz8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.alibaba.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7J/Ter1Dehc7CvvzIqb7UvCOH6N2WHvnEhXI9wImzHQ=;
 b=Ze5TV+L6TLb/rG3NC84klz8cs5nIk/PLAT6li6xjJlFwY0vX+96aKBGAkPASiT7RKb3wfAZr8BZFHPzV7QoLxlzTUg00OfT2TMsC4cWs447Dld+6EJmMADw/uwpQnVaGIWHmmNAxEYi17NaEwUOOwOYU+ldD4G7QtlhmfSMxYaiEUdqNVjbUoYidxthmhuLxTEwp7xBFtPOja8n9SdkaJ483r7XRXGNd0taYf/7gstKKtWyyLNCcHd3aSnezfABqF5u4nw+eSn/IsytDQcWZkk5dWoFMfIlaksiF48pBvFIQuh+LF+zJ4oVdWYrrgX3cqEAfyywbhvA2qBqpq3hP/A==
Received: from BN9PR03CA0670.namprd03.prod.outlook.com (2603:10b6:408:10e::15)
 by PH8PR12MB6723.namprd12.prod.outlook.com (2603:10b6:510:1ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Tue, 12 Nov
 2024 01:29:20 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:10e:cafe::7b) by BN9PR03CA0670.outlook.office365.com
 (2603:10b6:408:10e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27 via Frontend
 Transport; Tue, 12 Nov 2024 01:29:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.1 via Frontend Transport; Tue, 12 Nov 2024 01:29:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 11 Nov
 2024 17:29:12 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 11 Nov
 2024 17:29:11 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <kanie@linux.alibaba.com>
CC: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
	<shinichiro.kawasaki@wdc.com>, <dwagner@suse.de>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH blktest V2] nvme: test nvmet-wq sysfs interface
Date: Mon, 11 Nov 2024 17:29:04 -0800
Message-ID: <20241112012904.5182-1-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|PH8PR12MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0ab6d7-02dc-4e57-ffc1-08dd02b96ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JkJsm4blpQ3KKk7PZx/4twZbyo645rauAGV3bZsthaynbquVu5qcUcendTn9?=
 =?us-ascii?Q?eJLbK/gcpnEtpRGarZpMt6VcGNAI0Adh948ZNouHoBGj2yi39kRa5n0m3UDN?=
 =?us-ascii?Q?jntWK3SljyFQYl9z2RGjrpnY1mtwsa7bYIW82SZ3nqrFKv2nnLNUoJIxPam/?=
 =?us-ascii?Q?/mbdd4Y6OUmz2xgjHwcqEbd0p4CzDT4UKKiCaT02nfareYFrFA+n6g1Y9cNI?=
 =?us-ascii?Q?fBkKvc9fxiUwTCmN1YuNS/MpKhx4bDWxW+LShk6NwpVEiHMv5LnJj4juBA+G?=
 =?us-ascii?Q?U1eFoDKKlfSPqSUkncpcNPd1cTMYgyTM0FMbe0nGilQQADekaFxQ8mhEi236?=
 =?us-ascii?Q?h17Jpd+yqkag29QVzxBtPSUXo9DsvTaLKFibJvdhVG2Clo5J5o6YnVISdUX1?=
 =?us-ascii?Q?d/6BUjkgWWa0fXab649N9oFPa8Ca3bhE/q3E7VNs/HXgCP8AsWzfETSKWIca?=
 =?us-ascii?Q?r7UvsTS+ReN9PfTa2YQPIieoidMGHPrCTNLIoLKce0/Lx66QHJm98k8XKiXA?=
 =?us-ascii?Q?dAbfoGIFqg8HyFBIqoaWjb9VX9sF/DbH8nUwZT1aWbS6KbtcJhwx/8xzKCRA?=
 =?us-ascii?Q?8esUC30J81eD2k9oQVrkrjXGlSzWfVAGy1uHEW0R1PLYCjrj7+rynBpgd0G7?=
 =?us-ascii?Q?dy3olCUWeOSH8jk1dvD6D7H8GMiHbcDGD1bqy8X8RJVYUR2NHWTyhNUM9EJ4?=
 =?us-ascii?Q?HZor/9zEecrHffShSF0Yj055v9+eYRoRjVlsgL0zdW0DhEPLDbaaUwoo29Lt?=
 =?us-ascii?Q?97IMewumUj6HAE8oGJ/NxiebydwBUYhy22t9MOHzRBhE9GYoLwjsJibKIjmL?=
 =?us-ascii?Q?0lbzEX4ZWrKMgRaxqzvevk7tDMgWc6D+Ls1NWbeMsahJdkqFrENaUHJh/fvN?=
 =?us-ascii?Q?1jQEHzjlF9a+MqRJRc18G94PljiTqbz+C2eI3sv6b2vcIlUiRs2HNpCWrFC1?=
 =?us-ascii?Q?LcxTC0+29MeJsoGLHyt6iy2h83PN4VRVVFkQDM7fG8bXA790To3RQhfBdzvE?=
 =?us-ascii?Q?CgogNk/n5G9cS6GLGAn5FSfnKYuX9VDqQQORsK3bfY5ZZLFxiG+fFq9FZ5PW?=
 =?us-ascii?Q?CHIk2BM6R22qjw7oqUuOlyyQtuKPBSdtAVb7t45No7RisVN2y8TgeanEgAYR?=
 =?us-ascii?Q?FnNajLJZ+e53G8p/d94m2wuTSQ2gUzGcLLZST9b4MIs5BO0Ie5umlAN1mPSU?=
 =?us-ascii?Q?TSFPbpWARK4E+TTLzz3C7brKeovJCxXG2irBTepkIP72osFLglLsTD3TcL8y?=
 =?us-ascii?Q?LTWAtffWjhvzVAQDpvz3Nq/dRNR0fvBb8Frfl98fhhliLA7SlhjpMW3TyFHR?=
 =?us-ascii?Q?mwEeUCVCR5s2pIEXW3tyk77CFWyH+g2YWL//iWKfPk8qNxIdLI6D1ytXgqkG?=
 =?us-ascii?Q?ehgp4F9B3uaDqKLTYKiwWgi9Jr/46dNgAnMdYaxjb94eDL9xiQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 01:29:20.3279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0ab6d7-02dc-4e57-ffc1-08dd02b96ea9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6723

Add a test that randomly sets the cpumask from available CPUs for
the nvmet-wq while running the fio workload. This patch has been
tested on nvme-loop and nvme-tcp transport.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
V2:-

1. Remove the space.
2. Add set_conditions.
3. Use read -a numbers -d '' < <(seq $min_cpus $max_cpus) 
4. Use           : ${TIMEOUT:=60} 
5. Remove pgrep use kill -0
6. Simplify cpumask calculation
7. Remove killall

 tests/nvme/055     | 94 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/055.out |  3 ++
 2 files changed, 97 insertions(+)
 create mode 100755 tests/nvme/055
 create mode 100644 tests/nvme/055.out

diff --git a/tests/nvme/055 b/tests/nvme/055
new file mode 100755
index 0000000..24b72c8
--- /dev/null
+++ b/tests/nvme/055
@@ -0,0 +1,94 @@
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
+	_have_fio && _have_loop
+	_require_nvme_trtype_is_fabrics
+}
+
+set_conditions() {
+       _set_nvme_trtype "$@"
+}
+
+
+cleanup_setup() {
+	_nvme_disconnect_subsys
+	_nvmet_target_cleanup
+}
+
+test() {
+	local cpumask_path="/sys/devices/virtual/workqueue/nvmet-wq/cpumask"
+	local restored_cpumask
+	local original_cpumask
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
+	#shellcheck disable=SC2010
+	CPUS="$(ls -1 /sys/devices/system/cpu | grep -E '^cpu[0-9]+$' | sed 's/cpu//')"
+
+	: "${TIMEOUT:=60}"
+	_run_fio_rand_io --filename="/dev/${ns}" \
+			 --iodepth=8 --size="${NVME_IMG_SIZE}" &> "$FULL" &
+
+	# Let the fio settle down else we will break in the loop for fio check
+	sleep 1
+
+	for cpu in $CPUS; do
+
+		if ! kill -0 $! 2> /dev/null ; then
+			break
+		fi
+
+		# Set the cpumask for nvmet-wq to only the current CPU
+		echo "$cpu" > "$cpumask_path" 2>/dev/null
+		cpu_mask=$(cat "$cpumask_path")
+
+		if [[ "$(cat "$cpumask_path")" =~ ^[0,]*${cpu_mask}\n$  ]]; then
+			echo "Test Failed: cpumask was not set correctly "
+			echo "Expected ${cpu_mask} found $(cat "$cpumask_path")"
+			cleanup_setup
+			return 1
+		fi
+		sleep 3
+	done
+
+	kill -9 $! &> /dev/null
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

