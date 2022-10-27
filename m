Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC730FA3743
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 22:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbiJ0WPh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Oct 2022 18:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbiJ0WPe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2022 18:15:34 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FCD82D3E
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 15:15:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g12so4471954wrs.10
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 15:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7A52ipm2QrLZAhRmwpGWLDM+OAm7jKrXuoGyS3jVh5s=;
        b=JA+PYBrzCGuNuUf3vkF3VeeGpRj4DabkJXMqOJ4472loutRO7IeqJBl64VFv3tW9YC
         1KreZot4TBUe9fZ5KsYNhylyAlNvUbg5FbkXOrOsLVFyyVj/rwutiIrSizuhp8ECbn3v
         qf7gK2GmJXS5PydNkQGGuW86p9BCGtMAKH8m8JjZlYL3vWAWSggFzEedFH2RcH3kwq01
         jjLWgMI2gax7CyfvqhFWWPbQ7EmuFbDWgKFO9RfhvLZplcJqkn5x0Cx434NC4LNZd27H
         mm0u7hIw+XCCCRJjRMoIytlf2CL20RfMIfRHSkWDWq9ed9IUnmyd/5wZgWLiXFaUXJBp
         rIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7A52ipm2QrLZAhRmwpGWLDM+OAm7jKrXuoGyS3jVh5s=;
        b=T5EmnT5nym0oFzHRnn6YGi9AAXouwz2uz6BX1U7BWsBnxyOwJ69FDmGAJY9k0XJ43Z
         oBGvm98Cf2H4Yu+24bTfqo/AUQ+m5TkLJtxVcX6rLq2PsdiKfRcaKISZAT5Ub7NqNKLY
         52YJ2Fznj5Px3QultX1asXakOfUYNryTUF7Ej/JjgSRYQ12sTeYWgpy3EAhcOpSK66f9
         0fmrocJx88Xk4WzvTpFLs/Gnj6+6eYvqYkK1hW0OqyFJm8jijCH2KQmg5L+9m/z2Peu5
         54dLySIv1+a58c0Gvj+CJB4D12gdJe9uu5fCxlSEsy1HhN6iONQEq/RbDmKHwheWE09m
         D0lA==
X-Gm-Message-State: ACrzQf3GYpMO3k9nT3TnvuH97hzuwXoZ0Ya/StdVKzt2DRj1D1wSDB3u
        TzyRyRsHnLcTHOWONFY151s=
X-Google-Smtp-Source: AMsMyM6hS7hs5Nh9uYh5ZsAcJSWmyIbkktlXkx9dQsi7WxyIIBWg4+LxWXKcyQJ8u4TpG3Y2QOSK/w==
X-Received: by 2002:a5d:64e1:0:b0:22e:762f:7d3f with SMTP id g1-20020a5d64e1000000b0022e762f7d3fmr33235784wri.526.1666908930754;
        Thu, 27 Oct 2022 15:15:30 -0700 (PDT)
Received: from 127.0.0.1localhost (213-205-70-130.net.novis.pt. [213.205.70.130])
        by smtp.gmail.com with ESMTPSA id bs5-20020a056000070500b00236674840e9sm2085460wrb.59.2022.10.27.15.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 15:15:30 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH for-6.1 2/2] bio: don't rob bios from starving bioset
Date:   Thu, 27 Oct 2022 23:14:22 +0100
Message-Id: <0cf2d7dca8c0ee6322f4e068c2d0f56ac731e551.1666886282.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <cover.1666886282.git.asml.silence@gmail.com>
References: <cover.1666886282.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Biosets keep a mempool, so as long as requests complete we can always
can allocate and have forward progress. Percpu bio caches break that
assumptions as we may complete into the cache of one CPU and after try
and fail to allocate with another CPU. We also can't grab from another
CPU's cache without tricky sync.

If we're allocating with a bio while the mempool is undersaturated,
remove REQ_ALLOC_CACHE flag, so on put it will go straight to mempool.
It might try to free into mempool more requests than required, but
assuming than there is no memory starvation in the system it'll
stabilise and never hit that path.

Fixes: be4d234d7aebb ("bio: add allocation cache abstraction")
Cc: <stable@vger.kernel.org> # 5.15+
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 0a14af923738..e00c93be368a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -526,6 +526,8 @@ struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
 	}
 	if (unlikely(!p))
 		return NULL;
+	if (!mempool_is_saturated(&bs->bio_pool))
+		opf &= ~REQ_ALLOC_CACHE;
 
 	bio = p + bs->front_pad;
 	if (nr_vecs > BIO_INLINE_VECS) {
-- 
2.38.0

