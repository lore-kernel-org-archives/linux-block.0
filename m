Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F964CCA47C
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbiGNSHv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240080AbiGNSHt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:07:49 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4349A58842
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:49 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id f65so2249956pgc.12
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lRSkOmLtP1PZfxuoZXl0bXBxZro8DSt7xY6PLErKQjI=;
        b=48jvY77kun1wbiRAY8mUk716uSOMR7mMsKvdKqGIbvHjs6uKM1Efj/+QJyKTGoqcxE
         puFF709SQRHh4zrUCaOjd89tuo7W6bFqthTmyAPfQew5sLiWWWmo5N0fvsnRyf6rZ51A
         0/ZpAPz0k2tnQCX/v4cBuJHW1rzVQh4fwx6lABjhepXkPSfu/S/SB5LCWIz+ZOoKjEe9
         EuTDA/XPvwHvrv74LNOEFXwv31ydhhVz2ASAwe7sk7Oi9BcBaPzHQoeZTtIf+uD0GpPP
         ID9pz2jSxAQVFrJiueemE2l3/rxIJXGlZXPWVPEQD/GuVvY6y4BXUU7fl2vqELfNM+qZ
         HWvQ==
X-Gm-Message-State: AJIora9jeeXaTKo9+y8SpMlq6TPTorRUX4JCrGLmWi6lJOOcXggNlcxO
        I3jB7D4mf4Ds5twHRBMWBm8=
X-Google-Smtp-Source: AGRyM1vDYc+G1dR6QLFwbBewzdz9tfltwu+6WzEtwd5fKE/Nj9XS1g6N+siLpByZZR3eWN5M/qcAWw==
X-Received: by 2002:a63:5a44:0:b0:412:7bee:d757 with SMTP id k4-20020a635a44000000b004127beed757mr8829602pgm.419.1657822068670;
        Thu, 14 Jul 2022 11:07:48 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:07:48 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v3 08/63] block/mq-deadline: Use the new blk_opf_t type
Date:   Thu, 14 Jul 2022 11:06:34 -0700
Message-Id: <20220714180729.1065367-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the new blk_opf_t type for an argument that represents a bitwise
combination of a request operation and request flags. Rename that
argument from 'op' into 'opf'.

This patch does not change any functionality.

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 1a9e835e816c..5639921dfa92 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -543,12 +543,12 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
  * Called by __blk_mq_alloc_request(). The shallow_depth value set by this
  * function is used by __blk_mq_get_tag().
  */
-static void dd_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
+static void dd_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 {
 	struct deadline_data *dd = data->q->elevator->elevator_data;
 
 	/* Do not throttle synchronous reads. */
-	if (op_is_sync(op) && !op_is_write(op))
+	if (op_is_sync(opf) && !op_is_write(opf))
 		return;
 
 	/*
