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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A188C71155
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 01:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AB4D2076A
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 01:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAtUgbSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgK3Bkf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Nov 2020 20:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbgK3Bkf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Nov 2020 20:40:35 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4A8C0613D4
        for <linux-block@vger.kernel.org>; Sun, 29 Nov 2020 17:39:54 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id z7so13511128wrn.3
        for <linux-block@vger.kernel.org>; Sun, 29 Nov 2020 17:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZZ1///T+vYg4MLvcwCYhoWFn6ELsEtEXdv0FmIojt8c=;
        b=PAtUgbSmEuQM5Y4zjeW+T7NomEJrz6WC2oJQB/IBVQBS58hTojd1AQwHtBsY3YcZiN
         rrKlFfxWX9oGJbwD0KADKGqiQIYDNGNB5dpOv1gpekG1QADXGVZGhIzY3NATmzOytOYk
         ObOzCTiku0ZDPtumKiXEuKI3U8KfK1KqPoy5buAt6dWeaoqItIbQgokS4djjhmhIbqeL
         5fbZt0hP7i6dH5GRM5Z5VvXoBu9n8BrT7CjLrWTm5k3fAwPQlEjv8COVpcx6iS6NX04W
         t5MOWdf7D8MlxLDsOLI+yyow5Oy1eEE4v2U+Z2SECAIbe4gCxfUDlLRs4NyT5+8FZFgN
         3SSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZZ1///T+vYg4MLvcwCYhoWFn6ELsEtEXdv0FmIojt8c=;
        b=h0CmeQwc01jA1yPBvHH3clXeQ7PCOa1tk+aeW4RKoZlLK3xUlOamdIAh2fzysVBY5Z
         liGyLtM6E9EimDA58IIKcQm5ooInrtkbhKsUFm8rcw/BcIm8FjuK5HWBNjaQCMMA7ovN
         ZVhfuMyt52vsSWdzRcRxp1TF9SaFK8hsxSTMlZP32GNLzax/1SlZvDo7MaNqw4XG4c5S
         TNMdfCkIJM+wGEofWadA4HQCm4cIkd3U7EZ8jQTqtKBeZx79bnD7W4odgXnxCRjnhwxP
         OH8n/y5J9m98SkBoLP4qJ6wFS1D3lfHXXpilEWuiiVzZZ7kEz26RUAX5bimunUVbYwM/
         2h8Q==
X-Gm-Message-State: AOAM5303g7hzSpCnbZgD/jqmDmf7dXKlJUlL9k+kALo2MUiKQL03tyWk
        zVMcDDVhHfJEh/wMZi3amR8=
X-Google-Smtp-Source: ABdhPJywcwKiggtvdIaBPd98tGAxjssZ5TbV4gpCV6akgzD7RV/vRT2w2OPXjYHGvkRRemmrS8AN4w==
X-Received: by 2002:a5d:4612:: with SMTP id t18mr25603265wrq.401.1606700393511;
        Sun, 29 Nov 2020 17:39:53 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-135.range109-152.btcentralplus.com. [109.152.100.135])
        by smtp.gmail.com with ESMTPSA id k1sm24573414wrp.23.2020.11.29.17.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 17:39:53 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 3/3] blk-mq: idiomatic use of WARN_ON_ONCE
Date:   Mon, 30 Nov 2020 01:36:27 +0000
Message-Id: <bf149a4f4a73d21ed89e7d481eb92f46adb8bf6d.1606699505.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1606699505.git.asml.silence@gmail.com>
References: <cover.1606699505.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Let WARN_ON_ONCE() to be more clear by passing the warn condition
directly, so it'll be printed.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq-tag.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 98f6ea219bb4..f2743a9159ca 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -96,10 +96,8 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	int tag;
 
 	if (data->flags & BLK_MQ_REQ_RESERVED) {
-		if (unlikely(!tags->nr_reserved_tags)) {
-			WARN_ON_ONCE(1);
+		if (WARN_ON_ONCE(!tags->nr_reserved_tags))
 			return BLK_MQ_NO_TAG;
-		}
 		bt = tags->breserved_tags;
 	} else {
 		bt = tags->bitmap_tags;
-- 
2.24.0

