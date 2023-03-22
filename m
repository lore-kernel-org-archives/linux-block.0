Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3046C76195
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 00:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCVAYJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Mar 2023 20:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCVAYJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2023 20:24:09 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9A0311FC
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 17:24:08 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M01qAX007380
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 17:24:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=FYTiwteue9O3GyNlt9lJQtg5O7g1VL7645gn3rkoBdg=;
 b=Femxjp8ZBf+AP1MKe5ApM5+TqruQRtaXRjyg/fFfn3Qw3C8Agg4c9AiYRtEqMIerDVvk
 6pK8v8VGM8zbWOrOv1uqdCYMyCIl3KkmZAfnavkbb1bFaGefWTDnsC9G7+OwXgS2BuXZ
 f42mmI9Ha7ZzCXn81k/eMT0ONFBkJEl5cTtB0MKrM2OXRA0AM1p/F6meXKDy/3heRRmO
 bWQpfZzmFa27dNnQhm9dv51Be6HUsh7eG6nKaNZ+2yf1jEEZQLNR+8FZLeZWu/zmfdhZ
 NmcRCNzg2ealrRqfq/JJgDtED2BhGOIK/Nwu9qH7B408W3mtrOq9Og1bNNblEMmoaCG6 jQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pfdx9v42c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 17:24:08 -0700
Received: from twshared4298.02.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 21 Mar 2023 17:24:06 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 80A5214196985; Tue, 21 Mar 2023 17:23:52 -0700 (PDT)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>,
        <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC:     Keith Busch <kbusch@kernel.org>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH 3/3] blk-mq: directly poll requests
Date:   Tue, 21 Mar 2023 17:23:50 -0700
Message-ID: <20230322002350.4038048-4-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230322002350.4038048-1-kbusch@meta.com>
References: <20230322002350.4038048-1-kbusch@meta.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Kgexc-yDTK7n-WIVtlJWoj1U1ijCtI_n
X-Proofpoint-ORIG-GUID: Kgexc-yDTK7n-WIVtlJWoj1U1ijCtI_n
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Polling needs a bio with a valid bi_bdev, but neither of those are
guaranteed for polled driver requests. Make request based polling use
directly use blk-mq's polling function.

When executing a request from a polled hctx, we know the request's
cookie, and that it's from a live multi-queue that supports polling, so
we can safely skip everything that bio_poll provides.

Link: http://lists.infradead.org/pipermail/linux-nvme/2023-March/038340.html
Reported-by: Martin Belanger <Martin.Belanger@dell.com>
Reported-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4e30459df8151..932d2e95392e6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1334,8 +1334,6 @@ bool blk_rq_is_poll(struct request *rq)
 		return false;
 	if (rq->mq_hctx->type !=3D HCTX_TYPE_POLL)
 		return false;
-	if (WARN_ON_ONCE(!rq->bio))
-		return false;
 	return true;
 }
 EXPORT_SYMBOL_GPL(blk_rq_is_poll);
@@ -1343,7 +1341,7 @@ EXPORT_SYMBOL_GPL(blk_rq_is_poll);
 static void blk_rq_poll_completion(struct request *rq, struct completion *=
wait)
 {
 	do {
-		bio_poll(rq->bio, NULL, 0);
+		blk_mq_poll(rq->q, blk_rq_to_qc(rq), NULL, 0);
 		cond_resched();
 	} while (!completion_done(wait));
 }
--=20
2.34.1

