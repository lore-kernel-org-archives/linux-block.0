Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:34975 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbdFGDgV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Jun 2017 23:36:21 -0400
Received: by mail-ot0-f195.google.com with SMTP id t31so116234ota.2
        for <linux-block@vger.kernel.org>; Tue, 06 Jun 2017 20:36:21 -0700 (PDT)
From: Joseph Qi <jiangqi903@gmail.com>
Subject: [PATCH] blk-throttle: fix NULL pointer dereference in
 throtl_schedule_pending_timer
To: linux-block@vger.kernel.org
Cc: axboe@fb.com, Shaohua Li <shli@fb.com>, boyu.mt@taobao.com,
        wenqing.lz@taobao.com, qijiang.qj@alibaba-inc.com
Message-ID: <ba25ffe3-9db7-2311-51c7-91fce0ce8cfa@gmail.com>
Date: Wed, 7 Jun 2017 11:36:14 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Joseph Qi <qijiang.qj@alibaba-inc.com>

I have encountered a NULL pointer dereference in
throtl_schedule_pending_timer:
  [  413.735396] BUG: unable to handle kernel NULL pointer dereference at 0000000000000038
  [  413.735535] IP: [<ffffffff812ebbbf>] throtl_schedule_pending_timer+0x3f/0x210
  [  413.735643] PGD 22c8cf067 PUD 22cb34067 PMD 0
  [  413.735713] Oops: 0000 [#1] SMP
  ......

This is caused by the following case:
  blk_throtl_bio
    throtl_schedule_next_dispatch  <= sq is top level one without parent
      throtl_schedule_pending_timer
        sq_to_tg(sq)->td->throtl_slice  <= sq_to_tg(sq) returns NULL

Fix it by using sq_to_td instead of sq_to_tg(sq)->td, which will always
return a valid td.

Fixes: 297e3d854784 ("blk-throttle: make throtl_slice tunable")
Signed-off-by: Joseph Qi <qijiang.qj@alibaba-inc.com>
---
 block/blk-throttle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index fc13dd0..3b751f7 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -698,7 +698,7 @@ static void throtl_dequeue_tg(struct throtl_grp *tg)
 static void throtl_schedule_pending_timer(struct throtl_service_queue *sq,
 					  unsigned long expires)
 {
-	unsigned long max_expire = jiffies + 8 * sq_to_tg(sq)->td->throtl_slice;
+	unsigned long max_expire = jiffies + 8 * sq_to_td(sq)->throtl_slice;
 
 	/*
 	 * Since we are adjusting the throttle limit dynamically, the sleep
-- 
1.9.4
