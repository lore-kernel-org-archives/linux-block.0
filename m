Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71C1C433EF
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 09:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbiA0JVr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 04:21:47 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:34564 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234708AbiA0JVp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 04:21:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0V2zNzDl_1643275303;
Received: from localhost(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0V2zNzDl_1643275303)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 27 Jan 2022 17:21:43 +0800
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk
Subject: [RFC] blk-mq: complete request locallly if not in interrupt context
Date:   Thu, 27 Jan 2022 17:21:43 +0800
Message-Id: <20220127092143.1808-1-xiaoguang.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For block devices that call blk_mq_complete_request() to end request
in process context, it's pointless to redirect the completion to be
done in block soft-irq, also blk_mq_raise_softirq() isnt't a very
light operation, which contains preempt and hard irq disable, wake
up ksoftirqd in non-interrupt context.

I found this issue while I use tcm_loop and tcmu(backstore is file)
to evaluate performance, tcm_loop end request in workqueue.
Without this patch: libaio engine, direct io, randwrite, io size 128k
job0: (groupid=0, jobs=1): err= 0: pid=20876: Thu Jan 27 15:33:45 2022
  write: IOPS=15.7k, BW=1966MiB/s (2062MB/s)(115GiB/60001msec); 0 zone resets
    slat (nsec): min=5675, max=83552, avg=8689.69, stdev=996.96
    clat (usec): min=231, max=99977, avg=498.89, stdev=501.69
     lat (usec): min=291, max=99986, avg=507.70, stdev=501.69

With this patch:
job0: (groupid=0, jobs=1): err= 0: pid=12813: Thu Jan 27 15:50:46 2022
  write: IOPS=16.8k, BW=2101MiB/s (2203MB/s)(123GiB/60001msec); 0 zone resets
    slat (usec): min=5, max=125, avg=14.12, stdev=10.31
    clat (usec): min=306, max=65380, avg=460.78, stdev=506.24
     lat (usec): min=341, max=65389, avg=475.04, stdev=505.27

Which improves throughput and reduces lat.

Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
---
 block/blk-mq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8874a63ae952..9fdffc65d7ba 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -974,6 +974,9 @@ bool blk_mq_complete_request_remote(struct request *rq)
 		return true;
 	}
 
+	if (!in_interrupt())
+		return false;
+
 	if (rq->q->nr_hw_queues == 1) {
 		blk_mq_raise_softirq(rq);
 		return true;
-- 
2.14.4.44.g2045bb6

