Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013062.outbound.protection.outlook.com [52.101.72.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F651207A0B;
	Fri, 12 Dec 2025 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765528325; cv=fail; b=L3BgVP8nty+jVVtGp7asDJuDqysTmIyZcxgxq3xo4MHXtGw+jInxWGOYgM6/alHQlppSKYn6QAnct49yQzWfh4VJtPh+zxSUbTwbgFUNiTX+JDFS1lB53AGploKSIKS96nZvGpCXUWzB8jLR9Cxr70lRiSK/r1mdjDDa8p3PT2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765528325; c=relaxed/simple;
	bh=/fwENXuOoRl23fxoZ5Fy8l7qWg/uoTf5yCuyrjNg9mg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hMAMWbf1Ut0oBGzXWLR+UyuoL9EJBdU9GwqBfr08gftk/A9zo+R9Q6Sk0eHmj1/tenBT5+c7voJ6eyVZOOb1wCvXgTCkzrnZy5Q9vSqGGE1NRbxtNGeKaJoTkIlg9K6SDIjHZJLP8FWSRmsrdNl4c01XU5pof3eYTE3pkXfThRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YmtXi4la; arc=fail smtp.client-ip=52.101.72.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YmtXi4la"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULc76ClozAVxWZIud1llCPWd4LrE4RAzLo2X9GU1jxzecuilxZ/ah/PF9XNt1w7tTRW3MVd2nJxVWn1RCe3xamXCP/8NZEebHAL1W9yIEYCG+m70fI9Ziv0I6d/JHgC3HHgMA1Cw73xCC8sPubKhEf5pEg1fRDJIPL7hl9Eew7bN1fqwXcNRfgZ69paESqae27sEs3+o8fOQXM2SHic2pr59GHzLcAUWSahmJc3ry8CC62CBtVgrdykw88T5uvZ9MCE6iLDRtR7UZL0Xbyo2G6sXcMb5FySRbIsq7+S4RciRb6XAQlJFfHsZqBXrjtx6HuqZnkNFdOF0vkbNXzP7Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmteFQ6S27cGTR9PUEI3bX3XZ12cN3CbyeN5jFXRl5k=;
 b=NJj+Cuxnvrh0T0ZqU2zfRUMwT4lzMX8QhdOOEyrShX3FeCGlPAtmnPljHk43myhjKAyA18gO9aj5vWCTtyLqeitVIgBeXPZZQFl6XkempUnWjpzlzpKNfqvtX229g2S/zElI1+LlRYFlzocGbTwyTOXYLce2UWdCf+nCW/fJvt2I9QZsX/ydy54qbV517l7lVifK0ZcmHbaisRO06rT4KDHyMXJrfL48PRLFhysdYTvZME2jH24pxuJS9iBhSYFR79+4LeFqjoHes3pHYIjuGWbO6KQVlTrUnA21NDibJpbMm0mETHx5iojWMdo15ITfINzPN6i6eCc9H0jdgU458w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmteFQ6S27cGTR9PUEI3bX3XZ12cN3CbyeN5jFXRl5k=;
 b=YmtXi4lafMtMbYK1PlqjfyfBbVvr8XIjjbk554h7x5G9ij3alVLQsea7qpaQyA/E7+MqwyuUXz4nk35wLT8uMOjCg4Q4fmx1G+2vDC7k1KD4SZXer/qQIoEq+2eML6245E6IOS0RemBR16OK6dFS2xPE1y+I4ewpdykhtneK6bH9HWvHLnHHUpZUpdAQZXiAp0aLCc2YU8H4+qNk3xZClS50fyJXSZh8DYwgwCKEQtleuFoCHkuckbkxxWI0clUGg5LZlhr+qqONx8TsmNsLOLNkoKKD4AkiO8UiLtxoDkcz1j5aMpj4Q8hNwVDJAKw1vMxLAIcWG9k2QpvNjJbtIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by AMDPR04MB11556.eurprd04.prod.outlook.com (2603:10a6:20b:71f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 08:31:59 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%2]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 08:31:59 +0000
From: ziniu.wang_1@nxp.com
To: axboe@kernel.dk,
	ulf.hansson@linaro.org
Cc: linux-block@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH 2/2] mmc: add quirk to optimize certain Kingston eMMC secure erase/trim performance
Date: Fri, 12 Dec 2025 16:32:46 +0800
Message-Id: <20251212083246.582806-3-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251212083246.582806-1-ziniu.wang_1@nxp.com>
References: <20251212083246.582806-1-ziniu.wang_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|AMDPR04MB11556:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c6e944c-1905-40d4-742d-08de3958ea7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/SjhlhMyR1aDY8M7u2Jm6D0qkP0NU0QZnRlnJhFrbNLpKBUjJ5cILsiB2Zid?=
 =?us-ascii?Q?y4fsg+4ZRIkczVOg3i71ChZQI+ym0x0TBc0kvfFyVady8NbUAKIcRhwIVehS?=
 =?us-ascii?Q?NGatiWjaJY0zdNvLMk7ht7DpYj7NboBHVvenQA/sdEoW/rXXW3wd8TQ+1uB1?=
 =?us-ascii?Q?yQpiB50TYLt3cqdylkDfqwj/tYtzmFhuU4ysY7VglNtmmptRwNMNiraluW/r?=
 =?us-ascii?Q?tgP39tUsoNY04s4tQ8RP4jNORltAkLbtdbQcn9XEhaiNwkajdTPwMtmDCY9p?=
 =?us-ascii?Q?I12YQ1YPdl8fNTdwlrzJzTGnWdhQaxFoebN4I/FYPj5x8rww1l2Uv6FijXVx?=
 =?us-ascii?Q?DoRm3Aixcy6GooOT2B7Use7uNbL2Sy0Nv6x4IBWta6IsJXaF0tVdgGCcFiK7?=
 =?us-ascii?Q?2SWGTk42PdnZ4joUOmCiYcz8TnbijUMJw66H2wAwCyJgIidhN0ZbmfEmRF7T?=
 =?us-ascii?Q?vXBAz6QI0DfdJ/5Z+tMfTHykzW3jQ80Y2YMD/6mAAWYWClE5AFxjZOlJXzgS?=
 =?us-ascii?Q?MEAUrlS+CV+Bsa2IMYvycaAC44zw0ZJB5i6H9x7SxU4Z80yDMllhAY+M1foN?=
 =?us-ascii?Q?xxpoVaBRfl8kXK+uoKSXhiUSjk6i5iRaV+TYHtO2SXOfJw+z4lmH6sMBSEwR?=
 =?us-ascii?Q?m/GbEyaTk4190/w4rTowJ9gLEVQvRsoTsPPkKJHjli3qX8WyxBBzkTGbloz/?=
 =?us-ascii?Q?c5b1aZrBgIgK77W+tWbUPiNzbGVwTVRV55HfAW4CaoMmSbmZLXW40TDqMD32?=
 =?us-ascii?Q?Lse9brBlhHGbQjxFqdQIx1UddsG5WYqkfQ8C1TLZqBKlfjiZOd412qPztUV1?=
 =?us-ascii?Q?i7hCiicdxuaMBv7kKakuRj9/dzw3WwarlnYJo99n+Q4Its+MZ0KGSYNU9ynO?=
 =?us-ascii?Q?q2drT8FY0hHvdaVQ//hskTnCU8OBhGmdqJEC3gnWSIRn+39mD1lZ4ngr9qg7?=
 =?us-ascii?Q?DqY2//QIsn6Ew4EST5jva9pWvmc4IndxQ+WwB9b+8jyUQJHVus8tRQgFUWfX?=
 =?us-ascii?Q?TloWDrIn1aEoDDI69oJM9e5cvpt5dPEn3LBmMdpz/tq2Khk+RFMPSwOeh1FX?=
 =?us-ascii?Q?+xF0Kj5RSTxocscjNFhCD9HkeDJkYfIy+OWn8m87PvbOgKz6gcx6u9y76rLA?=
 =?us-ascii?Q?CsDeF3/xcYeUSMNbTU8PdeGp5w4s/4sOHDJc+IOSTl1ZxPIZ2stGTTu+psS6?=
 =?us-ascii?Q?pYMvfO/b60ZHoFLulkYXGpRHrHFtpJ5KLdTHshB5y2PFsHJfZ2G26Slo5mAU?=
 =?us-ascii?Q?rv8FX9D3uWU8WLs0O294EcY9U8oBWutC6A0A1/LIGPgWPfjeq6YtZ40iiVOs?=
 =?us-ascii?Q?J701Xiwr66pEj+jnULNdu3/7bLTUGeGYmg/MNRQvgvOzZsDQsHnnKds9VOEn?=
 =?us-ascii?Q?H0Plna5VqJoNPpcYawY7aUJYKIWGg1qCNbfesmTGtX5syG0zaxDkhhsZ1v30?=
 =?us-ascii?Q?YR0Syoo1N5Os8S2JI15pmhYdjnNxi/H33HzH3FxrlUZA3T6SPoUjHOmJQ9T9?=
 =?us-ascii?Q?trOpZPuv1rEAZlXQqWptqTIBZgsD2E9jzkP9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KrSNISqm/C7282uAKmdPKOUoRa3H9tXrTYu0tVqZoi6FnNimlIMcsFX7lXl6?=
 =?us-ascii?Q?TK5M5+3Ru/6uRqINKjB4bW1QSt3GZWOotcjp3DU4AuaBsZZEtETu563WFfuL?=
 =?us-ascii?Q?IWO7G0SWlgnIqBnND7285TO0S7tu0+LBkZIFPKlLcSGqB7P2je74cYJZoICN?=
 =?us-ascii?Q?pjESt/fc5UNRpFfWuQRIlijcYrIy4A+aI6zFoZL0cJwB0nN/5qLFnPn+Ecyt?=
 =?us-ascii?Q?2SGWR/kJYoe6z3qdHHDqu7t/oQDdNSw1cVCQTOFlZNQtExqLDUorgPg/jSS1?=
 =?us-ascii?Q?ClL0aKSvLvNlz1XXCl1alfLYjT9g8OJHdzd2rxtIIu92GwS1hh7y01lkA0Kv?=
 =?us-ascii?Q?tqtSRBI4GRzyqdH9GW06j0BMxx5oTAYw9rbs+76/R2Fd3/z4NqFjf34G+8Oz?=
 =?us-ascii?Q?f+XHGN7nLIVCmZvETJzD1VwKfdaaie8wGJhCxKUaRfS/RbtIYPEcsZoSmrM3?=
 =?us-ascii?Q?fEXuDQ8QtkkiuIbrKnx4rkElnYvpX0tLmthvjqFIy05RKRVEhYJlbY23N5Rs?=
 =?us-ascii?Q?oxNvFxqQo2N2GFtNv6BZ/esKiONMBSYEEO+XPw//RDM2bhKt+400sI/P6TjE?=
 =?us-ascii?Q?sxeMMuDVyWmh4P+3pXrtvl8+RKup92WZJcVqa658NiziHHWPBnHfXwZAdELD?=
 =?us-ascii?Q?JbRRp7cdmRn06i6E+Iy8xEhrUgmV6gkUTkbzcXBH/0ZjUYEYx0Cy53i/WE8B?=
 =?us-ascii?Q?yMS6SeAfEN80BBXjTed/WcmilWsqpzrqmBTCZaiZWve+hQxVe0pUSxrEcuaW?=
 =?us-ascii?Q?lcqD7DwKN2WsTW4RpqrgfJqkU8fHzofXgxT+ipjoSrL5f3KKk7QjS4oUHOeU?=
 =?us-ascii?Q?HzyPak0VBTv72MsbAuac5JmAlEuusl6e4CW8FTAS/x2FwHpQ/UKL4pB9n5ke?=
 =?us-ascii?Q?JlfgEUlknabLfgm65lurzBZVdamPq76diHwvSxm7sPYolJMnU31FJSB8DmJu?=
 =?us-ascii?Q?FrfzNDqdf3DlVk1bPY/hGaUuKH0mY+T4JuuATKJHMJMrmenJeRcGUjdOvnMz?=
 =?us-ascii?Q?tu7RxNlmFknLN71xIXFVpO2ve0ZXJK/D6ZA69WVU/wA4ttM1tDO3Lt1ZgOVZ?=
 =?us-ascii?Q?xFzQ0Ch/I0xrJKE1EhKb/N70QVpYGeFW4l/naM5WZn2t+lyXkecVKD2se+RI?=
 =?us-ascii?Q?CDx+8gqk1Vzjj/6g02BtOZcgPdiXWq3RMmkGxPaRLuGofPgWzbHjDtH/NMhl?=
 =?us-ascii?Q?wioWJYEs5L2TIbjGtVysDmmiHXag9CEx5AaMT3nGaQENZv5pgGLvBTOcBT9n?=
 =?us-ascii?Q?kcJHB3dueajUphLzLDa5rzuiwdFmBL/Hz4LlUTQ0rteh6SucrYhWtlIkteVP?=
 =?us-ascii?Q?rQzsuhDzKbYT2iMkBKTZCtM+u0ql+dG2GvOi5g2a0SUmuZzZS94MpzVUPynA?=
 =?us-ascii?Q?5I4M9XZt0I8MeYQUK/CFoBLOcgcqeYFh0dfkHjyzaa1lY/nKrayq05qla6qE?=
 =?us-ascii?Q?EgkRnZuUq7H2WJAQT9SQSdnLnA3DZgHlb3PGFcyor7z5Fonem7yEoSE/mJN8?=
 =?us-ascii?Q?gI1Qy7462zaikBENC57U3W9H084nh13h16d0LMCKm7Q0LRkGVGw/FESyZFWs?=
 =?us-ascii?Q?EL2UTgqfJIlj+vMYu2BlIA+ivE1VRX0RpuOpNhKo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6e944c-1905-40d4-742d-08de3958ea7b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 08:31:59.5229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12fP0LLfl15YOTadk3NRjpa5ZK9lSRAhTY5BZuJTp/OzgIcOvm4dQuoETu92peIFIXO4yxESVoV9JrEv8PMHAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11556

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
index 1200951bab08..0a198a2c2616 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -305,4 +305,9 @@ static inline int mmc_card_no_uhs_ddr50_tuning(const struct mmc_card *c)
 	return c->quirks & MMC_QUIRK_NO_UHS_DDR50_TUNING;
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
index c417ed34c057..1f7406c0ab03 100644
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
index e9e964c20e53..1882267ef201 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -329,6 +329,7 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_CACHE_FLUSH	(1<<16)	/* Don't flush cache until the write has occurred */
 #define MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY	(1<<17) /* Disable broken SD poweroff notify support */
 #define MMC_QUIRK_NO_UHS_DDR50_TUNING	(1<<18) /* Disable DDR50 tuning */
+#define MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME	(1<<19) /* Secure erase/trim time is fixed regardless of size */
 
 	bool			written_flag;	/* Indicates eMMC has been written since power on */
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
-- 
2.34.1

