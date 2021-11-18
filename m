Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ABCC433EF
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 23:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F76161179
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 23:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbhKSABK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Nov 2021 19:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbhKSABJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Nov 2021 19:01:09 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547AAC06173E
        for <linux-block@vger.kernel.org>; Thu, 18 Nov 2021 15:58:09 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id m14so7678755pfc.9
        for <linux-block@vger.kernel.org>; Thu, 18 Nov 2021 15:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4rpZGCTbKBiGjmtzGhgW6CK6EMd3LEVNf1dfX6HFghQ=;
        b=QQWOck8j0+FFQqp9DDAcFXvAZCuqBxhYe+Hhm027LcAg6kMBTZEixpAPgXZMvDEPQu
         VmFjdp9Wej0Kci9DSSCFYgvPWoFlYAHUVZbSL9YQ0gQjnagB1MatFVdhyTyJmXBzb3Mw
         6pzgG2RCndEkAM55X5RaI+GdXiQtGZ0w4b/D0qR83mbDkHTrtBPV0IxG9uW+06j6d4yY
         kO0K7VjB7goGrJTDCIibwuUsvRYcezZp81iBEJxmx2kXkEdDpP6Z+5EogR+xMSnaE9gN
         B0IgECgrq1HYwrc4QjItYu2llOLwHuplt+jvJ2n7qiXa262OIMisRpYUtW0tBQz89xsx
         gw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4rpZGCTbKBiGjmtzGhgW6CK6EMd3LEVNf1dfX6HFghQ=;
        b=7DO7ONogDk8KU0wK/DsEHJved+p4Ov72zLgnSA9mwkq6fLHIPdXcDyoQa/92CKHR7u
         dJIOzwKOQ+3lUihIUa1GA2NAztf70n6n5VWN6sz26FJFNjcJyZAtCJj+wqURq6TMtY4t
         fXqIvMWfsdIMnVAkYFnXPHq0G0eWMAC/v1NEmY4lQjuz7SPAcH7LTy5OA+0WwR2EfJ7w
         LRLYjie8YEYYF2E3Kvb974OiXbxx73VR6CD+ZfjqEdBiy4VVoNCvHie3atBn8MuuM/ow
         xIXSDgLhWh6jXS71iGTPEoG9ehUa0ULXKlrhKExUWYM55w04WSYKba48pAau5KcGlUOn
         gEMQ==
X-Gm-Message-State: AOAM531VSTkJ2TA73avYDjl6P/C2oHHhBuRqnI73WlErJZZY6FAsJ7aw
        DMpbmP4syqBZtgoW+HkBCeCg7Q==
X-Google-Smtp-Source: ABdhPJwofaoOdmDDhaskHtIZryki0A+tmXZox9rRYiee7+l8BcJCyR75Rmu+i2bmarhQoeAyG5x94A==
X-Received: by 2002:a63:844a:: with SMTP id k71mr4169755pgd.101.1637279888906;
        Thu, 18 Nov 2021 15:58:08 -0800 (PST)
Received: from localhost.localdomain ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id ip6sm9786395pjb.42.2021.11.18.15.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 15:58:08 -0800 (PST)
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
To:     stable@vger.kernel.org
Cc:     tadeusz.struk@linaro.org, axboe@kernel.dk, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+662448179365dddc1880@syzkaller.appspotmail.com,
        xieyongji@bytedance.com
Subject: [PATCH 5.14] block: Add a helper to validate the block size
Date:   Thu, 18 Nov 2021 15:57:56 -0800
Message-Id: <20211118235756.1128122-1-tadeusz.struk@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <7e6c4c23-f071-f33b-7bd4-da11980d34c6@linaro.org>
References: <7e6c4c23-f071-f33b-7bd4-da11980d34c6@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xie Yongji <xieyongji@bytedance.com>

From: Xie Yongji <xieyongji@bytedance.com>

There are some duplicated codes to validate the block
size in block drivers. This limitation actually comes
from block layer, so this patch tries to add a new block
layer helper for that.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Link: https://lore.kernel.org/r/20211026144015.188-2-xieyongji@bytedance.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Tadeusz Struk <tadeusz.struk@linaro.org>
---
 include/linux/blkdev.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e7979fe7e4fa..84019910446a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -59,6 +59,14 @@ struct blk_keyslot_manager;
  */
 #define BLKCG_MAX_POLS		6
 
+static inline int blk_validate_block_size(unsigned int bsize)
+{
+	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
+		return -EINVAL;
+
+	return 0;
+}
+
 typedef void (rq_end_io_fn)(struct request *, blk_status_t);
 
 /*
-- 
2.33.1

