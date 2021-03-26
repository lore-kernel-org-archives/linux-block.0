Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E145C433DB
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 03:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0085D61A3F
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 03:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhCZDFg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 23:05:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43676 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhCZDFX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 23:05:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12Q30xtY156196;
        Fri, 26 Mar 2021 03:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=lNNyAWIx5h3snOrtYYcnRg8iRmIgoStPHuDrIUSHdAA=;
 b=HdmVWlSAl+uwewsAL+YB1Vh9m4g1Z19R+bnigM7GIQE7SvWlVIeOVrINyoLdepy4qVWH
 dzuQithRn/bLOQSwNXff7gYE2MG7KsQG3iyFyvd67RjgtdmtJkiSrMLPovugkkDHLJDw
 Dycimz4smhD2HrVVz4L2lu+wws/JK2P18TWhyzFQi9y5hbEzEzNRGsbfDXU3WxQ5Wovx
 tpD8cg2Nx6B8tt6N+HbO0g+wWmiIhko1t224XMTBEbH0IJW5PSF33Zdr1gm7cmD69inT
 G0GG6xsJTJLQaBuFCzsEMRM2GnB0lsCFbw+rf8T9S7OG3jM3MQ47wST5y/CFlc8iq7a7 kQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37h1420pk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 03:05:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12Q2tJdo162628;
        Fri, 26 Mar 2021 03:05:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by aserp3030.oracle.com with ESMTP id 37h140uk80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 03:05:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQWeTJKkjgcZwvCPxjh/bSM4QZ+ZGc9o42gKkwwQW2UPLruHhoQJattW85TzzmtI2SyjyYyR+E21T5vkd92Qz0s1/yrDziZ8jwNhzPMm/Qfwh0XJkmQIcO5m46s9jTYQG3qdZ0fmehovu97RF/a2tpghXSa4UZhR7A1tJu8MVw+CmYpvqoplR6m6C4zgFmeqtoRB/wecQ+UgKCcZTl3Znbxx+KkI7IILCG31oxrMswb56woMcWFrlfvsSKC8DgfzE67GVITWA2DPUMFlKnSoUoI10VpYzp8+vLzy8ohh+EQ640cUBUPBG074EHBM/6lGsnmDbTI/ruXvrRRffLxmUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNNyAWIx5h3snOrtYYcnRg8iRmIgoStPHuDrIUSHdAA=;
 b=YYZWA/QglKCaoWGCZXm058Ge5Q0DVoLIzMHel36QIi9vC77R4bBZnZ6Dzztl5WwLyOoWRilNiKK7ki/UCKlqBozOpqTeKTT+El0+c3Y3oChCf1sloaPr90P3gDOtgjHFKfedRmNBABODrdrfpNOdek3R86d5g2GPTm6r4cVIgPlfiebnnjfDOAk6BEAlTRO3oprnHVgHRMXL3h/Pe7r0A9/XSXDyz6kkmrCaPnLbca4tevhO0Ns1XtzljXlzHDvc3B1kbjJFe9mEIHZSRI5qEEz8nPWhTGnj1LsGuhBOQ8M0oC7Alp2g3EPyqSyJCnwEeMkVSW3Bkeb4Z5VkQ24R/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNNyAWIx5h3snOrtYYcnRg8iRmIgoStPHuDrIUSHdAA=;
 b=lSBn2pteZ83D3yuynFXbbtoiKFvWmktjMe5KRQrE/OWF+eNURExVesJyKO8jqX/YE7yy52gJpeIpOw80gWRXREx7B1iru/blqe808rPVYMLm2At3xPkiyRGbXFsjotZva89Zf1flLKU8kS5b8gJX4hq7gqhMWX0P0GA1rMKg1LM=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BYAPR10MB3239.namprd10.prod.outlook.com (2603:10b6:a03:156::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Fri, 26 Mar
 2021 03:05:03 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902%7]) with mapi id 15.20.3955.027; Fri, 26 Mar 2021
 03:05:03 +0000
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Tom Saeger <tom.saeger@oracle.com>
Subject: [PATCH 1/1] block: fix trivial typos in comments
Date:   Thu, 25 Mar 2021 21:04:57 -0600
Message-Id: <31acb3239b7ab8989db0c9951e8740050aef0205.1616727528.git.tom.saeger@oracle.com>
X-Mailer: git-send-email 2.31.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2606:b400:8014:1041::15]
X-ClientProxiedBy: MWHPR10CA0058.namprd10.prod.outlook.com
 (2603:10b6:300:2c::20) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2606:b400:8014:1041::15) by MWHPR10CA0058.namprd10.prod.outlook.com (2603:10b6:300:2c::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Fri, 26 Mar 2021 03:05:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35d11e5c-8f4d-49d7-a09f-08d8f003f33e
X-MS-TrafficTypeDiagnostic: BYAPR10MB3239:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3239C2C20903898A07730E59FC619@BYAPR10MB3239.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BLX5s6DnLRaMxwCB5w57rjoErz0HFFHW+Um5tqv6KXegrbniSvueNoajBJX+?=
 =?us-ascii?Q?Xhh7LU5lCKdiIbzWFOxOaZEul1mbwwSQwyk8gTeEjF/k9EJqTj2dy3o7fiA0?=
 =?us-ascii?Q?1sYfyjYcItv20tMP3wLw+2pN3n7OOMkFudmdykvp30UNVuj3/bvizXlCX9SX?=
 =?us-ascii?Q?fSzxklMrr+JLfz9SttoU+YI88HYj7O2ynumOPcFct4pxgXTkwh26qNUu7+pD?=
 =?us-ascii?Q?tLrYR9q7M5p3zU89MdKzciY4LnSLQX3g5VSaPKcsYSl8w3W/BQIyFItqktqS?=
 =?us-ascii?Q?Zz7S87JJEDRvvShfKcRdPq9CFQ8Db0nE4icVOTw0uvRLdSur5zfqLXFOlWlu?=
 =?us-ascii?Q?w+iVyA20qKLhmBd6VNVCZ+BNjbQhAaelz89BKfEi0TcOd4B0sBvfOoDvrbeh?=
 =?us-ascii?Q?rjmYxl5W3uxe3ZOGTZGlyjaF0RyQmd+WDcrvy6JKKuT0Utj0TOsxglJXaZEo?=
 =?us-ascii?Q?IG+Zpj6IqN709jJvYuM35ulQtmxBhY3+qHVabfOk54mbhktwu3XirfG5+Et8?=
 =?us-ascii?Q?HUD5Ssk9BHkw0/14OybFazeu+/sGSLW4VcczodLiDSC6PZchXISnZ2iqlVbm?=
 =?us-ascii?Q?75BC4Vdoj48cqDbvd5i8FIztJ/0Oke5vyLY7icTp3sVq/8BWWd0pJhuOZcK6?=
 =?us-ascii?Q?DU9dukWTN+qUe4Oa+n3dzljfPHU+sBZZUaTncBs7tpWvEPIjP7dxl3KAnowY?=
 =?us-ascii?Q?3f+m27W1/PHYcLMXLUXr+AsDho4y+H/NcgzeGkZrIhQBwGp8AcET6ETCR1Fs?=
 =?us-ascii?Q?LhclMujys086bmsl+/GlM8CEEdsVLfL09ryhpNXHTm5WSB36PNGk1CLY36dY?=
 =?us-ascii?Q?9YuAw6pU77+QieUAkd42sRJDQYOCrA1QXOpmzig3CUKygCNkKxpI8Hzt/9I1?=
 =?us-ascii?Q?QJzjXWDq3heWXnPHsKtscYKvwR8kCuQHAgR898UcftowK+PQ4BhSwdwbTBga?=
 =?us-ascii?Q?XUvoYwPRr+q66/oQStTN1+jZz35+/atQ696j4U+uIIw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(396003)(366004)(346002)(376002)(39860400002)(136003)(478600001)(6496006)(66476007)(66556008)(52116002)(86362001)(2616005)(66946007)(8936002)(4326008)(316002)(6666004)(83380400001)(8676002)(186003)(5660300002)(38100700001)(36756003)(44832011)(19627235002)(107886003)(6486002)(30864003)(2906002)(16526019)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tuaOHnwbO8TlrW+QvwCidgLPrRt1lAa3walnkJMqBEJ+F55Pz4rPeMW5C0JO?=
 =?us-ascii?Q?6v+lL3G3O2SWsIHuFUlDYTSr8PfnV3gimV74Y/y6QLQZ4/uWmAcct8OMbFKs?=
 =?us-ascii?Q?G3OYRZgEbz/qqkoCNu4q5+3HmUY6a24mpHsGKbRFNgJIdEqN82DHJUwvDGmp?=
 =?us-ascii?Q?PHNJ032D0wg++/kR/9ATpSdTJuLA7Fxo9DwwFL8ghxABDR3trnFc7HE8uUaB?=
 =?us-ascii?Q?YQW2hcy/OjxW8zSVL/5H2Jo/8kAQBcmawsmH3xuPOMZAhmVPxrpbTK+Qfm0w?=
 =?us-ascii?Q?dRc2VTV5k9QNeI3pYY1A9SqBvfCnIH9FgpXJXQAfbjUuaTzcNjk07dDBLFNv?=
 =?us-ascii?Q?AzRRjktwYqTiB25z6Yg+Yp3Xm8sc/9ybo+jeIPMjBcVivjqHZxzR7wYPJoI1?=
 =?us-ascii?Q?u/iBddj1ENInJn87LNaPEv0RBib7jGVdsNN7igsqtF2NZlR786DZ6+fZtFTP?=
 =?us-ascii?Q?+3IR6whEmmZ9vBfVSkYb+RA/nEbiuXZjjz1kKE4OHNNR9tQkhvnNiC99ZlQY?=
 =?us-ascii?Q?+qBTbHPA8vr0y/uw42TR3VpjIKNwzTJBK+Av40uOyz31jKH2MKsYv1p2EDIB?=
 =?us-ascii?Q?82RVs027pdz35au0ZOHKM+csFgC3WGxWeFdfS48cOsUbq00g++FACISdGTCb?=
 =?us-ascii?Q?dlKh7a3GeZH1M2hlpQzN8d5BG3+H+KRQHshN3+iELjcjQOO1Ip0o/6OdZ34R?=
 =?us-ascii?Q?I1n/Q7zusYRDINeaMXvwiFejhu+6xzQzOQkwjSmMEa3yxVoWmkXJ+H8N5QvX?=
 =?us-ascii?Q?OLj6bETT08dDJ6HQCOJ705yTzEAkfKD7QEmMmJJ2jdZzXeDVeW+xL/0jA34S?=
 =?us-ascii?Q?+ftxoazDVPDHRk66nvRoC+6iP41r4yVUEDTT9daDa1hdB/IYJFt7Pls/PNzT?=
 =?us-ascii?Q?hgcTZF7cKEnc9NeqBTBg7ilerwm37QLVrvFLlf88CABWuPCkoNL2f17dohCD?=
 =?us-ascii?Q?ZR72Dof0Hj8rjf2qqAK0Ie7F4/aIpdEhyS7eYklQKeuUeIXXUni03a1xSEDq?=
 =?us-ascii?Q?9hW2jcMOqNtdW0x9K8RW6eCdrzlH3cHHvR5Tpmm6HSWs16QYxWRWURw3t3hC?=
 =?us-ascii?Q?q/jHCZSFJbJ8foTtAeHInhw7kUDV6DmZNiWGmornA2tr2QMwDjDUh+PSBFRQ?=
 =?us-ascii?Q?F1ei0Z26yBpnwpEgpVZl2pC3Fevu7d95vYQS2iFNxepPxw7wBc+h+wgnE4wL?=
 =?us-ascii?Q?DGHZWMROXumtdxtwxkbfafcTbvEFD4bo971RMHDO0ux3BAuGwK4XcZAYa8c2?=
 =?us-ascii?Q?QOgNUSVm12Yc6gt9G0vMB3sOq+3m/PExcRtBg6GB+BUTDvFozJAtS6VKGBLF?=
 =?us-ascii?Q?ucXNWOMAM47P66p3i4Xn1oxIj2CTBUr4WbYhNpjCJmX5Tw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d11e5c-8f4d-49d7-a09f-08d8f003f33e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 03:05:03.1599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+amTcx01l0sa9KpaC0YvfOhiRueCgCNknSM2hSAREkWi22EEEHA6/MPXYSkQJ+T9OCWA1HRcj0Oo8zxfEsiOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3239
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103260020
X-Proofpoint-GUID: wxT-r7QsRQF0dyiny7iqYtl6R6Vx4FMd
X-Proofpoint-ORIG-GUID: wxT-r7QsRQF0dyiny7iqYtl6R6Vx4FMd
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103260020
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


s/Additonal/Additional/
s/assocaited/associated/
s/assocaited/associated/
s/assocating/associating/
s/becasue/because/
s/configred/configured/
s/deactive/deactivate/
s/followings/following/
s/funtion/function/
s/heirarchy/hierarchy/
s/intiailized/initialized/
s/prefered/preferred/
s/readded/read/
s/Secion/Section/
s/soley/solely/

Cc: trivial@kernel.org
Signed-off-by: Tom Saeger <tom.saeger@oracle.com>
---
 block/bfq-iosched.c       |  4 ++--
 block/blk-cgroup-rwstat.c |  2 +-
 block/blk-cgroup.c        |  6 +++---
 block/blk-core.c          |  2 +-
 block/blk-iocost.c        | 12 ++++++------
 block/blk-iolatency.c     |  4 ++--
 block/blk-merge.c         |  6 +++---
 block/blk-mq.c            |  4 ++--
 block/blk-settings.c      |  2 +-
 block/blk-stat.h          |  2 +-
 block/blk.h               |  2 +-
 block/kyber-iosched.c     |  2 +-
 block/opal_proto.h        |  4 ++--
 block/partitions/ibm.c    |  2 +-
 block/partitions/sun.c    |  2 +-
 block/scsi_ioctl.c        |  2 +-
 16 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 9b7678ad5830..936e48bdecaf 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1798,7 +1798,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 	 * As for throughput, we ask bfq_better_to_idle() whether we
 	 * still need to plug I/O dispatching. If bfq_better_to_idle()
 	 * says no, then plugging is not needed any longer, either to
-	 * boost throughput or to perserve service guarantees. Then
+	 * boost throughput or to preserve service guarantees. Then
 	 * the best option is to stop plugging I/O, as not doing so
 	 * would certainly lower throughput. We may end up in this
 	 * case if: (1) upon a dispatch attempt, we detected that it
@@ -5050,7 +5050,7 @@ void bfq_put_queue(struct bfq_queue *bfqq)
 		 * by the fact that bfqq has just been merged.
 		 * 2) burst_size is greater than 0, to handle
 		 * unbalanced decrements. Unbalanced decrements may
-		 * happen in te following case: bfqq is inserted into
+		 * happen in the following case: bfqq is inserted into
 		 * the current burst list--without incrementing
 		 * bust_size--because of a split, but the current
 		 * burst list is not the burst list bfqq belonged to
diff --git a/block/blk-cgroup-rwstat.c b/block/blk-cgroup-rwstat.c
index 3304e841df7c..0039e4756fc3 100644
--- a/block/blk-cgroup-rwstat.c
+++ b/block/blk-cgroup-rwstat.c
@@ -37,7 +37,7 @@ EXPORT_SYMBOL_GPL(blkg_rwstat_exit);
  * @pd: policy private data of interest
  * @rwstat: rwstat to print
  *
- * Print @rwstat to @sf for the device assocaited with @pd.
+ * Print @rwstat to @sf for the device associated with @pd.
  */
 u64 __blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
 			 const struct blkg_rwstat_sample *rwstat)
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index a317c03d40f6..e5dc2e13487f 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -143,7 +143,7 @@ static void blkg_async_bio_workfn(struct work_struct *work)
  * @q: request_queue the new blkg is associated with
  * @gfp_mask: allocation mask to use
  *
- * Allocate a new blkg assocating @blkcg and @q.
+ * Allocate a new blkg associating @blkcg and @q.
  */
 static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 				   gfp_t gfp_mask)
@@ -526,7 +526,7 @@ EXPORT_SYMBOL_GPL(blkcg_print_blkgs);
  * @pd: policy private data of interest
  * @v: value to print
  *
- * Print @v to @sf for the device assocaited with @pd.
+ * Print @v to @sf for the device associated with @pd.
  */
 u64 __blkg_prfill_u64(struct seq_file *sf, struct blkg_policy_data *pd, u64 v)
 {
@@ -715,7 +715,7 @@ EXPORT_SYMBOL_GPL(blkg_conf_prep);
 
 /**
  * blkg_conf_finish - finish up per-blkg config update
- * @ctx: blkg_conf_ctx intiailized by blkg_conf_prep()
+ * @ctx: blkg_conf_ctx initialized by blkg_conf_prep()
  *
  * Finish up after per-blkg config update.  This function must be paired
  * with blkg_conf_prep().
diff --git a/block/blk-core.c b/block/blk-core.c
index fc60ff208497..e866e58214e2 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1035,7 +1035,7 @@ blk_qc_t submit_bio_noacct(struct bio *bio)
 	/*
 	 * We only want one ->submit_bio to be active at a time, else stack
 	 * usage with stacked devices could be a problem.  Use current->bio_list
-	 * to collect a list of requests submited by a ->submit_bio method while
+	 * to collect a list of requests submitted by a ->submit_bio method while
 	 * it is active, and then process them after it returned.
 	 */
 	if (current->bio_list) {
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 98d656bdb42b..282903250530 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -111,7 +111,7 @@
  * busy signal.
  *
  * As devices can have deep queues and be unfair in how the queued commands
- * are executed, soley depending on rq wait may not result in satisfactory
+ * are executed, solely depending on rq wait may not result in satisfactory
  * control quality.  For a better control quality, completion latency QoS
  * parameters can be configured so that the device is considered saturated
  * if N'th percentile completion latency rises above the set point.
@@ -851,7 +851,7 @@ static int ioc_autop_idx(struct ioc *ioc)
 }
 
 /*
- * Take the followings as input
+ * Take the following as input
  *
  *  @bps	maximum sequential throughput
  *  @seqiops	maximum sequential 4k iops
@@ -1090,7 +1090,7 @@ static void __propagate_weights(struct ioc_gq *iocg, u32 active, u32 inuse,
 		/* update the level sums */
 		parent->child_active_sum += (s32)(active - child->active);
 		parent->child_inuse_sum += (s32)(inuse - child->inuse);
-		/* apply the udpates */
+		/* apply the updates */
 		child->active = active;
 		child->inuse = inuse;
 
@@ -1144,7 +1144,7 @@ static void current_hweight(struct ioc_gq *iocg, u32 *hw_activep, u32 *hw_inusep
 	u32 hwa, hwi;
 	int ioc_gen;
 
-	/* hot path - if uptodate, use cached */
+	/* hot path - if up-to-date, use cached */
 	ioc_gen = atomic_read(&ioc->hweight_gen);
 	if (ioc_gen == iocg->hweight_gen)
 		goto out;
@@ -1241,7 +1241,7 @@ static bool iocg_activate(struct ioc_gq *iocg, struct ioc_now *now)
 
 	/*
 	 * If seem to be already active, just update the stamp to tell the
-	 * timer that we're still active.  We don't mind occassional races.
+	 * timer that we're still active.  We don't mind occasional races.
 	 */
 	if (!list_empty(&iocg->active_list)) {
 		ioc_now(ioc, now);
@@ -2122,7 +2122,7 @@ static void ioc_forgive_debts(struct ioc *ioc, u64 usage_us_sum, int nr_debtors,
 }
 
 /*
- * Check the active iocgs' state to avoid oversleeping and deactive
+ * Check the active iocgs' state to avoid oversleeping and deactivate
  * idle iocgs.
  *
  * Since waiters determine the sleep durations based on the vrate
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 81be0096411d..1b2a537ed2fa 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -18,7 +18,7 @@
  * every configured node, and each configured node has it's own independent
  * queue depth.  This means that we only care about our latency targets at the
  * peer level.  Some group at the bottom of the hierarchy isn't going to affect
- * a group at the end of some other path if we're only configred at leaf level.
+ * a group at the end of some other path if we're only configured at leaf level.
  *
  * Consider the following
  *
@@ -34,7 +34,7 @@
  * throttle "unloved", but nobody else.
  *
  * In this example "fast", "slow", and "normal" will be the only groups actually
- * accounting their io latencies.  We have to walk up the heirarchy to the root
+ * accounting their io latencies.  We have to walk up the hierarchy to the root
  * on every submit and complete so we can do the appropriate stat recording and
  * adjust the queue depth of ourselves if needed.
  *
diff --git a/block/blk-merge.c b/block/blk-merge.c
index ffb4aa0ea68b..1b44f42b19d2 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -283,7 +283,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	/*
 	 * Bio splitting may cause subtle trouble such as hang when doing sync
 	 * iopoll in direct IO routine. Given performance gain of iopoll for
-	 * big IO can be trival, disable iopoll when split needed.
+	 * big IO can be trivial, disable iopoll when split needed.
 	 */
 	bio->bi_opf &= ~REQ_HIPRI;
 
@@ -341,7 +341,7 @@ void __blk_queue_split(struct bio **bio, unsigned int *nr_segs)
 	}
 
 	if (split) {
-		/* there isn't chance to merge the splitted bio */
+		/* there isn't chance to merge the split bio */
 		split->bi_opf |= REQ_NOMERGE;
 
 		bio_chain(split, *bio);
@@ -674,7 +674,7 @@ void blk_rq_set_mixed_merge(struct request *rq)
 	/*
 	 * @rq will no longer represent mixable attributes for all the
 	 * contained bios.  It will just track those of the first one.
-	 * Distributes the attributs to each bio.
+	 * Distributes the attributes to each bio.
 	 */
 	for (bio = rq->bio; bio; bio = bio->bi_next) {
 		WARN_ON_ONCE((bio->bi_opf & REQ_FAILFAST_MASK) &&
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d4d7c1caa439..5d5689ae4398 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -915,7 +915,7 @@ static bool blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 
 	/*
 	 * Just do a quick check if it is expired before locking the request in
-	 * so we're not unnecessarilly synchronizing across CPUs.
+	 * so we're not unnecessarily synchronizing across CPUs.
 	 */
 	if (!blk_mq_req_expired(rq, next))
 		return true;
@@ -1634,7 +1634,7 @@ static bool blk_mq_has_sqsched(struct request_queue *q)
 }
 
 /*
- * Return prefered queue to dispatch from (if any) for non-mq aware IO
+ * Return preferred queue to dispatch from (if any) for non-mq aware IO
  * scheduler.
  */
 static struct blk_mq_hw_ctx *blk_mq_get_sq_hctx(struct request_queue *q)
diff --git a/block/blk-settings.c b/block/blk-settings.c
index b4aa2f37fab6..63168b529360 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -749,7 +749,7 @@ void blk_queue_virt_boundary(struct request_queue *q, unsigned long mask)
 	/*
 	 * Devices that require a virtual boundary do not support scatter/gather
 	 * I/O natively, but instead require a descriptor list entry for each
-	 * page (which might not be idential to the Linux PAGE_SIZE).  Because
+	 * page (which might not be identical to the Linux PAGE_SIZE).  Because
 	 * of that they are not limited by our notion of "segment size".
 	 */
 	if (mask)
diff --git a/block/blk-stat.h b/block/blk-stat.h
index 17b47a86eefb..0541f7228ef0 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -105,7 +105,7 @@ void blk_stat_add_callback(struct request_queue *q,
  * @cb: The callback.
  *
  * When this returns, the callback is not running on any CPUs and will not be
- * called again unless readded.
+ * called again unless read.
  */
 void blk_stat_remove_callback(struct request_queue *q,
 			      struct blk_stat_callback *cb);
diff --git a/block/blk.h b/block/blk.h
index 3b53e44b967e..84f52f113231 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -252,7 +252,7 @@ static inline void req_set_nomerge(struct request_queue *q, struct request *req)
 }
 
 /*
- * The max size one bio can handle is UINT_MAX becasue bvec_iter.bi_size
+ * The max size one bio can handle is UINT_MAX because bvec_iter.bi_size
  * is defined as 'unsigned int', meantime it has to aligned to with logical
  * block size which is the minimum accepted unit by hardware.
  */
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 33d34d69cade..f7b23bdf4866 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -142,7 +142,7 @@ struct kyber_cpu_latency {
  */
 struct kyber_ctx_queue {
 	/*
-	 * Used to ensure operations on rq_list and kcq_map to be an atmoic one.
+	 * Used to ensure operations on rq_list and kcq_map to be an atomic one.
 	 * Also protect the rqs on rq_list when merge.
 	 */
 	spinlock_t lock;
diff --git a/block/opal_proto.h b/block/opal_proto.h
index b486b3ec7dc4..20190c39fe3a 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -212,7 +212,7 @@ enum opal_parameter {
 
 /* Packets derived from:
  * TCG_Storage_Architecture_Core_Spec_v2.01_r1.00
- * Secion: 3.2.3 ComPackets, Packets & Subpackets
+ * Section: 3.2.3 ComPackets, Packets & Subpackets
  */
 
 /* Comm Packet (header) for transmissions. */
@@ -405,7 +405,7 @@ struct d0_single_user_mode {
 };
 
 /*
- * Additonal Datastores feature
+ * Additional Datastores feature
  *
  * code == 0x0202
  */
diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
index 4b044e620d35..f0b51bf892d6 100644
--- a/block/partitions/ibm.c
+++ b/block/partitions/ibm.c
@@ -212,7 +212,7 @@ static int find_lnx1_partitions(struct parsed_partitions *state,
 		size = label->lnx.formatted_blocks * secperblk;
 	} else {
 		/*
-		 * Formated w/o large volume support. If the sanity check
+		 * Formatted w/o large volume support. If the sanity check
 		 * 'size based on geo == size based on i_size' is true, then
 		 * we can safely assume that we know the formatted size of
 		 * the disk, otherwise we need additional information
diff --git a/block/partitions/sun.c b/block/partitions/sun.c
index 47dc53eccf77..c67b4d145270 100644
--- a/block/partitions/sun.c
+++ b/block/partitions/sun.c
@@ -101,7 +101,7 @@ int sun_partition(struct parsed_partitions *state)
 
 	/*
 	 * So that old Linux-Sun partitions continue to work,
-	 * alow the VTOC to be used under the additional condition ...
+	 * allow the VTOC to be used under the additional condition ...
 	 */
 	use_vtoc = use_vtoc || !(label->vtoc.sanity ||
 				 label->vtoc.version || label->vtoc.nparts);
diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 6599bac0a78c..384aa4837acb 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -461,7 +461,7 @@ int sg_scsi_ioctl(struct request_queue *q, struct gendisk *disk, fmode_t mode,
 	if (err)
 		goto error;
 
-	/* default.  possible overriden later */
+	/* default.  possible overridden later */
 	req->retries = 5;
 
 	switch (opcode) {

base-commit: 430a67f9d6169a7b3e328bceb2ef9542e4153c7c
-- 
2.31.0

