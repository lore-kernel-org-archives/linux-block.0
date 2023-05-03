Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BECC77B7F
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 22:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjECWwW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 18:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjECWwV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 18:52:21 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D29446AC
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 15:52:20 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-24e09b4153eso2931986a91.2
        for <linux-block@vger.kernel.org>; Wed, 03 May 2023 15:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683154340; x=1685746340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxsjF6/Njb1CBZYlUphCM+L4dP+Khele8WXLzm2lN6Q=;
        b=EX2VyxKI80sSmWSHATHdawJengxRg38dUWH1RUYlW3S399YycW+CbifTU4s06Zloxx
         CRawHzZX9LOWt4JJQFlFtqMj+vcmvFY6C9b0y7qnX3EftFQy5wAJcOmktUCUmBY3rEfq
         JN+hHPXmoZcg7KC3Xa1/FeM4QPbskZyg02HbbhvYLJ1fdarwlciEP/FnmiAx9B1MHuAN
         hHMruopvAHkODNxjbQyRNdv0F9e1awg64Z3F3Ed8sJFIWsEAdwzvfEifiQTmMKzo9sL5
         4YrftoIt7sgtiyAbAwAkNxtp9Nn4dh8Vkd1kaSvfL7HmRCAabn2imuBYfDhKodX/e9tK
         Zksw==
X-Gm-Message-State: AC+VfDzaDqDnHvYEBA6rk55JAJKYa4Nu+o520vcDIcmDpN93nhcv96zd
        wYEmHgHttWGFirBB9B73fZQ=
X-Google-Smtp-Source: ACHHUZ5cImaaOXJhRjCwPTdqOyywvv0bHZK3iaEpuoKCpCLy1n6HvgqvL1PY6DQvuxSzLtPEPzC2TA==
X-Received: by 2002:a17:90a:3e4e:b0:24d:ff53:464c with SMTP id t14-20020a17090a3e4e00b0024dff53464cmr37628pjm.49.1683154339618;
        Wed, 03 May 2023 15:52:19 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:2c3b:81e:ce21:2437])
        by smtp.gmail.com with ESMTPSA id e3-20020a170902744300b001aad4be4503sm227085plt.2.2023.05.03.15.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 15:52:19 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 05/11] block: mq-deadline: Clean up deadline_check_fifo()
Date:   Wed,  3 May 2023 15:52:02 -0700
Message-ID: <20230503225208.2439206-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
In-Reply-To: <20230503225208.2439206-1-bvanassche@acm.org>
References: <20230503225208.2439206-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Change the return type of deadline_check_fifo() from 'int' into 'bool'.
Use time_is_before_eq_jiffies() instead of time_after_eq(). No
functionality has been changed.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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
