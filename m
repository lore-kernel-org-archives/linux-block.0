Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B40CC282D7
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 13:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1E920833
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 13:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfA3N4u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:56:50 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:12147 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfA3N4u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 08:56:50 -0500
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0UDulqf070857;
        Wed, 30 Jan 2019 22:56:47 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp);
 Wed, 30 Jan 2019 22:56:47 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0UDuk2J070824
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 30 Jan 2019 22:56:47 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: WARNING in __flush_work
To:     axboe@kernel.dk
References: <000000000000c1ac2805809b7cf6@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <4d633ac8-2340-8759-f2a6-a147dafe3339@I-love.SAKURA.ne.jp>
Date:   Wed, 30 Jan 2019 22:56:43 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <000000000000c1ac2805809b7cf6@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From fd653e8dd0d5368cd0cd9ccd89cf3001e4584f8a Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Wed, 30 Jan 2019 22:21:45 +0900
Subject: [PATCH] block: pass no-op callback to INIT_WORK().

syzbot is hitting flush_work() warning caused by commit 4d43d395fed12463
("workqueue: Try to catch flush_work() without INIT_WORK().") [1].
Although that commit did not expect INIT_WORK(NULL) case, calling
flush_work() without setting a valid callback should be avoided anyway.
Fix this problem by setting a no-op callback instead of NULL.

[1] https://syzkaller.appspot.com/bug?id=e390366bc48bc82a7c668326e0663be3b91cbd29

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-and-tested-by: syzbot <syzbot+ba2a929dcf8e704c180e@syzkaller.appspotmail.com>
Cc: Tejun Heo <tj@kernel.org>
---
 block/blk-core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ab17c05..4673ebe 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -462,6 +462,10 @@ static void blk_rq_timed_out_timer(struct timer_list *t)
 	kblockd_schedule_work(&q->timeout_work);
 }
 
+static void blk_timeout_work(struct work_struct *work)
+{
+}
+
 /**
  * blk_alloc_queue_node - allocate a request queue
  * @gfp_mask: memory allocation flags
@@ -504,7 +508,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	timer_setup(&q->backing_dev_info->laptop_mode_wb_timer,
 		    laptop_mode_timer_fn, 0);
 	timer_setup(&q->timeout, blk_rq_timed_out_timer, 0);
-	INIT_WORK(&q->timeout_work, NULL);
+	INIT_WORK(&q->timeout_work, blk_timeout_work);
 	INIT_LIST_HEAD(&q->icq_list);
 #ifdef CONFIG_BLK_CGROUP
 	INIT_LIST_HEAD(&q->blkg_list);
-- 
1.8.3.1




