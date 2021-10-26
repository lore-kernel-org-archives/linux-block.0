Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1424C433F5
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 14:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 896A460E74
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 14:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbhJZOpS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 10:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236855AbhJZOpS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 10:45:18 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47824C061745
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 07:42:54 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q2-20020a17090a2e0200b001a0fd4efd49so1436060pjd.1
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 07:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TqXG0/tzAMme0lqJcgyNBNW84HzqzOSloOMxwNDMqnk=;
        b=4Uoy2ivd6uzyXo6Bmv0aXm5MmnUwpA6xwiPFquzbRkZTyRRY4UNetOEgSK4I/+I4Hs
         cKQMXQyeDPDR7Z3/e/VHdvzK8auY822368Vkua5jFt2pNRX6WElVvi56m1PXXALhq7Q5
         9MjGbof65vT4ZVYTsd2S1lNtt8tiNb0TNEVSVjR/FvRhJBKKd/RBuNLBb45aTezTh7ie
         rHGEwVnlQijC58C7l1SfEHHSIamwkhqqqS5HB2+qVofIJYZBIxWuDAAdXa0VKZi3vf3g
         7xiCe/YNR030jxAwfiyg+eYkDC8rHzxyNa7ezPLc9GdF7B/KXWS7ZNVuRUvwSiKaX/kA
         YKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TqXG0/tzAMme0lqJcgyNBNW84HzqzOSloOMxwNDMqnk=;
        b=mrwb54roYN30fqo1ki2Od92ol/RvyD23W8mAQvmKaLIdI6Y2F5R1QfzfLtjlOY2Vub
         l1TS8IjiR6w6YYwtJN872DJ/WZJrHep55VQdKk5p/oqu1VFN/n7k6Py4+6pEE/j4yuMT
         KrSlW6OPRJxInS0ldyJruS/vrtaiKgXMxKBpSirZBjzchdFgAKkTPjsMeenm774zPTA4
         qILqcVKsd83IYn+lQIARSimeBquJ7LL0clDnlcSO4xWxlLU6aKwf10WPXNuAudFOyCzG
         OUbO1c9pmGVgzTWjDCj8oVHAhO6tuFkQecnBf/dmq0rXtrnz+M3K1B7aJO0E7hCVtx47
         ps5Q==
X-Gm-Message-State: AOAM531rUufjcvfS9MyGuaRLipZrQN8nzQyTJKsp/kly8Ma2XeBPtu9O
        vvlRcinIg619H+CZ4dypWv8+
X-Google-Smtp-Source: ABdhPJxDwzTaNXwa8zQVleZVpvYopPJy2hn0TFeAdTDt/zvKmOazBfBhS7NJeIu2hl6KbdFN99IGQQ==
X-Received: by 2002:a17:90b:4c41:: with SMTP id np1mr40155366pjb.18.1635259373880;
        Tue, 26 Oct 2021 07:42:53 -0700 (PDT)
Received: from localhost ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id j19sm3396218pfj.127.2021.10.26.07.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 07:42:48 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     axboe@kernel.dk, hch@lst.de, josef@toxicpanda.com, mst@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, kwolf@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 1/4] block: Add a helper to validate the block size
Date:   Tue, 26 Oct 2021 22:40:12 +0800
Message-Id: <20211026144015.188-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211026144015.188-1-xieyongji@bytedance.com>
References: <20211026144015.188-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are some duplicated codes to validate the block
size in block drivers. This limitation actually comes
from block layer, so this patch tries to add a new block
layer helper for that.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 include/linux/blkdev.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 12b9dbcc980e..805cd02d7914 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -235,6 +235,14 @@ struct request {
 	void *end_io_data;
 };
 
+static inline int blk_validate_block_size(unsigned int bsize)
+{
+	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
+		return -EINVAL;
+
+	return 0;
+}
+
 static inline bool blk_op_is_passthrough(unsigned int op)
 {
 	op &= REQ_OP_MASK;
-- 
2.11.0

