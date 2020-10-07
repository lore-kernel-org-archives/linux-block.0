Return-Path: <SRS0=w7gf=DO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00388C3279D
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 03:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB43E208C3
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 03:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="i/c2g+os"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgJGDRW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Oct 2020 23:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbgJGDRM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Oct 2020 23:17:12 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F629C0613D3
        for <linux-block@vger.kernel.org>; Tue,  6 Oct 2020 20:17:11 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f19so508608pfj.11
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2020 20:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nPkmLEjjOLqKd/lOoAyA8z7n9dUCjwGzd+W0L3DZgSM=;
        b=i/c2g+osuUxGIsLB3AH+kyrVOsH7GDY82yaZk6DFm7TuOhQlVuanhZZn96R5kN3izp
         QCF6S7wYFvfEzqAWN4JNKCbmAxfjPUM41Xq23XmkKwysvjXL85bj9vgw91NQOOK5/Rt+
         p+HAZAhwRnRxmNuQa9Jgi2tqC06ZPFxoLEpOswxrCs3AWf0oIMM7K699j2Mt7owk9KFe
         TpVS1j5IyNSI1FB1hBUGb33xr+uCXUaBh5wd7IfXrgUXBdLrsG5ogZ9CFp5EPiUScT41
         Moa9yhVJI/PXM6UYGWvx5QP0lRzV4L7N8vOyZ0EFG8ZmnTZ2IDJjOSjJHTwSWKzAEH6U
         zKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nPkmLEjjOLqKd/lOoAyA8z7n9dUCjwGzd+W0L3DZgSM=;
        b=d88sKio9Ub53GnGJPECcHxx2JgWkGpmOqM0T6FUHuYzQtGRZgt+BQVuduOX5yjYcXl
         wIXlNMvp/xPQUB3jNBXMJgubW3LM3UADAO33CgUnS3XRzoWezhHdGXJQTDBLvw+b0Atw
         PrS53ajEAr/zYY1f8FS8g+4nMwuFMG49WvGSf/nF8pl97+Fi8ed/F4grGvZH6hHVRVj+
         Hb++q5kt1vRqonRXxViWV3VxY3Dmq4ICqj4AWFDGFB8DeNB2NNQ1xR5kiNVLuHKQmix2
         ip3T6bRCo0k0mYIaMoNGcD+U4pSeok1q8ACzxAiXWjBKqyMUbBy8bOPUo3gMHF7LAcYd
         ckcA==
X-Gm-Message-State: AOAM533KyjQ9Jvww2OXexfGNISzebAzwV/LOcQWSBVdvvVlNLviq0h13
        CGMcxjq2Dd1FePWK8oUMqxN9tQ==
X-Google-Smtp-Source: ABdhPJzxgagkn4cVqjUy8sr7sdcfRTWbXc2ao2DIrr5tMY6Uq7VD6rrtEFb369pBeTAqS3uisiBzXw==
X-Received: by 2002:a65:4bcc:: with SMTP id p12mr1093870pgr.353.1602040631013;
        Tue, 06 Oct 2020 20:17:11 -0700 (PDT)
Received: from localhost.localdomain ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id e1sm729094pfd.198.2020.10.06.20.17.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2020 20:17:10 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhuyinyin@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: [PATCH v3 4/4] io_uring: Fix double list add in io_queue_async_work()
Date:   Wed,  7 Oct 2020 11:16:35 +0800
Message-Id: <20201007031635.65295-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201007031635.65295-1-songmuchun@bytedance.com>
References: <20201007031635.65295-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we queue work in io_poll_wake(), it will leads to list double
add. So we should add the list when the callback func is the
io_sq_wq_submit_work.

The following oops was seen:

    list_add double add: new=ffff9ca6a8f1b0e0, prev=ffff9ca62001cee8,
    next=ffff9ca6a8f1b0e0.
    ------------[ cut here ]------------
    kernel BUG at lib/list_debug.c:31!
    Call Trace:
     <IRQ>
     io_poll_wake+0xf3/0x230
     __wake_up_common+0x91/0x170
     __wake_up_common_lock+0x7a/0xc0
     io_commit_cqring+0xea/0x280
     ? blkcg_iolatency_done_bio+0x2b/0x610
     io_cqring_add_event+0x3e/0x60
     io_complete_rw+0x58/0x80
     dio_complete+0x106/0x250
     blk_update_request+0xa0/0x3b0
     blk_mq_end_request+0x1a/0x110
     blk_mq_complete_request+0xd0/0xe0
     nvme_irq+0x129/0x270 [nvme]
     __handle_irq_event_percpu+0x7b/0x190
     handle_irq_event_percpu+0x30/0x80
     handle_irq_event+0x3c/0x60
     handle_edge_irq+0x91/0x1e0
     do_IRQ+0x4d/0xd0
     common_interrupt+0xf/0xf

Fixes: 1c4404efcf2c ("io_uring: make sure async workqueue is canceled on exit")
Reported-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/io_uring.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index c65f78f395655..a7cfe976480d8 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -513,12 +513,14 @@ static inline void io_queue_async_work(struct io_ring_ctx *ctx,
 		}
 	}
 
-	req->files = current->files;
+	if (req->work.func == io_sq_wq_submit_work) {
+		req->files = current->files;
 
-	spin_lock_irqsave(&ctx->task_lock, flags);
-	list_add(&req->task_list, &ctx->task_list);
-	req->work_task = NULL;
-	spin_unlock_irqrestore(&ctx->task_lock, flags);
+		spin_lock_irqsave(&ctx->task_lock, flags);
+		list_add(&req->task_list, &ctx->task_list);
+		req->work_task = NULL;
+		spin_unlock_irqrestore(&ctx->task_lock, flags);
+	}
 
 	queue_work(ctx->sqo_wq[rw], &req->work);
 }
@@ -667,6 +669,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 		state->cur_req++;
 	}
 
+	INIT_LIST_HEAD(&req->task_list);
 	req->file = NULL;
 	req->ctx = ctx;
 	req->flags = 0;
-- 
2.11.0

