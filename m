Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037A9C27C76
	for <linux-block@archiver.kernel.org>; Sat, 28 Jan 2023 16:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbjA1QXB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 Jan 2023 11:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbjA1QXA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Jan 2023 11:23:00 -0500
Received: from DM6FTOPR00CU001-vft-obe.outbound.protection.outlook.com (mail-cusazon11020024.outbound.protection.outlook.com [52.101.61.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78763D51D
        for <linux-block@vger.kernel.org>; Sat, 28 Jan 2023 08:22:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0FiIzVKB+u7wPdBBHAz3sC7HrV9pWDPLdDk89fsC6JwSuDwTPt91iuBP5pfHWaa5AYTVJJGkCLjBu2wCVb46ENMbyw+TaWPxx4QcARIt0pQt6eDfc3jvlmd9NnksLHKFjbTz6/iRVOQLqkyqu/IbEiIRb8DAocy7Ug7rcl7ZMryU80OLGZp9Ab1afdmHSjTC/q2r1GGgFqXvf3/P0WKvxgaEp4ZzUCBJMGHjjXuS4WfP2CY6oHnGRA2PCWQGWaEaHLxvdalnDWePaBH3SrBb5P4IzyGZ5b0wzl5ByWP6MnCpXvw1bPv2zUupI6aHPwkr5Z4f7qAqQyngTtXJOt/gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0fmZBlpeIXbGG+xhYtOxc4b5XGzmrMJuafSJ7QbKYE=;
 b=cSLbYxKWpzh+YMIfw4RFE3CYJxb4K18MRXzKIseTgkQJYi581AQzFr1mElh0UyWRCIQZv0EGbzoDNpym3FIrxivXi70WDY4Bc/mLZNCnA1vGLsluj+vpyB2PfxGFOSOXuc5u0c4wiB7GH1QLF/VCHOLk67j9LmSg9vOVALaDD73A2UHWMoMH0OWSennflktOXcTEjk65roIpnK+x2Stp1ROoVH6i1mOeqRGQtJuGxJI5uxjUcb6zGeFF+EcFzwlFoW/ES7MbknULJ/RzQLpGQqIhfWzuAId8isgQR3FffegaIukB0JQtYd/z5d25vY06RzuybAW1nH6LjKmAbuFpmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0fmZBlpeIXbGG+xhYtOxc4b5XGzmrMJuafSJ7QbKYE=;
 b=ZEj6HN6oOORq3cViE+Z26myEWgPmWvvU7pohEx2rjtCyufEG8QyIDB9H1bXE9tfD0r+McZXfyz9vkhot5Q/WNcSbXD975AkIcmth4FYHNn1iRLkgsaVzA9JToxcADN6T2TJPgtLHeTZIptJhyq1em6LtJ9he7ct7/Q4TLGMjeKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by BL1PR21MB3305.namprd21.prod.outlook.com (2603:10b6:208:39a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.7; Sat, 28 Jan
 2023 16:22:47 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::ef06:2e2c:3620:46a7]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::ef06:2e2c:3620:46a7%8]) with mapi id 15.20.6064.017; Sat, 28 Jan 2023
 16:22:47 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH v5.15.90 backport] block: don't allow multiple bios for IOCB_NOWAIT issue
Date:   Sat, 28 Jan 2023 08:21:35 -0800
Message-Id: <1674922895-78103-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:303:8e::30) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|BL1PR21MB3305:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d91546-a90e-4aa1-f4b0-08db014be44a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ca4uqCny3DQ2Q+BzrVpUNH1yK+PVWZr16Hle1lXxe3ZCh51Y+jU5zi0F69+IiMLMF5NbuYNMtvHxmvozANOkgZR/Y35w59lepKrqPoMIddWlr8vesXCoPnYPk1dahQvpk5GVR1psbj4yqZbFNEBGUead5Dy86tOM9gElvnlEguqm/nRs2Xeeu30ML0PPMRWp4Ktja/VGl168xwMcXnfIxpnULRquCPjolAWKYVL4l7I+sf6NiJsz6QXuFSXS0e1I7DY78L8V412RRUtu4uZ42YVPQcuyXImlGmHtkeYpaN/PwJL+5mcp5ll0bxlbqJ0S9DhOwXUTqQiQv6jPCOXPOPlvHlnDqSdzyKTdz1rahfV5XRA7++hqSR8uKIiiy6eSB+PNb0ph8XU61E03fr/Pgz6lAo4IyPmUwIPW/M+F/yg5Kiw1QmSnZqykUbSAJ+InMKDnMbW0Ta0YvhbC47yIXKF02j2rafxAZLRtsfsuz/w3ah2Bnwh1zIRlrvumLFhgN6Z+EfgC4BkuPIMEMeqv08xcjAzaTd7SiDH3Zwv8c+VQ0aeN/4X9Cu2B4noT0GrakH723ZhwfaMZC8rt+1/4+jX5pVZCexfufH/OA01j59h5HgaxaO/WcP6xb6bzxr+X1NytAwYq3hmN/gaVcTrLhsvLHsUFWMm9Bl8qqTTnGtMbC9q/HeUcYgfneDu6U5keAqoiM0+F8uDzrTU2KA3AIJJam+oXFp9aDXJLTpMCBHrcLD1QtCb23hQW020SrVZtWVKzgbgw/LqRAVl6dyrg5QLcK0jc5ynDYqFqaEIGb++NM9y8vJ9Yp6ApGtSCkVnM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199018)(52116002)(6486002)(186003)(26005)(478600001)(6512007)(966005)(2616005)(83380400001)(10290500003)(107886003)(6666004)(786003)(41300700001)(8676002)(38350700002)(41320700001)(38100700002)(316002)(6506007)(82960400001)(82950400001)(8936002)(66556008)(5660300002)(86362001)(4326008)(66946007)(66476007)(36756003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JJuG+jzUQEwMVyjIl6oT/fRNkFvDoWR8v/LecnBhQhhapZCVqiTwiF9kEUUV?=
 =?us-ascii?Q?OCeE5hYRNOZeq4G1AoPO5MsEap32oeiU6kwe3PKPcmhcRZW9PY7IrCE15pQ9?=
 =?us-ascii?Q?HjPUessk3kf6RCCxmO3H5DIcgI9MgT1QzoB2Tcbaw45IFfx0Q3EdiJ+zpChV?=
 =?us-ascii?Q?Jt5+1eCyVd9aMb0FApyFwXcjXrn0ECcmxzqnjIbmlP5VaxgnbcXny5/Atm4V?=
 =?us-ascii?Q?PV4lW3c0hzKHX+muy77o9W44DmLuPHt9r4UR4BbpNQ7mj1Ob3cdxuCQSgEWM?=
 =?us-ascii?Q?Ucz3Xgaq8rh3O98DPmFoW64oqv3/ZYcKepRQXXek38ejkqii5or9qQlHcOCf?=
 =?us-ascii?Q?3krxEwGR7oQqGpoegbPXRREAwPcI5NoOglvzAr4KBQTVmCbEehXtau8es+Fp?=
 =?us-ascii?Q?jpT+lPusyLx9sVGU9Uf3Ss3uCppGOTYcAgIwIK9r8l46iHj8/3XZnIaXAsW3?=
 =?us-ascii?Q?YxZXQFkDW2ZYDZnT7+GOh7cIRocWHKCdLSN0hgGFyJBm+zFdLMGlUeX+88Rr?=
 =?us-ascii?Q?rpGJE2tAc77PL8doelrbAGsgR1DqpVT74uo0OmDA4FDigZL2q5CXhAxzs7NL?=
 =?us-ascii?Q?CHTzd8r5HVoEjM+fz50Du5FxOa8nFi6xvnDCO/Sd/AF8IdkrLb7KzRFxOyZT?=
 =?us-ascii?Q?aGk2ODT2b2H3kFyRXR1KGDoZErZQiSgW1uQfueTN7UNpLgflJJ1n5931FRAX?=
 =?us-ascii?Q?22Ucj55wDc9nC0Tl+i/IDjMMlsF8sLisE9EvwMuuPn758SD4BrcJbesK9G3Q?=
 =?us-ascii?Q?3gMTfbU7IGOnAgRoSWQhYTYk1tuJR0VZprxD3I5n0zelnp7aZwiVzqXvXMH4?=
 =?us-ascii?Q?1/4QCk3AyHFIR3YxxW+U0QKyJ2aikfngo23kllsDHZNsxOaqecssU+yGcqZY?=
 =?us-ascii?Q?2UhQGDhtx5DL0k1S7hPZNc+fiaU9hUgorSZwAmYuSgAy0dvz/ZLAngyWdVmU?=
 =?us-ascii?Q?9zD5tc8bMPTO1L+92eSKjQk2MN6LOA3fjg32LBdCsk6um91T7+A8KUdLPsHh?=
 =?us-ascii?Q?Jo4R0sK27V0N2/QLxscG/f7lqDEhkRLjLy4M0kt3hF0GRY/k1RI1OFLjxOFz?=
 =?us-ascii?Q?rjbqvYKQmfWB8+NrCU84H1fgHZGLmHBmngG9QWg5zI6Z8FhX+CkDyFDvup4z?=
 =?us-ascii?Q?URxU1eywWO1pnPoQKSyLITecJhADIVEZDYQQ4ukyfRoK4KnMjqV1FBcFLV/P?=
 =?us-ascii?Q?vw2B48MIU/I5hSVz1Vl4SVqR8JTvHOSTD83z+3bWbgOe3GqgQ3E+hhYMaUPo?=
 =?us-ascii?Q?lBuZgjXIlJKQUCYYXIcaAPhsB+nlVo4OBLunQq4YxkMJHk86WIA8Y2o6qsc5?=
 =?us-ascii?Q?kDolYg800YmG823qbWfqs1o5A59qArtfofSt1iQPGRmnwmcYHa0prao493pS?=
 =?us-ascii?Q?gVSYpmIRDc2Yk0o0SDdSWofzMdAQWj/3DdTOobUxWJeD6lpCY5Y/ww12Ec+S?=
 =?us-ascii?Q?M733evPcl9A2EI6Kk1kuF6WJrBpLbdxC81rkXhXMAAZb5ZIY51Z1T2Pp5ziI?=
 =?us-ascii?Q?tEp92pgsXzXpVdn0CCy8hHYlr19ZJshLwcx3qKA+n/lQvk9gNhur1tmXvDMi?=
 =?us-ascii?Q?FwVYo8iVkOSQ1Ao+5EIZ361OmSWtNaxQL70S3b2G3H2TPorDrEUKc15kxGso?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d91546-a90e-4aa1-f4b0-08db014be44a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2023 16:22:47.0005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8/wlsbrB0OAwdJJhTr5SIaFiJdZFMC6GyBahqU91E56Bsvz4jjFElOJ1yKWshKzn2q10Ku3FpULfBxDsaiJUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3305
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we're doing a large IO request which needs to be split into multiple
bios for issue, then we can run into the same situation as the below
marked commit fixes - parts will complete just fine, one or more parts
will fail to allocate a request. This will result in a partially
completed read or write request, where the caller gets EAGAIN even though
parts of the IO completed just fine.

Do the same for large bios as we do for splits - fail a NOWAIT request
with EAGAIN. This isn't technically fixing an issue in the below marked
patch, but for stable purposes, we should have either none of them or
both.

This depends on: 613b14884b85 ("block: handle bio_split_to_limits() NULL return")

Cc: stable@vger.kernel.org # 5.15+
Fixes: 9cea62b2cbab ("block: don't allow splitting of a REQ_NOWAIT bio")
Link: https://github.com/axboe/liburing/issues/766
Reported-and-tested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---

This is a backport to v5.15.90 of a patch[1] from Jens Axboe.  I've
tested the backport with my basic io_uring tests, but the code
should be reviewed in the context of 5.15.90.  Commit 613b14884b85
mentioned above has already been backported and included in v5.15.90.

[1] https://lore.kernel.org/linux-block/1ce71005-c81b-374d-5bcf-e3b7e7c48d0d@kernel.dk/


 block/fops.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 1e970c2..42dafe7 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -244,17 +244,25 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 			break;
 		}
 
+		if (iocb->ki_flags & IOCB_NOWAIT) {
+			if (unlikely(iov_iter_count(iter))) {
+				bio_release_pages(bio, false);
+				bio_clear_flag(bio, BIO_REFFED);
+				bio_put(bio);
+				blk_finish_plug(&plug);
+				return -EAGAIN;
+			}
+			bio->bi_opf |= REQ_NOWAIT;
+		}
+
 		if (is_read) {
-			bio->bi_opf = REQ_OP_READ;
+			bio->bi_opf |= REQ_OP_READ;
 			if (dio->should_dirty)
 				bio_set_pages_dirty(bio);
 		} else {
-			bio->bi_opf = dio_bio_write_op(iocb);
+			bio->bi_opf |= dio_bio_write_op(iocb);
 			task_io_account_write(bio->bi_iter.bi_size);
 		}
-		if (iocb->ki_flags & IOCB_NOWAIT)
-			bio->bi_opf |= REQ_NOWAIT;
-
 		dio->size += bio->bi_iter.bi_size;
 		pos += bio->bi_iter.bi_size;
 
-- 
1.8.3.1

