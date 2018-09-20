Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1537463217.224533.4.camel@acm.org>
Subject: Re: [RFC PATCH 0/3] blk-mq: rework queue freeze and preempt-only
From: Bart Van Assche <bvanassche@acm.org>
To: Jianchao Wang <jianchao.w.wang@oracle.com>, axboe@kernel.dk,
 tj@kernel.org,  kent.overstreet@gmail.com, ming.lei@redhat.com,
 bart.vanassche@wdc.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 20 Sep 2018 10:06:57 -0700
In-Reply-To: <1537438703-25217-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1537438703-25217-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-09-20 at 18:18 +-0800, Jianchao Wang wrote:
+AD4 The current queue freeze depending on percpu+AF8-ref+AF8-kil/reinit has a limit that
+AD4 we have drain the requests before unfreeze the queue.
+AD4 
+AD4 Let's rework the queue freeze feature as following:
+AD4 1. introduce +AF8AXw-percpu+AF8-ref+AF8-get+AF8-many.
+AD4    It is same with original percpu+AF8-ref+AF8-get+AF8-many, but just need callers to provide
+AD4    sched rcu critical section. We will put the +AF8AXw-percpu+AF8-ref+AF8-get+AF8-many and our own
+AD4    condition checking under rcu+AF8-read+AF8-lock+AF8-sched. With this new helper interface,
+AD4    we could save an extra rcu+AF8-read+AF8-lock+AF8-sched.
+AD4 2. rework the blk+AF8-queue+AF8-enter as:
+AD4    
+AD4    rcu+AF8-read+AF8-lock+AF8-sched()
+AD4    if condition check true
+AD4      +AF8AXw-percpu+AF8-ref+AF8-get+AF8-many(+ACY-q-+AD4-q+AF8-usage+AF8-counter, 1)
+AD4    else
+AD4      goto wait
+AD4    rcu+AF8-read+AF8-unlock+AF8-sched()
+AD4 3. use percpu+AF8-ref+AF8-switch+AF8-to+AF8-atomic/percpu to switch mode directly.
+AD4 
+AD4 Then we could unfreeze the queue w/o draining requests.
+AD4 In addition, preempt-only mode code could be simplified.

Hello Jianchao,
                                                                           +AD0
Thanks for having taken a look. However, the approach of this patch series
may be more complicated than necessary. Had you considered something like
the patch below?

Thanks,

Bart.


diff --git a/block/blk-mq.c b/block/blk-mq.c
index 20fdd78b75c7..d384ab700afd 100644
--- a/block/blk-mq.c
+-+-+- b/block/blk-mq.c
+AEAAQA -199,7 +-199,7 +AEAAQA void blk+AF8-mq+AF8-unfreeze+AF8-queue(struct request+AF8-queue +ACo-q)
 	freeze+AF8-depth +AD0 atomic+AF8-dec+AF8-return(+ACY-q-+AD4-mq+AF8-freeze+AF8-depth)+ADs
 	WARN+AF8-ON+AF8-ONCE(freeze+AF8-depth +ADw 0)+ADs
 	if (+ACE-freeze+AF8-depth) +AHs
-		percpu+AF8-ref+AF8-reinit(+ACY-q-+AD4-q+AF8-usage+AF8-counter)+ADs
+-		percpu+AF8-ref+AF8-resurrect(+ACY-q-+AD4-q+AF8-usage+AF8-counter)+ADs
 		wake+AF8-up+AF8-all(+ACY-q-+AD4-mq+AF8-freeze+AF8-wq)+ADs
 	+AH0
 +AH0
diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index 009cdf3d65b6..b297cd1cd4f1 100644
--- a/include/linux/percpu-refcount.h
+-+-+- b/include/linux/percpu-refcount.h
+AEAAQA -108,6 +-108,7 +AEAAQA void percpu+AF8-ref+AF8-switch+AF8-to+AF8-atomic+AF8-sync(struct percpu+AF8-ref +ACo-ref)+ADs
 void percpu+AF8-ref+AF8-switch+AF8-to+AF8-percpu(struct percpu+AF8-ref +ACo-ref)+ADs
 void percpu+AF8-ref+AF8-kill+AF8-and+AF8-confirm(struct percpu+AF8-ref +ACo-ref,
 				 percpu+AF8-ref+AF8-func+AF8-t +ACo-confirm+AF8-kill)+ADs
+-void percpu+AF8-ref+AF8-resurrect(struct percpu+AF8-ref +ACo-ref)+ADs
 void percpu+AF8-ref+AF8-reinit(struct percpu+AF8-ref +ACo-ref)+ADs
 
 /+ACoAKg
diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index 9f96fa7bc000..054e7650cd35 100644
--- a/lib/percpu-refcount.c
+-+-+- b/lib/percpu-refcount.c
+AEAAQA -356,11 +-356,31 +AEAAQA EXPORT+AF8-SYMBOL+AF8-GPL(percpu+AF8-ref+AF8-kill+AF8-and+AF8-confirm)+ADs
  +ACo-/
 void percpu+AF8-ref+AF8-reinit(struct percpu+AF8-ref +ACo-ref)
 +AHs
+-	WARN+AF8-ON+AF8-ONCE(+ACE-percpu+AF8-ref+AF8-is+AF8-zero(ref))+ADs
+-
+-	percpu+AF8-ref+AF8-resurrect(ref)+ADs
+-+AH0
+-EXPORT+AF8-SYMBOL+AF8-GPL(percpu+AF8-ref+AF8-reinit)+ADs
+-
+-/+ACoAKg
+- +ACo percpu+AF8-ref+AF8-resurrect - modify a percpu refcount from dead to live
+- +ACo +AEA-ref: perpcu+AF8-ref to resurrect
+- +ACo
+- +ACo Modify +AEA-ref so that it's in the same state as before percpu+AF8-ref+AF8-kill() was
+- +ACo called. +AEA-ref must have be dead but not exited.
+- +ACo
+- +ACo Note that percpu+AF8-ref+AF8-tryget+AFsAXw-live+AF0() are safe to perform on +AEA-ref while
+- +ACo this function is in progress.
+- +ACo-/
+-void percpu+AF8-ref+AF8-resurrect(struct percpu+AF8-ref +ACo-ref)
+-+AHs
+-	unsigned long +AF8AXw-percpu +ACo-percpu+AF8-count+ADs
 	unsigned long flags+ADs
 
 	spin+AF8-lock+AF8-irqsave(+ACY-percpu+AF8-ref+AF8-switch+AF8-lock, flags)+ADs
 
-	WARN+AF8-ON+AF8-ONCE(+ACE-percpu+AF8-ref+AF8-is+AF8-zero(ref))+ADs
+-	WARN+AF8-ON+AF8-ONCE(+ACE(ref-+AD4-percpu+AF8-count+AF8-ptr +ACY +AF8AXw-PERCPU+AF8-REF+AF8-DEAD))+ADs
+-	WARN+AF8-ON+AF8-ONCE(+AF8AXw-ref+AF8-is+AF8-percpu(ref, +ACY-percpu+AF8-count))+ADs
 
 	ref-+AD4-percpu+AF8-count+AF8-ptr +ACYAPQ +AH4AXwBf-PERCPU+AF8-REF+AF8-DEAD+ADs
 	percpu+AF8-ref+AF8-get(ref)+ADs
+AEAAQA -368,4 +-388,4 +AEAAQA void percpu+AF8-ref+AF8-reinit(struct percpu+AF8-ref +ACo-ref)
 
 	spin+AF8-unlock+AF8-irqrestore(+ACY-percpu+AF8-ref+AF8-switch+AF8-lock, flags)+ADs
 +AH0
-EXPORT+AF8-SYMBOL+AF8-GPL(percpu+AF8-ref+AF8-reinit)+ADs
+-EXPORT+AF8-SYMBOL+AF8-GPL(percpu+AF8-ref+AF8-resurrect)+ADs-
