Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8BEC4332F
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 16:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9342D60F94
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 16:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhJFQhU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbhJFQhU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Oct 2021 12:37:20 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F312C061746
        for <linux-block@vger.kernel.org>; Wed,  6 Oct 2021 09:35:28 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id w10so3442786ilc.13
        for <linux-block@vger.kernel.org>; Wed, 06 Oct 2021 09:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FYcOruoZxh6lmMsi/LYojQ9n4MU9jWaK2/KXL1DOsqI=;
        b=111XAdfH/KsPkjwkYLUqSrlGtP01q7izqR1WoNm60TQQ754VyzDA2hgib9Ji4XsCM0
         gJN62jGFwdzSXgC11EC3dF+nD8qmfnsrG4tsZQWZwVcCbS2LOrJP0k5bdB+zUoDINiSQ
         sVP5UXQ9F7tkokJjBMYZg2zS4C3Dd6EYKtwdQwL1R+NTlWbFPeVACW1rwnJ9fUhSDQeL
         V4XgzOVc5siOF5kPNEtpfrnl4AOnyoSrSrzsd9Yr9L90cBXQ3WIktW5xSFxl8uuTYbiN
         y6NtrCZqb09Ze+oMQ357fn25PLplqWwQqHtPW8aK9DIHlL9DpBgjc1dSdpsB09j9wu9U
         ecBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FYcOruoZxh6lmMsi/LYojQ9n4MU9jWaK2/KXL1DOsqI=;
        b=XRPPDXbvislzpwYOvKWNMAC0umbZp2/pBCr1bO7dlMTJlLS967Akn1aSJXg8L93TjR
         IYHhqGELCJez+4Qi/YnmdxGvY0kS2l7pKvEYSQbIVllM6FeTouuN1ZpHuAdINx5lqe+Q
         SSpqasjrMtLHYujvxZZkKwdBbszUz5rrNhch8XMWIx4W6sWL1vYfv6/xegnHXEKKWcTb
         SqePCSPHcCGlEwYycSfTZ+PG4y/H3jqRwTBvh34GslBWZas1hkSOg4uaIJgCSe4foGUG
         Ulm9+gN9PpcBQPrOcnuVtsVypWyy/O3FZHJkBbJ59PZttNt8i3wB11XWX3Cwgdmhe55n
         ND2g==
X-Gm-Message-State: AOAM532nGr38fFaUVp30Ac+r9+caFcRjsS0ceAhTNvZQySx7HjlIfKuw
        bwfOL+4ecd2PJQ87c/IvUEfwxIuYnhmjoSAKJCc=
X-Google-Smtp-Source: ABdhPJxIuFMR3fGp2ArnhHHCXGGWM1H14D1LR4f7bQinlqkqtPQE8AolrNJxvOb+7Wsy8EapyEfV4g==
X-Received: by 2002:a05:6e02:de8:: with SMTP id m8mr1100729ilj.131.1633538127409;
        Wed, 06 Oct 2021 09:35:27 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n17sm1911890ile.76.2021.10.06.09.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:35:26 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] io_uring: inform block layer of how many requests we are submitting
Date:   Wed,  6 Oct 2021 10:35:22 -0600
Message-Id: <20211006163522.450882-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006163522.450882-1-axboe@kernel.dk>
References: <20211006163522.450882-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The block layer can use this knowledge to make smarter decisions on
how to handle the request, if it knows that N more may be coming. Switch
to using blk_start_plug_nr_ios() to pass in that information.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 62dc128e9b6b..c35b0f230be8 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -314,6 +314,8 @@ struct io_submit_state {
 	bool			plug_started;
 	bool			need_plug;
 
+	unsigned short		submit_nr;
+
 	/*
 	 * Batch completion logic
 	 */
@@ -7035,7 +7037,7 @@ static int io_init_req(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	 * is potentially a read/write to block based storage.
 	 */
 	if (state->need_plug && io_op_defs[req->opcode].plug) {
-		blk_start_plug(&state->plug);
+		blk_start_plug_nr_ios(&state->plug, state->submit_nr);
 		state->plug_started = true;
 		state->need_plug = false;
 	}
@@ -7150,6 +7152,7 @@ static void io_submit_state_start(struct io_submit_state *state,
 {
 	state->plug_started = false;
 	state->need_plug = max_ios > 2;
+	state->submit_nr = max_ios;
 	/* set only head, no need to init link_last in advance */
 	state->link.head = NULL;
 }
-- 
2.33.0

