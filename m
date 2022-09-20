Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184E6C54EE9
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 20:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiITUGp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Sep 2022 16:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiITUGo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 16:06:44 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E780D61B06
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 13:06:43 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id y11so4232022pjv.4
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 13:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=CaqaeO5MCXNuEWlgARIW075CAureE9iUPJqZulgTzUw=;
        b=EQU+9wS6BzcttRefRQp4SVAxMXSUhIdlGKzS+evHG+dYx0JGV0SCShfRbXN0+0sMQr
         oG+3GrQvKO9vwvKYndhtkFafthB1AXzEbsuUa0yUIETLErai75xaMrSXPrP2e+Qjp711
         BHNbV2hhACsEp17QfaLAeCyJmjRx+cKAStnOQE5u2o1POgZCM3lB7XUhT3EwcileX9zf
         i8+AfbsxYO33yFuBwHqWxjXMzH2HDtuLefNa/98R2WO7WQc2hiB/t1pfhQ+JQ/iQHRX6
         TWNaoRGpqlXowL8m9wWyfrWPuGJc83PuZNm6jSkonRPlmGGTBjcj91TAhh26ZYxUj1E4
         pdpw==
X-Gm-Message-State: ACrzQf2m6bYUgmwYo0JfuZ+r67LOCp03qTjYq+A+Z2Oo8SWj6xiLf0yB
        3Aejn5vkpsA6jlKoXQRY1N8=
X-Google-Smtp-Source: AMsMyM5ezYrCNWvz2XX2Z2L9WjtM6MiUA2jlTS98Irww3RHZF7nvOrNxPFEIPbs8a2qOHKb3MioQ7w==
X-Received: by 2002:a17:903:2284:b0:178:349b:d21b with SMTP id b4-20020a170903228400b00178349bd21bmr1228074plh.49.1663704403294;
        Tue, 20 Sep 2022 13:06:43 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:e9e9:677b:9685:6b7d])
        by smtp.gmail.com with ESMTPSA id e16-20020a056a0000d000b0053b208b55d1sm312209pfj.85.2022.09.20.13.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 13:06:42 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH] block: Fix the enum blk_eh_timer_return documentation
Date:   Tue, 20 Sep 2022 13:06:26 -0700
Message-Id: <20220920200626.3422296-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The documentation of the blk_eh_timer_return enumeration values does not
reflect correctly how e.g. the SCSI core uses these values. Fix the
documentation.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Fixes: 88b0cfad2888 ("block: document the blk_eh_timer_return values")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blk-mq.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 92294a5fb083..1532cd07a597 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -268,9 +268,16 @@ static inline void rq_list_move(struct request **src, struct request **dst,
 	rq_list_add(dst, rq);
 }
 
+/**
+ * enum blk_eh_timer_return - How the timeout handler should proceed
+ * @BLK_EH_DONE: The block driver completed the command or will complete it at
+ *	a later time.
+ * @BLK_EH_RESET_TIMER: Reset the request timer and continue waiting for the
+ *	request to complete.
+ */
 enum blk_eh_timer_return {
-	BLK_EH_DONE,		/* drivers has completed the command */
-	BLK_EH_RESET_TIMER,	/* reset timer and try again */
+	BLK_EH_DONE,
+	BLK_EH_RESET_TIMER,
 };
 
 #define BLK_TAG_ALLOC_FIFO 0 /* allocate starting from 0 */
