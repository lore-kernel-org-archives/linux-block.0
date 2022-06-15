Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD39C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 21:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345430AbiFOVAM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 17:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345229AbiFOVAL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 17:00:11 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A2E54FB2
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 14:00:10 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id a10so12257014pju.3
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 14:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MB0LeXi+X0nJwTOwQ1Rbe7Z7qBzrRw1Enp7KNNRIW+s=;
        b=HVO0lo25TESffyxB9Tl2BjHCiIkoJ/5HzLL5uGxR6qcpYZBLEoSxZtkXn1hQgYzfSg
         2uSC01B/anx9wb0NVViNf+7Ltupv+rkIvu1KJfYZ7vJsczdrQERYO2KXSr0RBvdAIIbf
         +2WI8EewxXAFDcv0La9h4jhgvWGZxvvg0d9EhbM+WJ0Pi0YBNHzQhJWGdLMx2Eiv0V87
         QIa7VzYMEjYV0K8tuWEtQS4yRSw0/KKqAmh4HDYlvCmhG2lYDczR7/XYeTfctiYwA+wR
         nSqZjhMH+vIHwYyGDvlWXrpbsxdWUG4GTEN9Ud442aBYSeL613XVPLkfUB0zU7Zco/r3
         8S1Q==
X-Gm-Message-State: AJIora9g6x9/wAmBexUA8miisOsyghKZ6yQHe+1udlHZYVCwby4lHKO4
        GJb8ZtT/rQES2kVPi9tOgHE=
X-Google-Smtp-Source: AGRyM1t0o2jTTQ0UJsoK/lEamJt6V3N6WY/28O96nc1YORwpu8aqIKYYHDVOd4m27zg6BchwpLwryQ==
X-Received: by 2002:a17:902:ce0c:b0:168:ca2e:c944 with SMTP id k12-20020a170902ce0c00b00168ca2ec944mr1335533plg.107.1655326810147;
        Wed, 15 Jun 2022 14:00:10 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:36ac:cabd:84b2:80f6])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b001678960e2ebsm48216pli.224.2022.06.15.14.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:00:09 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: Fix handling of offline queues in blk_mq_alloc_request_hctx()
Date:   Wed, 15 Jun 2022 14:00:04 -0700
Message-Id: <20220615210004.1031820-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch prevents that test nvme/004 triggers the following:

UBSAN: array-index-out-of-bounds in block/blk-mq.h:135:9
index 512 is out of range for type 'long unsigned int [512]'
Call Trace:
 show_stack+0x52/0x58
 dump_stack_lvl+0x49/0x5e
 dump_stack+0x10/0x12
 ubsan_epilogue+0x9/0x3b
 __ubsan_handle_out_of_bounds.cold+0x44/0x49
 blk_mq_alloc_request_hctx+0x304/0x310
 __nvme_submit_sync_cmd+0x70/0x200 [nvme_core]
 nvmf_connect_io_queue+0x23e/0x2a0 [nvme_fabrics]
 nvme_loop_connect_io_queues+0x8d/0xb0 [nvme_loop]
 nvme_loop_create_ctrl+0x58e/0x7d0 [nvme_loop]
 nvmf_create_ctrl+0x1d7/0x4d0 [nvme_fabrics]
 nvmf_dev_write+0xae/0x111 [nvme_fabrics]
 vfs_write+0x144/0x560
 ksys_write+0xb7/0x140
 __x64_sys_write+0x42/0x50
 do_syscall_64+0x35/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Fixes: 20e4d8139319 ("blk-mq: simplify queue mapping & schedule with each possisble CPU")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7a5558bbc7f6..1c09c6017ea9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -579,6 +579,8 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	if (!blk_mq_hw_queue_mapped(data.hctx))
 		goto out_queue_exit;
 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
+	if (cpu >= nr_cpu_ids)
+		goto out_queue_exit;
 	data.ctx = __blk_mq_get_ctx(q, cpu);
 
 	if (!q->elevator)
