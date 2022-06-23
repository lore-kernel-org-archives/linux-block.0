Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F85CCA47C
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbiFWTB5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbiFWTBo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:01:44 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9853C60F32
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:53 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id n16-20020a17090ade9000b001ed15b37424so340502pjv.3
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xcxVFeJnoTHrDFd+Jax7HwCAg9gLuZIP6Eln3ZPSdh0=;
        b=jWmaDFuLNKshE/jPkl+0OhPLnjhyGadM3Rnn9z3Xwp5t6G+CxlN4UCh7r8EdExjQd9
         X4RTE3e5Oj9LMnvZ5CBYZB8V4my226tWUIvbLDAh/R13WR6i59BUKaqzYGnIOvBmL4hE
         j6ynLt3ZpX9qR667xhCSqsY8LqTMi40lQ/CC0G3Syw4s2e4YsGtA79dGi3YkxSuYqO7j
         YkC9ybxhHvWSs9vqsdiAHM+L8Jm6b+aB4gSFW+wDypHiUJ3GmCwCYVSD0/1xuvziXX2o
         aFvmsatCoQlN86dtYFXJf2r5FPgaCkyXu+//t5HQqUpcLjQxNRN7jSBA8SnpVXZUw+vQ
         3ZjA==
X-Gm-Message-State: AJIora+3meFycuqoWs7On3dNRCgt05xj3DHhCHiSwm/3tS5LyDcgfUDS
        6+dF86L6bVNFiL/5LC2q18Q=
X-Google-Smtp-Source: AGRyM1vQn6qOqm6hD2x7E/3UA7liRSXqRqVJcuB3C/kV2Bfk14r/1jGGBUQYRiMV9CLaLYTY212WiQ==
X-Received: by 2002:a17:90b:3557:b0:1ec:cd27:1ca9 with SMTP id lt23-20020a17090b355700b001eccd271ca9mr5155123pjb.148.1656007612328;
        Thu, 23 Jun 2022 11:06:52 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:51 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 49/51] PM: Use the enum req_op and blk_opf_t types
Date:   Thu, 23 Jun 2022 11:05:26 -0700
Message-Id: <20220623180528.3595304-50-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for
variables that represent request flags.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/power/swap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 91fffdd2c7fb..db01cac40a4c 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -269,8 +269,8 @@ static void hib_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-static int hib_submit_io(int op, int op_flags, pgoff_t page_off, void *addr,
-		struct hib_bio_batch *hb)
+static int hib_submit_io(enum req_op op, blk_opf_t op_flags,
+			 pgoff_t page_off, void *addr, struct hib_bio_batch *hb)
 {
 	struct page *page = virt_to_page(addr);
 	struct bio *bio;
