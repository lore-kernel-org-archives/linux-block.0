Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D21FC388F3
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 23:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4B921855
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 23:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfI3XBA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 19:01:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32839 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfI3XBA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 19:01:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so6475564pfl.0
        for <linux-block@vger.kernel.org>; Mon, 30 Sep 2019 16:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gpSLYdxnzPeYthWjSUQJp6CR8C6RA6Ja2olEfHMV4mY=;
        b=VGdjMsA9GeAeCr/RR0/lScAfvdbebg5haGYujteQajomfQ4ck9mgjGsGTWWU77YeQz
         VWdxSGni5UlKnTn+KcwCdd12YxuVerzoqbpK6nX6tfTDzuzWBRn4w/z5M8fqxKnhZB3X
         tSuLQA4zr9gGsS5YxOB3OOVrEFby0hN+1p7YdQslxLfbNrTaaa4SUj5HqUY4cjTmuais
         SiJPKrebMEXb4lyv88cvwhduVn0506EjlN0dvsUB5gotyvOGZfcRo1bED8KRQTaZSZXB
         SLWveSCbLvjzwH6iif7xYJUGIhd5FbGsyGD9NbXFZFPTI7oTAXmdpJihzpTT1f9fMbWK
         YS+A==
X-Gm-Message-State: APjAAAWu85f0WG0lViGq/B+iopNrMpMC1VMQMuQVLguXVvxhAIr83Dyq
        CC7fxfKv0pgw4gL0x3fWqnI=
X-Google-Smtp-Source: APXvYqyArtbqWoPb3Edyq3NEy42szDRtVUPcSsiNmLG+Xrog6jLVgkl+SbeST6GiNQr0rzuu2/9bPA==
X-Received: by 2002:a17:90a:fe04:: with SMTP id ck4mr1917348pjb.74.1569884459379;
        Mon, 30 Sep 2019 16:00:59 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 74sm15071747pfy.78.2019.09.30.16.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:00:58 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 3/8] block: Remove request_queue.nr_queues
Date:   Mon, 30 Sep 2019 16:00:42 -0700
Message-Id: <20190930230047.44113-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20190930230047.44113-1-bvanassche@acm.org>
References: <20190930230047.44113-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 897bb0c7f1ea ("blk-mq: Use proper cpumask iterator"; v4.6)
removed the last use of request_queue.nr_queues from outside
blk_mq_init_allocate_queue(). Remove this member variable to make
struct request_queue smaller. This patch does not change any
functionality.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c         | 6 +++---
 include/linux/blkdev.h | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 29275f5a996f..25b8a9b44a31 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2867,9 +2867,9 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	/* init q->mq_kobj and sw queues' kobjects */
 	blk_mq_sysfs_init(q);
 
-	q->nr_queues = nr_hw_queues(set);
-	q->queue_hw_ctx = kcalloc_node(q->nr_queues, sizeof(*(q->queue_hw_ctx)),
-						GFP_KERNEL, set->numa_node);
+	q->queue_hw_ctx = kcalloc_node(nr_hw_queues(set),
+				       sizeof(*(q->queue_hw_ctx)), GFP_KERNEL,
+				       set->numa_node);
 	if (!q->queue_hw_ctx)
 		goto err_sys_init;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6032bb740cf4..fe32e07c5e3c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -411,7 +411,6 @@ struct request_queue {
 
 	/* sw queues */
 	struct blk_mq_ctx __percpu	*queue_ctx;
-	unsigned int		nr_queues;
 
 	unsigned int		queue_depth;
 
-- 
2.23.0.444.g18eeb5a265-goog

