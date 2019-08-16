Return-Path: <SRS0=fyvH=WM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F139C3A59C
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 16:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2342086C
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 16:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfHPQVG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Aug 2019 12:21:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34506 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfHPQVG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Aug 2019 12:21:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so3191288pgc.1
        for <linux-block@vger.kernel.org>; Fri, 16 Aug 2019 09:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iTaijuYSddFs0cbKJL5Ur8AyPlZdytAmNHauPzDJ3f0=;
        b=FWe7mm0aE28jxVkWZmYKJNiOEtosCdoG+OOa7Pk91gl5TL9SB2fjYxGjcjzI1VbyPH
         xYymWqML5RWMcbOuq3s3tEmziszDnCMkLHjisF0BE2NaCM/WooJjEr6i5+ojIV4w56nC
         dbMxNWBMvuYmFUQisE4+Kpbv26rGB2zhtyUJFKSp2VlhEkWKUQZmHa46hDuAoLnNiZsQ
         5dZGmqbB0J+M6uIPVW73dkH55x8gtbzzVdMevNisADkGiAr2TCrfxF36P6E7mrC2jZaP
         9QAujkUceAC9sLPQNGVE/YUmFHF5X1QB/e4efQP+EFjCfVcBeNh7LaNFTr3GXffs6b1U
         jSDQ==
X-Gm-Message-State: APjAAAWxd1eHDgM8eXHm4dZshCGlnhnw2D6b3+YIpd5wVlEXDUwqL553
        eQ83o+yCwebLug1ysOLZlm8=
X-Google-Smtp-Source: APXvYqymhotKLLTe77qKmjU4tlbHXQUvy08SX9xbvgaTohYbSZQTAzUkSWmflb8l2vjy/3u6ih5bsw==
X-Received: by 2002:a62:7a0f:: with SMTP id v15mr11484868pfc.35.1565972465932;
        Fri, 16 Aug 2019 09:21:05 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id p20sm5853235pgj.47.2019.08.16.09.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 09:21:04 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH] block: Remove blk_mq_register_dev()
Date:   Fri, 16 Aug 2019 09:20:58 -0700
Message-Id: <20190816162058.131214-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This function has no callers. Hence remove it.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-sysfs.c   | 11 -----------
 include/linux/blk-mq.h |  1 -
 2 files changed, 12 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index d6e1a9bd7131..6ddde3774ebe 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -349,17 +349,6 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
 	return ret;
 }
 
-int blk_mq_register_dev(struct device *dev, struct request_queue *q)
-{
-	int ret;
-
-	mutex_lock(&q->sysfs_lock);
-	ret = __blk_mq_register_dev(dev, q);
-	mutex_unlock(&q->sysfs_lock);
-
-	return ret;
-}
-
 void blk_mq_sysfs_unregister(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 21cebe901ac0..62a3bb715899 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -253,7 +253,6 @@ struct request_queue *blk_mq_init_sq_queue(struct blk_mq_tag_set *set,
 						const struct blk_mq_ops *ops,
 						unsigned int queue_depth,
 						unsigned int set_flags);
-int blk_mq_register_dev(struct device *, struct request_queue *);
 void blk_mq_unregister_dev(struct device *, struct request_queue *);
 
 int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set);
-- 
2.23.0.rc1.153.gdeed80330f-goog

