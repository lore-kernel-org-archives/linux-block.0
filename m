Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46680 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752780AbeCOPI3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 11:08:29 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 08/16] bcache: Fix a compiler warning in bcache_device_init()
Date: Thu, 15 Mar 2018 08:08:06 -0700
Message-Id: <20180315150814.9412-9-bart.vanassche@wdc.com>
In-Reply-To: <20180315150814.9412-1-bart.vanassche@wdc.com>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Avoid that building with W=1 triggers the following compiler warning:

drivers/md/bcache/super.c:776:20: warning: comparison is always false due to limited range of data type [-Wtype-limits]
      d->nr_stripes > SIZE_MAX / sizeof(atomic_t)) {
                    ^

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 drivers/md/bcache/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index e8dfa804bd98..87c1f853bbb3 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -769,6 +769,8 @@ static int bcache_device_init(struct bcache_device *d, unsigned block_size,
 			      sector_t sectors)
 {
 	struct request_queue *q;
+	const size_t max_stripes = min_t(size_t, INT_MAX,
+					 SIZE_MAX / sizeof(atomic_t));
 	size_t n;
 	int idx;
 
@@ -777,9 +779,7 @@ static int bcache_device_init(struct bcache_device *d, unsigned block_size,
 
 	d->nr_stripes = DIV_ROUND_UP_ULL(sectors, d->stripe_size);
 
-	if (!d->nr_stripes ||
-	    d->nr_stripes > INT_MAX ||
-	    d->nr_stripes > SIZE_MAX / sizeof(atomic_t)) {
+	if (!d->nr_stripes || d->nr_stripes > max_stripes) {
 		pr_err("nr_stripes too large or invalid: %u (start sector beyond end of disk?)",
 			(unsigned)d->nr_stripes);
 		return -ENOMEM;
-- 
2.16.2
