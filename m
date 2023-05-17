Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50C6C7EE2E
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 17:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjEQRpi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 13:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjEQRpe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 13:45:34 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283CC1FE6
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 10:45:05 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6436e004954so1095818b3a.0
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 10:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684345471; x=1686937471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5JRbS3GKyvmHNAncqIZ0qk+UzhMY/Qxetj+preyd2A=;
        b=RPSAGyrhPsE8qxZjxXl7tjzsTJndse2SvV9FbR5iQh49iJDo9MsmJlWMSw4uNqsyYy
         0PMHwfUYdZjhMN91hmhojoH5oVFNU9bzBnRQ6y48VSBOrixMgs+bVNHe513MKH7e1JSL
         HfXFtouSvFOnuuXASRAi/dOivw8ODEYAi3UjwzjDAWsR7Dd/wo+4YlNIc1SXdL5BN8QC
         t/ns16Iq71m7M7dEuvEaxyAb9sVQ2pX23XY2KkO3PlVi6QJWxrP+gJvI+0fxtLxRek7r
         zR6VjS0P20sm4hvMOZmJSh1UsNrHYqposcqzf//swRlWG72rUIp2O5nna3O8MK3GXqs4
         +JdA==
X-Gm-Message-State: AC+VfDwzOwf7/G0BmExjOSwhTC6+ZcigGD91lkEIycpL61GYw1B4/HWf
        0xIZYqC5+cGOjKtYoZwvTJw=
X-Google-Smtp-Source: ACHHUZ4J7NjylBaTKfLrDwxq+PCWQ/k9r9FNhKaNg3NYIXpXsuRYxz3Lsh5QT7FhNfGJ3+TLC+gM/Q==
X-Received: by 2002:a05:6a00:14c9:b0:646:2edb:a23 with SMTP id w9-20020a056a0014c900b006462edb0a23mr750469pfu.1.1684345470982;
        Wed, 17 May 2023 10:44:30 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id d22-20020aa78e56000000b00646e7d2b5a7sm15334410pfr.112.2023.05.17.10.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:44:30 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Omar Sandoval <osandov@fb.com>
Subject: [PATCH v6 01/11] block: mq-deadline: Add a word in a source code comment
Date:   Wed, 17 May 2023 10:42:19 -0700
Message-ID: <20230517174230.897144-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230517174230.897144-1-bvanassche@acm.org>
References: <20230517174230.897144-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add the missing word "and".

Cc: Damien Le Moal <dlemoal@kernel.org>
Suggested-by: Damien Le Moal <dlemoal@kernel.org>
Fixes: 945ffb60c11d ("mq-deadline: add blk-mq adaptation of the deadline IO scheduler")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 5839a027e0f0..cea1b084c69e 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -443,7 +443,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	 */
 	rq = deadline_next_request(dd, per_prio, dd->last_dir);
 	if (rq && dd->batching < dd->fifo_batch)
-		/* we have a next request are still entitled to batch */
+		/* we have a next request and are still entitled to batch */
 		goto dispatch_request;
 
 	/*
