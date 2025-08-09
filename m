Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013036.outbound.protection.outlook.com [40.107.44.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1DD194C86;
	Sat,  9 Aug 2025 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754749377; cv=fail; b=hsPhFlFMtPegossNKIUY8+DeNZ9GezyZZeUVk7fx2rdiWKpMp/Xpp9oD9ZlS03yYBjn7OMMcskjAsRsrIzaCOIcJCgPQLQt8+vkKxuRhS0HzBBE1O9Rv8YTh9KebeTK3Jb+XM5sEsdgZoc/kMK59hyYJgubzRzsiRV0JrlhD6Dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754749377; c=relaxed/simple;
	bh=4oj/evASI34nr/GLYEs/AtMghZGBz2J7PN+TVm1Ul4E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NKycKl0V4MnfWmGL+3ri4LEpmKAd582d56FAF0zsUIRkRDKi+HR+jsJFogGjKbCxbsCQHchv5Bk3Ca+x/waI/XDnHe6HK9HTXuVXMwOmUvT9M41IVU/4AAD5LBj5ACRSG//tX6VJ7FMEGafnHrluYWFZtasSE+ztw4rAjmklH0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Fxwr5X2E; arc=fail smtp.client-ip=40.107.44.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Fxwr5X2E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bD/kgR85WR4Ll2Zx5SBbdXTUF6h82fRk2edy2agDeQLkGMbbmZb8MY08Nv50d1qa3jfuRQrS+VhjDDn07FAFGHz3lGkSLv5qXL9B90WUbOz5vNRwy9D1O5WKxG+vOHqQkHN0jSnof5x8rluhxgIYomLVEwmFw30uqw2jV6F2c3p3LfS8u5WIdO9JLt5BPv22XXRZFCSU2gt7BoCoQgckjNXGZRedwQNgO+XvyesXowHXggQN6ZDjn+PBUrw/spkuGTq8wgR26v9+yEyTnR5X8uDjJKcGVlIKAuPlLctqfm1KyslRapfngJhWjvlW3H4f/egaHyRmjesUZspI0pfkrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClZxdjqa+4e6p2VRYe4+k53OWOS35M7TZUPFw1P45GM=;
 b=MiDsVgDEtWicKveQWqQsUTJKEMaHs8IArIAYVIutbPrw6wrrqx0EWZB5FlCMOMjuZxfkSmj/L2+GKflluR5JDQEghVNaXuOYU72gXT8fttiKQ+oxSLVlv0nRvaQUe6TP9cs1WmLDpdlfCeMl7OPBl9U5D/HwMlNYR1j+XzbcwZT+LhFTMNdM79AmPu7wb3JuhE1vMPzOxr184q3q45wQbZVNl08uBHin+y55h6ax37U+BfD5PZKCshPoxKl6+S0M4Kwz19XNLDUjk2x5nDi8g0QawaYaqeRxt2eEwLOWKr8RHLOuOdy1b01JlAAewo/RLlfvvCX8z/J+11ITujQ89A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClZxdjqa+4e6p2VRYe4+k53OWOS35M7TZUPFw1P45GM=;
 b=Fxwr5X2EJ6pmw6hQ58DJtcXTi4dvGdMc9aMK18cMtPa8Lhx/PjVFputKuHUXfzZmBnc5H0n6JC3sovyiELCh2lJCDfRh78ZZiRN8sFGtYt274fQ3tstQ3V1Sg8zAvCST/slJ+HWWQziwoTl4qadMNYgTUKm7Isay8wxhhao7kod/3i+/JLgiAE7++fn88EZeiaHF12Qw22qHv3U561f5+kVAsjio73Ekm5uXUoTKwwnYekjoVtCEMKpCWPSBLrV1YMbuWwka5uqz/WXVmYddpvZxxdd+vWIJbndZzFSDgdqSZXxWOL6mbG4F7mye1EDvKgPBEt4rpaeh8fK8fYsxHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 KL1PR06MB7329.apcprd06.prod.outlook.com (2603:1096:820:144::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Sat, 9 Aug
 2025 14:22:52 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.9009.017; Sat, 9 Aug 2025
 14:22:52 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Yu Kuai <yukuai3@huawei.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] block, bfq: remove redundant __GFP_NOWARN
Date: Sat,  9 Aug 2025 22:22:39 +0800
Message-Id: <20250809142240.174197-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0345.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::6) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|KL1PR06MB7329:EE_
X-MS-Office365-Filtering-Correlation-Id: 54b4f522-e671-4810-1376-08ddd750396d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ecj6uShnkVayepkAWn3Msc/lQ/6UNLXe/oI4LZnRqH1pMvNaBeS52CFzYz/T?=
 =?us-ascii?Q?8inAgyebSrSq3wPgaH0gz2flSJ5Fj4jJVH+BAO0wdy8Zks+VRelWlTzx+Cy3?=
 =?us-ascii?Q?JsS1X5j5LXCEwwp4rsFhG9M2dMtYZ1bpLrsCmtU628L8qUfi8j4Ng9QO4EKw?=
 =?us-ascii?Q?33aRrkGfi6EnjonShNZj7pkDQOteWyjbMsRYWJO9SmMkMfR2w0S1DR64y5qq?=
 =?us-ascii?Q?hVc6323ISKqhL4nj+6WnpMSlje3PUk3Ky94bKXpQpechBD4TziQYhkAyh7+d?=
 =?us-ascii?Q?BcLM+6N/E1v/BeUward0zju3J0bwecPpx/HoEK9pe6hv+5I4TKsjXxcyWTG0?=
 =?us-ascii?Q?jdboaxccL4B1YkRoyluz4T/gRAeLZUU9+21mGk4NOjlaRfhZh6m3Nc1Q0/rA?=
 =?us-ascii?Q?dI22vs7re6gcUrpaE+zVKyIxowJPUrqQMUFJlSbMDrZcxqFtp8PWt5WCGjTb?=
 =?us-ascii?Q?3Q3tGfEu3nMq5Qgheuu6IujEGZ+Yo5ibXb05KTLjvqDuUMP/9fP4k1bQ1rX5?=
 =?us-ascii?Q?8USNod+sTYsifHZ3kHqv1effsq3U45FiNZ2bIrMpulAla4IaE5OJiQzOV/8n?=
 =?us-ascii?Q?QPi1JHzf7GtN9d5qGdaQlpSkZSYNZoLk4+qxkAAqp1/JjScJWf9MJghLNhJG?=
 =?us-ascii?Q?2kVrFGZJaNvPDJvY3WPIMlCxoQfCPbJ/7BTtxxsWlhhsigyevZwbQ/XobBoU?=
 =?us-ascii?Q?fsc62UJzaddMoLm/4QfzEoypwxDF2Q8v7dpwvzWD+uRTYGhneGyYCghrGJCM?=
 =?us-ascii?Q?kjxL5kmVy1dIcvHKIhczJNWTqoU82gBw3ogyJyn25URw1DhXSjBy1eG7a2E/?=
 =?us-ascii?Q?45MkRifCaeT+3R8O67mIRtXNL/lYZeCiirgJzuXkAJhqzZ1IomRRXWMx9+DE?=
 =?us-ascii?Q?AL/Lg6tzcUCfwk2du4pwpnMPTPepcwLYvIFygX/6d/cWhuUlO/x/+TqeLIkY?=
 =?us-ascii?Q?n5wouQwQYBK4xoNIQ17dvW1Vk3NcxzjUW/1ABDY2kVuACGdb6r4JX6h33ZgY?=
 =?us-ascii?Q?ZcixlZWqHRTMdQGz8j5HFxwtYMVyRUXoBZL2VaeKMHvBeLd6tlCu9SJ4zUGc?=
 =?us-ascii?Q?ViCW45LXx9UyBWb9FUrP+AqYYhzmJ/N5Y48VVtTStt39PmOTY2cmq+9OUBv4?=
 =?us-ascii?Q?XPu9jKbD38xtQ1WALPJ6z/VkF3QCTQglNXopChE+gdR15LIizw10m3gTNUxf?=
 =?us-ascii?Q?AxzMCHERTLW1q5RN2DwfwbCPe05JCI4/eRpbypgPdWtVnzqyw0jN3NzP0D//?=
 =?us-ascii?Q?o1f2Xyq2e2HnoAzgvyQq9STqzjWLioM0ayr8mHh4o+sf2SIK6fkL8BFkjW9+?=
 =?us-ascii?Q?v4spRlK2olsrtRO0RaMD96FIRaRkQ3rZMTNNDo2r4cNxXECY0PBbevUuCUIp?=
 =?us-ascii?Q?xTKw4ux+/llsrL3ggAI/rMr5TaA+Mw12/tYOnyCfb9Mc/xJjytYXYuelInaR?=
 =?us-ascii?Q?1C54T8sEZ6vqv3MQhzmhB8O5fk5SDK4C2llpO2tpukf+ARfbsYawhg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kd02B9qBmDg71VPF9kfJCn8rzP9IEd2QWw/IJPG5eB7Dklfi3Wt+icBBWKgZ?=
 =?us-ascii?Q?Fi63yk00FJWZGAiqmajphrkzq78pMXK1PP8yp/guctYIbM3nJWrdNWpjBlWn?=
 =?us-ascii?Q?zHL8JHDTYFx9+ha/qKEZkgDuYSQnorXBrdpJC6/Lw4BtBlz5Pj44efdvrDkE?=
 =?us-ascii?Q?FX2mZiUhwHkUfSBP/iOcbx4m0I8WUkTQq2X/KgGHoP6aIKSi7BrcmNkM66Hg?=
 =?us-ascii?Q?4wmGVmH8//FAKSE4+LlyePeJMtQh1ZvUwX2616mA6jTnYfCWX9g6w0VsJaa5?=
 =?us-ascii?Q?N6PWlQWrUkH1zvCNKqmeHN83llh++vYgNAIcMnOif4gg145iUJgP27ozdWzP?=
 =?us-ascii?Q?HiP73XZ7MTrBgw96DqMH2XEk11qelgAHgmfHEdBfXCqNykW0zhtE8JV51FGY?=
 =?us-ascii?Q?dsJTLwi5+OMBtwIZNRGCIJiCDYEpitRX189vQM/tsIoKv9y7hv0RcLox/YZl?=
 =?us-ascii?Q?5jhgNmoeroOouNGmGGtsVYI/QF7Txowm4wNQNDiF05lDTL21RaYhHg0ddcUG?=
 =?us-ascii?Q?p9olBn14KDKNtkq4mXXGL+Wqp1cJ4svwECojrJAeo7lx/L8e8QLx7X0p28LO?=
 =?us-ascii?Q?iOLC3vppBxep+HtOCncRkuW8qeEBEf5kC23N7QHQfPsxNNhfIQV7VzGunsnS?=
 =?us-ascii?Q?cJVASL6buNkE6J7hpH/ASEKs+5vhp5fpeo03/91HpELYinDgUajyo4p6ctNP?=
 =?us-ascii?Q?U9NTBNazJevxCVIFIRiya3bPa6b/wII5/iGMsT4SRz9SPt2schEwUBNNpjLB?=
 =?us-ascii?Q?++dwxtc7G008y9C5pQyJ9wHfOctcF0GkQpW1kHcpoYPIZaIzyVI2AFBI4HK5?=
 =?us-ascii?Q?pP44dTwsdeddUsWoyHVBT4HVkTg9TZnArg8AZslwEG9QGc2TeInbGkZcp+wz?=
 =?us-ascii?Q?2icJOrTFi28iyvJkErkh8kOcM9P5DIfmaCXd+VPwEqG3ivmjssYTxKA0ggbA?=
 =?us-ascii?Q?ZVqAuJFjjlNN9HftJfGC966fpv1VdWlu1cwaNo68CrJtZeh2y1cXWkJ7ymf1?=
 =?us-ascii?Q?PQgwBwnNWnbcSqb42qvQbRXem3xUhytrShvbH5G7/UGzupctucithhHo7MU3?=
 =?us-ascii?Q?zPAKspTAzuuOaSeruX8Ls+REhhoGZLPIWr+RsWlV3AO1gnfqRqDrgfwGpaVt?=
 =?us-ascii?Q?nKkXnbnzIiIK6wm+Hs2EtT4dusz7yA9KFAmTq0lDo309Ppt3/9a9nJgKH7vA?=
 =?us-ascii?Q?5zhqCoQM4BgSZJFcNiF9U2m5tooJ0u2adYDw4DtFSNGIi+lAxeu0tqFDXjjW?=
 =?us-ascii?Q?8iFH3Qxy4feEamJIl7uFKd3KSBRRjJc9Df1tNiYRQbYzcICga+ufI155yeh/?=
 =?us-ascii?Q?G3mPZbdI0hFLBdIKJcdHEY0POKzBEdxwWXrhcnzA35wV9JEQVAEm1sBEuOGQ?=
 =?us-ascii?Q?PWhtrjrOUA94+Trq+GYb1f/g43afYuyM9qmwGPvkiIgqYirrR81HjKo3otty?=
 =?us-ascii?Q?Qfeh+Km1AFa73nKGYwvAlJdwv8EMuiKMCREjt1uWGzZWRxNqVQoOkwKa0Ylf?=
 =?us-ascii?Q?Z4TbfJGjLEpoVtyKgXFJIjFKzQo7+Gk5HMME8FyRn+Q/Ajf5NEO+tGyDs2pE?=
 =?us-ascii?Q?FcdneLPXwu+cvfA6f35IY9SaMe9a4s3f6Pa87m4d?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b4f522-e671-4810-1376-08ddd750396d
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 14:22:51.9440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T87R05jp9jx3FLy2dQd9nGZYhZS5f/UXWVYuKYf9fmRX3BvQp9rHsR3H+lyXhMzOMgoftBIYjiMWk1AdMXimNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7329

Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
GFP_NOWAIT implicitly include __GFP_NOWARN.

Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
`GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
redundant flags across subsystems.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 3bf76902f07f..db0ae65186ec 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5848,7 +5848,7 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 	}
 
 	bfqq = kmem_cache_alloc_node(bfq_pool,
-				     GFP_NOWAIT | __GFP_ZERO | __GFP_NOWARN,
+				     GFP_NOWAIT | __GFP_ZERO,
 				     bfqd->queue->node);
 
 	if (bfqq) {
-- 
2.34.1

