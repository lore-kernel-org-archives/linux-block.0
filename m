Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8093C32
	for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 03:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DAxY/1/N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8qAOBAdlgjbeCpGAN+pfg4DoQyacmfocrvRGCGC9qiFbjeYCKnvD07FiAYczEHioYPZ7MEh4RFm8ST/eZar5uClpt/X14RsfIx+PHobsdoT/890lg0hQqVsyalhv4qtvKIue6rNljahbJoLp5rnrzS0huYzAu+nSvR0PFOdJcuN0bwzd2QIpoJQZZcj/Pq3e4qP9r5Ir2E6CaF/SdA8fzaHosQoyQERUJS4qjv1DDHzos+oKmKtGut4d0O9TAZC8zepmMcJcyfF3uFd9OLtQwNmh8OW6ga/vscrPRp9KCo6b2owBf6XXg6g+0IV8BRQtbKa6uGc0L/TBZk4BYk8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4Pz3Fqe/f8M0e7nZwMmN/0I0cXmhH29hCVKHPPxdxY=;
 b=aWjHioIZ8HD5e9HHM1ijTqPVoG7TXcjfUy1ZCWeJPz1bJ7Zlc5lIgAFjP/6mUdpirnfXoS6JL8oF80RiYT6ATuEEUEFT2TID2aregMIvJQeQxN7paYt24UW69TAmSYOmI7XjvbSKALOrcQw9jHqvkBPa4tx1d3MQdQi7lwwYy2UrGldYabbCzcbHMv8yKCfAz4xouaSmjFALlX4AYYMF8/mSCSUU1D5mQAHSOlsAnVQ9SH5loGucFABlhmVNVtL6EjfAXLh8zC6APHr920whtXra6yF/UbNMNs6Cb+MC6QkugMf2QZFg39zSF/n2OT2ZjJsWe6tRX5loeZa9cqFKKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4Pz3Fqe/f8M0e7nZwMmN/0I0cXmhH29hCVKHPPxdxY=;
 b=DAxY/1/N+5UfL4l1sdPNU5zR+jU3BaTrrN40sC9GL230U8H9TgKSZZr9TbySCKMfmLvCLjcCKnqZ3SucGdQgSWrvLpJtl/A2irfL7eEoQzWTwYu9Xx1nFNNpHFpQZVvrJ1MGgux/XKyEanV1MlTRqEFH/HCQvKV6/Z8PthiOKFrQux0hpJ6QDZohAEmvFMb5rj3IPAKriJAQA7XqDForw1A8FaT++88o7prfJvAXMC1WM5OzQmvuTzIhHO4P8EKweK5hAmw0Sj8BAinrda/fhobu7v3icvB7IcC2/r5ymLiM+78mALF/zEf83nwGrFOAUBL7Ndt6u7M58PJ4bybK3Q==
Received: from SA9PR13CA0003.namprd13.prod.outlook.com (2603:10b6:806:21::8)
 by IA1PR12MB6553.namprd12.prod.outlook.com (2603:10b6:208:3a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 03:58:24 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:21:cafe::37) by SA9PR13CA0003.outlook.office365.com
 (2603:10b6:806:21::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.15 via Frontend
 Transport; Wed, 10 Jan 2024 03:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 03:58:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 19:58:08 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 19:58:08 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <shinichiro.kawasaki@wdc.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] nvme: add nvme pci timeout testcase
Date: Tue, 9 Jan 2024 19:57:56 -0800
Message-ID: <20240110035756.9537-1-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|IA1PR12MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fc34064-f6b0-4c30-e60c-08dc119064af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8vWIwR81KAalc0yaTyeCRs+Y4JifPD+f/2T70rJaX0sARtNTtbQsJpN1jBNM5tNAMcUd5/Ng+2x77su6AY0Zu2lNMYccSRGcSRmuotVlJLtU1dD7f8RWluKDgVJr5CZuF9OBAkZAfykQtjy7SE+KzHAa1sBBTZsUCN3MCsR0oMx/CIaGxCi6SV1nHjHxRmqnJMRmH5M2Zg9jow2CBnD//ZR9J/ugZVsLlXq1p1fchzeUOH9wXwSvXFC5HyyBXZsezgbBqoP02is2oCV/zfLLZdwMqFUXPG79j14cVQiGvPseV2W4WU1j2XRyRPlLTWppTwnYa4wq2xliOwWoSaZB0KzPEuG9p35IbMFOYbCbxG6wIS3uqgzCrltQUnti4mTp+Ju8PeTKJNLQjvLXS/WQJlz4mdEFcrQ3o6i4abK9UPSUkbXK2tlfyknLkwGxw49G4AmJpSGMRjIVjTKD3qWrQ7+6Ci475P19f9ww1UGxq/aCEFWC51fwgzeUeEht0vlA/FY6cgcVwDvJsHkPdYZJxHR16U/HF4EdTguuNWMpfwPl/I1cgGSfzSCaW0ZxZ1kULhAsqnvIjazhOKKWFw1dBJ9532b5uDvH2d8dca0841JVo5pLOnpZIsebDXsbRHtrOaySXelemoMvJ8ptn/NDRc7Te01caMLJyQfpYuRJAFGA2jzIp547ZgWL4yzqsrmymWnJ7ykgsTBa8m67P4Hwt6ik9jI1vmZOlrJHFzzJiIhd+2NYJYxBOXr5o0LXvqwDcVraYaAp45XdpSmwC/CE3A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(83380400001)(70206006)(70586007)(41300700001)(36756003)(7636003)(356005)(54906003)(82740400003)(36860700001)(107886003)(47076005)(16526019)(1076003)(426003)(336012)(2616005)(26005)(5660300002)(2906002)(110136005)(316002)(7696005)(478600001)(6666004)(8936002)(4326008)(8676002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 03:58:24.0573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc34064-f6b0-4c30-e60c-08dc119064af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6553

Trigger and test nvme-pci timeout with concurrent fio jobs.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 tests/nvme/050     | 43 +++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/050.out |  2 ++
 2 files changed, 45 insertions(+)
 create mode 100755 tests/nvme/050
 create mode 100644 tests/nvme/050.out

diff --git a/tests/nvme/050 b/tests/nvme/050
new file mode 100755
index 0000000..ba54bcd
--- /dev/null
+++ b/tests/nvme/050
@@ -0,0 +1,43 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Chaitanya Kulkarni.
+#
+# Test NVMe-PCI timeout with FIO jobs by triggering the nvme_timeout function.
+#
+
+. tests/nvme/rc
+
+DESCRIPTION="test nvme-pci timeout with fio jobs."
+
+requires() {
+	_require_nvme_trtype pci
+	_have_fio
+	_nvme_requires
+}
+
+test() {
+	local dev="/dev/nvme0n1"
+
+	echo "Running ${TEST_NAME}"
+
+	echo 1 > /sys/block/nvme0n1/io-timeout-fail
+
+	echo 99 > /sys/kernel/debug/fail_io_timeout/probability
+	echo 10 > /sys/kernel/debug/fail_io_timeout/interval
+	echo -1 > /sys/kernel/debug/fail_io_timeout/times
+	echo  0 > /sys/kernel/debug/fail_io_timeout/space
+	echo  1 > /sys/kernel/debug/fail_io_timeout/verbose
+
+	# shellcheck disable=SC2046
+	fio --bs=4k --rw=randread --norandommap --numjobs=$(nproc) \
+	    --name=reads --direct=1 --filename=${dev} --group_reporting \
+	    --time_based --runtime=1m 2>&1 | grep -q "Input/output error"
+
+	# shellcheck disable=SC2181
+	if [ $? -eq 0 ]; then
+		echo "Test complete"
+	else
+		echo "Test failed"
+	fi
+	modprobe -r nvme
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

