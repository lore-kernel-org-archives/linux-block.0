Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012053.outbound.protection.outlook.com [40.107.75.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA361DE2B4;
	Fri, 20 Jun 2025 03:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750390947; cv=fail; b=bjZSXNAv8s3xO3270diRVt56mzqVyfz3zINhC8CFERroDLofo/z+ORe3CSTgZx2OUpFiTsWko8LArWUH78MF7S4L/biPJNJ91CvNyeG2quImc+uUpt5amViSN4CZ/fEiMzSRvxoowg0glRrSfZX5zh94CkmK39VMhGzePpTyNt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750390947; c=relaxed/simple;
	bh=YcZhxuzWwdbvfxE2mAKeSMVurvR57Oqjr0eqTnjpRpI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fWRwdsbzVjQT0Xvb7xoTPprVivny84lZNVuS8JYuzNhzVYj2a99/bUEDMb13KrQV6Yvv2NHEkDomcW0wMd8bk/BqLEU4GDmqJQct/MEiCn5scDEcef9LH9o9vLtqlRmpy6uqrzGK701ScAN+tPFVKobkhN/alW6DTAq30epYwvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=fZN2JlTh; arc=fail smtp.client-ip=40.107.75.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="fZN2JlTh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChFe3S5qFoYmwu7DtP400g15irjgtfcL+AEOPz04yZma/hHbSv4aYOaGGcC/NDytUqchWUOPns73FttCC0G+ROhlQihbt9NQH5LvKZhAOqw6AxE7pfyxlcxukoyt3L7BTfAchlqPJv7edFDAcvgJ7lBj9tPMgib/dASQ5jQs2R8tmCJIvD58NjzlgseAUNdNFirZk2FsTDWwBdOdPtyhVBlvFl7XvrzCAU+b8K0wnI1SVj/7RNSfgiWqZe8WFvmhW8myhAYqdbxbTQEeQgx0NdVs6K8BIc5Pw1SudGhBomGZ6DRjKfHp5SuRnx4ewfxv5TVKTa7/rkrmmPD3nuJL4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5pfiUGsuCcWjFRqgUmdxWxoCgB2mpqdFDvPgRqW9pY=;
 b=xvz8OzQi9SUSBY0ooyRPZjKc3c30PwQOO3NtTvu5Tr8xkqBe5uSqDqw9ju8oEhBxptK556vK+ANxG7MfEBFA1WgPeBKPNNpoQMWTS5fLWfqQE+d2BEsd1ugpW7t3CXTb5aBeX33ZsV90KMLQRvnrmfRtQh1kO6Ns5hYwb2Yxduor2GZoL7zl2393CAJclilI3oqdrJYj8LHvRp5XybiVWyOJR5xZbHdwvIPKgCNykdtZb/WJwZoevWcc8BqTew8YUKfnXHhipMG97N4m2kV0bgrD818fyuWxPU/Cvb6Kxno7xjG2YYptCqzfA6yH1M3q1swjGGuyH5QDIwuc5n/95g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5pfiUGsuCcWjFRqgUmdxWxoCgB2mpqdFDvPgRqW9pY=;
 b=fZN2JlThQpPh5WEyK0IqDCH2hjf/ZKgLNIYG9EEeFb3gj9KzqsLV8ttwPJfCOBHup3YB7XmSf9UUfRZdK/xdllUxKbP7VdfubPdE5cptu/chmuOP/+5LHNaCx2QNWnBcqscaxhYZXPTzsFWN3mlGahHa/fXJOkWB5m0G4XJhC5pKVy4qfc65bLagz2oQI82Wv74CkLl9y+QTK0L9bdWDnx0ZfmcUmu1BOkCzw5NxfwltC0Z603eiRn+Ox3chXj3g0zVnle5d+BLr2ioW+/Kr7Ls3+dgQ0+AH0CVJPr9jwMZPaRUiBDWnYQPNXW7DwI4jDvMLwa9Qn2J/H27wf8xv0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5389.apcprd06.prod.outlook.com (2603:1096:101:64::7)
 by SEYPR06MB5672.apcprd06.prod.outlook.com (2603:1096:101:bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Fri, 20 Jun
 2025 03:42:20 +0000
Received: from SEZPR06MB5389.apcprd06.prod.outlook.com
 ([fe80::6869:c60d:7f4c:ede6]) by SEZPR06MB5389.apcprd06.prod.outlook.com
 ([fe80::6869:c60d:7f4c:ede6%5]) with mapi id 15.20.8835.035; Fri, 20 Jun 2025
 03:42:19 +0000
From: wangyufei <wangyufei@vivo.com>
To: Justin Sanders <justin@coraid.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	wangyufei <wangyufei@vivo.com>
Subject: [PATCH] aoe: Use min() to simplify code in probe()
Date: Fri, 20 Jun 2025 11:42:04 +0800
Message-Id: <20250620034206.3804-1-wangyufei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0111.apcprd03.prod.outlook.com
 (2603:1096:4:91::15) To SEZPR06MB5389.apcprd06.prod.outlook.com
 (2603:1096:101:64::7)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5389:EE_|SEYPR06MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c1f1ca-d625-4973-55cf-08ddafac7545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gZofZ6tNk96Ak39/BPS0xG9i2AqQvbnEHdd8/gCIeEs7st2r6w5KxO3EGjt1?=
 =?us-ascii?Q?vWRFk6BOH1JyTJ5VHcAGAE8j79l+yMNiszdHYn5kqXOHytRqrYKB3pOLVYhd?=
 =?us-ascii?Q?fsDK/F5nvvGyOkTujIJSJciVaWtDDHIeG/B8ivKkkjAGxijYRaLTmg8uMrVC?=
 =?us-ascii?Q?0s14RHt0rJq7+S2Xnx0tT7qNPr6HsNc4EW91Y4Dnqmyd/bO0EwGW1G60pqrz?=
 =?us-ascii?Q?wuRPPOg2teM2AAu6FaC1skBw3T3SIc6WIdJolhMJkI0qHUOCt5bc9ViwKDhs?=
 =?us-ascii?Q?VNsq99OCjAGaB8mKzE5xFTgcMkwgbvadjR2NwtquDOQ/bONObWhpNSH/bKiX?=
 =?us-ascii?Q?CsIoKebPMIAYw+qtgFOvU9R59LNi0P5btU0kbQDsenF3eUG6KIbsXT2hykyl?=
 =?us-ascii?Q?FYxSAtM0FYC7jh5lQBtyy+RPkppDyTMHTnSXtGnfy0EWEa4Yyq44TvsKn+uf?=
 =?us-ascii?Q?dWSaPH2sO9y1+Kel5Lqw3/pFmusS/C4cBccBgjvnJXuqT8J57YCi0J1IQ+3p?=
 =?us-ascii?Q?fex52nC9Jai4vz0MdT1tHiFG75IVbthcauurIJsXjZCZABVkzPwIWt5ghLQl?=
 =?us-ascii?Q?BBzCUeF+yzQh98UNIBLSrcm1nZmcYm4pzYQo4cD/RcKqG/aZBW3j4rZPvrtZ?=
 =?us-ascii?Q?qA/XP0dqQu2czENvcxE7wZg/AfzE3Ut96ZaKNBVHgPNTwspmfeBwlDmLIn1W?=
 =?us-ascii?Q?aRFZ825afJ8jdSd6V8fKwtqz6DR06gR0wmlkqNs6j78T7PZYTH2UG3boAMCb?=
 =?us-ascii?Q?CQCA8jaTt35gRSvWNsZp0z7hoitgGWM3l7j40bwqXPG/mOh/QinOgKQtIZFO?=
 =?us-ascii?Q?kvHwyWkkh8jkQt0VkJAZaLIRju1tsmevGEXWkoicXQxviotGImZs9c5Fq8vT?=
 =?us-ascii?Q?NcPU/1MU1A1BLxV9P9EUfYR4baWDJ12kQCQsTsgOiRqYYY+gxEX8GQhIz6T/?=
 =?us-ascii?Q?UsfBBA1UzKnlolXb0GCtmJ/oZMn9a9gz6YLZ86C0NiwvEV0sBfNHG3qCaxv0?=
 =?us-ascii?Q?kBkCyYOMa35/kjNM3kNqI7RjvPQkTg2EVi8qoL7+hrBn0FIA2T6iodak0lZD?=
 =?us-ascii?Q?PeyKQ9tjJjtBP10aXLbJIdCbmV5f0/2USNVwVJ2zxO8bsctI0WGQSGM8qmS0?=
 =?us-ascii?Q?+HLkoDLvWfy4Ss07THIq26pEZ3ucl/Di/U+p5+5/Y115zKm6b3+VTRL2FG/Q?=
 =?us-ascii?Q?+eqrTfniyQiGkyNfWPb0hxMF004ak7IBShknng4rAZSLusM/KWkDq5RvlYBK?=
 =?us-ascii?Q?ey0bhUW0+B5jwTvxH8dUvYJ48zmJp0rubR+5/PZaQgAyRCYTc6scmF/nrq8d?=
 =?us-ascii?Q?/fXJ7OR+fpcZWl3Tw+NlUocPgY0QP/hAa6krNmb9enzSTpwceydIKnSTNyKd?=
 =?us-ascii?Q?g8fckOHFr+KhvGO6V4IT1bZODfwMz9MGyTsiwmMBs6q3PHjgvld0uqJ1wotx?=
 =?us-ascii?Q?KVXtuoSsYfQCkSW7E1HtibN6EWSJWwC8nBUsfRDVSLoqbpL2qDjLDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5389.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kHLSa5gyxFWOHfZH2IN5f7qB5cx1OmiY3hSCNxMSQ2qZKDKAEcdpIrj8w3Zc?=
 =?us-ascii?Q?nejo2y81+SBRPrFAnnyQL0lZqsCfr1L3/ScpnFYyNdFqrkFOadtdDrH52UMR?=
 =?us-ascii?Q?XYTfKDb9KoVYyiwnRANQ6veON5My4JQtq56fCiDrDXejx3o0xIb7YWhPBjbK?=
 =?us-ascii?Q?UXQ2zAtl+0WtBx6aIXnp/36d3R1grzACHzedmgXPdpJ79guk7PxE32zX9lsy?=
 =?us-ascii?Q?YCaICuROH6Av/9iLjcVGrIiiZwcUzajeTvLZUZRM9iKlllNUN1kelPwBsM4W?=
 =?us-ascii?Q?JRPZUlp+SHwqGdSeS2VVCmUEgkDNt4Q2WSYPnnWFW2dL9MfapjCMmPmfLyY9?=
 =?us-ascii?Q?nwi5cPrTEpvgcrStL1m1xoAlQYE41Fpqikt/uxs2E6rBlBOvTSUrfw3MFJBb?=
 =?us-ascii?Q?bIFKsoTDkAtVOj/utOclITIAM1iigPFRe5OLrH17mnmFfamSNoRZxqOOr5vd?=
 =?us-ascii?Q?hv/Lnce+hmb7dE/v2pUJCjum7jUGR5CqMDV+zL1orl/m2oUD/x5CduZF5LDz?=
 =?us-ascii?Q?dQ9XUxLHwI/Vr+QHHWNg284/NUBvUpmlUL1rXaDMAPl+veyQRcLBLMe63Ocr?=
 =?us-ascii?Q?307iYTr7Oi+b6rlqr2EFfLXiQWcgeC9uulYE5ghGmz1HeFon+DWFo5mCdMc4?=
 =?us-ascii?Q?lrUjv6aYA1X0dYfTBQ7kNU6B0ftUcew9g8SNml9d/o1zHfAuzJRxATvXu+Qz?=
 =?us-ascii?Q?yRtDrLQOI5iCGtGZMfvhW1zuxkXukX7IYAEaXFM3aruVI7RI60G/6Alpes4q?=
 =?us-ascii?Q?bosEQ2QMnlNmwFupaydx34CY/czB6dSJq4SDJdwTIPh32H0pqVA5tej61zOz?=
 =?us-ascii?Q?4tJVC2P9x/rjyY44JVryWjo8z4svYBfCeGcHzfkeVC9+fABGc2JxUfCcs/jq?=
 =?us-ascii?Q?L0Uiu3ZOs3y9P5AJBWjiKuMMdKVBqWt96kjmUE7a1ehZVUgunezhomfP+2dR?=
 =?us-ascii?Q?0JeyCNPKfY9aTBe9Rf/wM/X7lubke8WJMDMk5ZI6cQQdx0rpMhK2GK97fQGl?=
 =?us-ascii?Q?O66gYsO43x93Hx2gv9wBTE+0jTxleLY/rNrkCioWPPw8ALkJNmzqpGZ/DtZ1?=
 =?us-ascii?Q?Y1d4AfihBuuSFiNGlAWyjokfdadkaKYz951zT+7vh33IgDPnxRLYIIfEWx1L?=
 =?us-ascii?Q?/R1hMHAKtruvowpAMwBFIlcp/p5fKwRzao4Am2bftZ7MauQmxcyXxf9SoEdp?=
 =?us-ascii?Q?jwKeiZ6s18J5jZ/Idaf4Zwyj1oMWVPwaBKDJGYZwnYFPUnI6ys6jhVWRG+Ow?=
 =?us-ascii?Q?F/pV92/Oz251B3qRdghQOQLKJmm4yyqTHxrL9uUCucxdf72Vislz859/3ppw?=
 =?us-ascii?Q?ncnVKm2AusMK9OuZ+a/nkqigG5UjCi1FJ+zTlBcpJnSM7z8IH4MwwvDrmwD9?=
 =?us-ascii?Q?GVlcgS1FspCDIG0yBUpFiLvyhBdkAubRz3Z2L3rhr/TuAHkr/N6aqX1IhgKF?=
 =?us-ascii?Q?CPEDDkjoykdbo/bbKjarKcRwV40K8EDJte/Io0iDE102qYmcU6kOIcLUcsI3?=
 =?us-ascii?Q?4KbLzgmzgdlWZ6HruBzm3FdFlOVkjBODgUN7P14GWtFJrGcGHtfs4PdGqp6x?=
 =?us-ascii?Q?bcKqDT36TVezLmaNrQpHhG0zrPYnSR+cj2I4KEgy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c1f1ca-d625-4973-55cf-08ddafac7545
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5389.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 03:42:19.7689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UM/grRJ9grJXPRyeRLLERUSutrp0NhmZeT2sG3fI1eqb+pmocd2S836ryVjWBPXDsAnh+L5cDlkaytwd1EI8Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5672

Use min() to simplify probe() and improve its readability.

Signed-off-by: wangyufei <wangyufei@vivo.com>
---
 drivers/block/aoe/aoecmd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 6298f8e27..d6fd83245 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -16,6 +16,7 @@
 #include <net/net_namespace.h>
 #include <linux/unaligned.h>
 #include <linux/uio.h>
+#include <linux/minmax.h>
 #include "aoe.h"
 
 #define MAXIOC (8192)	/* default meant to avoid most soft lockups */
@@ -607,10 +608,7 @@ probe(struct aoetgt *t)
 	ata_rw_frameinit(f);
 	skb = f->skb;
 	for (frag = 0, n = f->iter.bi_size; n > 0; ++frag, n -= m) {
-		if (n < PAGE_SIZE)
-			m = n;
-		else
-			m = PAGE_SIZE;
+		m = min(n, PAGE_SIZE);
 		skb_fill_page_desc(skb, frag, empty_page, 0, m);
 	}
 	skb->len += f->iter.bi_size;
-- 
2.39.0

