Return-Path: <SRS0=ZA/H=42=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA51AC18E5A
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 21:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8175D24649
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 21:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Wq9d+aIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgCIVmT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:42:19 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38982 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgCIVmS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Mar 2020 17:42:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id m13so13796684edb.6
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2020 14:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k2f3o78q0ZcV57lXckmVVvL2UXXP2J4/4eKg0byCatE=;
        b=Wq9d+aIcXs5pFMdG0URKQVfGtzNbzq3MHzRtIs2Y5vG9lIBdPI8YMa68iW3Z4JLHkY
         rcdHf/YE9UWobNY17VMLryazG23Lj/yiJjWEC8x9aiYhT8i7BonNAMrjQZRW7bHiGwL5
         TFnx7bZLHMQyh7H/uXVW3qz/BfaUfInbbCJjq6yCm8RUDx0rnLoFo1NLu/0VVXAJ+Hh+
         vs0TgmdEg8CTB26XfF2n76d9Iok9z0X8ZzOJbuHMm61ETzgUEpfbLLmR7RHrkTrIqA7z
         e9ie8XSdq5CE2G/ARRymRq4O02FxGJm94fpY2tVrdzoLDy+kXLum8FODwDYgTJkdOOyT
         iCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k2f3o78q0ZcV57lXckmVVvL2UXXP2J4/4eKg0byCatE=;
        b=oQFpmGcYx7BlqalKtfj2UybsacWZ5ELQr8McOeCrwSNCI4nCNExNHq4Ugis/mPKjuv
         hQKOi1iwmhYxqylqa6JN9aQjnI8J/jQd63Z+un3BXYUI36TEc3jxoTLkLTOEwfDQRQ+3
         8t7ZIAroP47ShQtalpwDFGCqRjY0dcAZUN0X5dJEaeS/qUxnJZv4bwJ6ywVrUKt7wmzn
         BpOpYKS6pZ/+JUYlhB+6WiJrNMhyFrbKGrWGKk2XhN1O2dUt1MlD4V2Caw+KmmgnfFQv
         /aeQq/l6jInEbjjaFat26MzXpSYkTgcQy2Jd/FIcal3zMrG0Q55apSqLRVU6J3ymttVh
         B/5w==
X-Gm-Message-State: ANhLgQ0YfXemwLouSDtgMmV83bpO0ybDdgZBTskTw4O5nam05ZzEB9yp
        IEdUeqSRuQLalteGPcWuPOHosaF2fauapg==
X-Google-Smtp-Source: ADFU+vtxJM+Z6E56JJoIPrBaODjGCF0KNzm2nJXeCrfr1dkBUNJUDl3BgXfi2WboD4R896Pp2rqHMg==
X-Received: by 2002:a50:fd89:: with SMTP id o9mr19543167edt.179.1583790136737;
        Mon, 09 Mar 2020 14:42:16 -0700 (PDT)
Received: from nb01257.fritz.box ([2001:16b8:4824:700:55b0:6e1e:26ab:27a5])
        by smtp.gmail.com with ESMTPSA id g6sm3828488edm.29.2020.03.09.14.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:42:16 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V2 6/6] block: cleanup comment for blk_flush_complete_seq
Date:   Mon,  9 Mar 2020 22:41:38 +0100
Message-Id: <20200309214138.30770-7-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309214138.30770-1-guoqing.jiang@cloud.ionos.com>
References: <20200309214138.30770-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove the comment about return value, since it is not valid after
commit 404b8f5a03d84 ("block: cleanup kick/queued handling").

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-flush.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 7f7f98305115..843d25683691 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -160,9 +160,6 @@ static void blk_account_io_flush(struct request *rq)
  *
  * CONTEXT:
  * spin_lock_irq(fq->mq_flush_lock)
- *
- * RETURNS:
- * %true if requests were added to the dispatch queue, %false otherwise.
  */
 static void blk_flush_complete_seq(struct request *rq,
 				   struct blk_flush_queue *fq,
-- 
2.17.1

