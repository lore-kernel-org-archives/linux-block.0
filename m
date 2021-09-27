Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2067C433FE
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF0C161058
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbhI0WFa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:05:30 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:43971 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237679AbhI0WFQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:05:16 -0400
Received: by mail-pg1-f173.google.com with SMTP id r2so19091484pgl.10
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 15:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5RYatZdhHmmiXuvRblXQ2liBvHEQiDy1GXtopaG/uwU=;
        b=I6z2gHVC4qUFv8DCYXEMHBW6BxPvhyfIrBlNco/eAF+lew3TbWvQRYBI1qUwOR+oTn
         Jjdn34G0KF5ILNJ+YgqI+zGCpzIaEkhIQGG4JLnBGy7O3QrHAQcRqfHMO2nSqLEelCgS
         HPf4fvGyEVKVvyQl9PUNIh2p1xW8AkJsxWxgrj0PmtnWNnqdsMAzpg/YWkJ+THcTw+vC
         8PNXII8skPtRJqC5/rTjF/Y+Q/lWF7+wVpIcRpC0SGTthD9wcfphPhhHAhD1gveZ7axb
         hfnlr2xrQpFqknLSJUL/OxjwpzvOHMMc6+zKvRbOXPg6xL8T2dt3BUS46maxjXF+iGZQ
         3a2A==
X-Gm-Message-State: AOAM532Qj1M+34V9NM4R6sqVgIEXHdmoBLygsnC7dRkgzg6s5pNs3H5f
        Gtyxpv1fv0HkwphA3xJZGQ0=
X-Google-Smtp-Source: ABdhPJyhRO+/cJi7TqqV1F/mZSXDlmvZnlxjPEcIpfjD4XFBy1G+DgAg6Q87x40jtzq10dL50QispA==
X-Received: by 2002:a65:44c4:: with SMTP id g4mr1621296pgs.254.1632780217366;
        Mon, 27 Sep 2021 15:03:37 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3e98:6842:383d:b5b2])
        by smtp.gmail.com with ESMTPSA id y13sm381587pjm.5.2021.09.27.15.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 15:03:36 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 1/4] block/mq-deadline: Improve request accounting further
Date:   Mon, 27 Sep 2021 15:03:25 -0700
Message-Id: <20210927220328.1410161-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210927220328.1410161-1-bvanassche@acm.org>
References: <20210927220328.1410161-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The scheduler .insert_requests() callback is called when a request is
queued for the first time and also when it is requeued. Only count a
request the first time it is queued. Additionally, since the mq-deadline
scheduler only performs zone locking for requests that have been
inserted, skip the zone unlock code for requests that have not been
inserted into the mq-deadline scheduler.

Fixes: 38ba64d12d4c ("block/mq-deadline: Track I/O statistics")
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 47f042fa6a68..c27b4347ca91 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -677,8 +677,10 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	blk_req_zone_write_unlock(rq);
 
 	prio = ioprio_class_to_prio[ioprio_class];
-	dd_count(dd, inserted, prio);
-	rq->elv.priv[0] = (void *)(uintptr_t)1;
+	if (!rq->elv.priv[0]) {
+		dd_count(dd, inserted, prio);
+		rq->elv.priv[0] = (void *)(uintptr_t)1;
+	}
 
 	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
 		blk_mq_free_requests(&free);
@@ -759,12 +761,13 @@ static void dd_finish_request(struct request *rq)
 
 	/*
 	 * The block layer core may call dd_finish_request() without having
-	 * called dd_insert_requests(). Hence only update statistics for
-	 * requests for which dd_insert_requests() has been called. See also
-	 * blk_mq_request_bypass_insert().
+	 * called dd_insert_requests(). Skip requests that bypassed I/O
+	 * scheduling. See also blk_mq_request_bypass_insert().
 	 */
-	if (rq->elv.priv[0])
-		dd_count(dd, completed, prio);
+	if (!rq->elv.priv[0])
+		return;
+
+	dd_count(dd, completed, prio);
 
 	if (blk_queue_is_zoned(q)) {
 		unsigned long flags;
