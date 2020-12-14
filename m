Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0F8C1B0E3
	for <linux-block@archiver.kernel.org>; Mon, 14 Dec 2020 02:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4640207A0
	for <linux-block@archiver.kernel.org>; Mon, 14 Dec 2020 02:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437918AbgLNCYL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Dec 2020 21:24:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33096 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726316AbgLNCYC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Dec 2020 21:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607912552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5zVWZPSaAWv7Lht4qqlxYxjkrqFIiQRPSSGPBSVzjCQ=;
        b=T/vbxzpMgco7fFeIWqU+dZdLmRx6cwRVShApryCVxSaUU83IWj6Q1ErInLE1Q45yamqvxX
        fG7akFWYCx057Q1a+BhMQ3iXKEURbQ/FnV27JChdrIQxDwmb+mkXbORwazFbU1hBOxQaM8
        gjJSdReXvNOO4+9QR6ms4H+l/O3dzTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-bV2H1bGLMj6Px7YDytYEFA-1; Sun, 13 Dec 2020 21:22:29 -0500
X-MC-Unique: bV2H1bGLMj6Px7YDytYEFA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19C0E18C8C02;
        Mon, 14 Dec 2020 02:22:28 +0000 (UTC)
Received: from localhost (ovpn-12-164.pek2.redhat.com [10.72.12.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66B556267D;
        Mon, 14 Dec 2020 02:22:22 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] blktrace: fix 'BUG: sleeping function called from invalid context' in case of PREEMPT_RT
Date:   Mon, 14 Dec 2020 10:22:17 +0800
Message-Id: <20201214022217.1754273-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

trace_note_tsk() is called by __blk_add_trace(), which is covered by RCU read lock.
So in case of PREEMPT_RT, warning of 'BUG: sleeping function called from invalid context'
will be triggered because spin lock is converted to rtmutex.

Fix the issue by converting running_trace_lock into raw_spin_lock().

Cc: Christoph Hellwig <hch@lst.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/trace/blktrace.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 2c5b3c5317c2..53dc876d669d 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -34,7 +34,7 @@ static struct trace_array *blk_tr;
 static bool blk_tracer_enabled __read_mostly;
 
 static LIST_HEAD(running_trace_list);
-static __cacheline_aligned_in_smp DEFINE_SPINLOCK(running_trace_lock);
+static __cacheline_aligned_in_smp DEFINE_RAW_SPINLOCK(running_trace_lock);
 
 /* Select an alternative, minimalistic output than the original one */
 #define TRACE_BLK_OPT_CLASSIC	0x1
@@ -121,12 +121,12 @@ static void trace_note_tsk(struct task_struct *tsk)
 	struct blk_trace *bt;
 
 	tsk->btrace_seq = blktrace_seq;
-	spin_lock_irqsave(&running_trace_lock, flags);
+	raw_spin_lock_irqsave(&running_trace_lock, flags);
 	list_for_each_entry(bt, &running_trace_list, running_list) {
 		trace_note(bt, tsk->pid, BLK_TN_PROCESS, tsk->comm,
 			   sizeof(tsk->comm), 0);
 	}
-	spin_unlock_irqrestore(&running_trace_lock, flags);
+	raw_spin_unlock_irqrestore(&running_trace_lock, flags);
 }
 
 static void trace_note_time(struct blk_trace *bt)
@@ -669,9 +669,9 @@ static int __blk_trace_startstop(struct request_queue *q, int start)
 			blktrace_seq++;
 			smp_mb();
 			bt->trace_state = Blktrace_running;
-			spin_lock_irq(&running_trace_lock);
+			raw_spin_lock_irq(&running_trace_lock);
 			list_add(&bt->running_list, &running_trace_list);
-			spin_unlock_irq(&running_trace_lock);
+			raw_spin_unlock_irq(&running_trace_lock);
 
 			trace_note_time(bt);
 			ret = 0;
@@ -679,9 +679,9 @@ static int __blk_trace_startstop(struct request_queue *q, int start)
 	} else {
 		if (bt->trace_state == Blktrace_running) {
 			bt->trace_state = Blktrace_stopped;
-			spin_lock_irq(&running_trace_lock);
+			raw_spin_lock_irq(&running_trace_lock);
 			list_del_init(&bt->running_list);
-			spin_unlock_irq(&running_trace_lock);
+			raw_spin_unlock_irq(&running_trace_lock);
 			relay_flush(bt->rchan);
 			ret = 0;
 		}
-- 
2.28.0

