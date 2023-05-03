Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C373DC77B7F
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 22:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjECWwZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 18:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjECWwZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 18:52:25 -0400
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176A046AF
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 15:52:24 -0700 (PDT)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-52c6f81193cso796218a12.1
        for <linux-block@vger.kernel.org>; Wed, 03 May 2023 15:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683154343; x=1685746343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXOZdpON9fcUZX+Q+tAMBs/sq3fFefmRkNQlWrkWjyg=;
        b=fDt6OXalAarxfPw99lsguIKkoC4G0etm9I1ODY3qCVE9y0Zy2whTD2G/mHZTWRoU28
         nHDPcJfUw1Ty5+h1YgBV0duXuRk4GfpV41U4hD/ctI2z1LNOMSQJt9ZoMnZiTyIjE2cR
         z84xnmVb/im8OBDYU+E6OHGYnNE1lUEClC9/2q4rhNnLk55NMNGWvq4gxCjDhuT2EDqA
         AElRRINmWFTICnSg+0QYrDl2iai6igDg7B8mBWo9WyMzkD5Z9BvuB/w4KuvVeLIr37nn
         MHubtDVVy08ZzXUrsm5S8uwrw4ZIgfKOInWLtqJLeDJ/5zym8Kb2VPBoHnhGZKEmaMcl
         lA+Q==
X-Gm-Message-State: AC+VfDziUbRgT+h1ehWJC+7sLy+ZWQh/UHsvcm9W3EepSzLhYA0fEVCj
        Q+fZ5ede+vSCbDnWMwteXb4=
X-Google-Smtp-Source: ACHHUZ7BtgyxcP2XT+4Uqhw0HXHwWLmfLwxjJMr7gNSWTt7ydoQQkQtGIEvmhJmHBfnPTpkvuD93jg==
X-Received: by 2002:a17:902:f545:b0:1a6:ff51:270 with SMTP id h5-20020a170902f54500b001a6ff510270mr1806329plf.29.1683154343427;
        Wed, 03 May 2023 15:52:23 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:2c3b:81e:ce21:2437])
        by smtp.gmail.com with ESMTPSA id e3-20020a170902744300b001aad4be4503sm227085plt.2.2023.05.03.15.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 15:52:22 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 08/11] block: mq-deadline: Reduce lock contention
Date:   Wed,  3 May 2023 15:52:05 -0700
Message-ID: <20230503225208.2439206-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
In-Reply-To: <20230503225208.2439206-1-bvanassche@acm.org>
References: <20230503225208.2439206-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_free_requests() calls dd_finish_request() indirectly. Prevent
nested locking of dd->lock and dd->zone_lock by unlocking dd->lock
before calling blk_mq_free_requests().

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index dbc0feca963e..56cc29953e15 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -758,6 +758,7 @@ static bool dd_bio_merge(struct request_queue *q, struct bio *bio,
  */
 static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 			      blk_insert_t flags)
+	__must_hold(dd->lock)
 {
 	struct request_queue *q = hctx->queue;
 	struct deadline_data *dd = q->elevator->elevator_data;
@@ -784,7 +785,9 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	}
 
 	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
+		spin_unlock(&dd->lock);
 		blk_mq_free_requests(&free);
+		spin_lock(&dd->lock);
 		return;
 	}
 
