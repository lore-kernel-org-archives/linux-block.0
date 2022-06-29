Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE80CCCA47E
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiF2XcO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbiF2XcN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:13 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ED430B
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:13 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id h9-20020a17090a648900b001ecb8596e43so995751pjj.5
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mhPIAl52SGdCw8OIB9YQLSAjw9f6OZgP6XBN+juRKMc=;
        b=uAz6iPRpSjTsKgL9ShOwSLJVtWDMfxMNDAdRNwh6OURfVF/Pxq5V1JjzzJ4WxKAi8r
         UByjQE+7UYr/2Pln9n96hXQ1FbhUy4uldxqhigDO6smkU/50WinFwjL+C+SUYk5N/nv0
         KcPZwKshbu6TchaX421ko7OnyRFP47oCXnupsl+wKcWkrx4iwcXliQ5epLkc4IvZp/eu
         9NmBJ6IjdN1dGm+8QTEIebCKAJLfSiR41q2a+lmVzJo5QWDSUeVPLw10hUvCYLr1QWN3
         GI1BpPNs76UqdgJVTJAGJ1eIZJEjBwws+losy6l5kRUCtMJBEu22Ah8KWbqvdt8J4Hn4
         o6uA==
X-Gm-Message-State: AJIora9wWXfjov4BW9rtzQqFxgUQdGw8kSbWKv2s0dgQt3wc2FwHZjbT
        Qrw+3+0LyL0o4VOe7O8E8a/x/It3T+8=
X-Google-Smtp-Source: AGRyM1vGwIutjqipmrNvjaZz3Uo7fXP9P/QNQYn50XxqS10tnG1AvOhGQdRdJQhTJtHLilsHKwMniQ==
X-Received: by 2002:a17:90a:e7c6:b0:1ee:fed1:60a4 with SMTP id kb6-20020a17090ae7c600b001eefed160a4mr8373426pjb.100.1656545532982;
        Wed, 29 Jun 2022 16:32:12 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:12 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 12/63] block/brd: Use the enum req_op type
Date:   Wed, 29 Jun 2022 16:30:54 -0700
Message-Id: <20220629233145.2779494-13-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for a
function argument that represents a request operation.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/brd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 7b82876af36e..859499cd1ff8 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -256,7 +256,7 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
  * Process a single bvec of a bio.
  */
 static int brd_do_bvec(struct brd_device *brd, struct page *page,
-			unsigned int len, unsigned int off, unsigned int op,
+			unsigned int len, unsigned int off, enum req_op op,
 			sector_t sector)
 {
 	void *mem;
