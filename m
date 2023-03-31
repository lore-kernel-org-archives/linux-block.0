Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9ECC76196
	for <linux-block@archiver.kernel.org>; Fri, 31 Mar 2023 18:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjCaSCO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Mar 2023 14:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjCaSB5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Mar 2023 14:01:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF5722E91
        for <linux-block@vger.kernel.org>; Fri, 31 Mar 2023 11:01:37 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32VHFNSN009444
        for <linux-block@vger.kernel.org>; Fri, 31 Mar 2023 11:01:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=7N7+T3oAc0Z3pa3pgBoPp9XPY+QAKDM3jfNkpleR/Uo=;
 b=AmTdlLU7KvuccEo32J31Q7Fjgc6IJ9C2L8+rS3XnST5/q7SyR4vP6ZUX8lDoWlOgdbR1
 5AAlMF36e/6KgaeeTwDgEQV4qH3q+4NIiCQHqKvowqAN0y2E9RbaPZksVsIr6ptJksvx
 PiGF1Efwk2uOcXMTBIozR29SADWYDy6674+ru8qAYjQFTZDGloUHyzpk4Cv8FqWkAxyJ
 r9E6bcweiYFsKLQ9+ITVkaV4hrRaJYr6nyBzvOr7DFTs5hfJKD0R84iraDh/nUoqK+Fx
 jgX1EclHEsv7nAW6MK31YzJgd2oD/zOJYQ6NQQKe5D+BnXd7/JUtHlJQod8/yO3DfXcl og== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pnr3fvew8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 31 Mar 2023 11:01:36 -0700
Received: from twshared21760.39.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 31 Mar 2023 11:01:35 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id CFA3314E89F23; Fri, 31 Mar 2023 11:01:27 -0700 (PDT)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC:     Keith Busch <kbusch@kernel.org>, <stable@kernel.org>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Daniel Wagner <dwagner@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCHv2] blk-mq: directly poll requests
Date:   Fri, 31 Mar 2023 11:00:56 -0700
Message-ID: <20230331180056.1155862-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: nZFjkhHLLn7UjqjLDgl_vKCtXoxFyo4N
X-Proofpoint-ORIG-GUID: nZFjkhHLLn7UjqjLDgl_vKCtXoxFyo4N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Polling needs a bio with a valid bi_bdev, but neither of those are
guaranteed for polled driver requests. Make request based polling
directly use blk-mq's polling function instead.

When executing a request from a polled hctx, we know the request's
cookie, and that it's from a live blk-mq queue that supports polling, so
we can safely skip everything that bio_poll provides.

Cc: stable@kernel.org
Reported-by: Martin Belanger <Martin.Belanger@dell.com>
Reported-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Tested-by: Daniel Wagner <dwagner@suse.de>
Revieded-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
v1->v2:

  Split from the unnecessary nvme fabrics polling cleanup patches since
  there's no dependency with them, and will be posted separately.

  Added received reviews, tests, and cc stable

 block/blk-mq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1b304f66f4e8e..3b75de43293c3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1326,8 +1326,6 @@ bool blk_rq_is_poll(struct request *rq)
 		return false;
 	if (rq->mq_hctx->type !=3D HCTX_TYPE_POLL)
 		return false;
-	if (WARN_ON_ONCE(!rq->bio))
-		return false;
 	return true;
 }
 EXPORT_SYMBOL_GPL(blk_rq_is_poll);
@@ -1335,7 +1333,7 @@ EXPORT_SYMBOL_GPL(blk_rq_is_poll);
 static void blk_rq_poll_completion(struct request *rq, struct completion=
 *wait)
 {
 	do {
-		bio_poll(rq->bio, NULL, 0);
+		blk_mq_poll(rq->q, blk_rq_to_qc(rq), NULL, 0);
 		cond_resched();
 	} while (!completion_done(wait));
 }
--=20
2.34.1

