Return-Path: <SRS0=JlK2=XS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8354C04EBF
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 10:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA1B206C2
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 10:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbfIWK0H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Sep 2019 06:26:07 -0400
Received: from foss.arm.com ([217.140.110.172]:40214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbfIWK0H (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Sep 2019 06:26:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BECCE142F;
        Mon, 23 Sep 2019 03:26:06 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69C883F694;
        Mon, 23 Sep 2019 03:26:05 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: sched: make struct task_struct::state 32-bit
To:     Markus Elfring <Markus.Elfring@web.de>,
        Alexey Dobriyan <adobriyan@gmail.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Julia Lawall <julia.lawall@lip6.fr>
References: <a43fe392-bd6a-71f5-8611-c6b764ba56c3@arm.com>
 <7e3e784c-e8e6-f9ba-490f-ec3bf956d96b@web.de>
 <0c4dcb91-4830-0013-b8c6-64b9e1ce47d4@arm.com>
Message-ID: <32d65b15-1855-e7eb-e9c4-81560fab62ea@arm.com>
Date:   Mon, 23 Sep 2019 11:26:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0c4dcb91-4830-0013-b8c6-64b9e1ce47d4@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05/09/2019 17:52, Valentin Schneider wrote:
> I actually got rid of the task_struct* parameter and now just match
> against task_struct.p accesses in the function body, which has the
> added bonus of not caring about the order of the parameters.
> 
> Still not there yet but making progress in the background, hope it's
> passable entertainment to see me struggle my way there :)
> 

Bit of hiatus on my end there. I did play around some more with Coccinelle 
on the way to/from Plumbers. The main problems I'm facing ATM is "current"
not being recognized as a task_struct* expression, and the need to 
"recursively" match task_struct.state modifiers, i.e. catch both functions
for something like:

foo(long state)
{
	__foo(state);
}

__foo(long state)
{
	current->state = state;
}


Here's where I'm at:
---
virtual patch
virtual report

// Match variables that represent task states
// They can be read from / written to task_struct.state, or be compared
// to TASK_* values
@state_access@
struct task_struct *p;
// FIXME: current not recognized as task_struct*, fixhack with regexp
identifier current =~ "^current$";
identifier task_state =~ "^TASK_";
identifier state_var;
position pos;
@@

(
  p->state & state_var@pos
|
  current->state & state_var@pos
|
  p->state | state_var@pos
|
  current->state | state_var@pos
|
  p->state < state_var@pos
|
  current->state < state_var@pos
|
  p->state > state_var@pos
|
  current->state > state_var@pos
|
  state_var@pos = p->state
|
  state_var@pos = current->state
|
  p->state == state_var@pos
|
  current->state == state_var@pos
|
  p->state != state_var@pos
|
  current->state != state_var@pos
|
// FIXME: match functions that do something with state_var underneath?
// How to do recursive rules?
  set_current_state(state_var@pos)
|
  set_special_state(state_var@pos)
|
  signal_pending_state(state_var@pos, p)
|
  signal_pending_state(state_var@pos, current)
|
  state_var@pos & task_state
|
  state_var@pos | task_state
)

// Fixup local variables
@depends on patch && state_access@
identifier state_var = state_access.state_var;
@@
(
- long
+ int
|
- unsigned long
+ unsigned int
)
state_var;

// Fixup function parameters
@depends on patch && state_access@
identifier fn;
identifier state_var = state_access.state_var;
@@

fn(...,
- long state_var
+ int state_var
,...)
{
	...
}

// FIXME: find a way to squash that with the above?
// Fixup function parameters
@depends on patch && state_access@
identifier fn;
identifier state_var = state_access.state_var;
@@

fn(...,
- unsigned long
+ unsigned int
state_var
,...)
{
	...
}
---

This gives me the following diff on kernel/:

---
diff -u -p a/locking/mutex.c b/locking/mutex.c
--- a/locking/mutex.c
+++ b/locking/mutex.c
@@ -923,7 +923,7 @@ __ww_mutex_add_waiter(struct mutex_waite
  * Lock a mutex (possibly interruptible), slowpath:
  */
 static __always_inline int __sched
-__mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
+__mutex_lock_common(struct mutex *lock, int state, unsigned int subclass,
 		    struct lockdep_map *nest_lock, unsigned long ip,
 		    struct ww_acquire_ctx *ww_ctx, const bool use_ww_ctx)
 {
@@ -1097,14 +1097,14 @@ err_early_kill:
 }
 
 static int __sched
-__mutex_lock(struct mutex *lock, long state, unsigned int subclass,
+__mutex_lock(struct mutex *lock, int state, unsigned int subclass,
 	     struct lockdep_map *nest_lock, unsigned long ip)
 {
 	return __mutex_lock_common(lock, state, subclass, nest_lock, ip, NULL, false);
 }
 
 static int __sched
-__ww_mutex_lock(struct mutex *lock, long state, unsigned int subclass,
+__ww_mutex_lock(struct mutex *lock, int state, unsigned int subclass,
 		struct lockdep_map *nest_lock, unsigned long ip,
 		struct ww_acquire_ctx *ww_ctx)
 {
diff -u -p a/locking/semaphore.c b/locking/semaphore.c
--- a/locking/semaphore.c
+++ b/locking/semaphore.c
@@ -201,7 +201,7 @@ struct semaphore_waiter {
  * constant, and thus optimised away by the compiler.  Likewise the
  * 'timeout' parameter for the cases without timeouts.
  */
-static inline int __sched __down_common(struct semaphore *sem, long state,
+static inline int __sched __down_common(struct semaphore *sem, int state,
 								long timeout)
 {
 	struct semaphore_waiter waiter;
diff -u -p a/freezer.c b/freezer.c
--- a/freezer.c
+++ b/freezer.c
@@ -64,7 +64,7 @@ bool __refrigerator(bool check_kthr_stop
 	/* Hmm, should we be allowed to suspend when there are realtime
 	   processes around? */
 	bool was_frozen = false;
-	long save = current->state;
+	int save = current->state;
 
 	pr_debug("%s entered refrigerator\n", current->comm);
 
diff -u -p a/sched/core.c b/sched/core.c
--- a/sched/core.c
+++ b/sched/core.c
@@ -1888,7 +1888,7 @@ out:
  * smp_call_function() if an IPI is sent by the same process we are
  * waiting to become inactive.
  */
-unsigned long wait_task_inactive(struct task_struct *p, long match_state)
+unsigned long wait_task_inactive(struct task_struct *p, int match_state)
 {
 	int running, queued;
 	struct rq_flags rf;
@@ -3185,7 +3185,7 @@ static struct rq *finish_task_switch(str
 {
 	struct rq *rq = this_rq();
 	struct mm_struct *mm = rq->prev_mm;
-	long prev_state;
+	int prev_state;
 
 	/*
 	 * The previous task will have left us with a preempt_count of 2
@@ -5964,7 +5964,7 @@ void sched_show_task(struct task_struct
 EXPORT_SYMBOL_GPL(sched_show_task);
 
 static inline bool
-state_filter_match(unsigned long state_filter, struct task_struct *p)
+state_filter_match(unsigned int state_filter, struct task_struct *p)
 {
 	/* no filter, everything matches */
 	if (!state_filter)
@@ -5985,7 +5985,7 @@ state_filter_match(unsigned long state_f
 }
 
 
-void show_state_filter(unsigned long state_filter)
+void show_state_filter(unsigned int state_filter)
 {
 	struct task_struct *g, *p;
 
---
