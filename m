Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13DEC433EF
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 14:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0002603E5
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 14:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhJZOqy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 10:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbhJZOqy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 10:46:54 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71501C061745
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 07:44:30 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id y1-20020a17090a134100b001a27a7e9c8dso2082006pjf.3
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 07:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z+Z7xBwuEdiDo3yfPlLotr1uBNzHqi96x2Qr+oepBsg=;
        b=22j8DgYNRhC00uD/t5NzU582DDp0TeZDzIrUD1vGUJP+buHsS4Wl2zs0sJDnuKtMZM
         0RyGAs9nqjt3Dbg08V65xH2SaH2M1zPQmwqjjAnf9XDDtU/VK5JihbmRhTzIl1xVtubj
         P4M4bdBG8Fwk/bkknT7a1/4cncO0izssVrGw3M+oo3Bj4/oBRDzoAGeWAqohB476Lq5N
         d+JDoJtjNzeV/lnlK9fc6hB5aojZQ9n3ECn2VdAGwwKDCmgN4JQqDjeSxsijRk5QpSuf
         B4YMiW8PTC5adr8WbXbEi6Pl3UVvZz2G0FfLhxpLFyqMkjuRZeq10dd/PxM/yDRHsuUu
         6/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z+Z7xBwuEdiDo3yfPlLotr1uBNzHqi96x2Qr+oepBsg=;
        b=1wI5eek9Dj9fUMmSMawg/BpEfdSUP3GIFmtQEcWlwP3S+MlBw1+rqHnqbRmEgkRrbm
         7WWEF+EXxEZUpkF2fbp0+JI2Gi664dx6FCsYkcdN4+bV0trcOI/6WbfOc5KQXSXU92pF
         7IPSEVJ1C1h+uPSzLPhWVFfgNX3AMQizaFRT1yCv3HtNDwfHpc8iv0BK2PaQIs/GJEHw
         0uvAUz514MkAt/GRAlRdcwwK0sjXnb6yn9F1wJBnkHhrRgggaOr1bPiOOpub8/6O1Pry
         7rL0LF39+DwGrKuitA0dlgt414iny/ZA9+HYHjwZ/ZO6MeEHl4qZB4HriHAv4u591dGU
         VvnA==
X-Gm-Message-State: AOAM5338ALXrql/IhoJP9rBS5x+FnNFzOm/FxgTDAoehos1COZc1YQwH
        kmdb7Z3FOPU2hgOKC75JOLZz/dzIuajH
X-Google-Smtp-Source: ABdhPJy6TY80ypFa1FsBAsensvZvnVf0khk4LzYsG9f8LfU6Fg3VXfA30SCyYasasYzhyUMmEmeu1Q==
X-Received: by 2002:a17:902:bf07:b0:138:e32d:9f2e with SMTP id bi7-20020a170902bf0700b00138e32d9f2emr22470151plb.59.1635259469930;
        Tue, 26 Oct 2021 07:44:29 -0700 (PDT)
Received: from localhost ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id on13sm1323889pjb.23.2021.10.26.07.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 07:42:58 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     axboe@kernel.dk, hch@lst.de, josef@toxicpanda.com, mst@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, kwolf@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 2/4] nbd: Use blk_validate_block_size() to validate block size
Date:   Tue, 26 Oct 2021 22:40:13 +0800
Message-Id: <20211026144015.188-3-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211026144015.188-1-xieyongji@bytedance.com>
References: <20211026144015.188-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the block layer helper to validate block size instead
of open coding it.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/block/nbd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 1183f7872b71..3f58c3eb38b6 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -323,7 +323,8 @@ static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 {
 	if (!blksize)
 		blksize = 1u << NBD_DEF_BLKSIZE_BITS;
-	if (blksize < 512 || blksize > PAGE_SIZE || !is_power_of_2(blksize))
+
+	if (blk_validate_block_size(blksize))
 		return -EINVAL;
 
 	nbd->config->bytesize = bytesize;
-- 
2.11.0

