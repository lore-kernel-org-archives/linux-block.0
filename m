Return-Path: <SRS0=lp7R=4I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4F9C11D81
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 02:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5950521D56
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 02:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgBTCpA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 21:45:00 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51578 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbgBTCpA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 21:45:00 -0500
Received: by mail-pj1-f68.google.com with SMTP id fa20so240533pjb.1
        for <linux-block@vger.kernel.org>; Wed, 19 Feb 2020 18:44:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qS4jYuSHffNekwNAsgtk/oo8N3cmEg+YtUoGOtRuAMU=;
        b=r2SaDeYJxbBCuWVWHedBHV24K1EwyOvOUd/8Lo494YGTi4POVogJUpX5Z3TyBJ/jzz
         YMRKhxUlxMAh8u2YRDrP6y1kR48B+UZ+IuIujUCvPm6+wtAb4tDh1UhfPvzU9OdiwGQk
         k+NmyAUJSWRMi3TWx4VU/Zc/CU09EnQHvnWsevSYFl3wpwX0aR3+WGWJ+jgmHpfuRebR
         YYN1iLFgBmDRrs6sGaPX80yBDsYkDvE3uMhnAjSJ38vmHXp8WlfNVg0areHdx0lX3h51
         u5I4sNaTl/VpjkxJY8cEpxjQO6T1bCEFK5uan+5Ec8afFUjsD/0//SOK0/E6rTogyias
         qAzw==
X-Gm-Message-State: APjAAAVju2gzWpZc+vklbGgIZlac+NxaDHlRkSOjitTklDhZnrOe4qEo
        WsUkCApzOA9hL+P0Z35M2vk=
X-Google-Smtp-Source: APXvYqwlXt73jUDAsKHbmUqng97rWYe5XG5QdE5hUd5CLnd+PSm/6szUUBVn3rFrtnUF2mJ5WASxrw==
X-Received: by 2002:a17:902:82c3:: with SMTP id u3mr27454974plz.73.1582166698682;
        Wed, 19 Feb 2020 18:44:58 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:29a7:b1bb:5b40:3d61])
        by smtp.gmail.com with ESMTPSA id t23sm1005466pfq.6.2020.02.19.18.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 18:44:58 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v2 8/8] null_blk: Add support for init_hctx() fault injection
Date:   Wed, 19 Feb 2020 18:44:41 -0800
Message-Id: <20200220024441.11558-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220024441.11558-1-bvanassche@acm.org>
References: <20200220024441.11558-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This makes it possible to test the error path in blk_mq_realloc_hw_ctxs()
and also several error paths in null_blk.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jth@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index ba83fd0537ce..7fccf162b59b 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -23,6 +23,7 @@
 #ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
 static DECLARE_FAULT_ATTR(null_timeout_attr);
 static DECLARE_FAULT_ATTR(null_requeue_attr);
+static DECLARE_FAULT_ATTR(null_init_hctx_attr);
 #endif
 
 static inline u64 mb_per_tick(int mbps)
@@ -101,6 +102,9 @@ module_param_string(timeout, g_timeout_str, sizeof(g_timeout_str), 0444);
 
 static char g_requeue_str[80];
 module_param_string(requeue, g_requeue_str, sizeof(g_requeue_str), 0444);
+
+static char g_init_hctx_str[80];
+module_param_string(init_hctx, g_init_hctx_str, sizeof(g_init_hctx_str), 0444);
 #endif
 
 static int g_queue_mode = NULL_Q_MQ;
@@ -1451,6 +1455,11 @@ static int null_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
 	struct nullb *nullb = hctx->queue->queuedata;
 	struct nullb_queue *nq;
 
+#ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
+	if (g_init_hctx_str[0] && should_fail(&null_init_hctx_attr, 1))
+		return -EFAULT;
+#endif
+
 	nq = &nullb->queues[hctx_idx];
 	hctx->driver_data = nq;
 	null_init_queue(nullb, nq);
@@ -1685,6 +1694,8 @@ static bool null_setup_fault(void)
 		return false;
 	if (!__null_setup_fault(&null_requeue_attr, g_requeue_str))
 		return false;
+	if (!__null_setup_fault(&null_init_hctx_attr, g_init_hctx_str))
+		return false;
 #endif
 	return true;
 }
