Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C950DC27C7A
	for <linux-block@archiver.kernel.org>; Thu, 17 Aug 2023 07:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348552AbjHQHjl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Aug 2023 03:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbjHQHjV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Aug 2023 03:39:21 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A762D68
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2023 00:39:19 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bc3d94d40fso62020695ad.3
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2023 00:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1692257959; x=1692862759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GP/YjygoFF08lKY29w0+zEUUxywWJPtXcSkEiYxVUq0=;
        b=1iTAFWfpmZga4r+G95k2++vHmVPcxtc/WjH8bBREx7ocOQJ5xjgyIPZBZIwXQh6MJY
         8DkK9RWSKdSiRgMd4vYP8Xw0YYX6vHUqrvcG37SkDAA1cVvua1qLtCDM0k/YyBfNPDX4
         GrBzDa43/qLtm1LNKgWLm2ycGAm3lB9btBNogGZyPESsxjhgkW08t6cZ93Iic9LwZZZR
         yHV2rLDVyFwXOADKgL4zQwbVugJPm8S2iXzHknJNm6ryOX5SRFZoaoPpqj9Y36UCrCj7
         QzHgfcsiTJweW47/V4e0UDyLTRHCm6xVEZ673mP0x12DecE59dKZXJ6Hub3y8RczcxDg
         20Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692257959; x=1692862759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GP/YjygoFF08lKY29w0+zEUUxywWJPtXcSkEiYxVUq0=;
        b=S6brlmthHfD208oJ3XbVNBN1BdDKCK9uuG4/speEUfHHsJb4gY1ObVaa1aJqry5Boi
         iN8xMw55dl+TvozHjNMSfRDbBFLZ84w55t9xcdz7OGL8qeXnXngyOd2nCIMf2rlK45p4
         +HaVg+MuRNyVetQc/HecL2apHUr9SdjTaZC3V5snhxCUUuxoL6AxqqNejQrByOAphQhY
         DV7WtRAWlYhBKYxOQDwo7JMrJtagdvOep++3d27MHYVxgUVl0lLFYCI5NlgnXF1yFa5A
         QEucxrMnNDWOpzePHDMRViTpbgfBHm+XM8RoA6IhzmmZ1vUGAm4m8I4bZXj4woVBgGXz
         dDwQ==
X-Gm-Message-State: AOJu0YwNwFQiKsvv42DUHBn7ODO6xzOPb1ErGD+Gbb1yw4ukOrrjtpvj
        0TSb8TUiwlzyaxLmwVs7clAgfA==
X-Google-Smtp-Source: AGHT+IGnGG8VxrVBoOvaKAHseq+oyFKkMBN41lyy/3WqKack98k/JMdJUSR63V3APa6SSIFqmLfT+A==
X-Received: by 2002:a17:903:1251:b0:1b8:66f6:87a3 with SMTP id u17-20020a170903125100b001b866f687a3mr5336702plh.52.1692257958866;
        Thu, 17 Aug 2023 00:39:18 -0700 (PDT)
Received: from 64217.gitgo.cc ([47.75.78.161])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902ec8200b001bba669a7eesm14503188plg.52.2023.08.17.00.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 00:39:18 -0700 (PDT)
From:   Li Feng <fengli@smartx.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list)
Cc:     lifeng1519@gmail.com, Li Feng <fengli@smartx.com>
Subject: [PATCH] block: fix unexpected split in bio_discard_limit
Date:   Thu, 17 Aug 2023 15:55:06 +0800
Message-ID: <20230817075509.1438569-1-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_discard_limit() enforces discard boundaries within the range of 32-bit
unsigned integers, resulting in unexpected discard cut boundaries.

For example, max discard size = 1MiB, discard_granularity = 512B, then the
discard lengths sent in the range [0,4G) are 1MiB, 1MiB... (1MiB-512).
The next discard offset from 4G is [4G-512, 4G-512+1MiB).
The discard of the 4G offset boundary does not comply with the optimal 1MiB
size.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 block/blk-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index e59c3069e835..ec95508c3593 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -32,7 +32,7 @@ static sector_t bio_discard_limit(struct block_device *bdev, sector_t sector)
 	 * Align the bio size to the discard granularity to make splitting the bio
 	 * at discard granularity boundaries easier in the driver if needed.
 	 */
-	return round_down(UINT_MAX, discard_granularity) >> SECTOR_SHIFT;
+	return round_down(ULONG_MAX, discard_granularity) >> SECTOR_SHIFT;
 }
 
 int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
-- 
2.41.0

