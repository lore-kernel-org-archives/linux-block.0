Return-Path: <mpatocka@redhat.com>
Date: Mon, 27 Nov 2017 22:36:59 -0500 (EST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] schedule: use unlikely()
In-Reply-To: <20171125081613.damtbce2pelywx2k@gmail.com>
Message-ID: <alpine.LRH.2.02.1711271906400.9280@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1711131359030.2791@file01.intranet.prod.int.rdu2.redhat.com> <20171124073819.ejig4akxinmugbnr@gmail.com> <alpine.LRH.2.02.1711241336410.20259@file01.intranet.prod.int.rdu2.redhat.com> <20171125081613.damtbce2pelywx2k@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>



On Sat, 25 Nov 2017, Ingo Molnar wrote:

> 
> * Mikulas Patocka <mpatocka@redhat.com> wrote:
> 
> > On Fri, 24 Nov 2017, Ingo Molnar wrote:
> > 
> > > > +	return unlikely(plug != NULL) &&
> > > >  		(!list_empty(&plug->list) ||
> > > >  		 !list_empty(&plug->mq_list) ||
> > > >  		 !list_empty(&plug->cb_list));
> > > 
> > > That's an unrelated change.
> > 
> > It is related, because this function gets inlined into schedule().
> 
> That needs to be in the changelog and the patch needs to be Cc:-ed to the 
> affected maintainer as well.
> 
> > The static branch prediction in gcc assumes that pointers are usually not 
> > NULL, but in this case tsk->pi_blocked_on and tsk->plug are usually NULL.
> 
> That too should be in the changelog.
> 
> Thanks,
> 
> 	Ingo
> 

OK - here I resend it with more verbose message:

Mikulas



From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] schedule: add unlikely()

A small patch for schedule(), so that the code goes straght in the common 
case. This patch saves two jumps in the assembler listing. The static 
branch prediction in GCC assumes that pointers are usually non-NULL when 
they are compared against NULL, but in theis case, tsk->plug is usually 
NULL (the function blk_needs_flush_plug gets inlined into schedule()) and 
tsk->pi_blocked_on is also usually NULL (that is checked by 
tsk_is_pi_blocked). This patch adds the macro unlikely() to override the 
static prediction.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 include/linux/blkdev.h |    2 +-
 kernel/sched/core.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/include/linux/blkdev.h
===================================================================
--- linux-2.6.orig/include/linux/blkdev.h
+++ linux-2.6/include/linux/blkdev.h
@@ -1308,7 +1308,7 @@ static inline bool blk_needs_flush_plug(
 {
 	struct blk_plug *plug = tsk->plug;
 
-	return plug &&
+	return unlikely(plug != NULL) &&
 		(!list_empty(&plug->list) ||
 		 !list_empty(&plug->mq_list) ||
 		 !list_empty(&plug->cb_list));
Index: linux-2.6/kernel/sched/core.c
===================================================================
--- linux-2.6.orig/kernel/sched/core.c
+++ linux-2.6/kernel/sched/core.c
@@ -3405,7 +3405,7 @@ void __noreturn do_task_dead(void)
 
 static inline void sched_submit_work(struct task_struct *tsk)
 {
-	if (!tsk->state || tsk_is_pi_blocked(tsk))
+	if (!tsk->state || unlikely(tsk_is_pi_blocked(tsk)))
 		return;
 	/*
 	 * If we are going to sleep and we have plugged IO queued,
