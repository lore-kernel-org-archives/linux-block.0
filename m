Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013062.outbound.protection.outlook.com [52.101.72.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BD52DF136;
	Wed,  4 Feb 2026 03:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770176284; cv=fail; b=SB2Aa+3rlW4BZh9OY9LeRG0VpYC0/p06WkbVXc0/e1Fe65ILnokexjvHvBrHIe9YgRSmbmS4K3OGSi7dxpIJSixcTL0wtDscb5HGQP2oJExledBp9BdhwtK0VYQY+A4VMq7FtjYiO98IdoE8kqMSlSI7iW30DHpuo/zJt/0BxUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770176284; c=relaxed/simple;
	bh=IxcaP8LEVNRRP1lUX2sxnK8oxQ60GH196Kx99TDIUvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RDGjokCWVo9LGhhcsa4epwccfhbeLMFwgaox+TT4NzW26h98wRvpl6GKCoW4vpdQ4nShPel4/KwmaugD8fKOgK2z1VXcWJxhKz2kQVDvRaOnelxsZR0mNdGCwJ4zimTK2Au3rR81k8TOL9i2qOwsFq/PFgMz6K8QbMq/I0Waf/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EoRYXFmK; arc=fail smtp.client-ip=52.101.72.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EoRYXFmK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7575SZyAyKCGJ5XlcYTtOtMlsatTGzmWkzQVQcQhZgGSymPR4GE9cPYkSEFAPc6GjQSpfiwN96h8mRdDDA5noIxn6byDev8kjbtdowf9fYWCpgzu+DEwIiLqtBwXY6F8Z3HcSZrnT7Wu3IUlb5tdFcz1MQuAdITn3Sj1YlUdyNuqgI4o9Bd09pFUSl9+B7GhDSmKpQpGKFxd4WASQ+ntthNrGJxtMlg18TfVBrjPjddkSP/+TSJWScDM2HO3edqKJCzG4ODcvX0qNevoOhBIjRv4WEILz+U3UQrS1xG4eDWSGXEzfJ7KzaYuB7ChWyxDQIRJh8aLqDk8wr3wrB+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLa0IjxI1yM3LLdIxlkka7kLwtJeh/h0xCIjf724uvw=;
 b=xf7leDG5tIVEAiiUoCL3MKP9x14AOFJiFjeUD5msXRi/xY02f4u5+yR+skMmXxtTXOEB3gUgvj0kBkOQExh3n0mozC/aMMV7bZ9x1d9NYk+rTSahWQjtJ+9NGnbQAsc82ivbyP2JYMzgZ/bVmu3rlxpk5NNi4yukX0vsDwJlCJmL8ywPzZSxvjiyXJEAYePliWgkpQoqwbHbYC/uo/J2FZTEDM26HC6cH8KwCQPT3SKlQ7LNq9qzhXcRsDZaB5Ud2JUTiuhZO2b5RLVcXxoJ91RqyKzJmylkI3mTsmoFpXQAknlSQ7+EkjKk/iB+Wc6rVfCYNPGNcx4LlNt9tjQOrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLa0IjxI1yM3LLdIxlkka7kLwtJeh/h0xCIjf724uvw=;
 b=EoRYXFmKjP/HLpxb28kS0X93zTA/VDERM0gubE8IKp1CMaBx3Wzc71xPWdaHaRFql18d8vEgRQl1d8M/AMPRsxASAiq4cRKmBVm4KZgaDjYbOrgG5zy7uGOGBN6l2hl8MTJhMD0iH+o2mMi1cTqLdb/L4BKwqlLQt+gAWf4LkR4gD7wEmm0rAWPXtCj5fCaPkNZ77kIvh0g8aYtDo1cw43QpP/huABdKpfclQhpe3aJgq+iMewlcPSL4DS543TB8IbvBVvocCPZkQpOrNeSOWSC+Le64Z+aVvNvrJh58L8Ldyt0wEQNBrb6BT0Y+s5HtdkmFjEmkJJn2m0ZY3C5RFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by AS8PR04MB7703.eurprd04.prod.outlook.com (2603:10a6:20b:23c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 03:38:00 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%2]) with mapi id 15.20.9542.008; Wed, 4 Feb 2026
 03:38:00 +0000
From: ziniu.wang_1@nxp.com
To: axboe@kernel.dk,
	ulf.hansson@linaro.org,
	hch@infradead.org
Cc: linux-block@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v4 2/2] mmc: add quirk to optimize certain Kingston eMMC secure erase/trim performance
Date: Wed,  4 Feb 2026 11:40:03 +0800
Message-Id: <20260204034003.2961402-3-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260204034003.2961402-1-ziniu.wang_1@nxp.com>
References: <20260204034003.2961402-1-ziniu.wang_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|AS8PR04MB7703:EE_
X-MS-Office365-Filtering-Correlation-Id: 199361a2-313e-4704-f01d-08de639ecb48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?erGio2inyrXR0rOx4g6LWI5j+QjcV7TtosO8YuFCuCGyJqZ/iiPK0YwIbgpV?=
 =?us-ascii?Q?Q5/XRHluBKnXHBlQPbOzL2mWycdTkK3/19h3VDon48Qq9kgTZcBbOKQAWiUv?=
 =?us-ascii?Q?+qYuUj8xcp/93kbbVIDr62zCstA/FYxPO1+87MPAkyJa+jP2VjSB40WzD/eh?=
 =?us-ascii?Q?eOJrnzLtC14aD31fgHAkpmBk7jRq5Z62uxoJiAXiP6mz3cwFSXDuKnu8Pf4p?=
 =?us-ascii?Q?kL8kwx/x9Mkfo9+SVcYljAwsvAwYKL4OVEKzkGkFxByyZdeEqU/HgjViRQcb?=
 =?us-ascii?Q?34L+Tq6gFClA71VPFDzZrYEhj8WG+dlik5dEf+0BKL1hbcfcoQe+aItOdgW1?=
 =?us-ascii?Q?m++5b/XPLZt/hQj7shHMFQC33G6Iqt+oHsLo3H1ct5mml6aSYPqJXIR0EINl?=
 =?us-ascii?Q?B0evIqNTZuAouygK5ZoDJvlQQoxZ/slzP5ZIVDPdH5x+ewxSg6K2mq5yDxnt?=
 =?us-ascii?Q?c1hGDMsTpj7hRGpASdlhiWyIQSXAFFRbMHQ/qyJMVMGyc5K2YpB6f1yhg42f?=
 =?us-ascii?Q?qpKaJmD7IxVjWF9x8KTEqhVFusAAlwxqvGawIhdBBgznvS24GeZazz2ecP+s?=
 =?us-ascii?Q?b1vHaZM7lQ7BBN4UZX2cR7C3ltDuMPC4R1c+GfqqtnNNYbD8w6m+eK7tFlJ+?=
 =?us-ascii?Q?GJyf4lZiH3DcpSblhbG0UTenTLqhRkk6PcEl4Aq0gyQMn7vdt/Hk8YgLTkZO?=
 =?us-ascii?Q?dULeqGceXuA1Q9xcwn2QNQ49UXupm0TLU7mquVR70IaVV22zr7qSxsUuuKec?=
 =?us-ascii?Q?BAKdgKI7YcrY2yL5xGz//1yeWvVeXEKn0j7q0oHbGAx5pAAJEK63WpYs2ktQ?=
 =?us-ascii?Q?IwiUuaqJ+90EbWzoH9PBQrIaoJRnud1IGXiW7moIHukjJBIQxv6rMcZ9wFCc?=
 =?us-ascii?Q?QqUyKKSfNdRmizs8WSSGMS4R9eBhGoQ3zyFortqvcJW0WUnJJpTpAAIyldjJ?=
 =?us-ascii?Q?hJMeNSvA9D+Eji7r9T5c1r7PxaQH4/2eoaH+BrhoaKQRtKx8mlBe2yfPfe0w?=
 =?us-ascii?Q?HzNY0tgEQ3AnqNtoQ2QXSFdp5w1L95JHZIccP1swQelF3E/Mt3iOxaVAgqop?=
 =?us-ascii?Q?iAB3+v5KRYXhoThmvqbGGjJpk+6fI32KQjC4ron2893oHHEIHSWcXGatu6P1?=
 =?us-ascii?Q?Sp2gwJgGphU4Y+8CYqBDIT/R7dPtD4TkYGUrn3EOz22yzodRaXXiAASIDxvx?=
 =?us-ascii?Q?MIGEp4lZRyNT+MNQqSwvqSp7FOYrH15BuLbfe8RD0Mo9BVfyZEbDSQtnfrHb?=
 =?us-ascii?Q?rKtZP04/qe/4NA2Dn8nz1Bjt6Q0lFHJSeQXLxg1ky1M776kKrjU6ht6876Pe?=
 =?us-ascii?Q?SWO4W8UoVBc2ohZE/RQkA3C7tTR35EKJB22mebRvuaFiFbKiWmpGFaAsYHxH?=
 =?us-ascii?Q?Qo5Rc2lfwWsyaaFor3dXvEAucBoY/gR76OA0Q3jpeixhSUhMgUDhtgHuzLfq?=
 =?us-ascii?Q?BKYW697AWl9HGsLZrCYSyTEA9ucfR+MfKX6pvWVuFcp38+w1zDm3TwksUJGZ?=
 =?us-ascii?Q?kEMkzFXNnmLeYcqsVLqVcEvBOrh2oHIUM/OsKN51RHXCpS6B2Sc75yfWwxqf?=
 =?us-ascii?Q?rd7hfnQxlcU4U+UXG7fY115IFBOTLzWM2yxyKaajURnWCxqGxOJ+gmlzggUT?=
 =?us-ascii?Q?/2bvWqmXBJ2/ViNfVCIQqZc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jO+U0A12xCN16bQnn6msbWH8NvreMsI8z2VLLXqqmoLk6VOs0QOiuJc4cRf5?=
 =?us-ascii?Q?qdzJ52RBlMLmBRCf7wqh6Ip+nUjEhgCT8+VZgaBAI8+himvgVZ05t+RYdqMm?=
 =?us-ascii?Q?fXf/y+BT4Tz6+jlo+u1AxiKgPppsXArpvrmJmc5dH/zXJWEJ0OwvQzySZ9BS?=
 =?us-ascii?Q?+eHmOPjQaYw8voZwjCdyNbb3mlVtygubZOB4id4NP7wDaxAf8TGdcHtGp85F?=
 =?us-ascii?Q?UkOTlKBt9EwoXzulkW0PM+5Rrx/duoFqiEZzJs7Z9j2BvVtTADUvelIqHIeL?=
 =?us-ascii?Q?hKzEInsnMtnJd5GXEX2GaR+sjAoaFHnCvcGxeLbdBryTC0n9cVU/tPrpSnS+?=
 =?us-ascii?Q?opgA9LM0sm4r9Z/QQHhTsfqckatp8jVwgJEjF/Ag58DmTmLspvXNPtR82p5y?=
 =?us-ascii?Q?qhR/fpyWe++44ZgwFNhXlcijFpTarY7f/hRI0WF6kVy5+D/OAKJNPOhvaZMz?=
 =?us-ascii?Q?zzoBWJcuXxFmjJcjFq8zwlArvM4wiAI17AsXEK+49v5JfyXfZsdgQNTYWEO/?=
 =?us-ascii?Q?7s1SSkqlMb/dK3VxJKgNwqcLhg8Y4Sjb+6wQxOOF23Ir3JK801SC+Csaqrb1?=
 =?us-ascii?Q?zeGzRz1n3R8ME4T69Gt0Sr+jF3EquYmBETYZUB0Q5H+OkcxEYM+S42+v6JAD?=
 =?us-ascii?Q?1ydffNGYQhricyfwZnl+mR/dOb6syttwOnkIWu5dWog4o/ofbPJyg7tkRWQa?=
 =?us-ascii?Q?QHdiaOBDztM+r2NwLqYuwIcTHOVspY7GSUxMtGPOG8x/vAWIp0JuU0kfqf3/?=
 =?us-ascii?Q?f6ppglx4b+9YUOMI15pKjjOEDDo9Y7YHZf7pzJO1UImTlAnKP1kNax/UOzGV?=
 =?us-ascii?Q?gfxkyd3Whq0WKbE6hraJG9M3Up4WYR2s8+vXM3SNL2I66xkxgJ0koKw2huPN?=
 =?us-ascii?Q?cNZHkWzk6FSJ0klg3glGO02z4LneHiKzaiQ+fSBYFdRRGLLth5RWIaQsUMF3?=
 =?us-ascii?Q?8yc4jhiHWA8hO1Npb7XrXtLRSq/aDN91MP3p6L8U9cZSJNscmYl7lOJBwmZ1?=
 =?us-ascii?Q?HsRzfsPSrPMdjtO9TDiww6ntFxONc4jocQS2qc9f4cavz4j2oKU2/1hmnLSL?=
 =?us-ascii?Q?pj2UIGoUudooUP5FyDdZm6B9QxXfXbtG+lcRcCbKB15JYs37umCS2BZXxP3l?=
 =?us-ascii?Q?tUJtxgidaapxmp092SVwIT5Kb0iHbKdbHVbywdNKeM5ZFv6P3MZ7nUaip4N9?=
 =?us-ascii?Q?TO+a0G6P46D+rKepBj9p13sXOF6iABpVaKFIMIvfhVkTIRjUi1eN6dghH7G5?=
 =?us-ascii?Q?arm1eNIxtwnw4rkelSAxkxr0Xcs2FZ3zbxYxmfNriWbKADkN7JbOMsHfGVap?=
 =?us-ascii?Q?/QPJSDMukMhfrueFdR++vocgCckKfTL3/LQK3wXvnhKeP7wqXRLOWGj7oGCp?=
 =?us-ascii?Q?SAvMVrQCO/a+h89HbIf93v4Fq2vxgv0mgRrbadqSZvQx0blyF8c7zuR747kc?=
 =?us-ascii?Q?THKvpdcvTyPuyghikmRmfoqKIBV/BnsvNrcTG2I1fEq7jcPEdG1AbbDB5zeW?=
 =?us-ascii?Q?P2inssxupWeT1a3SLGtjvDG+66rn1Ps0G2+I3MkZ2Yi2aV+Y2mGwuiOOnlVQ?=
 =?us-ascii?Q?joQ3c8eprPMZ7bTevqBwMbX6ZTm0PeoHCMM7FbT99pGrmKu3L9ySo/1EXDUF?=
 =?us-ascii?Q?hmXDqGuEp3IUhPc4RK9M7BZdcyUCbO97/ssXEA/ts7BWcSIRLXZwd8xpgPrf?=
 =?us-ascii?Q?9NRY0eagQWRIVDt/d1b9ATJtYufgbq4xUcKP05NHuma0gNBvNcen/q0uo2hR?=
 =?us-ascii?Q?ts36hgqtMA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 199361a2-313e-4704-f01d-08de639ecb48
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 03:38:00.4618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSixvM20cVYWdlOyBIz7XAKc59JZl/1KSluK+yGGAXfmekcgNm2lV15cxF0+P1ZsGXsVvMMg89z8661V21ouOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7703

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

