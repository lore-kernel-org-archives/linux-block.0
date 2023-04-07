Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884B9C761A6
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 00:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbjDGARh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 20:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbjDGARf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 20:17:35 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC87EA5CB
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 17:17:30 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id q2so2775163pll.7
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 17:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680826650; x=1683418650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CFIH6DPkGWqv6H5U0GnqrQGslXoWOV64uSysltami8=;
        b=yVn9H/Ogr2aeMAnh0XMZLXqkGeWB9VJTVjFVXHQGHxIUyXdHmMzIZovrl6N0omP25L
         ntxJJGMOIcjufXebH9uWI3FFl1kj/RtzOTJJk69AgTbfm8O/vQ/S7kXGP8vxhJHIk0i5
         v3h5puP5DzZW3h0mqhkaJjAY/Ic9x29/Spy9uKiHCFMNqpKYPUqXrHH2bmJY2AEkG7R4
         /4FmwNK96bm+FGG/rdxJU8URkIsJTU5Us7oRlDntqQf3QwI/jIA5MoklnYPM0aBK1M7R
         mVbpahEQmO9maoqY6EAXe66FpR4udWTfCbLJribFTjsGIW5Wq1Pbc6aW63Ii2u9Lr79d
         c5gA==
X-Gm-Message-State: AAQBX9dINy2/atNx4EIg2Ha+ocsd/FXNX2bxLakkugzXeB00gXAX2A4q
        9jnxJYyuyiUn8FKYd8INJxM=
X-Google-Smtp-Source: AKy350aXlZpPqEsiDzbkChI9U78MvnndkfXEDs5uKM0iU7cAahrr51N9YhNomPYuDSJ+z55ZvtvJmQ==
X-Received: by 2002:a17:902:ea0d:b0:1a1:f06b:f171 with SMTP id s13-20020a170902ea0d00b001a1f06bf171mr1078582plg.17.1680826649620;
        Thu, 06 Apr 2023 17:17:29 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id x9-20020a1709028ec900b0019a773419a6sm1873676plo.170.2023.04.06.17.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 17:17:28 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 11/12] block: mq-deadline: Fix a race condition related to zoned writes
Date:   Thu,  6 Apr 2023 17:17:09 -0700
Message-Id: <20230407001710.104169-12-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230407001710.104169-1-bvanassche@acm.org>
References: <20230407001710.104169-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Let deadline_next_request() only consider the first zoned write per
zone. This patch fixes a race condition between deadline_next_request()
and completion of zoned writes.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 8c2bc9fdcf8c..d49e20d3011d 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -389,12 +389,30 @@ deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 	 */
 	spin_lock_irqsave(&dd->zone_lock, flags);
 	while (rq) {
+		unsigned int zno = blk_rq_zone_no(rq);
+
 		if (blk_req_can_dispatch_to_zone(rq))
 			break;
-		if (blk_queue_nonrot(q))
-			rq = deadline_latter_request(rq);
-		else
+
+		WARN_ON_ONCE(!blk_queue_is_zoned(q));
+
+		if (!blk_queue_nonrot(q)) {
 			rq = deadline_skip_seq_writes(dd, rq);
+			if (!rq)
+				break;
+			rq = deadline_earlier_request(rq);
+			if (WARN_ON_ONCE(!rq))
+				break;
+		}
+
+		/*
+		 * Skip all other write requests for the zone with zone number
+		 * 'zno'. This prevents that this function selects a zoned write
+		 * that is not the first write for a given zone.
+		 */
+		while ((rq = deadline_latter_request(rq)) &&
+		       blk_rq_zone_no(rq) == zno)
+			;
 	}
 	spin_unlock_irqrestore(&dd->zone_lock, flags);
 
