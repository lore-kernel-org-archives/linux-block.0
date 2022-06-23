Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37919C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiFWTAv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiFWTAW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:00:22 -0400
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8720110CD36
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:51 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id l4so131899pgh.13
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gWBC5ntOBdls9NFQDjTFw6oK42LcURzDPDLiTvSvU8o=;
        b=rqk3lT8Bsfzgmmpo7nMvb2cpKVgj7X8YiTdkMJc6rq783qpWnrUt/l/HPfVQQpKtb1
         2uKDax7Rq6btclBCod9CY7l1JOgE22sh61SCYVSrlCY+148lvgucRYhuRM48pZRekuKp
         fz8jGGwkFLFdsjL/PfX8HNC+vQeZ8+J9D5AhEi/Can3QTRQpfgDpx+ll5BOZK+lywLxg
         rCHUkiSwRtkJTV3DBIltk5xA28vaH/Lga+HHFf5zx9vFJD8iKQUN5WdGJCbfClelidXk
         7OvmWs7LDhjnhs6z2Y5/xkzhN4L1o0px973rlPjElmtmgSFj+APWQYfq79zcgbhOote3
         +I2g==
X-Gm-Message-State: AJIora/OHDoiKiAyGT04mTdCJ+RkmVYetI8ZZYQGGy0yLEP9ADTim1uh
        GnaAkd7oll8QrxJc8cxbSdQVJiyCQL0=
X-Google-Smtp-Source: AGRyM1vGz/Zd+z5V1/TslPAaFO+pS8kedo7HQ2sdaX+D11u7ZchisEvKanP2oc44ekyTnjGjM7fOVw==
X-Received: by 2002:a63:564f:0:b0:40d:6ea2:6341 with SMTP id g15-20020a63564f000000b0040d6ea26341mr1668752pgm.534.1656007550916;
        Thu, 23 Jun 2022 11:05:50 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:05:50 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Denis Efremov <efremov@linux.com>
Subject: [PATCH 11/51] block/floppy: Fix a sparse warning
Date:   Thu, 23 Jun 2022 11:04:48 -0700
Message-Id: <20220623180528.3595304-12-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
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
index 015841f50f4e..2f24de4eb8da 100644
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
