Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEE1C77B75
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 22:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjEPWdi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 18:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjEPWdf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 18:33:35 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9815FDC
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:33:34 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1aaebed5bd6so1491295ad.1
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684276414; x=1686868414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxsjF6/Njb1CBZYlUphCM+L4dP+Khele8WXLzm2lN6Q=;
        b=CanYD2rQalR1i8cFCwQde3MMawsfJkGeKjwyn0rbJESQZ01ullwM0JjSvl37qNiTxI
         1g//0vTbwOjM5vtb0RXylKxJNUqzV6ZcXY9cCpxN2RXsWRpHObNTyOb4OkswBUiEYjq8
         sI7CdPIMfLgRK1DpjSmLxfWbTqZUBIMUY/veB1urztSwVOEr0FQi0ryURIPJx4kxoxcZ
         Oh4ooiFpOSYDQKJjYRJwq07P1iCxIfTlKDrUFsBWQwLjFB6r8cNiBGlYIE2H8AMYToyo
         IFvO1cIlqcMlw81gAJCwiSKdzfO1aA+oAJTIjTw+dPbTxwR8vVqHo59hDCN6MCPbGwTi
         6vQA==
X-Gm-Message-State: AC+VfDzzd29bZiEHJDmO11/oEY8FesJVwmYp5REdXmSFpHGCx4mpEsu9
        9HK9jZz0OzGM0Eax0vGVsOo=
X-Google-Smtp-Source: ACHHUZ6IlttNXldUScllloZbVUb7cI+R/A5xHacTilsnUQXqkg0HOe26htG0vBqd8i0Uftn2vRNY5w==
X-Received: by 2002:a17:903:1c6:b0:1ac:946e:468e with SMTP id e6-20020a17090301c600b001ac946e468emr36070226plh.57.1684276414207;
        Tue, 16 May 2023 15:33:34 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:baed:ee38:35e4:f97d])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902654800b001ae48d441desm839255pln.148.2023.05.16.15.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 15:33:33 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v5 05/11] block: mq-deadline: Clean up deadline_check_fifo()
Date:   Tue, 16 May 2023 15:33:14 -0700
Message-ID: <20230516223323.1383342-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230516223323.1383342-1-bvanassche@acm.org>
References: <20230516223323.1383342-1-bvanassche@acm.org>
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
