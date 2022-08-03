Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D31C00140
	for <linux-block@archiver.kernel.org>; Wed,  3 Aug 2022 02:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiHCCFY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Aug 2022 22:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiHCCFX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Aug 2022 22:05:23 -0400
X-Greylist: delayed 1173 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 Aug 2022 19:05:21 PDT
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AC96142
        for <linux-block@vger.kernel.org>; Tue,  2 Aug 2022 19:05:20 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4LyF60326TzlDHw
        for <linux-block@vger.kernel.org>; Wed,  3 Aug 2022 09:44:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgD3djBB0+liuEKIAA--.18393S4;
        Wed, 03 Aug 2022 09:45:45 +0800 (CST)
From:   Yufen Yu <yuyufen@huawei.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, yukuai3@huawei.com,
        yuyufen@huawei.com, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH RESEND v2] blk-mq: run queue no matter whether the request is the last request
Date:   Wed,  3 Aug 2022 09:57:23 +0800
Message-Id: <20220803015723.3632521-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgD3djBB0+liuEKIAA--.18393S4
X-Coremail-Antispam: 1UD129KBjvJXoW7trW3GrWxuw17JrW5Zw13Jwb_yoW8CF17pr
        W5Ca1FkFsYqFs3t348Ja1fG347urWDCrZrtr1UKr13Za98K397tFn0qr4UXw1Iyrs5AFsx
        Gr45W3sxWw45W37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1j6r18M7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxAIw28IcVAKzI0E
        Y4vE52x082I5MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU10eHDUUUUU==
Sender: yuyufen@huaweicloud.com
X-CM-SenderInfo: p1x13wthq6x35dzhxuhorxvhhfrp/
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
Reviewed-by: Ming Lei <ming.lei@redhat.com>
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

