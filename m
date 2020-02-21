Return-Path: <SRS0=LczR=4J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FBFC11D24
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 03:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B5D222C4
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 03:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgBUDXG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Feb 2020 22:23:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39901 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729613AbgBUDXG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Feb 2020 22:23:06 -0500
Received: by mail-pf1-f195.google.com with SMTP id 84so461192pfy.6
        for <linux-block@vger.kernel.org>; Thu, 20 Feb 2020 19:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qS4jYuSHffNekwNAsgtk/oo8N3cmEg+YtUoGOtRuAMU=;
        b=jEkXV8MvAOZ0YdlmuqFA6iwyjutDKHB1xhiyV+1inByDfdChFbtGgvzqMRUnX+aEY4
         UfqVFu/RzB9MG016CkCnPgZ2U9kPLdhgcA+PsVDUfzVSyO98fXr7ZE5PfY36l3NAmRZe
         vSKbQvWeLHRyKpc495SiUJhVFIf/421X17+D+yHdIj9D+DkWwq9oGGqC1PCAquY/v69f
         oVSq/98vIBaNlcQDcmjKWVXGvTiQq+aQV85qiNoM279HaPqXU0I13p4BduiOtFCTpKur
         9HEkcduiJ7KO/c73+jf/o7YktIQEc1JptN/1fSgLevSiia+iusFvV3u+R7UbZahtZZ/I
         ribw==
X-Gm-Message-State: APjAAAVo0qTtlueoEkMpcKQtV12XN6z8UgFukfl0x8juWv3BDUnzda9a
        XeUHqy+lq8MnuU5bJWuwZy4=
X-Google-Smtp-Source: APXvYqx9l19nJGPcAd7686RAWYAXMOyGjKr4ciJzB9QJpKlzY3C0U/Fo7HRbf/diHQC4oLZp3Qa7/A==
X-Received: by 2002:a63:34e:: with SMTP id 75mr37628113pgd.286.1582255385244;
        Thu, 20 Feb 2020 19:23:05 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:e57a:a1b3:1a44:bb8c])
        by smtp.gmail.com with ESMTPSA id x197sm1010517pfc.1.2020.02.20.19.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 19:23:04 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v3 8/8] null_blk: Add support for init_hctx() fault injection
Date:   Thu, 20 Feb 2020 19:22:43 -0800
Message-Id: <20200221032243.9708-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221032243.9708-1-bvanassche@acm.org>
References: <20200221032243.9708-1-bvanassche@acm.org>
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
