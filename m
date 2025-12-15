Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013059.outbound.protection.outlook.com [40.107.159.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BDA32ED5D;
	Mon, 15 Dec 2025 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765793908; cv=fail; b=WxGLUFFOEzUyk2TGrfBtAhYQBpQkd1XEUpGPovw/x/NCFZ4sQKtBoVYgYSce1CZpEv4TlX5RimH3CX2Waa1S7GUAFr5z3eI2NrMfniDP1svKCMRCkMPcRBEJBwcW6odWyYsB0Bg7Nq00s9mzhQliQirLhX5CeM81ZUKhbolwPZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765793908; c=relaxed/simple;
	bh=/fwENXuOoRl23fxoZ5Fy8l7qWg/uoTf5yCuyrjNg9mg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B3tDZ2G+6ZlgZQafMslwCMbcTqndgto0eYdNllBK+i0ZgKoNrGtgAdTgXzw124fyYRBjBV27BKQId1ikbgPPVQHxa6SPou67XBVo+TnYM2lJFcsYUh5u4vtSbiGnL4Kt6WEEgVqx9vTs9ZFvoslvr58O0RIvQXys9IWCfTPIvMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NzYSsGsz; arc=fail smtp.client-ip=40.107.159.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NzYSsGsz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCJvDEWvePW3Klx5PoL22FevSZitcg4+rAqhjSCwe71sbnEKsUj2ZHL7R5ljkVUB91duqQFzZM1srgGgYJtMLtkoOJjiqeIWfA3Hv0wwbeX+XLV6Xfp35O2aZGgo3KIWzeIuc6i0pQxKif4QLiIQSmGUzL52NluQG7FZ7+ltnnHdYoQkZ5aAyKwooBieUmEcfeL+1xrIY30t/SUQTc1d9LYrU7eqGWHtt7gRen+41ymNOIDloLcFf20qSA0I6c/ZBUe7aj6/NRHdy2jwZJT2snkbMdFHP37nlZTvn6yBiODRKkvEzNUAQFZs8qVtO3guwdUys+gtn7k6HEnTbAU22g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmteFQ6S27cGTR9PUEI3bX3XZ12cN3CbyeN5jFXRl5k=;
 b=zJYOPVZTKTXP4ha8x8OQqTI5NrLiFSQ3lbeAENdqRfYKQuddDfijyGulTDR4RVRH9iIeNYXCAm6vnIQbGNUB+mhoauqdExND2D3na8nIJ/qgqe7mYFCc/oigi1QpQKl0cery4dHxnTc97SAIU+fP9sXMsfmIhoaF/h3birCYAyHIvbBg5/r5mdDuZDLzuP8QgqXDnml5jG53mLTHKbySFtOGl3wDfoJiX9QBoNnz9Tu3tkAmX5xXS83m74Mxsh1kvtsgQc9SKSSjz7gxbaQwmb04G9MkJuhu38Nmt6nOTMn79ClOh7gffZkPu3MCzZcAKxzFqCy9gtJTnOfmqd6Djw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmteFQ6S27cGTR9PUEI3bX3XZ12cN3CbyeN5jFXRl5k=;
 b=NzYSsGszkaLbS5f8jJGTQcod+8tPs6i5zlmbqhQbsw7taevp6HjWEBY5vtX0WFV3kDkyKJjc800p3QXyeMBLf4vHkNS7P8UekhVxqOzQNpgTb/TUrGvTEfIXNF8ewW1Vc/DtdIZG+63PPnqzEXv+X5h4p1yRAm4h+hmBxNApEe/2rpa3hSCiCPZ/Kz4oICcVsG/yhkUJSieV3HG9BSFLlBvnmJ91C+JhvB7bR17K54NWhInN8Exwv+EBeF/ICgh1B9DHKZeYZw2d7lOM6z7HUYqwnAMMTxLGDB0FSFWyOiZe4HGPmmeh9x3WyM9ncUwk636WF1YNU4cBL4Bmmbe/IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by PA4PR04MB9438.eurprd04.prod.outlook.com (2603:10a6:102:2aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 10:18:22 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%2]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 10:18:22 +0000
From: ziniu.wang_1@nxp.com
To: axboe@kernel.dk,
	ulf.hansson@linaro.org
Cc: linux-block@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 2/2] mmc: add quirk to optimize certain Kingston eMMC secure erase/trim performance
Date: Mon, 15 Dec 2025 18:20:10 +0800
Message-Id: <20251215102010.608421-3-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251215102010.608421-1-ziniu.wang_1@nxp.com>
References: <20251215102010.608421-1-ziniu.wang_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::19) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|PA4PR04MB9438:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6e8c54-a9d6-47a3-3406-08de3bc34693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PPS7GJM0gqBMQ3YN9j837iGDFCK+fUKRXN3mnLqxX0W2iegIugmo5X2gyNkr?=
 =?us-ascii?Q?Lilqdf5bu3ZGS4wQcB1W40CXhOJ6SenV1qJzwx4F5jIm1nQT4I86jVReTvMX?=
 =?us-ascii?Q?VyFTHfwmTd41t4X0gLrtWI/eQeJtsQv+tMU9t8MjC9rMbTf2H7KxdO2eOoFC?=
 =?us-ascii?Q?1stRA5MufRFis3QF3ZLpeWnzSlkA7anJP4Ix872A9Nh5MyaP/TIOLF7x3eIm?=
 =?us-ascii?Q?h3DhbyGdIol5jDe+JpMvnIybAj1F+2rsf6xdws7+D2ZkV1GoG2WoduVhmDkT?=
 =?us-ascii?Q?lPiay+BLYiucjEIUn3mM4SWsiBxsdv/9A3HpuEsn0aPdjFga/GVPZ5xPIEOC?=
 =?us-ascii?Q?Z1xNF12rFl6fLxTQrAczGDx9QrRt7e2VCrhTTC7jCcN7WGNims4+SRptHwn1?=
 =?us-ascii?Q?RDIPIHd09uvO83jWMqrrThunYFedcqvWfvsA3SYT5b9AjnCSEztoKHII8eyZ?=
 =?us-ascii?Q?gZ0SFhPJcRi0IChfTtN94tnWLwsvDaiQLnT+YKvHB3BBOxLuJz/BIJkPuvRz?=
 =?us-ascii?Q?h2wYVI2g3K9W1l4IAXuNIYFKHP3tOJWm6GqrY5EnYtHfvNw8E44cPqIU0WlJ?=
 =?us-ascii?Q?29U6KhFb42dBVYYRcZJs6RmYhluLAxFFlMUNKGgy9e8aShYtyQyr7yT7cqpp?=
 =?us-ascii?Q?Yw0OPHbE6DsxYn9osjL70PN9RRALZFTADggMJFTBiU0U5r2kuuAtQiXch5ca?=
 =?us-ascii?Q?9efLHnzn5LCbXHAjO074B54znKvJhmtsbgOAv4DEdNl69Pz2zcE60jTF6L4E?=
 =?us-ascii?Q?KnPXVxsB1jKa2M6bNCOq+Lzd9EPuIaPTVsES38lroUwN5fge/NHMAJVkjq9y?=
 =?us-ascii?Q?RuCaHAofkipabHHqBLXybebr5Jk1tvRajCRVLBIAXtxPXBzkfQGk1Z+Zekab?=
 =?us-ascii?Q?cdYU7ABunG1iv6KN5foQkFFMQFyb0NshfEGE5qbPbEzwWG79HDngAf9YHvtI?=
 =?us-ascii?Q?lvXduGITX4UBzTP+kwV3H1Qhed8drLiqEcx/QRBlw6iSE7Wc2SUCTaxtVLCQ?=
 =?us-ascii?Q?0Kuul38gNIH2X49c4SeFkP62ZqaxDz/yr9CDAkLkUqy+HI8JiVkxI4v6ChZ1?=
 =?us-ascii?Q?iRvOpYhrV5M+2+3TTgDM4skRotxaNuf7i3amy5oBhVyTjObC6TsF6ElswDA6?=
 =?us-ascii?Q?Ncs7dPs/cCkpDe3nzPlgIewFA+gau0f4/UchQKq31M3BDRnS4moLDMSVja11?=
 =?us-ascii?Q?l2dLUp/si/qz7XClD30InAQobePf7EecAAqNfFY8dnh2Z42Qb4nNLzLLPT9F?=
 =?us-ascii?Q?eG6SSLURjwf1bByXXp747nvsOvJInOGqVR7jP/WdUNOFpHlQ+o8SqL0u41HS?=
 =?us-ascii?Q?qI2y99U7YZGgBLwKxLf6ENVwuvBCgFmc0bqlCgQiaw7i0lXNPiUpXHUlKTKu?=
 =?us-ascii?Q?MnVDrs8BWTBkudAyi1iGjDaB7Tbd2QCdnxHf4sk7YK46//jXdnFB5VQ0Aykc?=
 =?us-ascii?Q?05bS3O/Dvcz3+/DXzFzYQrarLRztZviNY7skzc/cSgt9KHFwIadSo11cU0br?=
 =?us-ascii?Q?k+02zGT6pmepHF38eV8+fXdf41+l58Gyjath?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nto/Vs+iOOQ2JJMP/pWg4rho7jIhAkHJ16ztqF1tQcmATwOOGuql5SJs+jFH?=
 =?us-ascii?Q?EwR2ofLGDN6qmXy4l5+75ldQkdrLRTwNzx6aeqs8C1HBVMMIl6sm+Y1K/TKs?=
 =?us-ascii?Q?ZCsHfCDVGZNMysWcY6cNnuBCjyer3xCQ/p1snVjGOamPVir+URhvOhFckUN1?=
 =?us-ascii?Q?hLUygetp+UuUUeAllOyQysYEpQZWko4KhkF2pDC/1Tsm56u/2Wa9aEsMiSp3?=
 =?us-ascii?Q?zkVQ0xtjdZgg+/OAtgK1fCbuTOm374E7ILKM4lIgI3X60F4xy6WcOU3iR6Uf?=
 =?us-ascii?Q?xHCGhRarUf0gkjRiu0IM+q6gRSnR5YJvFOJTC2bpGew6WCKqabgzpqyMyg/w?=
 =?us-ascii?Q?KLMt4rBq0pUT5dbicYPfl/httfC5box8emGVxMwqNM8wGhGQljkd9IF3pijb?=
 =?us-ascii?Q?YjFcNPqFWVBP/4PsqMks2SgiPIH0qwqpLWSyaRssukiVSBXUadef+falzihe?=
 =?us-ascii?Q?14EwZ01lMBVxAUy8VWSvzI9AOwatw2XFIZQW/w8kyZUjliJ79g6llR7fDjKm?=
 =?us-ascii?Q?oFunSAoVvlqHgmkkbM1HgX2MD85ercgvwushJjvh7eFFaZeMt3f6jaIV9gsD?=
 =?us-ascii?Q?KGYQSuOVIwBAKsbn1hlV8OUjV75ScumWNynGdGO3fhTRRcNY0RJ7L0cNJnLa?=
 =?us-ascii?Q?AgNspGONPu50z8WmwbC2NTzi6TEyKBUttmtJ8ra2mp47HqbY6L1LJ7XlM425?=
 =?us-ascii?Q?MOp8HHVHHMEW8kA+mT3z+qWX0gg8G9WjlSuc9qoBFKZ01Lb2PpsxTtQNBwll?=
 =?us-ascii?Q?Q3lGyZeIdZgjkMEF6T43etvm2jQ/303xOf4LUUUziSXYcPjW2XPwzV8XJgFD?=
 =?us-ascii?Q?yqoVY+fGvFvDBjNZjlrz84gniIH1ogrExBWtOwiXlsp7kcQo4I9ruj25ZmWs?=
 =?us-ascii?Q?71ArUGxbbn5Lc//DAR9H4qNMTFM/BswYtn7S3c8JxOC1jdYRlQm3pazxN3BH?=
 =?us-ascii?Q?o6OECz7TbgBhcyDf7OsbJwLTyZsPyNJP1cxq7ibMAEENVtc4Qq+UzFukQCTL?=
 =?us-ascii?Q?w9CDlJu+rzEuS5Af575dHGpxjj6UctiuVojrP76XbEJIgnM4xyY2zs4l8hQ8?=
 =?us-ascii?Q?WqVVBPEtrOoSSo+aJpcpznUVogHE0LLb3nw5GdtlYkyGOnNQvBK/nNQZ99VS?=
 =?us-ascii?Q?hv8MLWqe1hyot5BKNt7xZikIl/gMjWx8NPkMJ2tl90m8pB8nkEo9yv8zRh56?=
 =?us-ascii?Q?aXACyjn40NjttOJl43Vt40yzfC24UJHlKtcbwuJlQP5Mw6iRDzvp5e0PjlqD?=
 =?us-ascii?Q?f2t0qbUMmYwQ82O5+FPBat6+fCFj3E+iJNQhmxWqPPMio7HEmn12PnbKNXiM?=
 =?us-ascii?Q?PF2D1Uzcz/8obsvtRbuxBLLUi3fwGb5RqA74yOQ26ccZiHLlfSiMQFgtz4oX?=
 =?us-ascii?Q?K9s9oRm01Ui2ajEieiNTcmxvTbCTJAFhV0o7LmdQoPv9sqP7cvtJoo5IQJ+Q?=
 =?us-ascii?Q?oCEATXleYKARA9w1j8yaY2PcK345sxaddr5LyxB8iv/6+vESxN8ycoQ5Aagr?=
 =?us-ascii?Q?eTsciVjGIvvESH/AZ+uXVVnfbFpAhQk5+negD8SAEfGasMfa8PA3lU9Q7et6?=
 =?us-ascii?Q?JbRFuDc0cG7TyjYs0N2PYJXkflbrKSTwm2ojC/zA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6e8c54-a9d6-47a3-3406-08de3bc34693
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 10:18:22.5173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gdt7JTBk6hXYZpXaCAXW727gLlYYifzrQM+K3XY+XqfepfcbbFz60jZovD/owcoSZ2Z/Iv2UV/U9RxUvz1fAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9438

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

