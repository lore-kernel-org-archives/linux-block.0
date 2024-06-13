Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2103.outbound.protection.outlook.com [40.107.14.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DA8818
	for <linux-block@vger.kernel.org>; Thu, 13 Jun 2024 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281835; cv=fail; b=TsAX7h4Jg4kqASPaDfYN4k0qO6dmjB196gBboI1S9qPz49yNmEsIMQk8xM+kWowvnW0QwTTwbROtMSLz/2Xr1YUsd9H9gNPsimxgk8BcfbauY/swSlrkx1brwECEupOB1TXZxXoyIdaS81sT96mfpv5clWVgY+rc48sF+BUX/Dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281835; c=relaxed/simple;
	bh=rnQqasbNE/bGbHcEGB2UlLlL1hjq4PdgGLR/cN94gT0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WKJ/+UzJkhIWC4teLDZok3SpTaQUFijSqw76YnVllfcPjtj85Jzzk3d3SoY40AC2k22Mik0as0K74/yhwN971z54SnJBGPJAz1a5/gpwr3+NRKUE0/n8EC1i+yKW5W2cGQvFL3tH5kppwdKyH0p9X8i4Nx3lEvXCV06oRjMLrfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com; spf=pass smtp.mailfrom=volumez.com; dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b=kSX/wkoS; arc=fail smtp.client-ip=40.107.14.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=volumez.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b="kSX/wkoS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXl12bGWs9g/J/A5jftg+thyR1OfOA4c8R+WGv9S+JjuWCEMrXDCFwRTMshGO5km5ffTEMutlQ5jx3DNcGMvw3J/uM5IfpyOWLc5887G97cefNGDIkQPXDkNnC1uWA0RndyeTaOAn3W1/n94fwNmTCiP/7CgfCSEO0o3AEa99jtfVdsKQ9ISPXdUqWDfT8ahVqHWJ4GXF3B0qkKAiKVtgLY+r1HsP1GR6IKHqn5vrRRqYEcPS1sBjlCsAsJKnNPhSPGTq2t1HH4PTAJnD43ZJ+BHYK7JVljol4CHrsGQYRRVFtkzQohi0q0YxrEu0WUGa07fNVZxy6Oxqy+OPnlbVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSsi+/JU7v2MW9eiBNM1Iio+OSHzWiCJYu6wnn5LIKM=;
 b=QHbyiZcYZzERU5yHlaLbnt2C4tafwOMSnjNKKwCZRWLT9EwK7C9/HJLvwG5/XozUM7UAdRquztniM9039yYTblJLj2MsP9SuHf7oU15dVSNLbwwgsTa+D7q1XXIMyXFwNx5eL+lYJskcFC2sJGiTId/qEwYPDDrGqSo7MTE4Gl1BbxWIdXxBITzDvrRbTelWxjZEBXpR+CqlG+FQ8veKsPiE6Du+X2z5YuUg4hWnwrNHlrMzUW3E4Z/3mc8TfbMzz4NQY9tFCRY4pxTNnv6zkiGGWi4MPtO0lm9gL4cUQ/Fw+cDbFDn9pHqdh/SN+1mSiTL35ZTcue3rgXfw39hA1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSsi+/JU7v2MW9eiBNM1Iio+OSHzWiCJYu6wnn5LIKM=;
 b=kSX/wkoSaL3hWlec1PDufUgOa0GUievf7gO4w+6Q1zang2wisAVTmsfNdEbziPQx410wInmYeLu3dNR78hfBARpP7em5bXQCvtn7Dp8EwIVI7E6lDEfTqiHRCkukfw7gLytxJYmQpkqaBvFDP4ClXNVU+0StWPUfgV4ctExbzKYHMPJ4TezWaijJxGgEiXTjY2+pQkTbX/PvxHTyhhSObdWshSDI5PHh4yovKF5Q4NospVIWeCupyFuq2WKZmUWhLnC1fPITzbdWyJFpce19/YY4YtA9264dm0PPTybA7jB+bjomXxkYCJfG8VWXHuueRQ4j5reZpMzhJ/CTrXIflA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from AM0PR04MB5107.eurprd04.prod.outlook.com (2603:10a6:208:cb::11)
 by AM9PR04MB8620.eurprd04.prod.outlook.com (2603:10a6:20b:43b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 12:30:30 +0000
Received: from AM0PR04MB5107.eurprd04.prod.outlook.com
 ([fe80::de53:c058:7ef:21fb]) by AM0PR04MB5107.eurprd04.prod.outlook.com
 ([fe80::de53:c058:7ef:21fb%5]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 12:30:30 +0000
From: Ofir Gal <ofir.gal@volumez.com>
To: shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH blktests] md: add regression test for "md/md-bitmap: fix writing non bitmap pages"
Date: Thu, 13 Jun 2024 15:30:17 +0300
Message-ID: <20240613123019.3983399-1-ofir.gal@volumez.com>
X-Mailer: git-send-email 2.45.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To AM0PR04MB5107.eurprd04.prod.outlook.com
 (2603:10a6:208:cb::11)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5107:EE_|AM9PR04MB8620:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a843ddd-fa79-4e67-c944-08dc8ba49c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|366011|376009|52116009|1800799019|38350700009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eEOzWepagR5JBADBI6wB5VO1PUqS1xcbetxfIN0wnxtfnhaxtBhuDi+We7f6?=
 =?us-ascii?Q?lQ8rnKJAtaJI/mW/UJ8nOFPxRxVPo+wM5QxIOcBEmnLGtKc/ShAR/L2/A6Un?=
 =?us-ascii?Q?fACdga/zb61ir8IgwZBzKNKNAsvjZtlmjnSHjXgeMwobxbhwcnfOS+XNGndA?=
 =?us-ascii?Q?ip1Q/c4DSwf1zO8A2pPCk6+oDgNysOh+xHj8mbXhtjQZyhXlpFyAE6OW/oU/?=
 =?us-ascii?Q?aN8XIsmSbWHUqqvTlp+6DmfE8t/1mTPI7x5cl9ODdW9HfGFbRX5TwlbY3pJ1?=
 =?us-ascii?Q?QEudsIR8PfUqG3dietLYxE8u7tl5cBIxiSz4orGHC+w7QWObW2wKShhA6Bt/?=
 =?us-ascii?Q?ckGnE/crKNUQ2GcgKdS8Az79BoGN5IWPiEoNX3Ut3vlt/zthSPhi5R6drjQH?=
 =?us-ascii?Q?al3MdGkAF/hpJNOMW8Qwj6oq44FqpcKBuyF7TaOVCrydNFnqhLSm1Y30qmZD?=
 =?us-ascii?Q?nlHif+S07SbastBHU7tIIIb28ALsDKbF7DnDCGjXUBnPZbtrYZh2Sagd2GFj?=
 =?us-ascii?Q?NNkftUURgeM3TEAIhFNRdT5AUrpewcY/kVabGQFIBrDWabCulWNob3TI9phN?=
 =?us-ascii?Q?dGUYnoBYvqkRx3WBnX5CyJY3hqwAmVL1QqqksP5PvK190L1o9gskykmeG5V3?=
 =?us-ascii?Q?kymcvD8akuMtmtpzTWBc5tX2prHVA0O03LcGG/vovJiKL/RygsUxLaPoHRw7?=
 =?us-ascii?Q?Hf6yeQXCyU+bpGbUl0NzNsHu+6ObX/70YOF49vXvnEU/4Jq7ZNV+dwZCWi3X?=
 =?us-ascii?Q?boREx/4qqb+CMCrQGxCoXJsmzyWbYEYmAZYu4u6o/kUHu5yUNog6ZShZ1Zh3?=
 =?us-ascii?Q?te8raho+qBzLkM8wq0FHYGstmejmq+9BCL2x6DRvk7F0Ibqn0S8Cq3YS/029?=
 =?us-ascii?Q?l0/aYvtH8IdTFomYVfsa1mcBtjFyAUqgH0T6oluw82qFNcB9Jz1bQj+UnseO?=
 =?us-ascii?Q?o9ujE5nFfrXe0Vo6+qhpZXqAuI2lelM0FXYwMQ5F3J0hGwYsWpbK5MHwHBKH?=
 =?us-ascii?Q?98Q9nqQehAbqzSJxZMuYnuHE5np1c2jMiy8A6MxkrutXTWp+KTwwqsk12rhZ?=
 =?us-ascii?Q?5zmCqp8baqGZmu3/QMROZWpC8Ddfh173YEORI5IsAzkXW3o2Dov7WQfSkQph?=
 =?us-ascii?Q?w60QyV+RjFDNbHBE9groEeWiWIkBhCON72Ti4wLM8mjZUMe89K0KpdM3kISp?=
 =?us-ascii?Q?ht8WdsVBbjoSPnbpw6rshFglmGaAB1NxJl4xvyDjB0KEYkchgdDurLCw8Byf?=
 =?us-ascii?Q?dC9YVNgWyqxuPHHckHYo0INh8QsHXbR76IkTTo09Ro8ztF7au9JDTcb2F2OW?=
 =?us-ascii?Q?hWFupN3H7ygI3FfQLyetBNzhsrb3p3+VFOCjL0pIQh5jN75+hFAp/cwspGHC?=
 =?us-ascii?Q?fzdX8NU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(366011)(376009)(52116009)(1800799019)(38350700009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RWu+k1lbQ6mDjyc5uzfApbvH2/W7ispErX7tAhf0699ZY+DdL/yi3di5W+3R?=
 =?us-ascii?Q?IJTl0dgCOdDkljZoLF5KeI6Q5TLO0049Y51DcvHBekNfinvk7oK3/1ZQs2N8?=
 =?us-ascii?Q?wZjLd0OO3mx1Q1MucNFlSX9O+3nPM5EKkvYTcOD/d1c37FadpJoIq0K7GmY5?=
 =?us-ascii?Q?rCWHhO1STnGa4VozxeOWLA4sc/D/63c1MnKknMQOGG7Kx9AT5t6CyWjFnLRu?=
 =?us-ascii?Q?y92pro65d7RDdwIRGYb2W3arJfHgHONhyHftrQc4nTVex9uh24mWp6ul8sgL?=
 =?us-ascii?Q?P0vEgmOcG00QHDWZ4GXWw7gBnG1sEU6x5ZPm/CPEd0o1THeKSPzWSKhm9DxD?=
 =?us-ascii?Q?uRunGzj9iKOnBEfG6rjMkNnVG++DCFAEl+HD16sJIwb/R4cro/sNrWYEODA5?=
 =?us-ascii?Q?TyflPf2H/N0A2Zf5Qw7eyK+k/1X2oJS+/JUe8SxmHme5/GD/PI/jkWq7W5Yp?=
 =?us-ascii?Q?nTXVFyFYXuXA4xEE67wQ2ex/xLMPYGkhuQQ9gb9TDDAeT24R3CY7htSNrLya?=
 =?us-ascii?Q?W02FZ2UG4xcfRGbyonSl/eo93Xwb+8VqjRHfRmontqN7LTkK+TsxJpCuUC/x?=
 =?us-ascii?Q?KTf/mLugU/po7kauWuanEAFnbOj0huV7spk1ZDsZZ/dM69qf9ghbTTBbnDqN?=
 =?us-ascii?Q?kMFGs4JtNnC7Tpdi0Zc06QaJUARx78ZEvHL486V9/ai8zygQ/D7wVUDjrL6C?=
 =?us-ascii?Q?wrbcnUzPXecnLqpmGRhlzH6Zi3Llv14a23ecFDMjuyKSWA4TUKOVC1o1kxei?=
 =?us-ascii?Q?rcNcrD0DiCh4Rm+wKd7ub6LM1gMJjQb1civTWm5dHUUuIwUZsLbrc/2BEKnm?=
 =?us-ascii?Q?ZcFOD1D/eHDfEE67wK4/2swVNGjyrUEBNe2cAtno1PP+M4LKw11EBm/ZmqJE?=
 =?us-ascii?Q?dD8itNqbauHAtAnK2e1nUIummQF13Ux+k0ybMqXiRPDHuvPWlpsGRGMga1XP?=
 =?us-ascii?Q?SZtpImX+gXAacXcMLBAWJ6OpltwXrKhB5QKdXdFZ9M9FIsleyrR8t0ul/VKa?=
 =?us-ascii?Q?8YjFsXT+9iaSmOE6AhuNCJSpSRBPrMnK0ICTVaDIkw/m417/E4+f/GoqoIx4?=
 =?us-ascii?Q?2bhRmdfP5tf8zSYYK9LJgcnMXs9ye7UFpDG27+4kzmj3XmrNIWz133N6P3wB?=
 =?us-ascii?Q?qIx3iWLWRdLTjzUjQMsiquYsz+nD1tfyCjIWSk6TLSVRs5rM7evehn0ohK1w?=
 =?us-ascii?Q?5VvSVLz/pOdnyk2lxC4Q0mL3IWw51pWKZfpdlXG4DwH0H7bbEJ6V0XJK349n?=
 =?us-ascii?Q?Mo2Dfr9OW4Xuld88TXr52IIrwhszOGweWa8e/+YaPoYjH6KnMDXo/bE9r0CG?=
 =?us-ascii?Q?jLDI4PFDN4KDwNBgtT1OOgScukyj47Ss1UHD4n8Zbe7N9pjTNwGP+VCcX0MR?=
 =?us-ascii?Q?ZOUvVg0p+DFmutx+I6ywAx2u0QJ6lc7qLBacENfazjdvOdQi4uxIcm+TBeX6?=
 =?us-ascii?Q?zjyxuMaetLRdgwvUTFuVG7/wqE2VLhsaRr5FKoEoa/L5CkhrXZMEfoCKGEQV?=
 =?us-ascii?Q?OS1GhyA++7FrfN0oJoEj2G0oefPZqnfy/px097NRWLcfJKmcMbGeZgCjNdzz?=
 =?us-ascii?Q?rQGgHm3AQCCBznDWzdt/erylr0b53LqBM0ddVxAC?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a843ddd-fa79-4e67-c944-08dc8ba49c9c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 12:30:30.0050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDhjXJ+FWW6FTMU5LnYt6fXbsPizv+qTIY1uBk4QAMNe6GtdV13bVTYBN9K/cc6L5kGP1v6MqHx0jpYecH+uGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8620

A bug in md-bitmap has been discovered by setting up a md raid on top of
nvme-tcp devices that has optimal io size larger than the allocated
bitmap.

The following test reproduce the bug by setting up a md-raid on top of
nvme-tcp device over ram device that sets the optimal io size by using
dm-stripe.

Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
---
This is my first contribution to blktests. The tests hangs when being
ran on a kernel without the bugfix. Should we wait for the bugfix to be
merged to upstream before merging the test?

 common/brd       | 28 +++++++++++++++++
 tests/md/001     | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/md/001.out |  2 ++
 tests/md/rc      | 12 ++++++++
 4 files changed, 122 insertions(+)
 create mode 100644 common/brd
 create mode 100755 tests/md/001
 create mode 100644 tests/md/001.out
 create mode 100644 tests/md/rc

diff --git a/common/brd b/common/brd
new file mode 100644
index 0000000..b8cd4e3
--- /dev/null
+++ b/common/brd
@@ -0,0 +1,28 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Ofir Gal
+#
+# brd helper functions
+
+. common/shellcheck
+
+_have_brd() {
+	_have_driver brd
+}
+
+_init_brd() {
+	# _have_brd loads brd, we need to wait a bit for brd to be not in use in
+	# order to reload it
+	sleep 0.2
+
+	if ! modprobe -r brd || ! modprobe brd "$@" ; then
+		echo "failed to reload brd with args: $*"
+		return 1
+	fi
+
+	return 0
+}
+
+_cleanup_brd() {
+	modprobe -r brd
+}
diff --git a/tests/md/001 b/tests/md/001
new file mode 100755
index 0000000..d5fb755
--- /dev/null
+++ b/tests/md/001
@@ -0,0 +1,80 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Ofir Gal
+#
+# Regression test for patch "md/md-bitmap: fix writing non bitmap pages" and
+# for patch "nvme-tcp: use sendpages_ok() instead of sendpage_ok()"
+
+. tests/md/rc
+. tests/nvme/rc
+. common/brd
+
+DESCRIPTION="Create a raid with bitmap on top of nvme device with
+optimal-io-size over bitmap size"
+QUICK=1
+
+#restrict test to nvme-tcp only
+nvme_trtype=tcp
+nvmet_blkdev_type="device"
+
+requires() {
+	# Require dm-stripe
+	_have_program dmsetup
+	_have_driver dm-mod
+
+	_require_nvme_trtype tcp
+	_have_brd
+}
+
+# Sets up a brd device of 1G with optimal-io-size of 256K
+setup_underlying_device() {
+	if ! _init_brd rd_size=1048576 rd_nr=1; then
+		return 1
+	fi
+
+	dmsetup create ram0_big_optio --table \
+		"0 $(blockdev --getsz /dev/ram0) striped 1 512 /dev/ram0 0"
+}
+
+cleanup_underlying_device() {
+	dmsetup remove ram0_big_optio
+	_cleanup_brd
+}
+
+# Sets up a local host nvme over tcp
+setup_nvme_over_tcp() {
+	_setup_nvmet
+
+	local port
+	port="$(_create_nvmet_port "${nvme_trtype}")"
+
+	_create_nvmet_subsystem "blktests-subsystem-0" "/dev/mapper/ram0_big_optio"
+	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-0"
+
+	_create_nvmet_host "blktests-subsystem-0" "${def_hostnqn}"
+
+	_nvme_connect_subsys --subsysnqn "blktests-subsystem-0"
+	nvmedev=$(_find_nvme_dev "blktests-subsystem-0")
+}
+
+cleanup_nvme_over_tcp() {
+	_nvmet_target_cleanup --subsysnqn "blktests-subsystem-0"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	setup_underlying_device
+	setup_nvme_over_tcp
+
+	# Hangs here without the fix
+	mdadm -q --create /dev/md/blktests_md --level=1 --bitmap=internal \
+		--bitmap-chunk=1024K --assume-clean --run --raid-devices=2 \
+		/dev/"${nvmedev}"n1 missing
+
+	mdadm -q --stop /dev/md/blktests_md
+	cleanup_nvme_over_tcp
+	cleanup_underlying_device
+
+	echo "Test complete"
+}
diff --git a/tests/md/001.out b/tests/md/001.out
new file mode 100644
index 0000000..edd2ced
--- /dev/null
+++ b/tests/md/001.out
@@ -0,0 +1,2 @@
+Running md/001
+Test complete
diff --git a/tests/md/rc b/tests/md/rc
new file mode 100644
index 0000000..d492579
--- /dev/null
+++ b/tests/md/rc
@@ -0,0 +1,12 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Ofir Gal
+#
+# Tests for md raid
+
+. common/rc
+
+group_requires() {
+	_have_root
+	_have_program mdadm
+}
-- 
2.45.1

