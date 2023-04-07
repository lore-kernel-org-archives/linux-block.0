Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA05C76196
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 23:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjDGX7C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Apr 2023 19:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjDGX67 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Apr 2023 19:58:59 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FB2E19A
        for <linux-block@vger.kernel.org>; Fri,  7 Apr 2023 16:58:55 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id b3so66195pjq.3
        for <linux-block@vger.kernel.org>; Fri, 07 Apr 2023 16:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680911935; x=1683503935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbIDxmTUcHQIKbZyqyah2h625CSb86OBr3A1gMI1quA=;
        b=i/M8RD25xZODAXwDyDleyMmSeQImiAePwMD2QHpqq5FL8eFjGxDYMwU/twcMeOxDaH
         wLFlr9OtMdTr0aKCLkGN9+qZby6THue8Q2ObNCZvYvn7Eu6hiC/ruWIKhlCOqxDoaKOQ
         TR3gb8F9otoZRlQ0eyMF7F4m1J6YllboSPrPC8pJ5q2Ynj/fYaHKep2Yz7PhjTMjiP4i
         CWcOsYrOf80wnHfFJnVMavNpWWPf60nQMFmi0goeIyo1G3QV+x0pX+IJYvBu2UF35X37
         SVMmMLR52aF1G/RMYWXQTrNZExFr/VLPDQHLzh5EJz63NYgGCvVNkj48k1t5ILraRmsi
         zgtw==
X-Gm-Message-State: AAQBX9dIl7FiNW0clF2KIG8FgqGg4ojhSGlSzxy3O4EboYQDMHLR7KHT
        mZUpB7ppukpb/AuEh11bKFs=
X-Google-Smtp-Source: AKy350aPK5lySNkYzWg7KSJmNnEx58eN8NiUIcnr8W11aFo+gZYnVzVKjYEvHfAp6TJSz6Rh/WhUpA==
X-Received: by 2002:a05:6a20:a922:b0:d9:5db:7345 with SMTP id cd34-20020a056a20a92200b000d905db7345mr3136566pzb.26.1680911934603;
        Fri, 07 Apr 2023 16:58:54 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:f2c:4ac2:6000:5900])
        by smtp.gmail.com with ESMTPSA id j16-20020a62e910000000b006258dd63a3fsm3556003pfh.56.2023.04.07.16.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 16:58:54 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v2 11/12] block: mq-deadline: Fix a race condition related to zoned writes
Date:   Fri,  7 Apr 2023 16:58:21 -0700
Message-Id: <20230407235822.1672286-12-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230407235822.1672286-1-bvanassche@acm.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
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
 block/mq-deadline.c    | 24 +++++++++++++++++++++---
 include/linux/blk-mq.h |  5 +++++
 2 files changed, 26 insertions(+), 3 deletions(-)

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
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e62feb17af96..515dfd04d736 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1193,6 +1193,11 @@ static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
 	return !blk_req_zone_is_write_locked(rq);
 }
 #else /* CONFIG_BLK_DEV_ZONED */
+static inline unsigned int blk_rq_zone_no(struct request *rq)
+{
+	return 0;
+}
+
 static inline bool blk_req_needs_zone_write_lock(struct request *rq)
 {
 	return false;
