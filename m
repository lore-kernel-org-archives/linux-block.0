Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34673 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbdH2OwP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Aug 2017 10:52:15 -0400
Received: by mail-wr0-f195.google.com with SMTP id z91so2459743wrc.1
        for <linux-block@vger.kernel.org>; Tue, 29 Aug 2017 07:52:14 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?5p+l5paM?= <zhabinecho@gmail.com>
Date: Tue, 29 Aug 2017 22:52:13 +0800
Message-ID: <CAPr6Aj9n6z0Cw_QoaSL1vYQnMSU9VnMQi6SPwnMdYTYubzH6mg@mail.gmail.com>
Subject: [PATCH]blk-mq-sched: remove the empty entry in token wait list
To: linux-block@vger.kernel.org
Cc: osandov@fb.com, axboe@fb.com, boyu.mt@taobao.com,
        wenqing.lz@taobao.com, qijiang.qj@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From:  Bin Zha <zhabin.zb@alibaba-inc.com>


When the kyber adjusts the sync and other write depth to the
minimum(1), there is a case that maybe cause the requests to
be stalled in the kyber_hctx_data list.

The following example I have tested:


CPU7
block_rq_insert
add_wait_queue
__sbitmap_queue_get              CPU23
block_rq_issue                   block_rq_insert
block_rq_complete ------>  waiting token free
                                          block_rq_issue
          /|\                            block_rq_complete
           |                                        |
           |                                        |
           |                                       \|/
           |                                     CPU29
           |                            block_rq_insert
           |                           waiting token free
           |                             block_rq_issue
           |---------------------- block_rq_complete

                                                CPU1
                                       block_rq_insert
                                      waiting token free


The IO request complete in CPU29 will wake up CPU7,
because it has been added to the waitqueue in
kyber_get_domain_token. But it is empty waiter, and won't
wake up the CPU1.If no other requests issue to push it,
the requests will stall in kyber_hctx_data list.


Signed-off-by: Bin Zha <zhabin.zb@alibaba-inc.com>

diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index b9faabc..584bfd5 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -548,6 +548,10 @@ static int kyber_get_domain_token(struct
kyber_queue_data *kqd,
                 * queue.
                 */
                nr = __sbitmap_queue_get(domain_tokens);
+               if (nr >= 0) {
+                       remove_wait_queue(&ws->wait, wait);
+                       INIT_LIST_HEAD(&wait->task_list);
+               }
        }
        return nr;
 }
