Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21028C54EAA
	for <linux-block@archiver.kernel.org>; Mon, 30 Jan 2023 21:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjA3VNW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Jan 2023 16:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjA3VNV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 16:13:21 -0500
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9377947ED4
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 13:12:38 -0800 (PST)
Received: by mail-pj1-f46.google.com with SMTP id mi9so3160072pjb.4
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 13:12:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XDv83LP+qPry6iH6vx/YtSQX0aLYM4f7dX7XTBsGV/o=;
        b=MEFz1EjodXxG92maXlWaKZ2Cd9drrp1U05BcfMfeT1pyBILpnfwmwKykj/KWbPN2JK
         FdiQimuj0bbGKnzMN3fNB2eqh55SCEqWNqOUICVv1ZNjEHNvBZNXQKbYr1+KdmAxfsL+
         K4qmky91z1R3dzwID4G1xCoddf+d4rkKDSmlW0IbESklduibCBLdqHPWCtselEuf8Ofd
         f7SLhNnAON6jGp8XdUZhfv0GW3J4tPRoj2Bpx0R6h6KYY13QJtXPel69ZvUL4thfaSFA
         emeOSnhSSjyynhfQlmKIXtYeD8cijHxZV0jppHxua0lCI3lqTBPEbGikPr8GYTiLatml
         La7w==
X-Gm-Message-State: AO0yUKVH/A9BA7+ofSpP3Vg1x9O9AHYm2WLl824LjjiZZxxI/936+bj5
        dT6nmTpz7lo9O3zJhXrZ0x4=
X-Google-Smtp-Source: AK7set84W/U+7M3vOp7ee0zm8tujek1ppXN1LTzho79JBJRwT4V5ORDdAC78o+yLRWpayhr5xtDiHw==
X-Received: by 2002:a17:902:ecd2:b0:196:6903:e18f with SMTP id a18-20020a170902ecd200b001966903e18fmr11345180plh.5.1675113157945;
        Mon, 30 Jan 2023 13:12:37 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:5016:3bcd:59fe:334b])
        by smtp.gmail.com with ESMTPSA id bc7-20020a170902930700b001960283eca8sm8211831plb.94.2023.01.30.13.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 13:12:37 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH] block: Fix the blk_mq_destroy_queue() documentation
Date:   Mon, 30 Jan 2023 13:12:33 -0800
Message-Id: <20230130211233.831613-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 2b3f056f72e5 moved a blk_put_queue() call from
blk_mq_destroy_queue() into its callers. Reflect this change in the
documentation block above blk_mq_destroy_queue().

Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>
Fixes: 2b3f056f72e5 ("blk-mq: move the call to blk_put_queue out of blk_mq_destroy_queue")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9d463f7563bc..9c8dc70020bc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4069,8 +4069,9 @@ EXPORT_SYMBOL(blk_mq_init_queue);
  * blk_mq_destroy_queue - shutdown a request queue
  * @q: request queue to shutdown
  *
- * This shuts down a request queue allocated by blk_mq_init_queue() and drops
- * the initial reference.  All future requests will failed with -ENODEV.
+ * This shuts down a request queue allocated by blk_mq_init_queue(). All future
+ * requests will be failed with -ENODEV. The caller is responsible for dropping
+ * the reference from blk_mq_init_queue() by calling blk_put_queue().
  *
  * Context: can sleep
  */
