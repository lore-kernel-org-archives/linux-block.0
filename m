Return-Path: <SRS0=Dd+4=PL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E710C43387
	for <linux-block@archiver.kernel.org>; Thu,  3 Jan 2019 01:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E867920833
	for <linux-block@archiver.kernel.org>; Thu,  3 Jan 2019 01:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfACBUI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jan 2019 20:20:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfACBUI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Jan 2019 20:20:08 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8020D2D1ED1;
        Thu,  3 Jan 2019 01:20:07 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 182B21992A;
        Thu,  3 Jan 2019 01:19:59 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Anatoly Pugachev <matorola@gmail.com>,
        David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH] block: sunvdc: don't run hw queue synchronously from irq context
Date:   Thu,  3 Jan 2019 09:19:48 +0800
Message-Id: <20190103011948.25706-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 03 Jan 2019 01:20:08 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

vdc_blk_queue_start() may be called from irq context, so we can't run
queue via blk_mq_start_hw_queues() since we never allow to run queue
from irq context. Use blk_mq_start_stopped_hw_queues(q, true) to fix
this issue.

Fixes: fa182a1fa97dff56cd ("sunvdc: convert to blk-mq")
Reported-by: Anatoly Pugachev <matorola@gmail.com>
Tested-by: Anatoly Pugachev <matorola@gmail.com>
Cc: Anatoly Pugachev <matorola@gmail.com>
Cc: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/sunvdc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 9c0553dd13e7..ab7f7ab4c472 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -181,7 +181,7 @@ static void vdc_blk_queue_start(struct vdc_port *port)
 	 * allocated a disk.
 	 */
 	if (port->disk && vdc_tx_dring_avail(dr) * 100 / VDC_TX_RING_SIZE >= 50)
-		blk_mq_start_hw_queues(port->disk->queue);
+		blk_mq_start_stopped_hw_queues(port->disk->queue, true);
 }
 
 static void vdc_finish(struct vio_driver_state *vio, int err, int waiting_for)
-- 
2.9.5

