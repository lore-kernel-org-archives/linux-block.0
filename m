Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C516FC433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 17:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF816120E
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 17:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbhIVRwe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 13:52:34 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:41801 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbhIVRwe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 13:52:34 -0400
Received: by mail-pj1-f54.google.com with SMTP id pf3-20020a17090b1d8300b0019e081aa87bso2968033pjb.0
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 10:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t+TjEns5XRkvHFMYNNiHbiQpngeEs+IBTyGPaXzO3IA=;
        b=ScNZkq3jOaPuG516uufjQtlmgbOOr5AFilsDumaGN0CimN2xHy1T1cQIwEfX7+H/by
         QVdRruUpBnbkU7SNPYUd2C/qqwTnVUXVU8cKYa2YapRET/D0H9NiwPoAgiIJidxA/Url
         CBxRPXb8BpgAvae933cwbrIyQ6UoscFz6VBM34vlpnr7KPNT6OpCpZRYDwTL8sze4ntk
         jf0FuyOhI89BevFa9B6HTGpS0NV9FaxjEf666N6P/+YicEvOpOXuu1Y4ylItgNMX42Ir
         dwcxTH8s6qQ8nr+KIWK3HlQ9ze25LFIsyJQz4LZrdpP3BNBr1+tMiEmJhIC9omxpKB9t
         rftA==
X-Gm-Message-State: AOAM531NNwdrvenJ/XPmLwp/D9zCuTuE9ImacUJ9ALE8qq/AfbXz2g5x
        lowFg3QyfUv2v4lVevV+PAY=
X-Google-Smtp-Source: ABdhPJycVfnNdX3Q+xBw4Vy9Du2Kw55XT7wAoPC8Q+Dbtovahi5LaL3rEhVRy/hYDyftVUkY38qumQ==
X-Received: by 2002:a17:90a:1d0:: with SMTP id 16mr13043582pjd.53.1632333064042;
        Wed, 22 Sep 2021 10:51:04 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:f3b9:da7d:f0c0:c71c])
        by smtp.gmail.com with ESMTPSA id q18sm3062929pfh.170.2021.09.22.10.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 10:51:03 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] null_blk: Fix a NULL pointer dereference
Date:   Wed, 22 Sep 2021 10:50:55 -0700
Message-Id: <20210922175055.568763-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Skip queue mapping for shared tag sets. This patch fixes the following bug:

==================================================================
BUG: KASAN: null-ptr-deref in null_map_queues+0x131/0x1a0 [null_blk]
Read of size 8 at addr 0000000000000000 by task modprobe/4320

CPU: 9 PID: 4320 Comm: modprobe Tainted: G         E     5.15.0-rc2-dbg+ #2
Call Trace:
 show_stack+0x52/0x58
 dump_stack_lvl+0x49/0x5e
 kasan_report.cold+0x64/0xdb
 __asan_load8+0x69/0x90
 null_map_queues+0x131/0x1a0 [null_blk]
 blk_mq_update_queue_map+0x122/0x1a0
 blk_mq_alloc_tag_set+0x1e8/0x570
 null_init_tag_set+0x197/0x220 [null_blk]
 null_init+0x1dc/0x1000 [null_blk]
 do_one_initcall+0xc7/0x440
 do_init_module+0x10a/0x3d0
 load_module+0x115c/0x1220
 __do_sys_finit_module+0x124/0x1a0
 __x64_sys_finit_module+0x42/0x50
 do_syscall_64+0x35/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Fixes: 5f7acddf706c ("null_blk: poll queue support")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index eb5cfe189e90..62b7036f5e8d 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1472,13 +1472,15 @@ static int null_map_queues(struct blk_mq_tag_set *set)
 
 		switch (i) {
 		case HCTX_TYPE_DEFAULT:
-			map->nr_queues = nullb->dev->submit_queues;
+			map->nr_queues = nullb ? nullb->dev->submit_queues :
+						       g_submit_queues;
 			break;
 		case HCTX_TYPE_READ:
 			map->nr_queues = 0;
 			continue;
 		case HCTX_TYPE_POLL:
-			map->nr_queues = nullb->dev->poll_queues;
+			map->nr_queues =
+				nullb ? nullb->dev->poll_queues : g_poll_queues;
 			break;
 		}
 		map->queue_offset = qoff;
