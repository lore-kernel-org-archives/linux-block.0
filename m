Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAB8C77B6C
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 23:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjDGX7A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Apr 2023 19:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjDGX66 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Apr 2023 19:58:58 -0400
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDABEFA8
        for <linux-block@vger.kernel.org>; Fri,  7 Apr 2023 16:58:53 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id go23so2895024pjb.4
        for <linux-block@vger.kernel.org>; Fri, 07 Apr 2023 16:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680911933; x=1683503933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C86OJvzoW4rtHBJaXKlXJfoD3L6aK93cPTFYckMkAmg=;
        b=WJbevpT4pBqh9x1HJW4tYRHzIIMcxZC3MMrnDjQuvfmP9P5v7gnzl08wNlUHeGyMG/
         ZZaFdSDZI8ZoL0FQcZhH+biVSumzjBgScN3TgovPGh28J+dMEHeOJBx5cfKPhKPdXKzM
         c65RMb4RgZ1jrv4yxE4KirUUfqqjc7dhHz8a7KVkqVsZ2JI95exj2K0jwxPCofFrRQxy
         HXc0mPdiHtxFqZSnWRoqSlwMctK9aERHfdgowAoU39msQwGPOGzVgk6YC8+qOpuRtqlf
         7LI1NxxF6qOD1fFuGDizK/Ap40OtCksftR4Z3tFarUOdlIymcwoS/bPfDRES+jghYfc8
         Cf6g==
X-Gm-Message-State: AAQBX9cWuzByfa3hQNEBoshryWg5U8IlmO5syUrLGKHxSWZqXS5DnEF3
        DkMDF1ztoq7pthf8QFC0W+c=
X-Google-Smtp-Source: AKy350aV0NHYQpIKP/WX8scBC9JiBvpa0t8vZAt9Cqwx0HUJn8I9mT8o5u+Lc+PUZUCd7nTmBC+IBg==
X-Received: by 2002:a05:6a20:7a05:b0:de:808e:8f3d with SMTP id t5-20020a056a207a0500b000de808e8f3dmr2845315pzh.13.1680911933216;
        Fri, 07 Apr 2023 16:58:53 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:f2c:4ac2:6000:5900])
        by smtp.gmail.com with ESMTPSA id j16-20020a62e910000000b006258dd63a3fsm3556003pfh.56.2023.04.07.16.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 16:58:52 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v2 10/12] block: mq-deadline: Introduce a local variable
Date:   Fri,  7 Apr 2023 16:58:20 -0700
Message-Id: <20230407235822.1672286-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230407235822.1672286-1-bvanassche@acm.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
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
