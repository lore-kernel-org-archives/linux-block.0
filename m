Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54218C43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbiGNSHy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240097AbiGNSHx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:07:53 -0400
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A7C68704
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:51 -0700 (PDT)
Received: by mail-pg1-f175.google.com with SMTP id f11so2269379pgj.7
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dmUIPna0/jC9cy+H3EkBekQPpvLc3tuIsTlojuMdyjc=;
        b=3VZxQFA/l0aGuajlAPasdmsPv/9/nzOQRVx7iorN1vTGr3gwiFE0oc9Fecl1aEVnQ4
         Gw+FM2g5+s2MQODMTiKOpNWzdVwXYHDr6APfdsMnjuntj178RF9+2uZbIUZPCGi2634S
         8CnarPu65CAueqLARoYNebEMITuvvXyxakdmqBIpGhjDVFz5kWj29ce2zC5ToHnq3eXN
         5MX2GLQPyYs5/ztLWDtpQnUkNiAJKOqDWN7A1ZRPXWdi+DbiPJ+y7rwob6juHydxkI15
         PMu09+CZ6QdhUJhZV4lyMZjSTFAbKV6MyMt0CkW5xlGxgOdXkWlkvnJ9mlEQjpRNvw8D
         WGcQ==
X-Gm-Message-State: AJIora82c/9rE7S5X5S0xWL4Tb5GlKrZWpNzXhhjJ4kGrgZ5LH29+Q3L
        nqm8KHS4EbcKfonqs3V26Mo=
X-Google-Smtp-Source: AGRyM1t01sHbhfn6x+76vzkQs1az0MGzYZ+AvxxuZUf5bjZw4IrXBAo/0xBAMBqQV9xd2F3bcfcITg==
X-Received: by 2002:a63:1220:0:b0:411:f661:f819 with SMTP id h32-20020a631220000000b00411f661f819mr8772464pgl.250.1657822070489;
        Thu, 14 Jul 2022 11:07:50 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:07:49 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Omar Sandoval <osandov@fb.com>
Subject: [PATCH v3 09/63] block/kyber: Use the new blk_opf_t type
Date:   Thu, 14 Jul 2022 11:06:35 -0700
Message-Id: <20220714180729.1065367-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the new blk_opf_t type for arguments that represent a bitwise
combination of a request operation and request flags. Rename those
arguments from 'op' into 'opf'.

This patch does not change any functionality.

Cc: Omar Sandoval <osandov@fb.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/kyber-iosched.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 8f7c745b4a57..b05357bced99 100644
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
@@ -553,13 +553,13 @@ static void rq_clear_domain_token(struct kyber_queue_data *kqd,
 	}
 }
 
-static void kyber_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
+static void kyber_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 {
 	/*
 	 * We use the scheduler tags as per-hardware queue queueing tokens.
 	 * Async requests can be limited at this stage.
 	 */
-	if (!op_is_sync(op)) {
+	if (!op_is_sync(opf)) {
 		struct kyber_queue_data *kqd = data->q->elevator->elevator_data;
 
 		data->shallow_depth = kqd->async_depth;
