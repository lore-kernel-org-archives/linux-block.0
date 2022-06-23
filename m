Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E547BC433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiFWTAs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiFWTAU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:00:20 -0400
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B3410CD2A
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:48 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id 184so135997pga.12
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bA0iTvq/w0HBQiKA8Q/w3tykLbU2EYtwh4o0dlv+mIk=;
        b=ntAMPuRq9VScMBhMYIm83CQKQ/cBEpNkM4OYst3FDXKxxo7ciz1zjOB0l6aC0Bs1z9
         +SpJ2/mjwYPLQPTTvCPo4rrrHNLBfGY0qdZwihYfW6kVuNx61jQwczp7OYpX2ThWLOs1
         Op9DrHGvcxs8+lMFDeB2AdV6wNZxXHnJN6JDgdJQb0Bw67pI6XAfaMD6hkLKKJ9vUiQz
         APg3aMbG4ZYUH+N9ZSaMVme+5OBJ1LHuwWeFD6d8DgYbJGckH9ujdJbgSmqaSa1Wh0jN
         dxat/jxJ0C+wIBkJx+ro7tOQNAXnMb9lMx83kWlWQSDMwQF5fomwXHfPSluGoyEbU217
         JsFw==
X-Gm-Message-State: AJIora9Jl4MVccQ0WCNYnA5iZWaTL4eXhZaumLI4weqw/1tK+QVy7jyr
        9xwvGhtmYMyQB6/Gp8F5hDo=
X-Google-Smtp-Source: AGRyM1sYK+jy8Jn1rP8Xe333+F3lqj1pz5muZZZ3yt9+37bw7PpaoSR61vmy0Cg57FFU9UYm7HXQUQ==
X-Received: by 2002:a63:7555:0:b0:40c:f8be:af36 with SMTP id f21-20020a637555000000b0040cf8beaf36mr8386766pgn.6.1656007547966;
        Thu, 23 Jun 2022 11:05:47 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:05:47 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 09/51] block/brd: Use the enum req_op type
Date:   Thu, 23 Jun 2022 11:04:46 -0700
Message-Id: <20220623180528.3595304-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
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
index c3d772bdd89f..a3dfff0f73f5 100644
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
