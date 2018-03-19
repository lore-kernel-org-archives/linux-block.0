Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45175 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754841AbeCSAhE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Mar 2018 20:37:04 -0400
Received: by mail-pf0-f193.google.com with SMTP id l27so1841333pfk.12
        for <linux-block@vger.kernel.org>; Sun, 18 Mar 2018 17:37:04 -0700 (PDT)
From: Michael Lyle <mlyle@lyle.org>
To: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Cc: axboe@fb.com, Bart Van Assche <bart.vanassche@wdc.com>
Subject: [for-4.17 20/20] bcache: Fix a compiler warning in bcache_device_init()
Date: Sun, 18 Mar 2018 17:36:33 -0700
Message-Id: <20180319003633.27225-21-mlyle@lyle.org>
In-Reply-To: <20180319003633.27225-1-mlyle@lyle.org>
References: <20180319003633.27225-1-mlyle@lyle.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Bart Van Assche <bart.vanassche@wdc.com>

Avoid that building with W=1 triggers the following compiler warning:

drivers/md/bcache/super.c:776:20: warning: comparison is always false due to limited range of data type [-Wtype-limits]
      d->nr_stripes > SIZE_MAX / sizeof(atomic_t)) {
                    ^

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
---
 drivers/md/bcache/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 640ff8072ed8..d90d9e59ca00 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -778,6 +778,8 @@ static int bcache_device_init(struct bcache_device *d, unsigned block_size,
 			      sector_t sectors)
 {
 	struct request_queue *q;
+	const size_t max_stripes = min_t(size_t, INT_MAX,
+					 SIZE_MAX / sizeof(atomic_t));
 	size_t n;
 	int idx;
 
@@ -786,9 +788,7 @@ static int bcache_device_init(struct bcache_device *d, unsigned block_size,
 
 	d->nr_stripes = DIV_ROUND_UP_ULL(sectors, d->stripe_size);
 
-	if (!d->nr_stripes ||
-	    d->nr_stripes > INT_MAX ||
-	    d->nr_stripes > SIZE_MAX / sizeof(atomic_t)) {
+	if (!d->nr_stripes || d->nr_stripes > max_stripes) {
 		pr_err("nr_stripes too large or invalid: %u (start sector beyond end of disk?)",
 			(unsigned)d->nr_stripes);
 		return -ENOMEM;
-- 
2.14.1
