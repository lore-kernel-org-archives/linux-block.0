Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012051.outbound.protection.outlook.com [40.107.75.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA9C2C0264;
	Tue,  2 Sep 2025 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818587; cv=fail; b=ZxzOik7zC9hosFfWA3/FO7ntt05CwKlj2OtOHOpc4mXOwwb9TxbBYX6MLoLWP4JpeCW+U4c1sPbKSIoAHM1k8MfuASBKC9OpIbS0b1HyKTLT/S4YK2cfyO14D+sFM2+RM49FBnJmNH2Kzs4r47zLb6wwtMbnGmrh9Azw29xxkDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818587; c=relaxed/simple;
	bh=HIowVIqMPmAx00Z8bciNh7cK8aCoLorYYgVOPML0GTo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fox8Z6gJnJvMf82FwH60meHIo14UKV8MRiL7KESyH1skGvYUsEcuHICZYi6Ucq2WEhpORyxzODPJwEHGz9IeX2ZfvP+VWdWsmoCC6Gp3ZfQ8dWxExs33S5EXWT88sDfRtq/MotZT/NuR9vh9X+3fNtBlqfVxK1Y5wOpvil/tNYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=lN79BX0M; arc=fail smtp.client-ip=40.107.75.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lN79BX0M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkcFBkROGWOF08fvLOJ7slpLEVGinPVr7Q9sgFbSKUrw2QaKNLFsFbf2oa8J1ZGc834RxlcbdcDT5VddLXuXzXveuWLu+XV6scaU+96T+6DVlHuJ8+aCboaJIfXLdoSAtMBURiodDG0qg7Ee/iiW5Wt9A6IQqbYPU8cy8lC+YVgokvwACR8WCXu+4YsHYxBpbxCtlSeoMUUo0BUjb38aSGihRJI62AmkWgnEH7HUFPKehQCGgZ/lCnx3a2GwOTGhJeZlQAGnvOJogUx7Noi94Hl9lzkfpnuEO+xPJ47XW+kCyTKMHJ6msfd2wzw5H3nmIn2+KoPC5CgqotCcVbdz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaDvK12jQYaypVAm8TbT1yD9QO9sakcBK5DB9eYrQ2s=;
 b=t4o9n7a32HnrjnGhArO5H/jMFQIPK5hf5QW1w6Vtool4y1hlHFP7ocUKHLqHXZ9dV3VvLReKl8J6UQUZo7W4smSOeTaa92lJJg5kdW3JWsGljlf5/PgYvoDxN67vkhYegE54dP09edldgn4Hcouj1dGiyUoGOaefT/w0VQUjXcJ0BpGXKnmgkSMpHCWQa/zX8AL5m0tXpYppoRKNGMirLr145g5T30HnoiKslH1NGkrnlsnQhgRVd6/DHtERbreP1xJcO4sP4vr3b9YrmiWIvC0CbYdhHc34d5pgcnzBBcl+TB8vmvn7v6lPw59Ed0mAoopKD/rGn33NmNMNCqwEjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaDvK12jQYaypVAm8TbT1yD9QO9sakcBK5DB9eYrQ2s=;
 b=lN79BX0MPlg867lEejJHERWXWG6/lw44WP0nM1Zb3ONv2FKLR9wWbgKYmWkqZCsEFrSMMMqMJbVg3e3Qi5ySSwNpMIlhVa1bWxEQ+XeiikPOYcBmmqX6AV3MXK73V0q4KZR9ts07DYHVgum8+4jykGXlvS9Qe0fIrK5YWSL/FcvOAfDyZH8iRWNnTz4BhRvlejMyCYY2WaoGpyCEVBEbHgSvIbWiXcjaYEa6q6qGIOWulnOjKNXC1Z4RB/RuBP4oCl/4XS6a/KsIJy2jmm1NAS/LHwfwi/UlWrKqAjkib8PYuLGTsjYvD70ycDhWpMGW2c9zyMdiDgk6NVFw02WREA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 KL1PR06MB6323.apcprd06.prod.outlook.com (2603:1096:820:e4::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Tue, 2 Sep 2025 13:09:42 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 13:09:42 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] block: use int type to store negative value
Date: Tue,  2 Sep 2025 21:09:30 +0800
Message-Id: <20250902130930.68317-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0126.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::6) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|KL1PR06MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: e786b4f7-80e1-430f-c1f0-08ddea21fb0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rkEmsW5cu+8TZvFTT5nmHGzRhRsMEVemXnUs8eB1c7NRQcHNCuT1b6jclBRD?=
 =?us-ascii?Q?+g+iqrFk1DBsQbHu9sQ7nE5oXp2+cMVodIh1lBYB2EwL0dfJlgwsTNByAzUR?=
 =?us-ascii?Q?3zc8agnd2Qoekcv4G4g79ASqWnov4ffzgjx1Kp1egWlJ2BQyz/n3+aH9XIPf?=
 =?us-ascii?Q?Ag9xhMyvpFupm+CWxhfQdV3tMEyoR6um7zAwulo1+/w6UOXaZUpFCe5gHo2+?=
 =?us-ascii?Q?7Qo94E7a2o53hqLDu7Nx42VC4vaTi3WR474HSlzuUzoQ/JI9GB14bOP3MmFc?=
 =?us-ascii?Q?AgfT1AZs6lwlbD/AdQ+aGKY9ndvtMqYrZnujkrlevTeHdJUwFfpglLk1OX+6?=
 =?us-ascii?Q?PzcEjcNEtfiyRRz6YKxW4XGg7qRC6k/ACRIh335B5TYC5+OoCZY4TleC7cf/?=
 =?us-ascii?Q?iTx4QYATaCHwIDaWl+k0hGvvrGo0SuFlxCB4viEXszdv1Rg6e0Pw4Zgpq5SB?=
 =?us-ascii?Q?EHvlJDg5HwJHdVPyx/YM32R2XrrpC+yRsTdRmn0s4Oa59X0WDeolNYyLndOf?=
 =?us-ascii?Q?WaxbR07KMRuMIgJVWsT7VBvSJ5emJbh9w/oU1UAm5BNKyNBYUaQ351l8PzDQ?=
 =?us-ascii?Q?e0mwOcYHVj1hkWlOrUxTZVXRkCpmeY3eTeukn0Qw4yuFHHisZ/7fdT6MaBZY?=
 =?us-ascii?Q?bn2GCqHSZVOT4kMdh2EeCplfHyAB2Jm0D9vJJ03LE8n/wY28LZi7k37wfiC1?=
 =?us-ascii?Q?3YxDfAF1xqAmLTPFZx/rCcr4OGfDLRSN/PNI7b5J/gQm7Tmq9ZOoZOINhXJQ?=
 =?us-ascii?Q?qOZroD/NlJkwGDbqkp73Gyric2phXYDx8j1XsIx/Yz2xxbaG2mE2FKCr38DL?=
 =?us-ascii?Q?/2xfOhaxYFSHsNhSLv/Z78zK4WBuSRRWDHbSSrjsEQowSqVIJass/RYmkQGu?=
 =?us-ascii?Q?wLlOWCEDQczKZ6L2vbCqH5yZu2RvfkoHEn8DeOgARrH+StK+r9KXF3xNDvtg?=
 =?us-ascii?Q?5UPyNxzNHqhFSwowDwTYVzXpBVSXRBVagkEOcbEDqemdPsGsDsKGeegt1XSK?=
 =?us-ascii?Q?9agtIbOKgTzjXhGP4GARePZqkJQRDmVvPf/mY/q3Z1XsKQb/o5H/i0weqP7t?=
 =?us-ascii?Q?XrmzBTQPXTUBbplkMdrBTJ/zGQYgu3AFUa66eNhZxQNzV89sw8EqXPdmScMr?=
 =?us-ascii?Q?5usYcWgo29ZcvF00rfkWpzG3NH25um9+EZp+YK2O+xQq43o/wen2a0Oh5t1L?=
 =?us-ascii?Q?VmS5BhYDs4biHGCvNQWK51nUXKtfHNeU+z5i/noOfbJyT3ZYXm3ZXgaWEPsE?=
 =?us-ascii?Q?ESC3De2qHh5TUAjkMXvMSKe3vVF9qnoqLJvdPk32osIc42HeShFjJoeSqQHy?=
 =?us-ascii?Q?oMiZsqe9CRahyUwuHaqMJA58F9w8H6EGCT/XnYf/FMP+bVcOHLnSIp0cq71R?=
 =?us-ascii?Q?l8a5JPSMgLaJf76hPx28WLtpudwweFX7st30jgSPVC6Mo9qbVhyz4CYroKRN?=
 =?us-ascii?Q?LPsO2sx5GK4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5y7kQrPXF3aULoUE4xs9T3wmDNJXe7J2yYzG35b4Lq8lUruSqoVtFW9IeAXF?=
 =?us-ascii?Q?bzQTyRkgATs1E4zg283fvljVcgTimuh5vq2/t00Nsj7w3TDAkmcrcqXrM+mh?=
 =?us-ascii?Q?6WZIl7nnvYznMAu245LPFKO6iB7rGHIvizqYGp1LPTI0Ctea6sVDT+u79UxL?=
 =?us-ascii?Q?ndSDMxJ7i84fceImcKoAu3Xusw+vtsYOV7ZtSLDK0WckhbcZu18A5SXIwZw0?=
 =?us-ascii?Q?xN5oCk55Lwe0LiurVRqB733bs3qybdsnFosbtZAPrWiYevBKyDt4NnHyKcG1?=
 =?us-ascii?Q?hZjYgP2J969BEuwgwntQXNRPVhe2RR504Oji5V9CZg2Tv6dNjy5Q94rE5tQ5?=
 =?us-ascii?Q?Ob8T0RGJ0Rkq6X3hbK2ozZlJmlj2hV0jOvB8RBoFxGYuJSIrl4KxTMtHGy4q?=
 =?us-ascii?Q?eTPx7WRlZ6T2G1uWNmrWt4RXU+3xp8AvAojr3eL6EQNljyr07EMQl6IZQUot?=
 =?us-ascii?Q?RzIVze41rkrxiVmYEUYqECkBJnchmhOXZdy5OQhq11fbFnpyGWfnW19L7kJr?=
 =?us-ascii?Q?cRZey0By5jDN697ADFmz1pPSvXG7mKbHxgH/ZKP1UCROyBvhptKAACQwi0QB?=
 =?us-ascii?Q?hPRZOZkj23JMAFSGAFgOc1jGv3HTpdvkvcBFDHU66m3GUmyZXaAqX0zkOgeq?=
 =?us-ascii?Q?EZpbJ+9TiMbqW5LMgTXrFrxdm2yvSPHmgbq0/cV5RurOoFiJoLqO8c+u0yhG?=
 =?us-ascii?Q?uwdJ/yzCxI5ctryagfWpsnPYbe+nEeC+PgSCW5AHy+weEJhO/NzI9rTp7/dM?=
 =?us-ascii?Q?GoafBNq0DjO3GRybrQQ+zzqWFemVI8D0StasY4neSGg/SFLoYKzeekcyKwrR?=
 =?us-ascii?Q?/XR8C/l0BkL8DdLIBOxPz1dy6C6I0RgfYCegcKAsUCVVUAarLqFYKxVjwNLs?=
 =?us-ascii?Q?8Ks2umKzoNhuAZ0nC9geCUirpu7+nf77oGRy8hegAoaKTCsMiZcv+LKFPCm2?=
 =?us-ascii?Q?wgaeuf9qhGYY650BsUgGAU+s7oNh1paFZP+X8irOL6R98mrZa1Jxp93VzZn5?=
 =?us-ascii?Q?EGVJg3h0EQ135tEnqNLdu3KjBhggZ7I2q0PRSk+xnIy09WmKsx2p4aTB5ccq?=
 =?us-ascii?Q?B6YP+nTzia9X4M3pPGdY2tuhWwuw4RJ0FGQajwcjm1zFd5RyiAvJlpqjI8sU?=
 =?us-ascii?Q?0r8ysQnC7oA19K2jEJMXHDds2+t6YjRRdNwJrGpfWe3U6IOKj1FrRjnfp3Tp?=
 =?us-ascii?Q?C6G7q2h6DEpNHt99s/gwKmwnMaI2pIqfIISve9FYeo4ebqXL/yGLP/WsN46y?=
 =?us-ascii?Q?Sw4IhroVzWSDc4OlR1hkupRSHEviBz6Rpa71B9FEP55Nc94eX1ovpDtff84p?=
 =?us-ascii?Q?ykBd4eqBKHezXKHk2L1K+Zy4U/OdSCDfPgLe0SDJeQOZx1AcUeAgNLMO2xyr?=
 =?us-ascii?Q?aMcq7PDuVYIyooUWnHFU4YhsdId5iCW8VxPWvSLmi/xW8oY4X3JlApgC79X4?=
 =?us-ascii?Q?9RoEN56AGPrj+EB3eMLacDmIm9davbVkgkTRXKnUCiIpoWSr7TvQsSN16Ysk?=
 =?us-ascii?Q?JzoDVNwn8UQ5E4zDkRswargQKwKZiX0cvRRQvLH9xeQPyxfjLagEGgqVdikq?=
 =?us-ascii?Q?/3ATViprCDk+QBmwsQesAFmFuIUtvAIv9mnwEGYC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e786b4f7-80e1-430f-c1f0-08ddea21fb0f
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:09:42.7295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvEDfZz6Xl/LfdeQL3uDjEqVULaYafxIA6fE+uF/A0RGQR7/09UWd4caRQRqaAp/qMjManzjnkliWBPxW6ApHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6323

Change the 'ret' variable in blk_stack_limits() from unsigned int to int,
as it needs to store negative value -1.

Storing the negative error codes in unsigned type, or performing equality
comparisons (e.g., ret == -1), doesn't cause an issue at runtime [1] but
can be confusing.  Additionally, assigning negative error codes to unsigned
type may trigger a GCC warning when the -Wsign-conversion flag is enabled.

No effect on runtime.

Link: https://lore.kernel.org/all/x3wogjf6vgpkisdhg3abzrx7v7zktmdnfmqeih5kosszmagqfs@oh3qxrgzkikf/ #1
Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 block/blk-settings.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index d6438e6c276d..693bc8d20acf 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -763,7 +763,8 @@ static void blk_stack_atomic_writes_limits(struct queue_limits *t,
 int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 		     sector_t start)
 {
-	unsigned int top, bottom, alignment, ret = 0;
+	unsigned int top, bottom, alignment;
+	int ret = 0;
 
 	t->features |= (b->features & BLK_FEAT_INHERIT_MASK);
 
-- 
2.34.1

