Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6D5C77B75
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 22:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjEPWdv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 18:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjEPWdu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 18:33:50 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6418C7292
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:33:42 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1aaea3909d1so1850175ad.2
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684276422; x=1686868422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JBGozQfRMCbQ5kzLOjh8kmaOBJhZb4ciuk6Ot10DUo=;
        b=ZgCZv7AE7ejLhWKzfiCFiaHP8TzoGcPSBdhc8RiIBIMUcRoBmCGlDmW3wnbNvp5g0G
         TwKDbBNW0XIf5uG6tcgmgJ5152LjLHG+XGq9N9F8GV2XyVh8oT1x7tYvKyTXbXrC9Ij6
         fY8+mRRjiWMsNJ9Zji2S7Z3ff7uRD/fwvEDFv16yPzrAJtFIvkiBBiVBNJXpT8Ajdw5Y
         GL62j1fPSRj+IYkiDbVds92xoUcjpVQQidS4tFx0w5GpVKI7XeXgTix2OluyY932OBaR
         fGr87PWG0Y3dcdfMNjzHrjpTiACo0Le3TQkLqq+DYPBAIA7XOpiiE2nr132BvYUM9ddN
         8t/w==
X-Gm-Message-State: AC+VfDxnsSTkd3U9+WjCrDA8scc5HvwqJuaMb/dPklN/HaBdbWnOzZM/
        JcGNCq5Fqxr9eKAVWiFLwoQTOyb44jc=
X-Google-Smtp-Source: ACHHUZ7HnHYHqLvH0JkIOA3a49YoCkFBS8sxEPeoT9ZkkpPJXPpeYt+kxt0Zion7apkfqpfVDuiTYg==
X-Received: by 2002:a17:903:234e:b0:1ac:a9c1:b61d with SMTP id c14-20020a170903234e00b001aca9c1b61dmr32287226plh.11.1684276421769;
        Tue, 16 May 2023 15:33:41 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:baed:ee38:35e4:f97d])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902654800b001ae48d441desm839255pln.148.2023.05.16.15.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 15:33:41 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v5 11/11] block: mq-deadline: Fix handling of at-head zoned writes
Date:   Tue, 16 May 2023 15:33:20 -0700
Message-ID: <20230516223323.1383342-12-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230516223323.1383342-1-bvanassche@acm.org>
References: <20230516223323.1383342-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before dispatching a zoned write from the FIFO list, check whether there
are any zoned writes in the RB-tree with a lower LBA for the same zone.
This patch ensures that zoned writes happen in order even if at_head is
set for some writes for a zone and not for others.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 059727fa4b98..67989f8d29a5 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -346,7 +346,7 @@ static struct request *
 deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 		      enum dd_data_dir data_dir)
 {
-	struct request *rq;
+	struct request *rq, *rb_rq, *next;
 	unsigned long flags;
 
 	if (list_empty(&per_prio->fifo_list[data_dir]))
@@ -364,7 +364,12 @@ deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 	 * zones and these zones are unlocked.
 	 */
 	spin_lock_irqsave(&dd->zone_lock, flags);
-	list_for_each_entry(rq, &per_prio->fifo_list[DD_WRITE], queuelist) {
+	list_for_each_entry_safe(rq, next, &per_prio->fifo_list[DD_WRITE],
+				 queuelist) {
+		/* Check whether a prior request exists for the same zone. */
+		rb_rq = deadline_from_pos(per_prio, data_dir, blk_rq_pos(rq));
+		if (rb_rq && blk_rq_pos(rb_rq) < blk_rq_pos(rq))
+			rq = rb_rq;
 		if (blk_req_can_dispatch_to_zone(rq) &&
 		    (blk_queue_nonrot(rq->q) ||
 		     !deadline_is_seq_write(dd, rq)))
