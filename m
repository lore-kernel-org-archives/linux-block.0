Return-Path: <SRS0=5EYj=43=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1D9C10F27
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 04:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838CE24655
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 04:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgCJE0p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Mar 2020 00:26:45 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54714 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgCJE0o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Mar 2020 00:26:44 -0400
Received: by mail-pj1-f65.google.com with SMTP id np16so849221pjb.4
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2020 21:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8mTOjj/SAPVGUe6HsUeMd9PBV5Q14D6oy8rjmuu96T8=;
        b=N6wmZP1ClHWjHb8a63AMo1TWJrbjlotwlnv87Omiip4rEFjL7mddt27MVUxcnSKldO
         l3IoyhTe5Xsb30Woyqw6WqMWanm2PGcxeHVYWNZvYENt4XJPeS0adPFk+8y9vBXE574S
         oej9rtc3OgK4cF6cn5wUA7FetgYDpGVFfZnaJ3LdV4T2ZFc6+hLTOF5huqEqkOc0pBe9
         lIaz9eKBXY+EhPNOmoktCyFN9aC2u+AzD9U3dvW1q5RBJNxZfqRAeHneyvqobZRESiFg
         N7sWEAPSgRetadn4nwKniqcFjbTGJt1tI30Ay7/J+qOh8o1XtnC27QdatUgDlmThixT9
         Qi9Q==
X-Gm-Message-State: ANhLgQ3em6c2Od6iAIbOg5mK2KK4bMv5w0Ur8SriENy4L597OYHSp38e
        vkcvVHz8NhBITZp4v54rv1U=
X-Google-Smtp-Source: ADFU+vtOe+zvlv5jiM8Xatbz5keHItbgLxJSNPRZOa+O1984+6zFpheb0cBtA//qnoNtiW4U0Gz8sg==
X-Received: by 2002:a17:90a:22a9:: with SMTP id s38mr619747pjc.3.1583814403591;
        Mon, 09 Mar 2020 21:26:43 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:c0e4:71da:7a83:2357])
        by smtp.gmail.com with ESMTPSA id l189sm5963240pga.64.2020.03.09.21.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 21:26:42 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v4 8/8] null_blk: Add support for init_hctx() fault injection
Date:   Mon,  9 Mar 2020 21:26:23 -0700
Message-Id: <20200310042623.20779-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310042623.20779-1-bvanassche@acm.org>
References: <20200310042623.20779-1-bvanassche@acm.org>
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
index d21c82c8863f..89bb16a99007 100644
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
@@ -1683,6 +1692,8 @@ static bool null_setup_fault(void)
 		return false;
 	if (!__null_setup_fault(&null_requeue_attr, g_requeue_str))
 		return false;
+	if (!__null_setup_fault(&null_init_hctx_attr, g_init_hctx_str))
+		return false;
 #endif
 	return true;
 }
