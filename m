Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D76C61DA4
	for <linux-block@archiver.kernel.org>; Mon, 30 Jan 2023 23:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjA3XXI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Jan 2023 18:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjA3XXH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 18:23:07 -0500
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B1B7684
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 15:23:06 -0800 (PST)
Received: by mail-pl1-f174.google.com with SMTP id k13so13366810plg.0
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 15:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p54MTDqlwADC+0KEf6cImeivCfa29snzzezJGFnDkXY=;
        b=XPZBME3iBMg4L2iyk3agGkYEQtj8lrh3UQdxUaUsAP94QzhkoNuEh//7iA9KyDha+e
         OfWYFY8sinNWxkSo0j2iH6nYKxNnWLOelhQiGqHon1/3lMXMcI3WBhxhAQzCK3G/hX/D
         aPsK5sw4joKE4CxWjqHRuBKc0H5n7ndSDHjgF/pVz6CerTjQsXEiYcEAR6t5c0ym5YdH
         Lr2uz38bF1jyMWcSJc5rKAWn4nf89xLH5JSjt0OYKTEc9HRa//6iTAVpGEl+OcZntFoz
         fQ8asn5NTxmuL9mJslswnJYdz4bB8tjhSP5mbyPmL7QjqeILH+FmY+docO+11rxY5Jf4
         h8wg==
X-Gm-Message-State: AO0yUKViLOpEgrUNr6Nfde+imavSLQ0mi8k+lOsFcVdmiSOkSlmIBgOf
        36TOsfoVPPmJ+IZpWwIN31cKn+M2G5M=
X-Google-Smtp-Source: AK7set8fM9P0k62EOM2NbpsBRVekjEoCjEWaqfzj8Q/QjhPPTXsGC651akhUlQ/jgfEGwN0wjzUkYg==
X-Received: by 2002:a05:6a20:1602:b0:be:8e8d:330c with SMTP id l2-20020a056a20160200b000be8e8d330cmr5290692pzj.27.1675120986300;
        Mon, 30 Jan 2023 15:23:06 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:5016:3bcd:59fe:334b])
        by smtp.gmail.com with ESMTPSA id t1-20020aa79461000000b0058da7e58008sm7991629pfq.36.2023.01.30.15.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 15:23:05 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] block: Revert "let blkcg_gq grab request queue's refcnt"
Date:   Mon, 30 Jan 2023 15:22:57 -0800
Message-Id: <20230130232257.972224-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since commit 0a9a25ca7843 ("block: let blkcg_gq grab request queue's
refcnt") for many request queues the reference count drops to 1 when
the request queue is destroyed instead of to 0. In other words, the
request queue is leaked. Fix this by reverting that commit.

This leak was discovered by running the following shell command before
and after the sub-page block layer tests:

cat /sys/kernel/debug/block/sub_page_limit_queues

Without this patch, the above debugfs attribute is increased by one
after each such sub-page block layer test. With this revert applied,
that debugfs attribute drops to zero after each sub-page block layer
test.

Cc: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-cgroup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index cb110fc51940..2e531268f725 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -141,7 +141,6 @@ static void blkg_free_workfn(struct work_struct *work)
 	if (q) {
 		list_del_init(&blkg->q_node);
 		mutex_unlock(&q->blkcg_mutex);
-		blk_put_queue(q);
 	}
 
 	free_percpu(blkg->iostat_cpu);
@@ -273,9 +272,6 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 	if (!blkg->iostat_cpu)
 		goto err_free;
 
-	if (!blk_get_queue(disk->queue))
-		goto err_free;
-
 	blkg->q = disk->queue;
 	INIT_LIST_HEAD(&blkg->q_node);
 	spin_lock_init(&blkg->async_bio_lock);
