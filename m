Return-Path: <SRS0=GlWt=UD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06AFC282CE
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 18:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A9820717
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 18:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfFDSRq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jun 2019 14:17:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46741 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfFDSRp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jun 2019 14:17:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id v9so10797881pgr.13
        for <linux-block@vger.kernel.org>; Tue, 04 Jun 2019 11:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jk614OW+toouchtfiZ5Ct4yS0gtaRdK4sjfv9OBX/2A=;
        b=GgByGt39sceRXhmxInTHp9ttkdF5OuJaFrLSViP9v6+cwaMH2Z7WuVLGo5ZpeYdD/b
         601btaUnAoDlwc4ZsENJfhGGOMsl9kHKZSXLs2nL49xQsXs52PLhyBfm7HnkHN0Jo9Ua
         d9wZe1nnhRcByzTV0VhYOYqDKCdaUNF7Ejzu3k/rG578yMx5voGk8abRGmJg+U3lNoLQ
         5Pzly/EI9GeEIs2z8UZeqrRuTW/SkZxeZ7GtkMDb2qVj22b/EmRZulIFhePL0vw8FGHB
         6pLZMTVTHd7eSrkj06ecw/7MZVUNZ2higECAnu9Nx7rWfjHAMoFAotIaK3a9BUs5p6lv
         ICSw==
X-Gm-Message-State: APjAAAVNcoAd+dRaeUMPXwK50Q1q00znbuX7aerYPsQcXsudlg947s0t
        Tf/nBdSy//67IC7oLIMYNGoh+nfU
X-Google-Smtp-Source: APXvYqzR3K+z+btow0iiD9tMHgoE00W75mPkb4PB1dCHKtMP5Wdg83UJG1zuhjfIG2h46hvLZBxZGQ==
X-Received: by 2002:aa7:956d:: with SMTP id x13mr613619pfq.132.1559672265167;
        Tue, 04 Jun 2019 11:17:45 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id q19sm18318709pff.96.2019.06.04.11.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 11:17:44 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>, Omar Sandoval <osandov@fb.com>
Subject: [PATCH 2/2] blk-mq: Simplify blk_mq_make_request()
Date:   Tue,  4 Jun 2019 11:17:36 -0700
Message-Id: <20190604181736.903-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190604181736.903-1-bvanassche@acm.org>
References: <20190604181736.903-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move the blk_mq_bio_to_request() call in front of the if-statement.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Omar Sandoval <osandov@fb.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 00d572265aa3..8dd4a5cccf9a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1969,10 +1969,10 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 	cookie = request_to_qc_t(data.hctx, rq);
 
+	blk_mq_bio_to_request(rq, bio);
+
 	plug = current->plug;
 	if (unlikely(is_flush_fua)) {
-		blk_mq_bio_to_request(rq, bio);
-
 		/* bypass scheduler for flush rq */
 		blk_insert_flush(rq);
 		blk_mq_run_hw_queue(data.hctx, true);
@@ -1984,8 +1984,6 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		unsigned int request_count = plug->rq_count;
 		struct request *last = NULL;
 
-		blk_mq_bio_to_request(rq, bio);
-
 		if (!request_count)
 			trace_block_plug(q);
 		else
@@ -1999,8 +1997,6 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 		blk_add_rq_to_plug(plug, rq);
 	} else if (plug && !blk_queue_nomerges(q)) {
-		blk_mq_bio_to_request(rq, bio);
-
 		/*
 		 * We do limited plugging. If the bio can be merged, do that.
 		 * Otherwise the existing request in the plug list will be
@@ -2025,10 +2021,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		}
 	} else if ((q->nr_hw_queues > 1 && is_sync) || (!q->elevator &&
 			!data.hctx->dispatch_busy)) {
-		blk_mq_bio_to_request(rq, bio);
 		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
 	} else {
-		blk_mq_bio_to_request(rq, bio);
 		blk_mq_sched_insert_request(rq, false, true, true);
 	}
 
-- 
2.22.0.rc3

