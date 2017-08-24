Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:38808 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbdHXHDz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2017 03:03:55 -0400
Received: by mail-pg0-f46.google.com with SMTP id m133so12451729pga.5
        for <linux-block@vger.kernel.org>; Thu, 24 Aug 2017 00:03:54 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Hannes Reinecke <hare@suse.de>,
        Ming Lei <ming.lei@redhat.com>, Karel Zak <kzak@redhat.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: [PATCH 2/4] loop: set physical block size to PAGE_SIZE
Date: Thu, 24 Aug 2017 00:03:42 -0700
Message-Id: <378ae3760bd37441fd60a5188eae75f39babb6aa.1503558155.git.osandov@fb.com>
In-Reply-To: <cover.1503558155.git.osandov@fb.com>
References: <cover.1503558155.git.osandov@fb.com>
In-Reply-To: <cover.1503558155.git.osandov@fb.com>
References: <cover.1503558155.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The physical block size is "the lowest possible sector size that the
hardware can operate on without reverting to read-modify-write
operations" (from the comment on blk_queue_physical_block_size()). Since
loop does buffered I/O on the backing file by default, the RMW unit is a
page. This isn't the case for direct I/O mode, but let's keep it simple.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/loop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 54e091887199..1a5b4ecf54ec 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1764,6 +1764,8 @@ static int loop_add(struct loop_device **l, int i)
 	}
 	lo->lo_queue->queuedata = lo;
 
+	blk_queue_physical_block_size(lo->lo_queue, PAGE_SIZE);
+
 	/*
 	 * It doesn't make sense to enable merge because the I/O
 	 * submitted to backing file is handled page by page.
-- 
2.14.1
