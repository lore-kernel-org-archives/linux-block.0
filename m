Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA11C433B4
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 08:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FF8361437
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 08:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbhDUIQA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Apr 2021 04:16:00 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:46414 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhDUIP4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Apr 2021 04:15:56 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210421081521epoutp02d0aa614be7f5962f857e7c4a1be27a18~30XvuJxTZ2634026340epoutp02o
        for <linux-block@vger.kernel.org>; Wed, 21 Apr 2021 08:15:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210421081521epoutp02d0aa614be7f5962f857e7c4a1be27a18~30XvuJxTZ2634026340epoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1618992921;
        bh=HS4J43y+tg5ufiqDn6go8vMT66WmpgWbwxk48ryxnhc=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=u2odaMOptHW+nq6fnkpXv5tmCQ+wSmz6TnHTMTn4ZJb2YaqO70pZk3IdaV/g23HHp
         UWM1CEGr+GXK3+zyCsVNtJj27bIbNo8PPOAljmk79t4BYScf6RP15RqoBmFVayOoJm
         wHKqRCy2LEWOk49/9fgMN/9t0q/PeXM3V8WWWdsQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20210421081520epcas2p4f782116aa51acd0be403561e7cd7e84b~30Xum733o1037210372epcas2p4d;
        Wed, 21 Apr 2021 08:15:20 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4FQCzB5pCXz4x9QR; Wed, 21 Apr
        2021 08:15:18 +0000 (GMT)
X-AuditID: b6c32a46-e01ff700000025de-b9-607fdf16b39f
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.42.09694.61FDF706; Wed, 21 Apr 2021 17:15:18 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] block: remove redundant check in blk_attempt_plug_merge
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sung-Jun Park <sungjun07.park@samsung.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        Jieon Seol <jieon.seol@samsung.com>,
        Jaemyung Lee <jaemyung.lee@samsung.com>,
        Keoseong Park <keosung.park@samsung.com>,
        Dukhyun Kwon <d_hyun.kwon@samsung.com>,
        JinHwan Park <jh.i.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210421081517epcms2p75252b49900647146260b4f3c18cfd7c5@epcms2p7>
Date:   Wed, 21 Apr 2021 17:15:17 +0900
X-CMS-MailID: 20210421081517epcms2p75252b49900647146260b4f3c18cfd7c5
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmha7Y/foEg8nfhSxW3+1ns3h5SNNi
        18GDbBarHoRb9PZvZbPYfHADs0X/v3YWi22fBS2On3zHaLH3lrbF5V1z2Cw6p69hceDxuHy2
        1KNvyypGj8+b5AKYo3JsMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22V
        XHwCdN0yc4AOUlIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUGBoW6BUn5haX5qXr
        JefnWhkaGBiZAlUm5GRMuGJccIS3YtKU1SwNjBe4uhg5OSQETCQObZnE2MXIxSEksINRYsLl
        +SxdjBwcvAKCEn93CIPUCAt4SLy+uoYRxBYSUJJYf3EWO0RcT+LWQ4g4m4COxPQT98HiIgLq
        ErOPb2cGmckscI5Z4vyKjywQy3glZrQ/hbKlJbYv38oIYWtI/FjWywxhi0rcXP2WHcZ+f2w+
        VI2IROu9s1A1ghIPfu6GiktKHNv9gQnCrpfYeucX2DMSAj2MEod33mKFSOhLXOvYCLaYV8BX
        on3WXLA4i4CqxKMFHVDLXCS+HbkBFmcWkJfY/nYOMyggmAU0Jdbv0gcxJQSUJY7cgnulYeNv
        dnQ2swCfRMfhv3DxHfOeQJ2mJrHu53omiDEyErfmMU5gVJqFCOhZSNbOQli7gJF5FaNYakFx
        bnpqsVGBEXLUbmIEJ00ttx2MU95+0DvEyMTBeIhRgoNZSYT3fm1NghBvSmJlVWpRfnxRaU5q
        8SFGU6CHJzJLiSbnA9N2Xkm8oamRmZmBpamFqZmRhZI478/UugQhgfTEktTs1NSC1CKYPiYO
        TqkGJlWb7t1rsrgPdNbzfYzdd3jKqejPy7+mX/M85RV2q/FpwZtN0p9uz+Zf9lYs1vRCSNrL
        12fy15xTfbGsj0f8/OSd2e9Vm/29Lir4dwt5fdAVi1PL3S7iaHNy8aS5YXf8sl4+aVpf7Tj9
        RprKkgDeMwFJvVGi8ldyJ1yQlV/JcPtNZ++538rbbxm9f7vBIm3FpykfN8cl8Ah4TZJ3VEhR
        u3r+9NU5j6XnOVxuuuG0amFLgFPEeW77ub+szlzirH2asC93c488u+0kIZuLv4+HTnYwKmeI
        nSMX4zjl17v7es97NKbn7P8sobatrWTWwjfRkk1tbz57zkp1e/XJ8lls2G1pt4yztl7vnp4Q
        Osws6abEUpyRaKjFXFScCADLfDqYIwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210421081517epcms2p75252b49900647146260b4f3c18cfd7c5
References: <CGME20210421081517epcms2p75252b49900647146260b4f3c18cfd7c5@epcms2p7>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_attempt_plug_merge is only called by blk_mq_submit_bio and the
parameter of same_queue_rq is not NULL. This patch remove redundant
check for same_queue_rq is not NULL in list_for_each_entry_reverse.

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 block/blk-merge.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index ffb4aa0ea68b..0af8a276de09 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -1030,7 +1030,6 @@ static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
  * @nr_segs: number of segments in @bio
  * @same_queue_rq: pointer to &struct request that gets filled in when
  * another request associated with @q is found on the plug list
- * (optional, may be %NULL)
  *
  * Determine whether @bio being queued on @q can be merged with a request
  * on %current's plugged list.  Returns %true if merge was successful,
@@ -1059,18 +1058,16 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 	plug_list = &plug->mq_list;
 
 	list_for_each_entry_reverse(rq, plug_list, queuelist) {
-		if (rq->q == q && same_queue_rq) {
-			/*
-			 * Only blk-mq multiple hardware queues case checks the
-			 * rq in the same queue, there should be only one such
-			 * rq in a queue
-			 **/
-			*same_queue_rq = rq;
-		}
-
 		if (rq->q != q)
 			continue;
 
+		/*
+		 * Only blk-mq multiple hardware queues case checks the
+		 * rq in the same queue, there should be only one such
+		 * rq in a queue
+		 **/
+		*same_queue_rq = rq;
+
 		if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
 		    BIO_MERGE_OK)
 			return true;
-- 
2.25.1

