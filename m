Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011030.outbound.protection.outlook.com [40.107.130.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC1431AA84;
	Tue,  3 Feb 2026 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114429; cv=fail; b=tb+XDt0aLhMUq1Mf2VE65EM+BPAAqWWApQipeEwtpPdS/xOoZ9vOfzbqWu8Fi6gaQm8X015tWYVOqmf5eiWIB3mVFQLuZ44mr0aec4WNTmiYbxZ1L+FQ+fVnEwwtKemmt8ybuazrbtWFY3HqXONwNHRHZ6gNJRqpghu1ZGV7M1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114429; c=relaxed/simple;
	bh=IxcaP8LEVNRRP1lUX2sxnK8oxQ60GH196Kx99TDIUvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RVblo6N+8plyITD1OMZ3jNPdBuf8tyPI8hZlRGXvcRBFMbu6xBv1lpsEvmk5hjIH+YPlP5tayh41FdtynwTL0+gJUJCTyxFuzbV44MuPfQeGWCBOPaNYOClKYqWIvghBLUegYRNDmAIJni4/vlg2ZJJwJ0tD0PGUIfIrod/4bCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cYjhTQkt; arc=fail smtp.client-ip=40.107.130.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cYjhTQkt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNKPtqdw0cl8JR1KgOPdtrrxUNr8HfZYsIX/FlxBAdKfQZ119lKByzXdhbcV3DmlAQhL0wHqY6WLmtxqmEL/EmPUDx+S1zvWhb5OajvisDGXvquB3DV4c46jvrOENXg21ANgNfbgNYy638fc8/7xOkmR1W8PPhbV/F8hLvJ+cau8sl1bAvqtdAh1jLVmtfGc3cjQmP2jDN0j7XHWu42yG+SRsvbdK6mcYFGz/RnEbIkeCJaW+VJW41p9w/1nLCdGWf5dh+5EmkCdWgIJ+eXF37+R6gFRceHGWvdyG8rXh63eXPVf1jn6m+k7aOy92IrfnOAwrL85XDCTg7UGlngN0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLa0IjxI1yM3LLdIxlkka7kLwtJeh/h0xCIjf724uvw=;
 b=KKxjo23nUeEOCo+AIYHvKnJYQ/euoBXJcwnMM/uysfif+axex2mWu3Y7aQs4XyrWyPrtuO9MYR0yXmZx3u7bPPvkwNG1QUGMobGaSz1INFb+ZjVSA01RnNqHFoX3s0bParyIDX0m5NQZO+EaRbZTJDL8RExwqs7Y3kzjZoogzrT7gCNR2YmRjQbqKd+i+t3SQ++jMJdi0YoPgv9z9oeoemXCP3oajITBREHqrrZp2rvFMzxVsXVyWqY5cLZ1UyyjGtx7DkvnZFaAby2StcKmNcL2/LMt7vkf3R5DEyfSOnzyxfgkRFbOAv58sJtVKWTcg8ZhBVyPWZdRk0HdRJSLmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLa0IjxI1yM3LLdIxlkka7kLwtJeh/h0xCIjf724uvw=;
 b=cYjhTQktGEa6m8Ts7Qv4M0K9yZD4Rs/v8PPYv0xY/+5edijJ2VutA41PJD8EzbGAdNcnnfQjaK9tZDKqF2623NSK/XmTDoA8kIy+XtFgYirEUbfRXF7ASeXSy7xB4l2uFmXjiBkfudw8yXQ4TNnz8JfgBJutVqDFhP9wBFUHZMkm830U6nfzYn60brTG4eshL415pt+6+HrZ0s3BwROK9WAzH08pWvMuCletZ1pANszOinWrDSsWoJbvOgeUiOJd+qhLt5GVJM6WWUoMsN2QMw4BxOK2GLhD5RQ0vDpYW5h5VMOfWQi5sJ2LqKJGpKqPtGXpNafi+lMqPo1Xte8yTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by PAXPR04MB8720.eurprd04.prod.outlook.com (2603:10a6:102:21f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 10:27:04 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%2]) with mapi id 15.20.9542.008; Tue, 3 Feb 2026
 10:27:04 +0000
From: ziniu.wang_1@nxp.com
To: axboe@kernel.dk,
	ulf.hansson@linaro.org,
	hch@infradead.org
Cc: linux-block@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v3 2/2] mmc: add quirk to optimize certain Kingston eMMC secure erase/trim performance
Date: Tue,  3 Feb 2026 18:29:03 +0800
Message-Id: <20260203102903.2953660-3-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203102903.2953660-1-ziniu.wang_1@nxp.com>
References: <20260203102903.2953660-1-ziniu.wang_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|PAXPR04MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: f19da5b4-b510-4062-836d-08de630ec62b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7EBAE8j7Spwg7KUDQGFTBQrLeH/ZPh5GwZ0jO+Re7vOHn7y5Z9M4Ep54O6EK?=
 =?us-ascii?Q?uMw5sLK+52/hKxRgN2hH8oTLYAyJWyf4KbM8K4jMjADHSYyfZBujASZlQXwI?=
 =?us-ascii?Q?uff6fLtaX0uHa0ejHWK7x0xgD54kCMl79BE/HsFmFmGgpdSm3FSuQjKY68Vl?=
 =?us-ascii?Q?cQfsp4uDyqpUkzs6CDFyzZ8RP/F0IbhZ+CROLpLPgXGTUfLO03WR/6jq6YFm?=
 =?us-ascii?Q?k8vx7sKqkT75I1wzPEh7C8vvxNoOGyMdfn3A0zLK5LjDP4pdNtJswJdt0JDf?=
 =?us-ascii?Q?Fr8VBB8FyA2r5yE9Tn2mc+Y+TRH2DAeDhlQR3FCZ6LsEhM8wF+jN5mdDveLp?=
 =?us-ascii?Q?oHz0/FMgPqrOHEtxk9/IeqRXc5xOwa18k2qGOSfOgsE+k8MMH9U3UtgcuuOF?=
 =?us-ascii?Q?wh+LbiCPyNIrbRx78kpDRxNg7/j2PqKeBiTVh46UEIGUYtogMoF3LfuW4+Gm?=
 =?us-ascii?Q?5VWESjhAmTTgTh5hhtEkBXv6ux95JzEok6/jhr3u3YIU6gOQ9iuCteXxgmJw?=
 =?us-ascii?Q?+++/DOsX7V046BRDnLN15/2XNKSQMdYvLj6J0OFtXgflS5PP7y9lMz/AAWZ6?=
 =?us-ascii?Q?ZlnV1Hfv0XN7XdbLpfl7l1UepAnNZBfnLQRTRHz6W0hTqOoegU4ekGg6ciWf?=
 =?us-ascii?Q?BnZv4OTfPezJlIUE/xZRXHdyUHwQkrE6mTVJ7j7taY7fN5CENQUfvnLV5ZIZ?=
 =?us-ascii?Q?yqaZvtNL1gEFOUsc4mUuQRI2JqDlWjtU3/yOgn/jWlUqH0gHaW5KH5gEXV10?=
 =?us-ascii?Q?hQ+olojQOCKhElMQv3vAYGEALmH3AATkHmPZ4y7MrTHG1pL7q74QhK+BJ+hK?=
 =?us-ascii?Q?ERVUlRA7HyGdHbmPlyMZm0Pc0dk4q31QQj3W4YFvWjhQCTSRM/t4NORp7jfL?=
 =?us-ascii?Q?aMrczKQK7DghWFRZ+GPMsuiZ1yyv8AqLqdj6hKysrBpYoMwlJO+v5K1Ej3oa?=
 =?us-ascii?Q?RK+HZStZ0Zeul1MnW8vm6AeXK0jaJ9GKu+zirz0UtIB2D6pjIMbH/dFNrmQe?=
 =?us-ascii?Q?Uynkf1eGLwyrFNR7TJ3wPDcrohFQYh4mIs/K38chotR6V8bjuPTou/wVx3Vj?=
 =?us-ascii?Q?b022WNxo6OMhWN1lzIUo8nv8Crvrp0fEywy34WjDo3fgMk7Evtj5EbM4fHl4?=
 =?us-ascii?Q?1wdDtPV7jIzcZbW9PnCwm68FnzYeSf1ZRW9jHjjTJcMaZMgUiAdyzLfdIclr?=
 =?us-ascii?Q?OxV05e5xgPHM9rXseJ+RCe5cCxXgCpmWwyVnrXerZGn9JOn9NanLHz8GyFNj?=
 =?us-ascii?Q?2ZQYHPC/5sbhk4frtPA8NAyoNjub+VpWyl69+CNYjpIzhOAGN5F9GAuCGtIZ?=
 =?us-ascii?Q?GSN//gY9l199SHFdKYN8TTvEy4iZW7OYzIoFLOyU5JXt2PwMz1UAUlQ2Kg8t?=
 =?us-ascii?Q?0gkVOjJjtC0mtRgu2jzgFmZErxTaHDY2HSMk7Qjm5fLzwmPFAMSi6SRNXYvv?=
 =?us-ascii?Q?+qfvBB7SfXF0NIwPVSu7NfW75ggVk4C1TG1uXLdS/fVIQBWAs4uiwse7y7Eg?=
 =?us-ascii?Q?vMk9OK8p6HdHmi7O/4HyOEYSRoFT//pUI6WBhzM84XyzNx/67ktW28r3a/wP?=
 =?us-ascii?Q?sJUWl9ztB0LOi7EwWsS4u89SrvT9HV83yOhnDKvsgsw8LsjPq19T7p6TbXda?=
 =?us-ascii?Q?hI9dcRo/iRVMbTRip3aZHWM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vMpMUzmJO6mf/B6cVHlt4vwP0m0GH/thbCebHgclSfFY4VWebNUeBXKO1CLz?=
 =?us-ascii?Q?yAT5zYRSjFkPSZpAcuSe8u5PL8GkGq5laWKJmHiVIjgs9Yo/gDZgCrjD82ul?=
 =?us-ascii?Q?8x0AtsFBJtRa0I+FruTcZQsgqJs+S84z/y9yRbpRfcgTO6xF+iKL9qsRMBqB?=
 =?us-ascii?Q?Dg9QEBmW2BXG/RjAiaGUI2pVOpA6h19UWZWxEbCypGuHJJzEyJ77SbhI5dER?=
 =?us-ascii?Q?SUDvrdQi92HCNRQZc224rBdHDd/mLjbIsfVl2tfnS75PrNpycvKmsO8B9Wp0?=
 =?us-ascii?Q?pPlxHJvZdFyL3SVm6EBzSmiJYzFugNE1Msg2nHq0DKUDS1Vqj9LQJ0EHzgLO?=
 =?us-ascii?Q?Lvm61hp0rGkqTGFeBwVH1DorQ6w2jRNOiCQ9p1FKOVp+lZdRrX8cZ2MCybxT?=
 =?us-ascii?Q?QRD5djE+GdHfeWmAmlWWtnibPILkSUdnDtfIah+lcdekw7Z6mWtNUY94HHbT?=
 =?us-ascii?Q?YnZbORRqv/Y/Z9DdPUaYooOOFDg9nr/or8aE4lFX9hWgYai5FSPqsH1lJewW?=
 =?us-ascii?Q?Rb4+23rN+OLzmOVO8bhMeT93SflZWEizWd60sfUOtbO635Tui5HwjiuMhELo?=
 =?us-ascii?Q?wtjtmNGcrlARrvVG0izG09ICSNNnMNCf6KUb51487cqAU2rzqo9Qwm7Zw4n9?=
 =?us-ascii?Q?dWEMLSzM6lqIWVRCQp1PlYNk78cVqwSApFYyzPDb00xN86M62n7P+snzTFT3?=
 =?us-ascii?Q?skiInAOJmTfse5GLJpYqgxmqaPbmunnyISW6uSq67kqs+jZb3rEb6FAm3Qry?=
 =?us-ascii?Q?q/2w5ya+hjKsJNBlFk+zE4/yIWFqpckjBvR29XLUKDYN2wm97Wom2f9k86IP?=
 =?us-ascii?Q?uP1ZYSm9bbCaS52RjbDt+QrQCUDDEO0oBxj75bgsrrnBOOoXHyEq9u2q85Jj?=
 =?us-ascii?Q?jNM+5Cvd+tspFv508eEBo0uCzRrxc5nENAhdIS9SVMvwNev2CIWc2ihgOYug?=
 =?us-ascii?Q?K4V8Pq+upRUhqaqOMR3kFkuwY+gIXjhcRxKn5nVwJaZXi2ioJ/Vr95v5kUUw?=
 =?us-ascii?Q?nxXapIan4KVMj0IIhYITE/58ubA+jkGf0/rqODCJ9gzioK1pl7l3v+RgUkVT?=
 =?us-ascii?Q?8pPE0kUGfqCn47ttENjQuk2Sb3I16Zgt0nzQtK9OvSDjkyr5sOHdbjnN8tQM?=
 =?us-ascii?Q?NZfgwcD3akfTuiXN4HJKanmeBGzB0ojPp24k+cRL6rRn+Bx/zYwF/x0b6xHm?=
 =?us-ascii?Q?YVJcQbYLWEa/YgxXZsabliiE+LD9ecrJMiddZmA2y9zGglYhK7IW7btSBCwy?=
 =?us-ascii?Q?bYcL+kW+zVAKH2B+/G6BpnNwvLVplLDdbTdCJl5hvrO2ukCJobTaTXsEO4En?=
 =?us-ascii?Q?/fQnToiMxCZ2Bs4uKcQFsWg2efZAJO91W5GRnATtx2l22fx0UpHWsUVsxloi?=
 =?us-ascii?Q?j/sOByyt3MzMZNFcivKuOJZiV+4uEROJGW5vKC0IaR71KX5hPZlmzJ5G7XLT?=
 =?us-ascii?Q?oDwK9PpIdLXy9gzkZLz1B5Nqz9P8x7EB2zCxu6F6fZEKEvsdAg7LNR2pU7FZ?=
 =?us-ascii?Q?X0zfo1cdoZB9lKY59a5NpEESFxsjRtV8aAdm6H5lK+vuEEgciKLVz94zqyKT?=
 =?us-ascii?Q?gBb9HYz2/tY4UJsmvW6TLIHMgiJmFGT2LzNYSvVfTYw3Qr+PqyU/K36zAoAJ?=
 =?us-ascii?Q?IWFzZf0qn7lbStYprSd6L8K6QKenn3q0RMNvdCzfQ5Ek21oBHWBl9sba5fYl?=
 =?us-ascii?Q?5ee0fIJS2X0MWmAMWByZKJIDOB2np+DgOuHqw16bGzo7/ioON+J8WK6fvale?=
 =?us-ascii?Q?lcF3dC+IOw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f19da5b4-b510-4062-836d-08de630ec62b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 10:27:04.0952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0h1W6ygDX5Ht8SZribz7ktdC+J6YygV5olRdLvRciTDOAgOMKzZOfzDl39hKj+90bOQYDkBqneia7ye0CfKZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8720

From: Luke Wang <ziniu.wang_1@nxp.com>

Kingston eMMC IY2964 and IB2932 takes a fixed ~2 seconds for each secure
erase/trim operation regardless of size - that is, a single secure
erase/trim operation of 1MB takes the same time as 1GB. With default
calculated 3.5MB max discard size, secure erase 1GB requires ~300 separate
operations taking ~10 minutes total.

Add MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME quirk to set maximum secure
erase size for those devices. This allows 1GB secure erase to complete
in a single operation, reducing time from 10 minutes to just 2 seconds.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/core/card.h   | 5 +++++
 drivers/mmc/core/queue.c  | 9 +++++++--
 drivers/mmc/core/quirks.h | 9 +++++++++
 include/linux/mmc/card.h  | 1 +
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index a9619dd45270..a7c364d0030a 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -311,4 +311,9 @@ static inline int mmc_card_broken_mdt(const struct mmc_card *c)
 	return c->quirks & MMC_QUIRK_BROKEN_MDT;
 }
 
+static inline int mmc_card_fixed_secure_erase_trim_time(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME;
+}
+
 #endif
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 284856c8f655..eb1053d8cae7 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -184,8 +184,13 @@ static void mmc_queue_setup_discard(struct mmc_card *card,
 		return;
 
 	lim->max_hw_discard_sectors = max_discard;
-	if (mmc_card_can_secure_erase_trim(card))
-		lim->max_secure_erase_sectors = max_discard;
+	if (mmc_card_can_secure_erase_trim(card)) {
+		if (mmc_card_fixed_secure_erase_trim_time(card))
+			lim->max_secure_erase_sectors = UINT_MAX >> card->erase_shift;
+		else
+			lim->max_secure_erase_sectors = max_discard;
+	}
+
 	if (mmc_card_can_trim(card) && card->erased_byte == 0)
 		lim->max_write_zeroes_sectors = max_discard;
 
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index f5e8a0f6d11b..6f727b4a60a5 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -153,6 +153,15 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 	MMC_FIXUP("M62704", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
 		  MMC_QUIRK_TRIM_BROKEN),
 
+	/*
+	 * On Some Kingston eMMCs, secure erase/trim time is independent
+	 * of erase size, fixed at approximately 2 seconds.
+	 */
+	MMC_FIXUP("IY2964", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
+		  MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME),
+	MMC_FIXUP("IB2932", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
+		  MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME),
+
 	END_FIXUP
 };
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 4722dd7e46ce..9dc4750296af 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -330,6 +330,7 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY	(1<<17) /* Disable broken SD poweroff notify support */
 #define MMC_QUIRK_NO_UHS_DDR50_TUNING	(1<<18) /* Disable DDR50 tuning */
 #define MMC_QUIRK_BROKEN_MDT    (1<<19) /* Wrong manufacturing year */
+#define MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME	(1<<20) /* Secure erase/trim time is fixed regardless of size */
 
 	bool			written_flag;	/* Indicates eMMC has been written since power on */
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
-- 
2.34.1

