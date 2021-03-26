Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381ABC433C1
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 12:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 005CE61A2A
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 12:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhCZMLi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Mar 2021 08:11:38 -0400
Received: from mail-dm6nam11on2086.outbound.protection.outlook.com ([40.107.223.86]:3136
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229753AbhCZMLQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Mar 2021 08:11:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7uFocC/mLrGFeZMYod9dg3JbUzTmRJPWKN4SmLCNuYgYvdCOleG2oLFtkhpbCv0V2gKWDJBVLQW8qMZv6f1Mc/Ioy2Bd5/bEB6CMHAWdt9gp7B2IzS2T1jKy4GOoNKvFGBtBgTjIQ4mRhJq+RYw81FMS1r9o5Tu8R6VeVXoirwLPo87cIZbHy603SFSnGkUKZcYk34d2hwzwicOXon77Z9HzW6EhONtv+hAXEzX54gyg0ydY2pdbcIyXvFFdo4MOAV6Ix0Uq1I/zhe6iwzEtURqxNlExHJ1Pl7O53W3KbU0DnGrhSlJ/yFk5GmOX9eDZZ2TgROOj1J3Q5IcyK8eZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFbfWyoVDSQqTzzpLLjtk3zDR6d8A076ZavOOYvJU64=;
 b=lahBSsTfEbAzBVMo01R4UOZ51PP4hppBNS1cR/8fzou8g+S6Uqx9B3Lo+1m1af3BSBa+ErDdSE8YfAAgmZPuaw2VnjaEpLysP8RqSD80TVBC3FMOW3+Ah5egsrBYe78eFXdvoobO3+vA88RjtPSV1ZX0MY91/0ga8RJ+U0LjFbPWAm9p2/q/O4NY/WOZHWWUyQzg2oa74b4tKvJgYzznJ6VTKak2PugOYSooyi8xHfxrXEeok5Tfe40ksZ4Wso+pdi72g35hQUC3CkddB+NBhPPeD95LrGnJHkZTGo/icJ+ukhd1x94NdIwZEQmwh/OsKG2K9w38F0fkI2ikHc+U4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFbfWyoVDSQqTzzpLLjtk3zDR6d8A076ZavOOYvJU64=;
 b=JE4YDi6wnlP32cQmJrC/hODyXvQNwQ2WFMba/Z2BJu5LbXC9gfgTU1X5RhFfBot8CU6NuUnsUGmlX3L2HaueX4mtNSPd1+Xai+BgExuPfpqaL94Cn/kErati0cMpwJuuUAODuSac40yJHzHto0rJrgNxushGidVuNia2Rn8Xtt4=
Authentication-Results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB2918.namprd11.prod.outlook.com (2603:10b6:a03:92::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Fri, 26 Mar
 2021 12:11:13 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.3977.025; Fri, 26 Mar 2021
 12:11:13 +0000
From:   yanfei.xu@windriver.com
To:     hch@lst.de, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block: export disk_part_iter_* helpers
Date:   Fri, 26 Mar 2021 20:10:59 +0800
Message-Id: <20210326121059.597172-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR04CA0046.apcprd04.prod.outlook.com
 (2603:1096:202:14::14) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK2PR04CA0046.apcprd04.prod.outlook.com (2603:1096:202:14::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Fri, 26 Mar 2021 12:11:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44e17baf-e7a0-4693-c0a5-08d8f0503fbc
X-MS-TrafficTypeDiagnostic: BYAPR11MB2918:
X-Microsoft-Antispam-PRVS: <BYAPR11MB291869236B7604793E7B94B3E4619@BYAPR11MB2918.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:269;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TiqlyI0/fsaTb7/RSPAy3j3sLBPMb2Kr/K0OgfWPXZxt/AGTLMk+EGSiiaHqke6jJvALjDvOdS6QG5VuaakgTfg2jTXle7Ymlies+zY1dkgPDqjw1cj6Y0LaOkoVt4oIMogl6LCT/yalt1Eio/n0Vx2B6zYrcBy+AZbuhFDTTbKAEcfCBvDb+1iMX7TaYM4fBq6H1qgUMPYwQ8xsTcb4rXwXNKZEYmC9YEcEC8PNfaR4wSUP9KibuQDBupUZzwzA4NCtsCAnsBn23x56mCgf8m7Y2dO7X0hY1xoDR8gU/ssnPo+q/Ilso0xlgdrZ2Zlyji0iBeDHsOf+E1bUsNkHySlYMOrNage4cGwTiCz/jBT7X+BRrwATE+ZWQrGdb36LlkjHtQVcMLvtMOjpVKI0EOCGkITl2py07+8jlzcr20sebYzKo3tda61XSsKWiTnws4d0OaFr/hqevEP+B7ke0b+zHDGe0MUD+XpzJ0f+QASLsyYCL+kofA9USWTHv6Y3anU0THtBRqnxk5idQ8swVEC7zXh4/V8ItZWdsqKXAdD0E1Di2AlRS/dZXdsdzUX9SX5+XiSQxvFxKUvNt7fhmLGh13MDENEpP+mn4/3T3uwp0iC4PeAwLj0NzHmVDuWrn/+A4magkxWtNBdeuIMH4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39850400004)(366004)(376002)(136003)(86362001)(4326008)(83380400001)(66556008)(8676002)(1076003)(66946007)(66476007)(36756003)(2906002)(5660300002)(16526019)(956004)(186003)(6512007)(6666004)(38100700001)(2616005)(6506007)(52116002)(9686003)(26005)(6486002)(316002)(8936002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?n2XM2exzk4LcB6aMEPyu3Kk0f+Sq+zXvUgKCMZlWRaJGLLTBW+PH39GUsqj3?=
 =?us-ascii?Q?aiS4dErBLTR4XXKKjT3t2I81Q5jPDT7MmAu1ufiNriiBw/kqmKAvifwEcWfl?=
 =?us-ascii?Q?vv9Tpv2KOGsyc4BqzqWjyOoTWnKSFI1SW3nkRIsMMr1pQbVkuL16ws8CFZKV?=
 =?us-ascii?Q?9/kLGdDnuQTC8LN8v2p5klYhp/Mg9MXa6NvoTNhMTpBIoKVxWkpHUiWzGmaO?=
 =?us-ascii?Q?x9koXJE5vChMwqu+XVWJPBNxTTbkUadP1p7Kc/hPtr3OA7p0w6XLezSzQ7R9?=
 =?us-ascii?Q?k8KYsgM/+6ToGBoLAF3ptr31obPHqPqyuRgmN6Wfc3mhxmSW8vbbQ7JIv5ET?=
 =?us-ascii?Q?REztphUq6+jHXvpxGV+09fd7Ccyyb/TqJqdVe2xUZlibHZ6fklOAqgs1Nr88?=
 =?us-ascii?Q?czVBsrGGS1U5EzmITZsJFeTJlqP3SPnempRwlvf1PyU/W9X639yHRuRnV9hi?=
 =?us-ascii?Q?PBRhUm2031yRrmVDtc8imwqn5f/YizmtLEOAggJtYyRscHzjKRYtARAda4/p?=
 =?us-ascii?Q?Rp5cVbOM/kf2E2BVjeJJ+HpzVUF8sjn4nlcPHds/ARVHSskZe/SwAMo/2YNS?=
 =?us-ascii?Q?pRqFmUmIW+UN2lDmcFhAelsRWPLVJXt0WjbbBPBX9YtLHPu5X75K82t9GrHI?=
 =?us-ascii?Q?fX+Vvvpbg8Qp5sVrBJZ70ZOo+icD0Xx9xouLdP/FqyncGYGlDNxfXvJiiE3H?=
 =?us-ascii?Q?mTwo5Yu4ScYdCkhd7FnDIxL3DXxbAnBpIiJWjVxPRABYOl9ZyPG/nPnRig/4?=
 =?us-ascii?Q?xpXnqKeWqVrfZoriQSwzQKQSGhdxkBFb2eZY9WNeCkMr1Jo/MSsEpXmGwrxB?=
 =?us-ascii?Q?YtEDB4cjD9MTLeTo9QQT/VX4dp5xCGZ+WiSztCpjQxLj+ox4kqRaB3ANOUvU?=
 =?us-ascii?Q?r8m3v/MMtgOntujHHWZbGFL4KIz1NAMbyXdHRAdboDWXV1UcemCYEvMW51By?=
 =?us-ascii?Q?7+aGfH6S1j2C6kkh95J/PSZuXSthq8xMMErBHHxQmNwDy4hoaEVrPcFpYVWO?=
 =?us-ascii?Q?QhVYh/23wW2I2DMPwnsYFehjca+0z5fvWBVUCGt0zHNSFE+UnFrI0oNhRgNI?=
 =?us-ascii?Q?IZGWyi/s9I9UmizGKVicF9tpqVqdFvzK48mK75GsyUxzCSiaDxxll3QaahqA?=
 =?us-ascii?Q?+qsKfTy+5Td1iUtuFQ27gE+cLEu6k5oL7Vc8cTNARLQNjTsD14tlIrBMuoHp?=
 =?us-ascii?Q?1usQKbZcFPZ0gAUmXs1DY/XySmxScFLGm24sfENbl+tgh1IrF2jxCkml9wlL?=
 =?us-ascii?Q?Ju6Lm2rp0oPJwG76RgjPpaNiTOjpN4HMbViZFceA0zhcKJZa88y+XzanMJpK?=
 =?us-ascii?Q?C/CsMXXHLTri6c55QB8KVW0T?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e17baf-e7a0-4693-c0a5-08d8f0503fbc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 12:11:13.4387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4X6NOr3+gBfBGATkPAreQULAQLsaNuog2Wvj7N04O4ERBpxlHexpGcHhpVdXnaBpfYFc9a30JYtRUtPQIUVyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2918
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

disk_part_iter_* helpers might be used by other external modules, like
lttng-modules. But it was unexport in 'commit bc359d03c7ec ("block: add
a disk_uevent helper")'. Here export them again.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 block/genhd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 8c8f543572e6..4eac897baffe 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -183,6 +183,7 @@ void disk_part_iter_init(struct disk_part_iter *piter, struct gendisk *disk,
 		piter->idx = 1;
 	piter->flags = flags;
 }
+EXPORT_SYMBOL_GPL(disk_part_iter_init);
 
 /**
  * disk_part_iter_next - proceed iterator to the next partition and return it
@@ -219,6 +220,7 @@ struct block_device *disk_part_iter_next(struct disk_part_iter *piter)
 
 	return piter->part;
 }
+EXPORT_SYMBOL_GPL(disk_part_iter_next);
 
 /**
  * disk_part_iter_exit - finish up partition iteration
@@ -235,6 +237,7 @@ void disk_part_iter_exit(struct disk_part_iter *piter)
 		bdput(piter->part);
 	piter->part = NULL;
 }
+EXPORT_SYMBOL_GPL(disk_part_iter_exit);
 
 /*
  * Can be deleted altogether. Later.
-- 
2.27.0

