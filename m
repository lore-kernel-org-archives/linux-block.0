Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012016.outbound.protection.outlook.com [52.101.126.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF51D2DBF48;
	Mon, 11 Aug 2025 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754899911; cv=fail; b=U26X11UQAPryF2vCCeDDQNR2BEFkj7pxzxeEmiESuOSgR8lRxluw3I3M5bbzB28fEJiLgDyf/AdWDJIyv7GK1kGXED97IP3eyf1jfbeChrZaKDpa/lZQRtMrhewzPUtYWW7CpfP/BwxoEdCqIs5BtcX3HmcncSe3ulDJ1DmhTJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754899911; c=relaxed/simple;
	bh=4jUenGmfsZTZKWOd5Aoy9Qj/JxtxkfxGtL9NzqSnHv8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iu3Di9+srlYOQrMQ/e3WscG5kGnoqDZtr9zc07Qc4OcIM5PvO+QEQqugSBfrCXXP1XE99mRj/SIbkC+naQYhE7smp+Xn7hQ/ryZOkbghXXDv3PnWvg6hOp1PNpzHtWmMEI+z7PayiYNoW4iSfIP3udLTp+BESxBET8/oX7IeEAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=H5/+ws6g; arc=fail smtp.client-ip=52.101.126.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="H5/+ws6g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zl6AjI036cJP6s8kjy4Afm0yTvAQv0AqLohfJhFP7UtT7cPDQp9iZEOOaiInBHZfQL1TnJEwRhrlCCoBgeY0Mkvuu6epoIIpB5PzeSzKfVEexEifj6mFBraLYiJeqA8SD+/36vwnbAUQrmvxMTz2AMOrkmy1hMTWYtjAoV8XD/m+pVfzhvo40eExNP7E/bsXo2iIfpx9myIXVNdynP+bQaoDnJMbQM/CTbU+Gf2IYrqezC6CZRM/LNQLBOwzzEOmdlHEEiwYEMn19xAp200rUafSYdu1ggCIJEx+1qTgClu8UIUQMmp9yzQ7eamA2oKJLzd7FGzgcP8pcTP50i0+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+lkuTMynpahgfoxcFKZbZlPpGaax1XBg2V88LJpoNo=;
 b=YTF2CUSP7vsa6if3C0ATQSPHEKaNmPRTJa1RKs5YW+HaoWtbnlJnwVaDsPVT8RetVyBIRr17KJnRGAWXb3VZvW0FEbg/ZOEhPpghkocAiynyrbVDrN62l/Bx4PFkCZZHfqQAALNvcE70WnMDo7UzLNugdpfh+rpjYnJL64gNrLzbmNBIuvefsCFQcltLWmOIBwMka/nJy2Ae0CJH5x8EnXxkpK2GYNtelcWKTQapAwwI17IWx+FXZjRSwqDw8reKnhtr8a7ssabcu0PNLqj2qoS9HAcehkc8dBEuF4IHZWeVYw1nIPtj/kwCW2tVN/SAdwzka801lXeLaAy3sJYVTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+lkuTMynpahgfoxcFKZbZlPpGaax1XBg2V88LJpoNo=;
 b=H5/+ws6gGq5/vrdyPWRm2U2ALI9qt1pJeUaG8WI2TfQJnljB2Be+QCKgDBCRnJS129G3YtxyWjgXYAxoo/OuM+Bs7r8CjKwLirjZwkoO37muSutjJIQCwPrutS5xYf3Czp+emFgvg5mJIKBylyd1Svq87lwOAp8wv6i/hc2wWH5M1XocdGFT1GGUEjSAhz8pUEoYqi4FFsZwlLEd3agssWeSqnJEcEdNnOem28Rc/6w7BX2tTDsLTmh4wgHM58YMR72WCNj3g2qK+Wiy7NCI2n50TIYV6W49QsVgubFoKMDGgyBjs2gyv8NCDpn2Hgtb0oIuYdUGqtcrDNiTK4JFoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY0PR06MB5128.apcprd06.prod.outlook.com (2603:1096:400:1b3::9)
 by KL1PR06MB6135.apcprd06.prod.outlook.com (2603:1096:820:d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 08:11:46 +0000
Received: from TY0PR06MB5128.apcprd06.prod.outlook.com
 ([fe80::cbca:4a56:fdcc:7f84]) by TY0PR06MB5128.apcprd06.prod.outlook.com
 ([fe80::cbca:4a56:fdcc:7f84%3]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 08:11:46 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Yu Kuai <yukuai3@huawei.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH v2] block, bfq: remove redundant __GFP_NOWARN
Date: Mon, 11 Aug 2025 16:11:35 +0800
Message-Id: <20250811081135.374315-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To TY0PR06MB5128.apcprd06.prod.outlook.com
 (2603:1096:400:1b3::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5128:EE_|KL1PR06MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: b4851ef8-c03c-4358-f4e3-08ddd8aeb6f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h8VWtaGc6tR+eHTs1zvt45BAbGHd+jMiTEM4t5xWoR8LPrlfrfYyZTY+1icY?=
 =?us-ascii?Q?1o7ttRZOqHTdDrKkmye7nmxKJ9IBigORCWuDl3B5eVwemFX45cA0kHc/Dy1y?=
 =?us-ascii?Q?592axu+ZbfsLcD5MBSwsd6ygTGxYd9Zy/rKVIZ5VrBlw2rJXEcO3C+GDcWEi?=
 =?us-ascii?Q?slke/xG9LIZ/JlsYpJMcnCU7f+4vQErgxbOnOrw7pN8oYpDzz/5b9Te+nvM8?=
 =?us-ascii?Q?TGjjPV+FRXAfOv93b+XMuFe0O1QPewEQxPiHF87rGJL1z86P3BJcjWVZSUT1?=
 =?us-ascii?Q?+e5/Zi+ONWoZO4VErJ102v9M1EEMAJ6rXGm1OBU1EsU3c5vI1/rSEROqVrv+?=
 =?us-ascii?Q?npf0HEL+W2N2ypdH+X6+YuTs6fa4cMjt02r6piFzwU/C/8zryNcAuwyMEnQV?=
 =?us-ascii?Q?gHp96PDku5x+xxv5qAVIXddKkmFkPydNZ17+7BDBeZHnXvahdk/JtNkfbx0e?=
 =?us-ascii?Q?+6UqNfQJ8q64E+y1Z4nDEmSUlwvwhlhx5RP16JNufYSe94ZughI63FxShbi7?=
 =?us-ascii?Q?wSzaK6nGnBA4RwICMHjXVKSCBgzULwTTMausdsNeP2yqcfXTeIc7E8zaRPt5?=
 =?us-ascii?Q?6wEcVQg4QrN3r8gEs9oigUzCe+r+yThoRp2AcRtrbrs3hS7Pk7alJdOs8PXO?=
 =?us-ascii?Q?2wADtZdsoKmptRqBnkmpCHh7RDaFM4TNlxBoHkULRKic/9LgS+iWMfgdF2XE?=
 =?us-ascii?Q?FQfs9RU5cvah3xQxVDi1YTQEYc6Joy95l+1YYCTtPQEsdh7S/7+F7/IWzCW9?=
 =?us-ascii?Q?sKkyhBUDD6oIqIYksTV17w6harMjWuakotNyTj90W/n4WzqAGbM28P0z9hE+?=
 =?us-ascii?Q?wy2ZcvEW9nhGsoKXGBmWA8yEKTQCjsp7e3s/96o0RI25qNP4YV0nddiMTfQJ?=
 =?us-ascii?Q?bs0rGvFOxOyikqG7Z8bPSGfyGxOCpv1jFT+CPGrn/CR04xIPsU/tlh9e1aHI?=
 =?us-ascii?Q?8DcWrQGtFA7Twca1ObQMAQ1UHCjk92sMshRto01jQ/r7giAvvM66jTES8kaW?=
 =?us-ascii?Q?HQ0uSKgp2Jr2wHm46lFt2dmQ5V94pkCnzrAyr0T0b7fRn3mYcI6liQQ92w5E?=
 =?us-ascii?Q?zSLPoAuj1gnMeyxbTKHA6Eve8/59kOoIS/jpi5g5PcSoIiIpdHKvQyIdHWYL?=
 =?us-ascii?Q?/ZalYHOslWMyiWPG0AJP0PiiebHmuoetxsM7hdXrJ1Gyub4HlQGN+rqyGhFB?=
 =?us-ascii?Q?oBXlZJyq3i3paPuoYqqtxfPvrunIYBt5SY/sVdpEbvu+3bMMAnSFRPsjd2VF?=
 =?us-ascii?Q?NT3UDIUjRKCkVio+BJX+cvaCaZmXLE4HuyXbLA1CdjIE0/TJzNHm9as/wwdk?=
 =?us-ascii?Q?s0vAffgTtWrWZ5lEY51ubPx+ek1bImDWwInUSYWupcE2KXLlBdpecnCh8f69?=
 =?us-ascii?Q?QYL/j29+n8G18a3rnAVWVJmnMZ/Y7ir4r/8umaiimSeRDPoGluWysnuX2D/g?=
 =?us-ascii?Q?dWl89ALdVjJHcFcRzFdNqRrS31Yg9LPCOAkX1DsVnUN0/1kMm9Ny6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB5128.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RdX+gLNlSte5Sx+KJJCehSnRIa4+Ef7UX2ijXzBmosq/BbAgqdn9fA7dLTtx?=
 =?us-ascii?Q?QsUsf506YKP4tLGnes7tm6QIwNjjjzEc/hEgiVZ2qI1+n+daVQIFg8DU+6Zy?=
 =?us-ascii?Q?L/lH/upBklOTdxn5I5wxJO8/Q4c3/c2RAoN/zqQhHjchp4KARnTQKDBWFlIV?=
 =?us-ascii?Q?U+sClUP+goEFiQuNyg1HuGjndWFnrpZqtFU67o3+yhH5g+9E6m6p2/yN/clv?=
 =?us-ascii?Q?1mEM8zuVovB/IVNZcTtFT7NxXSibrQmgy/CW9scryg3GqR1IRk82gqzzT/7b?=
 =?us-ascii?Q?uVD7+rjjy6P+sbfHM1GYlm6UtOGhKLmTanI6bbLSqHxHPcxXWzZ7jCCc09aU?=
 =?us-ascii?Q?wI1qlDA2q8bZSlAnMEyunshvuawkeehPlvnHxFFVEPxGKISXvMmMjBL+iqcV?=
 =?us-ascii?Q?IjJelcjRNwNOl+sF1J3SQzXzknVuvYPXN/lIqy7Fs7ap76TJm8rXtKtKpbWP?=
 =?us-ascii?Q?hHEBcl8Dys0hVLGM5BZLXujL7BnP0cIsmgP3KoxVbRJwrhDsudalyLKEwDQD?=
 =?us-ascii?Q?XS/1g4mx69I1mlq/hO7OQ5k472VruNnIt7I49v5uqH+nNdr9uXNsYoi1TpcC?=
 =?us-ascii?Q?oxftSaZwQ7hYIYf4HIZGdJSz7GSWUiTxV4z52r/sx4h4IQXs6CC56MeNFS+6?=
 =?us-ascii?Q?GUwSfvVBBtxBeXne1Yn/jMDklooNEpQ1j+SwTF/n8ZPN9u5hu/JRLK3kbAvn?=
 =?us-ascii?Q?epYLCaGgs8qY3WoaXm695fKBDEmfE8q/RxZv1NYCGzl8rk8V4BTMgxG4/KnW?=
 =?us-ascii?Q?WzcdFZGy74Pvxkhtw08zYiajePgKy4pYAn2yonQuP2qF9NpfjgmjnSeG9vlm?=
 =?us-ascii?Q?KojSaFUWpgRf4ly1vsik4UE4e3u5piNADRaBonk4hrMRB6RJyf2rkYfuw748?=
 =?us-ascii?Q?TADwyF4gTeLtQhIYu06O91O0XR4QuDH2nCA/4d9FRuznX5Vi1eLfHGGpwITW?=
 =?us-ascii?Q?cFFcWpClNr8Rc/t88E4zbuVpwENgtcFObK0QLgXQdFgoUIRKXfUJCFoz5QEW?=
 =?us-ascii?Q?08/r4QALwP+Egr3fL17BrSm1qxdE5NPkM/j74gbiWl03edw0SlbkisZfWKmC?=
 =?us-ascii?Q?mi+gvlmrzg4m7VwjMerUm29oIPuQq1YBqIK8yNN9NJbiGglxsNzK5uAQHn/1?=
 =?us-ascii?Q?4nRTfYpcRmne5/mc5wxlKZJjM33TpMwSj86AB6bcW+6u0PRgYoPyTA0Qeo+P?=
 =?us-ascii?Q?DXKXwL4hoQgJ+6FYLpqGmhMOetNChzvQ16z+WQHKiue+z2w41SZS1eqH7XZc?=
 =?us-ascii?Q?3U0HK6QLMjsxgNhwoFCVx//rhsZ0rL4R1JTupwo2WJ+w2OCQgX0MCJvZAtSu?=
 =?us-ascii?Q?YXFTrBr0SXvX2BGxQrvjAEQURCEUKDJpMxruyo9GvBK+Q4wpeZ9Lp/gKbsAN?=
 =?us-ascii?Q?q+feVxBGu3M0jGf2fFdQIakgfCBfkSe+JC2Rbrl2/GV3M6HxSnRR5ckytGpa?=
 =?us-ascii?Q?q2i1RXtuA3Ca9IxVlLulBYi+NzjFYB/Z0UjOYP2Aqsr+HjBDgOOEWPhXnrfn?=
 =?us-ascii?Q?lCHav7So3pb3gXN26E/oOQlEShZHamNjp61z8d3LR9OlEVEfxd6K+a78BMRy?=
 =?us-ascii?Q?JenwS9u7cPdBdQPqGFrkJ9iIohMJ9SD99zejZe4E?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4851ef8-c03c-4358-f4e3-08ddd8aeb6f8
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5128.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 08:11:46.4261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zN7nwmeNfHML66dUfHDQJL49bwpapaoodr+K/l/uPeH5gtyCIPitBOlJqT0AU6ALmN4bvVkagRW3dxlm+mQsPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6135

Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
GFP_NOWAIT implicitly include __GFP_NOWARN.

Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
`GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
redundant flags across subsystems.

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 block/bfq-iosched.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 3bf76902f07f..50e51047e1fe 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5847,8 +5847,7 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 			goto out;
 	}
 
-	bfqq = kmem_cache_alloc_node(bfq_pool,
-				     GFP_NOWAIT | __GFP_ZERO | __GFP_NOWARN,
+	bfqq = kmem_cache_alloc_node(bfq_pool, GFP_NOWAIT | __GFP_ZERO,
 				     bfqd->queue->node);
 
 	if (bfqq) {
-- 
2.34.1

