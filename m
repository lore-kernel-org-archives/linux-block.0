Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4922EEB64DC
	for <linux-block@archiver.kernel.org>; Wed, 21 Jun 2023 20:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjFUUMx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 16:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjFUUMw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 16:12:52 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA77C199D
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 13:12:50 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-66654d019d4so4959904b3a.0
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 13:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687378370; x=1689970370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9egdE7ADXBdyCn1MfDmsbP3NYuKmHDjGrIkLbUr7D9s=;
        b=XljH4Un5jhdgjM/vcCzpYwRXQAvSOF1UibfODpf6yboEwqknJisasK1v0tJtjvFiB9
         906llOJx+o+MZ4z+lAaD/3saM20t7INvbOoxOUc8FRIWR1TCIwynyZP4rDG60GtnWL9C
         MHGJhcRotcIyHgQjZ5w6WHcVtzum7RRz4xy57rB8DUS1FvbvzcJ/H/TyJflg3iOeXzgk
         twx6EYQmcl8yb28IAlxh7fbINprLnwqqqq+d6PpxZzk43r6Gh0FIFxe050wuiKuNzvCr
         4ng/9w/tfFMip1p2Mfkm4JKVQXZBcgjyoayEL1Kho4CDYo7SCW9mM+HcOqc/aPQvbU2x
         RSRA==
X-Gm-Message-State: AC+VfDyZBmmbKHEeIogS0yf1CXkkWXBAUv3tdAaFGcn9R0hKmdInq5Gb
        eR7z8v5Y/2Gj4o+5y3YnNQU=
X-Google-Smtp-Source: ACHHUZ58VIv6oBQpGHfPwpjGWHF1tvERBQ1O8qQ5/vYjZaNgGqT1B3VswMLwPnWzNnEr+t5Rm8SaIg==
X-Received: by 2002:a05:6a20:1585:b0:122:470:377c with SMTP id h5-20020a056a20158500b001220470377cmr11764933pzj.2.1687378370050;
        Wed, 21 Jun 2023 13:12:50 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:c0b7:6a6f:751b:b854])
        by smtp.gmail.com with ESMTPSA id h8-20020a63df48000000b00548fb73874asm3522983pgj.37.2023.06.21.13.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:12:49 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com
Subject: [PATCH v4 6/7] dm: Inline __dm_mq_kick_requeue_list()
Date:   Wed, 21 Jun 2023 13:12:33 -0700
Message-ID: <20230621201237.796902-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230621201237.796902-1-bvanassche@acm.org>
References: <20230621201237.796902-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since commit 52d7f1b5c2f3 ("blk-mq: Avoid that requeueing starts stopped
queues") the function __dm_mq_kick_requeue_list() is too short to keep it
as a separate function. Hence, inline this function.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/dm-rq.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index f7e9a3632eb3..bbe1e2ea0aa4 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -168,21 +168,16 @@ static void dm_end_request(struct request *clone, blk_status_t error)
 	rq_completed(md);
 }
 
-static void __dm_mq_kick_requeue_list(struct request_queue *q, unsigned long msecs)
-{
-	blk_mq_delay_kick_requeue_list(q, msecs);
-}
-
 void dm_mq_kick_requeue_list(struct mapped_device *md)
 {
-	__dm_mq_kick_requeue_list(md->queue, 0);
+	blk_mq_kick_requeue_list(md->queue);
 }
 EXPORT_SYMBOL(dm_mq_kick_requeue_list);
 
 static void dm_mq_delay_requeue_request(struct request *rq, unsigned long msecs)
 {
 	blk_mq_requeue_request(rq, false);
-	__dm_mq_kick_requeue_list(rq->q, msecs);
+	blk_mq_delay_kick_requeue_list(rq->q, msecs);
 }
 
 static void dm_requeue_original_request(struct dm_rq_target_io *tio, bool delay_requeue)
