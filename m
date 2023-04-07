Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224D4C76196
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 23:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjDGX65 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Apr 2023 19:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjDGX64 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Apr 2023 19:58:56 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE71EF91
        for <linux-block@vger.kernel.org>; Fri,  7 Apr 2023 16:58:52 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id 20so1997995plk.10
        for <linux-block@vger.kernel.org>; Fri, 07 Apr 2023 16:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680911932; x=1683503932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0rraQvI0NSDkdGimavbgcqDUTGPiPZaZulhFDWUQ2I=;
        b=oGWzCclDT1Zl3t8BEFiswzGfZT4lMhknImLq5hljXOoiazCe1YyItguzeoKID2yzrP
         u9NODBj8NtMGjkjhAWYwg/3vXjhGxEkPidB/HnS6ZPPIJog6LaNvg1poGFlRECKOWdRp
         KAJ7giG4WWiUdS9m8hpwDllvwS8qtrM3VYjGsgcTzwiTpqI0eJe3aPdOrHPyxBLLGkmO
         2zmhdPMgItKXCCKmRqegTlONA9pW2wj26a4MFpObRTdVVewq1PNBFYRqhWOEUOnhgVJK
         dvrP6wOwfPZUt8T09QKYN08XAfMRRuAmHbdH9PwJ/zaitK5N1MZwCEOVw5bJFDeS7cz7
         aZCQ==
X-Gm-Message-State: AAQBX9f+auZgDop2RfYDU4952fAytaaH71EJ6HZRmP88DPUrXviitEbx
        dKphupxwTMyz8TQ3uDStGg6h8CyryTs=
X-Google-Smtp-Source: AKy350aGhAV/pPaPxd1I+mcFyMprRDgupv3iGB9oyM4RKTFpfR/ikLF9/yUpNpUiG9Vjr4Ox/cHPsQ==
X-Received: by 2002:a05:6a20:3b1a:b0:cc:ac05:88f7 with SMTP id c26-20020a056a203b1a00b000ccac0588f7mr142592pzh.34.1680911931996;
        Fri, 07 Apr 2023 16:58:51 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:f2c:4ac2:6000:5900])
        by smtp.gmail.com with ESMTPSA id j16-20020a62e910000000b006258dd63a3fsm3556003pfh.56.2023.04.07.16.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 16:58:51 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v2 09/12] block: mq-deadline: Disable head insertion for zoned writes
Date:   Fri,  7 Apr 2023 16:58:19 -0700
Message-Id: <20230407235822.1672286-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230407235822.1672286-1-bvanassche@acm.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make sure that zoned writes are submitted in LBA order.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 50a9d3b0a291..891ee0da73ac 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -798,7 +798,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	trace_block_rq_insert(rq);
 
-	if (at_head) {
+	if (at_head && !blk_rq_is_seq_zoned_write(rq)) {
 		list_add(&rq->queuelist, &per_prio->dispatch);
 		rq->fifo_time = jiffies;
 	} else {
