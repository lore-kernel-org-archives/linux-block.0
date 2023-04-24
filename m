Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A5FC77B7F
	for <linux-block@archiver.kernel.org>; Mon, 24 Apr 2023 20:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjDXUdp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 16:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjDXUdo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 16:33:44 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505DC5B93
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 13:33:39 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-63b60366047so4053258b3a.1
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 13:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682368419; x=1684960419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WF3r3QrptKfudquaNkr3Z1ryI3uc5dg0gMZZjctB2Lw=;
        b=fyWtG6G+izvvvh7vlM7ImSaiEFhV/YannypjFeTR3NPnc+9ltqA4mqgfvLRbmU12wB
         hK25VihxSR43kB6CXgJeP6500Z1dbm7oqaA3fBX7Q/iuihe8AueBQATCis2f4YdO8ibN
         SbL2T+t60gbjulQ1xIIekPRS3LF1JyHgYNLIs+bcKO+B5+okcy2SYFup5bW85HfKDQqw
         Jk5G5y2fIDMrGsGm97BTzU3VHEq/Xy8TizJgJzs54ZKX4yo9LjqEn/R6lQobxmo3a8Ph
         daVhqZjbHSiOAw+ZfnjOIkP/iX9mKejdFDrxkhi8fPl6aXoxTdT7XJ1UgmbOmd61pWq1
         MdiQ==
X-Gm-Message-State: AAQBX9eI6arRVnflHzw+bcX58q+EvhErPxzui+x6rVCC9pcBKpDktK8E
        dmc9/IDqHlhgUAfjgDoDh7g=
X-Google-Smtp-Source: AKy350b+Sr5xvOzebrB+2yXysTKe2PJbmMwalYWJuBuxadmHJisDl3kPlZ4wOoNmbQfu3yNcA47qyQ==
X-Received: by 2002:a05:6a20:734e:b0:ef:e240:b559 with SMTP id v14-20020a056a20734e00b000efe240b559mr21393452pzc.46.1682368418786;
        Mon, 24 Apr 2023 13:33:38 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:56cb:b39a:c8b:8c37])
        by smtp.gmail.com with ESMTPSA id k16-20020aa788d0000000b00625616f59a1sm7417505pff.73.2023.04.24.13.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 13:33:38 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 4/9] block: mq-deadline: Clean up deadline_check_fifo()
Date:   Mon, 24 Apr 2023 13:33:24 -0700
Message-ID: <20230424203329.2369688-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230424203329.2369688-1-bvanassche@acm.org>
References: <20230424203329.2369688-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Change the return type of deadline_check_fifo() from 'int' into 'bool'.
Use time_is_before_eq_jiffies() instead of time_after_eq(). No
functionality has been changed.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 5839a027e0f0..a016cafa54b3 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -272,21 +272,15 @@ static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
 }
 
 /*
- * deadline_check_fifo returns 0 if there are no expired requests on the fifo,
- * 1 otherwise. Requires !list_empty(&dd->fifo_list[data_dir])
+ * deadline_check_fifo returns true if and only if there are expired requests
+ * in the FIFO list. Requires !list_empty(&dd->fifo_list[data_dir]).
  */
-static inline int deadline_check_fifo(struct dd_per_prio *per_prio,
-				      enum dd_data_dir data_dir)
+static inline bool deadline_check_fifo(struct dd_per_prio *per_prio,
+				       enum dd_data_dir data_dir)
 {
 	struct request *rq = rq_entry_fifo(per_prio->fifo_list[data_dir].next);
 
-	/*
-	 * rq is expired!
-	 */
-	if (time_after_eq(jiffies, (unsigned long)rq->fifo_time))
-		return 1;
-
-	return 0;
+	return time_is_before_eq_jiffies((unsigned long)rq->fifo_time);
 }
 
 /*
