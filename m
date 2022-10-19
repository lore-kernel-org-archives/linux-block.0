Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5626C433FE
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 22:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJSWXo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 18:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiJSWXn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 18:23:43 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C822B17653E
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 15:23:42 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id h14so1569598pjv.4
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 15:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yL10cP6154JCU7pQS5gRGa+et2/upUIU6Cb/rzZjRh8=;
        b=FdYzA5gxYhcmQu5mxk6IEkYKGHcmj6uRk2YUkSvAytjjz9HcpgtGcJ8UnSAFdoCLYA
         iHjq1JfKXgVgn4SGqN5UYLgcVeC5gK9+t4uhuF7sYcQxORljS7kO6fv/maxbM3+1BrO5
         R1DQybhyRopUVs1LGK+WNstNEe/wlGwiDEcOgWY4yNLwIYzIbVsBhYtX+uU9p8Qd/2AB
         SVbBnVsLCqXgk+lVu8tKHug39C6FyIkEe/75rFcd/73RxzyQg+rGghpPPHSCJklb4WFP
         RUPxMqoKBuDgrXjrD+qwkPpu7tcMkC3klwdbz/t9RZk51zphpt0iJA+Im5i8AMoh9bmk
         XQOA==
X-Gm-Message-State: ACrzQf0Yp/CSXqD+cIFCtNEGnypEz7yWHtgJUfG/icyb12uiaSYbsnG0
        X6iLxYO+vuiD/UwnT1EFqiU=
X-Google-Smtp-Source: AMsMyM4gxWMZiPDXRds/6MP+zp0FCGFZVm21VhcGP1raFxsmrqQotcjcRytDvBbd0GuJ2SezayfxJw==
X-Received: by 2002:a17:903:2111:b0:185:4ca4:7511 with SMTP id o17-20020a170903211100b001854ca47511mr10651223ple.164.1666218222066;
        Wed, 19 Oct 2022 15:23:42 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:8280:2606:af57:d34])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d50300b00174d9bbeda4sm11486866plg.197.2022.10.19.15.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 15:23:41 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 04/10] block: Add support for small segments in blk_rq_map_user_iov()
Date:   Wed, 19 Oct 2022 15:23:18 -0700
Message-Id: <20221019222324.362705-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221019222324.362705-1-bvanassche@acm.org>
References: <20221019222324.362705-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before changing the return value of bio_add_hw_page() into a value in
the range [0, len], make blk_rq_map_user_iov() fall back to copying data
if mapping the data is not possible due to the segment limit.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-map.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 46688e70b141..4505307d758e 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -304,17 +304,26 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 		else {
 			for (j = 0; j < npages; j++) {
 				struct page *page = pages[j];
-				unsigned int n = PAGE_SIZE - offs;
+				unsigned int n = PAGE_SIZE - offs, added;
 				bool same_page = false;
 
 				if (n > bytes)
 					n = bytes;
 
-				if (!bio_add_hw_page(rq->q, bio, page, n, offs,
-						     max_sectors, &same_page)) {
+				added = bio_add_hw_page(rq->q, bio, page, n,
+						offs, max_sectors, &same_page);
+				if (added == 0) {
 					if (same_page)
 						put_page(page);
 					break;
+				} else if (added != n) {
+					/*
+					 * The segment size is smaller than the
+					 * page size and an iov exceeds the
+					 * segment size. Give up.
+					 */
+					ret = -EREMOTEIO;
+					goto out_unmap;
 				}
 
 				bytes -= n;
@@ -654,10 +663,18 @@ int blk_rq_map_user_iov(struct request_queue *q, struct request *rq,
 
 	i = *iter;
 	do {
-		if (copy)
+		if (copy) {
 			ret = bio_copy_user_iov(rq, map_data, &i, gfp_mask);
-		else
+		} else {
 			ret = bio_map_user_iov(rq, &i, gfp_mask);
+			/*
+			 * Fall back to copying the data if bio_map_user_iov()
+			 * returns -EREMOTEIO.
+			 */
+			if (ret == -EREMOTEIO)
+				ret = bio_copy_user_iov(rq, map_data, &i,
+							gfp_mask);
+		}
 		if (ret)
 			goto unmap_rq;
 		if (!bio)
