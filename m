Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013020.outbound.protection.outlook.com [52.101.127.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C3B2A8C1;
	Fri,  1 Aug 2025 07:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754033624; cv=fail; b=twsX2SjV4HNK/cRCJ8oPOaJYGEmk3zHog6GMSdZ4x7LItXY+axL944goHgkLv2jte20UFavCn5Mkv8gpAMaUMzSsVswlfrsdLKWWNxcbe7ZqFTOShZr4TilRxqjbeMkwIDrz5L/z8zCmqpX8oUHRAbLglMntu/5TS0hqXnHsDZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754033624; c=relaxed/simple;
	bh=lY2ddHEU136qPP9M8vPyenedrgL4HnD74Q3nqaIaA+g=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bsAjqTtek3qjgD0ZBqiUjBIGLYhXNLGdpKeVGSsOuSqHwpDpKu8Fbcp4OkoOar7fFPP7LIYsa9UGQGyJVMp0FwdwsaMn0LHuzKqC0q7ZM1d8J0YDtXvoF9vmGaQy5YcOq0Il+UFBdHdgipoKRgVZbIiz20jGN2t3Q1S2zS8/mcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=O+TQTpdj; arc=fail smtp.client-ip=52.101.127.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="O+TQTpdj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRWfz7egzjFf7HTqZdkjrH8WvCXE5s6mDzIrpZCPt4aJQrYyH9IDYklqviagG/F2lJ4jJ88DtTz5LRuTI0G922VOFRuRE83DhzCRTJ3f7XcRoggECvT0nirbmks8ChLUULi1otDmr0CSlEsOBqMTaTpHwVygpXohnj/uC3NEDZDnhJwMPHdB1v0wu0rJW5j5TygFXBoZJJC9EzynyauVHtn42NQTUNAI0o7hhlBh09+1T130I/fXsZxh308YVUc/zuC+1SOCNMXRxviuVTFhwHCVJB4jvl879Gqq9n40UjR9QCylW523y4lG8LDudyPn48IV1DNQ5hPuAkoKYav+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GqGfK0FRu32qBvkfGHxm7ccblsKIEgCVdsBVAvR5vE=;
 b=cGhgiCLTdKXSvYVc2mjBCnQ58zY+J0pQaWUSVA+W+T4Uju6V0SXnFM3pyMZC2wHNG1SeTO7iHm22MjT279nk6IcaaGJlo5UKPao7e+DjBpIaqkuyQ6m5/gWeQMJZAdzSXxG8s3c19HvUKBgyPo03EiU2iMBSPipyOEeLI1DOv4pFZTvF7Mf4dG9Xeg1QN00MXiuvCJ+6v3eS62kpp1J724KsQIZUrOoeer8FHGixQmqcqQLNSivVkfCbq32W3RzqWMND8sGYqLQwm5yMhOQBeVbxZAcCCCxAzR/t3DfVxa/bnu3sdbdjW3YqZpeth8GbKvHFtDpDa07DmpVWNr0UfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GqGfK0FRu32qBvkfGHxm7ccblsKIEgCVdsBVAvR5vE=;
 b=O+TQTpdjxv6+hY0zDixFMgdsoKZ60/byYs0Dq01kW/0g7gdCg73rzmryRgndKIikZ1eg/Xco68JWn9hHsadp9ZvDy+hKQ4X9nDC0d1+Nn0TeZKk3VZr49fvMi3lzQ0qRcL4VF+RHB511LOlH/59e5u3/5AQeCXkDpE6EkkGNKXbIRbMWAoGdgnuxH2X1A3Fp0b1NXucjN+IjEI+d3QLlVpZPMWJvHTy0l9wF5joddrsaJhu1ovjibd3wVftuzAc1e7ciIffF9li6eOkdP4kACuOQmjBvrk8A5gc8hwXcLWnjCcqLmuVa5Ufs8SPic+p15lD49vFtDsY7TZCkYf7fsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB7008.apcprd06.prod.outlook.com (2603:1096:400:469::8)
 by JH0PR06MB7351.apcprd06.prod.outlook.com (2603:1096:990:a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 1 Aug
 2025 07:33:38 +0000
Received: from TYSPR06MB7008.apcprd06.prod.outlook.com
 ([fe80::41f3:1597:2953:65f2]) by TYSPR06MB7008.apcprd06.prod.outlook.com
 ([fe80::41f3:1597:2953:65f2%4]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 07:33:38 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: ldm@flatcap.org,
	axboe@kernel.dk
Cc: linux-ntfs-dev@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] block/partitions/ldm: Use bool as the function return type
Date: Fri,  1 Aug 2025 15:33:28 +0800
Message-Id: <20250801073328.503850-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::16) To TYSPR06MB7008.apcprd06.prod.outlook.com
 (2603:1096:400:469::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR06MB7008:EE_|JH0PR06MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f579978-5aa2-4cdc-f865-08ddd0cdbb36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MuXg0TZ9BVJeCJCXZ/3TK4Vmq+Hwvi1uYSBUEWWk5TvJWKaugE5Y6lj6wM9A?=
 =?us-ascii?Q?K3E08LKzUIIG5K0SafuldWnOKkZW1HQFXMnP8HtH229b6wcbUMb60DTnjktx?=
 =?us-ascii?Q?GkCd1xdBdd6uwgkB/vWqYkAzl4QNrU5883Ib0zLdpIbfui1PvAcexXqRZ8/N?=
 =?us-ascii?Q?+RJqpygbuYMTiZP4E335j2ZEZpOjcauTZcWfZUNzYcuMu79u1Cl51IbedZvy?=
 =?us-ascii?Q?zwl2uoWfruccRPguc9eTFml9CH9B5q8JQGBrsRmj6LFwlcdCvSX+5ls6crmc?=
 =?us-ascii?Q?LzOrHaWbVWGjSjGgiTsJ1U6GDht4a4rKO2+XwhXLJ1013VBbCUwXPLDevX6N?=
 =?us-ascii?Q?3Nf9U3MuKunhC/VHkZCljZ6DKPSK1VEkpZo5dw8FaKwh5gCL4GZSyo5oPXHd?=
 =?us-ascii?Q?AIiOaURcH7BTciRGlZSV81UCO+JZEifC2yLe/PyvxcAv14eGh3QOF9ZyPJkc?=
 =?us-ascii?Q?sNSTfjeCPkj4b/rFE0oGhLnfYjEwJZWoQMBAzhRiI17fXPIRJvsz/6/yxcww?=
 =?us-ascii?Q?HIlqVP3KNwmcVwFkkPlpXpA7w8Xja3QlG6JcBdlt0DXOGCNnMDPri6psTYcs?=
 =?us-ascii?Q?z3B65fZGHmpgA+N/+tuH2+Ra6rWdMqsPMTFLiUy4SUwGUz88YTQq1QxFK2Vu?=
 =?us-ascii?Q?ugg6x54Uxeq0h4zObeXIQ5y1SWsz+6B/BMPTTK9K4n6Xlh86BBUT3Y7Eo13I?=
 =?us-ascii?Q?JVXNhr7wyZ8aZ+nharvj+KwXXL9UpNlxf1mAflvHY89hwcyAHBC9DRun6Zfo?=
 =?us-ascii?Q?yDcCleGR+xxb/64lwmNdYzkB0uYIescNNC+COKb4Zp54NCI1143zAYkGlS8H?=
 =?us-ascii?Q?T175i7Y9tNlVlz9TvmlpXvqXLm+Rat5I0jIx+H6lPM3mltCvEtHuWmOC8suO?=
 =?us-ascii?Q?EKK/3ktVT+znOQS4jYJVMjengKUTDYf7Ml/skd5iV/dnYbC773gCwUzaV1FS?=
 =?us-ascii?Q?sZtf0mG2EI0vbL+pSpaJc7ilxZFZyxYoVg8gzEYz8uDB/7FRUFRgM/Eyd7FF?=
 =?us-ascii?Q?2Subww537bPINKpFMe70QWixikue3zxnortUI4BFmOEYs+/lyfugNFAmEZ7/?=
 =?us-ascii?Q?wwW980qS6dOs6+WIDIX8ydL546EB2s6Y8Kp/BCerZlibxtZ7QLH7TFAKjDX/?=
 =?us-ascii?Q?qzvjrL1R0wdKILyOVZ4/1zGjh51eNd5iOOi/FGC2eJVxPBmO3CtSYa+d6PKK?=
 =?us-ascii?Q?wWQ+vdbxk/XGp3fwQpWsyTsaXySOHuBPfjUIhqWtMlWlt/KQ7JQNy+k7Rlmu?=
 =?us-ascii?Q?k8+cvHYQjWuqH/li0YY0i4SWR2eHi7S2Aa0db9jxBbCqiTxqvmHucb4e/Fdc?=
 =?us-ascii?Q?NRMorGtczguxQ7PUE2kAG/YGaIDohCl7Mdw6XrCIQPj+Lc8JrlTT5N51ZOXd?=
 =?us-ascii?Q?YMYrMKiLhwTHyySFcDQYig35Q6GJmjP1SGzohogrR5hk4Xn/gmgZsr+bOLDX?=
 =?us-ascii?Q?IweDwW8/ntzuJGOnVFGloPSYd4dSbq+sOcHIRUebTB/0/P9E95Lwhg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB7008.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PBXvBwbj9y8K3RsbpwQWf+G/9f3egmroi1iw1i4e3BbsCVSK0l1GuRIO+FUW?=
 =?us-ascii?Q?Ulv4eEvXyBGBQULkLASO8fVboC3aeN5A0TE2XQIPyiipaXZHEDPH3y0iyQq4?=
 =?us-ascii?Q?OFrFi7sKx+tmfEG+BD7rw3BZi0UIkXmLDI/CrH2sGpiLKS44FKCTx92gyD47?=
 =?us-ascii?Q?OY2b1xKkhWXwFCGiGOy9rstkJNeCgiW5k290Xtt2t5dOFowllo2rSEIxJgCL?=
 =?us-ascii?Q?gSObq94fEFcmek9isi7HfJebnFBVN8hkx/osUf5wZ6q6bX2jAqhhF7s5vmB3?=
 =?us-ascii?Q?oNkNXEgAD3lMlXZyW82sfcJCOSYJRW+TFL7KtCmHQsvUkyt+Ib8WjVqjoIDX?=
 =?us-ascii?Q?FfU6jQljm3knn1Ccl3yTwVH+TbElCdmW6lK1CHSsoR+kRAsgEmkMuSQFigz/?=
 =?us-ascii?Q?0aqnKCdy8Xs+1Baw+wLZ493CKeISWDES/mbijW7S4e/rLqObzOMx8mzGhEdY?=
 =?us-ascii?Q?DW6gjVqNm1+5AdEmj+2tuRNhWaptNrCLhipWMakj+/sa6T5UZ0NIR41jDJUo?=
 =?us-ascii?Q?Brx0TvoBIc0isNtzsrpKuKWqQMoC5U71+1r7WLzoMnv/1BMhXfckjmremUak?=
 =?us-ascii?Q?wcwlFd/3H+GSzfjGzA13eG02Mo73axJFOlmuxYCHEs813nHAiIluKgSjDoes?=
 =?us-ascii?Q?rEvE2WXFmtkMBBhoKWpJoLb5VU/0Dx210qVQDYGgpbjQPaP6O+qw1J1MGYlg?=
 =?us-ascii?Q?35CfCpAQwxDy9gg2o+nD4gHzD9gqFJo6Xxa05hsK9nFZ+K9DkFi5sC1Qjh3S?=
 =?us-ascii?Q?dvyTJBqDOJkH8SAP2RaStzOCYRCuTJA6ky4OR/tOixHeXW31JH8pV3AwirKV?=
 =?us-ascii?Q?inAZj9rHWxwrjF3EXVa5cd15eJXMC9oW53IuDV6TBtoXQVcZUsD+j6LX4Wie?=
 =?us-ascii?Q?quzaQS+fabFFf+J2cMIsg6nCj1ki1KOJv2fLUk6klzCgq+MYN5KlQ21QGc7a?=
 =?us-ascii?Q?lCmN2cfQMRusn2gZI3AAZF0koci/+tjESFA9wR+4fFFTBgU6jaYLZxaJ3yQG?=
 =?us-ascii?Q?APVZPX/IdXW/G0VD0p9GP7Q7j1estJLE313M/sMUkXXLjX8b2aSIJPjd+C74?=
 =?us-ascii?Q?PyrivZdhRy45s9hGvdUkbqJg6ZL/QWzHpypbXCI8nnotiOtqEkoufA5P/mLi?=
 =?us-ascii?Q?tz3OyqPfM/OALgXAS/cRFaAtsCrV5DgSe2S8/k4FBuywddjw+QxC1B3MQdRb?=
 =?us-ascii?Q?Z3IV38Y4Mg8DSKTB45DySgOFNNuEm2BoZm0gY2TSJjSj0erDUv0aWUapvVBO?=
 =?us-ascii?Q?lSinW6GwABcXItRhTfPgzL0QBxqZHY+Z7MPD7jMKUz/Mb4QdUp3YbGwrFwxr?=
 =?us-ascii?Q?egnUOXibFcK5UiJwgtMw9CQeET9GR/+meonxuoDVCL4+7oYDribnqsqklJI7?=
 =?us-ascii?Q?jncgnnhK/dHWt4WHxi1eHLv6MuhrmBCedDfmIIazhQeFc0GjhxqHSjmBaisY?=
 =?us-ascii?Q?spmE/0fVfImiiX7QrTJ6hZ2dFd53gisVVOgFKgE15TjPg5xBhQ2nfxman1dM?=
 =?us-ascii?Q?bHaNwSGgj+b8lFswJBislL8R96QEcPsem5kRDI3wcTlbxQTTpRdkpiMv5VGb?=
 =?us-ascii?Q?hY6eZhNzEh8tDoKITTHDcFVqOEQYq2zZLKn4eix7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f579978-5aa2-4cdc-f865-08ddd0cdbb36
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB7008.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 07:33:38.6221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yn+wk//3kk9Ogxh7BstrhHtFUEcUAtMPSjTLZ1Bx/phOTpOceBvvT2QkU286kPiaEJYR+N23WtFOMok3/644Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7351

The function only returns true and false, and the places using the
function also expect a bool return type. Therefore, the function's
return type is changed from int to bool.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 block/partitions/ldm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
index 2bd42fedb907..bfcdee4c29db 100644
--- a/block/partitions/ldm.c
+++ b/block/partitions/ldm.c
@@ -765,7 +765,7 @@ static bool ldm_parse_cmp3 (const u8 *buffer, int buflen, struct vblk *vb)
  * Return:  'true'   @vb contains a Disk Group VBLK
  *          'false'  @vb contents are not defined
  */
-static int ldm_parse_dgr3 (const u8 *buffer, int buflen, struct vblk *vb)
+static bool ldm_parse_dgr3 (const u8 *buffer, int buflen, struct vblk *vb)
 {
 	int r_objid, r_name, r_diskid, r_id1, r_id2, len;
 	struct vblk_dgrp *dgrp;
-- 
2.34.1

