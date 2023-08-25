Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B118C7EE2C
	for <linux-block@archiver.kernel.org>; Fri, 25 Aug 2023 09:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbjHYJLx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Aug 2023 05:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238875AbjHYJLZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Aug 2023 05:11:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E5B19BF
        for <linux-block@vger.kernel.org>; Fri, 25 Aug 2023 02:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692954637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MOxXzYAwVk8su+pAQL33hLOQLiZp2L1Fw6EIRqNjBM4=;
        b=Ytrwh+EFrbLTjVPFWnkVUvpZX/IMT9+2voudkDyoxwj8+0VqPT7nEQnoa0SnVTAMKPdLBx
        bhNd+UYSRjpJkTxU6ygjv/tF6Vbkq+H7HU30WLlLW3UGMrkae+iNG3kx9bs4uccLnlB2G7
        +agm/4A1QKp/smwfV2zsx4PIT6CM1LQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-hmyKhL_UOX6qMuiVzf9KnQ-1; Fri, 25 Aug 2023 05:10:34 -0400
X-MC-Unique: hmyKhL_UOX6qMuiVzf9KnQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B118108BD87;
        Fri, 25 Aug 2023 09:10:34 +0000 (UTC)
Received: from localhost (unknown [10.72.120.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58AD66B59D;
        Fri, 25 Aug 2023 09:10:33 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] io_uring: add one helper for reaping iopoll events
Date:   Fri, 25 Aug 2023 17:09:58 +0800
Message-Id: <20230825090959.1866771-2-ming.lei@redhat.com>
In-Reply-To: <20230825090959.1866771-1-ming.lei@redhat.com>
References: <20230825090959.1866771-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prepare for reaping iopoll events before exiting io_wq, which may depend on
iopoll.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 io_uring/io_uring.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 88599852af82..c4adb44f1aa4 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3214,6 +3214,23 @@ static __cold bool io_uring_try_cancel_iowq(struct io_ring_ctx *ctx)
 	return ret;
 }
 
+static bool iopoll_reap_events(struct io_ring_ctx *ctx, bool reap_all)
+{
+	bool reapped = false;
+
+	/* SQPOLL thread does its own polling */
+	if ((!(ctx->flags & IORING_SETUP_SQPOLL) && reap_all) ||
+	    (ctx->sq_data && ctx->sq_data->thread == current)) {
+		while (!wq_list_empty(&ctx->iopoll_list)) {
+			io_iopoll_try_reap_events(ctx);
+			reapped = true;
+			cond_resched();
+		}
+	}
+
+	return reapped;
+}
+
 static __cold bool io_uring_try_cancel_requests(struct io_ring_ctx *ctx,
 						struct task_struct *task,
 						bool cancel_all)
@@ -3245,15 +3262,7 @@ static __cold bool io_uring_try_cancel_requests(struct io_ring_ctx *ctx,
 		ret |= (cret != IO_WQ_CANCEL_NOTFOUND);
 	}
 
-	/* SQPOLL thread does its own polling */
-	if ((!(ctx->flags & IORING_SETUP_SQPOLL) && cancel_all) ||
-	    (ctx->sq_data && ctx->sq_data->thread == current)) {
-		while (!wq_list_empty(&ctx->iopoll_list)) {
-			io_iopoll_try_reap_events(ctx);
-			ret = true;
-			cond_resched();
-		}
-	}
+	ret = iopoll_reap_events(ctx, cancel_all);
 
 	if ((ctx->flags & IORING_SETUP_DEFER_TASKRUN) &&
 	    io_allowed_defer_tw_run(ctx))
-- 
2.40.1

