Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D53E611A
	for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 04:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705465369; cv=fail; b=CsloeegNOnIujQ0XdWv7Y9/DxfHKMuqIFUAMhYhNOAbQc+jjXMboawYAMj7wTk21+gQm7AcQxc7r6fZd7i/Eeu+hB1W0OFbbrFnHhMQGHKoFnFJS7D6Y+UZxKZF7vTx6rD0rAW/aIZngMhJmQT0e1j+A9efUU5uXBqzYT0c+4zE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705465369; c=relaxed/simple;
	bh=WKjyvKpOsQZELM8j59smXHTK6+hr3SrJfcrlwnM0s7s=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=Uu5fhT/Z/nUSFKyIH7yQFISJ5k7T9VLffMBs4mODi3ztkVSdVXm7//rN8td0+UJs5P/1uwNE9tbllgPe0eWDK3LpiaGkMZJrwrsBMdx+yY7GynheYR3wn6x6EqJj0h1z4FjJS5xvzp3E6UbN0NPJQT1ok5tMVnEhRMeTiAsEt48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rrOzB8lX; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rrOzB8lX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EewG5gbWRBF6Ywqe0iBnCYubhNS16/RHK0qbpMyIXEyHQ7XEQ+m3XH0HogZkVE47MRBTB6hTENbM/yeq2MlVQl5iQkJyCFTJzFBJR1LLReneKb5CJxzrVYN5d18/jbTHvusC0czb6zLfinmow+KTQq5qRsCGHyuev3P6y+teQmK8anfIkQDyBwuU2RWfuLRA0GW85UzOXigUmNDtlKxP7sMrasQCMXojkL/RB8pgjGD759oWmEhHEJ6CeidwuUWVXe1o/DKaozSAW0MwbSrGgbF/EerSYfjtcHaBRc47NW3/d324G77j4gryLB4tcKFYu2F8YvC58VL1TsZQM6U8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKEQi1OfW9NNDNlpRZKU/dzRzSLTneUxsl6FULUxdp8=;
 b=KrqLNl8aK5h3uilyCwrjHmE2bIsmSYXyrPdS0PL8c6eNg4vI/PAuDiiIWTwhqHLqVIIfWdpJKZgZQedpjjJ34Rs+/ko0sfWWMRD62k9RB3Ds0exRjHux1YbFKDRCTJkUglkeMeUqkbni5+kiUGviKdxP9amxUJOJLfwzPuthjsnK22Hg/2fBshG7H70aB8HK5GPnoIWVfOr519OfCRdrga7c9FhRSyS60krt2eyaOMB4Ryo9/1uCReBHKkN6/AKD4hiJ9QyfSQ+Nwu0RfICOiVdiiu+gxhligSt2zi9euFpD/GUQz1oh770nhxDW3vURxKEtXoqS2FVdjDzHK2sBpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKEQi1OfW9NNDNlpRZKU/dzRzSLTneUxsl6FULUxdp8=;
 b=rrOzB8lXWq+G0A70vFovodqCEtOg8YFssKw6CCBrf35I88wLlfv2wPTbHXndnDMyvCj/btDuj7VmqiGQdu8b/dtC3XQ3iULNsUpsXvgRlczww9Gki8S5NQyyVnW8z7P7QLfGVv2EAlhqJNLkNP659hJOTsTMdT2kW1B3JCjiU+PjqnUPRJ2kwuJ645OXPnjCzXmsVFKajoUM9b9Snft0nSWVTlF/tmIO5cZ4YO+hrcgeQFnqr52aotTWYBkrRpyNv1/9C0koa5fDvZgFhmbvy1Utpt6KE3XkP+vLqV78I2bvIaaOyOpqnN538h0mYJZvBg3o8oduN1DrKi+ZuO/qaA==
Received: from BL1PR13CA0137.namprd13.prod.outlook.com (2603:10b6:208:2bb::22)
 by PH7PR12MB6761.namprd12.prod.outlook.com (2603:10b6:510:1ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Wed, 17 Jan
 2024 04:22:44 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2bb:cafe::24) by BL1PR13CA0137.outlook.office365.com
 (2603:10b6:208:2bb::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Wed, 17 Jan 2024 04:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 04:22:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 16 Jan
 2024 20:22:29 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 16 Jan
 2024 20:22:28 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC: <shinichiro.kawasaki@wdc.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests V2 1/1] nvme: add nvme pci timeout testcase
Date: Tue, 16 Jan 2024 20:22:06 -0800
Message-ID: <20240117042206.11031-2-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20240117042206.11031-1-kch@nvidia.com>
References: <20240117042206.11031-1-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|PH7PR12MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c51410-8b47-4f08-41f6-08dc1713f396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OYRq2efTiwAUOhUSoNZYy7gSZ3uwSPv0BS9SLsILHjsLD4SF7t4hRvnQkwXIfyKbfiYErTg+c60c1/DYme8Zg7gPCLWYZ00pBWptQv+KOuT1ULoI9hGW0IG4BhXfSHcg5MhCbtHUpUB7QAbhpH8E7uZYh1Opp/sNxJpe9qAtO1I/oElAtUh+HNB7G9lcsgHSleK5zUWdVJEIfmbCdyTyp9Eh+z05hyb2atApAZJEr2fMbXWZWO7v5Rq83R3vl7h8P+zBKV+U3ozOuTb8Ie09050iUvmaUozDroiZUtp+ANu0sSj/iF168RMq78R6+OxD4+k0Xr7OT1JGmCLixyTUD9jR2x7bd7sIzZK1yFFxtu0L1sl1+hRRcdCI1YIzrf7FGuxsDa6Ld3gj4Gd3GQur0PRx9xiqAcIATD2w4W5CfRqVoTy4vN9WAHVR18dw0vF7TuGZF8NA2kOGQaAf6tTkSaXpcf/0fmp4mZ+BlH7UKhkUKoCno55SMyCD3uKk6tdHbxiGL4pG79sjGPEW1OmJrpejM1PDtXxQvgbugHCbg+/c2IbS1Y9uwnN8o+4fxKmice38/7u6w7CeXnyBaEyzjbAX8gyNrGsnaHuCejKdlJz8M0+2iO6wj0twMNSDiPSLZL1/elB2q62KFa3parOgjfxzgc6mnYAX4UrMTtx2vpO6b2jr+VSUymNeSUA34yCgs8DzZCobK/xWEZYRsz0n3tWdFNgRJGKyIloCYVtHnR4fSXsUAJ8zXDd0rJVXFxehj3e9Gl7RPIAxoCr4wcxROQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(82740400003)(83380400001)(7636003)(5660300002)(4326008)(8676002)(8936002)(356005)(2906002)(16526019)(336012)(2616005)(26005)(47076005)(426003)(40480700001)(107886003)(1076003)(36860700001)(40460700003)(7696005)(478600001)(6666004)(36756003)(110136005)(316002)(70206006)(70586007)(54906003)(41300700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 04:22:43.6264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c51410-8b47-4f08-41f6-08dc1713f396
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6761

Trigger and test nvme-pci timeout with concurrent fio jobs.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 tests/nvme/050     | 74 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/050.out |  2 ++
 2 files changed, 76 insertions(+)
 create mode 100755 tests/nvme/050
 create mode 100644 tests/nvme/050.out

diff --git a/tests/nvme/050 b/tests/nvme/050
new file mode 100755
index 0000000..6c44b43
--- /dev/null
+++ b/tests/nvme/050
@@ -0,0 +1,74 @@
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
+
+sysfs_path="/sys/kernel/debug/fail_io_timeout/"
+#restrict test to nvme-pci only
+nvme_trtype=pci
+
+# fault injection config array
+declare -A fi_array
+
+requires() {
+        _require_nvme_trtype pci
+        _have_fio
+        _nvme_requires
+        _have_kernel_option FAIL_IO_TIMEOUT
+}
+
+device_requires() {
+	_require_test_dev_is_nvme
+}
+
+save_fi_settings() {
+	for fi_attr in probability interval times space verbose
+	do
+		fi_array["${fi_attr}"]=$(cat "${sysfs_path}/${fi_attr}")
+	done
+}
+
+restore_fi_settings() {
+	for fi_attr in probability interval times space verbose
+	do
+		echo "${fi_array["${fi_attr}"]}" > "${sysfs_path}/${fi_attr}"
+	done
+}
+
+test_device() {
+	local nvme_ns
+	local io_fimeout_fail
+
+	echo "Running ${TEST_NAME}"
+
+	nvme_ns="$(basename "${TEST_DEV}")"
+	io_fimeout_fail="$(cat /sys/block/"${nvme_ns}"/io-timeout-fail)"
+	save_fi_settings
+	echo 1 > /sys/block/"${nvme_ns}"/io-timeout-fail
+
+	echo 99 > /sys/kernel/debug/fail_io_timeout/probability
+	echo 10 > /sys/kernel/debug/fail_io_timeout/interval
+	echo -1 > /sys/kernel/debug/fail_io_timeout/times
+	echo  0 > /sys/kernel/debug/fail_io_timeout/space
+	echo  1 > /sys/kernel/debug/fail_io_timeout/verbose
+
+	fio --bs=4k --rw=randread --norandommap --numjobs="$(nproc)" \
+	    --name=reads --direct=1 --filename="${TEST_DEV}" --group_reporting \
+	    --time_based --runtime=1m 2>&1 | grep -q "Input/output error"
+
+	# shellcheck disable=SC2181
+	if [ $? -eq 0 ]; then
+		echo "Test complete"
+	else
+		echo "Test failed"
+	fi
+
+	restore_fi_settings
+	echo "${io_fimeout_fail}" > /sys/block/"${nvme_ns}"/io-timeout-fail
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

