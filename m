Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE922C7EE29
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 22:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbjEVW0P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 May 2023 18:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbjEVW0K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 18:26:10 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01D4FE
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 15:26:09 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-25343f0c693so4531961a91.3
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 15:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684794369; x=1687386369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwFb7GBgsiYz152ip8/4jhS0NB6B53ypfLTTPKe/aig=;
        b=HGQwQ+0qISDzDXDcuzO3vIni+GhGRV5RhJmtV5/sfhxBrz4DyfFC9+SR0KsdlU9BiY
         Rlz7qzHlRf1IYWEFkS+7TZ0RmIW+z4Q5pXUONY2K0GrgGnyayhvjIkTPFbhqNlvex5J0
         6M9bzrDMWPYHl0+Eck/oq4T99FUdljNFXNb9ybR4FqoTmihbL+LOX0WuRs8N/Sv/4Qgd
         4xxK6BoXlDc9pmS9c/m4HiVNNQxURxu5ZCpIeT1oCaqyMrPW/xZga862+eVHra5JpJWi
         yhQS6CD99X1Ctcwjed5iUT57p/232jMVzzzSbHDNg+yRw4PruIm/C02oUrUKECJoVmMP
         3Q2w==
X-Gm-Message-State: AC+VfDzzf5kS6HznuBQoz6drO0dWPY2s2/y2+QUyaaOJ7zYNwVruiVEF
        kpnRsrqZjFd6XoBZgv9m/sU=
X-Google-Smtp-Source: ACHHUZ7+cb7BlDJeC+CF8e/7pPOf7rENJJUY9jAZd+QBysSGbb6BbJ3BfK/YirNIDrLF0KXVLpRLSg==
X-Received: by 2002:a17:90b:1e4d:b0:253:6c97:6861 with SMTP id pi13-20020a17090b1e4d00b002536c976861mr11680703pjb.17.1684794369082;
        Mon, 22 May 2023 15:26:09 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:642f:e57f:85fb:3794])
        by smtp.gmail.com with ESMTPSA id y8-20020a634b08000000b00520f4ecd71esm4725364pga.93.2023.05.22.15.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 15:26:08 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        jyescas@google.com, mcgrof@kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v5 7/9] block: Add support for small segments in blk_rq_map_user_iov()
Date:   Mon, 22 May 2023 15:25:39 -0700
Message-ID: <20230522222554.525229-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230522222554.525229-1-bvanassche@acm.org>
References: <20230522222554.525229-1-bvanassche@acm.org>
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
Cc: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-map.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index e1355331019a..c04f1698672a 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -308,17 +308,26 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
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
@@ -658,10 +667,18 @@ int blk_rq_map_user_iov(struct request_queue *q, struct request *rq,
 
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
