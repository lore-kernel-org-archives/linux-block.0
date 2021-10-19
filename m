Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DBFC433FE
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 923F26134F
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhJSV0y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhJSV0y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 17:26:54 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09023C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:41 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l38-20020a05600c1d2600b0030d80c3667aso5616185wms.5
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AVoXQBnS9I34e/jR0MATyoXPGgXTqfW0R5gKnmJ28c0=;
        b=XrVskauqhoBAXT/T/RytFGyrUPaWOw7mlti8hRCrySHipyffxLgwaA63mGLxIYvoLb
         4uJF/Z1b3TqGoej2siTPl7/hM/z0po7B7O9RpL/F0OnDN6Yh12aU9ezsQ1jXEPLf3/fh
         A/49AD9NspNlwLadbj7cHBuRVVjYYoS8TRT0EndDxs/kymI9vsIU54kmmWDJtq5IDWf/
         DwkTK7YoovJj+84HfIUgHg0TPd/poiSOC56QY17UvAJSVWanDAHOCpInZh6vAmnRKK2A
         toSSeFcThcmqvHAwEKbgoVdJDf3lBfGhbly0UAw2eE1Ij8kVSHR2dlJSAjCvwZ+LOTDb
         lu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AVoXQBnS9I34e/jR0MATyoXPGgXTqfW0R5gKnmJ28c0=;
        b=UbqsPj97pUuJ1V6c1hYRsktvH6uw/OOQCyNCQXIfyD6rygS1wjIfiZ05JpNkCgIvQp
         LJzly21GWCeRN9lvqXdWTNSjpraOScfS/Z95KU8OwjJDIn/OtEKaZOKg5e735SA/f9Mr
         xXJIw30SErtm5BL7myQjjvpFcuc/RL0HEN0lLx3Hi+bVJ1GTwQu2xWu76GH/qs/2EO3I
         KtUNgV7jUunaMWDoJBbGUVn17x/I6OphovRhgLEI+Hn9Vl2HpPyh94K1k/b9RniU0i4Q
         w2xllWOXxxnMnT6PuIVtDsEcsQmiJGn/rJdsyLyqOrWQY9ENOiHzeyaudUhL09+jAVfW
         GDZQ==
X-Gm-Message-State: AOAM533u7xCLtsFbgpg4mL8C3IBnctJtqiFnRYtSyHWjSpbufN0t7A/V
        6ub0DcBtkqlDZMIVmz+MMOFK0Y7JMvdgEw==
X-Google-Smtp-Source: ABdhPJwGOx2wSeVTV+foACs0d8Ka1MNGkRtYQWZDVLlbaAIH2jaoXj2VnPoRinzEw+KuoAYAmo1LDQ==
X-Received: by 2002:a1c:1b89:: with SMTP id b131mr8835880wmb.71.1634678679421;
        Tue, 19 Oct 2021 14:24:39 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.194])
        by smtp.gmail.com with ESMTPSA id m14sm216020wms.25.2021.10.19.14.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 14:24:39 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 08/16] block: optimise blk_flush_plug_list
Date:   Tue, 19 Oct 2021 22:24:17 +0100
Message-Id: <a9127996b15a859a0041245b4a9507f97f155f7f.1634676157.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634676157.git.asml.silence@gmail.com>
References: <cover.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

First, don't init a callback list if there are no plug callbacks. Also,
replace internals of the function with do-while.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6bdbaa838030..6627ea76f7c6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2251,22 +2251,24 @@ static void flush_plug_callbacks(struct blk_plug *plug, bool from_schedule)
 {
 	LIST_HEAD(callbacks);
 
-	while (!list_empty(&plug->cb_list)) {
+	do {
 		list_splice_init(&plug->cb_list, &callbacks);
 
-		while (!list_empty(&callbacks)) {
+		do {
 			struct blk_plug_cb *cb = list_first_entry(&callbacks,
 							  struct blk_plug_cb,
 							  list);
+
 			list_del(&cb->list);
 			cb->callback(cb, from_schedule);
-		}
-	}
+		} while (!list_empty(&callbacks));
+	} while (!list_empty(&plug->cb_list));
 }
 
 void blk_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
-	flush_plug_callbacks(plug, from_schedule);
+	if (!list_empty(&plug->cb_list))
+		flush_plug_callbacks(plug, from_schedule);
 
 	if (!rq_list_empty(plug->mq_list))
 		blk_mq_flush_plug_list(plug, from_schedule);
-- 
2.33.1

