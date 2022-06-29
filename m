Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7E6C43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbiF2Xca (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiF2Xc3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:29 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7496D329
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:25 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id w19-20020a17090a8a1300b001ec79064d8dso1019200pjn.2
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7nB/8fIrcZbusTl6uP2+f7zMnfIs2dSJzk2zUmHHCtI=;
        b=StwLISog+sPhiWuh6c4LUyzCWynXYe2TFpY9ypE0eBe3Ammm8Ls4x+YrxybqePMs9u
         mY/Aocba5ugLuYxfSgscoquF2t1MrKVsrxCsnvIXD5Rznu/yTET5FFJwzcXRRyhBjUHz
         /aM94/XPaHWvLFVdJuE3CkFEznrYwYyD57o87yJJANCwvITkYukXngWjl2Xz8FymC/v3
         Iv8mwNHXg21fS4HPo3ekedoL2xfGWGl7RKbcJsBLp7NIe90WsI/eRzeGPfuspiv1+4v7
         bJKXyfb/z0V9iOtEKm62npdhHUFP/+f+jr7sx+4HY9MNB9Ppn2DkLZ1chtVZCItkUWQV
         I7aw==
X-Gm-Message-State: AJIora9SKtrxY1oSgFENTfES2u1DvSbiGtS2YioT0fUP6yahV3wEnWnn
        AkKHNgLGa6gHXBi2a4swhJPxUE7gTZw=
X-Google-Smtp-Source: AGRyM1vbRWDgKnEU3DRsG1ZU5FcGzzQrsJYP0uePseMg2W/KnZ5UqQMu44emKUqCPQepO4i2NuMZ2A==
X-Received: by 2002:a17:902:e1c5:b0:16a:78a6:6051 with SMTP id t5-20020a170902e1c500b0016a78a66051mr11226764pla.24.1656545544908;
        Wed, 29 Jun 2022 16:32:24 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:24 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [PATCH v2 20/63] um: Use enum req_op where appropriate
Date:   Wed, 29 Jun 2022 16:31:02 -0700
Message-Id: <20220629233145.2779494-21-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using type enum req_op instead of int where
appropriate.

Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 arch/um/drivers/ubd_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 479b79e11442..eb2d2f0f0bcc 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1262,7 +1262,7 @@ static void ubd_map_req(struct ubd *dev, struct io_thread_req *io_req,
 	struct req_iterator iter;
 	int i = 0;
 	unsigned long byte_offset = io_req->offset;
-	int op = req_op(req);
+	enum req_op op = req_op(req);
 
 	if (op == REQ_OP_WRITE_ZEROES || op == REQ_OP_DISCARD) {
 		io_req->io_desc[0].buffer = NULL;
@@ -1325,7 +1325,7 @@ static int ubd_submit_request(struct ubd *dev, struct request *req)
 	int segs = 0;
 	struct io_thread_req *io_req;
 	int ret;
-	int op = req_op(req);
+	enum req_op op = req_op(req);
 
 	if (op == REQ_OP_FLUSH)
 		segs = 0;
