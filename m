Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B17C433EF
	for <linux-block@archiver.kernel.org>; Fri,  8 Apr 2022 23:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbiDHXtR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Apr 2022 19:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236531AbiDHXtP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Apr 2022 19:49:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D561CFCC
        for <linux-block@vger.kernel.org>; Fri,  8 Apr 2022 16:47:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t190-20020a25c3c7000000b006410799ab3dso2411604ybf.21
        for <linux-block@vger.kernel.org>; Fri, 08 Apr 2022 16:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Sr/qRaqa5z0r+uAXDRErpJZ7x7X8TiNzZy9nkvxB+Zo=;
        b=j093d4HglnRuHm30WYjo+4bJfNhh8R69tSuGD8sG2vVCGmZLtmPNULApd085mM1rRp
         PtrfZIA0w/UrHLyEHZI8p6RExsXeXpJ2ertTmmlbxqdPfVA6CKOlNWQbO/VR8Deuex6i
         IlzuXGJqwlKqLIW+SJcxEvFb7MMgZnD86nwsNYN+BetBxTlMAoalaykCtrxCSLUeUggx
         3kiLXg5Bdzf2/jshqvd6p+aHtKglXlrfIu0aD9BU6vP0uAZxtHeuI/Cn56ZlrX9DKOB8
         CKVwq4mU9ItDow5/lGb5h+igr1uhcI/c5eDd01UyPylqJ5MugYxRTm3Ns0RnTDCfo4kG
         wM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Sr/qRaqa5z0r+uAXDRErpJZ7x7X8TiNzZy9nkvxB+Zo=;
        b=AmM+JW0Eh8H7rsNkgjzTPiWxz112h0Zmgr3umjg5Lq2APx2qVUkyVP3antpnaPW0W4
         tJtXOZV9FrOORwFbKSISBvezV7VAY1LWNYH9cGH/qjLjl2iJoARPv2IvW6llCKwJ0+n3
         gqh44Y4DYRCrEBjQI/OoPhTgP0L5MJfcRzaGe2jrB2kmPuGOsSHXvgtCz3iAUcFqyw/O
         cHPFUWpzmbg9H/zg7zHc9+TO025SVnQlV5Cr+OGQDMX8DEce3M13Z19YzTQZtTDEiXPS
         FxXmfMpaeWKnHg4ogAJew9II5gawuRzKrKDWML2tcXdWO5CivbuI6o5ny3YdTqY7lT0a
         RsGA==
X-Gm-Message-State: AOAM530J8RJjUviEl/LpSHmOPO6B3Pqge6kOY2xsJ3ixBIHlaBf8/51I
        torWjmnDPBqaAQcKpSo0MPCbG8QOVEc=
X-Google-Smtp-Source: ABdhPJwHsnREaTd9LqMnQLGsxcwdglz8LsVSd8sjRZeQ7YvvH6hrJ73som0gxiDhjaauIi1oCS+8yi9KIqA=
X-Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2cd:202:102:a6b5:8282:fe01])
 (user=khazhy job=sendgmr) by 2002:a81:7357:0:b0:2e5:f8d1:eb92 with SMTP id
 o84-20020a817357000000b002e5f8d1eb92mr17753632ywc.461.1649461630297; Fri, 08
 Apr 2022 16:47:10 -0700 (PDT)
Date:   Fri,  8 Apr 2022 16:47:07 -0700
Message-Id: <20220408234707.2562835-1-khazhy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH] block/compat_ioctl: fix range check in BLKGETSIZE
From:   Khazhismel Kumykov <khazhy@google.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

kernel ulong and compat_ulong_t may not be same width. Use type directly
to eliminate mismatches.

This would result in truncation rather than EFBIG for 32bit mode for
large disks.

Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 block/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Noticed this one was sitting in my "not landed yet" pile, third time's
the charm? :)

diff --git a/block/ioctl.c b/block/ioctl.c
index 4a86340133e4..959e93a90b29 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -629,7 +629,7 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 		return compat_put_long(argp,
 			(bdev->bd_disk->bdi->ra_pages * PAGE_SIZE) / 512);
 	case BLKGETSIZE:
-		if (bdev_nr_sectors(bdev) > ~0UL)
+		if (bdev_nr_sectors(bdev) > ~((compat_ulong_t)0UL))
 			return -EFBIG;
 		return compat_put_ulong(argp, bdev_nr_sectors(bdev));
 
-- 
2.35.1.1178.g4f1659d476-goog

