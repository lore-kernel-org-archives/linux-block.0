Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2127.outbound.protection.outlook.com [40.107.6.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C515745E2
	for <linux-block@vger.kernel.org>; Mon, 24 Jun 2024 10:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719225999; cv=fail; b=mOSdOEWzRdzmsCbs+FpHVHafC5cPAsWntYO5fNGCy972uMS1AFOzWTRApUImle3+QkSI/1juqv3/M3YlL70XfhbBemhrNKyJnjwCdP/iqr1oyMWf96mibVOai2awnYplnFx4qJ863IQQ5TzO9O+dU/PyVqTd8c7OuUy31RrHQAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719225999; c=relaxed/simple;
	bh=Br5X5+pEtIvSpkR1ui+7/Yf6M4PvpaIiLZBpl0ZXdIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u4nYYI2V452R4J1NqlnfXR+LhXgACfzX+yylVUuxAgKeHqCfWnckDarjl3GQxcrvWT7hZp4X03atWhP4+LxsVRAp9L5SL3Aj3vDuITconNmduVOJVO19gX/81V9fnkoeXXQG4YLddWJvja3XL6pJVVh4DvjWb5aiErpdA1HUvOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com; spf=pass smtp.mailfrom=volumez.com; dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b=edCyfTcw; arc=fail smtp.client-ip=40.107.6.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=volumez.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b="edCyfTcw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LURbJG0dsgrjfI606pR7cu71d69x29USyUZt14EuHTuaKluwS4ULFQW6KO4nqjnlytIRC0mP0HIgpOGSq0xisyHgKvy640JRQ1q+9n9O4K4ZmJXLIDWdoZvAr/eCfJ3udyNZi2H57JaYLe/aXU9IiV1D9pc2hBHVfRaJm71LI2mVfsgHDrN50ULwCXXvQ+GimQqg6CHuqOcpJobCyHV16lJAp3jlb/kOhd+p7MAZTAkCGXzWPicmfn1ZgiFNKg8wJXwYAGCrYDsgsj2sEBOby/F0g7scY9GUrnxLzNg4vv/fLaWzXNwjRViDHjnnx7LU7+sWqW7DjtrkEsbWRiA+DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAUpzR3xhXiC96ZulCHUBTlwCdEfpHwURpgP4zn4bq0=;
 b=Sc5MXrxRKwXnedca8t/arCc/522osk8eRrQYELnZYQHLT9j7XjkdJe+3n9e5OfNagiyuubh1Rh6XROvmowzXRf6/Twe+Oyj7W6AfWy8ST/frxNSEX7sMy2aNDqzpDP3pZf5takd6U7A5z/FQf+arzhAJ720TXllpGqdPhbPmzcj1ZKmfcZhzG/ZyB/HZOQPaWBqY6Qn1VpV/AlBqivpLQSac7wmqdiTcvf3nFgfPmaI5bEuRVr2NpbsUhT7cAh/iLWZElIIccFaYjh3ZU6/GkIXTWdZrWTdb5aI7XRqefvDmoXtW4+xiz2VlAAPForOpYL3h+l7Q6cLJ6eI7xow2qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAUpzR3xhXiC96ZulCHUBTlwCdEfpHwURpgP4zn4bq0=;
 b=edCyfTcwSR18KIdfQuoqccA8ybXG/u027Q7PW4AtBq13/wfnMJEdRuwryPe/1+ToQcfMyTi3gZwMFKO2vDtnb0ODZHBW6i8t4qfbPl1tZpwIg39bZcO+fATtRJvw6i/CdK0gW5SknBhKUEnMBAZ9LseLn9f+F30DkPZv9MwbqgSxuBlj70JG6IaGVy5w5Kv+g6WRV740Pxvw14JZiFPKbs2cFreQIHROWctcNeFGvPesb6BzpXaTZvD4NcmKYQU84faFio6Ge5CK3Dqhi+5ZcRC6GLve6SdFbNFVs/+gMByaT97JfBcsHypA1FT+cp9xRDeqID+UdEza2I/bXm4Ubw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from AM0PR04MB5107.eurprd04.prod.outlook.com (2603:10a6:208:cb::11)
 by AS8PR04MB7605.eurprd04.prod.outlook.com (2603:10a6:20b:292::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 10:46:32 +0000
Received: from AM0PR04MB5107.eurprd04.prod.outlook.com
 ([fe80::de53:c058:7ef:21fb]) by AM0PR04MB5107.eurprd04.prod.outlook.com
 ([fe80::de53:c058:7ef:21fb%4]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 10:46:32 +0000
From: Ofir Gal <ofir.gal@volumez.com>
To: shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	chaitanyak@nvidia.com
Subject: [PATCH blktests v2 2/2] md: add regression test for "md/md-bitmap: fix writing non bitmap pages"
Date: Mon, 24 Jun 2024 13:46:18 +0300
Message-ID: <20240624104620.2156041-3-ofir.gal@volumez.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240624104620.2156041-1-ofir.gal@volumez.com>
References: <20240624104620.2156041-1-ofir.gal@volumez.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::20) To AM0PR04MB5107.eurprd04.prod.outlook.com
 (2603:10a6:208:cb::11)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5107:EE_|AS8PR04MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb68bc5-e129-49a6-cecf-08dc943ae93d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021|52116011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+b2MBp+qMoe1moZIIzF2JUsdWXp176FkkSUPKgUPW5ZXCbhhcy3iCp8g+b8D?=
 =?us-ascii?Q?73XzGaIOI0e7Ip4XrHi+xU1gkKhAs9hRYSBm4AhamByKgAILdBuZ2y3SeLdl?=
 =?us-ascii?Q?6BioTcqomKK2qiuACBYIAGXyJYbkKSdGuyVk27bXffuM8wKgjAb5UlvPeJ8H?=
 =?us-ascii?Q?TeNFtQTTOWfm90roTzFMM/wJBNMpGVvf4FNand3TZQPACHXqcdnsqoHGj6ON?=
 =?us-ascii?Q?cmLC6zEPeLYSqY1bfwuqi1UUNTLYmdvAEUfwBJcg3o/nZKrDvpT44jzzl6Yj?=
 =?us-ascii?Q?CUwbs8YNofLuC3NlIjv33bdgJRwlTUP1nav8rczdoOPdPRxEDssb7iGDVF63?=
 =?us-ascii?Q?gdOL8UvUX1aFkMY0ibqLjMuzPpNcvvZjwGLupLlpBpxc2HzQ5ZE8mux03EjJ?=
 =?us-ascii?Q?Av+mHFMNLNsdopW8A3nj8i6TUhwuyzr/8BcBdLVK06KiUoGuK46DvOmpyKV3?=
 =?us-ascii?Q?SQP1kpo7mckJWmxZODYMFG+twXZxS57cVgHVRUeeNl7ZQOgwnXXVZxqjCsTI?=
 =?us-ascii?Q?AsMDqmN8YoCKn+XbEk0LZ9z5ktd74fLJiuhDp01VYUa9Tp/w5NSrHuAS/C4Y?=
 =?us-ascii?Q?AQg6DEwWMqTjjYwa4loOnr/dlGqqcLfxAsuJpLMcKkmaPxU8nhIfX/l+3fth?=
 =?us-ascii?Q?Ro0kjmSxc53Qo54XeBIjLURe0UoWtugD48a58uNnLWgG2RMe8qJSxjRWwjFF?=
 =?us-ascii?Q?99SdaLfiw1YLt019c1pFqns2aBX9DmVE1CgtFgMD78n5ufNUc3RA+/uOK0Tf?=
 =?us-ascii?Q?HEqL/L8mZcBy3w4Dpc+WPmHizH7Ip6oT2LjuF7Z7MFDIK7fmKQtgceKL8dgk?=
 =?us-ascii?Q?14/8/Xnf+zOsasIrB/BsYLy0DCvU8kXw4KX3yicTxt8bFW8CfNBwmW+hZecB?=
 =?us-ascii?Q?nGV59Bg+fLmymC0sA2/iRzMfWAEfyH5kDQnbm5vcSAipryRpVf4hfW3Nx2VC?=
 =?us-ascii?Q?2ue5bbBxfS99Dwi0m1F4n40D+34h/uZbH5AUNUwguyeImwEU+A7aKGrUAksN?=
 =?us-ascii?Q?nKuzuqBLkPEmZkzpBvAIzMnmAKlW9gGtCpx/7V5CxNquY5nAWdc8Hp+dikdz?=
 =?us-ascii?Q?UbebR0qEy1KIYM5oqGLQAZYpbE1mRrevr25O5dHILXa2bGIImzsPcnycQAh+?=
 =?us-ascii?Q?s+1BtSrgNNvh0/fkUeZ/gH6qUW+G+/9O7r5VL6/KeZwxtz19F5wPgxc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(52116011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tCmwtThjiEsfr1sYOcyg18Ag69uixnMXzXf8tj7sOMu+/MJHEJ/2hqy5a1XP?=
 =?us-ascii?Q?+sEKxPkg+P0FnYHjb1C3SlNXBcMw0huydFrEdTU8I3bOFIh6MbUKtSrmsft5?=
 =?us-ascii?Q?Lf58x7RW3L0UekXNOuIeUCtK8qdPscCiEKyUouzVs2okZyGLTZTsClz5dZKK?=
 =?us-ascii?Q?1yJcR4aGNvmqBLGR9E8X34VvhFilttHu6CPiKA2tHWmT5GNhsoGYFxKW3sXJ?=
 =?us-ascii?Q?v78r5XJjiHD+4cx7C7dyio4M59K02dYgmTYUtQw8mFPCije7QxrVESzqApbN?=
 =?us-ascii?Q?cx6qLD9Gl7TGEGZRUxj241PG5VDZa9vCfQwYnPchYtWqOvYRwI6Yj056UI3P?=
 =?us-ascii?Q?7zRTowvwjtucwT2yiU5cqqucM5X4aMjc8+dS1db1NOFpLziPc9p+z+8ks4nj?=
 =?us-ascii?Q?u20lWeYNWcUSrHsB5xgrYOEWjSxDBeeHOAI7LNFOHzovsOOe6irx7P09R02c?=
 =?us-ascii?Q?S1mRSM3WD0z7nvhzkrdBy1qfYaGwiwe65zf2vQaEHz5jGJk8Dx61CeyMoM0s?=
 =?us-ascii?Q?20wyJJnUoLHBDdD9hQiJynfhNhoAD/jg+nbw8dVBNffRbMTqnigT44q0me5f?=
 =?us-ascii?Q?8j/n0yzLX8vTBiEg14zaiQzHwVp/XPAB9zjZf0QAlvB57zCO9yF79BxBHjyl?=
 =?us-ascii?Q?2hfQlqu83qJ8fWvdqXYEfmCZ98li2/irgJt9fwcPvCjHXtgHBAqWCDDMi48v?=
 =?us-ascii?Q?cMSXoSezJj8dfre3FD6lHZUinbT1xOJ1ZsmTnqfoO6VLjfDCt8y05HNNwn/F?=
 =?us-ascii?Q?kQtZ/4dNa93pYBNrjBkobEEzkXsRyoDY8RoZVELF8oHs/0si97N+Lwp29jXV?=
 =?us-ascii?Q?UwFJyOy0LQiiqoleNLrrnF7IuVFG6uxdVaIp4PKFVyrwRgBVkxPKp1ZzFYU/?=
 =?us-ascii?Q?AfoBytzBXMB0Jii9ZkUfSYXDYu7UysPc61kshxWK3PQ1StfAP5eDEf3V2NDw?=
 =?us-ascii?Q?pATnxWYw4H4w1XgXXq/Vz8/pc91gZRR3IomgkDzb1Hd320bKChSIHW2la4Ft?=
 =?us-ascii?Q?jUfRcw6Tfzvy+QdTcYfya9jQ6t7myQKxSihyhYWlhoV1sWY86Yk8gQweJFow?=
 =?us-ascii?Q?3nUQAisq9GdpJ45CqVu3b/0ZVMaQQyOJobyf8Iv7huuK1kn5Q9+rN0nIAwFL?=
 =?us-ascii?Q?5/S2wEqGEog8XBCINtqg4O83MEkwmi0qoG6enveZUA1TQMTll2TU4aCsYU8u?=
 =?us-ascii?Q?Nl0CGUgXkiK9NWdE5z71/+IDNCmG19C2cdyuim4Oo2mELD8Z5glJ1yqEAmnp?=
 =?us-ascii?Q?fA8+Bvbji+joI8NMQ4EgHGj6jwpZNBx51QOH9yzUXaw5WvSS5oA6G8lOo6N1?=
 =?us-ascii?Q?017/eucZlGqe06N4GyiLbExLMxNYruz3DPe/T4NhIiBTq8DEQ+q/haPzpHLc?=
 =?us-ascii?Q?vBkXQOsT7NO2WlHfXLYsUid53Tr+K+lCWjgdvtICQZRY6LyalTC3UF3lCVuP?=
 =?us-ascii?Q?EPc4VVl4qhb9PVytEEB1muLedJD0J1VibKwS2gzddiV/LpNQ76dXVxRpg5da?=
 =?us-ascii?Q?WSZL9Dz2MYaj9U4a0CV5pV2BrkBPsCv0vphQOuPXiCsiVcOIiiIrkJ2VESQK?=
 =?us-ascii?Q?sAv70DOJGpS9hIHlbcrIRXD8i45KZD0NVz0y/t5ex+o9c37tPKNyTvutqrOE?=
 =?us-ascii?Q?7JmE+tFeYmpM7fvzuOdoVVLiGdpAiZUVDs8HILqPm2Px?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb68bc5-e129-49a6-cecf-08dc943ae93d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 10:46:32.2723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlRtFCoiOWW6LcMO7pMSr/m7YXrE4og1AZ1m90UEIk+3Pt1PRvJOJJMdXkuAA2HXL5j18+CRYkfWwRaTg+4yUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7605

A bug in md-bitmap has been discovered by setting up a md raid on top of
nvme-tcp devices that has optimal io size larger than the allocated
bitmap.

The following test reproduce the bug by setting up a md-raid on top of
nvme-tcp device over ram device that sets the optimal io size by using
dm-stripe.

Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
---
 common/brd       | 28 +++++++++++++++
 tests/md/001     | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/md/001.out |  2 ++
 tests/md/rc      | 12 +++++++
 4 files changed, 130 insertions(+)
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
index 0000000..fc23ff7
--- /dev/null
+++ b/tests/md/001
@@ -0,0 +1,88 @@
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
+	_create_nvmet_subsystem "blktests-subsystem-0" "/dev/mapper/ram0_big_optio"
+	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-0"
+
+	_create_nvmet_host "blktests-subsystem-0" "${def_hostnqn}"
+
+	_nvme_connect_subsys --subsysnqn "blktests-subsystem-0"
+
+	local nvmedev
+	nvmedev=$(_find_nvme_dev "blktests-subsystem-0")
+	echo "${nvmedev}"
+}
+
+cleanup_nvme_over_tcp() {
+	local nvmedev=$1
+	_nvme_disconnect_ctrl "${nvmedev}"
+	_nvmet_target_cleanup --subsysnqn "blktests-subsystem-0"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	setup_underlying_device
+	local nvmedev
+	nvmedev=$(setup_nvme_over_tcp)
+
+	# Hangs here without the fix
+	mdadm --quiet --create /dev/md/blktests_md --level=1 --bitmap=internal \
+		--bitmap-chunk=1024K --assume-clean --run --raid-devices=2 \
+		/dev/"${nvmedev}"n1 missing
+
+	mdadm --quiet --stop /dev/md/blktests_md
+	cleanup_nvme_over_tcp "${nvmedev}"
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

