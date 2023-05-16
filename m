Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AD2C7EE24
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 22:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjEPWdi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 18:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjEPWdh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 18:33:37 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2210D6189
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:33:36 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ab032d9266so2292405ad.0
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684276415; x=1686868415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfH3fddu0PSG0m6djX24rpBRUBdl5uuwI2SQRIjlZ2k=;
        b=Xmf5ofrIco0KKsjkG2yefYzOerQASaG47gHeGKYc8ZpAe5JeJ4jIhg3i5GAlCepUaN
         mu0T1m6ZJ7nfHSTdgHTabR030bhKwLQQZnx9ATWfgnyiCijkAEeBxJ4Gi7wC2k7lKTtA
         HELIxL14tLjHzpEFKx6ad7LEPhMmJDAuI5eDrv0pDfTAiN6iGnLYAL2xI6OJ1JyrvV5y
         CXU6gx6zMVBKTapjzTxjBVmYJchJEu++V8Bb/IFHUloYsDTPGSpl8Z2e7sq9XINuYb12
         QaDL573iocFhXcls/EYKzcrBMxUEqCMo/VANQ/omQgskO0sGlj/wBo52u1fxdyrFQiw6
         w4Hw==
X-Gm-Message-State: AC+VfDxJI4+w4LgysDJol5Ms49DpRWF+PusrZ0X9w3n3doQp6F1id685
        FYtvxL/rU01OWrS8tG3e9j0=
X-Google-Smtp-Source: ACHHUZ5QorBj7rU2QW5rUVVaQ0p2J7tzMTV6Wi/agny+qZG85hBR1Oogf9aKlW1oz4SQ58Z2VpDg1Q==
X-Received: by 2002:a17:902:da84:b0:1ac:5b6b:df4c with SMTP id j4-20020a170902da8400b001ac5b6bdf4cmr45287312plx.69.1684276415510;
        Tue, 16 May 2023 15:33:35 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:baed:ee38:35e4:f97d])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902654800b001ae48d441desm839255pln.148.2023.05.16.15.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 15:33:35 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v5 06/11] block: mq-deadline: Simplify deadline_skip_seq_writes()
Date:   Tue, 16 May 2023 15:33:15 -0700
Message-ID: <20230516223323.1383342-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230516223323.1383342-1-bvanassche@acm.org>
References: <20230516223323.1383342-1-bvanassche@acm.org>
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
