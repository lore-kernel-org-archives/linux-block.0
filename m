Return-Path: <SRS0=aEt0=ZG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703C9C432C3
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 22:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C5020706
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 22:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="EF0AF64K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfKNWvh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Nov 2019 17:51:37 -0500
Received: from linux.microsoft.com ([13.77.154.182]:57734 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfKNWvh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Nov 2019 17:51:37 -0500
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 60F1420BCFAD; Thu, 14 Nov 2019 14:51:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 60F1420BCFAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1573771896;
        bh=WV644kJDTY/IDY2jipf0kW2lG8VT+H0spEuwz+hRcI0=;
        h=From:To:Cc:Subject:Date:From;
        b=EF0AF64K51Fm2myP0Se+Akzj+OVPw4Kxst3CpZ+l5+pC4D5Gfm0kJwXZWQv0i7j9P
         2tsKMR55kxEgeAs7wDXb7CWoULeZlBxdMV6gh2m17DXLoN1+tmFbD4bEoGSwjfuc0L
         bZ4xUEm7O3sRGxmkWFO3jGRVppNIL3x0SIrkAGWc=
From:   longli@linuxonhyperv.com
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [PATCH] blk-mq: avoid repeatedly scheduling the same work to run hardware queue
Date:   Thu, 14 Nov 2019 14:51:24 -0800
Message-Id: <1573771884-38879-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Long Li <longli@microsoft.com>

SCSI layer calls blk_mq_run_hw_queues() in scsi_end_request(), for every
completed I/O. blk_mq_run_hw_queues() in turn schedules some works to run
the hardware queues.

The actual work is queued by mod_delayed_work_on(), it turns out the cost of
this function is high on locking and CPU usage, when the I/O workload has
high queue depth. Most of these calls are not necessary since the queue is
already scheduled to run, and has not run yet.

This patch tries to solve this problem by avoiding scheduling work when it's
already scheduled.

Benchmark results:
The following tests are run on a RAM backed virtual disk on Hyper-V, with 8
FIO jobs with 4k random read I/O. The test numbers are for IOPS.

queue_depth	pre-patch	after-patch	improvement
16		190k		190k		0%
64		235k		240k		2%
256		180k		256k		42%
1024		156k		250k		60%

Signed-off-by: Long Li <longli@microsoft.com>
---
 block/blk-mq.c         | 12 ++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ec791156e9cc..a882bd65167a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1476,6 +1476,16 @@ static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
 		put_cpu();
 	}
 
+	/*
+	 * Queue a work to run queue. If this is a non-delay run and the
+	 * work is already scheduled, avoid scheduling the same work again.
+	 */
+	if (!msecs) {
+		if (test_bit(BLK_MQ_S_WORK_QUEUED, &hctx->state))
+			return;
+		set_bit(BLK_MQ_S_WORK_QUEUED, &hctx->state);
+	}
+
 	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work,
 				    msecs_to_jiffies(msecs));
 }
@@ -1561,6 +1571,7 @@ void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx)
 	cancel_delayed_work(&hctx->run_work);
 
 	set_bit(BLK_MQ_S_STOPPED, &hctx->state);
+	clear_bit(BLK_MQ_S_WORK_QUEUED, &hctx->state);
 }
 EXPORT_SYMBOL(blk_mq_stop_hw_queue);
 
@@ -1626,6 +1637,7 @@ static void blk_mq_run_work_fn(struct work_struct *work)
 	struct blk_mq_hw_ctx *hctx;
 
 	hctx = container_of(work, struct blk_mq_hw_ctx, run_work.work);
+	clear_bit(BLK_MQ_S_WORK_QUEUED, &hctx->state);
 
 	/*
 	 * If we are stopped, don't run the queue.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 0bf056de5cc3..98269d3fd141 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -234,6 +234,7 @@ enum {
 	BLK_MQ_S_STOPPED	= 0,
 	BLK_MQ_S_TAG_ACTIVE	= 1,
 	BLK_MQ_S_SCHED_RESTART	= 2,
+	BLK_MQ_S_WORK_QUEUED	= 3,
 
 	BLK_MQ_MAX_DEPTH	= 10240,
 
-- 
2.20.1

