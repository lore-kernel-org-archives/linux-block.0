Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Wed, 8 Feb 2017 09:17:13 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	linux-block@vger.kernel.org,
	Linux-Kernal <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>, broonie@kernel.org
Subject: Re: [PATCH] bfq-mq: cause deadlock by executing exit_icq body
 immediately
Message-ID: <20170208171713.GA7811@vader>
References: <20170207173346.4789-1-paolo.valente@linaro.org>
 <20170207214516.GA14269@vader.DHCP.thefacebook.com>
 <A064B1DA-C96B-4EA9-A412-F2A6D8FB295A@linaro.org>
 <20170208103342.GA4647@vader>
 <49CC2920-EF8D-4B9B-B6BE-1722156AAB70@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49CC2920-EF8D-4B9B-B6BE-1722156AAB70@linaro.org>
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 08, 2017 at 11:39:24AM +0100, Paolo Valente wrote:
> 
> > Il giorno 08 feb 2017, alle ore 11:33, Omar Sandoval <osandov@osandov.com> ha scritto:
> > 
> > On Wed, Feb 08, 2017 at 11:03:01AM +0100, Paolo Valente wrote:
> >> 
> >>> Il giorno 07 feb 2017, alle ore 22:45, Omar Sandoval <osandov@osandov.com> ha scritto:
> >>> 
> >>> On Tue, Feb 07, 2017 at 06:33:46PM +0100, Paolo Valente wrote:
> >>>> Hi,
> >>>> this patch is meant to show that, if the  body of the hook exit_icq is executed
> >>>> from inside that hook, and not as deferred work, then a circular deadlock
> >>>> occurs.
> >>>> 
> >>>> It happens if, on a CPU
> >>>> - the body of icq_exit takes the scheduler lock,
> >>>> - it does so from inside the exit_icq hook, which is invoked with the queue
> >>>> lock held
> >>>> 
> >>>> while, on another CPU
> >>>> - bfq_bio_merge, after taking the scheduler lock, invokes bfq_bic_lookup,
> >>>> which, in its turn, takes the queue lock. bfq_bic_lookup needs to take such a
> >>>> lock, because it invokes ioc_lookup_icq.
> >>>> 
> >>>> For more details, here is a lockdep report, right before the deadlock did occur.
> >>>> 
> >>>> [   44.059877] ======================================================
> >>>> [   44.124922] [ INFO: possible circular locking dependency detected ]
> >>>> [   44.125795] 4.10.0-rc5-bfq-mq+ #38 Not tainted
> >>>> [   44.126414] -------------------------------------------------------
> >>>> [   44.127291] sync/2043 is trying to acquire lock:
> >>>> [   44.128918]  (&(&bfqd->lock)->rlock){-.-...}, at: [<ffffffff90484195>] bfq_exit_icq_bfqq+0x55/0x140
> >>>> [   44.134052]
> >>>> [   44.134052] but task is already holding lock:
> >>>> [   44.134868]  (&(&q->__queue_lock)->rlock){-.....}, at: [<ffffffff9044738e>] put_io_context_active+0x6e/0xc0
> >>> 
> >>> Hey, Paolo,
> >>> 
> >>> I only briefly skimmed the code, but what are you using the queue_lock
> >>> for? You should just use your scheduler lock everywhere. blk-mq doesn't
> >>> use the queue lock, so the scheduler is the only thing you need mutual
> >>> exclusion against.
> >> 
> >> Hi Omar,
> >> the cause of the problem is that the hook functions bfq_request_merge
> >> and bfq_allow_bio_merge invoke, directly or through other functions,
> >> the function bfq_bic_lookup, which, in its turn, invokes
> >> ioc_lookup_icq.  The latter must be invoked with the queue lock held.
> >> In particular the offending lines in bfq_bic_lookup are:
> >> 
> >> 		spin_lock_irqsave(q->queue_lock, flags);
> >> 		icq = icq_to_bic(ioc_lookup_icq(ioc, q));
> >> 		spin_unlock_irqrestore(q->queue_lock, flags);
> >> 
> >> Maybe I'm missing something and we can avoid taking this lock?
> > 
> > Ah, I didn't realize we still used the q->queue_lock for the icq stuff.
> > You're right, you still need that lock for ioc_lookup_icq(). Unless
> > there's something else I'm forgetting, that should be the only thing you
> > need it for in the core code, and you should use your scheduler lock for
> > everything else. What else are you using q->queue_lock for? 
> 
> Nothing.  The deadlock follows from that bfq_request_merge gets called
> with the scheduler lock already held.  Problematic paths start from:
> bfq_bio_merge and bfq_insert_request.
> 
> I'm trying to understand whether I/we can reorder operations in some
> way that avoids the nested locking, but at no avail so far.
> 
> Thanks,
> Paolo

Okay, I understand what you're saying now. It was all in the first email
but I didn't see it right away, sorry about that.

I don't think it makes sense for ->exit_icq() to be invoked while
holding q->queue_lock for blk-mq -- we don't hold that lock for any of
the other hooks. Could you try the below? I haven't convinced myself
that there isn't a circular locking dependency between bfqd->lock and
ioc->lock now, but it's probably easiest for you to just try it.

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index fe186a9eade9..b12f9c87b4c3 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -35,7 +35,10 @@ static void icq_free_icq_rcu(struct rcu_head *head)
 	kmem_cache_free(icq->__rcu_icq_cache, icq);
 }
 
-/* Exit an icq. Called with both ioc and q locked. */
+/*
+ * Exit an icq. Called with both ioc and q locked for sq, only ioc locked for
+ * mq.
+ */
 static void ioc_exit_icq(struct io_cq *icq)
 {
 	struct elevator_type *et = icq->q->elevator->type;
@@ -166,6 +169,7 @@ EXPORT_SYMBOL(put_io_context);
  */
 void put_io_context_active(struct io_context *ioc)
 {
+	struct elevator_type *et;
 	unsigned long flags;
 	struct io_cq *icq;
 
@@ -184,13 +188,19 @@ void put_io_context_active(struct io_context *ioc)
 	hlist_for_each_entry(icq, &ioc->icq_list, ioc_node) {
 		if (icq->flags & ICQ_EXITED)
 			continue;
-		if (spin_trylock(icq->q->queue_lock)) {
+
+		et = icq->q->elevator->type;
+		if (et->uses_mq) {
 			ioc_exit_icq(icq);
-			spin_unlock(icq->q->queue_lock);
 		} else {
-			spin_unlock_irqrestore(&ioc->lock, flags);
-			cpu_relax();
-			goto retry;
+			if (spin_trylock(icq->q->queue_lock)) {
+				ioc_exit_icq(icq);
+				spin_unlock(icq->q->queue_lock);
+			} else {
+				spin_unlock_irqrestore(&ioc->lock, flags);
+				cpu_relax();
+				goto retry;
+			}
 		}
 	}
 	spin_unlock_irqrestore(&ioc->lock, flags);
