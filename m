Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11022080.outbound.protection.outlook.com [52.101.66.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C57A1993B8
	for <linux-block@vger.kernel.org>; Tue, 16 Jul 2024 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721130647; cv=fail; b=FqZ0ornwlO68efktcuZnjrIH5+O7RojRhjuHdkJS8F3B3QSe2n/zNIHJYdIZcKdqNwhYrP2wZG/ZQNAmAULHrC1tO6SggLkKOxAnFwvOlkiupZ/rcdqr/Z+6pz066gjc2SoXFYNu+Mb6cA3C1spA68ccK/ExLK17eNI1zVBfRmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721130647; c=relaxed/simple;
	bh=xHn5joR3v1zWr/E3bLCor0xNVLAbnth1ftqWsKd2D1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JoCfN/MW+773zneVWCQY0KxCAEAkO+HShF4ScjiZOwGupq32SAQ2XKBMnnGHhTYEOP0SZHVZM9hvn9qsIgyIwg2Dsyleap/NmpPwdMgNkWgu0AsH0MGJL9QeKNPOAAXn2vX5agxum7zM7Xx/LpeZP3Y7SnyjhWZgKmWFcMzeVG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com; spf=pass smtp.mailfrom=volumez.com; dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b=bRzcJThc; arc=fail smtp.client-ip=52.101.66.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=volumez.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b="bRzcJThc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQ4LLrmLOjnSiH23MYfgPMyn6mY4lFhwDPu5JMCFIdFUoSc3jhsAg63IGP4GHwOQKfURMmN8eG4EsbvrR55f4T9mjUmwxB73V1y8p7Qhx+hNkYQVkoPw2TsmSoJITeePzlUlysthwQjFDLzibEQa1Ce4DP3MorErhiVJswKmNWrOOT0HQ2BHfMbsqHwMTvnYvLOylReUtDpdv5Rly8S2P1uRLcE0ThDuLiu/J+5CJwPUM/II6N7SFg21uy8AXIbivXdtr/pIIFSYJrUM4DC9L0T2owvd4af/y5lX9z+qqY/DmAxM359g1MUSjmedXJ0lG3yaJG2tL6K5d5IOoscX8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKBll5VEHTMdbiUvyUCQK6g57PpwjYFR90NOi60tyNo=;
 b=xFNmUiPwsqUDfejfsTRrXp2vHHEEZ1IDXCzV0HeGslCIvNXwPIq+0v8s6ksPQT5hQivEBoxcD0IaIcZksDGPjyyBhO9jLarFOG/1N/TdU55kmH/gpRTZobkozdPBErjRg4bcpFx4AU5k0y3t/Ve/6zy/lQ/Ld7GXEadCVjLmZaC7MKRJ1y9yGbIecTYqScl/NSWwzB9yZNQVAgfo604DOHYqbAp4x4mNabsekuRdOmfUEzCNrV2YLmZLsloWYaWMydNVK5ACqdZ7pAlx7e2x26lfCd9km6s2658Kr84KGSLaHzvyCR5pA08A7wXuTANTWCh2oNs/uOie9CL6zXko/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKBll5VEHTMdbiUvyUCQK6g57PpwjYFR90NOi60tyNo=;
 b=bRzcJThczYY90S/v+/PsQhQYounr8UGueDpQvs3nUfFhWljHi8AwwMhOBBOa2pp4xKQbjvRd1Fq35SBZbQG4XrVOjEtC7vOTo/60UAXBh7HzGoJw3IvFc8yWF3UwEahD8pqNXJVZd681mFfV8Phv4zr6fNckPYlwK689iTbMUkIWgAMtejhvuzIhW7k1vtSNh19dPEe9NxLkreNGWHGTGsLk87ea0aJpZIqcWFtsZu0DNjKFAONP67ezHGtEbQS4/BI1neXGQpeiEMGk4hb8MffwCvER+Xw9mNehoXnkghej9ool7tlGuQ43saeIfePPspaYfb7AQUosYvg8kCZj+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20)
 by PA4PR04MB7775.eurprd04.prod.outlook.com (2603:10a6:102:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 11:50:39 +0000
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
Subject: [PATCH blktests v3 1/2] nvme: move helper functions to common/nvme
Date: Tue, 16 Jul 2024 14:50:23 +0300
Message-ID: <20240716115026.1783969-2-ofir.gal@volumez.com>
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
X-MS-Office365-Filtering-Correlation-Id: 79e82f0e-82d9-48be-e4bd-08dca58d8321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HKm/udzZvHCDMe2ja4clEDgzudHPCio4xD3epL6t8hsBmWZ3JxvbmxrgRDie?=
 =?us-ascii?Q?d0StSZbNG5Nqs9vIjM6byamvqzfhgrwwJv0Du2pyEqakfzglT5dpKZSIfJ7u?=
 =?us-ascii?Q?qk5+LbQzzxEyRRnH/K0KLp56+E3Vz5492RvLkeRVR1nXoW0upcDP6QRwdNcP?=
 =?us-ascii?Q?NrDk28+V/0XMENesR9zFDrKMqKtIah/tB+OJTJUEu8R8OMHNrtDmkSnWjlYr?=
 =?us-ascii?Q?oktNHc7ItJ6F0g4FYUpTUl3k5l5nVG2Kuxe0yfMN8UTfN5pmEV9L7XWQpfkW?=
 =?us-ascii?Q?CaCJx5/riUW3b6YRRzuBLmHxbdij8zale/quBUFYhNFCiePxbI9hGTwRz5Rq?=
 =?us-ascii?Q?4vO6i/7WTr90K5eOOLJT/BKKDXvvdeNtDeBSqycdiQwi/IUVS03g6OlbYAeR?=
 =?us-ascii?Q?bXYuXAJIcEpiWqKbPXA7yRtoJ0jyXY3C+VNucQV8aGjMfOvUpDyeVbYWgDko?=
 =?us-ascii?Q?CUWKn2wkGMFzkUJCpzKyXVZGdbX6tJLAD9qmAC13CrKBKLt7nEr7VaEVtiHI?=
 =?us-ascii?Q?WabCVzn8m4fH7i2P3Vkean5tBTdkhXDuZY0YAA0cirJ3YJO6UWp9OGSOQN2l?=
 =?us-ascii?Q?/9oem2qfOQbia5j1xrQbTlW1LupKSRztHsx6H8rTb9JtHhffAbnUkTxkguBr?=
 =?us-ascii?Q?e5P1VPouRfgRZcJomFenE1wd7982PBXaK9IqMXYFoORauLhjdpnKurEyhcun?=
 =?us-ascii?Q?mHOg8sexaz3ngTTkm5jKJU50f3yfrjUHze8e6epLoXUN0QZVdRTQM5hOFBNk?=
 =?us-ascii?Q?Eg+kzj8EYLlpcdOmYm0i66kJhkAtCHbYKcRD4P1ZTxGadEZcfH41orJ+YjYW?=
 =?us-ascii?Q?67QSAFItuysx4X6PhYflG+9SAdPxoxERhjF5bvIOsrZzejawEfdlvcewdSpj?=
 =?us-ascii?Q?Sya2MfD6UIxVqdOkwvkGeF7oCD/6COB3KEcyz8USHb2zcyJnMtxwVI3El7Da?=
 =?us-ascii?Q?2XjBb4In7AWfVxnp3rFZ6Gzmq0V5NPJoqv9Yi3Ver/4GsWHB0H4WsMOMBvvs?=
 =?us-ascii?Q?InR9R4XS+oisS9Bl0F3K7XNhMzVSSTfQLCpeWC65OLI/G7YDvrbdHdjBpy3x?=
 =?us-ascii?Q?V4vHxjQ12QuyNI6MAH4PE31kAhTJStOUZyTH5b4AOHQBset2hpnZjII/KG3K?=
 =?us-ascii?Q?YOCeddFTSFBfyioydwg9FfSnIEkSot3hhztT19+CHjqCqZQSPx3ZGt8D3TMa?=
 =?us-ascii?Q?M1X8RHOhex8lcXDfw3R9k1+Y3LzWHgwPuiOBSRvc+TDp8UmLT9DVT6Hqg7CF?=
 =?us-ascii?Q?QYyPLbSCQ+yy1SaduHmvIqQCjAsPtNtJ6mh0C5a9qUR5wv0jaskHmO2ztlBC?=
 =?us-ascii?Q?LsSlckRTAmJ6TuSQFmXu3hcnmRWAf7+P5+19kwih+kY1t790ECE4YRPSW/js?=
 =?us-ascii?Q?QIVTsLVRcpuR1hZfiU4130CzgAUqGkkjmxwj8szba4qmqgSt3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D4R4bDapzZmQuWBNJt4QirfDxd/+1lcjV1EEsNqTQiw0tOe4On4d7EmD0URP?=
 =?us-ascii?Q?NQQ8wNATw6wgTX+ZRoVfJ/cxFeL5VB2L7qW++KHVCi7th2BgXHLxrhh7kgpM?=
 =?us-ascii?Q?NP6wB1XVbo3OKWkWlhtxfu7cQoCGg1CBuRiFJFWN3PliHI3+NgmXy+ujJABt?=
 =?us-ascii?Q?/qGX1eRsTorhh0M7zYvUI2vyT8wBY2HlNX1KkXb0PYFSDWZ0Q0sKp4UmqD/W?=
 =?us-ascii?Q?Jv6n7NCzJqQ8IsxOY3hM4XQ/3I2bB1SDOPdbwuMhLY0ottU9kRq1R3GRoH/l?=
 =?us-ascii?Q?Jq/yefn9s8v0nSatUHy/ETv4KbVucYLQYRbkJTk/BXsTCdDNIJF51AiPsmDX?=
 =?us-ascii?Q?dnBv33CqZfoDjnwz5gTpGkbTGNh9+4Itzr26iW0Aw3ljShU03tsO38Jk3tgd?=
 =?us-ascii?Q?CWf6mV35LY/3zCnMXehc0c+C2veloWTNGReQpMxYu0Fr5As4tSAoczx47dnA?=
 =?us-ascii?Q?U1VNpiDvyBWKJ8is6AKq9oMKj2/FYiZJ9AbRx+WrL+x6GhhV1vfZLm9F8KiZ?=
 =?us-ascii?Q?L8gJw7IZ/7kCpJoA6MOH/IUL4LkmVOkFzIX959InedsbXTXe1RfpbjeLDR3w?=
 =?us-ascii?Q?gjC/6ybYERNi8nlOdR1UcOprdM0TKgdw3cD3lJPpNDr1vLg77ImXfIqBeiV9?=
 =?us-ascii?Q?LchttdN8c68vgEI+MHq8+cOFVhaCc7K+oyURwUYA8auhVLfnrar/XEuEwixW?=
 =?us-ascii?Q?+P+ZiSnPh7JuF5JIn5T9FmkKnfuXDz+jp4mQxLr+R2vM5GB1TELiphMOxoWY?=
 =?us-ascii?Q?QzF3fFxpahA3oya5pm0bht/X0ugrKa7bjoin/9xoqFceaGt0hM5x5t+22Ydd?=
 =?us-ascii?Q?WPXSN0IlTfZn7bWvBTe+p8mvvh/GHWKiFvpYKf+W+K7yBqjKWLylvoe7zVe5?=
 =?us-ascii?Q?971vNM9Hvl5UNYU5a8+WCv/MyqNGfAy6Nsj/FXcVRY6jFC+utod643rnFg4h?=
 =?us-ascii?Q?lQF+N8P0Y+jqSDuXd5ahJ30U+dHquFzXyX9/XswCHbwbBL2EzRkR1YnItIyg?=
 =?us-ascii?Q?dmFZWwuKvSLHTz/DtgN4bPk2VxZW3TGY5mD4J7Fz6UAkPnJNF1tjV5Y5iWvg?=
 =?us-ascii?Q?Q6tIhpvnZx0du1IaxWzwWomWzfVTmYn1KtwmjFkv0cOYNucyux+BZn/Ax+Vr?=
 =?us-ascii?Q?Nbiq1BkA2p6Lw5EA2KGfcDxK+OHosph++73PCQQFnyshwS2ystHWBlDLmXyz?=
 =?us-ascii?Q?8buFrToNjjJS4WorMzFkOI+2Q/HY5hihRd27IMWIP1U8L7swRQHN/fQ5yvr5?=
 =?us-ascii?Q?6QF4Y7rsugm+1whjZCWf+0eoojErvSG8USXcTNvc3aqPPik2gEjeyGKa+5hk?=
 =?us-ascii?Q?t7rqWheK1mc0InjCp+anNzoUsHXeKXshANVuc2QhuNek8CzLKpRCUXuXVuqK?=
 =?us-ascii?Q?1nTaXKZu8tNRtTwgSaG2Y9CdZn0k33sYigqa6z/qBeoumZ3zNTzfjM1TnnBr?=
 =?us-ascii?Q?N7+TA1m2yIY3uEU60gmTHMH6UeaD2FAks2mYafFK10NuaYY1Tecz97qcEYem?=
 =?us-ascii?Q?6Htr/vUff5dC6FE0ytCF/ExIDuGum1HqNfDuX1n8ifnk5oJ4GRKo31TU7m7u?=
 =?us-ascii?Q?ybWw20yfqfDUNQ1/cPIOY9kl1RtxtEGJaEjtBqtJ?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e82f0e-82d9-48be-e4bd-08dca58d8321
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 11:50:39.0215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dK4o7TW041oa/8O9AOjfiQQCRTLYeUnt5TrnRycGy/rFzbdMSQlLKdAA469BbfMfkstz29Y+2m0SkLLAHpC/eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7775

Move functions from tests/nvme/rc to common/nvme to be able to reuse
them in other tests groups.

Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
---
 common/nvme   | 636 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/rc | 629 +------------------------------------------------
 2 files changed, 637 insertions(+), 628 deletions(-)
 create mode 100644 common/nvme

diff --git a/common/nvme b/common/nvme
new file mode 100644
index 0000000..9e78f3e
--- /dev/null
+++ b/common/nvme
@@ -0,0 +1,636 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+#
+# nvme helper functions.
+
+. common/shellcheck
+
+def_traddr="127.0.0.1"
+def_adrfam="ipv4"
+def_trsvcid="4420"
+def_remote_wwnn="0x10001100aa000001"
+def_remote_wwpn="0x20001100aa000001"
+def_local_wwnn="0x10001100aa000002"
+def_local_wwpn="0x20001100aa000002"
+def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
+def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
+export def_subsysnqn="blktests-subsystem-1"
+export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+_check_conflict_and_set_default NVMET_TRTYPES nvme_trtype "loop"
+_check_conflict_and_set_default NVME_IMG_SIZE nvme_img_size 1G
+_check_conflict_and_set_default NVME_NUM_ITER nvme_num_iter 1000
+nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
+NVMET_BLKDEV_TYPES=${NVMET_BLKDEV_TYPES:-"device file"}
+NVMET_CFS="/sys/kernel/config/nvmet/"
+nvme_trtype=${nvme_trtype:-}
+nvme_adrfam=${nvme_adrfam:-}
+
+# TMPDIR can not be referred out of test() or test_device() context. Instead of
+# global variable def_flie_path, use this getter function.
+_nvme_def_file_path() {
+	echo "${TMPDIR}/img"
+}
+
+_require_nvme_trtype() {
+	local trtype
+	for trtype in "$@"; do
+		if [[ "${nvme_trtype}" == "$trtype" ]]; then
+			return 0
+		fi
+	done
+	SKIP_REASONS+=("nvme_trtype=${nvme_trtype} is not supported in this test")
+	return 1
+}
+
+_require_nvme_trtype_is_loop() {
+	if ! _require_nvme_trtype loop; then
+		return 1
+	fi
+	return 0
+}
+
+_require_nvme_trtype_is_fabrics() {
+	if ! _require_nvme_trtype loop fc rdma tcp; then
+		return 1
+	fi
+	return 0
+}
+
+_nvme_fcloop_add_rport() {
+	local local_wwnn="$1"
+	local local_wwpn="$2"
+	local remote_wwnn="$3"
+	local remote_wwpn="$4"
+	local loopctl=/sys/class/fcloop/ctl
+
+	echo "wwnn=${remote_wwnn},wwpn=${remote_wwpn},lpwwnn=${local_wwnn},lpwwpn=${local_wwpn},roles=0x60" > ${loopctl}/add_remote_port
+}
+
+_nvme_fcloop_add_lport() {
+	local wwnn="$1"
+	local wwpn="$2"
+	local loopctl=/sys/class/fcloop/ctl
+
+	echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/add_local_port
+}
+
+_nvme_fcloop_add_tport() {
+	local wwnn="$1"
+	local wwpn="$2"
+	local loopctl=/sys/class/fcloop/ctl
+
+	echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/add_target_port
+}
+
+_setup_fcloop() {
+	local local_wwnn="${1:-$def_local_wwnn}"
+	local local_wwpn="${2:-$def_local_wwpn}"
+	local remote_wwnn="${3:-$def_remote_wwnn}"
+	local remote_wwpn="${4:-$def_remote_wwpn}"
+
+	_nvme_fcloop_add_tport "${remote_wwnn}" "${remote_wwpn}"
+	_nvme_fcloop_add_lport "${local_wwnn}" "${local_wwpn}"
+	_nvme_fcloop_add_rport "${local_wwnn}" "${local_wwpn}" \
+		               "${remote_wwnn}" "${remote_wwpn}"
+}
+
+_nvme_fcloop_del_rport() {
+	local local_wwnn="$1"
+	local local_wwpn="$2"
+	local remote_wwnn="$3"
+	local remote_wwpn="$4"
+	local loopctl=/sys/class/fcloop/ctl
+
+	if [[ ! -f "${loopctl}/del_remote_port" ]]; then
+		return
+	fi
+	echo "wwnn=${remote_wwnn},wwpn=${remote_wwpn}" > "${loopctl}/del_remote_port"
+}
+
+_nvme_fcloop_del_lport() {
+	local wwnn="$1"
+	local wwpn="$2"
+	local loopctl=/sys/class/fcloop/ctl
+
+	if [[ ! -f "${loopctl}/del_local_port" ]]; then
+		return
+	fi
+	echo "wwnn=${wwnn},wwpn=${wwpn}" > "${loopctl}/del_local_port"
+}
+
+_nvme_fcloop_del_tport() {
+	local wwnn="$1"
+	local wwpn="$2"
+	local loopctl=/sys/class/fcloop/ctl
+
+	if [[ ! -f "${loopctl}/del_target_port" ]]; then
+		return
+	fi
+	echo "wwnn=${wwnn},wwpn=${wwpn}" > "${loopctl}/del_target_port"
+}
+
+_cleanup_fcloop() {
+	local local_wwnn="${1:-$def_local_wwnn}"
+	local local_wwpn="${2:-$def_local_wwpn}"
+	local remote_wwnn="${3:-$def_remote_wwnn}"
+	local remote_wwpn="${4:-$def_remote_wwpn}"
+
+	_nvme_fcloop_del_tport "${remote_wwnn}" "${remote_wwpn}"
+	_nvme_fcloop_del_lport "${local_wwnn}" "${local_wwpn}"
+	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
+			       "${remote_wwnn}" "${remote_wwpn}"
+}
+
+_cleanup_blkdev() {
+	local blkdev
+	local dev
+
+	blkdev="$(losetup -l | awk '$6 == "'"$(_nvme_def_file_path)"'" { print $1 }')"
+	for dev in ${blkdev}; do
+		losetup -d "${dev}"
+	done
+	rm -f "$(_nvme_def_file_path)"
+}
+
+_cleanup_nvmet() {
+	local dev
+	local port
+	local subsys
+	local transport
+	local name
+
+	if [[ ! -d "${NVMET_CFS}" ]]; then
+		return 0
+	fi
+
+	# Don't let successive Ctrl-Cs interrupt the cleanup processes
+	trap '' SIGINT
+
+	shopt -s nullglob
+
+	for dev in /sys/class/nvme/nvme*; do
+		dev="$(basename "$dev")"
+		transport="$(cat "/sys/class/nvme/${dev}/transport" 2>/dev/null)"
+		if [[ "$transport" == "${nvme_trtype}" ]]; then
+			# if udev auto connect is enabled for FC we get false positives
+			if [[ "$transport" != "fc" ]]; then
+				echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
+			fi
+			_nvme_disconnect_ctrl "${dev}" 2>/dev/null
+		fi
+	done
+
+	for port in "${NVMET_CFS}"/ports/*; do
+		name=$(basename "${port}")
+		echo "WARNING: Test did not clean up port: ${name}"
+		rm -f "${port}"/subsystems/*
+		rmdir "${port}"
+	done
+
+	for subsys in "${NVMET_CFS}"/subsystems/*; do
+		name=$(basename "${subsys}")
+		echo "WARNING: Test did not clean up subsystem: ${name}"
+		for ns in "${subsys}"/namespaces/*; do
+			rmdir "${ns}"
+		done
+		rmdir "${subsys}"
+	done
+
+	for host in "${NVMET_CFS}"/hosts/*; do
+		name=$(basename "${host}")
+		echo "WARNING: Test did not clean up host: ${name}"
+		rmdir "${host}"
+	done
+
+	shopt -u nullglob
+	trap SIGINT
+
+	if [[ "${nvme_trtype}" == "fc" ]]; then
+		_cleanup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
+				"${def_remote_wwnn}" "${def_remote_wwpn}"
+		modprobe -rq nvme-fcloop 2>/dev/null
+	fi
+	modprobe -rq nvme-"${nvme_trtype}" 2>/dev/null
+	if [[ "${nvme_trtype}" != "loop" ]]; then
+		modprobe -rq nvmet-"${nvme_trtype}" 2>/dev/null
+	fi
+	modprobe -rq nvmet 2>/dev/null
+	if [[ "${nvme_trtype}" == "rdma" ]]; then
+		stop_soft_rdma
+	fi
+
+	_cleanup_blkdev
+}
+
+_setup_nvmet() {
+	_register_test_cleanup _cleanup_nvmet
+	modprobe -q nvmet
+	if [[ "${nvme_trtype}" != "loop" ]]; then
+		modprobe -q nvmet-"${nvme_trtype}"
+	fi
+	modprobe -q nvme-"${nvme_trtype}"
+	if [[ "${nvme_trtype}" == "rdma" ]]; then
+		start_soft_rdma
+		for i in $(rdma_network_interfaces)
+		do
+			if [[ "${nvme_adrfam}" == "ipv6" ]]; then
+				ipv6_addr=$(get_ipv6_ll_addr "$i")
+				if [[ -n "${ipv6_addr}" ]]; then
+					def_traddr=${ipv6_addr}
+				fi
+			else
+				ipv4_addr=$(get_ipv4_addr "$i")
+				if [[ -n "${ipv4_addr}" ]]; then
+					def_traddr=${ipv4_addr}
+				fi
+			fi
+		done
+	fi
+	if [[ "${nvme_trtype}" = "fc" ]]; then
+		modprobe -q nvme-fcloop
+		_setup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
+			      "${def_remote_wwnn}" "${def_remote_wwpn}"
+
+		def_traddr=$(printf "nn-%s:pn-%s" \
+				    "${def_remote_wwnn}" \
+				    "${def_remote_wwpn}")
+		def_host_traddr=$(printf "nn-%s:pn-%s" \
+					 "${def_local_wwnn}" \
+					 "${def_local_wwpn}")
+	fi
+}
+
+_nvme_disconnect_ctrl() {
+	local ctrl="$1"
+
+	nvme disconnect --device "${ctrl}"
+}
+
+_nvme_connect_subsys() {
+	local subsysnqn="$def_subsysnqn"
+	local hostnqn="$def_hostnqn"
+	local hostid="$def_hostid"
+	local hostkey=""
+	local ctrlkey=""
+	local nr_io_queues=""
+	local nr_write_queues=""
+	local nr_poll_queues=""
+	local keep_alive_tmo=""
+	local reconnect_delay=""
+	local ctrl_loss_tmo=""
+	local no_wait=false
+	local i
+
+	while [[ $# -gt 0 ]]; do
+		case $1 in
+			--subsysnqn)
+				subsysnqn="$2"
+				shift 2
+				;;
+			--hostnqn)
+				hostnqn="$2"
+				shift 2
+				;;
+			--hostid)
+				hostid="$2"
+				shift 2
+				;;
+			--dhchap-secret)
+				hostkey="$2"
+				shift 2
+				;;
+			--dhchap-ctrl-secret)
+				ctrlkey="$2"
+				shift 2
+				;;
+			--nr-io-queues)
+				nr_io_queues="$2"
+				shift 2
+				;;
+			--nr-write-queues)
+				nr_write_queues="$2"
+				shift 2
+				;;
+			--nr-poll-queues)
+				nr_poll_queues="$2"
+				shift 2
+				;;
+			--keep-alive-tmo)
+				keep_alive_tmo="$2"
+				shift 2
+				;;
+			--reconnect-delay)
+				reconnect_delay="$2"
+				shift 2
+				;;
+			--ctrl-loss-tmo)
+				ctrl_loss_tmo="$2"
+				shift 2
+				;;
+			--no-wait)
+				no_wait=true
+				shift 1
+				;;
+			*)
+				echo "WARNING: unknown argument: $1"
+				shift
+				;;
+		esac
+	done
+
+	ARGS=(--transport "${nvme_trtype}" --nqn "${subsysnqn}")
+	if [[ "${nvme_trtype}" == "fc" ]] ; then
+		ARGS+=(--traddr "${def_traddr}" --host-traddr "${def_host_traddr}")
+	elif [[ "${nvme_trtype}" != "loop" ]]; then
+		ARGS+=(--traddr "${def_traddr}" --trsvcid "${def_trsvcid}")
+	fi
+	ARGS+=(--hostnqn="${hostnqn}")
+	ARGS+=(--hostid="${hostid}")
+	if [[ -n "${hostkey}" ]]; then
+		ARGS+=(--dhchap-secret="${hostkey}")
+	fi
+	if [[ -n "${ctrlkey}" ]]; then
+		ARGS+=(--dhchap-ctrl-secret="${ctrlkey}")
+	fi
+	if [[ -n "${nr_io_queues}" ]]; then
+		ARGS+=(--nr-io-queues="${nr_io_queues}")
+	fi
+	if [[ -n "${nr_write_queues}" ]]; then
+		ARGS+=(--nr-write-queues="${nr_write_queues}")
+	fi
+	if [[ -n "${nr_poll_queues}" ]]; then
+		ARGS+=(--nr-poll-queues="${nr_poll_queues}")
+	fi
+	if [[ -n "${keep_alive_tmo}" ]]; then
+		ARGS+=(--keep-alive-tmo="${keep_alive_tmo}")
+	fi
+	if [[ -n "${reconnect_delay}" ]]; then
+		ARGS+=(--reconnect-delay="${reconnect_delay}")
+	fi
+	if [[ -n "${ctrl_loss_tmo}" ]]; then
+		ARGS+=(--ctrl-loss-tmo="${ctrl_loss_tmo}")
+	fi
+
+	nvme connect "${ARGS[@]}" 2> /dev/null | grep -v "connecting to device:"
+
+	# Wait until device file and uuid/wwid sysfs attributes get ready for
+	# all namespaces.
+	if [[ ${no_wait} = false ]]; then
+		udevadm settle
+		for ((i = 0; i < 10; i++)); do
+			_nvme_ns_ready "${subsysnqn}" && return
+			sleep .1
+		done
+	fi
+}
+
+_nvme_disconnect_subsys() {
+	local subsysnqn="$def_subsysnqn"
+
+	while [[ $# -gt 0 ]]; do
+		case $1 in
+			--subsysnqn)
+				subsysnqn="$2"
+				shift 2
+				;;
+			*)
+				echo "WARNING: unknown argument: $1"
+				shift
+				;;
+		esac
+	done
+
+	nvme disconnect --nqn "${subsysnqn}" |& tee -a "$FULL" |
+		grep -o "disconnected.*"
+}
+
+
+_nvme_ns_ready() {
+	local subsysnqn="${1}"
+	local ns_path ns_id dev
+	local cfs_path="${NVMET_CFS}/subsystems/$subsysnqn"
+
+	dev=$(_find_nvme_dev "$subsysnqn")
+	for ns_path in "${cfs_path}/namespaces/"*; do
+		ns_id=${ns_path##*/}
+		if [[ ! -b /dev/${dev}n${ns_id} ||
+			   ! -e /sys/block/${dev}n${ns_id}/uuid ||
+			   ! -e /sys/block/${dev}n${ns_id}/wwid ]]; then
+			return 1
+		fi
+	done
+	return 0
+}
+
+_create_nvmet_port() {
+	local trtype="$1"
+	local traddr="${2:-$def_traddr}"
+	local adrfam="${3:-$def_adrfam}"
+	local trsvcid="${4:-$def_trsvcid}"
+
+	local port
+	for ((port = 0; ; port++)); do
+		if [[ ! -e "${NVMET_CFS}/ports/${port}" ]]; then
+			break
+		fi
+	done
+
+	mkdir "${NVMET_CFS}/ports/${port}"
+	echo "${trtype}" > "${NVMET_CFS}/ports/${port}/addr_trtype"
+	echo "${traddr}" > "${NVMET_CFS}/ports/${port}/addr_traddr"
+	echo "${adrfam}" > "${NVMET_CFS}/ports/${port}/addr_adrfam"
+	if [[ "${adrfam}" != "fc" ]]; then
+		echo "${trsvcid}" > "${NVMET_CFS}/ports/${port}/addr_trsvcid"
+	fi
+
+	echo "${port}"
+}
+
+_remove_nvmet_port() {
+	local port="$1"
+	rmdir "${NVMET_CFS}/ports/${port}"
+}
+
+_create_nvmet_ns() {
+	local nvmet_subsystem="$1"
+	local nsid="$2"
+	local blkdev="$3"
+	local uuid="00000000-0000-0000-0000-000000000000"
+	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+	local ns_path="${subsys_path}/namespaces/${nsid}"
+
+	if [[ $# -eq 4 ]]; then
+		uuid="$4"
+	fi
+
+	mkdir "${ns_path}"
+	printf "%s" "${blkdev}" > "${ns_path}/device_path"
+	printf "%s" "${uuid}" > "${ns_path}/device_uuid"
+	printf 1 > "${ns_path}/enable"
+}
+
+_create_nvmet_subsystem() {
+	local nvmet_subsystem="$1"
+	local blkdev="$2"
+	local uuid=$3
+	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+
+	mkdir -p "${cfs_path}"
+	echo 0 > "${cfs_path}/attr_allow_any_host"
+	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
+}
+
+_add_nvmet_allow_hosts() {
+	local nvmet_subsystem="$1"
+	local nvmet_hostnqn="$2"
+	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+	local host_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
+
+	ln -s "${host_path}" "${cfs_path}/allowed_hosts/${nvmet_hostnqn}"
+}
+
+_create_nvmet_host() {
+	local nvmet_subsystem="$1"
+	local nvmet_hostnqn="$2"
+	local nvmet_hostkey="$3"
+	local nvmet_ctrlkey="$4"
+	local host_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
+
+	if [[ -d "${host_path}" ]]; then
+		echo "FAIL target setup failed. stale host configuration found"
+		return 1;
+	fi
+
+	mkdir "${host_path}"
+	_add_nvmet_allow_hosts "${nvmet_subsystem}" "${nvmet_hostnqn}"
+	if [[ "${nvmet_hostkey}" ]] ; then
+		echo "${nvmet_hostkey}" > "${host_path}/dhchap_key"
+	fi
+	if [[ "${nvmet_ctrlkey}" ]] ; then
+		echo "${nvmet_ctrlkey}" > "${host_path}/dhchap_ctrl_key"
+	fi
+}
+
+_remove_nvmet_ns() {
+	local nvmet_subsystem="$1"
+	local nsid=$2
+	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+	local nvmet_ns_path="${subsys_path}/namespaces/${nsid}"
+
+	echo 0 > "${nvmet_ns_path}/enable"
+	rmdir "${nvmet_ns_path}"
+}
+
+_remove_nvmet_subsystem() {
+	local nvmet_subsystem="$1"
+	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+
+	_remove_nvmet_ns "${nvmet_subsystem}" "1"
+	rm -f "${subsys_path}"/allowed_hosts/*
+	rmdir "${subsys_path}"
+}
+
+_remove_nvmet_host() {
+	local nvmet_host="$1"
+	local host_path="${NVMET_CFS}/hosts/${nvmet_host}"
+
+	rmdir "${host_path}"
+}
+
+_add_nvmet_subsys_to_port() {
+	local port="$1"
+	local nvmet_subsystem="$2"
+
+	ln -s "${NVMET_CFS}/subsystems/${nvmet_subsystem}" \
+		"${NVMET_CFS}/ports/${port}/subsystems/${nvmet_subsystem}"
+}
+
+_remove_nvmet_subsystem_from_port() {
+	local port="$1"
+	local nvmet_subsystem="$2"
+
+	rm "${NVMET_CFS}/ports/${port}/subsystems/${nvmet_subsystem}"
+}
+
+_get_nvmet_ports() {
+	local nvmet_subsystem="$1"
+	local -n nvmet_ports="$2"
+	local cfs_path="${NVMET_CFS}/ports"
+	local sarg
+
+	sarg="s;^${cfs_path}/\([0-9]\+\)/subsystems/${nvmet_subsystem}$;\1;p"
+
+	for path in "${cfs_path}/"*"/subsystems/${nvmet_subsystem}"; do
+		nvmet_ports+=("$(echo "${path}" | sed -n -s "${sarg}")")
+	done
+}
+
+_find_nvme_dev() {
+	local subsys=$1
+	local subsysnqn
+	local dev
+	for dev in /sys/class/nvme/nvme*; do
+		[ -e "$dev" ] || continue
+		dev="$(basename "$dev")"
+		subsysnqn="$(cat "/sys/class/nvme/${dev}/subsysnqn" 2>/dev/null)"
+		if [[ "$subsysnqn" == "$subsys" ]]; then
+			echo "$dev"
+		fi
+	done
+}
+
+_find_nvme_ns() {
+	local subsys_uuid=$1
+	local uuid
+	local ns
+
+	for ns in "/sys/block/nvme"* ; do
+		# ignore nvme channel block devices
+		if ! [[ "${ns}" =~ nvme[0-9]+n[0-9]+ ]]; then
+			continue
+		fi
+		[ -e "${ns}/uuid" ] || continue
+		uuid=$(cat "${ns}/uuid")
+		if [[ "${subsys_uuid}" == "${uuid}" ]]; then
+			basename "${ns}"
+		fi
+	done
+}
+
+_nvmet_target_cleanup() {
+	local ports
+	local port
+	local blkdev
+	local subsysnqn="${def_subsysnqn}"
+	local blkdev_type=""
+
+	while [[ $# -gt 0 ]]; do
+		case $1 in
+			--blkdev)
+				blkdev_type="$2"
+				shift 2
+				;;
+			--subsysnqn)
+				subsysnqn="$2"
+				shift 2
+				;;
+			*)
+				echo "WARNING: unknown argument: $1"
+				shift
+				;;
+		esac
+	done
+
+	_get_nvmet_ports "${subsysnqn}" ports
+
+	for port in "${ports[@]}"; do
+		_remove_nvmet_subsystem_from_port "${port}" "${subsysnqn}"
+		_remove_nvmet_port "${port}"
+	done
+	_remove_nvmet_subsystem "${subsysnqn}"
+	_remove_nvmet_host "${def_hostnqn}"
+
+	if [[ "${blkdev_type}" == "device" ]]; then
+		_cleanup_blkdev
+	fi
+}
diff --git a/tests/nvme/rc b/tests/nvme/rc
index c1ddf41..dedc412 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -5,25 +5,9 @@
 # Test specific to NVMe devices
 
 . common/rc
+. common/nvme
 . common/multipath-over-rdma
 
-def_traddr="127.0.0.1"
-def_adrfam="ipv4"
-def_trsvcid="4420"
-def_remote_wwnn="0x10001100aa000001"
-def_remote_wwpn="0x20001100aa000001"
-def_local_wwnn="0x10001100aa000002"
-def_local_wwpn="0x20001100aa000002"
-def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
-def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
-export def_subsysnqn="blktests-subsystem-1"
-export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-_check_conflict_and_set_default NVMET_TRTYPES nvme_trtype "loop"
-_check_conflict_and_set_default NVME_IMG_SIZE nvme_img_size 1G
-_check_conflict_and_set_default NVME_NUM_ITER nvme_num_iter 1000
-nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
-NVMET_BLKDEV_TYPES=${NVMET_BLKDEV_TYPES:-"device file"}
-
 _NVMET_TRTYPES_is_valid() {
 	local type
 
@@ -70,12 +54,6 @@ _set_nvmet_blkdev_type() {
 	COND_DESC="bd=${nvmet_blkdev_type}"
 }
 
-# TMPDIR can not be referred out of test() or test_device() context. Instead of
-# global variable def_flie_path, use this getter function.
-_nvme_def_file_path() {
-	echo "${TMPDIR}/img"
-}
-
 _nvme_requires() {
 	_have_program nvme
 	_require_nvme_test_img_size 4m
@@ -144,8 +122,6 @@ group_device_requires() {
 	_require_test_dev_is_nvme
 }
 
-NVMET_CFS="/sys/kernel/config/nvmet/"
-
 _require_test_dev_is_nvme() {
 	if ! readlink -f "$TEST_DEV_SYSFS/device" | grep -q nvme; then
 		SKIP_REASONS+=("$TEST_DEV is not a NVMe device")
@@ -168,31 +144,6 @@ _require_nvme_test_img_size() {
 	return 0
 }
 
-_require_nvme_trtype() {
-	local trtype
-	for trtype in "$@"; do
-		if [[ "${nvme_trtype}" == "$trtype" ]]; then
-			return 0
-		fi
-	done
-	SKIP_REASONS+=("nvme_trtype=${nvme_trtype} is not supported in this test")
-	return 1
-}
-
-_require_nvme_trtype_is_loop() {
-	if ! _require_nvme_trtype loop; then
-		return 1
-	fi
-	return 0
-}
-
-_require_nvme_trtype_is_fabrics() {
-	if ! _require_nvme_trtype loop fc rdma tcp; then
-		return 1
-	fi
-	return 0
-}
-
 _require_nvme_cli_auth() {
 	if ! nvme gen-dhchap-key --nqn nvmf-test-subsys > /dev/null 2>&1 ; then
 		SKIP_REASONS+=("nvme gen-dhchap-key command missing")
@@ -235,371 +186,6 @@ _nvme_calc_rand_io_size() {
 	echo "${io_size_kb}k"
 }
 
-_nvme_fcloop_add_rport() {
-	local local_wwnn="$1"
-	local local_wwpn="$2"
-	local remote_wwnn="$3"
-	local remote_wwpn="$4"
-	local loopctl=/sys/class/fcloop/ctl
-
-	echo "wwnn=${remote_wwnn},wwpn=${remote_wwpn},lpwwnn=${local_wwnn},lpwwpn=${local_wwpn},roles=0x60" > ${loopctl}/add_remote_port
-}
-
-_nvme_fcloop_add_lport() {
-	local wwnn="$1"
-	local wwpn="$2"
-	local loopctl=/sys/class/fcloop/ctl
-
-	echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/add_local_port
-}
-
-_nvme_fcloop_add_tport() {
-	local wwnn="$1"
-	local wwpn="$2"
-	local loopctl=/sys/class/fcloop/ctl
-
-	echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/add_target_port
-}
-
-_setup_fcloop() {
-	local local_wwnn="${1:-$def_local_wwnn}"
-	local local_wwpn="${2:-$def_local_wwpn}"
-	local remote_wwnn="${3:-$def_remote_wwnn}"
-	local remote_wwpn="${4:-$def_remote_wwpn}"
-
-	_nvme_fcloop_add_tport "${remote_wwnn}" "${remote_wwpn}"
-	_nvme_fcloop_add_lport "${local_wwnn}" "${local_wwpn}"
-	_nvme_fcloop_add_rport "${local_wwnn}" "${local_wwpn}" \
-		               "${remote_wwnn}" "${remote_wwpn}"
-}
-
-_nvme_fcloop_del_rport() {
-	local local_wwnn="$1"
-	local local_wwpn="$2"
-	local remote_wwnn="$3"
-	local remote_wwpn="$4"
-	local loopctl=/sys/class/fcloop/ctl
-
-	if [[ ! -f "${loopctl}/del_remote_port" ]]; then
-		return
-	fi
-	echo "wwnn=${remote_wwnn},wwpn=${remote_wwpn}" > "${loopctl}/del_remote_port"
-}
-
-_nvme_fcloop_del_lport() {
-	local wwnn="$1"
-	local wwpn="$2"
-	local loopctl=/sys/class/fcloop/ctl
-
-	if [[ ! -f "${loopctl}/del_local_port" ]]; then
-		return
-	fi
-	echo "wwnn=${wwnn},wwpn=${wwpn}" > "${loopctl}/del_local_port"
-}
-
-_nvme_fcloop_del_tport() {
-	local wwnn="$1"
-	local wwpn="$2"
-	local loopctl=/sys/class/fcloop/ctl
-
-	if [[ ! -f "${loopctl}/del_target_port" ]]; then
-		return
-	fi
-	echo "wwnn=${wwnn},wwpn=${wwpn}" > "${loopctl}/del_target_port"
-}
-
-_cleanup_fcloop() {
-	local local_wwnn="${1:-$def_local_wwnn}"
-	local local_wwpn="${2:-$def_local_wwpn}"
-	local remote_wwnn="${3:-$def_remote_wwnn}"
-	local remote_wwpn="${4:-$def_remote_wwpn}"
-
-	_nvme_fcloop_del_tport "${remote_wwnn}" "${remote_wwpn}"
-	_nvme_fcloop_del_lport "${local_wwnn}" "${local_wwpn}"
-	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
-			       "${remote_wwnn}" "${remote_wwpn}"
-}
-
-_cleanup_blkdev() {
-	local blkdev
-	local dev
-
-	blkdev="$(losetup -l | awk '$6 == "'"$(_nvme_def_file_path)"'" { print $1 }')"
-	for dev in ${blkdev}; do
-		losetup -d "${dev}"
-	done
-	rm -f "$(_nvme_def_file_path)"
-}
-
-_cleanup_nvmet() {
-	local dev
-	local port
-	local subsys
-	local transport
-	local name
-
-	if [[ ! -d "${NVMET_CFS}" ]]; then
-		return 0
-	fi
-
-	# Don't let successive Ctrl-Cs interrupt the cleanup processes
-	trap '' SIGINT
-
-	shopt -s nullglob
-
-	for dev in /sys/class/nvme/nvme*; do
-		dev="$(basename "$dev")"
-		transport="$(cat "/sys/class/nvme/${dev}/transport" 2>/dev/null)"
-		if [[ "$transport" == "${nvme_trtype}" ]]; then
-			# if udev auto connect is enabled for FC we get false positives
-			if [[ "$transport" != "fc" ]]; then
-				echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
-			fi
-			_nvme_disconnect_ctrl "${dev}" 2>/dev/null
-		fi
-	done
-
-	for port in "${NVMET_CFS}"/ports/*; do
-		name=$(basename "${port}")
-		echo "WARNING: Test did not clean up port: ${name}"
-		rm -f "${port}"/subsystems/*
-		rmdir "${port}"
-	done
-
-	for subsys in "${NVMET_CFS}"/subsystems/*; do
-		name=$(basename "${subsys}")
-		echo "WARNING: Test did not clean up subsystem: ${name}"
-		for ns in "${subsys}"/namespaces/*; do
-			rmdir "${ns}"
-		done
-		rmdir "${subsys}"
-	done
-
-	for host in "${NVMET_CFS}"/hosts/*; do
-		name=$(basename "${host}")
-		echo "WARNING: Test did not clean up host: ${name}"
-		rmdir "${host}"
-	done
-
-	shopt -u nullglob
-	trap SIGINT
-
-	if [[ "${nvme_trtype}" == "fc" ]]; then
-		_cleanup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
-				"${def_remote_wwnn}" "${def_remote_wwpn}"
-		modprobe -rq nvme-fcloop 2>/dev/null
-	fi
-	modprobe -rq nvme-"${nvme_trtype}" 2>/dev/null
-	if [[ "${nvme_trtype}" != "loop" ]]; then
-		modprobe -rq nvmet-"${nvme_trtype}" 2>/dev/null
-	fi
-	modprobe -rq nvmet 2>/dev/null
-	if [[ "${nvme_trtype}" == "rdma" ]]; then
-		stop_soft_rdma
-	fi
-
-	_cleanup_blkdev
-}
-
-_setup_nvmet() {
-	_register_test_cleanup _cleanup_nvmet
-	modprobe -q nvmet
-	if [[ "${nvme_trtype}" != "loop" ]]; then
-		modprobe -q nvmet-"${nvme_trtype}"
-	fi
-	modprobe -q nvme-"${nvme_trtype}"
-	if [[ "${nvme_trtype}" == "rdma" ]]; then
-		start_soft_rdma
-		for i in $(rdma_network_interfaces)
-		do
-			if [[ "${nvme_adrfam}" == "ipv6" ]]; then
-				ipv6_addr=$(get_ipv6_ll_addr "$i")
-				if [[ -n "${ipv6_addr}" ]]; then
-					def_traddr=${ipv6_addr}
-				fi
-			else
-				ipv4_addr=$(get_ipv4_addr "$i")
-				if [[ -n "${ipv4_addr}" ]]; then
-					def_traddr=${ipv4_addr}
-				fi
-			fi
-		done
-	fi
-	if [[ "${nvme_trtype}" = "fc" ]]; then
-		modprobe -q nvme-fcloop
-		_setup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
-			      "${def_remote_wwnn}" "${def_remote_wwpn}"
-
-		def_traddr=$(printf "nn-%s:pn-%s" \
-				    "${def_remote_wwnn}" \
-				    "${def_remote_wwpn}")
-		def_host_traddr=$(printf "nn-%s:pn-%s" \
-					 "${def_local_wwnn}" \
-					 "${def_local_wwpn}")
-	fi
-}
-
-_nvme_disconnect_ctrl() {
-	local ctrl="$1"
-
-	nvme disconnect --device "${ctrl}"
-}
-
-_nvme_disconnect_subsys() {
-	local subsysnqn="$def_subsysnqn"
-
-	while [[ $# -gt 0 ]]; do
-		case $1 in
-			--subsysnqn)
-				subsysnqn="$2"
-				shift 2
-				;;
-			*)
-				echo "WARNING: unknown argument: $1"
-				shift
-				;;
-		esac
-	done
-
-	nvme disconnect --nqn "${subsysnqn}" |& tee -a "$FULL" |
-		grep -o "disconnected.*"
-}
-
-_nvme_connect_subsys() {
-	local subsysnqn="$def_subsysnqn"
-	local hostnqn="$def_hostnqn"
-	local hostid="$def_hostid"
-	local hostkey=""
-	local ctrlkey=""
-	local nr_io_queues=""
-	local nr_write_queues=""
-	local nr_poll_queues=""
-	local keep_alive_tmo=""
-	local reconnect_delay=""
-	local ctrl_loss_tmo=""
-	local no_wait=false
-	local i
-
-	while [[ $# -gt 0 ]]; do
-		case $1 in
-			--subsysnqn)
-				subsysnqn="$2"
-				shift 2
-				;;
-			--hostnqn)
-				hostnqn="$2"
-				shift 2
-				;;
-			--hostid)
-				hostid="$2"
-				shift 2
-				;;
-			--dhchap-secret)
-				hostkey="$2"
-				shift 2
-				;;
-			--dhchap-ctrl-secret)
-				ctrlkey="$2"
-				shift 2
-				;;
-			--nr-io-queues)
-				nr_io_queues="$2"
-				shift 2
-				;;
-			--nr-write-queues)
-				nr_write_queues="$2"
-				shift 2
-				;;
-			--nr-poll-queues)
-				nr_poll_queues="$2"
-				shift 2
-				;;
-			--keep-alive-tmo)
-				keep_alive_tmo="$2"
-				shift 2
-				;;
-			--reconnect-delay)
-				reconnect_delay="$2"
-				shift 2
-				;;
-			--ctrl-loss-tmo)
-				ctrl_loss_tmo="$2"
-				shift 2
-				;;
-			--no-wait)
-				no_wait=true
-				shift 1
-				;;
-			*)
-				echo "WARNING: unknown argument: $1"
-				shift
-				;;
-		esac
-	done
-
-	ARGS=(--transport "${nvme_trtype}" --nqn "${subsysnqn}")
-	if [[ "${nvme_trtype}" == "fc" ]] ; then
-		ARGS+=(--traddr "${def_traddr}" --host-traddr "${def_host_traddr}")
-	elif [[ "${nvme_trtype}" != "loop" ]]; then
-		ARGS+=(--traddr "${def_traddr}" --trsvcid "${def_trsvcid}")
-	fi
-	ARGS+=(--hostnqn="${hostnqn}")
-	ARGS+=(--hostid="${hostid}")
-	if [[ -n "${hostkey}" ]]; then
-		ARGS+=(--dhchap-secret="${hostkey}")
-	fi
-	if [[ -n "${ctrlkey}" ]]; then
-		ARGS+=(--dhchap-ctrl-secret="${ctrlkey}")
-	fi
-	if [[ -n "${nr_io_queues}" ]]; then
-		ARGS+=(--nr-io-queues="${nr_io_queues}")
-	fi
-	if [[ -n "${nr_write_queues}" ]]; then
-		ARGS+=(--nr-write-queues="${nr_write_queues}")
-	fi
-	if [[ -n "${nr_poll_queues}" ]]; then
-		ARGS+=(--nr-poll-queues="${nr_poll_queues}")
-	fi
-	if [[ -n "${keep_alive_tmo}" ]]; then
-		ARGS+=(--keep-alive-tmo="${keep_alive_tmo}")
-	fi
-	if [[ -n "${reconnect_delay}" ]]; then
-		ARGS+=(--reconnect-delay="${reconnect_delay}")
-	fi
-	if [[ -n "${ctrl_loss_tmo}" ]]; then
-		ARGS+=(--ctrl-loss-tmo="${ctrl_loss_tmo}")
-	fi
-
-	nvme connect "${ARGS[@]}" 2> /dev/null | grep -v "connecting to device:"
-
-	# Wait until device file and uuid/wwid sysfs attributes get ready for
-	# all namespaces.
-	if [[ ${no_wait} = false ]]; then
-		udevadm settle
-		for ((i = 0; i < 10; i++)); do
-			_nvme_ns_ready "${subsysnqn}" && return
-			sleep .1
-		done
-	fi
-}
-
-_nvme_ns_ready() {
-	local subsysnqn="${1}"
-	local ns_path ns_id dev
-	local cfs_path="${NVMET_CFS}/subsystems/$subsysnqn"
-
-	dev=$(_find_nvme_dev "$subsysnqn")
-	for ns_path in "${cfs_path}/namespaces/"*; do
-		ns_id=${ns_path##*/}
-		if [[ ! -b /dev/${dev}n${ns_id} ||
-			   ! -e /sys/block/${dev}n${ns_id}/uuid ||
-			   ! -e /sys/block/${dev}n${ns_id}/wwid ]]; then
-			return 1
-		fi
-	done
-	return 0
-}
-
 _nvme_discover() {
 	local trtype="$1"
 	local traddr="${2:-$def_traddr}"
@@ -617,73 +203,6 @@ _nvme_discover() {
 	nvme discover "${ARGS[@]}"
 }
 
-_create_nvmet_port() {
-	local trtype="$1"
-	local traddr="${2:-$def_traddr}"
-	local adrfam="${3:-$def_adrfam}"
-	local trsvcid="${4:-$def_trsvcid}"
-
-	local port
-	for ((port = 0; ; port++)); do
-		if [[ ! -e "${NVMET_CFS}/ports/${port}" ]]; then
-			break
-		fi
-	done
-
-	mkdir "${NVMET_CFS}/ports/${port}"
-	echo "${trtype}" > "${NVMET_CFS}/ports/${port}/addr_trtype"
-	echo "${traddr}" > "${NVMET_CFS}/ports/${port}/addr_traddr"
-	echo "${adrfam}" > "${NVMET_CFS}/ports/${port}/addr_adrfam"
-	if [[ "${adrfam}" != "fc" ]]; then
-		echo "${trsvcid}" > "${NVMET_CFS}/ports/${port}/addr_trsvcid"
-	fi
-
-	echo "${port}"
-}
-
-_remove_nvmet_port() {
-	local port="$1"
-	rmdir "${NVMET_CFS}/ports/${port}"
-}
-
-_create_nvmet_ns() {
-	local nvmet_subsystem="$1"
-	local nsid="$2"
-	local blkdev="$3"
-	local uuid="00000000-0000-0000-0000-000000000000"
-	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
-	local ns_path="${subsys_path}/namespaces/${nsid}"
-
-	if [[ $# -eq 4 ]]; then
-		uuid="$4"
-	fi
-
-	mkdir "${ns_path}"
-	printf "%s" "${blkdev}" > "${ns_path}/device_path"
-	printf "%s" "${uuid}" > "${ns_path}/device_uuid"
-	printf 1 > "${ns_path}/enable"
-}
-
-_create_nvmet_subsystem() {
-	local nvmet_subsystem="$1"
-	local blkdev="$2"
-	local uuid=$3
-	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
-
-	mkdir -p "${cfs_path}"
-	echo 0 > "${cfs_path}/attr_allow_any_host"
-	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
-}
-
-_add_nvmet_allow_hosts() {
-	local nvmet_subsystem="$1"
-	local nvmet_hostnqn="$2"
-	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
-	local host_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
-
-	ln -s "${host_path}" "${cfs_path}/allowed_hosts/${nvmet_hostnqn}"
-}
-
 _remove_nvmet_allow_hosts() {
 	local nvmet_subsystem="$1"
 	local nvmet_hostnqn="$2"
@@ -692,54 +211,6 @@ _remove_nvmet_allow_hosts() {
 	rm "${cfs_path}/allowed_hosts/${nvmet_hostnqn}"
 }
 
-_create_nvmet_host() {
-	local nvmet_subsystem="$1"
-	local nvmet_hostnqn="$2"
-	local nvmet_hostkey="$3"
-	local nvmet_ctrlkey="$4"
-	local host_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
-
-	if [[ -d "${host_path}" ]]; then
-		echo "FAIL target setup failed. stale host configuration found"
-		return 1;
-	fi
-
-	mkdir "${host_path}"
-	_add_nvmet_allow_hosts "${nvmet_subsystem}" "${nvmet_hostnqn}"
-	if [[ "${nvmet_hostkey}" ]] ; then
-		echo "${nvmet_hostkey}" > "${host_path}/dhchap_key"
-	fi
-	if [[ "${nvmet_ctrlkey}" ]] ; then
-		echo "${nvmet_ctrlkey}" > "${host_path}/dhchap_ctrl_key"
-	fi
-}
-
-_remove_nvmet_ns() {
-	local nvmet_subsystem="$1"
-	local nsid=$2
-	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
-	local nvmet_ns_path="${subsys_path}/namespaces/${nsid}"
-
-	echo 0 > "${nvmet_ns_path}/enable"
-	rmdir "${nvmet_ns_path}"
-}
-
-_remove_nvmet_subsystem() {
-	local nvmet_subsystem="$1"
-	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
-
-	_remove_nvmet_ns "${nvmet_subsystem}" "1"
-	rm -f "${subsys_path}"/allowed_hosts/*
-	rmdir "${subsys_path}"
-}
-
-_remove_nvmet_host() {
-	local nvmet_host="$1"
-	local host_path="${NVMET_CFS}/hosts/${nvmet_host}"
-
-	rmdir "${host_path}"
-}
-
 _create_nvmet_passthru() {
 	local nvmet_subsystem="$1"
 	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
@@ -765,34 +236,6 @@ _remove_nvmet_passhtru() {
 	rmdir "${subsys_path}"
 }
 
-_add_nvmet_subsys_to_port() {
-	local port="$1"
-	local nvmet_subsystem="$2"
-
-	ln -s "${NVMET_CFS}/subsystems/${nvmet_subsystem}" \
-		"${NVMET_CFS}/ports/${port}/subsystems/${nvmet_subsystem}"
-}
-
-_remove_nvmet_subsystem_from_port() {
-	local port="$1"
-	local nvmet_subsystem="$2"
-
-	rm "${NVMET_CFS}/ports/${port}/subsystems/${nvmet_subsystem}"
-}
-
-_get_nvmet_ports() {
-	local nvmet_subsystem="$1"
-	local -n nvmet_ports="$2"
-	local cfs_path="${NVMET_CFS}/ports"
-	local sarg
-
-	sarg="s;^${cfs_path}/\([0-9]\+\)/subsystems/${nvmet_subsystem}$;\1;p"
-
-	for path in "${cfs_path}/"*"/subsystems/${nvmet_subsystem}"; do
-		nvmet_ports+=("$(echo "${path}" | sed -n -s "${sarg}")")
-	done
-}
-
 _set_nvmet_hostkey() {
 	local nvmet_hostnqn="$1"
 	local nvmet_hostkey="$2"
@@ -829,38 +272,6 @@ _set_nvmet_dhgroup() {
 	     "${cfs_path}/dhchap_dhgroup"
 }
 
-_find_nvme_dev() {
-	local subsys=$1
-	local subsysnqn
-	local dev
-	for dev in /sys/class/nvme/nvme*; do
-		[ -e "$dev" ] || continue
-		dev="$(basename "$dev")"
-		subsysnqn="$(cat "/sys/class/nvme/${dev}/subsysnqn" 2>/dev/null)"
-		if [[ "$subsysnqn" == "$subsys" ]]; then
-			echo "$dev"
-		fi
-	done
-}
-
-_find_nvme_ns() {
-	local subsys_uuid=$1
-	local uuid
-	local ns
-
-	for ns in "/sys/block/nvme"* ; do
-		# ignore nvme channel block devices
-		if ! [[ "${ns}" =~ nvme[0-9]+n[0-9]+ ]]; then
-			continue
-		fi
-		[ -e "${ns}/uuid" ] || continue
-		uuid=$(cat "${ns}/uuid")
-		if [[ "${subsys_uuid}" == "${uuid}" ]]; then
-			basename "${ns}"
-		fi
-	done
-}
-
 _find_nvme_passthru_loop_dev() {
 	local subsys=$1
 	local nsid
@@ -924,44 +335,6 @@ _nvmet_target_setup() {
 			"${hostkey}" "${ctrlkey}"
 }
 
-_nvmet_target_cleanup() {
-	local ports
-	local port
-	local blkdev
-	local subsysnqn="${def_subsysnqn}"
-	local blkdev_type=""
-
-	while [[ $# -gt 0 ]]; do
-		case $1 in
-			--blkdev)
-				blkdev_type="$2"
-				shift 2
-				;;
-			--subsysnqn)
-				subsysnqn="$2"
-				shift 2
-				;;
-			*)
-				echo "WARNING: unknown argument: $1"
-				shift
-				;;
-		esac
-	done
-
-	_get_nvmet_ports "${subsysnqn}" ports
-
-	for port in "${ports[@]}"; do
-		_remove_nvmet_subsystem_from_port "${port}" "${subsysnqn}"
-		_remove_nvmet_port "${port}"
-	done
-	_remove_nvmet_subsystem "${subsysnqn}"
-	_remove_nvmet_host "${def_hostnqn}"
-
-	if [[ "${blkdev_type}" == "device" ]]; then
-		_cleanup_blkdev
-	fi
-}
-
 _nvmet_passthru_target_setup() {
 	local subsysnqn="$def_subsysnqn"
 	local port
-- 
2.45.1

