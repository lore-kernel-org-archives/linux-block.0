Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86327C0015E
	for <linux-block@archiver.kernel.org>; Wed, 21 Jun 2023 20:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjFUUMs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 16:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjFUUMr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 16:12:47 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1BD19A2
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 13:12:46 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-38c35975545so4832879b6e.1
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 13:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687378366; x=1689970366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFt+Mtj8hNn59Hxzeh80ilXlkW7gARv3gmBoY2WdfPY=;
        b=NweceprDpTRrab53R4y2Jbe1wi/ESeyymtEyouEQDXwwP5YKB16LNdpTCRT7gLlS1X
         VnnBOco0RL4c4EU9/vU8aGuJXgArIRh0Z5s+LYNI1tgeh5W1MfDqerWACzpmGcXXZetY
         db70T5ILOernxxGK5sooZEVQ+JxX9+Q30JSv9eJaWmETLEcT2zNFt5Q/ZiG0nmtY1sDk
         FV8MiCpA3UJ32/t4kAQa+Mz/l+ams2DjwGivJlDc55zNFpv03nfrYQTvVKR27L1q/zkq
         TKixwuhhgeHBehHR18BEYNVuR4OLqavMANfXG1iSkbZGBr9rrzAUCUwXma/QCIyrXx9Q
         +OgA==
X-Gm-Message-State: AC+VfDzWESrUxvrTHGZNE1YKWm/o3/MwGmIAHRWFVPNUFTmavKb5kH8U
        Jv+KKpXVQi8d3reAM7u1k2I=
X-Google-Smtp-Source: ACHHUZ4EZZtntc4bKLShaZQ9KmX5/px0MvAMSlc0OSFh5hRD26lwhrO6WgfokbF+hGjVnCppY/jStQ==
X-Received: by 2002:a05:6808:601:b0:399:dd46:d561 with SMTP id y1-20020a056808060100b00399dd46d561mr7888776oih.48.1687378365697;
        Wed, 21 Jun 2023 13:12:45 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:c0b7:6a6f:751b:b854])
        by smtp.gmail.com with ESMTPSA id h8-20020a63df48000000b00548fb73874asm3522983pgj.37.2023.06.21.13.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:12:45 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v4 3/7] block: Send requeued requests to the I/O scheduler
Date:   Wed, 21 Jun 2023 13:12:30 -0700
Message-ID: <20230621201237.796902-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230621201237.796902-1-bvanassche@acm.org>
References: <20230621201237.796902-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Send requeued requests to the I/O scheduler if the dispatch order
matters such that the I/O scheduler can control the order in which
requests are dispatched.

This patch reworks commit aef1897cd36d ("blk-mq: insert rq with DONTPREP
to hctx dispatch list when requeue"). Instead of sending DONTPREP
requests to the dispatch list, send these to the I/O scheduler and
prevent that the I/O scheduler merges these requests by adding
RQF_DONTPREP to the list of flags that prevent merging
(RQF_NOMERGE_FLAGS).

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c         | 10 +++++-----
 include/linux/blk-mq.h |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f440e4aaaae3..453a90767f7a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1453,13 +1453,13 @@ static void blk_mq_requeue_work(struct work_struct *work)
 	while (!list_empty(&requeue_list)) {
 		rq = list_entry(requeue_list.next, struct request, queuelist);
 		/*
-		 * If RQF_DONTPREP ist set, the request has been started by the
-		 * driver already and might have driver-specific data allocated
-		 * already.  Insert it into the hctx dispatch list to avoid
-		 * block layer merges for the request.
+		 * Only send those RQF_DONTPREP requests to the dispatch list
+		 * that may be reordered freely. If the request order matters,
+		 * send the request to the I/O scheduler.
 		 */
 		list_del_init(&rq->queuelist);
-		if (rq->rq_flags & RQF_DONTPREP)
+		if (rq->rq_flags & RQF_DONTPREP &&
+		    !op_needs_zoned_write_locking(req_op(rq)))
 			blk_mq_request_bypass_insert(rq, 0);
 		else
 			blk_mq_insert_request(rq, BLK_MQ_INSERT_AT_HEAD);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index f401067ac03a..2610b299ec77 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -62,8 +62,8 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_RESV		((__force req_flags_t)(1 << 23))
 
 /* flags that prevent us from merging requests: */
-#define RQF_NOMERGE_FLAGS \
-	(RQF_STARTED | RQF_FLUSH_SEQ | RQF_SPECIAL_PAYLOAD)
+#define RQF_NOMERGE_FLAGS                                               \
+	(RQF_STARTED | RQF_FLUSH_SEQ | RQF_DONTPREP | RQF_SPECIAL_PAYLOAD)
 
 enum mq_rq_state {
 	MQ_RQ_IDLE		= 0,
