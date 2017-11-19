Return-Path: <axboe@kernel.dk>
Subject: Re: possible deadlock in blk_trace_remove
To: syzbot
 <bot+583353673e394aa41e5fb68ddc8b8d9d5c8d576f@syzkaller.appspotmail.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
 rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
References: <001a1141f8dc4440a9055e53896e@google.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4d09f529-7cf9-7267-7dcb-122ecc957e7d@kernel.dk>
Date: Sun, 19 Nov 2017 11:50:20 -0700
MIME-Version: 1.0
In-Reply-To: <001a1141f8dc4440a9055e53896e@google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/19/2017 03:36 AM, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on  
> d9e0e63d9a6f88440eb201e1491fcf730272c706
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> 
> Unfortunately, I don't have any reproducer for this bug yet.> 
> 
> Use struct sctp_sack_info instead
> 
> ============================================
> WARNING: possible recursive locking detected
> 4.14.0-rc8-next-20171110+ #40 Not tainted
> --------------------------------------------
> syz-executor6/21462 is trying to acquire lock:
>   (&q->blk_trace_mutex){+.+.}, at: [<ffffffff81760261>]  
> blk_trace_remove+0x21/0x40 kernel/trace/blktrace.c:373
> 
> but task is already holding lock:
>   (&q->blk_trace_mutex){+.+.}, at: [<ffffffff81763b38>]  
> blk_trace_setup+0x38/0x70 kernel/trace/blktrace.c:606
> 
> other info that might help us debug this:
>   Possible unsafe locking scenario:
> 
>         CPU0
>         ----
>    lock(&q->blk_trace_mutex);
>    lock(&q->blk_trace_mutex);

The below should fix it.


diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 206e0e2ace53..f224985de5fa 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -591,7 +591,7 @@ static int __blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 		return ret;
 
 	if (copy_to_user(arg, &buts, sizeof(buts))) {
-		blk_trace_remove(q);
+		__blk_trace_remove(q);
 		return -EFAULT;
 	}
 	return 0;
@@ -637,7 +637,7 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
 		return ret;
 
 	if (copy_to_user(arg, &buts.name, ARRAY_SIZE(buts.name))) {
-		blk_trace_remove(q);
+		__blk_trace_remove(q);
 		return -EFAULT;
 	}
 
 
-- 
Jens Axboe
