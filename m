Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36178 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeIERgn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Sep 2018 13:36:43 -0400
MIME-Version: 1.0
From: Junhui Tang <tang.junhui.linux@gmail.com>
Date: Wed, 5 Sep 2018 21:06:11 +0800
Message-ID: <CA+NNRhHxU6zRfOVPxkZSLA4_75-HxQnaLAvPk+OLiHcu0ah5gw@mail.gmail.com>
Subject: [PATCH] bcache: trace missed reading by cache_missed
To: colyli@suse.de
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>From acd3853bca04799659cdb1c90675d36b6397a373 Mon Sep 17 00:00:00 2001
From: Tang Junhui <tang.junhui.linux@gmail.com>
Date: Wed, 5 Sep 2018 21:00:44 +0800
Subject: [PATCH] bcache: trace missed reading by cache_missed

Missed reading IOs are identified by s->cache_missed, not the
s->cache_miss, so in trace_bcache_read() using trace_bcache_read
to identify wether the IO is missed or not.

Signed-off-by: Tang Junhui <tang.junhui.linux@gmail.com>
---
 drivers/md/bcache/request.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 7dbe8b6..928fa99 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -845,7 +845,7 @@ static void cached_dev_read_done_bh(struct closure *cl)

  bch_mark_cache_accounting(s->iop.c, s->d,
    !s->cache_missed, s->iop.bypass);
- trace_bcache_read(s->orig_bio, !s->cache_miss, s->iop.bypass);
+ trace_bcache_read(s->orig_bio, !s->cache_missed, s->iop.bypass);

  if (s->iop.status)
  continue_at_nobarrier(cl, cached_dev_read_error, bcache_wq);
-- 
1.8.3.1
