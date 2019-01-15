Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720FBC43387
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 04:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4201720651
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 04:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfAOEAX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 23:00:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727547AbfAOEAX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 23:00:23 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CDBE52D7FF;
        Tue, 15 Jan 2019 04:00:22 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD7015D9CA;
        Tue, 15 Jan 2019 04:00:04 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sbitmap: Protect swap_lock from hardirq
Date:   Tue, 15 Jan 2019 11:59:52 +0800
Message-Id: <20190115035952.13325-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 15 Jan 2019 04:00:23 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The original report is actually one real deadlock:

    [  106.132865]  Possible interrupt unsafe locking scenario:
    [  106.132865]
    [  106.133659]        CPU0                    CPU1
    [  106.134194]        ----                    ----
    [  106.134733]   lock(&(&sb->map[i].swap_lock)->rlock);
    [  106.135318]                                local_irq_disable();
    [  106.136014]                                lock(&sbq->ws[i].wait);
    [  106.136747]                                lock(&(&hctx->dispatch_wait_lock)->rlock);
    [  106.137742]   <Interrupt>
    [  106.138110]     lock(&sbq->ws[i].wait);

Because we may call blk_mq_get_driver_tag() directly from
blk_mq_dispatch_rq_list() without holding any lock, then HARDIRQ may come
and the above DEADLOCK is triggered.

ab53dcfb3e7b ("sbitmap: Protect swap_lock from hardirq") tries to fix
this issue by using 'spin_lock_bh', which isn't enough because we complete
request from hardirq context direclty in case of multiqueue.

Cc: Clark Williams <williams@redhat.com>
Fixes: ab53dcfb3e7b ("sbitmap: Protect swap_lock from hardirq")
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 lib/sbitmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 864354000e04..5b382c1244ed 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -27,8 +27,9 @@ static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
 {
 	unsigned long mask, val;
 	bool ret = false;
+	unsigned long flags;
 
-	spin_lock_bh(&sb->map[index].swap_lock);
+	spin_lock_irqsave(&sb->map[index].swap_lock, flags);
 
 	if (!sb->map[index].cleared)
 		goto out_unlock;
@@ -49,7 +50,7 @@ static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
 
 	ret = true;
 out_unlock:
-	spin_unlock_bh(&sb->map[index].swap_lock);
+	spin_unlock_irqrestore(&sb->map[index].swap_lock, flags);
 	return ret;
 }
 
-- 
2.14.4

