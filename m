Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1D4C433FE
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 16:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DA96610EA
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 16:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbhJFQhT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbhJFQhS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Oct 2021 12:37:18 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C53BC061746
        for <linux-block@vger.kernel.org>; Wed,  6 Oct 2021 09:35:26 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id w10so3442693ilc.13
        for <linux-block@vger.kernel.org>; Wed, 06 Oct 2021 09:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N1UO0S4eEYIT3PhlUq2EsLNQ/tmm/PiGqnw65TZDDCs=;
        b=qMTJvv8o9ZkB6Rku0XuMhonmsnzgNQP7wQp7DUwcFUreZ5ajGl00iBYw04nLQQVXqV
         Pi8ZP2Vs9GT7ta3hVb+ws9G2+yEhgwViVn1Gmz0p6rE2WdcL1I/cJHwy/w/v86hr+jh5
         BPSNPRK/lY/Fdni7HFZQpA6o10b4OSBwkBvD3UjWNZB7ldUrtvmXdh1QBCHmEB4QYZ7E
         jYO2bVmiNYeR2go+jFRdrynMyQvvBrd8ao00BtEPEhmv/+2HePtxIIJ4H7yrj64BzLXn
         8Iz7lPcgeUXskn+is2i2zUTbgoDsj+QcfYYpZx90j6RBvx81D7KKQDiMkakWhmTIzQA7
         tBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N1UO0S4eEYIT3PhlUq2EsLNQ/tmm/PiGqnw65TZDDCs=;
        b=luMEttb5aIbcL2rwoR1KNrSEPm673VmQdy0vuRVQXZmBVqUkQApLHa1/ROTgeRRezB
         hE4AZUzkYTKPYoQwI4XwBT6Ma2IrB70fDyLKfId1AGGmzSUoKC78EZ5pxPirmexicxOh
         InnZfuO9GTufM4tl8RqtmYkVIUm74NyKo1akdD127JUah30ujCsNKgATXhnWhFvBt3d4
         WPtNM39b3zZ4c25Rlrau2ObN7faikMhOkqzS0qrog8HU26yC0ma9KsCEEfQhFnFwnEKJ
         ll/GeFCzdDkSDWBk1093Cf+thkSdTrc+ayBouaxI9vVChUOAHd3hFaOoK1uVNpRYzcq/
         gM5Q==
X-Gm-Message-State: AOAM531WSBsoy9hRBFW/PZ/XXbbg2+eHp/L+wCnZiZOlE7Ip+SjycmDk
        7ysGbyj8Jx3PZaMWk8R84+Wk6bfi2m/rUPNMq2o=
X-Google-Smtp-Source: ABdhPJywT2fZCDWzICeA4sKvtL5432g3GqYpNvymiE9noZDBC6s1ugFiUEPXEo4sun8ml5tUBVniWw==
X-Received: by 2002:a05:6e02:164c:: with SMTP id v12mr7665147ilu.240.1633538125512;
        Wed, 06 Oct 2021 09:35:25 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n17sm1911890ile.76.2021.10.06.09.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:35:24 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] block: bump max plugged deferred size from 16 to 32
Date:   Wed,  6 Oct 2021 10:35:20 -0600
Message-Id: <20211006163522.450882-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006163522.450882-1-axboe@kernel.dk>
References: <20211006163522.450882-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Particularly for NVMe with efficient deferred submission for many
requests, there are nice benefits to be seen by bumping the default max
plug count from 16 to 32. This is especially true for virtualized setups,
where the submit part is more expensive. But can be noticed even on
native hardware.

Reduce the multiple queue factor from 4 to 2, since we're changing the
default size.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c         | 4 ++--
 include/linux/blkdev.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a40c94505680..5327abbefbab 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2145,14 +2145,14 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
 }
 
 /*
- * Allow 4x BLK_MAX_REQUEST_COUNT requests on plug queue for multiple
+ * Allow 2x BLK_MAX_REQUEST_COUNT requests on plug queue for multiple
  * queues. This is important for md arrays to benefit from merging
  * requests.
  */
 static inline unsigned short blk_plug_max_rq_count(struct blk_plug *plug)
 {
 	if (plug->multiple_queues)
-		return BLK_MAX_REQUEST_COUNT * 4;
+		return BLK_MAX_REQUEST_COUNT * 2;
 	return BLK_MAX_REQUEST_COUNT;
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b19172db7eef..534298ac73cc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -727,7 +727,7 @@ struct blk_plug {
 	bool multiple_queues;
 	bool nowait;
 };
-#define BLK_MAX_REQUEST_COUNT 16
+#define BLK_MAX_REQUEST_COUNT 32
 #define BLK_PLUG_FLUSH_SIZE (128 * 1024)
 
 struct blk_plug_cb;
-- 
2.33.0

