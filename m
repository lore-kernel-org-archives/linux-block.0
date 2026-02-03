Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011048.outbound.protection.outlook.com [52.101.65.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD4E318152;
	Tue,  3 Feb 2026 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114425; cv=fail; b=c0RP+qsmbGiOQM6YGR3X+/zo5EYfgnalDNdWZpZO7Ou4YTubpZ9ug0aipRTzZOpU/Fixh7pG0kre2EQrYYgKrZFQu4X3A0l+MwH+CkF/0PaNvagab9p2ORw8llCKsKkGhIsp3INTL7fR63h6sy9pNzawjuBnZYOSWw/hOiGA+yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114425; c=relaxed/simple;
	bh=0gabG0FyllZJjXyjZYRDGgYrUKm5+6VgfcgJVhGsUUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EXx9DnkqYHWW6Z/Ga/0yZlwEX5yVa0VT1oThSGnmCw0zJZltnJJq8fRl6joNq7Nxxs7Y23FB+yDWxKD0MXvx6BCwYIk4y/NM1tRIpXcJgl3R1rFnyGnoP+sYrNMrKHJ8s3zMbYtZrxuBBjUmY0v3lEUguRFcorxpXdkWUjrG8NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BdxMaHMW; arc=fail smtp.client-ip=52.101.65.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BdxMaHMW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s76u1YYJm1bLDjRNzYNg6QsEfZwGWugShUFHXXyZKpe6Mi/gf9CSFipHAK4FBx+YaBrW0waiHZLO6xvYXGc/N9HuX92aclnqAzMB1NzorbY9K2PzK43S5ua1Xt3Pyt2pyz4hiF7wk1InOA8RmSLgApFWwVYsWC9yBU/nEFZG+BVqm0Wq0ImyxaYFbi4Yns+cj0nO0jDhRIN8pRfLn95v+EV74OdRuA9YFfhNw9NrklJ9t3ExaRNGerDWSz7l59vfQnvKahWM68qc2oNSS7+bd1nu5jHTskSeZ5JcgQEcwIRNbHkbQW9gUUTUHZvlcm58kaImow0Gd4iz4DiDdOu+kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QNknnqP/s/mowL8OKisM7t2zjYlIqX67P1z7LErTcY=;
 b=PUBYe2ofMuVXbR6kSlKsKV06Kcs9D/yDD+vpqqlm1l110Cq7a9sGbHstcrOaRGykYJvGvbxK1VK6AIQMAwivsbkphR5D1M1/P4k/FOSpqIFIHrUJ0dVuwTorS3dW3bJedGST3F2ybuR3G9XJHaGX0/OLJnRvUbIQ6JtkaR6Dq0Z17zWZLrhSsEYL7cOzt2RT4QPJhm9wcqVBF6HHahlhaW/w68NY7Yg1qS8XPj7QDnHDQkI8N1UqiHgA4OZO35dq5WeULZJY+BF867dJhLrK+isiRmRflSGzZGawmnphS/RzrUDvsFfwk9e2xOmSwr7rMhNQLRHEKXC4jBRSkOpvxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QNknnqP/s/mowL8OKisM7t2zjYlIqX67P1z7LErTcY=;
 b=BdxMaHMWlNh+PeGd6J0fJXHFzSZdwHDOu4HVLgg1LJFzgdlBp4ZyuwyViMRhsXQMo6OjCgATTSRpkqlVA8wE+Z2LjXPPEZwGq4VpSokCmm3/6nqcqow8fCNXRQLZ7xbtlPplZmeOkC0rbBrRUOPIBm01xUrb8B0BIqp1T3FO16qzrLQ7zGIBuFV/y977JMxrkZxo7fHc7sxmhfUtys9KdkbJNMUkoxPZPDJILrTW0BcrxLQxkL3Frcx9vsEO7imKh/xUBEDmW+6EVx1WiANsWIm3/gnLvCHLjwubfA3AW+EqEK2vbIzSPkBdGQnifieBTNo/EFAWGCYAP88UFXENFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by PAXPR04MB8720.eurprd04.prod.outlook.com (2603:10a6:102:21f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 10:27:01 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%2]) with mapi id 15.20.9542.008; Tue, 3 Feb 2026
 10:27:01 +0000
From: ziniu.wang_1@nxp.com
To: axboe@kernel.dk,
	ulf.hansson@linaro.org,
	hch@infradead.org
Cc: linux-block@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v3 1/2] block: decouple secure erase size limit from discard size limit
Date: Tue,  3 Feb 2026 18:29:02 +0800
Message-Id: <20260203102903.2953660-2-ziniu.wang_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 58fff773-4918-4c8d-14be-08de630ec44f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vm0i2Kz3N+DD0ImwmGlkLFifKifxo9FOxKQwvSNK/0gXp4ZOxk/So3rpjMhG?=
 =?us-ascii?Q?rd/uKyLbTNrB87LPjmhrkyXzmClNQo9NXAL8eSefI0dznzV0HSt5Vhv9OplK?=
 =?us-ascii?Q?mrWQBieKilPoJLKyhsQailS+2Q8GGQXVbkPMoFp5AfrkpiLgKfSTP01Ag8Np?=
 =?us-ascii?Q?bSfSnC7iuxbPbgP9WEMRDQNgZiMDfdLecQafpLoTGO315UXi65hhmybCrINg?=
 =?us-ascii?Q?oQL9+W61AjD/0tO8MLk/UPQzXY6xaRxlqNloBDpbIKC4ynDFMiS0Ao4kQLir?=
 =?us-ascii?Q?gdh5FnvnE+NVXh4n9kDvK0USObE24LSuqt8AkRvtjVXR0H3ghOxLRAKKtWoJ?=
 =?us-ascii?Q?leJAGDZBL+auVNoI+e1Ij45fDtqEK7kCHSphYHJmL++NWCwLSfg1hR2UObhP?=
 =?us-ascii?Q?6iCwKrRw0gRgWY2SGSPQJZeMzLuedYWjm3SwpQFbzcOSNTgCHVRrUIsGQhYQ?=
 =?us-ascii?Q?CxrCdWVYPtV9UT5GTB6Smw5voP8jHG1BXF3wCkYNvXx6hI1MCbKnzWuL1m76?=
 =?us-ascii?Q?fGTtVxJDVU4GO9V+aUZhiRYERbi8KGIIAQyeF9GM2sf2gLYs/iTHISFtHPqu?=
 =?us-ascii?Q?i0XDPgcLr8CStHIUIQGa/xbSMTDl9wKjSa1y+CFEMIQK7WbNYi0H1QbFitie?=
 =?us-ascii?Q?dF4yWnBR7bbdsrL13i2Xf3T0W1Gn27UjN8JW4FMs0pK1dnuXPn7o+jmNahMO?=
 =?us-ascii?Q?trl3ypNeZBOZGQ+x3UVoxcE+tAPMNqFKfy84PdkXG30M6mthMpu1V+QDUgF6?=
 =?us-ascii?Q?2vnvjHFon9YOVpdgWVdd7x6ibeey2jNfX2sIWzrsHlxQ4NEN/RlRs6zqlmEx?=
 =?us-ascii?Q?pvlD0k5z0EGzsLy8nz+mMuoz1XYngPadyIpFU26R9TxJSqU2kqnpPqWXj4fI?=
 =?us-ascii?Q?Bg1V6VItK6Bktp1983OALRRWTbIXvOkDlFb+GnWS3BPiEGhIcENZW9xHClOc?=
 =?us-ascii?Q?t6mK5ZbwhjnmsfZb0qZtxeqqQXtp5jViLvVsQ0+1FTUyfkTazPaVNTVRIvpb?=
 =?us-ascii?Q?Y4wV3asm3X981KCckKwBBhr6g5lPvq4XrUeETPBDKjsNOqJk6En/hxxaIXDk?=
 =?us-ascii?Q?bLzhIdBjezDzLVk6wrmk8ZsWXDOVlj6NvgyU4A9VLz/epUm5GeH3qyiQ8UOi?=
 =?us-ascii?Q?LgndlEDJMWDO0IgFNsulZt3UAwUBIhjYB1WrYEJQXkwx7k0CMIj4Fyk4ac8k?=
 =?us-ascii?Q?LexlzeEbc/aMfX8P33Qg8aJgItic6yGmVjDiT5UVkKcFWsBNbtv+2BmD8IXO?=
 =?us-ascii?Q?JP8OpGxB3fPtw34ImHl3ZkFwvB5z1HqaqeH0REO/44DwLLha60oczrHoQgmL?=
 =?us-ascii?Q?FPkug/KYlcb6KK+pFMogS3D2bwm9haCO6EtzPYpEN0/KhZ4Zo1YRs5hmrwy0?=
 =?us-ascii?Q?e1xehLwG1Vc5zTpbeIK+C1IbphtaaEZJWQFgPiYFC6cVWE/CZoE0mivKOB8e?=
 =?us-ascii?Q?onixkYoVJnUjFoj8Lco24xsB54+8YAbSHAtkzD8R36K7qZ//ts8c1d2Z4KOW?=
 =?us-ascii?Q?Iv8Gqyml1mBdBuY9bdiJ8fp2XnRLVYG3SqzYsxvVnX+zl0ixZ+Eht32adP3N?=
 =?us-ascii?Q?q2b53ZegN6lDOmuwq1Pj0JaBTOTKo1DYxNYQNatbNlMPr6L4n1D6ONReRWLA?=
 =?us-ascii?Q?V5iUQkphvCjxPC6AnuX1HwE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Lh72wt8rg8x+BW9ERWFbSQtzl9GENI9sHBuK6+kUjalqX305EyYyHlnmRpq?=
 =?us-ascii?Q?AsZtk+E92BM8EBe5XyePZdSkrdcGvds83t+KxAvzZFDOwGASTKxyzRFFzmz8?=
 =?us-ascii?Q?wca0j07B0117pxf9N5+qYaOzpbrvYFQfqSDST5cAiKkjvt8z81+BrHprOomQ?=
 =?us-ascii?Q?fLIUMs2NL1+S46pk+5Vmk0EzC8i7H3qHSjvF56DX5OYtejCLxMCsvIMEvRwp?=
 =?us-ascii?Q?B5vWVGGoCdDx9A7zBtfFKddkmBzWwTS58EO2hRTM3sC/CD3hszvwl7GIBBjx?=
 =?us-ascii?Q?csx0mW+ow5LN5wulfR4HkZikszfsdqXP2DF06gmu8Uzmt0imXKo5b5ZLuWV9?=
 =?us-ascii?Q?9tLSe8tjH1SKT8Iel4y7q6629I7Xs67GlfbT7pgO6nDCg4Ghfy+YK5XHDnmY?=
 =?us-ascii?Q?zbneMcOHclel3togUtHZN0tO/zcRekyJPi1IrD2SvMcthrcRsEm47gtKtXtW?=
 =?us-ascii?Q?QGkSoL2bcH/VLBTBFtk6FrKPaYoslgK45K47sO65aHgiNV/a40yti2hHH04Y?=
 =?us-ascii?Q?Gv/Zq50XDWaj4i7U3ikyWM/mlZUqSXwqMtOVId059pUA+4uA4SbCFgO+liwO?=
 =?us-ascii?Q?skw1L7gFGsUKuQjzG8QqwomD9B+DR4KV2W4Wz9yvYZ/KoQ/hPPSV7wnzSSHd?=
 =?us-ascii?Q?trc/+x/pQOCVra5RWukUlJoUmyjHN4YbsE9eolmBJRgEHe804o6LOUt+zuwN?=
 =?us-ascii?Q?W4gOzw6iHChSEa8tpDxnwaUxG6eTFuG3YYkT6ZAfU91t7bmf5XLhwZJX6KKp?=
 =?us-ascii?Q?7PwwKg+fhQb02xafjhXv822PJbgoBM7wBeXNqd0tsosdVSaGFTeIlTuIfBzI?=
 =?us-ascii?Q?foqSIvLXIFR/G3CHETGf/8ypgr0nK6Rb008KeP0rxuPyq9t5Va2HM6yjBgyX?=
 =?us-ascii?Q?hQyteMBpInu8UcB6xwLI1zUq+MkhuZ19HCAU56ImNZ9DjSQ1Kr+DE7ww/B73?=
 =?us-ascii?Q?fGNcSekGoCaTaxwwp1ZAgYOmeARd2fH2VR5cMmMB7oyCRRm5B+n0AE1gv74N?=
 =?us-ascii?Q?v7THl5RpUe0OmgwUgMp0VVf55aFYRDjuOx+rqF3+yzE9UWN/T2hfXwZ1gd+s?=
 =?us-ascii?Q?Mo7g9kyjvdDjPZ5TEle6dtZC2oP4z9MEV01qQyUK/t6IbUYaIOUIMdqv9Nqk?=
 =?us-ascii?Q?4SU01W79lrAZVF8REyqIRtT1qczjKy6IV6S1ZkO1Jxrrsfcrx4lXAiqw8R+J?=
 =?us-ascii?Q?bERbPU/Neg7x1ggf2tvSYPlM6jGWQX9MszWwZ4lc1ZT0KnyWKxZHVkBdYB2/?=
 =?us-ascii?Q?XGLeSPPbBCAv6wv/ZbX7bzNUiWqBjEq1IL3kfti78eHG5ig8ytFmqgvWwb1L?=
 =?us-ascii?Q?OTqYo2y042XxpxYWSanYB8PQf0szwIFHx42xBKzdZsNeo1cn4VxviXmM2oHt?=
 =?us-ascii?Q?wLoXSXu2dNMll9Cejr9AoABqtBotYvo3867WjTPsN2J3xwiwl5oaabJWS5np?=
 =?us-ascii?Q?BHjLIBt/C6q5ZzXkBR2N58z/O+JxwqdMYVDiTDI0uR/4JGTuQcoeMGUPpCC5?=
 =?us-ascii?Q?b64kHq0bgpMi37FP5hr2lG9y4Axfd+BfJaeHDbB8cvI90Xlp+Jw7GgfekO0X?=
 =?us-ascii?Q?oadz7Uza9FKUk5lYnnoIxj2S7i3yk3jcuhbTGafW0sH4LrFkDaeHNcp3QXH9?=
 =?us-ascii?Q?twvEXov/YVC7J1rtnGbGD5djxGx3ItDtY51d3ePPjhzsxKLQPw5A8bnnGxZk?=
 =?us-ascii?Q?aduOHAvp+TfYLpjDGH5GbGcWuPCl3ZDtfnz21ovm7WlFW7u3GW3md6h/9OF0?=
 =?us-ascii?Q?M1Hqv76phA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fff773-4918-4c8d-14be-08de630ec44f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 10:27:01.1259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFP2RgHq+laLipKOTbm2kKt0ymEtKcKBlyQgfSA2/ayb9d8qVPw3NL+/vQcgQCTt/J5CPTR0bLiEBx1NzMo2Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8720

From: Luke Wang <ziniu.wang_1@nxp.com>

Secure erase should use max_secure_erase_sectors instead of being limited
by max_discard_sectors. Separate the handling of REQ_OP_SECURE_ERASE from
REQ_OP_DISCARD to allow each operation to use its own size limit.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 block/blk-merge.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 0eb0aef97197..fcf09325b22e 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -158,8 +158,9 @@ static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
 	return bio;
 }
 
-struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
-		unsigned *nsegs)
+static struct bio *__bio_split_discard(struct bio *bio,
+		const struct queue_limits *lim, unsigned *nsegs,
+		unsigned int max_sectors)
 {
 	unsigned int max_discard_sectors, granularity;
 	sector_t tmp;
@@ -169,8 +170,7 @@ struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
 
 	granularity = max(lim->discard_granularity >> 9, 1U);
 
-	max_discard_sectors =
-		min(lim->max_discard_sectors, bio_allowed_max_sectors(lim));
+	max_discard_sectors = min(max_sectors, bio_allowed_max_sectors(lim));
 	max_discard_sectors -= max_discard_sectors % granularity;
 	if (unlikely(!max_discard_sectors))
 		return bio;
@@ -194,6 +194,19 @@ struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
 	return bio_submit_split(bio, split_sectors);
 }
 
+struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
+		unsigned *nsegs)
+{
+	unsigned int max_sectors;
+
+	if (bio_op(bio) == REQ_OP_SECURE_ERASE)
+		max_sectors = lim->max_secure_erase_sectors;
+	else
+		max_sectors = lim->max_discard_sectors;
+
+	return __bio_split_discard(bio, lim, nsegs, max_sectors);
+}
+
 static inline unsigned int blk_boundary_sectors(const struct queue_limits *lim,
 						bool is_atomic)
 {
-- 
2.34.1

