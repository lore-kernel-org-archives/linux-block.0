Return-Path: <SRS0=LczR=4J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98BEC11D24
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 03:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8ED720716
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 03:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgBUDW5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Feb 2020 22:22:57 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35682 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729280AbgBUDW5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Feb 2020 22:22:57 -0500
Received: by mail-pf1-f195.google.com with SMTP id i19so474538pfa.2
        for <linux-block@vger.kernel.org>; Thu, 20 Feb 2020 19:22:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7kDp2bhQ0TbfGMdY7FiTn31W51zSy2a+MMBLD+uJRe8=;
        b=gTNty4IbLxqYuCg/4VAciNYAa7bnzvFWRlk9R1wwiBioRbz7Pjzr7C7TkVaS/PlNaZ
         xUPf99Khx7jIXKosDD9OsnPaKnDoaH+t2/McKyRaUhMS6aepSSxvHuBF2onqYNsWs4mM
         y3kbvc6aK/pmcYTsbxS+boIswNSCAvnwZTtHWsoxlkd2Lnx2KqX4UQYFyoTNxXWh6Wln
         vwqu/SUL8Cv7aa+24Fq2hts+dId+5m3CqAv71oVJwlFAeVfBej0rrX8wZBubQyr2+QJ9
         dx8plHuyt7htbpUeBoAC2Gt90tQYfC8EBg2h3Z91y4L1guIGPy6jeHnn+Q7jFC/3U1Q5
         GWmA==
X-Gm-Message-State: APjAAAXX3+Vjickx//gCTw0PaPoW6FJiFlFstkOCz37p8zeCOUgBmF+t
        f5YBvh0Oc8n4nY4/93RWEBs=
X-Google-Smtp-Source: APXvYqyQZDQza1rrtdWhhZQ+c2Ex+kwqTRBDAO2NydVSsauAA+IX/O5GYXLUtLVStHdcUbPKsXrc5Q==
X-Received: by 2002:a62:1594:: with SMTP id 142mr35071510pfv.18.1582255376297;
        Thu, 20 Feb 2020 19:22:56 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:e57a:a1b3:1a44:bb8c])
        by smtp.gmail.com with ESMTPSA id x197sm1010517pfc.1.2020.02.20.19.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 19:22:55 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        syzbot+d44e1b26ce5c3e77458d@syzkaller.appspotmail.com
Subject: [PATCH v3 2/8] blk-mq: Keep set->nr_hw_queues and set->map[].nr_queues in sync
Date:   Thu, 20 Feb 2020 19:22:37 -0800
Message-Id: <20200221032243.9708-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221032243.9708-1-bvanassche@acm.org>
References: <20200221032243.9708-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_map_queues() and multiple .map_queues() implementations expect that
set->map[HCTX_TYPE_DEFAULT].nr_queues is set to the number of hardware
queues. Hence set .nr_queues before calling these functions. This patch
fixes the following kernel warning:

WARNING: CPU: 0 PID: 2501 at include/linux/cpumask.h:137
Call Trace:
 blk_mq_run_hw_queue+0x19d/0x350 block/blk-mq.c:1508
 blk_mq_run_hw_queues+0x112/0x1a0 block/blk-mq.c:1525
 blk_mq_requeue_work+0x502/0x780 block/blk-mq.c:775
 process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
 worker_thread+0x98/0xe40 kernel/workqueue.c:2415
 kthread+0x361/0x430 kernel/kthread.c:255

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jth@kernel.org>
Reported-by: syzbot+d44e1b26ce5c3e77458d@syzkaller.appspotmail.com
Fixes: ed76e329d74a ("blk-mq: abstract out queue map") # v5.0
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f298500e6dda..a92444c077bc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3023,6 +3023,14 @@ static int blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 
 static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 {
+	/*
+	 * blk_mq_map_queues() and multiple .map_queues() implementations
+	 * expect that set->map[HCTX_TYPE_DEFAULT].nr_queues is set to the
+	 * number of hardware queues.
+	 */
+	if (set->nr_maps == 1)
+		set->map[HCTX_TYPE_DEFAULT].nr_queues = set->nr_hw_queues;
+
 	if (set->ops->map_queues && !is_kdump_kernel()) {
 		int i;
 
