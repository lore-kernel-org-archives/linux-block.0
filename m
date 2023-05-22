Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129DDC7EE2E
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 18:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbjEVSjU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 May 2023 14:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjEVSjT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 14:39:19 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB688103
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 11:39:12 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-64d2a87b9daso3140100b3a.0
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 11:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684780752; x=1687372752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WQEBPaTp9e92UDSFetDYUksigH+qbg6oynzPV16cmA=;
        b=FIm2LA2MpCElb/6azzJ5/BMi3F/N+72zhLDpJOfMTKjLHHGsWZczdzp66a5W3MEo7A
         2jbbO1HjlWbEALSpMI/Y8SOp0oyylZiAZmjkmlr1vjYc94+30nDIDMI7cOa0zxduyRN7
         JuwRhSFSSCsjFRZ6YLD4IfW11JEcpXOGiIVEH9BEHyPqm0QsBiMxuco/jAKjSdtPpdd7
         ZJe64FPhFOSE/81fNINXEdG85ORqB4Aau3moBFklRAV+YzIS7qMlEyY91TyHtw29SdeF
         crZQZZcTbDSQujQfEQ8L+7YCE01OxTM6bSjV+UZe5bTIibUmmB6y+N+NDglmEaPxDt7q
         g9OQ==
X-Gm-Message-State: AC+VfDzfqcnqtvEwnJJ1UZKcihYjx51XbqhvmVoNfD0LgWHsJafHpiFH
        jJZfVrfbahslh8QQHl7lnKjQ/GEwRuc=
X-Google-Smtp-Source: ACHHUZ5A9GwoIpft4afFk4MqM5Dy0horkrQJv1ovXB0nj5k0S7TzgOlyKRxazcLOr/osTShdGkIxAg==
X-Received: by 2002:a05:6a20:914c:b0:100:6863:8be7 with SMTP id x12-20020a056a20914c00b0010068638be7mr13133657pzc.62.1684780752173;
        Mon, 22 May 2023 11:39:12 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:642f:e57f:85fb:3794])
        by smtp.gmail.com with ESMTPSA id d61-20020a17090a6f4300b0024dfbac9e2fsm6710335pjk.21.2023.05.22.11.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 11:39:11 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 3/7] block: Requeue requests if a CPU is unplugged
Date:   Mon, 22 May 2023 11:38:38 -0700
Message-ID: <20230522183845.354920-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230522183845.354920-1-bvanassche@acm.org>
References: <20230522183845.354920-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Requeue requests instead of sending these to the dispatch list if a CPU
is unplugged. This gives the I/O scheduler the chance to preserve the
order of zoned write requests.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 632aee9af60f..bc52a57641e2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3497,13 +3497,13 @@ static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
 }
 
 /*
- * 'cpu' is going away. splice any existing rq_list entries from this
- * software queue to the hw queue dispatch list, and ensure that it
- * gets run.
+ * @cpu is going away. Requeue any existing rq_list entries from its
+ * software queue and run the hw queue associated with @cpu.
  */
 static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 {
 	struct blk_mq_hw_ctx *hctx;
+	struct request *rq, *next;
 	struct blk_mq_ctx *ctx;
 	LIST_HEAD(tmp);
 	enum hctx_type type;
@@ -3525,9 +3525,9 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	if (list_empty(&tmp))
 		return 0;
 
-	spin_lock(&hctx->lock);
-	list_splice_tail_init(&tmp, &hctx->dispatch);
-	spin_unlock(&hctx->lock);
+	list_for_each_entry_safe(rq, next, &tmp, queuelist)
+		blk_mq_requeue_request(rq, false);
+	blk_mq_kick_requeue_list(hctx->queue);
 
 	blk_mq_run_hw_queue(hctx, true);
 	return 0;
