Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A67C7EE25
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 22:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjECWwX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 18:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjECWwW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 18:52:22 -0400
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750D544B6
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 15:52:21 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-52079a12451so3972135a12.3
        for <linux-block@vger.kernel.org>; Wed, 03 May 2023 15:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683154341; x=1685746341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfH3fddu0PSG0m6djX24rpBRUBdl5uuwI2SQRIjlZ2k=;
        b=i94+vdDwVJriiFMmDn2SIa0No0jKKlYEZQA8nB4B0UMu0nq/7hBszO19tRgh6rhCb0
         c+37gPUGkSEAflOORscGJO0wNDDv0n1uRUeud3fhXtXelvf4giSnhN0iHSqjkttKkquO
         9hIdhNB9/dEvJrO9qstcFHBwmMdtcW5Y/ydT7vul+TJJY3KF7EvWkMHx2zrSR40Vj+jb
         2sg+FK/KPSkgjVJdkZ7jwcc3PASC/EbwXrFMzPzDoX5Mw68usbdSz/Y1yI+R1QGdUr0v
         CxCJCcFPcY1XGBUL7nDXjSJYu4npeTfWwaAXr3fBQpSH2SdR62slEOlH0jLHv82+7bZx
         INLA==
X-Gm-Message-State: AC+VfDweWsF4oKMjkf4qJ4tL51DH1BIhKp6Mb+UvawiMXneYewCrwTl8
        wKSyVeqLHV2H1eJwxto68n4=
X-Google-Smtp-Source: ACHHUZ6ep41cCH74B49KC6NocWGxqcJ8UMOwg/yNbdCQ4vFoQn6ZFD8+c3S45T78+FYZhp3WTjiupQ==
X-Received: by 2002:a17:902:d2ce:b0:1ab:b70:27a7 with SMTP id n14-20020a170902d2ce00b001ab0b7027a7mr2018755plc.19.1683154340882;
        Wed, 03 May 2023 15:52:20 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:2c3b:81e:ce21:2437])
        by smtp.gmail.com with ESMTPSA id e3-20020a170902744300b001aad4be4503sm227085plt.2.2023.05.03.15.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 15:52:20 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 06/11] block: mq-deadline: Simplify deadline_skip_seq_writes()
Date:   Wed,  3 May 2023 15:52:03 -0700
Message-ID: <20230503225208.2439206-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
In-Reply-To: <20230503225208.2439206-1-bvanassche@acm.org>
References: <20230503225208.2439206-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make the deadline_skip_seq_writes() code shorter without changing its
functionality.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
