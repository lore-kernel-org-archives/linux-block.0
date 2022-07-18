Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF82C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 12:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiGRMXV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 08:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiGRMXV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 08:23:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B2F25297
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 05:23:19 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lmh0K20Z9zlW4H;
        Mon, 18 Jul 2022 20:21:37 +0800 (CST)
Received: from dggpeml500009.china.huawei.com (7.185.36.209) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Jul 2022 20:23:17 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500009.china.huawei.com
 (7.185.36.209) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 18 Jul
 2022 20:23:16 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>, <hch@lst.de>,
        "Yufen Yu" <yuyufen@huawei.com>
Subject: [PATCH] blk-mq: run queue after issuing the last request of the plug list
Date:   Mon, 18 Jul 2022 20:35:28 +0800
Message-ID: <20220718123528.178714-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500009.china.huawei.com (7.185.36.209)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We do test on a virtio scsi device (/dev/sda) and the default mq
scheduler is 'none'. We found a IO hung as following:

blk_finish_plug
  blk_mq_plug_issue_direct
      scsi_mq_get_budget
      //get budget_token fail and sdev->restarts=1

			     	 scsi_end_request
				   scsi_run_queue_async
                                   //sdev->restart=0 and run queue

     blk_mq_request_bypass_insert
        //add request to hctx->dispatch list

  //continue to dispath plug list
  blk_mq_dispatch_plug_list
      blk_mq_try_issue_list_directly
        //success issue all requests from plug list

After .get_budget fail, scsi_mq_get_budget will increase 'restarts'.
Normally, it will run hw queue when io complete and set 'restarts'
as 0. But if we run queue before adding request to the dispatch list
and blk_mq_dispatch_plug_list also success issue all requests, then
on one will run queue, and the request will be stall in the dispatch
list and cannot complete forever.

To fix the bug, we run queue after issuing the last request in
function blk_mq_sched_insert_requests.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-mq-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index a4f7c101b53b..c3ad97ca2753 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -490,8 +490,8 @@ void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
 		blk_mq_insert_requests(hctx, ctx, list);
 	}
 
-	blk_mq_run_hw_queue(hctx, run_queue_async);
  out:
+	blk_mq_run_hw_queue(hctx, run_queue_async);
 	percpu_ref_put(&q->q_usage_counter);
 }
 
-- 
2.31.1

