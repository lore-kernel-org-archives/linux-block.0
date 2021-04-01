Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF77CC433ED
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 06:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82D40600EF
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 06:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhDAG2U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Apr 2021 02:28:20 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:41218 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhDAG2F (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Apr 2021 02:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617258484; x=1648794484;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2Kvqd8auZiZ6tsnIvm/A+kxg6E4k9HUzKnCIlEyIxAw=;
  b=Q8PQqOt3fZn596tlpnMFLdLLKsZoK8PdjMQTtJobrp8B1BYo3FsALV20
   5cZgG8tq+zg80XWojIzNu18O45frA84KGI3hzm8RZF9sb8kt9JudR7Km6
   VR+iEoJCyOKx+a0zdbRYoWw6/k9IsGiM0RjTDClVgs8EVu10ubNi+4ZEO
   Cg+2tqzNyL0ycZN/PQO/kGfvZnzMuPw3pC7asZeTpg3Vv9AXhsTVhnyh2
   n2u57D9X02xl1xpQd2XKLKVQ0jgKpP6z3J7lGcpUEP35pEfAFnOwTDw3m
   HQYaAXIJ+Gg6twElCNAK47hMYbzlkYwlzU+YjhWhgFeoTO0SaTsKkYBlq
   A==;
IronPort-SDR: 8U1il+bpPV5L+zy0Dc/5D7Pg0o1sVou7mh32OLGsW+jfGA11c7YLDa5FHhaZWiuSme3inW3nB7
 7rRsVMGMo40ZWDCFNc6xwsDvZ6/QozpO1URpxVXsO59pKByIz7sv6vUIF0hr9mTTXk9YLoIhAq
 d7x/7P+kkLjKLDpUJIzolJMcNJpjyPWZ29u/QtCmC/o3slxp34bvd45UufZB4uqJ5UBm9Hg2FW
 WtquykRixT91U3tNgwxzofZ6pDd2jnDyqxpZI3gyQEfKbzQNXZONswH3BrLUHfJx8S2x+Zbnma
 Kuw=
X-IronPort-AV: E=Sophos;i="5.81,296,1610380800"; 
   d="scan'208";a="163420155"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Apr 2021 14:27:59 +0800
IronPort-SDR: m3sptMtSDCo55qXQI8/V4f9I9+7youPLUG9a+RqZvUbtb2vecg+rwkzSBlWBBLiFoWvwXAgBvu
 pb5BZf22eyNRiPSGQDDyFSGjzbwdkY9ljdG4Pbl80Rp92x+UthlF5fmYJAi7n1GusBeeIp1NE0
 C10zRX6nIMLzQ6qNZcvMQCdxaGzu/6oApkY/uACwHTnapkPBezjz4JJR2QcUYlbEralSTlaULI
 /bDdPHaKEWKKf0gmwyFo0NthTRJmoVCtqQijT5IyQfmsMdpoqC5pw8FIcxG6u0dc11oZ87TSJ+
 oq9m/NN31Nbn1SqykjTqeavO
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 23:09:37 -0700
IronPort-SDR: XMDhI+2Mllqgm+XOjqWfJrM5dVzH5xKWGSE54XuS8tfrBNQBd5Bxp+QVDUhfic6NeT1h+p4zUZ
 cPhlTU0pRwyHnHmpcuCTKzuSfPJmr3/XFiSmmwrneIdgMNwt0+wmlykdlmfIkPSvyM64jZ3io6
 DVKuv6sAqPG1k6akm86zIxexyS3LpUTmNSN4t4E/moj4D2tiqb8enUmrt0iIK7Azj2cuHEfdYu
 FsEOLAccR+GK2hDaMnF/wuf4+FEs/U/kC6TyTWiMa0cToKH5dX1fqzM751eJwjC31dhnK93T9n
 mDs=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 31 Mar 2021 23:27:54 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2] null_blk: fix command timeout completion handling
Date:   Thu,  1 Apr 2021 15:27:53 +0900
Message-Id: <20210401062753.193845-1-damien.lemoal@wdc.com>
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
blk_mq_complete_request() as before. This is safe as the submission
path does not execute complete requests in this case.

In null_timeout_rq(), also make sure to set the command error field to
BLK_STS_TIMEOUT and to propagate this error through to the request
completion.

Reported-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Tested-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Reviewed-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
---
Changes from v2:
* Fixed typo in commit message

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

