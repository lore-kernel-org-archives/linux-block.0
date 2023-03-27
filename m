Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D3EC77B6C
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 20:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjC0UOE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 16:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjC0UOD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 16:14:03 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E9B1BF8
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:12 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id jl13so7608649qvb.10
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679947991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38Sgxe5/q+hJ0JKVFdOX1S2/H0qUacEb3wrSiTwviHY=;
        b=U0wP3Nugs8NAQG9ZTr1OX2UVkJRtnEISnGUfIeLnB0VvBvrhdTSQdlLBzD1R378pm/
         SdMOPoO7IR/EAfmtGrc7Ti8ytbwcSx0FAYE0AQLfJUSYKCWddK6ujdpUXJny9T5qIh8S
         KfVnSZEkRCQiS/Uu8dkLtslO2tWV4wOseHCjrLzgnthOPuZur1l7LuQrxjsub8oxu1Ye
         dpGjy9ddBuzKhNYNVLQy8Q40+z5WX+MJ8+CTTC+1LxsN21YOqfoTrnkY92GOkVvzSlBT
         bYA4t9diB7LBBrXPOClK9G9THkiilf+7/DI93sztTrMLTC801tl3J4Q+S0KP0W2qje8S
         Y5mw==
X-Gm-Message-State: AAQBX9e7++MQm/p+WochG/OHNl3JIwaKh4Jys0TXyxCsepfXfu3Rfwa5
        tfjdkJxI9iXEPVhXUdq82ErH
X-Google-Smtp-Source: AKy350Z/SX3NEFg9tn3FY6AM6zZMl6uXUeBw6GhmbRlqi/g3goSm+tkfNNjvAC/CMiQFi0MxHMsbFw==
X-Received: by 2002:ad4:5d69:0:b0:5db:e06f:e0f9 with SMTP id fn9-20020ad45d69000000b005dbe06fe0f9mr19745867qvb.13.1679947991288;
        Mon, 27 Mar 2023 13:13:11 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id a200-20020ae9e8d1000000b00747d211536dsm3327118qkg.107.2023.03.27.13.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:13:10 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, ejt@redhat.com,
        mpatocka@redhat.com, heinzm@redhat.com, nhuck@google.com,
        ebiggers@kernel.org, keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v3 03/20] dm bufio: never crash if dm_bufio_in_request()
Date:   Mon, 27 Mar 2023 16:11:26 -0400
Message-Id: <20230327201143.51026-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230327201143.51026-1-snitzer@kernel.org>
References: <20230327201143.51026-1-snitzer@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All these instances are entirely avoidable given that they speak to
coding mistakes that result in inappropriate use. Proper testing during
development will catch any such coding bug so its best to relax all of
these from BUG_ON to WARN_ON_ONCE.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-bufio.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index dac9f1f84c34..d63f94ab1d9f 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1152,7 +1152,8 @@ EXPORT_SYMBOL_GPL(dm_bufio_get);
 void *dm_bufio_read(struct dm_bufio_client *c, sector_t block,
 		    struct dm_buffer **bp)
 {
-	BUG_ON(dm_bufio_in_request());
+	if (WARN_ON_ONCE(dm_bufio_in_request()))
+		return ERR_PTR(-EINVAL);
 
 	return new_read(c, block, NF_READ, bp);
 }
@@ -1161,7 +1162,8 @@ EXPORT_SYMBOL_GPL(dm_bufio_read);
 void *dm_bufio_new(struct dm_bufio_client *c, sector_t block,
 		   struct dm_buffer **bp)
 {
-	BUG_ON(dm_bufio_in_request());
+	if (WARN_ON_ONCE(dm_bufio_in_request()))
+		return ERR_PTR(-EINVAL);
 
 	return new_read(c, block, NF_FRESH, bp);
 }
@@ -1174,7 +1176,8 @@ void dm_bufio_prefetch(struct dm_bufio_client *c,
 
 	LIST_HEAD(write_list);
 
-	BUG_ON(dm_bufio_in_request());
+	if (WARN_ON_ONCE(dm_bufio_in_request()))
+		return; /* should never happen */
 
 	blk_start_plug(&plug);
 	dm_bufio_lock(c);
@@ -1281,7 +1284,8 @@ void dm_bufio_write_dirty_buffers_async(struct dm_bufio_client *c)
 {
 	LIST_HEAD(write_list);
 
-	BUG_ON(dm_bufio_in_request());
+	if (WARN_ON_ONCE(dm_bufio_in_request()))
+		return; /* should never happen */
 
 	dm_bufio_lock(c);
 	__write_dirty_buffers_async(c, 0, &write_list);
@@ -1386,7 +1390,8 @@ int dm_bufio_issue_flush(struct dm_bufio_client *c)
 		.count = 0,
 	};
 
-	BUG_ON(dm_bufio_in_request());
+	if (WARN_ON_ONCE(dm_bufio_in_request()))
+		return -EINVAL;
 
 	return dm_io(&io_req, 1, &io_reg, NULL);
 }
@@ -1409,7 +1414,8 @@ int dm_bufio_issue_discard(struct dm_bufio_client *c, sector_t block, sector_t c
 		.count = block_to_sector(c, count),
 	};
 
-	BUG_ON(dm_bufio_in_request());
+	if (WARN_ON_ONCE(dm_bufio_in_request()))
+		return -EINVAL; /* discards are optional */
 
 	return dm_io(&io_req, 1, &io_reg, NULL);
 }
-- 
2.40.0

