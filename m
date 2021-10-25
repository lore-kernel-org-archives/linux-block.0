Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1739BC433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 14:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFE9960F46
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 14:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbhJYO1v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 10:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbhJYO1u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 10:27:50 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04EFC061745
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 07:25:28 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so116365pjb.3
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 07:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z+Z7xBwuEdiDo3yfPlLotr1uBNzHqi96x2Qr+oepBsg=;
        b=rTjEd60jOwJMhvhEMRHrMEBAKxeXsvtSubyuLHnKWoGE2nd+sUM8esldpNB9FZyd9K
         gRQCeEn1RXqoxkZzazCxggbQD8onZqyIrumUA0RNpRhOUM/31Q0jULpAwPnmnaHq6asM
         IVZUJ3hCMlpovO0MZnb2o/8SMBwrlqyN+NapbT63b08vlGyItYPJ66jBYCb4FrpaAIwM
         KI0zI9GdD0ZJvD3b0rU6gDthUBHTwgraXxDkHsAEkVUzeVLVTX8Bcfrgc+xsjt4mWe8P
         MXJo/mpXLJJ35X4Nl6gSqLZQonxUrJq1heeyTERlrDrxbUrkip2EDzQeaeZr52tE8j35
         fyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z+Z7xBwuEdiDo3yfPlLotr1uBNzHqi96x2Qr+oepBsg=;
        b=TvIWdkblYMLMTSOZfkOhD8LE0Y6qfN/9oDm5v4ZxhMalaCQbLH6RzaWyNO+zfKGCrC
         mcdRxDoM93tyb5rS998IVJfadhqi/OWDZ00vSyDndhA5YePyADDuLB2wtnTcoLkw4V+F
         ntGP/UDEAAuH3Q09isUtLzdGwOEv+u2gqHteo/rsIDKjECgiLQ6ClVHJKwqSEbH2uNAL
         VWM42v3lz3s+lCRNRWoEO4cDwrqdksuDqeXOj1maABu9pziHGVKUjBDHz18bIelUIzJh
         R5FnX41Co1TuiM+1M6YdRROUx69ZHyKJPiYeY8uG52OpUDeFpbB03ox0158IeC1qbIH2
         vgwQ==
X-Gm-Message-State: AOAM533C1CMPuVUveZd1VrR+KPpGovcSUAQB0epVmaF/cnPJy6/CExmk
        R/beBN7PzTjjXPfYGEKBfhoK
X-Google-Smtp-Source: ABdhPJxm/W5mKeg55PTl0JwWvTPTmH6uEA/7yKQ01Mx6oyo7yr2Rrwv5cHZuBMKhI387NKzPi54k5w==
X-Received: by 2002:a17:90a:4598:: with SMTP id v24mr21011284pjg.5.1635171928289;
        Mon, 25 Oct 2021 07:25:28 -0700 (PDT)
Received: from localhost ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id s30sm23254567pfg.17.2021.10.25.07.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:25:27 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     axboe@kernel.dk, hch@lst.de, josef@toxicpanda.com, mst@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, kwolf@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 2/4] nbd: Use blk_validate_block_size() to validate block size
Date:   Mon, 25 Oct 2021 22:25:04 +0800
Message-Id: <20211025142506.167-3-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025142506.167-1-xieyongji@bytedance.com>
References: <20211025142506.167-1-xieyongji@bytedance.com>
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

