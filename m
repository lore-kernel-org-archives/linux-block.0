Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E68C433F5
	for <linux-block@archiver.kernel.org>; Mon, 31 Jan 2022 20:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiAaUd5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Jan 2022 15:33:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46092 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378970AbiAaUdm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Jan 2022 15:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643661222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=UC9Tb4TqjXYhw3vTG6JNh+fY+4YQyHcZaN60FJV88JY=;
        b=GKNjU61pWLdVK6VPeWj6UVwmflA37u0KmF8Q0UUW4B1uId+U9qZO38caNplsUwbvQ3twA4
        vmaEpKBA3A0SyqcC9/6cbR3Nnb9zMLyaG7Qzoas00anhyUv03MBR2b1IGK5j3EKX1hjIxU
        jQzlz2fx4i9oa/B/FBNz7DcCNmSKUy4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-Hx1NQwtpNwKW86MqERxIoQ-1; Mon, 31 Jan 2022 15:33:40 -0500
X-MC-Unique: Hx1NQwtpNwKW86MqERxIoQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC5D11124C44
        for <linux-block@vger.kernel.org>; Mon, 31 Jan 2022 20:33:39 +0000 (UTC)
Received: from redhat (unknown [10.22.18.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 867C8101E819
        for <linux-block@vger.kernel.org>; Mon, 31 Jan 2022 20:33:39 +0000 (UTC)
Date:   Mon, 31 Jan 2022 15:33:37 -0500
From:   David Jeffery <djeffery@redhat.com>
To:     linux-block@vger.kernel.org
Subject: [PATCH] blk-mq: avoid extending delays of active hctx from
 blk_mq_delay_run_hw_queues
Message-ID: <20220131203337.GA17666@redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When blk_mq_delay_run_hw_queues sets an hctx to run in the future, it can
reset the delay length for an already pending delayed work run_work. This
creates a scenario where multiple hctx may have their queues set to run,
but if one runs first and finds nothing to do, it can reset the delay of
another hctx and stall the other hctx's ability to run requests.

To avoid this I/O stall when an hctx's run_work is already pending,
leave it untouched to run at its current designated time rather than
extending its delay. The work will still run which keeps closed the race
calling blk_mq_delay_run_hw_queues is needed for while also avoiding the
I/O stall.

Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 block/blk-mq.c |    8 ++++++++
 1 file changed, 8 insertions(+)


diff --git a/block/blk-mq.c b/block/blk-mq.c
index f3bf3358a3bb..ae46eb4bf547 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2177,6 +2177,14 @@ void blk_mq_delay_run_hw_queues(struct request_queue *q, unsigned long msecs)
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (blk_mq_hctx_stopped(hctx))
 			continue;
+		/*
+		 * If there is already a run_work pending, leave the
+		 * pending delay untouched. Otherwise, a hctx can stall
+		 * if another hctx is re-delaying the other's work
+		 * before the work executes.
+		 */
+		if (delayed_work_pending(&hctx->run_work))
+			continue;
 		/*
 		 * Dispatch from this hctx either if there's no hctx preferred
 		 * by IO scheduler or if it has requests that bypass the

