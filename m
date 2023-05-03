Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8088AC77B7F
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 22:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjECWwd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 18:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjECWwa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 18:52:30 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87BB4681
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 15:52:27 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ab0c697c84so21593915ad.3
        for <linux-block@vger.kernel.org>; Wed, 03 May 2023 15:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683154347; x=1685746347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GH2YcvGFrV6xS6Volz3QhBy2NN3NfkIJiHY8Dki6J5w=;
        b=bEJEEnnEoQtFTgcmEj16m3C8MamIRYO2FrNGh9gtl+DIIV383jIqVRyjIaYGAQr5KL
         uBdjuXfyEuIQYAn1x7mmc7RjdWfdPp0Eg8w0DHOpvrclI4n7HK5kPfXWV+MIi1BfTRV/
         ArTccwujUBfPf7efwhQXXjKeT+OmDhMzzZrX5N/T3bUqUSRv51oIXtUV0DZxmYCX83SC
         pT4iO96V8ZSnYhtEF021bVF5gTMgfbrPRHhvijBC9JCwpmDtgxcPiAmDGsY1XTbO9Ki7
         op0GbcgHym92bFrbHzF9shbQ9sTyeWSCVmZEoCZYkECzKegwuFfFQXgdrBqC5tIo9Fof
         KjhA==
X-Gm-Message-State: AC+VfDw4gb7MvPzBVb1GJTcqXeDY8E+EdIOUGatEJheaRQbscLcxEcqG
        h3RlwqeZhmS5Ux8l1DBR3NI=
X-Google-Smtp-Source: ACHHUZ4w8gM90haQL1WxJO/1QsrERtae2OIepc68EWulhSbKFY7y1qv+rPFvcy8QlJ/mLtN518Y3Yw==
X-Received: by 2002:a17:902:ce88:b0:1ac:2c8b:a0da with SMTP id f8-20020a170902ce8800b001ac2c8ba0damr9657plg.51.1683154347329;
        Wed, 03 May 2023 15:52:27 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:2c3b:81e:ce21:2437])
        by smtp.gmail.com with ESMTPSA id e3-20020a170902744300b001aad4be4503sm227085plt.2.2023.05.03.15.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 15:52:27 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 11/11] block: mq-deadline: Fix handling of at-head zoned writes
Date:   Wed,  3 May 2023 15:52:08 -0700
Message-ID: <20230503225208.2439206-12-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
In-Reply-To: <20230503225208.2439206-1-bvanassche@acm.org>
References: <20230503225208.2439206-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before dispatching a zoned write from the FIFO list, check whether there
are any zoned writes in the RB-tree with a lower LBA for the same zone.
This patch ensures that zoned writes happen in order even if at_head is
set for some writes for a zone and not for others.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 6c196182f86c..e556a6dd6616 100644
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
