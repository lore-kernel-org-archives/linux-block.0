Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5BAC433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AB99603E7
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbhJYJtg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 05:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbhJYJsP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 05:48:15 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B695C061220
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 02:45:53 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id l186so3926628pge.7
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 02:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z+Z7xBwuEdiDo3yfPlLotr1uBNzHqi96x2Qr+oepBsg=;
        b=15U6o0BRYIjxKzdZQ9qlzBcMsGkmDKOqIlUj4DEIpH35tgQ9ByQuIOF2gOd2SrPOVK
         WLBWo5HGkc4gYHNzfAL3QJBcdShi2dMQrpMTV1/Dt1OXzHv8GQW/HT/XNYnYIFsYIcJ0
         ayswLcHqMl8yATnLNE720OJEsvVIPJ9F1Z5Z/ogPkQyeV6QcBqUpC6PFUn6SxOFP1055
         Ywo76qs1XQZPFmCmC2G3Dm1BZUQ6ncLkF42kqH7q0K9PXJJcDQ69Jx4HqlM/IOMjkq1b
         bMFPVAOfDR3pZb/IAYh7daWLvSpY1KoLmDTnQ87l5dJHaErhupAYRbdo6TqWxo5GCmjS
         /LZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z+Z7xBwuEdiDo3yfPlLotr1uBNzHqi96x2Qr+oepBsg=;
        b=leg/rjAwiDiQA+Ab1O4tweg1Bsq0VOEJNWaobLP+OK1mT4zavliodLBTUla7Pvlvl9
         /gsg++7Pa4LQ+2uHnbc2IQxgSiO528oiYrSxDCTtA2+HzHZAymPhtcpAN8369uC1ZlGS
         C6ygDz9u6mXfVGGFy+ZFfnoITTK2A8wUY08bIvr4QBXN9wdLeH0n8D5B4xnRKWiUBbql
         zKDqgOWrpbbPgvdmHzjw/KgEe5HX9osDilc15OcK5PHkgAfqUHUS+m6sX6nXt7MhLzUP
         OQg1FNiqvgHGagUAcmowgBYqm4sLgXZJ9zXUyNBDJu5yudNOnoAd0hJ1an4totMp8Ex/
         k+jQ==
X-Gm-Message-State: AOAM531GsQtxYRh5EXWgPqwVLZ4loh1Qa+CoTaBzOhKpnAEKhkCWQk8e
        26Cg15fVYoiRXMcmgLG3eWAQ
X-Google-Smtp-Source: ABdhPJyX2r+nUzD6cxyL3ncyEb6QxB6hw/+2sEZG0Mfnx94HOreDWdGH+gtwePOJc0jGFKfTH9/gjA==
X-Received: by 2002:a63:131f:: with SMTP id i31mr12758784pgl.207.1635155152846;
        Mon, 25 Oct 2021 02:45:52 -0700 (PDT)
Received: from localhost ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id s13sm20840212pfk.175.2021.10.25.02.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 02:45:52 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     axboe@kernel.dk, hch@lst.de, josef@toxicpanda.com, mst@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, kwolf@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 2/4] nbd: Use blk_validate_block_size() to validate block size
Date:   Mon, 25 Oct 2021 17:43:04 +0800
Message-Id: <20211025094306.97-3-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025094306.97-1-xieyongji@bytedance.com>
References: <20211025094306.97-1-xieyongji@bytedance.com>
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

