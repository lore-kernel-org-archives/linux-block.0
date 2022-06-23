Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0C5CCA47C
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiFWTA7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiFWTAe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:00:34 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA3DA1E10
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:55 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id a17so16856228pls.6
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=au1a8taQE5BsDHVNYY/5GNZPJ3Dny1f3djPadh9DsWk=;
        b=Vg6kvAfGTtPxZLp2gaMxfDjaKqDgB+tVwOxRWMX3/qmtsQMUEzeUuzhmmwCvZYN9EP
         XV4kqcZ3G0NRqatGtl9QQzlBd5gbcmn+vQSPrMbiORbfAdNeXS9fDM1RI7NAxmzT8Lqe
         fDdHt4YnKHaUY0PBcD/PQm59RVm8B2ZT5hYEs7Y4WBXxnz8lMXS6g8Qydr2+Qw/EqGMK
         LerARZYQ2pi1UI0VSvyyUXb1KHh+NW6BkEgf0Em+SldloLQ+SdMDxAwHo6BtUNKvGZ6q
         tMqa/vkClzlALicqGGHm+Z8Bkuvm3J/g5siCjHrgWO+njG1nYKMvp3hRYuWn9SdAYZ+D
         sHGA==
X-Gm-Message-State: AJIora9gULsqyAo+tiMaGMvdNgw6qVGDx5G6c6bTxBtUtmA4EYKe9d7X
        lA0rVS6tRYNzyw2euQhwVo8=
X-Google-Smtp-Source: AGRyM1tkSvkqZHJohnEfsyxfiPs4oGhb3Jh1qLiH02VWaFUWLkYwyeo0RpNSJ+Tvn2RZ1/edNPX+oQ==
X-Received: by 2002:a17:903:183:b0:16a:5c43:9a9c with SMTP id z3-20020a170903018300b0016a5c439a9cmr3593869plg.153.1656007554559;
        Thu, 23 Jun 2022 11:05:54 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:05:53 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [PATCH 13/51] um: Use enum req_op where appropriate
Date:   Thu, 23 Jun 2022 11:04:50 -0700
Message-Id: <20220623180528.3595304-14-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
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
index c4344b67628d..e2a0ebe4872f 100644
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
