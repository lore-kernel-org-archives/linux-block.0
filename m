Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56268C433FE
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 23:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4340861179
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 23:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhKSABb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Nov 2021 19:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbhKSABb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Nov 2021 19:01:31 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD14FC061574
        for <linux-block@vger.kernel.org>; Thu, 18 Nov 2021 15:58:30 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id r5so6958959pgi.6
        for <linux-block@vger.kernel.org>; Thu, 18 Nov 2021 15:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9WkN4HKXuKYbFciD1zZtiqVWPD50CNCY9jlNGzee/uw=;
        b=qrO2wcdt1faJZaDnJbYZRzsdKDdVdTc2K/Q8VGgqOZpv5ePN4i5qAlnQCzYV/E1W1N
         kyqG0nBAvNIwmOkCZdc7bZ1rpvMjW7OgP6LSA6b+fpBjF1k1d6+krF3Kt5hAmxw05XlH
         If6DvQA16yH3QpGEA3YSYbS3N99chxAe+LoqKyll3EFfP7WWqfOeHgYoolaOJhbOxuz7
         g7gOtc1fKeHiu6/afTCtGfYP/TsnR4wzkjRwDbyWYw1SEBxyKs4J8d7yjc5Vvs/PoJEH
         XjRZUK92nR/JIvYfTSRVQBFC+O8VGpyuYe89pYrRJ+hwNv4VwujZU0d/q6UOyW6Ixbg9
         zbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9WkN4HKXuKYbFciD1zZtiqVWPD50CNCY9jlNGzee/uw=;
        b=1dL7hNLU7T2iHRpZ4J5G/nSfTZ2cunfo9503F8c91zG1NM6gmuOllkEyWMZuFFvcns
         jxK4q8Yfi1NgYpdDTDj3eLRLo6L6BZVas8j+KghlgcYWXO/bE7HiCHRlfHfrYVYuBVcS
         hSvWjJPzJqVhUPzBIosQbjtgNS69ildHXPIndmCGJcYfKTR+fTcKCA1rhFWegWElPb0A
         HJMu1jxn1xtq1IsBTGxs+mSXTZLtZK82KAu+AC7BMUsGFlNxP8e7eExo/scSn7JSMBPH
         12yWloVwStRCwFgOl9DtkoRN+lgob1h4yuq4oPaUdSnc/CH34Ja5cRRFqI+FIV6tsS50
         nmPg==
X-Gm-Message-State: AOAM532OpDeKsi1IYuBJL8zErDEdZlF2/sr4H0uLMpMrZMQoK8+52ThG
        4tRq3S9fauM1771T4GkjMob/xw==
X-Google-Smtp-Source: ABdhPJwRZiJZb3NbkmAdoQ5A+L6PoE6jT0vR3ZTTdIvSEpKR9s9kX013IkpCvc500C8TS0vhWSIJhw==
X-Received: by 2002:a63:6ece:: with SMTP id j197mr13929977pgc.11.1637279910401;
        Thu, 18 Nov 2021 15:58:30 -0800 (PST)
Received: from localhost.localdomain ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id b8sm685811pfi.103.2021.11.18.15.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 15:58:30 -0800 (PST)
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
To:     stable@vger.kernel.org
Cc:     tadeusz.struk@linaro.org, axboe@kernel.dk, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+662448179365dddc1880@syzkaller.appspotmail.com,
        xieyongji@bytedance.com
Subject: [PATCH 5.10] block: Add a helper to validate the block size
Date:   Thu, 18 Nov 2021 15:58:18 -0800
Message-Id: <20211118235818.1128157-1-tadeusz.struk@linaro.org>
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
index 4ba17736b614..98fdf5a31fd6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -59,6 +59,14 @@ struct blk_keyslot_manager;
  */
 #define BLKCG_MAX_POLS		5
 
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

