Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE758C433F5
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 14:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF8C60E74
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 14:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbhJZOq6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 10:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbhJZOq6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 10:46:58 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB4CC061767
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 07:44:34 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id lx5-20020a17090b4b0500b001a262880e99so1882483pjb.5
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 07:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=av0r/rjVqFrB/l7qERXJM+4hS0XcNVLfoNKN5vMbJNg=;
        b=fQCuSISujQ+sp4jiaR2E3exaiwEYxJwlV49WSqAxrPz8tjID4RK9dUcdYjmYSArsLN
         okRmNoxVVFxY50rCcK3bONQSE0Re5Q4qqvWpnnJY9ONfiJM0SA/Ok/XB9E7rdEhIZ/Uz
         4skmvpbX5fSta7u6VMRNW3H94ocQ9YwBGIMd2mpvjPtefnKml9woJY4Jk6N17UDeFb2k
         nkWr2Cl+nsf/X8K/M1vklGlm6NoD83XAvXz6x+vy3NC1F6an3D0TbHoCHcdyC0KtPkhA
         g4zWU4JM8bWS6/P/GS46nl54uzxY+GMfhHSKgHMtCsTaRqS4BqwmGYQqcKxMfC8uQe3u
         EeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=av0r/rjVqFrB/l7qERXJM+4hS0XcNVLfoNKN5vMbJNg=;
        b=zXvzSOs7ZSoAeApGw8DNYg1qAx/5k15Zt72xW5ySEvQmEVaUWHUSqrJFsYaFaYdNiX
         klj0BDPG0aQW/nDpU8JjLL7ZWuQPptCUX0TDVepfcMIGjIvRZp1qxQsdekR9D9N9NPX/
         +9KC9SNFKi70iYmVzrX0TJcEEO8nDnXqupcfOkazyBlMGcse7q33DP3lk9iD748en0M6
         VSeWozjVhJGsjS+L9NXkOmClXC+v2B71SvmuqSI6kbZgqPAen8zIHE4v5U83yOSwQvTL
         QNAmJdS1Tddsb7i0tT/XCWwS/IPxTKelBRRXwfKNzo/A0RF6pXWLwU8fY4kuXXzrZDV6
         ZA5Q==
X-Gm-Message-State: AOAM532dRofDbFGHTrNlojZ4yIhOq2cR9wF5w2Vw0CdWeCGZs4s5g9LG
        mE502tor2UGn/o7voeFTPk8P
X-Google-Smtp-Source: ABdhPJyTDsD97vcyR2KGqe10jzWQryeC853DoaBsvwg3J1QWs9+FnNpyFRuyRjDckKsjLlrUuPA1hg==
X-Received: by 2002:a17:90b:1d86:: with SMTP id pf6mr38167103pjb.20.1635259473908;
        Tue, 26 Oct 2021 07:44:33 -0700 (PDT)
Received: from localhost ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id p9sm22418175pfn.7.2021.10.26.07.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 07:44:32 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     axboe@kernel.dk, hch@lst.de, josef@toxicpanda.com, mst@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, kwolf@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 3/4] loop: Use blk_validate_block_size() to validate block size
Date:   Tue, 26 Oct 2021 22:40:14 +0800
Message-Id: <20211026144015.188-4-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211026144015.188-1-xieyongji@bytedance.com>
References: <20211026144015.188-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove loop_validate_block_size() and use the block layer helper
to validate block size.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/block/loop.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7bf4686af774..dfc72a1f6500 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -273,19 +273,6 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 }
 
 /**
- * loop_validate_block_size() - validates the passed in block size
- * @bsize: size to validate
- */
-static int
-loop_validate_block_size(unsigned short bsize)
-{
-	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
-		return -EINVAL;
-
-	return 0;
-}
-
-/**
  * loop_set_size() - sets device size and notifies userspace
  * @lo: struct loop_device to set the size for
  * @size: new size of the loop device
@@ -1236,7 +1223,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	}
 
 	if (config->block_size) {
-		error = loop_validate_block_size(config->block_size);
+		error = blk_validate_block_size(config->block_size);
 		if (error)
 			goto out_unlock;
 	}
@@ -1759,7 +1746,7 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 	if (lo->lo_state != Lo_bound)
 		return -ENXIO;
 
-	err = loop_validate_block_size(arg);
+	err = blk_validate_block_size(arg);
 	if (err)
 		return err;
 
-- 
2.11.0

