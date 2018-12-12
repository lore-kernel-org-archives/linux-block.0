Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723D0C04EB8
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 11:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A3120873
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 11:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A3120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeLLLoo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:44:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbeLLLoo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 06:44:44 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 83A4C85A04;
        Wed, 12 Dec 2018 11:44:43 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CF6A60C5C;
        Wed, 12 Dec 2018 11:44:39 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        stable@vger.kernel.org, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH] block: deactivate blk_stat timer in wbt_disable_default()
Date:   Wed, 12 Dec 2018 19:44:34 +0800
Message-Id: <20181212114434.13435-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 12 Dec 2018 11:44:43 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

rwb_enabled() can't be changed when there is any inflight IO.

wbt_disable_default() may set rwb->wb_normal as zero, however the
blk_stat timer may still be pending, and the timer function will update
wrb->wb_normal again.

This patch introduces blk_stat_deactivate() and applies it in
wbt_disable_default(), then the following IO hang triggered when running
parted & switching io scheduler can be fixed:

[  369.937806] INFO: task parted:3645 blocked for more than 120 seconds.
[  369.938941]       Not tainted 4.20.0-rc6-00284-g906c801e5248 #498
[  369.939797] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  369.940768] parted          D    0  3645   3239 0x00000000
[  369.941500] Call Trace:
[  369.941874]  ? __schedule+0x6d9/0x74c
[  369.942392]  ? wbt_done+0x5e/0x5e
[  369.942864]  ? wbt_cleanup_cb+0x16/0x16
[  369.943404]  ? wbt_done+0x5e/0x5e
[  369.943874]  schedule+0x67/0x78
[  369.944298]  io_schedule+0x12/0x33
[  369.944771]  rq_qos_wait+0xb5/0x119
[  369.945193]  ? karma_partition+0x1c2/0x1c2
[  369.945691]  ? wbt_cleanup_cb+0x16/0x16
[  369.946151]  wbt_wait+0x85/0xb6
[  369.946540]  __rq_qos_throttle+0x23/0x2f
[  369.947014]  blk_mq_make_request+0xe6/0x40a
[  369.947518]  generic_make_request+0x192/0x2fe
[  369.948042]  ? submit_bio+0x103/0x11f
[  369.948486]  ? __radix_tree_lookup+0x35/0xb5
[  369.949011]  submit_bio+0x103/0x11f
[  369.949436]  ? blkg_lookup_slowpath+0x25/0x44
[  369.949962]  submit_bio_wait+0x53/0x7f
[  369.950469]  blkdev_issue_flush+0x8a/0xae
[  369.951032]  blkdev_fsync+0x2f/0x3a
[  369.951502]  do_fsync+0x2e/0x47
[  369.951887]  __x64_sys_fsync+0x10/0x13
[  369.952374]  do_syscall_64+0x89/0x149
[  369.952819]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  369.953492] RIP: 0033:0x7f95a1e729d4
[  369.953996] Code: Bad RIP value.
[  369.954456] RSP: 002b:00007ffdb570dd48 EFLAGS: 00000246 ORIG_RAX: 000000000000004a
[  369.955506] RAX: ffffffffffffffda RBX: 000055c2139c6be0 RCX: 00007f95a1e729d4
[  369.956389] RDX: 0000000000000001 RSI: 0000000000001261 RDI: 0000000000000004
[  369.957325] RBP: 0000000000000002 R08: 0000000000000000 R09: 000055c2139c6ce0
[  369.958199] R10: 0000000000000000 R11: 0000000000000246 R12: 000055c2139c0380
[  369.959143] R13: 0000000000000004 R14: 0000000000000100 R15: 0000000000000008

Cc: stable@vger.kernel.org
Cc: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-stat.h | 5 +++++
 block/blk-wbt.c  | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/blk-stat.h b/block/blk-stat.h
index f4a1568e81a4..17b47a86eefb 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -145,6 +145,11 @@ static inline void blk_stat_activate_nsecs(struct blk_stat_callback *cb,
 	mod_timer(&cb->timer, jiffies + nsecs_to_jiffies(nsecs));
 }
 
+static inline void blk_stat_deactivate(struct blk_stat_callback *cb)
+{
+	del_timer_sync(&cb->timer);
+}
+
 /**
  * blk_stat_activate_msecs() - Gather block statistics during a time window in
  * milliseconds.
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 8ac93fcbaa2e..0c62bf4eca75 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -760,8 +760,10 @@ void wbt_disable_default(struct request_queue *q)
 	if (!rqos)
 		return;
 	rwb = RQWB(rqos);
-	if (rwb->enable_state == WBT_STATE_ON_DEFAULT)
+	if (rwb->enable_state == WBT_STATE_ON_DEFAULT) {
+		blk_stat_deactivate(rwb->cb);
 		rwb->wb_normal = 0;
+	}
 }
 EXPORT_SYMBOL_GPL(wbt_disable_default);
 
-- 
2.9.5

