Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35998 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755684AbdIGSkT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Sep 2017 14:40:19 -0400
Received: by mail-pf0-f179.google.com with SMTP id e199so790839pfh.3
        for <linux-block@vger.kernel.org>; Thu, 07 Sep 2017 11:40:19 -0700 (PDT)
Date: Thu, 7 Sep 2017 11:40:17 -0700
From: Omar Sandoval <osandov@osandov.com>
To: =?utf-8?B?5p+l5paM?= <zhabinecho@gmail.com>
Cc: linux-block@vger.kernel.org, osandov@fb.com, axboe@fb.com,
        boyu.mt@taobao.com, wenqing.lz@taobao.com,
        qijiang.qj@alibaba-inc.com
Subject: Re: [PATCH]blk-mq-sched: remove the empty entry in token wait list
Message-ID: <20170907184017.GC17057@vader.DHCP.thefacebook.com>
References: <CAPr6Aj9n6z0Cw_QoaSL1vYQnMSU9VnMQi6SPwnMdYTYubzH6mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAPr6Aj9n6z0Cw_QoaSL1vYQnMSU9VnMQi6SPwnMdYTYubzH6mg@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Aug 29, 2017 at 10:52:13PM +0800, 查斌 wrote:
> From:  Bin Zha <zhabin.zb@alibaba-inc.com>
> 
> 
> When the kyber adjusts the sync and other write depth to the
> minimum(1), there is a case that maybe cause the requests to
> be stalled in the kyber_hctx_data list.
> 
> The following example I have tested:
> 
> 
> CPU7
> block_rq_insert
> add_wait_queue
> __sbitmap_queue_get              CPU23
> block_rq_issue                   block_rq_insert
> block_rq_complete ------>  waiting token free
>                                           block_rq_issue
>           /|\                            block_rq_complete
>            |                                        |
>            |                                        |
>            |                                       \|/
>            |                                     CPU29
>            |                            block_rq_insert
>            |                           waiting token free
>            |                             block_rq_issue
>            |---------------------- block_rq_complete
> 
>                                                 CPU1
>                                        block_rq_insert
>                                       waiting token free
> 
> 
> The IO request complete in CPU29 will wake up CPU7,
> because it has been added to the waitqueue in
> kyber_get_domain_token. But it is empty waiter, and won't
> wake up the CPU1.If no other requests issue to push it,
> the requests will stall in kyber_hctx_data list.
> 
> 
> Signed-off-by: Bin Zha <zhabin.zb@alibaba-inc.com>
> 
> diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
> index b9faabc..584bfd5 100644
> --- a/block/kyber-iosched.c
> +++ b/block/kyber-iosched.c
> @@ -548,6 +548,10 @@ static int kyber_get_domain_token(struct
> kyber_queue_data *kqd,
>                  * queue.
>                  */
>                 nr = __sbitmap_queue_get(domain_tokens);
> +               if (nr >= 0) {
> +                       remove_wait_queue(&ws->wait, wait);
> +                       INIT_LIST_HEAD(&wait->task_list);
> +               }
>         }
>         return nr;
>  }

Hm... I could've sworn I thought about this case when I wrote this code,
but your analysis looks correct. I do remember that I didn't do this
because I was worried about a race like so:

add_wait_queue()
                        kyber_domain_wake()
			\_ list_del_init()
remove_wait_queue()
\_ list_del()

But thinking about it some more, list_del() is probably safe after
list_del_init()?

Have you been able to reproduce this? I have the following patch to
force the domain token pools to one token, I imagine with the right
workload we can hit it:

diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index f58cab8..b4e1bd7 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -58,9 +58,9 @@ enum {
  * So, we cap these to a reasonable value.
  */
 static const unsigned int kyber_depth[] = {
-       [KYBER_READ] = 256,
-       [KYBER_SYNC_WRITE] = 128,
-       [KYBER_OTHER] = 64,
+       [KYBER_READ] = 1,
+       [KYBER_SYNC_WRITE] = 1,
+       [KYBER_OTHER] = 1,
 };

 /*
@@ -126,6 +126,7 @@ enum {
 #define IS_GOOD(status) ((status) > 0)
 #define IS_BAD(status) ((status) < 0)

+#if 0
 static int kyber_lat_status(struct blk_stat_callback *cb,
                            unsigned int sched_domain, u64 target)
 {
@@ -243,6 +244,7 @@ static void kyber_adjust_other_depth(struct kyber_queue_data *kqd,
        if (depth != orig_depth)
                sbitmap_queue_resize(&kqd->domain_tokens[KYBER_OTHER], depth);
 }
+#endif

 /*
  * Apply heuristics for limiting queue depths based on gathered latency
@@ -250,6 +252,8 @@ static void kyber_adjust_other_depth(struct kyber_queue_data *kqd,
  */
 static void kyber_stat_timer_fn(struct blk_stat_callback *cb)
 {
+       return;
+#if 0
        struct kyber_queue_data *kqd = cb->data;
        int read_status, write_status;

@@ -269,6 +273,7 @@ static void kyber_stat_timer_fn(struct blk_stat_callback *cb)
            ((IS_BAD(read_status) || IS_BAD(write_status) ||
              kqd->domain_tokens[KYBER_OTHER].sb.depth < kyber_depth[KYBER_OTHER])))
                blk_stat_activate_msecs(kqd->cb, 100);
+#endif
 }

 static unsigned int kyber_sched_tags_shift(struct kyber_queue_data *kqd)
