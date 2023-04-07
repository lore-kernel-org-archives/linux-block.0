Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE635C761A6
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 00:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjDGARc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 20:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbjDGAR3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 20:17:29 -0400
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115BF8A55
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 17:17:28 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso7046655pjc.1
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 17:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680826648; x=1683418648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C86OJvzoW4rtHBJaXKlXJfoD3L6aK93cPTFYckMkAmg=;
        b=4D8cYGKo6YMi9ZYQf0+4qbWThHHqb4rBa0X3LSFG11by8d+YDX4igmdTpxwj1iexdU
         IG1AVML+ihOCwzfZHiDdjphKAWId6mfQFjzvWlvPpW/Zns5nWoyx6gIc271v1/kGJlmm
         0ynj/vXyb3OkHa0xapqESr0xv2yrIksCO1sLEeruXC9ADulZOMFA147lAx8KIkYa7gIW
         AV3p6O8Qk8Ttd8+oRqCrnIc/1rp44lo5uS4tZhPivNTvptXykVb6rFpE3rrWoDKB2NEL
         U3r3ituMHuQr8ov3A48Y3rAL2qW0v/TGu2i9tcpcfgROgJh9WkTowA1fRhgWrVypYEH1
         dOaA==
X-Gm-Message-State: AAQBX9dfGCSN5V7cnFULTawQlQ99PT6uu2ZEmPyP+mbnkQ88srK4A0e5
        xemGT7AwpKMKYN3c2k56Y49fE/2UHeE=
X-Google-Smtp-Source: AKy350at2WfR1iPgMlpDsFP95FOQVOXchZtrUmK6tUHDTl4p4/trXszUDZq9aZew0Yw+B41WRE0Hng==
X-Received: by 2002:a17:903:280d:b0:1a2:8c7e:f315 with SMTP id kp13-20020a170903280d00b001a28c7ef315mr630405plb.21.1680826647688;
        Thu, 06 Apr 2023 17:17:27 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id x9-20020a1709028ec900b0019a773419a6sm1873676plo.170.2023.04.06.17.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 17:17:27 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 10/12] block: mq-deadline: Introduce a local variable
Date:   Thu,  6 Apr 2023 17:17:08 -0700
Message-Id: <20230407001710.104169-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230407001710.104169-1-bvanassche@acm.org>
References: <20230407001710.104169-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prepare for adding more code that uses the request queue pointer.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 891ee0da73ac..8c2bc9fdcf8c 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -368,6 +368,7 @@ static struct request *
 deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 		      enum dd_data_dir data_dir)
 {
+	struct request_queue *q;
 	struct request *rq;
 	unsigned long flags;
 
@@ -375,7 +376,8 @@ deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 	if (!rq)
 		return NULL;
 
-	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
+	q = rq->q;
+	if (data_dir == DD_READ || !blk_queue_is_zoned(q))
 		return rq;
 
 	/*
@@ -389,7 +391,7 @@ deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 	while (rq) {
 		if (blk_req_can_dispatch_to_zone(rq))
 			break;
-		if (blk_queue_nonrot(rq->q))
+		if (blk_queue_nonrot(q))
 			rq = deadline_latter_request(rq);
 		else
 			rq = deadline_skip_seq_writes(dd, rq);
