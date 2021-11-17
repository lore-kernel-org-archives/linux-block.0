Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC24C4332F
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 03:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2BB561545
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 03:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhKQDlL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Nov 2021 22:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhKQDlK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Nov 2021 22:41:10 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8913FC061746
        for <linux-block@vger.kernel.org>; Tue, 16 Nov 2021 19:38:12 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id e144so1329402iof.3
        for <linux-block@vger.kernel.org>; Tue, 16 Nov 2021 19:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4G4Mjbe7lIxc74U3KrDv4l8eTOrTW6gu4gjlLQHEK0k=;
        b=svSwfhjyuJgA0GF2D87eQFGI5pFplJPSMvBTs/0mfTeYw4kcKixtMfAbV6jkqytx2v
         cuJEfJvMmFAT0XvF6tZfVGgR0OGXIUrAAjHhmb6/qNHGCIC+VvHWAT81VivB8T23MZxi
         iwUAujSuaWgvxSJaduwFUqo/IC5vrUDtoFfS939AlQTIIb0AvWPp2E8eDIOgDgJwaB1o
         zGuBwkXH6emCIhjAzsKmjpy41S7LuUez7+uX4bge+QTf8o1embOyHlcg241newWd0cGu
         znDOxjw/OEweSyzj6t1qW3MD4AGF9MfqYVz2hhGPncI/Uzu5N6oiX9oWc2Q/FUEbANo7
         GjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4G4Mjbe7lIxc74U3KrDv4l8eTOrTW6gu4gjlLQHEK0k=;
        b=Mj0AbdK193fa/605yRKpi8xIC220PHRj7wGpE1tf4+Gc3DGevcfN++2T85Mm2Dp2UL
         8shWZlmOJrpL6+LhBCsXpsxv5yVCaXawLQ7n5oJm68etivrsEd6brXhzeGdWyyYKHgPE
         Gg1ogiej7kNuRAIq+cIVzpJFEv8vp+J80hGzAZLiMe0MSKtWaKxad4Ox57J1CntCja3i
         T+c26UYUQwg/sUDtAtcaQMcxI9VlBkox4ixg+nBt5xWJ2meZYutt55ZPoQnF5zrQ4aK3
         Wzp0djfNGuDhUEMujy90JHNcLxuTZaifKoN3AcLNWnd0i5jZDE0ZGCBaKjPOMk5z6bsP
         nFgQ==
X-Gm-Message-State: AOAM532NQ5UwBA17olM4eCJ39gCq3SFrl1KLU6EE3xcu6LnMZTeW1NDb
        2xXqWsQDvsmUm2EPYUe88bcgEEVGCMZlcnfl
X-Google-Smtp-Source: ABdhPJyTr1DRMagYOjMA2OQv6txRKgU6H9uQM+mP9atjqXqq3LW6IIRd8jh8hlmCpGBOJ2eYkqftNQ==
X-Received: by 2002:a05:6638:3899:: with SMTP id b25mr10321264jav.39.1637120291851;
        Tue, 16 Nov 2021 19:38:11 -0800 (PST)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id l13sm12563693ios.49.2021.11.16.19.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 19:38:11 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@infradead.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/4] nvme: split command copy into a helper
Date:   Tue, 16 Nov 2021 20:38:05 -0700
Message-Id: <20211117033807.185715-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211117033807.185715-1-axboe@kernel.dk>
References: <20211117033807.185715-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We'll need it for batched submit as well.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/pci.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c89f74ea00d4..c33cd1177b37 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -501,6 +501,15 @@ static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
 	nvmeq->last_sq_tail = nvmeq->sq_tail;
 }
 
+static inline void nvme_copy_cmd(struct nvme_queue *nvmeq,
+				 struct nvme_command *cmd)
+{
+	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes), cmd,
+		sizeof(*cmd));
+	if (++nvmeq->sq_tail == nvmeq->q_depth)
+		nvmeq->sq_tail = 0;
+}
+
 /**
  * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
  * @nvmeq: The queue to use
@@ -511,10 +520,7 @@ static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
 			    bool write_sq)
 {
 	spin_lock(&nvmeq->sq_lock);
-	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
-	       cmd, sizeof(*cmd));
-	if (++nvmeq->sq_tail == nvmeq->q_depth)
-		nvmeq->sq_tail = 0;
+	nvme_copy_cmd(nvmeq, cmd);
 	nvme_write_sq_db(nvmeq, write_sq);
 	spin_unlock(&nvmeq->sq_lock);
 }
-- 
2.33.1

