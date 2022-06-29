Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCDBC43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiF2XcU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbiF2XcT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:19 -0400
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4274F30B
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:18 -0700 (PDT)
Received: by mail-pg1-f176.google.com with SMTP id z14so16821210pgh.0
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qoZeMJ3REXcYSreXu9nxiOnPcSahP/AInUfCwQA7eNA=;
        b=tz2qdR/fxQyamu9gnZvqOl6LHZMD278OUzilBnXNP2JrpnAeH96z7JBxdwqkmcybY0
         D/GyT34P+KVO3p6zX1SqE2e5XfPndaQSmwIohZBuLu3DFY94mDjO2g7DoFY8yEDQ+I7D
         +hHQP1J/4Ak0XDUJplXmhSSSijsEOSGFxfaZ5fyqICKmoNtbWqmMeYvsF3Je+KealTAF
         7drt+TIG7voXViIoEK++QT1oAa9gV1cyWsESkTD65skmU44NMs8GJ0kbqk+HKOfFPwSl
         QeYXi0dV1uy/riRIgAb7BycEQ2Z4nGo3ZIIy+HKeqdQkK35RvRFV4wH9zCJO1YO46LBY
         io0g==
X-Gm-Message-State: AJIora+A62qPWCqhX9QlfZQgi7amzCGj24L1jh579yfR3j81qLxW2wKZ
        br6/aSCHsFshvFVQ2q3QbfY=
X-Google-Smtp-Source: AGRyM1uWsXyNIHIVSKJJbxrO9yKoXGsGUSGucubciojUsdd9gDR5CTB4jH6fixl+3MxFUIY8HGhyrA==
X-Received: by 2002:a63:fe09:0:b0:40d:34e6:7c69 with SMTP id p9-20020a63fe09000000b0040d34e67c69mr4882874pgh.368.1656545537486;
        Wed, 29 Jun 2022 16:32:17 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:16 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Denis Efremov <efremov@linux.com>
Subject: [PATCH v2 15/63] block/floppy: Fix a sparse warning
Date:   Wed, 29 Jun 2022 16:30:57 -0700
Message-Id: <20220629233145.2779494-16-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since the type of request.cmd_flags has been changed from u32 into
blk_opf_t, use the __force keyword when casting to an integer type to
prevent that sparse warns about this cast.

Cc: Denis Efremov <efremov@linux.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/floppy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 491e7205a0db..ccad3d7b3ddd 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -2859,7 +2859,7 @@ static blk_status_t floppy_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (WARN(atomic_read(&usage_count) == 0,
 		 "warning: usage count=0, current_req=%p sect=%ld flags=%llx\n",
 		 current_req, (long)blk_rq_pos(current_req),
-		 (unsigned long long) current_req->cmd_flags))
+		 (__force unsigned long long) current_req->cmd_flags))
 		return BLK_STS_IOERR;
 
 	if (test_and_set_bit(0, &fdc_busy)) {
