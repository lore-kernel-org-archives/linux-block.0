Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11022080.outbound.protection.outlook.com [52.101.66.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EB7199E90
	for <linux-block@vger.kernel.org>; Tue, 16 Jul 2024 11:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721130649; cv=fail; b=FR6jHcDyPZPY0bpY21jW/38CZjecM0r/wOYYn3R7RJkzPtRndHxtI4PLF5B/mwgVR19scWxsk/kyBL6lhaqnemTadQqsKg3HofZzmP7JwcFV0rHOZs+wdlQEFI6Y08WzUl5ID0fQFKE1LdWQCt4Oo5+lnNtqq6UcFES1z6XXdzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721130649; c=relaxed/simple;
	bh=MExSA+5ivOmxDqXaVcTB8939OgnUH25YCKq6uVrNwF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=STicThp8OO4LzEmJtf63b/KvhXGQd4zP+RixZrwzoD66jsjrzYgiB0723lWwUATHEgCCJoX9weJBmBBKuKeTylibIG7CwoUM1vZU7TwrYP7MkgYulsR0rPvgIJ6H6J9You2Yq6jrQHZ70+RxEpx5eOG/p7IDyLUmsvbRav4TU1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com; spf=pass smtp.mailfrom=volumez.com; dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b=hMmr+fnN; arc=fail smtp.client-ip=52.101.66.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=volumez.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b="hMmr+fnN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRVO7qfaMXY4sT85qy1E+WaHJYNLC4XyC3lgzjsSz0IFOd8zyD2AFRiEjxi0JwpcSsCeUJMlcM0Iv6gzX7vEu8eCbwelIhfTG8DF2Zidh/i+vStmfXq9SmKCeZyyVb2W+xqTdYZezu2b0dkn6E/IIUXgQIXUeS2Jgy5PPIzsfGjSEC03vrX8p9xnvLrRMXhDC+P7ngaEXxLdhyvqin3HxHK/tt+rAL+asSotaRVsniRqAOY57Wfr6BHCrJc4BIpwc9SCqWwpsmOEdcgPeEqm4BFg7EuVsKrOI4vZNRFJxE1rvgOu87m9gWmVwJR448fukFmoAojsUeT0VluZLGBEew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWB8taQJBp9SZkrE2xzj0WvKQZaxXWwdq670G97JD/A=;
 b=k0p3GmuS4H5+uzA8Ff4wBQzPfQyjAiCnhDwScuyC/CAmvY3aa6i3/jPBJQEJozYHb7IfLlXUjcIHUBJJIQurrs9v5BjAigZuRxJN5pN6es9LL0lqeTgJqTHnQWHhNRQp3+nP7Ew3dTwvm2LU/kaIo55g8GAWujJhcUB19Ddl1OufsODUjbVUQI5s+VSHR9Yfg7C2RGmRe5ZtWG+8A6igdyDIH6VnRovnZeqdbyjwgqX1pObqcWe1NObUPiBLhCp+uo9/WmZE2I5PjOe+XUlvdv+OHKJrkF9zRrxfv9q4XLVJCxnqQ98NQJD977lA7WQfB3fOTJnSlx0h9R/MFukVoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWB8taQJBp9SZkrE2xzj0WvKQZaxXWwdq670G97JD/A=;
 b=hMmr+fnNjWUbQ92g1VkvKs5qkh70h7NbjtxuxxuWneWbhYtiP00WBW/V6/yFuPPmydT8lxrjXM1P9BXT700AuJ5WDiWZ70TN3rUy7H4ST5IH7d6o+OfGEQ9OWFBfhDEwvnILytUkLOdUoQ9OZM8qNAQe/6ey/h/ZK52Vw52lpLHaIYClTYj6+WjcbMuRijPxOkQ9HlJu+dxfefctCGVp2M/nF7Dlco2r8kAfOFzqQQRjqQVB+nTK0oslwxEuS2qZJ7BC1E0PRh0zaBAsrFKHP94Z2wGwcwyd1sp35mDXoEo9K2gBWPDFn3IkQGOygvbweEu6XDQ7L2U33cV8ptsGZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20)
 by PA4PR04MB7775.eurprd04.prod.outlook.com (2603:10a6:102:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 11:50:40 +0000
Received: from AS8PR04MB8344.eurprd04.prod.outlook.com
 ([fe80::d3e7:36d9:18b3:3bc7]) by AS8PR04MB8344.eurprd04.prod.outlook.com
 ([fe80::d3e7:36d9:18b3:3bc7%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 11:50:39 +0000
From: Ofir Gal <ofir.gal@volumez.com>
To: shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	chaitanyak@nvidia.com
Subject: [PATCH blktests v3 2/2] md: add regression test for "md/md-bitmap: fix writing non bitmap pages"
Date: Tue, 16 Jul 2024 14:50:24 +0300
Message-ID: <20240716115026.1783969-3-ofir.gal@volumez.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240716115026.1783969-1-ofir.gal@volumez.com>
References: <20240716115026.1783969-1-ofir.gal@volumez.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0024.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::8)
 To AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8344:EE_|PA4PR04MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b67fbb9-54a5-4286-d583-08dca58d839f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v0bzL4dqLR7Calg6+y4se0sy587SSTQ7N/tXQL0lOki2ZSH6J3PeWN6OeiLz?=
 =?us-ascii?Q?YKP/qr/HyRa5rIgNx5r85AZG1utEXZ3O40Ae2lLs/sr05LVPIPp56BA0GJG8?=
 =?us-ascii?Q?Bq/2DO+5ZENRiloagvzBJysWCNJv/i94OkdB72D7uEAbEssyjcc56D9d+icm?=
 =?us-ascii?Q?9yDKT+E4jeGHzkCVGlKFiVaIFafIvT/3LiIZISkUXi9r0IUsoE7LGVaNZuKJ?=
 =?us-ascii?Q?jix1ZSiXmCXlho6V9Nqte0eHs0vh+KgWCeOOIg5pwzpxG088NVZyqu67lQnr?=
 =?us-ascii?Q?TIaffHoktqnxtQf0ax5ONeWM/Xh0aDBk1ask1EGc0RFtpTT1kSCbjwinHctc?=
 =?us-ascii?Q?4wRiox6fpkKxQkdyMkKQcy8V+lKEOSi0hK7RIJOoVepJd3YfCRJZBNy8hk6J?=
 =?us-ascii?Q?PlEAqyvZPzHCdPLP6J7SThjCjqVSsiKfUxugV+Wt3sedW5X55vV48n+KGILQ?=
 =?us-ascii?Q?a8uxPdS5Fa4k1ZS+ZfCnpjw4Z/Y/MjGkwWzQ1JIO7akCYkel+lWIW789bs+J?=
 =?us-ascii?Q?JwcM7gs8/1cruZwqjDrR4mIQlgtka5MvgQFpviYPaF8bhaqUzh0Ylr5A+Ljt?=
 =?us-ascii?Q?VfdOVzWsVa0n4SI0cS2k+Pcl+OxF7PSOobzogeKro696KiKsD1A9DztNbixT?=
 =?us-ascii?Q?nQEH3P7vILdXm8VyvrwU/FlRgdoxcOye/Ie+qt1XD7wMfL6ogORfWtyOUYQ4?=
 =?us-ascii?Q?8/XtnXzF0j1/duqxMMZF4EN1hMLBBGPfxz7aZLZSfrGHyXhth6+9IyZU4jqL?=
 =?us-ascii?Q?smqpZt6UOI83as7SxAIlotslCgAx8hYQmIUesOHxGoc8X3s9w6vCtaN9VKU3?=
 =?us-ascii?Q?IJHnBclYB4HMVENa6lWYH+RyPWWIbbVQuqgm9CWoRzq5Sxg5kEcyh5PNMF77?=
 =?us-ascii?Q?bj5NokPVNYXueqv16Mksbm4THTXL8vQIeENdNADwQnEvNTbAtpCCAKPWX3y9?=
 =?us-ascii?Q?Ia5zlhnDgvPEBNaGNKAUJA5/uTK8NMqQ1t4Z0ZqKDOkiYj2HQvtlWiQzTIyx?=
 =?us-ascii?Q?zNJxe+ZiZ68Zg7iQnr8IMn6UmO+4KEyhq4yjv2QUeK5OmJDklIwFka0wv+4Z?=
 =?us-ascii?Q?YRABXYRhbwN/8yDY3enUu4UjqcwvGmIsWL6R1w0fF9ZHHc9HVvBZTvyMki63?=
 =?us-ascii?Q?yUE25LQi1nQHlx3RvsADTHhl6BfP48yAvxanT1+DGBeWT96ck7bx5p9Gi6NQ?=
 =?us-ascii?Q?N2uY0DW5chj6JU5y72VfKG653TKnAeR13gG/wXURnoxl3jC9GV2Id5LXzS62?=
 =?us-ascii?Q?E/3MP3Fc3yprNh1gy9mqpHaNk1VonffdL5WO1VXujnUSomcPylj1ZIIIlyMC?=
 =?us-ascii?Q?YP+vJfikfcm0PAoBLVDXilSiFXYpuX74jO8Q+cQyFceHZuO8KTBTVn3vEeul?=
 =?us-ascii?Q?lbXiHKL/hol5JsEsccVucam2qgvoSr/xB1uDXd7dEJatBhykiw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W6HrXGTUoE3FLSO2/3X/TtNEoNoPbtFgIoN3SsZ9r+ZvcxIC1nSqms257THd?=
 =?us-ascii?Q?4amAST4mbkFBIIQA1bUBe8+zj4CwOeiaWWmGD0lqJsfbOXMxqjMg/rCfzitK?=
 =?us-ascii?Q?/GvEsViIHjkD7BIG3RBuCxuCFCGXtqu+jSufAQ+CQJwhyp0pF4qAAce19tNS?=
 =?us-ascii?Q?QaMK1sXH7vyx+2+AEhd3kaKIw6UPmvPj/kvO4uJWk7AqxAIK+DqkElY+NuNJ?=
 =?us-ascii?Q?CeuKPDYCvK1LcCMBTvbvON+6so3t11GYFxjJl1ewYbFLjuQayb7kMD9rGMYl?=
 =?us-ascii?Q?mWyd/wmpI86opYmCFKaTJ6poVvFddoJHWaJ8R7YqLzLpTHGwTmSQNuLqsiCl?=
 =?us-ascii?Q?/zEdvXiv5TN1iwRf1udrRqMhK7DyzqTvEKD8IOWEKKkRcG4V9lAmhhDPYOvj?=
 =?us-ascii?Q?51ETuspZ67qz9OQuh8emzN3zxmLHxZ48i1688nPvnsMtuVUVERrcZMkncy1j?=
 =?us-ascii?Q?Hu3+BtlQwTL4T+v6E/BhKZ8HCyVd4kzo1X07iLCcuScbn9YVfsCA+PkVdk7w?=
 =?us-ascii?Q?8I0z4VD2nyxrEmmPiS89mA5KewJto3QUMar8kc+4pCaRGk6Tvwmpz8ytlud9?=
 =?us-ascii?Q?VRmvrWjlyJEZvRfV8pKAegZXVRgaG89T5JQrjBYrLySNuTEDWqBt5xRv3BNX?=
 =?us-ascii?Q?HKzTKlbW0g4PCwMMeYJ1UNwoKSPG6WjabUuNxtkUJ3GmODL3MZA/rUOX++4T?=
 =?us-ascii?Q?eDxLQsdqRcz10PQnG6VffJzhLN3wyqYw4jdYudetThJb36BNE8QCV/apZxwZ?=
 =?us-ascii?Q?zM6agBSJ7Tq4pNcC7MkzER5cZTBu9lXGjgQuF7R6hlPRehVov+KOj1UfU0YS?=
 =?us-ascii?Q?d7WCe2q84Ewq/Ldq9KhCorPDVfnCDR3leb1PZhJRMWx7fBv681BmlInNTWPm?=
 =?us-ascii?Q?h92oUWk/y3f0VRlD0zRgvIjESVAB2+f9FYUTcdvo6l3axDdcsiv/aORQevlu?=
 =?us-ascii?Q?ICHa90LXZk3CWNdlHGauvzk66Xx/qpL1TuKuIZwyiC7XfC/KbdQUGcbc3Tc7?=
 =?us-ascii?Q?xlFZV6W6oP5tZPI2JxH5d8QRG0d8Qg+EzrKhddFYOEnHdssaZoQaEhoe/COq?=
 =?us-ascii?Q?e2vVi6zkvBiE21GOyXJaidoLzcoXFfbiQblLDfW8WwlVWbtt8L+cBKZ8bZSn?=
 =?us-ascii?Q?7oZfXK4DM5oy7al7kpqaynM+Mmhd8ikmj24kYSVfhSP/qouGsazQZcyssbI3?=
 =?us-ascii?Q?Ofsmujak/9nyaUn9tyvL3Pmpl0dSQK1BhqVn2GF0mI7OJwpJ+8mXBbGldb9Z?=
 =?us-ascii?Q?Tlz9e2Gs9CLdwOzdNBsPJucFDFh2MflGENHcDzRRGujgOn3foedaajOUk15i?=
 =?us-ascii?Q?y/RbBhuK1UNzwVgqvGe+WRRSkLc2vSBG0GFNhglHWQBgF011aZbbQIUv0r7m?=
 =?us-ascii?Q?74Vy7xSHOw+TZV7/0aaZypGIqj0ZJiYh81Hzxg/eX/0/bKSQ5UF9vdwsY5oZ?=
 =?us-ascii?Q?9QDDitC641L/lPL7Ay5DlbbUiBXGvkySl/M8INNr4g4erywCOYYWNwqT98KB?=
 =?us-ascii?Q?UDlsrH2UekmjlAAlhUskx57GcT+Y1gC/Cp/KC6xi2IXQeIrgC8nPK4CvZ8+n?=
 =?us-ascii?Q?dWidFIc3a7BEuEnIwd8+DJ7Pj7qz7Q/xvKRrV4du?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b67fbb9-54a5-4286-d583-08dca58d839f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 11:50:39.8634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmgaZJ+FaH4TXIG8cAx4TaRzy43/G5MDVRFBX/YKuy0KI/KAVEgt4c56XgzHBE84bsgkKgykADX1B1I7ssm5lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7775

A bug in md-bitmap has been discovered by setting up a md raid on top of
nvme-tcp devices that has optimal io size larger than the allocated
bitmap.

The following test reproduce the bug by setting up a md-raid on top of
nvme-tcp device over ram device that sets the optimal io size by using
dm-stripe.

Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
---
 common/brd       | 28 ++++++++++++++++
 tests/md/001     | 85 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/md/001.out |  3 ++
 tests/md/rc      | 12 +++++++
 4 files changed, 128 insertions(+)
 create mode 100644 common/brd
 create mode 100755 tests/md/001
 create mode 100644 tests/md/001.out
 create mode 100644 tests/md/rc

diff --git a/common/brd b/common/brd
new file mode 100644
index 0000000..31e964f
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
+	_have_module brd
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
index 0000000..e9578e8
--- /dev/null
+++ b/tests/md/001
@@ -0,0 +1,85 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Ofir Gal
+#
+# The bug is "visible" only when the underlying device of the raid is a network
+# block device that utilize MSG_SPLICE_PAGES. nvme-tcp is used as the network device.
+#
+# Regression test for patch "md/md-bitmap: fix writing non bitmap pages" and
+# for patch "nvme-tcp: use sendpages_ok() instead of sendpage_ok()"
+
+. tests/md/rc
+. common/brd
+. common/nvme
+
+DESCRIPTION="Raid with bitmap on tcp nvmet with opt-io-size over bitmap size"
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
+	_create_nvmet_subsystem "${def_subsysnqn}" "/dev/mapper/ram0_big_optio" "${def_subsys_uuid}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+
+	_nvme_connect_subsys
+}
+
+cleanup_nvme_over_tcp() {
+	_nvme_disconnect_subsys
+	_nvmet_target_cleanup --subsysnqn "${def_subsysnqn}"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	setup_underlying_device
+	setup_nvme_over_tcp
+
+	local ns
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+
+	# Hangs here without the fix
+	mdadm --quiet --create /dev/md/blktests_md --level=1 --bitmap=internal \
+		--bitmap-chunk=1024K --assume-clean --run --raid-devices=2 \
+		/dev/"${ns}" missing
+
+	mdadm --quiet --stop /dev/md/blktests_md
+	cleanup_nvme_over_tcp
+	cleanup_underlying_device
+
+	echo "Test complete"
+}
diff --git a/tests/md/001.out b/tests/md/001.out
new file mode 100644
index 0000000..23071ec
--- /dev/null
+++ b/tests/md/001.out
@@ -0,0 +1,3 @@
+Running md/001
+disconnected 1 controller(s)
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

