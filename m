Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45999 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbeHYNZ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Aug 2018 09:25:29 -0400
MIME-Version: 1.0
From: Junhui Tang <tang.junhui.linux@gmail.com>
Date: Sat, 25 Aug 2018 17:48:04 +0800
Message-ID: <CA+NNRhF8-M4S-hby3MJn=i-+7f=giRb9FaK9gwsYLy08wnS_xQ@mail.gmail.com>
Subject: [PATCH] bcache: fix miss key refill->end in writeback
To: colyli@suse.de
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>From 5562f3868115ba5f6d4242750e02bb4c179c5274 Mon Sep 17 00:00:00 2001
From: Tang Junhui <tang.junhui.linux@gmail.com>
Date: Sun, 26 Aug 2018 01:28:35 +0800
Subject: [PATCH] bcache: fix miss key refill->end in writeback

Signed-off-by: Tang Junhui <tang.junhui.linux@gmail.com>
refill->end record the last key of writeback,
for example, at the first time, keys (1,128K) to (1,1024K)
are flush to the backend device, but the end key (1,1024K)
is not included, since the bellow code:
if (bkey_cmp(k, refill->end) >= 0) {
ret = MAP_DONE;
goto out;
}
And in the next time when we refill writeback keybuf again,
we searched key start from (1,1024K), and got a key bigger
than it, so the key (1,1024K) missed.
This patch modify the above code, and let the end key to
be included to the writeback key buffer.
---
 drivers/md/bcache/btree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 079ae18..2b5df26 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -2363,7 +2363,7 @@ static int refill_keybuf_fn(struct btree_op *op,
struct btree *b,
  struct keybuf *buf = refill->buf;
  int ret = MAP_CONTINUE;

- if (bkey_cmp(k, refill->end) >= 0) {
+ if (bkey_cmp(k, refill->end) > 0) {
  ret = MAP_DONE;
  goto out;
  }
-- 
1.8.3.1
