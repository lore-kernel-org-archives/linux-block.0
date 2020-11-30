Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFA2C64E7B
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 01:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB2012076A
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 01:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvFga+PU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgK3Bkd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Nov 2020 20:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgK3Bkd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Nov 2020 20:40:33 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966D7C0613D2
        for <linux-block@vger.kernel.org>; Sun, 29 Nov 2020 17:39:52 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id i2so13505526wrs.4
        for <linux-block@vger.kernel.org>; Sun, 29 Nov 2020 17:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7cZQifmtKrzG+24RrMwyoPCWwB2u7v0s6UGdz93hnGY=;
        b=VvFga+PU/WHwEp6SkeX7oYRa9ghQqTNuaqg4/7hejsXbao7PgTX9sYePe/gQnU/J5F
         Efg7JOJc6QxVXyL5Ct2EBZdfSJO/mpEd/VB1sQmch8ENkJCknrv0qFJXv9VtdrPUr8I4
         WfXEOjPxh0LSY/tcqzozMnFJU+e+5MZBa4m76yoUvbcJZwugASRQg+KynBIdkXlqRDOe
         rFejYksZ/vvC8Q4N+JfPo/5IMEhJT6hyq+XvfaBe377WQ+ySzJGPzuBwW8o/60ov9aH6
         7PokdFND4gFMo/klWc6VEZJCkQ8IqDkPkXyvviNPxve9u3LvMFATIeK6JYzUVG03kk3/
         TVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7cZQifmtKrzG+24RrMwyoPCWwB2u7v0s6UGdz93hnGY=;
        b=Kl/0VNsmw/eSAsgnxPfw+CEnFiVYr+TYO4ZblVXkSsdnlHoldZLDH7Mu7Zs3/Z8l8q
         FB9F+rq1+zrVjwNN096bcR3qDuPASY9siqxJ7Fspz/ob0mtgYzrRZDLEzBuAQFWJy3+j
         UdIMgBPk2loQpD5C3DoVXhL7gd+WX5tdPMaivnlzsqlK02tCcwAouhJVjzT6KWk9J+hx
         j5kANoAUCNUKlnCDRRvEauDaNg8pM5vZfp8pIuo5AOgblN0AzDRM9+DlrO5UrZAsCj6R
         8fYy4lvjal8mzgDo03jbJdFjUlN45ipPJ4trC5DOBI+XDg/dff88tOUFcYZ1ovLR2J1A
         yqYw==
X-Gm-Message-State: AOAM530P1UmUxcOYjObv+oiKE2IWVoAx+SZqUB55G3gCDgBZu0WwzBPY
        Fe4YY0/J1tJxaNCi1hB6H2Y=
X-Google-Smtp-Source: ABdhPJyMGQkhV3P8t/9UvW65TApacDrp2HfprojxUjR3UnvHt1eeqUxVhfMMuDKYWlRD1WRiLiPUwQ==
X-Received: by 2002:a5d:4591:: with SMTP id p17mr25972310wrq.361.1606700391334;
        Sun, 29 Nov 2020 17:39:51 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-135.range109-152.btcentralplus.com. [109.152.100.135])
        by smtp.gmail.com with ESMTPSA id k1sm24573414wrp.23.2020.11.29.17.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 17:39:50 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 1/3] blk-mq: use right tag offset after wait
Date:   Mon, 30 Nov 2020 01:36:25 +0000
Message-Id: <beee275f48a98e42f073ee63221e9610fc9470b5.1606699505.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1606699505.git.asml.silence@gmail.com>
References: <cover.1606699505.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_get_tag() selects tag_offset in the beginning and doesn't update
it even though the tag set it may have changed hw queue during waiting.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq-tag.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 9c92053e704d..dbbf11edf9a6 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -101,10 +101,8 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 			return BLK_MQ_NO_TAG;
 		}
 		bt = tags->breserved_tags;
-		tag_offset = 0;
 	} else {
 		bt = tags->bitmap_tags;
-		tag_offset = tags->nr_reserved_tags;
 	}
 
 	tag = __blk_mq_get_tag(data, bt);
@@ -167,6 +165,11 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	sbitmap_finish_wait(bt, ws, &wait);
 
 found_tag:
+	if (data->flags & BLK_MQ_REQ_RESERVED)
+		tag_offset = 0;
+	else
+		tag_offset = tags->nr_reserved_tags;
+
 	/*
 	 * Give up this allocation if the hctx is inactive.  The caller will
 	 * retry on an active hctx.
-- 
2.24.0

