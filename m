Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD896C43217
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 08:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA258610A0
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 08:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhJMJAI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 05:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238974AbhJMJAH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 05:00:07 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E2DC061570;
        Wed, 13 Oct 2021 01:58:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i12so5773581wrb.7;
        Wed, 13 Oct 2021 01:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YePs0TQf23ZBQB6LueFD/OKBXTXV+es306X2q3nmHFM=;
        b=S6Ybon6F77mV6maV+KGsWAhY8OlDL9tieNrMyqyHATfcijtEQmF4/ZzvRQffOu2rKk
         qrHqCwxeCj5+arW4mWPw2tS1LjCf+A+LZS7o7LPm9GuZlQgkXjrQXa3LZX8leqCyJNXI
         n9dHlcva0mjAGVo9svzwee7Un/4oRjjkrLTNMWoShFSTKeU5r3upS+OUChGznRmQRbEH
         4UOB2BD33n33Gw24JTXX3nZECq2SN62ZuEaM4Wx1lxE3Aa2KNAm4jZ/A2d3yePwWvYEh
         n+Pv8ZIAnnNRBmklpL/+6XzHRU+hrLjxRomuXAI6SrRUIkrCt95Z9ZHOPyGzi0dh+nfV
         p5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YePs0TQf23ZBQB6LueFD/OKBXTXV+es306X2q3nmHFM=;
        b=tDTF0h8KTw6IUgOK6jNdCaItszdSc2H5zVY8zDKW/ciSuUh085nYObjjlt8D+uwf/V
         rQEG6D8A7NdFezaqrOEAOKyp+8x3HZOpjkkqfgW1FsaLY9wyiZsbMGdgH9zMNC2YS1KS
         SCy62qMcx+3i37f+/D8d+wrbt8xRZWu4QDd+jzFuvm88Hs/w+UI9uIz+0nXmoNMULZFf
         4nskJke4JB4MonAnxC5jyqN4extOnctYCsPUGZWa0erdT/hRVGvBhr929/t/f86N5yXc
         tLmq7w9ZOfAEiVlOOO7wNl6ejp8qenIU8+k3xeywaHZeQmw/+IgB7RBUNYEpovHr7qob
         PDLQ==
X-Gm-Message-State: AOAM532KsM1smHTtkYDdPFS4lh5LkxesOQAhFJSEav9PiZ/9wtSyReCu
        GQLUVcjQuaW3yLm1tsn/05nxUcmUb6E=
X-Google-Smtp-Source: ABdhPJxU9MxUY/SU+pCF5PWFUbiXdGEU8DTeK1tK4nCwhPlAbYuU8880cPJXjxzebtbHmimNJ3vshQ==
X-Received: by 2002:a05:6000:2a3:: with SMTP id l3mr37362192wry.12.1634115483118;
        Wed, 13 Oct 2021 01:58:03 -0700 (PDT)
Received: from localhost.localdomain ([185.69.145.208])
        by smtp.gmail.com with ESMTPSA id v1sm13187283wro.54.2021.10.13.01.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 01:58:02 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>, asml.silence@gmail.com
Subject: [PATCH v2 3/3] blk-mq: optimise *end_request non-stat path
Date:   Wed, 13 Oct 2021 09:57:13 +0100
Message-Id: <e0f2ea812e93a8adcd07101212e7d7e70ca304e7.1634115360.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1634115360.git.asml.silence@gmail.com>
References: <cover.1634115360.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We already have a blk_mq_need_time_stamp() check in
__blk_mq_end_request() to get a timestamp, hide all the statistics
accounting under it. It cuts some cycles for requests that don't need
stats, and is free otherwise.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 38e6651d8b94..3dd3b22bc280 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -572,20 +572,18 @@ void blk_mq_free_plug_rqs(struct blk_plug *plug)
 
 inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 {
-	u64 now = 0;
+	if (blk_mq_need_time_stamp(rq)) {
+		u64 now = ktime_get_ns();
 
-	if (blk_mq_need_time_stamp(rq))
-		now = ktime_get_ns();
+		if (rq->rq_flags & RQF_STATS) {
+			blk_mq_poll_stats_start(rq->q);
+			blk_stat_add(rq, now);
+		}
 
-	if (rq->rq_flags & RQF_STATS) {
-		blk_mq_poll_stats_start(rq->q);
-		blk_stat_add(rq, now);
+		blk_mq_sched_completed_request(rq, now);
+		blk_account_io_done(rq, now);
 	}
 
-	blk_mq_sched_completed_request(rq, now);
-
-	blk_account_io_done(rq, now);
-
 	if (rq->end_io) {
 		rq_qos_done(rq->q, rq);
 		rq->end_io(rq, error);
-- 
2.33.0

