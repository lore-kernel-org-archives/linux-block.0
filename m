Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79C92066DE
	for <linux-block@vger.kernel.org>; Fri,  6 Dec 2024 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733493126; cv=fail; b=l3z0imLkbJSl326B0LiPIDAm8+pgi/8fNCq40Ju5++kXdAeteNzoOm8adTv5hP4yz+nIUg1x0JvXCguuF1H0ggMx4KffbHuxo7Bw+ewNo8wmywGBaqigeljk6cLA8/eb+PbDFlTtK28G0lxz6k3l1E6kayezBaun+fVDsjhpDsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733493126; c=relaxed/simple;
	bh=Ombqya65qYOEQIQLGu3tL0GaEVsdtyli8qpqKAuKuoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ifI1wQaShOAUOH+YK95Sa19MRhFDIuMXevX9608fuj6cvy73rszRLvAe4umJAyodrkwgAaQ/MPIAwaVcUvHVAQSFHqWbDR8Aa9jqQXmsh80bjGpP5Qy/lgQ2pAj/EamTdEqASZ7b4IKz08HPGBFo/5K9aIf9kraMzovwbcWgIXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ExqxBBfP; arc=fail smtp.client-ip=40.107.96.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ExqxBBfP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CiJWR16XRpgHdPTnS6WfEraogZFRzZbL8IVMQF7GDU8kxVG4IhLCnkTGq6nTF/8+2yGtZF0Mg4nJ457Itm3Sf5iWkfZjUbL03y3VaYZh3BFsKn+CEboBSSGWv1DOoXYHNqjmn/5hGt6UWOZXIU40BLxoXT9wWPjatCgG+suES1XWRlj4MqrzP6FvZQfNKkEBRySn+yGdXQaQISY6bJDa5zLv8Vw3/DDBmFFNCKWI+N04hkOtolpgdGcmu2YNZ7LxX1kYBANiVJV8F8cucOq7+sz5TDbfDFzA3GKW84h3lZn7//p7tazpnSqYkAtn19zI8FQhk0vp9mc6Y+ny/dvYbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mxzVhDV08ngtVVetPKZ/6KeOr5JIGxofdladdrqfs0=;
 b=lo9uwokDgZiyLJCvnlvXUpmCe2VgNopzWzX3f3xprOlxopeb0ytKbLSqP/5pUGEteS8v5f40QhxfmGZynMd2+n1yh96W2Mo3dgIh8CSPY3ubBEgDXe7q1vGX2Pfb+lx9M9Uz6YWnRWV0voK7O4yBeF3KEJxGXF0i8dhTawPcNGQpKbeol7PjW+nI9vfJimMh3FwH0wn9t6hKHjL1Ny91njMsVOauF2tOSKY+vau0Tcq/60Wi3+YlWD08Z9RKTjKvVPCBUcWsCNbIN3rQGsZxf/plFfojnZKAJ4iHljIb2MTJXYcGeXFN8WdwIKG0X0S8FUUwSePM/nzqX3cK08fS/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mxzVhDV08ngtVVetPKZ/6KeOr5JIGxofdladdrqfs0=;
 b=ExqxBBfPTm3oqF0EOlPLwgbvk1jQSw6Jlu2aTcVkfkMBUTKRldomYXJluJTZMWqdiGSCYcXTAcO5Q8MAs/EPXa+LprVob9jnfTN47EKHc83p9Xr90GMyIRpAuEnyU4GVcs9VulS8QIW+SoTvKC4QQfaCVOwkXGJ09r3/830U4cGVN95Y5LiS/3jJCIRIXT7tQfJd88sXlQyQN90xileP6Rrm8pmflAVE/JSUkOl6x+eDHUkOUqNcC6jb7eUy3+UnXW0l2rQcVKN0ZesohioMGXGTBUaQYC0GOzqQ+tKrVGOLLM+vumWPs1puYqgGynbQ3AnGRr48f8XOJ9OqPlg8tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 6 Dec
 2024 13:52:00 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 13:52:00 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: aaptel@nvidia.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	Shai Malin <smalin@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v5 5/5] nvme/055: add test for nvme-tcp zero-copy offload
Date: Fri,  6 Dec 2024 15:51:20 +0200
Message-Id: <20241206135120.5141-6-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206135120.5141-1-aaptel@nvidia.com>
References: <20241206135120.5141-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0438.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::9) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|BY5PR12MB4209:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bb06d1d-f5b0-40b2-5ccd-08dd15fd2821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3iJyx0FJUI0KqW3V1Uqy+wWhcmtFWdwyJPCZzw1RabmUDk+bBit8rqlofJT+?=
 =?us-ascii?Q?Fols3/X62P6gHwEG/5sBfojXpmkH96P266UULnVSqxYvL+iozvbpYGMKWVCj?=
 =?us-ascii?Q?arkw5HgX1iEjCnSCgmLYJXVgtof06D3Fac2ExLOyibOCdErTv4pd7U78I51X?=
 =?us-ascii?Q?GGdA8BYcBuFsnXhKuuMu6hkcyTUUkPrA9j4U2jGw+EL8m74NQOs68z95Szfs?=
 =?us-ascii?Q?yMAA1eZxHWQW9SUC9IpPDadKY6Scu62ZXw60WhVRVqXvtXcco8I2G+jJWTyU?=
 =?us-ascii?Q?j3oKoQfXgB1KyPYmtURkP4g6PL5cYeWYQI8WsBvgOGJadoUSr6eMloX+RJma?=
 =?us-ascii?Q?UeDyIuHHsYYgLVEoTrQCpJToiykLGuWv5Mby/7GZINCwhaCor3S5WmQ49MB5?=
 =?us-ascii?Q?4ktIl5B0l+keNiXDUWomkD07esRowY9tFFBIR6WQFRvaykj6y4eigzpGRRoz?=
 =?us-ascii?Q?0+AcOl6+jgqU0J+2SzXhEDaiz7X2aazlViUKfhNn0K12LjGjrbofWWR3ad0y?=
 =?us-ascii?Q?/GZSlDD82Xh5S9qZEHs5yfsifax9pfTkQ0ByDslP+gBmN+rj55iupTC4jaik?=
 =?us-ascii?Q?V0aRzHtTYWRORj1eXjufa7iU4+CmQbYau0AiZHXXHQ1cmf1AQd2AroB/xwEm?=
 =?us-ascii?Q?HzTcVru28YVGzW71j9gbqCV8D/15tD8J58riGZoeMRpOxjm+mvRTEFc6AYSE?=
 =?us-ascii?Q?jEi1zs9H9WmQTkcnW9CNiM7NNkmuNxGD6W7BxqeuTZWNv9eoT6G00XyNet9t?=
 =?us-ascii?Q?p3ZMv2mu2FP65/YBpP0eccNmJ05t8yEVJlypuaXATogFtrXjQUTi/xpGSyGU?=
 =?us-ascii?Q?kifFkS25l3eTEXtSwG/w0kbNFyZj6Lh2L8GQYe+hjvnoU9TvfIzl4DZfK+Fi?=
 =?us-ascii?Q?fVdHq0LjWGyXr4FxKW8LR9CxNwkOq6PP+5Dwgx0g1jYjY9k09x92jF77qk22?=
 =?us-ascii?Q?9zzI1ZMx1CAIJB9fWRpvMlnn4Tvm/HNrFcduZsunZkD7bYs5Ji9I+TsTMNKT?=
 =?us-ascii?Q?OZZa7qxIicb0MyYGfZTzTqZ4C/+kf052Clgl+iMT5SXrwCaAuuEkBHib1Ujw?=
 =?us-ascii?Q?JwCPLMlV0riAwtJj78stoGCnea+Phif3L3N5wrmVkySyaLvBGz1FypiPA+Sy?=
 =?us-ascii?Q?2ZmADB20QLSBf7Ki5yE0vBTKB6lfWxoBzEgdoImd1k41/p1bjlS8w+e3Ww/j?=
 =?us-ascii?Q?PZU811g540kXEzehqqgl/OXqm2CcjmD9v+nw63iD/Q1zIe8HAOIzcY1l9ATz?=
 =?us-ascii?Q?nv+4z+eMAZ3dzWBIb8spYKd9noHFoO1KMQCh9YwNr4Ce8KCTGTr57xKHdALQ?=
 =?us-ascii?Q?hQYvUqIiL6K6/+IY65XUbdgMJ/zVCfHm9ciDGDf+FGEmaw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JVhEu/rNlVj6l9hHMZ8T1nw/MB1zTNmLwXi1nr8XnB5GvACaZigDWizCuOvK?=
 =?us-ascii?Q?NUI/gBS7VReFJUvJgKGGr1WpUx+SYplAF9NBoK6/eDU5SvvNvTK5/+e4tMJU?=
 =?us-ascii?Q?IgYnxgV/emMG0OKOzERkgPcb0HM10UvmkMOsFUk4sUIAyQ+xsDzHv9QV/ajW?=
 =?us-ascii?Q?u5vlFXrSGFm9gV57W8PJ2JRHuM3/AyW0huO20TWYOjTzT0eyTMsCouEqz/8r?=
 =?us-ascii?Q?ap7pXrHoERCD6DPdUGpOuZ+L/qyZwgdlfQPCsQ22cPcLx8mPSuV/X1/RvZRr?=
 =?us-ascii?Q?LuVGH0XVfvGSTjMckDbHcaOMq6niu7ylyEh1jiMKVVhWtaVN+PVaEc8SsvlM?=
 =?us-ascii?Q?ll0CVF/3SHIq4/wsEhNCab5bcJrplmIpUhWjtcCb8StV93rqFBNnG+hYhWw8?=
 =?us-ascii?Q?AN+0KN0UbGSlWra7JnImyKJ3KCzqeElO5L157J7XaWjV4wMxe6xDAFBpoJNM?=
 =?us-ascii?Q?Egh9g/TXMqJqjbylpDj+zplnQWfm+6ZXCyT/1IoGTyHauVxPrxwVNbR2JAbT?=
 =?us-ascii?Q?tN4YMrVagqDJQjRzAHIsTmDXGUx780kG8HgfmiIljYeVaW6YCZbxMbiszy7L?=
 =?us-ascii?Q?l6TItOXQuuKf0PlpdW1hGqLRAMfVnZMLQk/pTa9tMlaLIpY8MMvsuQg6QhOv?=
 =?us-ascii?Q?r0iXt2VmKCGM/IR9vr5bgtastYaUz5eCOoVZODfceKoSDHuxQq6ANAjjPXHB?=
 =?us-ascii?Q?8/ISvZ3Db3ZWLnKCbwU54/q5soPBlOHhAJ24Gr50oo4GxaDWYwib/btU6j2Z?=
 =?us-ascii?Q?+5XufCuCQn0rWsSN133rGra3Jq9+gBCzpv+vf6xknuVkAKvLtjTGpKS5CmFg?=
 =?us-ascii?Q?v8JIk9/ORPJP6C27SwAe0sqgO3AoIjTmJ0y+CcL+rdxTyXJSa/i18r7+gyaG?=
 =?us-ascii?Q?j8sRyn9sh3zZiM5Xn3fbwVRcd0cbj2d9/WcHwfmrGJxZ1YySWjLFIklBvUyH?=
 =?us-ascii?Q?NQdIIEMyhxixY/NnR77dhg3nGxMpXW+0sXUHGdJzuqSIu/1bmfdkhlI1M+WB?=
 =?us-ascii?Q?gaUDLVNQDVucO99lS9LSV2D3iK/bTSY5d/HGWRllNScavdO5f8TmmuOH0Fya?=
 =?us-ascii?Q?TT3e4f51gy/6bccyEdB4l5xap76gh+x3tnbWu9rstKqrxaQWrn1Qj3T0y+l0?=
 =?us-ascii?Q?Vn18y3YzvaohAKzhcL3UnPaXNk5CtekLr/Y70TtBkOD8a39AXhRnGXrQnWH3?=
 =?us-ascii?Q?L+LgaOqmOB78C87IGXEA2BPedD92GdLrELUHyV/cvA21paUWPAbKixuk+cAe?=
 =?us-ascii?Q?d/OLwYA3lYRITDAyJeXoH3m4ojbHz2OLuynMy0TvBCxI2PCO8Zfd4lVHUwm3?=
 =?us-ascii?Q?l9e7TYyoWxaBvwTyTg9MJ7AVoKCS4h03svfH5q/yVsgmLcai/QqkjDfMNaeT?=
 =?us-ascii?Q?kdAA/X/MN6gH6usEWJCiSm0215reXCOO10ZeHXoOOFRVCQ9SfWICb9scLHDf?=
 =?us-ascii?Q?ToAPUHIItJd/bjlA7AnhfjtoEWSoT07Cvd8+JOBCBmlzuti0pwWOYUa8A+Px?=
 =?us-ascii?Q?tx46nJQ6zpXC6qy51HAeHVjS3FeuC51OCKpqTVHUasvaCj6FyWOFPns2ty0Y?=
 =?us-ascii?Q?3t+5lcqlTsxjIIX5Xscyp7FPGW6NYibKU6Z+8gGs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb06d1d-f5b0-40b2-5ccd-08dd15fd2821
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 13:52:00.2623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38NMS7g7SUt0Og+nw1fU3Rf3zRPIhIIKo/cnphYzyvLtlJUfTgXs9EPvtxEv18ED65TdKLi8wiN38xBqA8gBkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4209

This commit adds a new test for the kernel ULP DDP (Direct Data
Placement) feature with NVMe-TCP.

Configuration of DDP is per NIC and is done through a script in the
kernel source. For this reason we add 2 new config vars:
- KERNELSRC: path to the running kernel sources
- NVME_IFACE: name of the network interface to configure the offload on

Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Signed-off-by: Shai Malin smalin@nvidia.com
Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 Documentation/running-tests.md |   9 ++
 README.md                      |   1 +
 common/rc                      |   8 +
 tests/nvme/055                 | 268 +++++++++++++++++++++++++++++++++
 tests/nvme/055.out             |  44 ++++++
 tests/nvme/rc                  |   8 +
 6 files changed, 338 insertions(+)
 create mode 100755 tests/nvme/055
 create mode 100644 tests/nvme/055.out

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index fe4f729..a42fc91 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -124,6 +124,15 @@ The NVMe tests can be additionally parameterized via environment variables.
   be skipped and this script gets called. This makes it possible to run
   the fabric nvme tests against a real target.
 
+#### NVMe-TCP zero-copy offload
+
+The NVMe-TCP ZC offload tests use a couple more variables.
+
+- KERNELSRC: Path to running kernel sources.
+  Needed for the script to configure the offload.
+- NVME_IFACE: Name of the interface the offload should be enabled on.
+  This should be the same interface the NVMe connection is made with.
+
 ### Running nvme-rdma and SRP tests
 
 These tests will use the siw (soft-iWARP) driver by default. The rdma_rxe
diff --git a/README.md b/README.md
index 55227d9..5073510 100644
--- a/README.md
+++ b/README.md
@@ -30,6 +30,7 @@ Some tests require the following:
 - nbd-client and nbd-server (Debian) or nbd (Fedora, openSUSE, Arch Linux)
 - dmsetup (Debian) or device-mapper (Fedora, openSUSE, Arch Linux)
 - rublk (`cargo install --version=^0.1 rublk`) for ublk test
+- python3, ethtool, iproute2 for nvme-tcp zero-copy offload test
 
 Build blktests with `make`. Optionally, install it to a known location with
 `make install` (`/usr/local/blktests` by default, but this can be changed by
diff --git a/common/rc b/common/rc
index b2e68b2..0c8b51f 100644
--- a/common/rc
+++ b/common/rc
@@ -148,6 +148,14 @@ _have_loop() {
 	_have_driver loop && _have_program losetup
 }
 
+_have_kernel_source() {
+	if [ -z "${KERNELSRC}" ]; then
+		SKIP_REASONS+=("KERNELSRC not set")
+		return 1
+	fi
+	return 0
+}
+
 _have_blktrace() {
 	# CONFIG_BLK_DEV_IO_TRACE might still be disabled, but this is easier
 	# to check. We can fix it if someone complains.
diff --git a/tests/nvme/055 b/tests/nvme/055
new file mode 100755
index 0000000..4f2f87e
--- /dev/null
+++ b/tests/nvme/055
@@ -0,0 +1,268 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Aurelien Aptel <aaptel@nvidia.com>
+#
+# zero-copy offload
+
+. tests/nvme/rc
+
+DESCRIPTION="enable zero copy offload and run rw traffic"
+TIMED=1
+
+iface_idx=""
+
+# these vars get updated after each call to connect_run_disconnect()
+nb_packets=0
+nb_bytes=0
+nb_offload_packets=0
+nb_offload_bytes=0
+offload_bytes_ratio=0
+offload_packets_ratio=0
+
+requires() {
+	_nvme_requires
+	_require_remote_nvme_target
+	_require_nvme_trtype tcp
+	_have_kernel_option ULP_DDP
+	# require nvme-tcp as a module to be able to change the ddp_offload param
+	_have_module nvme_tcp && _have_module_param nvme_tcp ddp_offload
+	_have_fio
+	_have_program ip
+	_have_program ethtool
+	_have_kernel_source && _have_program python3 && have_netlink_cli
+	have_iface
+}
+
+have_netlink_cli() {
+	local cli
+	cli="${KERNELSRC}/tools/net/ynl/cli.py"
+
+	if ! [ -f "$cli" ]; then
+		SKIP_REASONS+=("Kernel sources do not have tools/net/ynl/cli.py")
+		return 1
+	fi
+
+	if ! "$cli" -h &> /dev/null; then
+		SKIP_REASONS+=("Cannot run the kernel tools/net/ynl/cli.py")
+		return 1;
+	fi
+
+	if ! [ -f "${KERNELSRC}/Documentation/netlink/specs/ulp_ddp.yaml" ]; then
+		SKIP_REASONS+=("Kernel sources do not have the ULP DDP netlink specs")
+		return 1
+	fi
+}
+
+have_iface() {
+	if [ -z "${NVME_IFACE}" ]; then
+		SKIP_REASONS+=("NVME_IFACE not set")
+		return 1
+	fi
+	return 0
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+netlink_cli() {
+	"${KERNELSRC}/tools/net/ynl/cli.py" \
+		--spec "${KERNELSRC}/Documentation/netlink/specs/ulp_ddp.yaml" \
+		"$@"
+}
+
+eth_stat() {
+	ethtool -S "${NVME_IFACE}" | awk "/ $1:/ { print \$2 }"
+}
+
+ddp_stat() {
+	netlink_cli --do stats-get --json "{\"ifindex\": $iface_idx}" \
+		| awk -F: "/'$1'/{print \$2;}" | tr -d '{},'
+}
+
+ddp_caps() {
+	local out
+	out="$(netlink_cli --do caps-get --json "{\"ifindex\": $iface_idx}")"
+	echo "$out" | tr '{},' '\n' | tr -d ' '| awk -F: "/$1/ { print \$2 }"
+}
+
+configure_ddp() {
+	local mod_param
+	local cap
+
+	mod_param=$1
+	cap=$2
+
+	echo "=== configured with ddp_offload=$mod_param and caps=$cap ==="
+
+	# set ddp_offload module param
+	modprobe -q -r nvme-tcp
+	modprobe -q nvme-tcp ddp_offload="$mod_param"
+
+	# set capabilities
+	netlink_cli --do caps-set --json "{\"ifindex\": $iface_idx, \"wanted\": $cap, \"wanted_mask\": 3}" >> "$FULL" 2>&1
+}
+
+connect_run_disconnect() {
+	local io_size nvme_dev
+
+	# offload stat counters
+	# sockets
+	local beg_sk_add beg_sk_add_fail beg_sk_del
+	local end_sk_add end_sk_add_fail end_sk_del
+	# loss
+	local beg_drop beg_resync
+	local end_drop end_resync
+	# bw stats
+	local beg_off_bytes beg_eth_bytes beg_off_packets beg_eth_packets
+	local end_off_bytes end_eth_bytes end_off_packets end_eth_packets
+	# pdu offload setup/teardown
+	local end_setup beg_setup_fail end_setup_fail end_teardown
+
+	local nb_drop drop_ratio
+	local nb_resync resync_ratio
+
+	io_size=$1
+
+	beg_sk_add=$(ddp_stat rx-nvme-tcp-sk-add)
+	beg_sk_add_fail=$(ddp_stat rx-nvme-tcp-sk-add-fail)
+	beg_sk_del=$(ddp_stat rx-nvme-tcp-sk-del)
+	beg_setup_fail=$(ddp_stat rx-nvme-tcp-setup-fail)
+	beg_drop=$(ddp_stat rx-nvme-tcp-drop)
+	beg_resync=$(ddp_stat rx-nvme-tcp-resync)
+	beg_off_packets=$(ddp_stat rx-nvme-tcp-packets)
+	beg_off_bytes=$(ddp_stat rx-nvme-tcp-bytes)
+	beg_eth_packets=$(eth_stat rx_packets)
+	beg_eth_bytes=$(eth_stat rx_bytes)
+	_nvme_connect_subsys --hdr-digest --data-digest --nr-io-queues 8
+
+	nvme_dev="/dev/$(_find_nvme_ns "${def_subsys_uuid}")"
+
+	local common_args=(
+		--blocksize_range="$io_size"
+		--rw=randrw
+		--numjobs=8
+		--iodepth=128
+		--name=randrw
+		--ioengine=libaio
+		--time_based
+		--runtime="$TIMEOUT"
+		--direct=1
+		--invalidate=1
+		--randrepeat=1
+		--norandommap
+		--filename="$nvme_dev"
+	)
+
+	echo "IO size: $io_size"
+
+	_run_fio "${common_args[@]}"
+	_nvme_disconnect_subsys >> "$FULL" 2>&1
+
+	end_sk_add=$(ddp_stat rx-nvme-tcp-sk-add)
+	end_sk_add_fail=$(ddp_stat rx-nvme-tcp-sk-add-fail)
+	end_sk_del=$(ddp_stat rx-nvme-tcp-sk-del)
+	end_setup=$(ddp_stat rx-nvme-tcp-setup)
+	end_setup_fail=$(ddp_stat rx-nvme-tcp-setup-fail)
+	end_teardown=$(ddp_stat rx-nvme-tcp-teardown)
+	end_drop=$(ddp_stat rx-nvme-tcp-drop)
+	end_resync=$(ddp_stat rx-nvme-tcp-resync)
+	end_off_packets=$(ddp_stat rx-nvme-tcp-packets)
+	end_eth_packets=$(eth_stat rx_packets)
+	end_off_bytes=$(ddp_stat rx-nvme-tcp-bytes)
+	end_eth_bytes=$(eth_stat rx_bytes)
+
+	echo "Offloaded sockets: $((end_sk_add - beg_sk_add))"
+	echo "Failed sockets:    $((end_sk_add_fail - beg_sk_add_fail))"
+	echo "Unoffloaded sockets:   $((end_sk_del - beg_sk_del))"
+	echo "Offload packet leaked: $((end_setup - end_teardown))"
+	echo "Failed packet setup:   $((end_setup_fail - beg_setup_fail))"
+
+	# global var results
+	nb_drop=$(( end_drop - beg_drop ))
+	nb_resync=$(( end_resync - beg_resync ))
+	nb_packets=$(( end_eth_packets - beg_eth_packets ))
+	nb_offload_packets=$(( end_off_packets - beg_off_packets ))
+	nb_bytes=$(( end_eth_bytes - beg_eth_bytes ))
+	nb_offload_bytes=$(( end_off_bytes - beg_off_bytes ))
+
+	offload_packets_ratio=0
+	offload_bytes_ratio=0
+
+	# sanity check and avoid div by zero in ratio calculation
+	if [[ nb_bytes -eq 0 || nb_packets -eq 0 ]]; then
+		echo "No traffic: $nb_bytes bytes, $nb_packets packets"
+		return
+	fi
+
+	offload_packets_ratio=$(( nb_offload_packets*100/nb_packets ))
+	offload_bytes_ratio=$(( nb_offload_bytes*100/nb_bytes ))
+
+	drop_ratio=$(( nb_drop*100/nb_packets ))
+	resync_ratio=$(( nb_resync*100/nb_packets ))
+	[[ drop_ratio -gt 5 ]] && echo "High drop ratio: $drop_ratio %"
+	[[ resync_ratio -gt 5 ]] && echo "High resync ratio: $resync_ratio %"
+}
+
+test() {
+	local starting_ddp
+	local starting_cap
+
+	: "${TIMEOUT:=30}"
+
+	echo "Running ${TEST_NAME}"
+
+	# get iface index
+	iface_idx=$(ip address | awk -F: "/${NVME_IFACE}/ { print \$1; exit; }")
+
+	# check hw supports ddp
+	if [[ $(( $(ddp_caps hw) & 3)) -ne 3 ]]; then
+		SKIP_REASONS+=("${NVME_IFACE} does not support nvme-tcp ddp offload")
+		return
+	fi
+
+	_setup_nvmet
+	_nvmet_target_setup
+
+	starting_ddp="$(cat "/sys/module/nvme_tcp/parameters/ddp_offload")"
+	starting_cap="$(ddp_caps active)"
+
+	# if any of the offload knobs are disabled, no offload should occur
+	# and offloaded packets & bytes should be zero
+
+	configure_ddp N 0
+	connect_run_disconnect 32k-1M
+	echo "Offloaded packets: $nb_offload_packets"
+	echo "Offloaded bytes: $nb_offload_bytes"
+
+	configure_ddp N 3
+	connect_run_disconnect 32k-1M
+	echo "Offloaded packets: $nb_offload_packets"
+	echo "Offloaded bytes: $nb_offload_bytes"
+
+	configure_ddp Y 0
+	connect_run_disconnect 32k-1M
+	echo "Offloaded packets: $nb_offload_packets"
+	echo "Offloaded bytes: $nb_offload_bytes"
+
+	# if everything is enabled, the offload should happen for large IOs only
+	configure_ddp Y 3
+
+	connect_run_disconnect 32k-1M
+	[[ nb_offload_packets -lt 100 ]] && echo "Low offloaded packets: $nb_offload_packets"
+	[[ nb_offload_bytes -lt 32768 ]] && echo "Low offloaded bytes: $nb_offload_bytes"
+	[[ offload_bytes_ratio -lt 90 ]] && echo "Low offloaded bytes ratio: $offload_bytes_ratio %"
+	[[ offload_packets_ratio -lt 95 ]] && echo "Low offloaded packets ratio: $offload_packets_ratio %"
+
+	# small IO should be under the offload threshold, ratio should be zero
+	connect_run_disconnect 4k-16k
+	echo "Offload bytes ratio: $offload_bytes_ratio %"
+	echo "Offload packets ratio: $offload_packets_ratio %"
+
+	_nvmet_target_cleanup
+
+	# restore starting config
+	configure_ddp "$starting_ddp" "$starting_cap" > /dev/null
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/055.out b/tests/nvme/055.out
new file mode 100644
index 0000000..9284a6f
--- /dev/null
+++ b/tests/nvme/055.out
@@ -0,0 +1,44 @@
+Running nvme/055
+=== configured with ddp_offload=N and caps=0 ===
+IO size: 32k-1M
+Offloaded sockets: 0
+Failed sockets:    0
+Unoffloaded sockets:   0
+Offload packet leaked: 0
+Failed packet setup:   0
+Offloaded packets: 0
+Offloaded bytes: 0
+=== configured with ddp_offload=N and caps=3 ===
+IO size: 32k-1M
+Offloaded sockets: 0
+Failed sockets:    0
+Unoffloaded sockets:   0
+Offload packet leaked: 0
+Failed packet setup:   0
+Offloaded packets: 0
+Offloaded bytes: 0
+=== configured with ddp_offload=Y and caps=0 ===
+IO size: 32k-1M
+Offloaded sockets: 0
+Failed sockets:    0
+Unoffloaded sockets:   0
+Offload packet leaked: 0
+Failed packet setup:   0
+Offloaded packets: 0
+Offloaded bytes: 0
+=== configured with ddp_offload=Y and caps=3 ===
+IO size: 32k-1M
+Offloaded sockets: 8
+Failed sockets:    0
+Unoffloaded sockets:   8
+Offload packet leaked: 0
+Failed packet setup:   0
+IO size: 4k-16k
+Offloaded sockets: 8
+Failed sockets:    0
+Unoffloaded sockets:   8
+Offload packet leaked: 0
+Failed packet setup:   0
+Offload bytes ratio: 0 %
+Offload packets ratio: 0 %
+Test complete
diff --git a/tests/nvme/rc b/tests/nvme/rc
index d1a4c01..4a43e43 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -199,6 +199,14 @@ _require_kernel_nvme_target() {
 	return 0
 }
 
+_require_remote_nvme_target() {
+	if [ -z "${nvme_target_control}" ]; then
+		SKIP_REASONS+=("Remote target required but NVME_TARGET_CONTROL is not set")
+		return 1
+	fi
+	return 0
+}
+
 _test_dev_nvme_ctrl() {
 	echo "/dev/char/$(cat "${TEST_DEV_SYSFS}/device/dev")"
 }
-- 
2.34.1

