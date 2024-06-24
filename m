Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2127.outbound.protection.outlook.com [40.107.6.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F416136E2B
	for <linux-block@vger.kernel.org>; Mon, 24 Jun 2024 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719226006; cv=fail; b=Y2/h4q/7mjAu9T1CPCR9ztWFWM87q4dE9Brfz4NgD6ZdaDaNKFCTo5AtUsG8Uw83drsD05cJT/K3HRGyHbiLEyVmZ6FtS2+IOMEVQ6+kyKi2dewt4BHsJh8lPAt/aynd66uQLmOhiPGWkEtCTtR0dhvVNZ6IhBZvSY7aKTqe6mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719226006; c=relaxed/simple;
	bh=ks4d5n0+2R63Dhvg8e5zwo2To865hCAmF3PbhNmDM78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iAdvoTR3pu+dVq0FX19UxFioyizY704N38DKkumYb4GGqK0wdlyTwXUPguSRpBGkqq132g5vUPj558fuzcJOsbP0jCyGVAtIzYTc6kL5OSRuDYWoG/uOqkpaFYwO3RwTxLb9ienWnfIf8qd063oM2KZggnlfuE66+/PHnFXfRIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com; spf=pass smtp.mailfrom=volumez.com; dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b=AxD3hyp6; arc=fail smtp.client-ip=40.107.6.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=volumez.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b="AxD3hyp6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iO13R7GA4Gm09hPFB5YP8qRZ9+FSCbIwn2Uukup4voZr5t/h6m49URqBemF8TyDXQZrKANNw8ks6xsurqWPAHsCpcjdr0TKVw0QEFJyUWl7ubmIRz9C6uhDbO8rDXxrhod4SqnifV9ixfS9hoRtGw+UbxBXU+2TdPvGo+5ZWJJFge9wSueUX9mSMNP0gr5Ioh+/hrpXsJGXr79QkrKpNjPne//oD4IxJrBGEFbw/qG3RBonxak6I7RYiRzijkxEiegAPIg4aPhMgelBCSCp0/4wnZg/vWduzuF+6etquItg+pglwRljbY+DsitGcCH5buP2PQJdYq0DkXl8wQJ3hBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KdVz03msyCfOkUJ0g4FBQebCtqvHvDVHs3LCeek7RM=;
 b=lBsPUgawfwxxKY32ZvmE4fyC6haIslRXDaow1dCO9k9vtnAhZIowDdE9N6+WK1TfC2EKysfNnlLkLXvDJVBao/5vA/IfIel7gevuFN+PT/aU8cfgahjEJe6D1hsVRMCb7STiDH+JoXtVgiwTw47GCmEWinqhUxb3mUQcWcYzpz58I4gvUSv+V7KxF0MVyzhB4pXJnA2fumzyZKq6G6F1jkMQjSJ3i1M7Mxseyfk+f2V75+RPq/Nmr0clGe+QC29l4cCwRWK+XGIQP757jhKPXXmGcmg0Yv1a5aZkz8y3CEJAnVZ6Xajafq5V0OUahYUizyiOlAxbJ+M6kvYezU3VbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KdVz03msyCfOkUJ0g4FBQebCtqvHvDVHs3LCeek7RM=;
 b=AxD3hyp6PW9wMN6X6btqUcgQkadnldscf/Ndtu4Iusc80UOB5yQkZerEVoOc8di4z5u76ZxSTp7MafckpHbV4TcuCcFirmX142uqCwEDAXMz+TqBljxpuX1ZLh8/uIkH/4677jSAPxoJxp/BTnQ2KjI+40bi1cL6KmyS0vnERwvLa9kJw5td2N3PaH9v/tv01Xf3yMTsLQIuII1XlAUE2MM1OYIq7lt9+frt4U2vnB+ni85blpEdsErcPhCZWGmIBlXHb31qMd5XdMlDacKupbmTplkzN1tsClkCHPvgrBGhb9VT8bcevrPHRwuQr6Q9ZieJgJmh0Y1sgOBLwBO9MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from AM0PR04MB5107.eurprd04.prod.outlook.com (2603:10a6:208:cb::11)
 by AS8PR04MB7605.eurprd04.prod.outlook.com (2603:10a6:20b:292::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 10:46:31 +0000
Received: from AM0PR04MB5107.eurprd04.prod.outlook.com
 ([fe80::de53:c058:7ef:21fb]) by AM0PR04MB5107.eurprd04.prod.outlook.com
 ([fe80::de53:c058:7ef:21fb%4]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 10:46:31 +0000
From: Ofir Gal <ofir.gal@volumez.com>
To: shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	chaitanyak@nvidia.com
Subject: [PATCH blktests v2 1/2] nvme: move helper functions to common/nvme
Date: Mon, 24 Jun 2024 13:46:17 +0300
Message-ID: <20240624104620.2156041-2-ofir.gal@volumez.com>
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
X-MS-Office365-Filtering-Correlation-Id: d5b0a5dd-8608-4441-df91-08dc943ae89f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021|52116011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YGZ7arHcZ2EqpALEDpw9lDSxmXXv26vvTPBPBsENNzgggWgTmzbxURSGRKR9?=
 =?us-ascii?Q?lGwjj+xXkv+nsda/z6Jf8tUbBCl5Wcz0i2B0MZT13/Xn0wfyJB1Ix8/9HFdt?=
 =?us-ascii?Q?FTM3ry1Twh0d4nxez1jEC51EcDG8RCKjNdBpaOyfVXGAET/BIklaKJ5jUZvW?=
 =?us-ascii?Q?8gkuTxgc35rM4Nve26FowTvAYAkWsB9lHY+xUr6zipc/bMEEpUAOOxxi/Dqq?=
 =?us-ascii?Q?05oQI/X1Aw4+HJdBflBNR2gf2TndBupVM0nXvbhwQoB8/oL3Z0BAqVp2my/g?=
 =?us-ascii?Q?vYbNMghas0dm2c6xFUY4ohI6LzOMerL+bQkc3+oGCM9UaJTun08wxrXcDX4r?=
 =?us-ascii?Q?gfFk3sdjX5LgugnS7nmEZTrc27AWpx0aLpD5BScqeOJ+cyyaub22eYwPFQmq?=
 =?us-ascii?Q?BxGjlr+6OVuKIuz6OtTTjNNAavMgHXWOyOk5HHfofur7YZW7DS02cgyoSocA?=
 =?us-ascii?Q?8LJTxN0HTtS/WloUR2UoMeIhMStFgy3baRN+MyKZLESCToy1fw2zr+ffOcPF?=
 =?us-ascii?Q?PR7aBPNF05B54looZMp3vgOzpZuJadrRinZJWLVlhUoSJNDHX1Y5qaXRj9Fx?=
 =?us-ascii?Q?njvlP48bhKAR3GBxto29MoqBCpTMYmILTxIHS/Tpm93UPy4rVk7UkTWz7ky6?=
 =?us-ascii?Q?ed3u/Zbl6m8NPLsk6kQO8813vBySFlFD7NAW3iW+//WWw1AsBM5LVSj3LnH5?=
 =?us-ascii?Q?By+YypCE1vewbipsxmJXbobFeJ3A67b3biCTk68ZZXbK84E2aHRUPnwVkLal?=
 =?us-ascii?Q?NfiA9eF82h598JQ/OWKfyY0z6PfzUXa7qykVjkC5LqiJ57m6k53l56UXoz3s?=
 =?us-ascii?Q?AUCy0ulEMnvKWK5SJzO4Z6lGDMAA3fImpAvdaZzq/0MV2RbRmDPS/AtRGeA8?=
 =?us-ascii?Q?EXswu3+6bzaBNJkbBWHDqRwS6YimXSvWWVubDVq24sFVETU08q6zhwxFPMky?=
 =?us-ascii?Q?5xQS5uNrEQpjbMM+D+Y5wX99y84qd2Y6uFZeHCFaG1giQqfKlH7VcgHnuBWz?=
 =?us-ascii?Q?QFV+a03p9B9YeMu0Vqo9HpWrSUpIbgQyKfsqU0A1nxMfuv2qpLBUBrq72XVs?=
 =?us-ascii?Q?8nVcyge8KCeOu7wkBIHgOVhpZg5A1RcOb+uxLZc8tV1t/XK28N0pmUEJbzJ1?=
 =?us-ascii?Q?L4b5LKRkvp4vlu1ZgCReFASC72TqBNrAKfFw24T2pfHgLgYjYiRczRQfJjSn?=
 =?us-ascii?Q?AhbpCLG7lw0UAM4i0QcpfzRzI8++z3u1ar40R/a1Hlst2ZhoorWJORCftQ7O?=
 =?us-ascii?Q?DLAtWlvOQ59Dexxjb8S4lcB1+9T/yr/FKY7JHCwDkynjNtyL5+DITrcvWbXd?=
 =?us-ascii?Q?+p4tblqG4mSpLR/EOBBg9stu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(52116011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ox3bFLSFBIGsT7B3mxtkLMe0OpUVLpn9QonSZOi+644Ft+0LKNFoTGnHfDlM?=
 =?us-ascii?Q?RuQmp5+m/oi3bHCs6+OoyI2T3KCKzsup2oi2ElbVRp82gjsxOuE95+Jdy0Kg?=
 =?us-ascii?Q?fVpgjFzEq6sAhoDf0zKY1jwRq6jpJHY+GKWTiKMsLLo72YUcsmiWb8T1vuML?=
 =?us-ascii?Q?yy3rw08nbK6qOkwJ0RaBA3MfnQ78d7KBHKd+ULa/xNCLMWJPTLr1NZw6HmkO?=
 =?us-ascii?Q?2MVDWVq7ogsxcCAxZXInSInevPrkiOcxvUTzkwOEkPdmO85uTThAMqP9NxcL?=
 =?us-ascii?Q?lINYH2s7yzg39Rjpgs8kR48y5wLpD/KsUpeeR/o4tG/m6tI6FxM9sxuOl8zY?=
 =?us-ascii?Q?h8tShbEkSM4G4dRR7u1PSySMRlK/3CjzrWydlOnBLTqwdBcUjqwtk4KvcsA6?=
 =?us-ascii?Q?vIbW0KGubqOLLO4DvlDcCaJ4FSLkiL3Y3V+C9jQF7rvOPetebIYUv2pe9G5/?=
 =?us-ascii?Q?qBIwUHoWxh5O88mciDAeNxUMqgdVZyihZSQ1TDHC6079/DORXqMlWxjch3Yz?=
 =?us-ascii?Q?UwfVosgf/2Q6zvow/VAyKZeBiw5i5vKGv96MfRlqKj3nXyqJdC6QQptWG3te?=
 =?us-ascii?Q?DOATuT+/piR1gEjfdvWuw92bSMcfW2ezG9114Lwhztemml45WdLvIoHu6c7w?=
 =?us-ascii?Q?I6ttGtQrelF2WRQs58uyghHRpOEZ64IKRpc2hxxjQJdz/jUAp7XstAS9Giu3?=
 =?us-ascii?Q?ZxfcFjYvRrOxB4dKqfzg3JchRQstNqK1b/JMGmz2lnE0JSEdTPV+GyW9bySP?=
 =?us-ascii?Q?XCvW8wurf6hVlvslk2tcAJxn/fRMGvsJcO7dUvZ/IzpdKC724ZYC3M05FTFb?=
 =?us-ascii?Q?bYP/4XN1WiV90BPQ/Wykvc78lqFyzFtrmFxz7iGV6M9TLlYaukYBTwdNZ37F?=
 =?us-ascii?Q?1zz9JOGh4iAzZHhV619oguEVYM5L2JUDT9PriTuUcOMXbrflE3LrHBMmTADq?=
 =?us-ascii?Q?4sUt3J+LJpcH6dt9ySsujnZkgn5cIKnY++8Pky/7s64nukcPhuFulFXyQC+R?=
 =?us-ascii?Q?U37HtHzAIJuxTt63pweu8b3Zw4MA/CX2u9GIPaKXLl4gheqoYdziDw3tXQWE?=
 =?us-ascii?Q?DRLb30imcaapGBbrnBf7TvJYNXzgMhbhRqJYjz8PoRsBSQ1d94QXs/myB4yM?=
 =?us-ascii?Q?/eygQusMsOv85M22c0T4r0/33O9UzwUYZ8kkRRDph6fnLte119gYstyTz50I?=
 =?us-ascii?Q?zDGq4vGKzxn67Vten7zF0A6RebaWe3z1WY1MAjkqhsH/3SqsmejIJlq8+wBu?=
 =?us-ascii?Q?kDe51bNnFXcMoP6PcbLVlS7PJK/oR7GfiFywj9wxXZ58Sg/AKorALaRQX71C?=
 =?us-ascii?Q?gp3UgfJ/Wo/4EUe2Sy2jzxzhtY3s+2qp5Xix0nDK4UcBfApX8aTAx+1llxVW?=
 =?us-ascii?Q?JmX3lnZUr85HOyL3/vZO9vkz92FuiHG3k5zOqA61xW8a9BH1UGN8RPEgWeGJ?=
 =?us-ascii?Q?7sQ1JhdmAGRjI+WAAqngCZhyOVKJcTwJQyAWebr1LRNXpfQbsJvTOFXdiari?=
 =?us-ascii?Q?Uo6Gg5dWuBOKHvUQaNMrRYIG3+fkqjNKbCoBfT984Hb04kolJX5qZvMonEQB?=
 =?us-ascii?Q?oefsE1VDtpQm/h/ELTBzdGAyCTco4Xf4CO7INRWt9dPGBz7wzNBgxW0Lxvuv?=
 =?us-ascii?Q?ZaDqTPMrsNtNZ+nR5Hw8OZZhjhji5G01vkF7Ec4ElKMb?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b0a5dd-8608-4441-df91-08dc943ae89f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 10:46:31.3229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJPaA3700ngf+O5KeNSvck3tiP65Irc1cwAith+sQJ9JG39t3S24QpHs5o4L4IfJE0yQ4R8cWMpWNcKk61jsBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7605

Move functions from tests/nvme/rc to common/nvme to be able to reuse
them in other tests groups.

Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
---
I have moved the function that are nessecary for the regression test I
add. Let me know if we want to move more or all the functions to
common/nvme.

shellcheck detects 2 new warnings:
common/nvme:35:10: warning: nvme_trtype is referenced but not assigned. [SC2154]
common/nvme:234:11: warning: nvme_adrfam is referenced but not assigned. [SC2154]

I have tried to figure out why but I couldn't figure out what is
different than the upstream version. How can I fix them?


 common/nvme   | 595 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/rc | 591 +------------------------------------------------
 2 files changed, 596 insertions(+), 590 deletions(-)
 create mode 100644 common/nvme

diff --git a/common/nvme b/common/nvme
new file mode 100644
index 0000000..1800263
--- /dev/null
+++ b/common/nvme
@@ -0,0 +1,595 @@
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
index c1ddf41..3462f2e 100644
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
@@ -235,216 +186,6 @@ _nvme_calc_rand_io_size() {
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
 _nvme_disconnect_subsys() {
 	local subsysnqn="$def_subsysnqn"
 
@@ -465,141 +206,6 @@ _nvme_disconnect_subsys() {
 		grep -o "disconnected.*"
 }
 
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
@@ -617,73 +223,6 @@ _nvme_discover() {
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
@@ -692,54 +231,6 @@ _remove_nvmet_allow_hosts() {
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
@@ -765,34 +256,6 @@ _remove_nvmet_passhtru() {
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
@@ -829,20 +292,6 @@ _set_nvmet_dhgroup() {
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
 _find_nvme_ns() {
 	local subsys_uuid=$1
 	local uuid
@@ -924,44 +373,6 @@ _nvmet_target_setup() {
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

