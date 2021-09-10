Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B04C433F5
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 09:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B720611C1
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 09:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhIJJMe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Sep 2021 05:12:34 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9413 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbhIJJMe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Sep 2021 05:12:34 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H5VPH3kpNz8yRX;
        Fri, 10 Sep 2021 17:06:59 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Fri, 10 Sep 2021 17:11:21 +0800
Received: from huawei.com (10.175.127.227) by dggema761-chm.china.huawei.com
 (10.1.198.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Fri, 10
 Sep 2021 17:11:21 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <axboe@kernel.dk>, <rostedt@goodmis.org>, <mingo@redhat.com>,
        <acme@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH] blktrace: Fix uaf in blk_trace access after removing by sysfs
Date:   Fri, 10 Sep 2021 17:21:20 +0800
Message-ID: <20210910092120.182270-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema761-chm.china.huawei.com (10.1.198.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is an use-after-free problem triggered by following process:

      P1(sda)				P2(sdb)
			echo 0 > /sys/block/sdb/trace/enable
			  blk_trace_remove_queue
			    synchronize_rcu
			    blk_trace_free
			      relay_close
rcu_read_lock
__blk_add_trace
  trace_note_tsk
  (Iterate running_trace_list)
			        relay_close_buf
				  relay_destroy_buf
				    kfree(buf)
    trace_note(sdb's bt)
      relay_reserve
        buf->offset <- nullptr deference (use-after-free) !!!
rcu_read_unlock

[  502.714379] BUG: kernel NULL pointer dereference, address:
0000000000000010
[  502.715260] #PF: supervisor read access in kernel mode
[  502.715903] #PF: error_code(0x0000) - not-present page
[  502.716546] PGD 103984067 P4D 103984067 PUD 17592b067 PMD 0
[  502.717252] Oops: 0000 [#1] SMP
[  502.720308] RIP: 0010:trace_note.isra.0+0x86/0x360
[  502.732872] Call Trace:
[  502.733193]  __blk_add_trace.cold+0x137/0x1a3
[  502.733734]  blk_add_trace_rq+0x7b/0xd0
[  502.734207]  blk_add_trace_rq_issue+0x54/0xa0
[  502.734755]  blk_mq_start_request+0xde/0x1b0
[  502.735287]  scsi_queue_rq+0x528/0x1140
...
[  502.742704]  sg_new_write.isra.0+0x16e/0x3e0
[  502.747501]  sg_ioctl+0x466/0x1100

Reproduce method:
  ioctl(/dev/sda, BLKTRACESETUP, blk_user_trace_setup[buf_size=127])
  ioctl(/dev/sda, BLKTRACESTART)
  ioctl(/dev/sdb, BLKTRACESETUP, blk_user_trace_setup[buf_size=127])
  ioctl(/dev/sdb, BLKTRACESTART)

  echo 0 > /sys/block/sdb/trace/enable &
  // Add delay(mdelay/msleep) before kernel enters blk_trace_free()

  ioctl$SG_IO(/dev/sda, SG_IO, ...)
  // Enters trace_note_tsk() after blk_trace_free() returned
  // Use mdelay in rcu region rather than msleep(which may schedule out)

Don't remove blk_trace by sysfs when blk_trace is at Blktrace_running
state, just like function __blk_trace_remove() does. The state change
process and blk_trace_remove_queue() are protected and by mutex lock
'q->debugfs_mutex', so the sequence of stopping blk_trace first and
then removing it will be ensured.

Fixes: c71a896154119f ("blktrace: add ftrace plugin")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 kernel/trace/blktrace.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index c221e4c3f625..7fe29bb9746f 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1821,8 +1821,17 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 		}
 		if (value)
 			ret = blk_trace_setup_queue(q, bdev);
-		else
-			ret = blk_trace_remove_queue(q);
+		else {
+			/*
+			 * Don't remove blk_trace under running state, in
+			 * case triggering use-after-free in function
+			 * __blk_add_trace().
+			 */
+			if (bt->trace_state != Blktrace_running)
+				ret = blk_trace_remove_queue(q);
+			else
+				ret = -EBUSY;
+		}
 		goto out_unlock_bdev;
 	}
 
-- 
2.31.1

