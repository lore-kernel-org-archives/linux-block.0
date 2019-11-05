Return-Path: <SRS0=uUnX=Y5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B84C5DF60
	for <linux-block@archiver.kernel.org>; Tue,  5 Nov 2019 18:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06436214D8
	for <linux-block@archiver.kernel.org>; Tue,  5 Nov 2019 18:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vPxN2a9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390668AbfKES2i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Nov 2019 13:28:38 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:34056 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389724AbfKES2i (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Nov 2019 13:28:38 -0500
Received: by mail-qt1-f202.google.com with SMTP id u26so23331169qtq.1
        for <linux-block@vger.kernel.org>; Tue, 05 Nov 2019 10:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=wgxjvwX6+cnB3A8RMM5lxB/OlF4KhSWsamiPqNj2U6w=;
        b=vPxN2a9eb5x/Kf9/TWrUXR40il0raZDiN6LYAMVyDiDfjpf7s9xXS6bjE5/awxsuoy
         0q1m5Zb8UvHXS6AiO3q0DRqBZT21rMVwU80N064o5cR+O0LTltXWOTW6KWnDg6PzLmHb
         9M1FDkcKNGd4va1a96WGR8KkuNh54njhXe7jlzCokkcBEA+WXz3ori13j//Kq+ltDpEN
         seY173tKGH4fj+4kOxr/zl/3VnAdEcGpqai8VOCJLmWbOUj4Y1MH2s/elBVlj92QhMKX
         CRGRDyk5VgA1XMd5XFM8hjSqA1lFfraXvc5TeTIXEEbBNjacO726/dEGWgneMJa9+qcG
         1vGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=wgxjvwX6+cnB3A8RMM5lxB/OlF4KhSWsamiPqNj2U6w=;
        b=ShSDxFh+gNjnWxmw0tXTZ9D1K9D4oqjzWuLcGKFUD6vpH457Qd9HnhN+OfEAX3GVGI
         OtVYSUDv+QaGs1cBw74oSF5aYlBG0dntQonlddAOjTJHF6oAd7I8yk3M9q4JdWJKYbfl
         RKgym0au+7Zr7TLSYBwHFoeYwEIMkS7qwqQ3Kgu6XtqTtyNiTRd08WETWExMxXeBCZeb
         S7/CuZbGrdXPIKOnnHmAt9tvNEV0XgArxPIMjW7apRsZl0nmWAPUu4VJZQR8a+mz7chp
         KeyFMbAhOODS0iQEbRCg3MQRh7+Uae3UNBWAl5p+JoectLRBMW2HCzy8F9Vu4uPcGeSN
         5PrA==
X-Gm-Message-State: APjAAAVALHTdIG9ivpJgrBImb/NJNKKOjUSCHUmpMjM0WBOAAMqjDrIp
        r6tirLvAE8j9Ah16aL2bgkk/pD67gg==
X-Google-Smtp-Source: APXvYqzTpHCaI8bTtovq6RT1gOrzAFSaWFSHvNTuvzdVkIjREWwMwBmhqgfZhpxg2SpG0OZOyHCv1UTJ7g==
X-Received: by 2002:a37:9d44:: with SMTP id g65mr27690527qke.302.1572978515493;
 Tue, 05 Nov 2019 10:28:35 -0800 (PST)
Date:   Tue,  5 Nov 2019 19:27:47 +0100
Message-Id: <20191105182746.217864-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH] blk-wbt: Fix data race and avoid possible false sharing
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+ba8947364367f96fe16b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pattern here is to avoid possible false sharing. However, due to
compiler optimizations the code may simply collapse to the write if we
omit READ_ONCE/WRITE_ONCE:
https://github.com/google/ktsan/wiki/READ_ONCE-and-WRITE_ONCE#it-may-improve-performance

==================================================================
BUG: KCSAN: data-race in wbt_wait / wbt_wait

read to 0xffff88821aa6d140 of 8 bytes by task 10372 on cpu 1:
 wb_timestamp block/blk-wbt.c:88 [inline]
 wb_timestamp block/blk-wbt.c:83 [inline]
 wbt_wait+0x1f9/0x250 block/blk-wbt.c:587
 __rq_qos_throttle+0x47/0x70 block/blk-rq-qos.c:72
 rq_qos_throttle block/blk-rq-qos.h:185 [inline]
 blk_mq_make_request+0x29c/0xf60 block/blk-mq.c:1971
 generic_make_request block/blk-core.c:1064 [inline]
 generic_make_request+0x196/0x740 block/blk-core.c:1006
 submit_bio+0x96/0x3c0 block/blk-core.c:1190
 submit_bh_wbc+0x40f/0x460 fs/buffer.c:3095
 submit_bh fs/buffer.c:3101 [inline]
 __bread_slow fs/buffer.c:1177 [inline]
 __bread_gfp+0xe7/0x1e0 fs/buffer.c:1359
 sb_bread include/linux/buffer_head.h:307 [inline]
 fat__get_entry+0x35e/0x4f0 fs/fat/dir.c:100
 fat_get_entry fs/fat/dir.c:128 [inline]
 fat_get_short_entry+0x103/0x200 fs/fat/dir.c:877
 fat_subdirs+0x6b/0x110 fs/fat/dir.c:943
 fat_read_root fs/fat/inode.c:1416 [inline]
 fat_fill_super+0x1552/0x1f50 fs/fat/inode.c:1862
 vfat_fill_super+0x3b/0x50 fs/fat/namei_vfat.c:1050
 mount_bdev+0x262/0x2d0 fs/super.c:1415
 vfat_mount+0x3e/0x60 fs/fat/namei_vfat.c:1057

write to 0xffff88821aa6d140 of 8 bytes by task 10375 on cpu 0:
 wb_timestamp block/blk-wbt.c:89 [inline]
 wb_timestamp block/blk-wbt.c:83 [inline]
 wbt_wait+0x21e/0x250 block/blk-wbt.c:587
 __rq_qos_throttle+0x47/0x70 block/blk-rq-qos.c:72
 rq_qos_throttle block/blk-rq-qos.h:185 [inline]
 blk_mq_make_request+0x29c/0xf60 block/blk-mq.c:1971
 generic_make_request block/blk-core.c:1064 [inline]
 generic_make_request+0x196/0x740 block/blk-core.c:1006
 submit_bio+0x96/0x3c0 block/blk-core.c:1190
 mpage_bio_submit fs/mpage.c:66 [inline]
 mpage_readpages+0x36c/0x3c0 fs/mpage.c:410
 blkdev_readpages+0x36/0x50 fs/block_dev.c:620
 read_pages+0xa2/0x2d0 mm/readahead.c:126
 __do_page_cache_readahead+0x353/0x390 mm/readahead.c:212
 force_page_cache_readahead+0x13a/0x1f0 mm/readahead.c:243
 page_cache_sync_readahead+0x1cf/0x1e0 mm/readahead.c:522
 generic_file_buffered_read mm/filemap.c:2050 [inline]
 generic_file_read_iter+0xeb6/0x1440 mm/filemap.c:2323
 blkdev_read_iter+0xb2/0xe0 fs/block_dev.c:2010

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 10375 Comm: blkid Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
==================================================================

Reported-by: syzbot+ba8947364367f96fe16b@syzkaller.appspotmail.com
Signed-off-by: Marco Elver <elver@google.com>
---
 block/blk-wbt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 8641ba9793c5..ce281a9007a6 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -85,8 +85,8 @@ static void wb_timestamp(struct rq_wb *rwb, unsigned long *var)
 	if (rwb_enabled(rwb)) {
 		const unsigned long cur = jiffies;
 
-		if (cur != *var)
-			*var = cur;
+		if (cur != READ_ONCE(*var))
+			WRITE_ONCE(*var, cur);
 	}
 }
 
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

