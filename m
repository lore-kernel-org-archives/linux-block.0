Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BEFC433E2
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 14:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBFC22078B
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 14:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgIAOE4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:04:56 -0400
Received: from smtp.h3c.com ([60.191.123.50]:1764 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728272AbgIAOEt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Sep 2020 10:04:49 -0400
Received: from DAG2EX10-IDC.srv.huawei-3com.com ([10.8.0.73])
        by h3cspam02-ex.h3c.com with ESMTPS id 081E3IK3046769
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Sep 2020 22:03:19 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX10-IDC.srv.huawei-3com.com (10.8.0.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 1 Sep 2020 22:03:22 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.1713.004; Tue, 1 Sep 2020 22:03:22 +0800
From:   Tianxianting <tian.xianting@h3c.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [v3] blk-mq: use BLK_MQ_NO_TAG for no tag
Thread-Topic: [PATCH] [v3] blk-mq: use BLK_MQ_NO_TAG for no tag
Thread-Index: AQHWfD0K8koEXAvdJUKfqbC/GaNLZ6lT1/Nw
Date:   Tue, 1 Sep 2020 14:03:22 +0000
Message-ID: <465ec9bf9b7b45fb98d7f21498328300@h3c.com>
References: <20200827063417.35851-1-tian.xianting@h3c.com>
In-Reply-To: <20200827063417.35851-1-tian.xianting@h3c.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 081E3IK3046769
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens
Could I get the feedback from you whether this patch can be applied? 
Thanks a lot.

-----Original Message-----
From: tianxianting (RD) 
Sent: Thursday, August 27, 2020 2:34 PM
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org; linux-kernel@vger.kernel.org; tianxianting (RD) <tian.xianting@h3c.com>
Subject: [PATCH] [v3] blk-mq: use BLK_MQ_NO_TAG for no tag

Replace various magic -1 constants for tags with BLK_MQ_NO_TAG.

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 block/blk-core.c     | 4 ++--
 block/blk-mq-sched.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c index d9d632639..c7eaf7504 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -116,8 +116,8 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 	rq->__sector = (sector_t) -1;
 	INIT_HLIST_NODE(&rq->hash);
 	RB_CLEAR_NODE(&rq->rb_node);
-	rq->tag = -1;
-	rq->internal_tag = -1;
+	rq->tag = BLK_MQ_NO_TAG;
+	rq->internal_tag = BLK_MQ_NO_TAG;
 	rq->start_time_ns = ktime_get_ns();
 	rq->part = NULL;
 	refcount_set(&rq->ref, 1);
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c index a19cdf159..439481f59 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -522,7 +522,7 @@ void blk_mq_sched_insert_request(struct request *rq, bool at_head,
 		goto run;
 	}
 
-	WARN_ON(e && (rq->tag != -1));
+	WARN_ON(e && (rq->tag != BLK_MQ_NO_TAG));
 
 	if (blk_mq_sched_bypass_insert(hctx, !!e, rq)) {
 		/*
--
2.17.1

