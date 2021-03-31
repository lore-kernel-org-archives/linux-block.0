Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F45C433B4
	for <linux-block@archiver.kernel.org>; Wed, 31 Mar 2021 22:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDF8F61073
	for <linux-block@archiver.kernel.org>; Wed, 31 Mar 2021 22:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhCaWw4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Mar 2021 18:52:56 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:34635 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhCaWwq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Mar 2021 18:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617231166; x=1648767166;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HunEiUVWz+iH90OzAXNb4G/YNIo43JyNmlmUpixMVMY=;
  b=T3HX5JATjv0vnkJacLuIqRhfN85V3OfK3Pfu/B+GzayN9V1oBjlqrFN3
   FC8b9NY6oaLQyMdo0uEuN2QRxOXXTUfV/h+Xlc5lLN3tsamjw+N9r8SlK
   8jbTXPEuGvEf82EyhRjQNsfjVWrDsicgisSZJJVRr+V9JOisb7Kz/yNZG
   mY06Km3LjOBRa8LYknzyoa6Te8GfuVnbfum68LphmFLaHZnD9jFbrsRFz
   49suQsw9l2ojzywcTE/uuWJbWsrp+GrKqeiPYjCtud/4AwTmJDdqw5wL5
   f+Kh0GPk7roKMMvss8JN8qojhodAdYnmj1/K6f3M9HFaAIIXN4kEHHejT
   A==;
IronPort-SDR: ZHmhBw6bcpHvTzPbdgCMWOjy7wVIcL3grjnrkQu9Ci1hrr/EbmvpIqPnrwHAsS14BwujYFHSf4
 zXnBkz/Q6/y+qppjX7W0J8DQV/oaZ6fAwSRIxoq5W58hmLWQvB9F2gFT2sXxDGnvKOXg4cJEjl
 LWL/frUXAdxUjx6AaZUvlmGreqJ9dMvHWfAABDEVJNOJZF/O1qrmTOxplUc42q/xDycipRJLky
 /zJCfwnefKhGNc2LdOwORqO0Wvt7Az2874j1HmPcoslorp9wuKPzjuVzIWNBY+AUkN9oW9nHpo
 +Xc=
X-IronPort-AV: E=Sophos;i="5.81,295,1610380800"; 
   d="scan'208";a="274319192"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Apr 2021 06:52:45 +0800
IronPort-SDR: gwEy8kU41rZsCYoVRCrcTuHNs00NB+U/E5NcbWx8hfp38DNKAGMe6cyiAAM9OIsBbP/jyGI/s9
 6LqIW3aMYTz+Y4WqpIeazCWrZqXBJRs1hp8KqMLLtCMZ0us7SeOGozL2ZPnIU0Bwfy0PNfUWpL
 WP+m+BIrDNgLnR9PIpcQiO3aIW1mBMUPCRX/xvXsgiu5Td+PUnPqXnOXTuRK5I81++2RgbsUl0
 2dHF/Jfll6eNe+g7tjaaOGWsKs2PuDcudMpzEaFzZbRSPo8aAyJp++Zu1bUiStqmDTGMlkIqxr
 GLvWVBrcvfzQzo0ivCWLEYNf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 15:32:54 -0700
IronPort-SDR: fnaqjox1HETSeyFY4gXHlvQzz96FZgDfGovdYy64yFG05BS7YIp3Vt6ycKL3awv6EGWAWk3G/j
 wlKUy2bHAwtAveSB5v+ReZzErsKlgfGxEgnX08HnGvVvwsf7I9tPcV5GEqYac26/mJ6M0Hku+M
 Cba+eQrEwWOU3so+9ndOKmDdgdC0V+D2AOOStHCjJkaVItD4rz85pX7qBUgIJ6ExVzO3+VqQkl
 4rtlY18h5jOuxeYUhaA81sqRxnotelf8LeCBhs/kRq1aR0Bpdb7iZGLErHCznRyqbp3dAYe9vC
 ai4=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Mar 2021 15:52:45 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] null_blk: fix command timeout completion handling
Date:   Thu,  1 Apr 2021 07:52:44 +0900
Message-Id: <20210331225244.126426-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Memory backed or zoned null block devices may generate actual request
timeout errors due to the submission path being blocked on memory
allocation or zone locking. Unlike fake timeouts or injected timeouts,
the request submission path will call blk_mq_complete_request() or
blk_mq_end_request() for these real timeout errors, causing a double
completion and use after free situation as the block layer timeout
handler executes blk_mq_rq_timed_out() and __blk_mq_free_request() in
blk_mq_check_expired(). This problem often triggers a NULL pointer
dereference such as:

BUG: kernel NULL pointer dereference, address: 0000000000000050
RIP: 0010:blk_mq_sched_mark_restart_hctx+0x5/0x20
...
Call Trace:
  dd_finish_request+0x56/0x80
  blk_mq_free_request+0x37/0x130
  null_handle_cmd+0xbf/0x250 [null_blk]
  ? null_queue_rq+0x67/0xd0 [null_blk]
  blk_mq_dispatch_rq_list+0x122/0x850
  __blk_mq_do_dispatch_sched+0xbb/0x2c0
  __blk_mq_sched_dispatch_requests+0x13d/0x190
  blk_mq_sched_dispatch_requests+0x30/0x60
  __blk_mq_run_hw_queue+0x49/0x90
  process_one_work+0x26c/0x580
  worker_thread+0x55/0x3c0
  ? process_one_work+0x580/0x580
  kthread+0x134/0x150
  ? kthread_create_worker_on_cpu+0x70/0x70
  ret_from_fork+0x1f/0x30

This problem very often triggers when running the full btrfs xfstests
on a memory-backed zoned null block device in a VM with limited amount
of memory.

Avoid this by executing blk_mq_complete_request() in null_timeout_rq()
only for commands that are marked for a fake timeout completion using
the fake_timeout boolean in struct null_cmd. For timeout errors injected
through debugfs, the timeout handler will execute
blk_mq_complete_request()i as before. This is safe as the submission
path does not execute complete requests in this case.

In null_timeout_rq(), also make sure to set the command error field to
BLK_STS_TIMEOUT and to propagate this error through to the request
completion.

Reported-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/block/null_blk/main.c     | 26 +++++++++++++++++++++-----
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d6c821d48090..51bfd7737552 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1369,10 +1369,13 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
 	}
 
 	if (dev->zoned)
-		cmd->error = null_process_zoned_cmd(cmd, op,
-						    sector, nr_sectors);
+		sts = null_process_zoned_cmd(cmd, op, sector, nr_sectors);
 	else
-		cmd->error = null_process_cmd(cmd, op, sector, nr_sectors);
+		sts = null_process_cmd(cmd, op, sector, nr_sectors);
+
+	/* Do not overwrite errors (e.g. timeout errors) */
+	if (cmd->error == BLK_STS_OK)
+		cmd->error = sts;
 
 out:
 	nullb_complete_cmd(cmd);
@@ -1451,8 +1454,20 @@ static bool should_requeue_request(struct request *rq)
 
 static enum blk_eh_timer_return null_timeout_rq(struct request *rq, bool res)
 {
+	struct nullb_cmd *cmd = blk_mq_rq_to_pdu(rq);
+
 	pr_info("rq %p timed out\n", rq);
-	blk_mq_complete_request(rq);
+
+	/*
+	 * If the device is marked as blocking (i.e. memory backed or zoned
+	 * device), the submission path may be blocked waiting for resources
+	 * and cause real timeouts. For these real timeouts, the submission
+	 * path will complete the request using blk_mq_complete_request().
+	 * Only fake timeouts need to execute blk_mq_complete_request() here.
+	 */
+	cmd->error = BLK_STS_TIMEOUT;
+	if (cmd->fake_timeout)
+		blk_mq_complete_request(rq);
 	return BLK_EH_DONE;
 }
 
@@ -1473,6 +1488,7 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 	cmd->rq = bd->rq;
 	cmd->error = BLK_STS_OK;
 	cmd->nq = nq;
+	cmd->fake_timeout = should_timeout_request(bd->rq);
 
 	blk_mq_start_request(bd->rq);
 
@@ -1489,7 +1505,7 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 			return BLK_STS_OK;
 		}
 	}
-	if (should_timeout_request(bd->rq))
+	if (cmd->fake_timeout)
 		return BLK_STS_OK;
 
 	return null_handle_cmd(cmd, sector, nr_sectors, req_op(bd->rq));
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 83504f3cc9d6..4876d5adb12d 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -22,6 +22,7 @@ struct nullb_cmd {
 	blk_status_t error;
 	struct nullb_queue *nq;
 	struct hrtimer timer;
+	bool fake_timeout;
 };
 
 struct nullb_queue {
-- 
2.30.2

