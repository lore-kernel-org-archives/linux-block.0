Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EFDC77B7E
	for <linux-block@archiver.kernel.org>; Mon, 24 Apr 2023 20:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjDXUdp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 16:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbjDXUdo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 16:33:44 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB65059C3
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 13:33:40 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-63b62d2f729so4088227b3a.1
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 13:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682368420; x=1684960420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NUV6NV2cIUWphd4beZRDY/+nr6v98+rXMDkVE/hCI8=;
        b=MR19SMIvLxFeyg6A0a21md8iYGQth0bCQB5HHDsvGrDmf2oWZVBv+fDgazQYPrY87l
         tX+YU8aRFNPdATXQ/o475tW4FiC4PCv4I1+jGKuapfT48fXpcaRY+kR+MZbNfMM+UaSB
         OlTLuJZtAlwCpgWJpKjb1cgT7Fd7VfEvUlOrIiFXgQzRX3uvQjEacJ7B/MCSMmc+cv3j
         2MLE8/mS7QGE7LEFO9iKHVYXVbqEwq2R6y4guTUnF8q4hcLmJG20wI2lTSSkvgs+H8Xt
         rPcTDevIgX75L7+N0ClPxPRK+TxsPJhFzYardm2KuuklXT40u0+1DZlVE0wP91XPQLjo
         w1Vg==
X-Gm-Message-State: AAQBX9dap0hiCjTrj4WXSyCKs9zOZuolR462z0eGzMTTZajOXWf2syQt
        18xSybtgtuGCEey/R+7GSk0zoe160aw=
X-Google-Smtp-Source: AKy350b3s8pHwJFgehdY+tGCM4CQdPkK9dnYen4HbPse/bkh++AxtzDQ5puynyQxrezDkkRRiXwM8g==
X-Received: by 2002:a05:6a00:1503:b0:63b:5496:7af5 with SMTP id q3-20020a056a00150300b0063b54967af5mr22009493pfu.1.1682368420060;
        Mon, 24 Apr 2023 13:33:40 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:56cb:b39a:c8b:8c37])
        by smtp.gmail.com with ESMTPSA id k16-20020aa788d0000000b00625616f59a1sm7417505pff.73.2023.04.24.13.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 13:33:39 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 5/9] block: mq-deadline: Simplify deadline_skip_seq_writes()
Date:   Mon, 24 Apr 2023 13:33:25 -0700
Message-ID: <20230424203329.2369688-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230424203329.2369688-1-bvanassche@acm.org>
References: <20230424203329.2369688-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make the deadline_skip_seq_writes() code shorter without changing its
functionality.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index a016cafa54b3..6276afede9cd 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -304,14 +304,11 @@ static struct request *deadline_skip_seq_writes(struct deadline_data *dd,
 						struct request *rq)
 {
 	sector_t pos = blk_rq_pos(rq);
-	sector_t skipped_sectors = 0;
 
-	while (rq) {
-		if (blk_rq_pos(rq) != pos + skipped_sectors)
-			break;
-		skipped_sectors += blk_rq_sectors(rq);
+	do {
+		pos += blk_rq_sectors(rq);
 		rq = deadline_latter_request(rq);
-	}
+	} while (rq && blk_rq_pos(rq) == pos);
 
 	return rq;
 }
