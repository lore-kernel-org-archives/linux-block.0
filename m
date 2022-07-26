Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA320C433EF
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 10:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbiGZKtO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 06:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238790AbiGZKtM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 06:49:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B7A2409B
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 03:49:10 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LsYVc2FtszjX5b;
        Tue, 26 Jul 2022 18:46:16 +0800 (CST)
Received: from dggpeml500009.china.huawei.com (7.185.36.209) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 18:49:08 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500009.china.huawei.com
 (7.185.36.209) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Jul
 2022 18:49:08 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <ming.lei@redhat.com>, <yukuai3@huawei.com>,
        <linux-block@vger.kernel.org>, Yufen Yu <yuyufen@huawei.com>
Subject: [PATCH v2] blk-mq: run queue no matter whether the request is the last request
Date:   Tue, 26 Jul 2022 19:01:11 +0800
Message-ID: <20220726110111.1557859-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

It is wrong to use last request of plug list to decide if run queue is
needed since all the remained requests in plug list may be from other
hctxs. To fix the bug, pass run_queue as true always to
blk_mq_request_bypass_insert().

Fix-suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 93d9d60980fb..1eb13d57a946 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2568,7 +2568,7 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
 			break;
 		case BLK_STS_RESOURCE:
 		case BLK_STS_DEV_RESOURCE:
-			blk_mq_request_bypass_insert(rq, false, last);
+			blk_mq_request_bypass_insert(rq, false, true);
 			blk_mq_commit_rqs(hctx, &queued, from_schedule);
 			return;
 		default:
-- 
2.31.1

