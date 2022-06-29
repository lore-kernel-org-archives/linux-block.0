Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B14C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiF2XcK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiF2XcJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:09 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F94D31F
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:09 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id q18so15447034pld.13
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AOKxTsLwvynSw4s524r/Q8ZrPZw7Y5LNj6Ex7MwS88Y=;
        b=O5jKm5rKPTqZ4mMBj30b9JSm1XMdEDq201IL56MMsJHmMM0U9EW1TKuisbN4Dg2WhJ
         QcDlbhlWqvkiDWWaOWroANQbJcFurBP/vM5KYmzh2uEiLXbcyblFwG6iG5LJUKaJp/Iu
         uv0Icn3ay6tAn0W5RaEoiGOrywmhyGUSBzs4IIRpiEBuNguTc1ULv1p/f3Do40ygYJC7
         iBO91UlGEFEXM8amyDxskGSd5z9cxyI+6W6A68L8McEhm/LVT5/7LGwwVr/KP45y4evQ
         1HUbpFH3D4h60vKWFqauXgjvRkkO+BEIRZlNpfbaqBnFdATbLoK0+fVrfqRG47XsmVyJ
         EwYA==
X-Gm-Message-State: AJIora8q9Pj4P5oHm3rrhcq6/ZGk9O/+WmaK2UhR0fy2EA7pAdsp/Oq2
        6+eiASGcjOsdGB2TTsmL6keSLgFacfo=
X-Google-Smtp-Source: AGRyM1vcJvbvxfZHsaKKEiQ5ZBGb6jGzbwWNZF5eQ8QscmLbYzkh2EYwUI+UGDc7YQHfQ5XaNSSY4A==
X-Received: by 2002:a17:90a:2d82:b0:1eb:6ee0:9d68 with SMTP id p2-20020a17090a2d8200b001eb6ee09d68mr8335867pjd.28.1656545528491;
        Wed, 29 Jun 2022 16:32:08 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:07 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Omar Sandoval <osandov@fb.com>
Subject: [PATCH v2 09/63] block/kyber: Use the new blk_opf_t type
Date:   Wed, 29 Jun 2022 16:30:51 -0700
Message-Id: <20220629233145.2779494-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the new blk_opf_t type for arguments that represent a bitwise
combination of a request operation and request flags.

This patch does not change any functionality.

Cc: Omar Sandoval <osandov@fb.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/kyber-iosched.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 8f7c745b4a57..102b6a311b5c 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -195,9 +195,9 @@ struct kyber_hctx_data {
 static int kyber_domain_wake(wait_queue_entry_t *wait, unsigned mode, int flags,
 			     void *key);
 
-static unsigned int kyber_sched_domain(unsigned int op)
+static unsigned int kyber_sched_domain(blk_opf_t opf)
 {
-	switch (op & REQ_OP_MASK) {
+	switch (opf & REQ_OP_MASK) {
 	case REQ_OP_READ:
 		return KYBER_READ;
 	case REQ_OP_WRITE:
@@ -553,7 +553,7 @@ static void rq_clear_domain_token(struct kyber_queue_data *kqd,
 	}
 }
 
-static void kyber_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
+static void kyber_limit_depth(blk_opf_t op, struct blk_mq_alloc_data *data)
 {
 	/*
 	 * We use the scheduler tags as per-hardware queue queueing tokens.
