Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48029 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753925AbdFWDfE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jun 2017 23:35:04 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5N3YD6H069738
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2017 23:35:04 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2b8pv387vp-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2017 23:35:03 -0400
Received: from localhost
        by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 22 Jun 2017 23:35:02 -0400
Date: Thu, 22 Jun 2017 20:34:56 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        pprakash@codeaurora.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Cochran <rcochran@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [BUG] Deadlock due due to interactions of block, RCU, and cpu
 offline
Reply-To: paulmck@linux.vnet.ibm.com
References: <db9c91f6-1b17-6136-84f0-03c3c2581ab4@codeaurora.org>
 <20170326232843.GA3637@linux.vnet.ibm.com>
 <d23f3f77-8158-24a4-727d-123ec526dffa@codeaurora.org>
 <20170327181711.GF3637@linux.vnet.ibm.com>
 <20170620234623.GA16200@linux.vnet.ibm.com>
 <df080eec-62b8-7d19-c201-e1a44febb96d@codeaurora.org>
 <20170621161853.GB3721@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170621161853.GB3721@linux.vnet.ibm.com>
Message-Id: <20170623033456.GA15959@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 21, 2017 at 09:18:53AM -0700, Paul E. McKenney wrote:
> On Wed, Jun 21, 2017 at 08:39:45AM -0600, Jeffrey Hugo wrote:
> > On 6/20/2017 5:46 PM, Paul E. McKenney wrote:
> > >On Mon, Mar 27, 2017 at 11:17:11AM -0700, Paul E. McKenney wrote:
> > >>On Mon, Mar 27, 2017 at 12:02:27PM -0600, Jeffrey Hugo wrote:
> > >>>Hi Paul.
> > >>>
> > >>>Thanks for the quick reply.
> > >>>
> > >>>On 3/26/2017 5:28 PM, Paul E. McKenney wrote:
> > >>>>On Sun, Mar 26, 2017 at 05:10:40PM -0600, Jeffrey Hugo wrote:
> > >>>
> > >>>>>It is a race between this work running, and the cpu offline processing.
> > >>>>
> > >>>>One quick way to test this assumption is to build a kernel with Kconfig
> > >>>>options CONFIG_RCU_NOCB_CPU=y and CONFIG_RCU_NOCB_CPU_ALL=y.  This will
> > >>>>cause call_rcu_sched() to queue the work to a kthread, which can migrate
> > >>>>to some other CPU.  If your analysis is correct, this should avoid
> > >>>>the deadlock.  (Note that the deadlock should be fixed in any case,
> > >>>>just a diagnostic assumption-check procedure.)
> > >>>
> > >>>I enabled CONFIG_RCU_EXPERT=y, CONFIG_RCU_NOCB_CPU=y,
> > >>>CONFIG_RCU_NOCB_CPU_ALL=y in my build.  I've only had time so far to
> > >>>do one test run however the issue reproduced, but it took a fair bit
> > >>>longer to do so.  An initial look at the data indicates that the
> > >>>work is still not running.  An odd observation, the two threads are
> > >>>no longer blocked on the same queue, but different ones.
> > >>
> > >>I was afraid of that...
> > >>
> > >>>Let me look at this more and see what is going on now.
> > >>
> > >>Another thing to try would be to affinity the "rcuo" kthreads to
> > >>some CPU that is never taken offline, just in case that kthread is
> > >>sometimes somehow getting stuck during the CPU-hotplug operation.
> > >>
> > >>>>>What is the opinion of the domain experts?
> > >>>>
> > >>>>I do hope that we can come up with a better fix.  No offense intended,
> > >>>>as coming up with -any- fix in the CPU-hotplug domain is not to be
> > >>>>denigrated, but this looks to be at vest quite fragile.
> > >>>>
> > >>>>							Thanx, Paul
> > >>>>
> > >>>
> > >>>None taken.  I'm not particularly attached to the current fix.  I
> > >>>agree, it does appear to be quite fragile.
> > >>>
> > >>>I'm still not sure what a better solution would be though.  Maybe
> > >>>the RCU framework flushes the work somehow during cpu offline?  It
> > >>>would need to ensure further work is not queued after that point,
> > >>>which seems like it might be tricky to synchronize.  I don't know
> > >>>enough about the working of RCU to even attempt to implement that.
> > >>
> > >>There are some ways that RCU might be able to shrink the window during
> > >>which the outgoing CPU's callbacks are in limbo, but they are not free
> > >>of risk, so we really need to compleetly understand what is going on
> > >>before making any possibly ill-conceived changes.  ;-)
> > >>
> > >>>In any case, it seem like some more analysis is needed based on the
> > >>>latest data.
> > >>
> > >>Looking forward to hearing about you find!
> > >
> > >Hearing nothing, I eventually took unilateral action (I am a citizen of
> > >USA, after all!) and produced the lightly tested patch shown below.
> > >
> > >Does it help?
> > >
> > >							Thanx, Paul
> > >
> > 
> > Wow, has it been 3 months already?  I am extremely sorry, I've been
> > preempted multiple times, and this has sat on my todo list where I
> > keep thinking I need to find time to come back to it but apparently
> > not doing enough to make that happen.
> > 
> > Thank you for not forgetting about this.  I promise I will somehow
> > clear my schedule to test this next week.
> 
> No worries, and I am very much looking forward to seeing the results of
> your testing.

And please see below for an updated patch based on LKML review and
more intensive testing.

							Thanx, Paul

------------------------------------------------------------------------

commit 4384c26f62d90e9685a50d65dcd352dbe96ae220
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Tue Jun 20 12:11:34 2017 -0700

    rcu: Migrate callbacks earlier in the CPU-offline timeline
    
    RCU callbacks must be migrated away from an outgoing CPU, and this is
    done near the end of the CPU-hotplug operation, after the outgoing CPU is
    long gone.  Unfortunately, this means that other CPU-hotplug callbacks
    can execute while the outgoing CPU's callbacks are still immobilized
    on the long-gone CPU's callback lists.  If any of these CPU-hotplug
    callbacks must wait, either directly or indirectly, for the invocation
    of any of the immobilized RCU callbacks, the system will hang.
    
    This commit avoids such hangs by migrating the callbacks away from the
    outgoing CPU immediately upon its departure, shortly after the return
    from __cpu_die() in takedown_cpu().  Thus, RCU is able to advance these
    callbacks and invoke them, which allows all the after-the-fact CPU-hotplug
    callbacks to wait on these RCU callbacks without risk of a hang.
    
    While in the neighborhood, this commit also moves rcu_send_cbs_to_orphanage()
    and rcu_adopt_orphan_cbs() under a pre-existing #ifdef to avoid including
    dead code on the one hand and to avoid define-without-use warnings on the
    other hand.
    
    Reported-by: Jeffrey Hugo <jhugo@codeaurora.org>
    Link: http://lkml.kernel.org/r/db9c91f6-1b17-6136-84f0-03c3c2581ab4@codeaurora.org
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    Cc: Ingo Molnar <mingo@kernel.org>
    Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
    Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
    Cc: Richard Weinberger <richard@nod.at>

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index ecca9d2e4e4a..96f1baf62ab8 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -109,6 +109,7 @@ void rcu_bh_qs(void);
 void rcu_check_callbacks(int user);
 void rcu_report_dead(unsigned int cpu);
 void rcu_cpu_starting(unsigned int cpu);
+void rcutree_migrate_callbacks(int cpu);
 
 #ifdef CONFIG_RCU_STALL_COMMON
 void rcu_sysrq_start(void);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 9ae6fbe5b5cf..f5f3db2403fa 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -729,6 +729,7 @@ static int takedown_cpu(unsigned int cpu)
 	__cpu_die(cpu);
 
 	tick_cleanup_dead_cpu(cpu);
+	rcutree_migrate_callbacks(cpu);
 	return 0;
 }
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 94ec7455fc46..e6d534946c7f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2547,85 +2547,6 @@ rcu_check_quiescent_state(struct rcu_state *rsp, struct rcu_data *rdp)
 }
 
 /*
- * Send the specified CPU's RCU callbacks to the orphanage.  The
- * specified CPU must be offline, and the caller must hold the
- * ->orphan_lock.
- */
-static void
-rcu_send_cbs_to_orphanage(int cpu, struct rcu_state *rsp,
-			  struct rcu_node *rnp, struct rcu_data *rdp)
-{
-	lockdep_assert_held(&rsp->orphan_lock);
-
-	/* No-CBs CPUs do not have orphanable callbacks. */
-	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU) || rcu_is_nocb_cpu(rdp->cpu))
-		return;
-
-	/*
-	 * Orphan the callbacks.  First adjust the counts.  This is safe
-	 * because _rcu_barrier() excludes CPU-hotplug operations, so it
-	 * cannot be running now.  Thus no memory barrier is required.
-	 */
-	rdp->n_cbs_orphaned += rcu_segcblist_n_cbs(&rdp->cblist);
-	rcu_segcblist_extract_count(&rdp->cblist, &rsp->orphan_done);
-
-	/*
-	 * Next, move those callbacks still needing a grace period to
-	 * the orphanage, where some other CPU will pick them up.
-	 * Some of the callbacks might have gone partway through a grace
-	 * period, but that is too bad.  They get to start over because we
-	 * cannot assume that grace periods are synchronized across CPUs.
-	 */
-	rcu_segcblist_extract_pend_cbs(&rdp->cblist, &rsp->orphan_pend);
-
-	/*
-	 * Then move the ready-to-invoke callbacks to the orphanage,
-	 * where some other CPU will pick them up.  These will not be
-	 * required to pass though another grace period: They are done.
-	 */
-	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rsp->orphan_done);
-
-	/* Finally, disallow further callbacks on this CPU.  */
-	rcu_segcblist_disable(&rdp->cblist);
-}
-
-/*
- * Adopt the RCU callbacks from the specified rcu_state structure's
- * orphanage.  The caller must hold the ->orphan_lock.
- */
-static void rcu_adopt_orphan_cbs(struct rcu_state *rsp, unsigned long flags)
-{
-	struct rcu_data *rdp = raw_cpu_ptr(rsp->rda);
-
-	lockdep_assert_held(&rsp->orphan_lock);
-
-	/* No-CBs CPUs are handled specially. */
-	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU) ||
-	    rcu_nocb_adopt_orphan_cbs(rsp, rdp, flags))
-		return;
-
-	/* Do the accounting first. */
-	rdp->n_cbs_adopted += rsp->orphan_done.len;
-	if (rsp->orphan_done.len_lazy != rsp->orphan_done.len)
-		rcu_idle_count_callbacks_posted();
-	rcu_segcblist_insert_count(&rdp->cblist, &rsp->orphan_done);
-
-	/*
-	 * We do not need a memory barrier here because the only way we
-	 * can get here if there is an rcu_barrier() in flight is if
-	 * we are the task doing the rcu_barrier().
-	 */
-
-	/* First adopt the ready-to-invoke callbacks, then the done ones. */
-	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rsp->orphan_done);
-	WARN_ON_ONCE(rsp->orphan_done.head);
-	rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rsp->orphan_pend);
-	WARN_ON_ONCE(rsp->orphan_pend.head);
-	WARN_ON_ONCE(rcu_segcblist_empty(&rdp->cblist) !=
-		     !rcu_segcblist_n_cbs(&rdp->cblist));
-}
-
-/*
  * Trace the fact that this CPU is going offline.
  */
 static void rcu_cleanup_dying_cpu(struct rcu_state *rsp)
@@ -2695,7 +2616,6 @@ static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf)
  */
 static void rcu_cleanup_dead_cpu(int cpu, struct rcu_state *rsp)
 {
-	unsigned long flags;
 	struct rcu_data *rdp = per_cpu_ptr(rsp->rda, cpu);
 	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
 
@@ -2704,18 +2624,6 @@ static void rcu_cleanup_dead_cpu(int cpu, struct rcu_state *rsp)
 
 	/* Adjust any no-longer-needed kthreads. */
 	rcu_boost_kthread_setaffinity(rnp, -1);
-
-	/* Orphan the dead CPU's callbacks, and adopt them if appropriate. */
-	raw_spin_lock_irqsave(&rsp->orphan_lock, flags);
-	rcu_send_cbs_to_orphanage(cpu, rsp, rnp, rdp);
-	rcu_adopt_orphan_cbs(rsp, flags);
-	raw_spin_unlock_irqrestore(&rsp->orphan_lock, flags);
-
-	WARN_ONCE(rcu_segcblist_n_cbs(&rdp->cblist) != 0 ||
-		  !rcu_segcblist_empty(&rdp->cblist),
-		  "rcu_cleanup_dead_cpu: Callbacks on offline CPU %d: qlen=%lu, 1stCB=%p\n",
-		  cpu, rcu_segcblist_n_cbs(&rdp->cblist),
-		  rcu_segcblist_first_cb(&rdp->cblist));
 }
 
 /*
@@ -3927,6 +3835,116 @@ void rcu_report_dead(unsigned int cpu)
 	for_each_rcu_flavor(rsp)
 		rcu_cleanup_dying_idle_cpu(cpu, rsp);
 }
+
+/*
+ * Send the specified CPU's RCU callbacks to the orphanage.  The
+ * specified CPU must be offline, and the caller must hold the
+ * ->orphan_lock.
+ */
+static void
+rcu_send_cbs_to_orphanage(int cpu, struct rcu_state *rsp,
+			  struct rcu_node *rnp, struct rcu_data *rdp)
+{
+	lockdep_assert_held(&rsp->orphan_lock);
+
+	/* No-CBs CPUs do not have orphanable callbacks. */
+	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU) || rcu_is_nocb_cpu(rdp->cpu))
+		return;
+
+	/*
+	 * Orphan the callbacks.  First adjust the counts.  This is safe
+	 * because _rcu_barrier() excludes CPU-hotplug operations, so it
+	 * cannot be running now.  Thus no memory barrier is required.
+	 */
+	rdp->n_cbs_orphaned += rcu_segcblist_n_cbs(&rdp->cblist);
+	rcu_segcblist_extract_count(&rdp->cblist, &rsp->orphan_done);
+
+	/*
+	 * Next, move those callbacks still needing a grace period to
+	 * the orphanage, where some other CPU will pick them up.
+	 * Some of the callbacks might have gone partway through a grace
+	 * period, but that is too bad.  They get to start over because we
+	 * cannot assume that grace periods are synchronized across CPUs.
+	 */
+	rcu_segcblist_extract_pend_cbs(&rdp->cblist, &rsp->orphan_pend);
+
+	/*
+	 * Then move the ready-to-invoke callbacks to the orphanage,
+	 * where some other CPU will pick them up.  These will not be
+	 * required to pass though another grace period: They are done.
+	 */
+	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rsp->orphan_done);
+
+	/* Finally, disallow further callbacks on this CPU.  */
+	rcu_segcblist_disable(&rdp->cblist);
+}
+
+/*
+ * Adopt the RCU callbacks from the specified rcu_state structure's
+ * orphanage.  The caller must hold the ->orphan_lock.
+ */
+static void rcu_adopt_orphan_cbs(struct rcu_state *rsp, unsigned long flags)
+{
+	struct rcu_data *rdp = raw_cpu_ptr(rsp->rda);
+
+	lockdep_assert_held(&rsp->orphan_lock);
+
+	/* No-CBs CPUs are handled specially. */
+	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU) ||
+	    rcu_nocb_adopt_orphan_cbs(rsp, rdp, flags))
+		return;
+
+	/* Do the accounting first. */
+	rdp->n_cbs_adopted += rsp->orphan_done.len;
+	if (rsp->orphan_done.len_lazy != rsp->orphan_done.len)
+		rcu_idle_count_callbacks_posted();
+	rcu_segcblist_insert_count(&rdp->cblist, &rsp->orphan_done);
+
+	/*
+	 * We do not need a memory barrier here because the only way we
+	 * can get here if there is an rcu_barrier() in flight is if
+	 * we are the task doing the rcu_barrier().
+	 */
+
+	/* First adopt the ready-to-invoke callbacks, then the done ones. */
+	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rsp->orphan_done);
+	WARN_ON_ONCE(rsp->orphan_done.head);
+	rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rsp->orphan_pend);
+	WARN_ON_ONCE(rsp->orphan_pend.head);
+	WARN_ON_ONCE(rcu_segcblist_empty(&rdp->cblist) !=
+		     !rcu_segcblist_n_cbs(&rdp->cblist));
+}
+
+/* Orphan the dead CPU's callbacks, and then adopt them. */
+static void rcu_migrate_callbacks(int cpu, struct rcu_state *rsp)
+{
+	unsigned long flags;
+	struct rcu_data *rdp = per_cpu_ptr(rsp->rda, cpu);
+	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
+
+	raw_spin_lock_irqsave(&rsp->orphan_lock, flags);
+	rcu_send_cbs_to_orphanage(cpu, rsp, rnp, rdp);
+	rcu_adopt_orphan_cbs(rsp, flags);
+	raw_spin_unlock_irqrestore(&rsp->orphan_lock, flags);
+	WARN_ONCE(rcu_segcblist_n_cbs(&rdp->cblist) != 0 ||
+		  !rcu_segcblist_empty(&rdp->cblist),
+		  "rcu_cleanup_dead_cpu: Callbacks on offline CPU %d: qlen=%lu, 1stCB=%p\n",
+		  cpu, rcu_segcblist_n_cbs(&rdp->cblist),
+		  rcu_segcblist_first_cb(&rdp->cblist));
+}
+
+/*
+ * The outgoing CPU has just passed through the dying-idle state,
+ * and we are being invoked from the CPU that was IPIed to continue the
+ * offline operation.  We need to migrate the outgoing CPU's callbacks.
+ */
+void rcutree_migrate_callbacks(int cpu)
+{
+	struct rcu_state *rsp;
+
+	for_each_rcu_flavor(rsp)
+		rcu_migrate_callbacks(cpu, rsp);
+}
 #endif
 
 /*
