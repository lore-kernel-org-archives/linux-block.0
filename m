Return-Path: <paulmck@linux.vnet.ibm.com>
Date: Tue, 27 Jun 2017 17:11:30 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        pprakash@codeaurora.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, Jens Axboe <axboe@kernel.dk>,
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
 <20170623033456.GA15959@linux.vnet.ibm.com>
 <c367a3a4-6fac-957a-5a5e-ac4a68bc4648@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c367a3a4-6fac-957a-5a5e-ac4a68bc4648@codeaurora.org>
Message-Id: <20170628001130.GB3721@linux.vnet.ibm.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jun 27, 2017 at 04:32:09PM -0600, Jeffrey Hugo wrote:
> On 6/22/2017 9:34 PM, Paul E. McKenney wrote:
> >On Wed, Jun 21, 2017 at 09:18:53AM -0700, Paul E. McKenney wrote:
> >>No worries, and I am very much looking forward to seeing the results of
> >>your testing.
> >
> >And please see below for an updated patch based on LKML review and
> >more intensive testing.
> >
> 
> I spent some time on this today.  It didn't go as I expected.  I
> validated the issue is reproducible as before on 4.11 and 4.12 rcs 1
> through 4.  However, the version of stress-ng that I was using ran
> into constant errors starting with rc5, making it nearly impossible
> to make progress toward reproduction.  Upgrading stress-ng to tip
> fixes the issue, however, I've still been unable to repro the issue.
> 
> Its my unfounded suspicion that something went in between rc4 and
> rc5 which changed the timing, and didn't actually fix the issue.  I
> will run the test overnight for 5 hours to try to repro.
> 
> The patch you sent appears to be based on linux-next, and appears to
> have a number of dependencies which prevent it from cleanly applying
> on anything current that I'm able to repro on at this time.  Do you
> want to provide a rebased version of the patch which applies to say
> 4.11?  I could easily test that and report back.

Here is a very lightly tested backport to v4.11.

							Thanx, Paul

------------------------------------------------------------------------

commit 5557f5d8435dcfdc81ff090aceb57734448d3051
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
index de88b33c0974..183d69438776 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -295,6 +295,7 @@ void rcu_bh_qs(void);
 void rcu_check_callbacks(int user);
 void rcu_report_dead(unsigned int cpu);
 void rcu_cpu_starting(unsigned int cpu);
+void rcutree_migrate_callbacks(int cpu);
 
 #ifndef CONFIG_TINY_RCU
 void rcu_end_inkernel_boot(void);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 37b223e4fc05..21be6ab54ea2 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -729,6 +729,7 @@ static int takedown_cpu(unsigned int cpu)
 	__cpu_die(cpu);
 
 	tick_cleanup_dead_cpu(cpu);
+	rcutree_migrate_callbacks(cpu);
 	return 0;
 }
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 50fee7689e71..63206f81574a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2636,114 +2636,6 @@ rcu_check_quiescent_state(struct rcu_state *rsp, struct rcu_data *rdp)
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
-	/* No-CBs CPUs do not have orphanable callbacks. */
-	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU) || rcu_is_nocb_cpu(rdp->cpu))
-		return;
-
-	/*
-	 * Orphan the callbacks.  First adjust the counts.  This is safe
-	 * because _rcu_barrier() excludes CPU-hotplug operations, so it
-	 * cannot be running now.  Thus no memory barrier is required.
-	 */
-	if (rdp->nxtlist != NULL) {
-		rsp->qlen_lazy += rdp->qlen_lazy;
-		rsp->qlen += rdp->qlen;
-		rdp->n_cbs_orphaned += rdp->qlen;
-		rdp->qlen_lazy = 0;
-		WRITE_ONCE(rdp->qlen, 0);
-	}
-
-	/*
-	 * Next, move those callbacks still needing a grace period to
-	 * the orphanage, where some other CPU will pick them up.
-	 * Some of the callbacks might have gone partway through a grace
-	 * period, but that is too bad.  They get to start over because we
-	 * cannot assume that grace periods are synchronized across CPUs.
-	 * We don't bother updating the ->nxttail[] array yet, instead
-	 * we just reset the whole thing later on.
-	 */
-	if (*rdp->nxttail[RCU_DONE_TAIL] != NULL) {
-		*rsp->orphan_nxttail = *rdp->nxttail[RCU_DONE_TAIL];
-		rsp->orphan_nxttail = rdp->nxttail[RCU_NEXT_TAIL];
-		*rdp->nxttail[RCU_DONE_TAIL] = NULL;
-	}
-
-	/*
-	 * Then move the ready-to-invoke callbacks to the orphanage,
-	 * where some other CPU will pick them up.  These will not be
-	 * required to pass though another grace period: They are done.
-	 */
-	if (rdp->nxtlist != NULL) {
-		*rsp->orphan_donetail = rdp->nxtlist;
-		rsp->orphan_donetail = rdp->nxttail[RCU_DONE_TAIL];
-	}
-
-	/*
-	 * Finally, initialize the rcu_data structure's list to empty and
-	 * disallow further callbacks on this CPU.
-	 */
-	init_callback_list(rdp);
-	rdp->nxttail[RCU_NEXT_TAIL] = NULL;
-}
-
-/*
- * Adopt the RCU callbacks from the specified rcu_state structure's
- * orphanage.  The caller must hold the ->orphan_lock.
- */
-static void rcu_adopt_orphan_cbs(struct rcu_state *rsp, unsigned long flags)
-{
-	int i;
-	struct rcu_data *rdp = raw_cpu_ptr(rsp->rda);
-
-	/* No-CBs CPUs are handled specially. */
-	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU) ||
-	    rcu_nocb_adopt_orphan_cbs(rsp, rdp, flags))
-		return;
-
-	/* Do the accounting first. */
-	rdp->qlen_lazy += rsp->qlen_lazy;
-	rdp->qlen += rsp->qlen;
-	rdp->n_cbs_adopted += rsp->qlen;
-	if (rsp->qlen_lazy != rsp->qlen)
-		rcu_idle_count_callbacks_posted();
-	rsp->qlen_lazy = 0;
-	rsp->qlen = 0;
-
-	/*
-	 * We do not need a memory barrier here because the only way we
-	 * can get here if there is an rcu_barrier() in flight is if
-	 * we are the task doing the rcu_barrier().
-	 */
-
-	/* First adopt the ready-to-invoke callbacks. */
-	if (rsp->orphan_donelist != NULL) {
-		*rsp->orphan_donetail = *rdp->nxttail[RCU_DONE_TAIL];
-		*rdp->nxttail[RCU_DONE_TAIL] = rsp->orphan_donelist;
-		for (i = RCU_NEXT_SIZE - 1; i >= RCU_DONE_TAIL; i--)
-			if (rdp->nxttail[i] == rdp->nxttail[RCU_DONE_TAIL])
-				rdp->nxttail[i] = rsp->orphan_donetail;
-		rsp->orphan_donelist = NULL;
-		rsp->orphan_donetail = &rsp->orphan_donelist;
-	}
-
-	/* And then adopt the callbacks that still need a grace period. */
-	if (rsp->orphan_nxtlist != NULL) {
-		*rdp->nxttail[RCU_NEXT_TAIL] = rsp->orphan_nxtlist;
-		rdp->nxttail[RCU_NEXT_TAIL] = rsp->orphan_nxttail;
-		rsp->orphan_nxtlist = NULL;
-		rsp->orphan_nxttail = &rsp->orphan_nxtlist;
-	}
-}
-
-/*
  * Trace the fact that this CPU is going offline.
  */
 static void rcu_cleanup_dying_cpu(struct rcu_state *rsp)
@@ -2805,14 +2697,12 @@ static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf)
 
 /*
  * The CPU has been completely removed, and some other CPU is reporting
- * this fact from process context.  Do the remainder of the cleanup,
- * including orphaning the outgoing CPU's RCU callbacks, and also
- * adopting them.  There can only be one CPU hotplug operation at a time,
- * so no other CPU can be attempting to update rcu_cpu_kthread_task.
+ * this fact from process context.  Do the remainder of the cleanup.
+ * There can only be one CPU hotplug operation at a time, so no need for
+ * explicit locking.
  */
 static void rcu_cleanup_dead_cpu(int cpu, struct rcu_state *rsp)
 {
-	unsigned long flags;
 	struct rcu_data *rdp = per_cpu_ptr(rsp->rda, cpu);
 	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
 
@@ -2821,16 +2711,6 @@ static void rcu_cleanup_dead_cpu(int cpu, struct rcu_state *rsp)
 
 	/* Adjust any no-longer-needed kthreads. */
 	rcu_boost_kthread_setaffinity(rnp, -1);
-
-	/* Orphan the dead CPU's callbacks, and adopt them if appropriate. */
-	raw_spin_lock_irqsave(&rsp->orphan_lock, flags);
-	rcu_send_cbs_to_orphanage(cpu, rsp, rnp, rdp);
-	rcu_adopt_orphan_cbs(rsp, flags);
-	raw_spin_unlock_irqrestore(&rsp->orphan_lock, flags);
-
-	WARN_ONCE(rdp->qlen != 0 || rdp->nxtlist != NULL,
-		  "rcu_cleanup_dead_cpu: Callbacks on offline CPU %d: qlen=%lu, nxtlist=%p\n",
-		  cpu, rdp->qlen, rdp->nxtlist);
 }
 
 /*
@@ -4011,6 +3891,140 @@ void rcu_report_dead(unsigned int cpu)
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
+	/* No-CBs CPUs do not have orphanable callbacks. */
+	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU) || rcu_is_nocb_cpu(rdp->cpu))
+		return;
+
+	/*
+	 * Orphan the callbacks.  First adjust the counts.  This is safe
+	 * because _rcu_barrier() excludes CPU-hotplug operations, so it
+	 * cannot be running now.  Thus no memory barrier is required.
+	 */
+	if (rdp->nxtlist != NULL) {
+		rsp->qlen_lazy += rdp->qlen_lazy;
+		rsp->qlen += rdp->qlen;
+		rdp->n_cbs_orphaned += rdp->qlen;
+		rdp->qlen_lazy = 0;
+		WRITE_ONCE(rdp->qlen, 0);
+	}
+
+	/*
+	 * Next, move those callbacks still needing a grace period to
+	 * the orphanage, where some other CPU will pick them up.
+	 * Some of the callbacks might have gone partway through a grace
+	 * period, but that is too bad.  They get to start over because we
+	 * cannot assume that grace periods are synchronized across CPUs.
+	 * We don't bother updating the ->nxttail[] array yet, instead
+	 * we just reset the whole thing later on.
+	 */
+	if (*rdp->nxttail[RCU_DONE_TAIL] != NULL) {
+		*rsp->orphan_nxttail = *rdp->nxttail[RCU_DONE_TAIL];
+		rsp->orphan_nxttail = rdp->nxttail[RCU_NEXT_TAIL];
+		*rdp->nxttail[RCU_DONE_TAIL] = NULL;
+	}
+
+	/*
+	 * Then move the ready-to-invoke callbacks to the orphanage,
+	 * where some other CPU will pick them up.  These will not be
+	 * required to pass though another grace period: They are done.
+	 */
+	if (rdp->nxtlist != NULL) {
+		*rsp->orphan_donetail = rdp->nxtlist;
+		rsp->orphan_donetail = rdp->nxttail[RCU_DONE_TAIL];
+	}
+
+	/*
+	 * Finally, initialize the rcu_data structure's list to empty and
+	 * disallow further callbacks on this CPU.
+	 */
+	init_callback_list(rdp);
+	rdp->nxttail[RCU_NEXT_TAIL] = NULL;
+}
+
+/*
+ * Adopt the RCU callbacks from the specified rcu_state structure's
+ * orphanage.  The caller must hold the ->orphan_lock.
+ */
+static void rcu_adopt_orphan_cbs(struct rcu_state *rsp, unsigned long flags)
+{
+	int i;
+	struct rcu_data *rdp = raw_cpu_ptr(rsp->rda);
+
+	/* No-CBs CPUs are handled specially. */
+	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU) ||
+	    rcu_nocb_adopt_orphan_cbs(rsp, rdp, flags))
+		return;
+
+	/* Do the accounting first. */
+	rdp->qlen_lazy += rsp->qlen_lazy;
+	rdp->qlen += rsp->qlen;
+	rdp->n_cbs_adopted += rsp->qlen;
+	if (rsp->qlen_lazy != rsp->qlen)
+		rcu_idle_count_callbacks_posted();
+	rsp->qlen_lazy = 0;
+	rsp->qlen = 0;
+
+	/*
+	 * We do not need a memory barrier here because the only way we
+	 * can get here if there is an rcu_barrier() in flight is if
+	 * we are the task doing the rcu_barrier().
+	 */
+
+	/* First adopt the ready-to-invoke callbacks. */
+	if (rsp->orphan_donelist != NULL) {
+		*rsp->orphan_donetail = *rdp->nxttail[RCU_DONE_TAIL];
+		*rdp->nxttail[RCU_DONE_TAIL] = rsp->orphan_donelist;
+		for (i = RCU_NEXT_SIZE - 1; i >= RCU_DONE_TAIL; i--)
+			if (rdp->nxttail[i] == rdp->nxttail[RCU_DONE_TAIL])
+				rdp->nxttail[i] = rsp->orphan_donetail;
+		rsp->orphan_donelist = NULL;
+		rsp->orphan_donetail = &rsp->orphan_donelist;
+	}
+
+	/* And then adopt the callbacks that still need a grace period. */
+	if (rsp->orphan_nxtlist != NULL) {
+		*rdp->nxttail[RCU_NEXT_TAIL] = rsp->orphan_nxtlist;
+		rdp->nxttail[RCU_NEXT_TAIL] = rsp->orphan_nxttail;
+		rsp->orphan_nxtlist = NULL;
+		rsp->orphan_nxttail = &rsp->orphan_nxtlist;
+	}
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
 
 static int rcu_pm_notify(struct notifier_block *self,
