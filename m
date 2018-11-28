Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB04EC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 13:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816182081B
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 13:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xUVl7gPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816182081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbeK2Ahe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:37:34 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40943 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbeK2Ahe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 19:37:34 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so10176651pfo.7
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 05:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GAoJSvmHfXV5b+B8mW8zPiyr53hLA3V14/V5fq2+ED4=;
        b=xUVl7gPoMfCqDpQWEhHzvgXmXmb8YEPLoRO54Rew6JmEHlqZkjNPf+FzIz9vwVaPq/
         /dPs7EloaoRfekx1c4cmyQZQHiY1R7n+GWABwDi1pCTgvSHh5t4wgE9gvL2l9pVDzZB0
         nJqAx8bCaNGqhQtI2cj5o9JsUe+KdCTIv201zNHSV2kR/Tgq1qzOirn8D+Mo+dubcmxa
         x77RvKzhg06SgSXFWBkr/8yVtQtPhuH6do65JBVpUPKxtZIaWMefluqydtmn/0Spq0fx
         e6gS/sNzaDCMexk6jOn6V+54IgWjN5fIUJEf9rXBZIw/Y1guuUF0h/RulW6hFPusNJ+q
         SozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GAoJSvmHfXV5b+B8mW8zPiyr53hLA3V14/V5fq2+ED4=;
        b=rBLCY4fzHdvKAGSncMGaMP5w9FUgYLMSwO8NL80b5SXa8NRCe5xixidhMxbLde2hYj
         FGgIJV8iWPBhfxoMPYqKY4I/whEoKoQPK4HjVG3nr28vgCHHw1I7FAQg+9az3Ri0HMKW
         kAEcsqXnyP6PIEWCc3nlODUDI1yzP3hvMAZQQF+eNqaYDlYTePBcxtz4nW2zxPvT4JsV
         +fjvF5PlX0Q0+qZAb1gM/X95NHTbHmsPrr2fpBo2IPrLv/+jx3fas7YwTDPjFnLyNCwu
         Bn2WQq9eDLGZSYTyPEEpuQEbgRnegcOQc5hs2JbbK672XWtu0McuZvLriNs/QssqYdIM
         adZw==
X-Gm-Message-State: AGRZ1gLFv+TY3TwK79u5YPZ1bAVQL1zFw/qyR4LaiO04YJVOOyVTzRyi
        PaMDxznO3oJiKLlZ5+emQT4CGpV1mY8=
X-Google-Smtp-Source: AJdET5eH0lg+JzeHzPjcGuS8yKXN9dmcNf7ZEM9NaI2zvaFBLMFEOUZU152zoIDKqfvhGHA5zIKvQw==
X-Received: by 2002:a62:b2c3:: with SMTP id z64mr37115709pfl.120.1543412152718;
        Wed, 28 Nov 2018 05:35:52 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id q75sm4744925pfa.38.2018.11.28.05.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 05:35:51 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/7] ataflop: implement mq_ops->commit_rqs() hook
Date:   Wed, 28 Nov 2018 06:35:36 -0700
Message-Id: <20181128133538.20329-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181128133538.20329-1-axboe@kernel.dk>
References: <20181128133538.20329-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We need this for blk-mq to kick things into gear, if we told it that
we had more IO coming, but then failed to deliver on that promise.

Reviewed-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ataflop.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index f88b4c26d422..a0c6745b0034 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1471,6 +1471,15 @@ static void setup_req_params( int drive )
 			ReqTrack, ReqSector, (unsigned long)ReqData ));
 }
 
+static void ataflop_commit_rqs(struct blk_mq_hw_ctx *hctx)
+{
+	spin_lock_irq(&ataflop_lock);
+	atari_disable_irq(IRQ_MFP_FDC);
+	finish_fdc();
+	atari_enable_irq(IRQ_MFP_FDC);
+	spin_unlock_irq(&ataflop_lock);
+}
+
 static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
 				     const struct blk_mq_queue_data *bd)
 {
@@ -1947,6 +1956,7 @@ static const struct block_device_operations floppy_fops = {
 
 static const struct blk_mq_ops ataflop_mq_ops = {
 	.queue_rq = ataflop_queue_rq,
+	.commit_rqs = ataflop_commit_rqs,
 };
 
 static struct kobject *floppy_find(dev_t dev, int *part, void *data)
-- 
2.17.1

