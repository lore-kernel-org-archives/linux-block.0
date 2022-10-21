Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97191C4332F
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 11:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiJULRI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Oct 2022 07:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiJULQ6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 07:16:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AF7254375
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 04:16:52 -0700 (PDT)
Received: from frapeml100003.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mv21f612Vz6823d;
        Fri, 21 Oct 2022 19:15:02 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 frapeml100003.china.huawei.com (7.182.85.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 13:16:49 +0200
Received: from [10.126.168.107] (10.126.168.107) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 12:16:49 +0100
Message-ID: <b44c42f8-db20-eff8-fba4-07a64ca47918@huawei.com>
Date:   Fri, 21 Oct 2022 12:16:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   John Garry <john.garry@huawei.com>
Subject: Issue in blk_mq_alloc_request_hctx()
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.168.107]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi guys,

I find that a call to blk_mq_alloc_request_hctx() sometimes has rq->bio 
set when returned, when I didn't think it should. I notice that we 
explicitly zero this field (and data len and sector) in 
blk_mq_alloc_request().

This trips up scsi_setup_scsi_cmd() for me, which checks these fields.

This is what I thought needs changing:

---8<----

 From 396d0b64b73cc6fb5193189d9da2c6107dbeff83 Mon Sep 17 00:00:00 2001
From: John Garry <john.garry@huawei.com>
Date: Fri, 21 Oct 2022 11:56:11 +0100
Subject: [PATCH] blk-mq: Properly init rq and fix queue enter/exit in
  blk_mq_alloc_request_hctx()


diff --git a/block/blk-mq.c b/block/blk-mq.c
index f33ea455dd72..cce5cda3c442 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -611,6 +611,7 @@ struct request *blk_mq_alloc_request_hctx(struct 
request_queue *q,
  		.nr_tags	= 1,
  	};
  	u64 alloc_time_ns = 0;
+	struct request *rq;
  	unsigned int cpu;
  	unsigned int tag;
  	int ret;
@@ -660,8 +661,15 @@ struct request *blk_mq_alloc_request_hctx(struct 
request_queue *q,
  	tag = blk_mq_get_tag(&data);
  	if (tag == BLK_MQ_NO_TAG)
  		goto out_queue_exit;
-	return blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), tag,
+	rq = blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), tag,
  					alloc_time_ns);
+	if (!rq)
+		goto out_queue_exit;
+
+	rq->__data_len = 0;
+	rq->__sector = (sector_t) -1;
+	rq->bio = rq->biotail = NULL;
+	return rq;


--->8---


What that, now my code under dev looks ok. Is that change correct? Seems 
strange to be missed..

Cheers,
John
