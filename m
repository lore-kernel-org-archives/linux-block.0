Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Wed, 13 Dec 2017 11:46:17 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Byungchul Park <max.byungchul.park@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, david@fromorbit.com,
        tytso@mit.edu, willy@infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>, byungchul.park@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        oleg@redhat.com
Subject: [PATCH] locking/lockdep: Remove the cross-release locking checks
Message-ID: <20171213104617.7lffucjhaa6xb7lp@gmail.com>
References: <CANrsvRPQcWz-p_3TYfNf+Waek3bcNNPniXhFzyyS=7qbCqzGyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANrsvRPQcWz-p_3TYfNf+Waek3bcNNPniXhFzyyS=7qbCqzGyg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>


* Byungchul Park <max.byungchul.park@gmail.com> wrote:

> Lockdep works, based on the following:
> 
>    (1) Classifying locks properly
>    (2) Checking relationship between the classes
> 
> If (1) is not good or (2) is not good, then we
> might get false positives.
> 
> For (1), we don't have to classify locks 100%
> properly but need as enough as lockdep works.
> 
> For (2), we should have a mechanism w/o
> logical defects.
> 
> Cross-release added an additional capacity to
> (2) and requires (1) to get more precisely classified.
> 
> Since the current classification level is too low for
> cross-release to work, false positives are being
> reported frequently with enabling cross-release.
> Yes. It's a obvious problem. It needs to be off by
> default until the classification is done by the level
> that cross-release requires.
> 
> But, the logic (2) is valid and logically true. Please
> keep the code, mechanism, and logic.

Just to give a full context to everyone: the patch that removes the cross-release 
locking checks was Cc:-ed to lkml, I've attached the patch below again.

In general, as described in the changelog, the cross-release checks were 
historically just too painful (first they were too slow, and they also had a lot 
of false positives), and today, 4 months after its introduction, the cross-release 
checks *still* produce numerous false positives, especially in the filesystem 
space, but the continuous-integration testing folks were still having trouble with 
kthread locking patterns causing false positives:

  https://bugs.freedesktop.org/show_bug.cgi?id=103950

which were resulting in two bad reactions:

 - turning off lockdep

 - writing patches that uglified unrelated subsystems

So while I appreciate the fixes that resulted from running cross-release, there's 
still numerous false positives, months after its interaction, which is 
unacceptable. For us to have this feature it has to have roughly similar qualities 
as compiler warnings:

 - there's a "zero false positive warnings" policy

 - plus any widespread changes to avoid warnings has to improve the code,
   not make it uglier.

Lockdep itself is a following that policy: the default state is that it produces 
no warnings upstream, and any annotations added to unrelated code documents the 
locking hierarchies.

While technically we could keep the cross-release checking code upstream and turn 
it off by default via the Kconfig switch, I'm not a big believer in such a policy 
for complex debugging code:

 - We already did that for v4.14, two months ago:

     b483cf3bc249: locking/lockdep: Disable cross-release features for now

   ... and re-enabled it for v4.15 - but the false positives are still not fixed.

 - either the cross-release checking code can be fixed and then having it off by
   default is just wrong, because we can apply the fixed code again once it's
   fixed.

 - or it cannot be fixed (or we don't have the manpower/interest to fix it),
   in which case having it off is only delaying the inevitable.

In any case, for v4.15 it's clear that the false positives are too numerous.

Thanks,

	Ingo


=============================>
>From e966eaeeb623f09975ef362c2866fae6f86844f9 Mon Sep 17 00:00:00 2001
From: Ingo Molnar <mingo@kernel.org>
Date: Tue, 12 Dec 2017 12:31:16 +0100
Subject: [PATCH] locking/lockdep: Remove the cross-release locking checks

This code (CONFIG_LOCKDEP_CROSSRELEASE=y and CONFIG_LOCKDEP_COMPLETIONS=y),
while it found a number of old bugs initially, was also causing too many
false positives that caused people to disable lockdep - which is arguably
a worse overall outcome.

If we disable cross-release by default but keep the code upstream then
in practice the most likely outcome is that we'll allow the situation
to degrade gradually, by allowing entropy to introduce more and more
false positives, until it overwhelms maintenance capacity.

Another bad side effect was that people were trying to work around
the false positives by uglifying/complicating unrelated code. There's
a marked difference between annotating locking operations and
uglifying good code just due to bad lock debugging code ...

This gradual decrease in quality happened to a number of debugging
facilities in the kernel, and lockdep is pretty complex already,
so we cannot risk this outcome.

Either cross-release checking can be done right with no false positives,
or it should not be included in the upstream kernel.

( Note that it might make sense to maintain it out of tree and go through
  the false positives every now and then and see whether new bugs were
  introduced. )

Cc: Byungchul Park <byungchul.park@lge.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/locking/crossrelease.txt | 874 ---------------------------------
 include/linux/completion.h             |  45 --
 include/linux/lockdep.h                | 125 -----
 include/linux/sched.h                  |  11 -
 kernel/locking/lockdep.c               | 652 ++----------------------
 lib/Kconfig.debug                      |  33 --
 6 files changed, 35 insertions(+), 1705 deletions(-)

diff --git a/Documentation/locking/crossrelease.txt b/Documentation/locking/crossrelease.txt
deleted file mode 100644
index bdf1423d5f99..000000000000
--- a/Documentation/locking/crossrelease.txt
+++ /dev/null
@@ -1,874 +0,0 @@
-Crossrelease
-============
-
-Started by Byungchul Park <byungchul.park@lge.com>
-
-Contents:
-
- (*) Background
-
-     - What causes deadlock
-     - How lockdep works
-
- (*) Limitation
-
-     - Limit lockdep
-     - Pros from the limitation
-     - Cons from the limitation
-     - Relax the limitation
-
- (*) Crossrelease
-
-     - Introduce crossrelease
-     - Introduce commit
-
- (*) Implementation
-
-     - Data structures
-     - How crossrelease works
-
- (*) Optimizations
-
-     - Avoid duplication
-     - Lockless for hot paths
-
- (*) APPENDIX A: What lockdep does to work aggresively
-
- (*) APPENDIX B: How to avoid adding false dependencies
-
-
-==========
-Background
-==========
-
-What causes deadlock
---------------------
-
-A deadlock occurs when a context is waiting for an event to happen,
-which is impossible because another (or the) context who can trigger the
-event is also waiting for another (or the) event to happen, which is
-also impossible due to the same reason.
-
-For example:
-
-   A context going to trigger event C is waiting for event A to happen.
-   A context going to trigger event A is waiting for event B to happen.
-   A context going to trigger event B is waiting for event C to happen.
-
-A deadlock occurs when these three wait operations run at the same time,
-because event C cannot be triggered if event A does not happen, which in
-turn cannot be triggered if event B does not happen, which in turn
-cannot be triggered if event C does not happen. After all, no event can
-be triggered since any of them never meets its condition to wake up.
-
-A dependency might exist between two waiters and a deadlock might happen
-due to an incorrect releationship between dependencies. Thus, we must
-define what a dependency is first. A dependency exists between them if:
-
-   1. There are two waiters waiting for each event at a given time.
-   2. The only way to wake up each waiter is to trigger its event.
-   3. Whether one can be woken up depends on whether the other can.
-
-Each wait in the example creates its dependency like:
-
-   Event C depends on event A.
-   Event A depends on event B.
-   Event B depends on event C.
-
-   NOTE: Precisely speaking, a dependency is one between whether a
-   waiter for an event can be woken up and whether another waiter for
-   another event can be woken up. However from now on, we will describe
-   a dependency as if it's one between an event and another event for
-   simplicity.
-
-And they form circular dependencies like:
-
-    -> C -> A -> B -
-   /                \
-   \                /
-    ----------------
-
-   where 'A -> B' means that event A depends on event B.
-
-Such circular dependencies lead to a deadlock since no waiter can meet
-its condition to wake up as described.
-
-CONCLUSION
-
-Circular dependencies cause a deadlock.
-
-
-How lockdep works
------------------
-
-Lockdep tries to detect a deadlock by checking dependencies created by
-lock operations, acquire and release. Waiting for a lock corresponds to
-waiting for an event, and releasing a lock corresponds to triggering an
-event in the previous section.
-
-In short, lockdep does:
-
-   1. Detect a new dependency.
-   2. Add the dependency into a global graph.
-   3. Check if that makes dependencies circular.
-   4. Report a deadlock or its possibility if so.
-
-For example, consider a graph built by lockdep that looks like:
-
-   A -> B -
-           \
-            -> E
-           /
-   C -> D -
-
-   where A, B,..., E are different lock classes.
-
-Lockdep will add a dependency into the graph on detection of a new
-dependency. For example, it will add a dependency 'E -> C' when a new
-dependency between lock E and lock C is detected. Then the graph will be:
-
-       A -> B -
-               \
-                -> E -
-               /      \
-    -> C -> D -        \
-   /                   /
-   \                  /
-    ------------------
-
-   where A, B,..., E are different lock classes.
-
-This graph contains a subgraph which demonstrates circular dependencies:
-
-                -> E -
-               /      \
-    -> C -> D -        \
-   /                   /
-   \                  /
-    ------------------
-
-   where C, D and E are different lock classes.
-
-This is the condition under which a deadlock might occur. Lockdep
-reports it on detection after adding a new dependency. This is the way
-how lockdep works.
-
-CONCLUSION
-
-Lockdep detects a deadlock or its possibility by checking if circular
-dependencies were created after adding each new dependency.
-
-
-==========
-Limitation
-==========
-
-Limit lockdep
--------------
-
-Limiting lockdep to work on only typical locks e.g. spin locks and
-mutexes, which are released within the acquire context, the
-implementation becomes simple but its capacity for detection becomes
-limited. Let's check pros and cons in next section.
-
-
-Pros from the limitation
-------------------------
-
-Given the limitation, when acquiring a lock, locks in a held_locks
-cannot be released if the context cannot acquire it so has to wait to
-acquire it, which means all waiters for the locks in the held_locks are
-stuck. It's an exact case to create dependencies between each lock in
-the held_locks and the lock to acquire.
-
-For example:
-
-   CONTEXT X
-   ---------
-   acquire A
-   acquire B /* Add a dependency 'A -> B' */
-   release B
-   release A
-
-   where A and B are different lock classes.
-
-When acquiring lock A, the held_locks of CONTEXT X is empty thus no
-dependency is added. But when acquiring lock B, lockdep detects and adds
-a new dependency 'A -> B' between lock A in the held_locks and lock B.
-They can be simply added whenever acquiring each lock.
-
-And data required by lockdep exists in a local structure, held_locks
-embedded in task_struct. Forcing to access the data within the context,
-lockdep can avoid racy problems without explicit locks while handling
-the local data.
-
-Lastly, lockdep only needs to keep locks currently being held, to build
-a dependency graph. However, relaxing the limitation, it needs to keep
-even locks already released, because a decision whether they created
-dependencies might be long-deferred.
-
-To sum up, we can expect several advantages from the limitation:
-
-   1. Lockdep can easily identify a dependency when acquiring a lock.
-   2. Races are avoidable while accessing local locks in a held_locks.
-   3. Lockdep only needs to keep locks currently being held.
-
-CONCLUSION
-
-Given the limitation, the implementation becomes simple and efficient.
-
-
-Cons from the limitation
-------------------------
-
-Given the limitation, lockdep is applicable only to typical locks. For
-example, page locks for page access or completions for synchronization
-cannot work with lockdep.
-
-Can we detect deadlocks below, under the limitation?
-
-Example 1:
-
-   CONTEXT X	   CONTEXT Y	   CONTEXT Z
-   ---------	   ---------	   ----------
-		   mutex_lock A
-   lock_page B
-		   lock_page B
-				   mutex_lock A /* DEADLOCK */
-				   unlock_page B held by X
-		   unlock_page B
-		   mutex_unlock A
-				   mutex_unlock A
-
-   where A and B are different lock classes.
-
-No, we cannot.
-
-Example 2:
-
-   CONTEXT X		   CONTEXT Y
-   ---------		   ---------
-			   mutex_lock A
-   mutex_lock A
-			   wait_for_complete B /* DEADLOCK */
-   complete B
-			   mutex_unlock A
-   mutex_unlock A
-
-   where A is a lock class and B is a completion variable.
-
-No, we cannot.
-
-CONCLUSION
-
-Given the limitation, lockdep cannot detect a deadlock or its
-possibility caused by page locks or completions.
-
-
-Relax the limitation
---------------------
-
-Under the limitation, things to create dependencies are limited to
-typical locks. However, synchronization primitives like page locks and
-completions, which are allowed to be released in any context, also
-create dependencies and can cause a deadlock. So lockdep should track
-these locks to do a better job. We have to relax the limitation for
-these locks to work with lockdep.
-
-Detecting dependencies is very important for lockdep to work because
-adding a dependency means adding an opportunity to check whether it
-causes a deadlock. The more lockdep adds dependencies, the more it
-thoroughly works. Thus Lockdep has to do its best to detect and add as
-many true dependencies into a graph as possible.
-
-For example, considering only typical locks, lockdep builds a graph like:
-
-   A -> B -
-           \
-            -> E
-           /
-   C -> D -
-
-   where A, B,..., E are different lock classes.
-
-On the other hand, under the relaxation, additional dependencies might
-be created and added. Assuming additional 'FX -> C' and 'E -> GX' are
-added thanks to the relaxation, the graph will be:
-
-         A -> B -
-                 \
-                  -> E -> GX
-                 /
-   FX -> C -> D -
-
-   where A, B,..., E, FX and GX are different lock classes, and a suffix
-   'X' is added on non-typical locks.
-
-The latter graph gives us more chances to check circular dependencies
-than the former. However, it might suffer performance degradation since
-relaxing the limitation, with which design and implementation of lockdep
-can be efficient, might introduce inefficiency inevitably. So lockdep
-should provide two options, strong detection and efficient detection.
-
-Choosing efficient detection:
-
-   Lockdep works with only locks restricted to be released within the
-   acquire context. However, lockdep works efficiently.
-
-Choosing strong detection:
-
-   Lockdep works with all synchronization primitives. However, lockdep
-   suffers performance degradation.
-
-CONCLUSION
-
-Relaxing the limitation, lockdep can add additional dependencies giving
-additional opportunities to check circular dependencies.
-
-
-============
-Crossrelease
-============
-
-Introduce crossrelease
-----------------------
-
-In order to allow lockdep to handle additional dependencies by what
-might be released in any context, namely 'crosslock', we have to be able
-to identify those created by crosslocks. The proposed 'crossrelease'
-feature provoides a way to do that.
-
-Crossrelease feature has to do:
-
-   1. Identify dependencies created by crosslocks.
-   2. Add the dependencies into a dependency graph.
-
-That's all. Once a meaningful dependency is added into graph, then
-lockdep would work with the graph as it did. The most important thing
-crossrelease feature has to do is to correctly identify and add true
-dependencies into the global graph.
-
-A dependency e.g. 'A -> B' can be identified only in the A's release
-context because a decision required to identify the dependency can be
-made only in the release context. That is to decide whether A can be
-released so that a waiter for A can be woken up. It cannot be made in
-other than the A's release context.
-
-It's no matter for typical locks because each acquire context is same as
-its release context, thus lockdep can decide whether a lock can be
-released in the acquire context. However for crosslocks, lockdep cannot
-make the decision in the acquire context but has to wait until the
-release context is identified.
-
-Therefore, deadlocks by crosslocks cannot be detected just when it
-happens, because those cannot be identified until the crosslocks are
-released. However, deadlock possibilities can be detected and it's very
-worth. See 'APPENDIX A' section to check why.
-
-CONCLUSION
-
-Using crossrelease feature, lockdep can work with what might be released
-in any context, namely crosslock.
-
-
-Introduce commit
-----------------
-
-Since crossrelease defers the work adding true dependencies of
-crosslocks until they are actually released, crossrelease has to queue
-all acquisitions which might create dependencies with the crosslocks.
-Then it identifies dependencies using the queued data in batches at a
-proper time. We call it 'commit'.
-
-There are four types of dependencies:
-
-1. TT type: 'typical lock A -> typical lock B'
-
-   Just when acquiring B, lockdep can see it's in the A's release
-   context. So the dependency between A and B can be identified
-   immediately. Commit is unnecessary.
-
-2. TC type: 'typical lock A -> crosslock BX'
-
-   Just when acquiring BX, lockdep can see it's in the A's release
-   context. So the dependency between A and BX can be identified
-   immediately. Commit is unnecessary, too.
-
-3. CT type: 'crosslock AX -> typical lock B'
-
-   When acquiring B, lockdep cannot identify the dependency because
-   there's no way to know if it's in the AX's release context. It has
-   to wait until the decision can be made. Commit is necessary.
-
-4. CC type: 'crosslock AX -> crosslock BX'
-
-   When acquiring BX, lockdep cannot identify the dependency because
-   there's no way to know if it's in the AX's release context. It has
-   to wait until the decision can be made. Commit is necessary.
-   But, handling CC type is not implemented yet. It's a future work.
-
-Lockdep can work without commit for typical locks, but commit step is
-necessary once crosslocks are involved. Introducing commit, lockdep
-performs three steps. What lockdep does in each step is:
-
-1. Acquisition: For typical locks, lockdep does what it originally did
-   and queues the lock so that CT type dependencies can be checked using
-   it at the commit step. For crosslocks, it saves data which will be
-   used at the commit step and increases a reference count for it.
-
-2. Commit: No action is reauired for typical locks. For crosslocks,
-   lockdep adds CT type dependencies using the data saved at the
-   acquisition step.
-
-3. Release: No changes are required for typical locks. When a crosslock
-   is released, it decreases a reference count for it.
-
-CONCLUSION
-
-Crossrelease introduces commit step to handle dependencies of crosslocks
-in batches at a proper time.
-
-
-==============
-Implementation
-==============
-
-Data structures
----------------
-
-Crossrelease introduces two main data structures.
-
-1. hist_lock
-
-   This is an array embedded in task_struct, for keeping lock history so
-   that dependencies can be added using them at the commit step. Since
-   it's local data, it can be accessed locklessly in the owner context.
-   The array is filled at the acquisition step and consumed at the
-   commit step. And it's managed in circular manner.
-
-2. cross_lock
-
-   One per lockdep_map exists. This is for keeping data of crosslocks
-   and used at the commit step.
-
-
-How crossrelease works
-----------------------
-
-It's the key of how crossrelease works, to defer necessary works to an
-appropriate point in time and perform in at once at the commit step.
-Let's take a look with examples step by step, starting from how lockdep
-works without crossrelease for typical locks.
-
-   acquire A /* Push A onto held_locks */
-   acquire B /* Push B onto held_locks and add 'A -> B' */
-   acquire C /* Push C onto held_locks and add 'B -> C' */
-   release C /* Pop C from held_locks */
-   release B /* Pop B from held_locks */
-   release A /* Pop A from held_locks */
-
-   where A, B and C are different lock classes.
-
-   NOTE: This document assumes that readers already understand how
-   lockdep works without crossrelease thus omits details. But there's
-   one thing to note. Lockdep pretends to pop a lock from held_locks
-   when releasing it. But it's subtly different from the original pop
-   operation because lockdep allows other than the top to be poped.
-
-In this case, lockdep adds 'the top of held_locks -> the lock to acquire'
-dependency every time acquiring a lock.
-
-After adding 'A -> B', a dependency graph will be:
-
-   A -> B
-
-   where A and B are different lock classes.
-
-And after adding 'B -> C', the graph will be:
-
-   A -> B -> C
-
-   where A, B and C are different lock classes.
-
-Let's performs commit step even for typical locks to add dependencies.
-Of course, commit step is not necessary for them, however, it would work
-well because this is a more general way.
-
-   acquire A
-   /*
-    * Queue A into hist_locks
-    *
-    * In hist_locks: A
-    * In graph: Empty
-    */
-
-   acquire B
-   /*
-    * Queue B into hist_locks
-    *
-    * In hist_locks: A, B
-    * In graph: Empty
-    */
-
-   acquire C
-   /*
-    * Queue C into hist_locks
-    *
-    * In hist_locks: A, B, C
-    * In graph: Empty
-    */
-
-   commit C
-   /*
-    * Add 'C -> ?'
-    * Answer the following to decide '?'
-    * What has been queued since acquire C: Nothing
-    *
-    * In hist_locks: A, B, C
-    * In graph: Empty
-    */
-
-   release C
-
-   commit B
-   /*
-    * Add 'B -> ?'
-    * Answer the following to decide '?'
-    * What has been queued since acquire B: C
-    *
-    * In hist_locks: A, B, C
-    * In graph: 'B -> C'
-    */
-
-   release B
-
-   commit A
-   /*
-    * Add 'A -> ?'
-    * Answer the following to decide '?'
-    * What has been queued since acquire A: B, C
-    *
-    * In hist_locks: A, B, C
-    * In graph: 'B -> C', 'A -> B', 'A -> C'
-    */
-
-   release A
-
-   where A, B and C are different lock classes.
-
-In this case, dependencies are added at the commit step as described.
-
-After commits for A, B and C, the graph will be:
-
-   A -> B -> C
-
-   where A, B and C are different lock classes.
-
-   NOTE: A dependency 'A -> C' is optimized out.
-
-We can see the former graph built without commit step is same as the
-latter graph built using commit steps. Of course the former way leads to
-earlier finish for building the graph, which means we can detect a
-deadlock or its possibility sooner. So the former way would be prefered
-when possible. But we cannot avoid using the latter way for crosslocks.
-
-Let's look at how commit steps work for crosslocks. In this case, the
-commit step is performed only on crosslock AX as real. And it assumes
-that the AX release context is different from the AX acquire context.
-
-   BX RELEASE CONTEXT		   BX ACQUIRE CONTEXT
-   ------------------		   ------------------
-				   acquire A
-				   /*
-				    * Push A onto held_locks
-				    * Queue A into hist_locks
-				    *
-				    * In held_locks: A
-				    * In hist_locks: A
-				    * In graph: Empty
-				    */
-
-				   acquire BX
-				   /*
-				    * Add 'the top of held_locks -> BX'
-				    *
-				    * In held_locks: A
-				    * In hist_locks: A
-				    * In graph: 'A -> BX'
-				    */
-
-   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-   It must be guaranteed that the following operations are seen after
-   acquiring BX globally. It can be done by things like barrier.
-   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-   acquire C
-   /*
-    * Push C onto held_locks
-    * Queue C into hist_locks
-    *
-    * In held_locks: C
-    * In hist_locks: C
-    * In graph: 'A -> BX'
-    */
-
-   release C
-   /*
-    * Pop C from held_locks
-    *
-    * In held_locks: Empty
-    * In hist_locks: C
-    * In graph: 'A -> BX'
-    */
-				   acquire D
-				   /*
-				    * Push D onto held_locks
-				    * Queue D into hist_locks
-				    * Add 'the top of held_locks -> D'
-				    *
-				    * In held_locks: A, D
-				    * In hist_locks: A, D
-				    * In graph: 'A -> BX', 'A -> D'
-				    */
-   acquire E
-   /*
-    * Push E onto held_locks
-    * Queue E into hist_locks
-    *
-    * In held_locks: E
-    * In hist_locks: C, E
-    * In graph: 'A -> BX', 'A -> D'
-    */
-
-   release E
-   /*
-    * Pop E from held_locks
-    *
-    * In held_locks: Empty
-    * In hist_locks: D, E
-    * In graph: 'A -> BX', 'A -> D'
-    */
-				   release D
-				   /*
-				    * Pop D from held_locks
-				    *
-				    * In held_locks: A
-				    * In hist_locks: A, D
-				    * In graph: 'A -> BX', 'A -> D'
-				    */
-   commit BX
-   /*
-    * Add 'BX -> ?'
-    * What has been queued since acquire BX: C, E
-    *
-    * In held_locks: Empty
-    * In hist_locks: D, E
-    * In graph: 'A -> BX', 'A -> D',
-    *           'BX -> C', 'BX -> E'
-    */
-
-   release BX
-   /*
-    * In held_locks: Empty
-    * In hist_locks: D, E
-    * In graph: 'A -> BX', 'A -> D',
-    *           'BX -> C', 'BX -> E'
-    */
-				   release A
-				   /*
-				    * Pop A from held_locks
-				    *
-				    * In held_locks: Empty
-				    * In hist_locks: A, D
-				    * In graph: 'A -> BX', 'A -> D',
-				    *           'BX -> C', 'BX -> E'
-				    */
-
-   where A, BX, C,..., E are different lock classes, and a suffix 'X' is
-   added on crosslocks.
-
-Crossrelease considers all acquisitions after acqiuring BX are
-candidates which might create dependencies with BX. True dependencies
-will be determined when identifying the release context of BX. Meanwhile,
-all typical locks are queued so that they can be used at the commit step.
-And then two dependencies 'BX -> C' and 'BX -> E' are added at the
-commit step when identifying the release context.
-
-The final graph will be, with crossrelease:
-
-               -> C
-              /
-       -> BX -
-      /       \
-   A -         -> E
-      \
-       -> D
-
-   where A, BX, C,..., E are different lock classes, and a suffix 'X' is
-   added on crosslocks.
-
-However, the final graph will be, without crossrelease:
-
-   A -> D
-
-   where A and D are different lock classes.
-
-The former graph has three more dependencies, 'A -> BX', 'BX -> C' and
-'BX -> E' giving additional opportunities to check if they cause
-deadlocks. This way lockdep can detect a deadlock or its possibility
-caused by crosslocks.
-
-CONCLUSION
-
-We checked how crossrelease works with several examples.
-
-
-=============
-Optimizations
-=============
-
-Avoid duplication
------------------
-
-Crossrelease feature uses a cache like what lockdep already uses for
-dependency chains, but this time it's for caching CT type dependencies.
-Once that dependency is cached, the same will never be added again.
-
-
-Lockless for hot paths
-----------------------
-
-To keep all locks for later use at the commit step, crossrelease adopts
-a local array embedded in task_struct, which makes access to the data
-lockless by forcing it to happen only within the owner context. It's
-like how lockdep handles held_locks. Lockless implmentation is important
-since typical locks are very frequently acquired and released.
-
-
-=================================================
-APPENDIX A: What lockdep does to work aggresively
-=================================================
-
-A deadlock actually occurs when all wait operations creating circular
-dependencies run at the same time. Even though they don't, a potential
-deadlock exists if the problematic dependencies exist. Thus it's
-meaningful to detect not only an actual deadlock but also its potential
-possibility. The latter is rather valuable. When a deadlock occurs
-actually, we can identify what happens in the system by some means or
-other even without lockdep. However, there's no way to detect possiblity
-without lockdep unless the whole code is parsed in head. It's terrible.
-Lockdep does the both, and crossrelease only focuses on the latter.
-
-Whether or not a deadlock actually occurs depends on several factors.
-For example, what order contexts are switched in is a factor. Assuming
-circular dependencies exist, a deadlock would occur when contexts are
-switched so that all wait operations creating the dependencies run
-simultaneously. Thus to detect a deadlock possibility even in the case
-that it has not occured yet, lockdep should consider all possible
-combinations of dependencies, trying to:
-
-1. Use a global dependency graph.
-
-   Lockdep combines all dependencies into one global graph and uses them,
-   regardless of which context generates them or what order contexts are
-   switched in. Aggregated dependencies are only considered so they are
-   prone to be circular if a problem exists.
-
-2. Check dependencies between classes instead of instances.
-
-   What actually causes a deadlock are instances of lock. However,
-   lockdep checks dependencies between classes instead of instances.
-   This way lockdep can detect a deadlock which has not happened but
-   might happen in future by others but the same class.
-
-3. Assume all acquisitions lead to waiting.
-
-   Although locks might be acquired without waiting which is essential
-   to create dependencies, lockdep assumes all acquisitions lead to
-   waiting since it might be true some time or another.
-
-CONCLUSION
-
-Lockdep detects not only an actual deadlock but also its possibility,
-and the latter is more valuable.
-
-
-==================================================
-APPENDIX B: How to avoid adding false dependencies
-==================================================
-
-Remind what a dependency is. A dependency exists if:
-
-   1. There are two waiters waiting for each event at a given time.
-   2. The only way to wake up each waiter is to trigger its event.
-   3. Whether one can be woken up depends on whether the other can.
-
-For example:
-
-   acquire A
-   acquire B /* A dependency 'A -> B' exists */
-   release B
-   release A
-
-   where A and B are different lock classes.
-
-A depedency 'A -> B' exists since:
-
-   1. A waiter for A and a waiter for B might exist when acquiring B.
-   2. Only way to wake up each is to release what it waits for.
-   3. Whether the waiter for A can be woken up depends on whether the
-      other can. IOW, TASK X cannot release A if it fails to acquire B.
-
-For another example:
-
-   TASK X			   TASK Y
-   ------			   ------
-				   acquire AX
-   acquire B /* A dependency 'AX -> B' exists */
-   release B
-   release AX held by Y
-
-   where AX and B are different lock classes, and a suffix 'X' is added
-   on crosslocks.
-
-Even in this case involving crosslocks, the same rule can be applied. A
-depedency 'AX -> B' exists since:
-
-   1. A waiter for AX and a waiter for B might exist when acquiring B.
-   2. Only way to wake up each is to release what it waits for.
-   3. Whether the waiter for AX can be woken up depends on whether the
-      other can. IOW, TASK X cannot release AX if it fails to acquire B.
-
-Let's take a look at more complicated example:
-
-   TASK X			   TASK Y
-   ------			   ------
-   acquire B
-   release B
-   fork Y
-				   acquire AX
-   acquire C /* A dependency 'AX -> C' exists */
-   release C
-   release AX held by Y
-
-   where AX, B and C are different lock classes, and a suffix 'X' is
-   added on crosslocks.
-
-Does a dependency 'AX -> B' exist? Nope.
-
-Two waiters are essential to create a dependency. However, waiters for
-AX and B to create 'AX -> B' cannot exist at the same time in this
-example. Thus the dependency 'AX -> B' cannot be created.
-
-It would be ideal if the full set of true ones can be considered. But
-we can ensure nothing but what actually happened. Relying on what
-actually happens at runtime, we can anyway add only true ones, though
-they might be a subset of true ones. It's similar to how lockdep works
-for typical locks. There might be more true dependencies than what
-lockdep has detected in runtime. Lockdep has no choice but to rely on
-what actually happens. Crossrelease also relies on it.
-
-CONCLUSION
-
-Relying on what actually happens, lockdep can avoid adding false
-dependencies.
diff --git a/include/linux/completion.h b/include/linux/completion.h
index 0662a417febe..94a59ba7d422 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -10,9 +10,6 @@
  */
 
 #include <linux/wait.h>
-#ifdef CONFIG_LOCKDEP_COMPLETIONS
-#include <linux/lockdep.h>
-#endif
 
 /*
  * struct completion - structure used to maintain state for a "completion"
@@ -29,58 +26,16 @@
 struct completion {
 	unsigned int done;
 	wait_queue_head_t wait;
-#ifdef CONFIG_LOCKDEP_COMPLETIONS
-	struct lockdep_map_cross map;
-#endif
 };
 
-#ifdef CONFIG_LOCKDEP_COMPLETIONS
-static inline void complete_acquire(struct completion *x)
-{
-	lock_acquire_exclusive((struct lockdep_map *)&x->map, 0, 0, NULL, _RET_IP_);
-}
-
-static inline void complete_release(struct completion *x)
-{
-	lock_release((struct lockdep_map *)&x->map, 0, _RET_IP_);
-}
-
-static inline void complete_release_commit(struct completion *x)
-{
-	lock_commit_crosslock((struct lockdep_map *)&x->map);
-}
-
-#define init_completion_map(x, m)					\
-do {									\
-	lockdep_init_map_crosslock((struct lockdep_map *)&(x)->map,	\
-			(m)->name, (m)->key, 0);				\
-	__init_completion(x);						\
-} while (0)
-
-#define init_completion(x)						\
-do {									\
-	static struct lock_class_key __key;				\
-	lockdep_init_map_crosslock((struct lockdep_map *)&(x)->map,	\
-			"(completion)" #x,				\
-			&__key, 0);					\
-	__init_completion(x);						\
-} while (0)
-#else
 #define init_completion_map(x, m) __init_completion(x)
 #define init_completion(x) __init_completion(x)
 static inline void complete_acquire(struct completion *x) {}
 static inline void complete_release(struct completion *x) {}
 static inline void complete_release_commit(struct completion *x) {}
-#endif
 
-#ifdef CONFIG_LOCKDEP_COMPLETIONS
-#define COMPLETION_INITIALIZER(work) \
-	{ 0, __WAIT_QUEUE_HEAD_INITIALIZER((work).wait), \
-	STATIC_CROSS_LOCKDEP_MAP_INIT("(completion)" #work, &(work)) }
-#else
 #define COMPLETION_INITIALIZER(work) \
 	{ 0, __WAIT_QUEUE_HEAD_INITIALIZER((work).wait) }
-#endif
 
 #define COMPLETION_INITIALIZER_ONSTACK_MAP(work, map) \
 	(*({ init_completion_map(&(work), &(map)); &(work); }))
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index a842551fe044..2e75dc34bff5 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -158,12 +158,6 @@ struct lockdep_map {
 	int				cpu;
 	unsigned long			ip;
 #endif
-#ifdef CONFIG_LOCKDEP_CROSSRELEASE
-	/*
-	 * Whether it's a crosslock.
-	 */
-	int				cross;
-#endif
 };
 
 static inline void lockdep_copy_map(struct lockdep_map *to,
@@ -267,95 +261,8 @@ struct held_lock {
 	unsigned int hardirqs_off:1;
 	unsigned int references:12;					/* 32 bits */
 	unsigned int pin_count;
-#ifdef CONFIG_LOCKDEP_CROSSRELEASE
-	/*
-	 * Generation id.
-	 *
-	 * A value of cross_gen_id will be stored when holding this,
-	 * which is globally increased whenever each crosslock is held.
-	 */
-	unsigned int gen_id;
-#endif
-};
-
-#ifdef CONFIG_LOCKDEP_CROSSRELEASE
-#define MAX_XHLOCK_TRACE_ENTRIES 5
-
-/*
- * This is for keeping locks waiting for commit so that true dependencies
- * can be added at commit step.
- */
-struct hist_lock {
-	/*
-	 * Id for each entry in the ring buffer. This is used to
-	 * decide whether the ring buffer was overwritten or not.
-	 *
-	 * For example,
-	 *
-	 *           |<----------- hist_lock ring buffer size ------->|
-	 *           pppppppppppppppppppppiiiiiiiiiiiiiiiiiiiiiiiiiiiii
-	 * wrapped > iiiiiiiiiiiiiiiiiiiiiiiiiii.......................
-	 *
-	 *           where 'p' represents an acquisition in process
-	 *           context, 'i' represents an acquisition in irq
-	 *           context.
-	 *
-	 * In this example, the ring buffer was overwritten by
-	 * acquisitions in irq context, that should be detected on
-	 * rollback or commit.
-	 */
-	unsigned int hist_id;
-
-	/*
-	 * Seperate stack_trace data. This will be used at commit step.
-	 */
-	struct stack_trace	trace;
-	unsigned long		trace_entries[MAX_XHLOCK_TRACE_ENTRIES];
-
-	/*
-	 * Seperate hlock instance. This will be used at commit step.
-	 *
-	 * TODO: Use a smaller data structure containing only necessary
-	 * data. However, we should make lockdep code able to handle the
-	 * smaller one first.
-	 */
-	struct held_lock	hlock;
 };
 
-/*
- * To initialize a lock as crosslock, lockdep_init_map_crosslock() should
- * be called instead of lockdep_init_map().
- */
-struct cross_lock {
-	/*
-	 * When more than one acquisition of crosslocks are overlapped,
-	 * we have to perform commit for them based on cross_gen_id of
-	 * the first acquisition, which allows us to add more true
-	 * dependencies.
-	 *
-	 * Moreover, when no acquisition of a crosslock is in progress,
-	 * we should not perform commit because the lock might not exist
-	 * any more, which might cause incorrect memory access. So we
-	 * have to track the number of acquisitions of a crosslock.
-	 */
-	int nr_acquire;
-
-	/*
-	 * Seperate hlock instance. This will be used at commit step.
-	 *
-	 * TODO: Use a smaller data structure containing only necessary
-	 * data. However, we should make lockdep code able to handle the
-	 * smaller one first.
-	 */
-	struct held_lock	hlock;
-};
-
-struct lockdep_map_cross {
-	struct lockdep_map map;
-	struct cross_lock xlock;
-};
-#endif
-
 /*
  * Initialization, self-test and debugging-output methods:
  */
@@ -560,37 +467,6 @@ enum xhlock_context_t {
 	XHLOCK_CTX_NR,
 };
 
-#ifdef CONFIG_LOCKDEP_CROSSRELEASE
-extern void lockdep_init_map_crosslock(struct lockdep_map *lock,
-				       const char *name,
-				       struct lock_class_key *key,
-				       int subclass);
-extern void lock_commit_crosslock(struct lockdep_map *lock);
-
-/*
- * What we essencially have to initialize is 'nr_acquire'. Other members
- * will be initialized in add_xlock().
- */
-#define STATIC_CROSS_LOCK_INIT() \
-	{ .nr_acquire = 0,}
-
-#define STATIC_CROSS_LOCKDEP_MAP_INIT(_name, _key) \
-	{ .map.name = (_name), .map.key = (void *)(_key), \
-	  .map.cross = 1, .xlock = STATIC_CROSS_LOCK_INIT(), }
-
-/*
- * To initialize a lockdep_map statically use this macro.
- * Note that _name must not be NULL.
- */
-#define STATIC_LOCKDEP_MAP_INIT(_name, _key) \
-	{ .name = (_name), .key = (void *)(_key), .cross = 0, }
-
-extern void crossrelease_hist_start(enum xhlock_context_t c);
-extern void crossrelease_hist_end(enum xhlock_context_t c);
-extern void lockdep_invariant_state(bool force);
-extern void lockdep_init_task(struct task_struct *task);
-extern void lockdep_free_task(struct task_struct *task);
-#else /* !CROSSRELEASE */
 #define lockdep_init_map_crosslock(m, n, k, s) do {} while (0)
 /*
  * To initialize a lockdep_map statically use this macro.
@@ -604,7 +480,6 @@ static inline void crossrelease_hist_end(enum xhlock_context_t c) {}
 static inline void lockdep_invariant_state(bool force) {}
 static inline void lockdep_init_task(struct task_struct *task) {}
 static inline void lockdep_free_task(struct task_struct *task) {}
-#endif /* CROSSRELEASE */
 
 #ifdef CONFIG_LOCK_STAT
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 21991d668d35..9ce6c3001e9f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -849,17 +849,6 @@ struct task_struct {
 	struct held_lock		held_locks[MAX_LOCK_DEPTH];
 #endif
 
-#ifdef CONFIG_LOCKDEP_CROSSRELEASE
-#define MAX_XHLOCKS_NR 64UL
-	struct hist_lock *xhlocks; /* Crossrelease history locks */
-	unsigned int xhlock_idx;
-	/* For restoring at history boundaries */
-	unsigned int xhlock_idx_hist[XHLOCK_CTX_NR];
-	unsigned int hist_id;
-	/* For overwrite check at each context exit */
-	unsigned int hist_id_save[XHLOCK_CTX_NR];
-#endif
-
 #ifdef CONFIG_UBSAN
 	unsigned int			in_ubsan;
 #endif
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 670d8d7d8087..5fa1324a4f29 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -57,10 +57,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/lock.h>
 
-#ifdef CONFIG_LOCKDEP_CROSSRELEASE
-#include <linux/slab.h>
-#endif
-
 #ifdef CONFIG_PROVE_LOCKING
 int prove_locking = 1;
 module_param(prove_locking, int, 0644);
@@ -75,19 +71,6 @@ module_param(lock_stat, int, 0644);
 #define lock_stat 0
 #endif
 
-#ifdef CONFIG_BOOTPARAM_LOCKDEP_CROSSRELEASE_FULLSTACK
-static int crossrelease_fullstack = 1;
-#else
-static int crossrelease_fullstack;
-#endif
-static int __init allow_crossrelease_fullstack(char *str)
-{
-	crossrelease_fullstack = 1;
-	return 0;
-}
-
-early_param("crossrelease_fullstack", allow_crossrelease_fullstack);
-
 /*
  * lockdep_lock: protects the lockdep graph, the hashes and the
  *               class/list/hash allocators.
@@ -740,18 +723,6 @@ look_up_lock_class(struct lockdep_map *lock, unsigned int subclass)
 	return is_static || static_obj(lock->key) ? NULL : ERR_PTR(-EINVAL);
 }
 
-#ifdef CONFIG_LOCKDEP_CROSSRELEASE
-static void cross_init(struct lockdep_map *lock, int cross);
-static int cross_lock(struct lockdep_map *lock);
-static int lock_acquire_crosslock(struct held_lock *hlock);
-static int lock_release_crosslock(struct lockdep_map *lock);
-#else
-static inline void cross_init(struct lockdep_map *lock, int cross) {}
-static inline int cross_lock(struct lockdep_map *lock) { return 0; }
-static inline int lock_acquire_crosslock(struct held_lock *hlock) { return 2; }
-static inline int lock_release_crosslock(struct lockdep_map *lock) { return 2; }
-#endif
-
 /*
  * Register a lock's class in the hash-table, if the class is not present
  * yet. Otherwise we look it up. We cache the result in the lock object
@@ -1151,41 +1122,22 @@ print_circular_lock_scenario(struct held_lock *src,
 		printk(KERN_CONT "\n\n");
 	}
 
-	if (cross_lock(tgt->instance)) {
-		printk(" Possible unsafe locking scenario by crosslock:\n\n");
-		printk("       CPU0                    CPU1\n");
-		printk("       ----                    ----\n");
-		printk("  lock(");
-		__print_lock_name(parent);
-		printk(KERN_CONT ");\n");
-		printk("  lock(");
-		__print_lock_name(target);
-		printk(KERN_CONT ");\n");
-		printk("                               lock(");
-		__print_lock_name(source);
-		printk(KERN_CONT ");\n");
-		printk("                               unlock(");
-		__print_lock_name(target);
-		printk(KERN_CONT ");\n");
-		printk("\n *** DEADLOCK ***\n\n");
-	} else {
-		printk(" Possible unsafe locking scenario:\n\n");
-		printk("       CPU0                    CPU1\n");
-		printk("       ----                    ----\n");
-		printk("  lock(");
-		__print_lock_name(target);
-		printk(KERN_CONT ");\n");
-		printk("                               lock(");
-		__print_lock_name(parent);
-		printk(KERN_CONT ");\n");
-		printk("                               lock(");
-		__print_lock_name(target);
-		printk(KERN_CONT ");\n");
-		printk("  lock(");
-		__print_lock_name(source);
-		printk(KERN_CONT ");\n");
-		printk("\n *** DEADLOCK ***\n\n");
-	}
+	printk(" Possible unsafe locking scenario:\n\n");
+	printk("       CPU0                    CPU1\n");
+	printk("       ----                    ----\n");
+	printk("  lock(");
+	__print_lock_name(target);
+	printk(KERN_CONT ");\n");
+	printk("                               lock(");
+	__print_lock_name(parent);
+	printk(KERN_CONT ");\n");
+	printk("                               lock(");
+	__print_lock_name(target);
+	printk(KERN_CONT ");\n");
+	printk("  lock(");
+	__print_lock_name(source);
+	printk(KERN_CONT ");\n");
+	printk("\n *** DEADLOCK ***\n\n");
 }
 
 /*
@@ -1211,10 +1163,7 @@ print_circular_bug_header(struct lock_list *entry, unsigned int depth,
 		curr->comm, task_pid_nr(curr));
 	print_lock(check_src);
 
-	if (cross_lock(check_tgt->instance))
-		pr_warn("\nbut now in release context of a crosslock acquired at the following:\n");
-	else
-		pr_warn("\nbut task is already holding lock:\n");
+	pr_warn("\nbut task is already holding lock:\n");
 
 	print_lock(check_tgt);
 	pr_warn("\nwhich lock already depends on the new lock.\n\n");
@@ -1244,9 +1193,7 @@ static noinline int print_circular_bug(struct lock_list *this,
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
 		return 0;
 
-	if (cross_lock(check_tgt->instance))
-		this->trace = *trace;
-	else if (!save_trace(&this->trace))
+	if (!save_trace(&this->trace))
 		return 0;
 
 	depth = get_lock_depth(target);
@@ -1850,9 +1797,6 @@ check_deadlock(struct task_struct *curr, struct held_lock *next,
 		if (nest)
 			return 2;
 
-		if (cross_lock(prev->instance))
-			continue;
-
 		return print_deadlock_bug(curr, prev, next);
 	}
 	return 1;
@@ -2018,31 +1962,26 @@ check_prevs_add(struct task_struct *curr, struct held_lock *next)
 	for (;;) {
 		int distance = curr->lockdep_depth - depth + 1;
 		hlock = curr->held_locks + depth - 1;
+
 		/*
-		 * Only non-crosslock entries get new dependencies added.
-		 * Crosslock entries will be added by commit later:
+		 * Only non-recursive-read entries get new dependencies
+		 * added:
 		 */
-		if (!cross_lock(hlock->instance)) {
+		if (hlock->read != 2 && hlock->check) {
+			int ret = check_prev_add(curr, hlock, next, distance, &trace, save_trace);
+			if (!ret)
+				return 0;
+
 			/*
-			 * Only non-recursive-read entries get new dependencies
-			 * added:
+			 * Stop after the first non-trylock entry,
+			 * as non-trylock entries have added their
+			 * own direct dependencies already, so this
+			 * lock is connected to them indirectly:
 			 */
-			if (hlock->read != 2 && hlock->check) {
-				int ret = check_prev_add(curr, hlock, next,
-							 distance, &trace, save_trace);
-				if (!ret)
-					return 0;
-
-				/*
-				 * Stop after the first non-trylock entry,
-				 * as non-trylock entries have added their
-				 * own direct dependencies already, so this
-				 * lock is connected to them indirectly:
-				 */
-				if (!hlock->trylock)
-					break;
-			}
+			if (!hlock->trylock)
+				break;
 		}
+
 		depth--;
 		/*
 		 * End of lock-stack?
@@ -3292,21 +3231,10 @@ static void __lockdep_init_map(struct lockdep_map *lock, const char *name,
 void lockdep_init_map(struct lockdep_map *lock, const char *name,
 		      struct lock_class_key *key, int subclass)
 {
-	cross_init(lock, 0);
 	__lockdep_init_map(lock, name, key, subclass);
 }
 EXPORT_SYMBOL_GPL(lockdep_init_map);
 
-#ifdef CONFIG_LOCKDEP_CROSSRELEASE
-void lockdep_init_map_crosslock(struct lockdep_map *lock, const char *name,
-		      struct lock_class_key *key, int subclass)
-{
-	cross_init(lock, 1);
-	__lockdep_init_map(lock, name, key, subclass);
-}
-EXPORT_SYMBOL_GPL(lockdep_init_map_crosslock);
-#endif
-
 struct lock_class_key __lockdep_no_validate__;
 EXPORT_SYMBOL_GPL(__lockdep_no_validate__);
 
@@ -3362,7 +3290,6 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	int chain_head = 0;
 	int class_idx;
 	u64 chain_key;
-	int ret;
 
 	if (unlikely(!debug_locks))
 		return 0;
@@ -3411,8 +3338,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 
 	class_idx = class - lock_classes + 1;
 
-	/* TODO: nest_lock is not implemented for crosslock yet. */
-	if (depth && !cross_lock(lock)) {
+	if (depth) {
 		hlock = curr->held_locks + depth - 1;
 		if (hlock->class_idx == class_idx && nest_lock) {
 			if (hlock->references) {
@@ -3500,14 +3426,6 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (!validate_chain(curr, lock, hlock, chain_head, chain_key))
 		return 0;
 
-	ret = lock_acquire_crosslock(hlock);
-	/*
-	 * 2 means normal acquire operations are needed. Otherwise, it's
-	 * ok just to return with '0:fail, 1:success'.
-	 */
-	if (ret != 2)
-		return ret;
-
 	curr->curr_chain_key = chain_key;
 	curr->lockdep_depth++;
 	check_chain_key(curr);
@@ -3745,19 +3663,11 @@ __lock_release(struct lockdep_map *lock, int nested, unsigned long ip)
 	struct task_struct *curr = current;
 	struct held_lock *hlock;
 	unsigned int depth;
-	int ret, i;
+	int i;
 
 	if (unlikely(!debug_locks))
 		return 0;
 
-	ret = lock_release_crosslock(lock);
-	/*
-	 * 2 means normal release operations are needed. Otherwise, it's
-	 * ok just to return with '0:fail, 1:success'.
-	 */
-	if (ret != 2)
-		return ret;
-
 	depth = curr->lockdep_depth;
 	/*
 	 * So we're all set to release this lock.. wait what lock? We don't
@@ -4675,495 +4585,3 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 	dump_stack();
 }
 EXPORT_SYMBOL_GPL(lockdep_rcu_suspicious);
-
-#ifdef CONFIG_LOCKDEP_CROSSRELEASE
-
-/*
- * Crossrelease works by recording a lock history for each thread and
- * connecting those historic locks that were taken after the
- * wait_for_completion() in the complete() context.
- *
- * Task-A				Task-B
- *
- *					mutex_lock(&A);
- *					mutex_unlock(&A);
- *
- * wait_for_completion(&C);
- *   lock_acquire_crosslock();
- *     atomic_inc_return(&cross_gen_id);
- *                                |
- *				  |	mutex_lock(&B);
- *				  |	mutex_unlock(&B);
- *                                |
- *				  |	complete(&C);
- *				  `--	  lock_commit_crosslock();
- *
- * Which will then add a dependency between B and C.
- */
-
-#define xhlock(i)         (current->xhlocks[(i) % MAX_XHLOCKS_NR])
-
-/*
- * Whenever a crosslock is held, cross_gen_id will be increased.
- */
-static atomic_t cross_gen_id; /* Can be wrapped */
-
-/*
- * Make an entry of the ring buffer invalid.
- */
-static inline void invalidate_xhlock(struct hist_lock *xhlock)
-{
-	/*
-	 * Normally, xhlock->hlock.instance must be !NULL.
-	 */
-	xhlock->hlock.instance = NULL;
-}
-
-/*
- * Lock history stacks; we have 2 nested lock history stacks:
- *
- *   HARD(IRQ)
- *   SOFT(IRQ)
- *
- * The thing is that once we complete a HARD/SOFT IRQ the future task locks
- * should not depend on any of the locks observed while running the IRQ.  So
- * what we do is rewind the history buffer and erase all our knowledge of that
- * temporal event.
- */
-
-void crossrelease_hist_start(enum xhlock_context_t c)
-{
-	struct task_struct *cur = current;
-
-	if (!cur->xhlocks)
-		return;
-
-	cur->xhlock_idx_hist[c] = cur->xhlock_idx;
-	cur->hist_id_save[c]    = cur->hist_id;
-}
-
-void crossrelease_hist_end(enum xhlock_context_t c)
-{
-	struct task_struct *cur = current;
-
-	if (cur->xhlocks) {
-		unsigned int idx = cur->xhlock_idx_hist[c];
-		struct hist_lock *h = &xhlock(idx);
-
-		cur->xhlock_idx = idx;
-
-		/* Check if the ring was overwritten. */
-		if (h->hist_id != cur->hist_id_save[c])
-			invalidate_xhlock(h);
-	}
-}
-
-/*
- * lockdep_invariant_state() is used to annotate independence inside a task, to
- * make one task look like multiple independent 'tasks'.
- *
- * Take for instance workqueues; each work is independent of the last. The
- * completion of a future work does not depend on the completion of a past work
- * (in general). Therefore we must not carry that (lock) dependency across
- * works.
- *
- * This is true for many things; pretty much all kthreads fall into this
- * pattern, where they have an invariant state and future completions do not
- * depend on past completions. Its just that since they all have the 'same'
- * form -- the kthread does the same over and over -- it doesn't typically
- * matter.
- *
- * The same is true for system-calls, once a system call is completed (we've
- * returned to userspace) the next system call does not depend on the lock
- * history of the previous system call.
- *
- * They key property for independence, this invariant state, is that it must be
- * a point where we hold no locks and have no history. Because if we were to
- * hold locks, the restore at _end() would not necessarily recover it's history
- * entry. Similarly, independence per-definition means it does not depend on
- * prior state.
- */
-void lockdep_invariant_state(bool force)
-{
-	/*
-	 * We call this at an invariant point, no current state, no history.
-	 * Verify the former, enforce the latter.
-	 */
-	WARN_ON_ONCE(!force && current->lockdep_depth);
-	if (current->xhlocks)
-		invalidate_xhlock(&xhlock(current->xhlock_idx));
-}
-
-static int cross_lock(struct lockdep_map *lock)
-{
-	return lock ? lock->cross : 0;
-}
-
-/*
- * This is needed to decide the relationship between wrapable variables.
- */
-static inline int before(unsigned int a, unsigned int b)
-{
-	return (int)(a - b) < 0;
-}
-
-static inline struct lock_class *xhlock_class(struct hist_lock *xhlock)
-{
-	return hlock_class(&xhlock->hlock);
-}
-
-static inline struct lock_class *xlock_class(struct cross_lock *xlock)
-{
-	return hlock_class(&xlock->hlock);
-}
-
-/*
- * Should we check a dependency with previous one?
- */
-static inline int depend_before(struct held_lock *hlock)
-{
-	return hlock->read != 2 && hlock->check && !hlock->trylock;
-}
-
-/*
- * Should we check a dependency with next one?
- */
-static inline int depend_after(struct held_lock *hlock)
-{
-	return hlock->read != 2 && hlock->check;
-}
-
-/*
- * Check if the xhlock is valid, which would be false if,
- *
- *    1. Has not used after initializaion yet.
- *    2. Got invalidated.
- *
- * Remind hist_lock is implemented as a ring buffer.
- */
-static inline int xhlock_valid(struct hist_lock *xhlock)
-{
-	/*
-	 * xhlock->hlock.instance must be !NULL.
-	 */
-	return !!xhlock->hlock.instance;
-}
-
-/*
- * Record a hist_lock entry.
- *
- * Irq disable is only required.
- */
-static void add_xhlock(struct held_lock *hlock)
-{
-	unsigned int idx = ++current->xhlock_idx;
-	struct hist_lock *xhlock = &xhlock(idx);
-
-#ifdef CONFIG_DEBUG_LOCKDEP
-	/*
-	 * This can be done locklessly because they are all task-local
-	 * state, we must however ensure IRQs are disabled.
-	 */
-	WARN_ON_ONCE(!irqs_disabled());
-#endif
-
-	/* Initialize hist_lock's members */
-	xhlock->hlock = *hlock;
-	xhlock->hist_id = ++current->hist_id;
-
-	xhlock->trace.nr_entries = 0;
-	xhlock->trace.max_entries = MAX_XHLOCK_TRACE_ENTRIES;
-	xhlock->trace.entries = xhlock->trace_entries;
-
-	if (crossrelease_fullstack) {
-		xhlock->trace.skip = 3;
-		save_stack_trace(&xhlock->trace);
-	} else {
-		xhlock->trace.nr_entries = 1;
-		xhlock->trace.entries[0] = hlock->acquire_ip;
-	}
-}
-
-static inline int same_context_xhlock(struct hist_lock *xhlock)
-{
-	return xhlock->hlock.irq_context == task_irq_context(current);
-}
-
-/*
- * This should be lockless as far as possible because this would be
- * called very frequently.
- */
-static void check_add_xhlock(struct held_lock *hlock)
-{
-	/*
-	 * Record a hist_lock, only in case that acquisitions ahead
-	 * could depend on the held_lock. For example, if the held_lock
-	 * is trylock then acquisitions ahead never depends on that.
-	 * In that case, we don't need to record it. Just return.
-	 */
-	if (!current->xhlocks || !depend_before(hlock))
-		return;
-
-	add_xhlock(hlock);
-}
-
-/*
- * For crosslock.
- */
-static int add_xlock(struct held_lock *hlock)
-{
-	struct cross_lock *xlock;
-	unsigned int gen_id;
-
-	if (!graph_lock())
-		return 0;
-
-	xlock = &((struct lockdep_map_cross *)hlock->instance)->xlock;
-
-	/*
-	 * When acquisitions for a crosslock are overlapped, we use
-	 * nr_acquire to perform commit for them, based on cross_gen_id
-	 * of the first acquisition, which allows to add additional
-	 * dependencies.
-	 *
-	 * Moreover, when no acquisition of a crosslock is in progress,
-	 * we should not perform commit because the lock might not exist
-	 * any more, which might cause incorrect memory access. So we
-	 * have to track the number of acquisitions of a crosslock.
-	 *
-	 * depend_after() is necessary to initialize only the first
-	 * valid xlock so that the xlock can be used on its commit.
-	 */
-	if (xlock->nr_acquire++ && depend_after(&xlock->hlock))
-		goto unlock;
-
-	gen_id = (unsigned int)atomic_inc_return(&cross_gen_id);
-	xlock->hlock = *hlock;
-	xlock->hlock.gen_id = gen_id;
-unlock:
-	graph_unlock();
-	return 1;
-}
-
-/*
- * Called for both normal and crosslock acquires. Normal locks will be
- * pushed on the hist_lock queue. Cross locks will record state and
- * stop regular lock_acquire() to avoid being placed on the held_lock
- * stack.
- *
- * Return: 0 - failure;
- *         1 - crosslock, done;
- *         2 - normal lock, continue to held_lock[] ops.
- */
-static int lock_acquire_crosslock(struct held_lock *hlock)
-{
-	/*
-	 *	CONTEXT 1		CONTEXT 2
-	 *	---------		---------
-	 *	lock A (cross)
-	 *	X = atomic_inc_return(&cross_gen_id)
-	 *	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-	 *				Y = atomic_read_acquire(&cross_gen_id)
-	 *				lock B
-	 *
-	 * atomic_read_acquire() is for ordering between A and B,
-	 * IOW, A happens before B, when CONTEXT 2 see Y >= X.
-	 *
-	 * Pairs with atomic_inc_return() in add_xlock().
-	 */
-	hlock->gen_id = (unsigned int)atomic_read_acquire(&cross_gen_id);
-
-	if (cross_lock(hlock->instance))
-		return add_xlock(hlock);
-
-	check_add_xhlock(hlock);
-	return 2;
-}
-
-static int copy_trace(struct stack_trace *trace)
-{
-	unsigned long *buf = stack_trace + nr_stack_trace_entries;
-	unsigned int max_nr = MAX_STACK_TRACE_ENTRIES - nr_stack_trace_entries;
-	unsigned int nr = min(max_nr, trace->nr_entries);
-
-	trace->nr_entries = nr;
-	memcpy(buf, trace->entries, nr * sizeof(trace->entries[0]));
-	trace->entries = buf;
-	nr_stack_trace_entries += nr;
-
-	if (nr_stack_trace_entries >= MAX_STACK_TRACE_ENTRIES-1) {
-		if (!debug_locks_off_graph_unlock())
-			return 0;
-
-		print_lockdep_off("BUG: MAX_STACK_TRACE_ENTRIES too low!");
-		dump_stack();
-
-		return 0;
-	}
-
-	return 1;
-}
-
-static int commit_xhlock(struct cross_lock *xlock, struct hist_lock *xhlock)
-{
-	unsigned int xid, pid;
-	u64 chain_key;
-
-	xid = xlock_class(xlock) - lock_classes;
-	chain_key = iterate_chain_key((u64)0, xid);
-	pid = xhlock_class(xhlock) - lock_classes;
-	chain_key = iterate_chain_key(chain_key, pid);
-
-	if (lookup_chain_cache(chain_key))
-		return 1;
-
-	if (!add_chain_cache_classes(xid, pid, xhlock->hlock.irq_context,
-				chain_key))
-		return 0;
-
-	if (!check_prev_add(current, &xlock->hlock, &xhlock->hlock, 1,
-			    &xhlock->trace, copy_trace))
-		return 0;
-
-	return 1;
-}
-
-static void commit_xhlocks(struct cross_lock *xlock)
-{
-	unsigned int cur = current->xhlock_idx;
-	unsigned int prev_hist_id = xhlock(cur).hist_id;
-	unsigned int i;
-
-	if (!graph_lock())
-		return;
-
-	if (xlock->nr_acquire) {
-		for (i = 0; i < MAX_XHLOCKS_NR; i++) {
-			struct hist_lock *xhlock = &xhlock(cur - i);
-
-			if (!xhlock_valid(xhlock))
-				break;
-
-			if (before(xhlock->hlock.gen_id, xlock->hlock.gen_id))
-				break;
-
-			if (!same_context_xhlock(xhlock))
-				break;
-
-			/*
-			 * Filter out the cases where the ring buffer was
-			 * overwritten and the current entry has a bigger
-			 * hist_id than the previous one, which is impossible
-			 * otherwise:
-			 */
-			if (unlikely(before(prev_hist_id, xhlock->hist_id)))
-				break;
-
-			prev_hist_id = xhlock->hist_id;
-
-			/*
-			 * commit_xhlock() returns 0 with graph_lock already
-			 * released if fail.
-			 */
-			if (!commit_xhlock(xlock, xhlock))
-				return;
-		}
-	}
-
-	graph_unlock();
-}
-
-void lock_commit_crosslock(struct lockdep_map *lock)
-{
-	struct cross_lock *xlock;
-	unsigned long flags;
-
-	if (unlikely(!debug_locks || current->lockdep_recursion))
-		return;
-
-	if (!current->xhlocks)
-		return;
-
-	/*
-	 * Do commit hist_locks with the cross_lock, only in case that
-	 * the cross_lock could depend on acquisitions after that.
-	 *
-	 * For example, if the cross_lock does not have the 'check' flag
-	 * then we don't need to check dependencies and commit for that.
-	 * Just skip it. In that case, of course, the cross_lock does
-	 * not depend on acquisitions ahead, either.
-	 *
-	 * WARNING: Don't do that in add_xlock() in advance. When an
-	 * acquisition context is different from the commit context,
-	 * invalid(skipped) cross_lock might be accessed.
-	 */
-	if (!depend_after(&((struct lockdep_map_cross *)lock)->xlock.hlock))
-		return;
-
-	raw_local_irq_save(flags);
-	check_flags(flags);
-	current->lockdep_recursion = 1;
-	xlock = &((struct lockdep_map_cross *)lock)->xlock;
-	commit_xhlocks(xlock);
-	current->lockdep_recursion = 0;
-	raw_local_irq_restore(flags);
-}
-EXPORT_SYMBOL_GPL(lock_commit_crosslock);
-
-/*
- * Return: 0 - failure;
- *         1 - crosslock, done;
- *         2 - normal lock, continue to held_lock[] ops.
- */
-static int lock_release_crosslock(struct lockdep_map *lock)
-{
-	if (cross_lock(lock)) {
-		if (!graph_lock())
-			return 0;
-		((struct lockdep_map_cross *)lock)->xlock.nr_acquire--;
-		graph_unlock();
-		return 1;
-	}
-	return 2;
-}
-
-static void cross_init(struct lockdep_map *lock, int cross)
-{
-	if (cross)
-		((struct lockdep_map_cross *)lock)->xlock.nr_acquire = 0;
-
-	lock->cross = cross;
-
-	/*
-	 * Crossrelease assumes that the ring buffer size of xhlocks
-	 * is aligned with power of 2. So force it on build.
-	 */
-	BUILD_BUG_ON(MAX_XHLOCKS_NR & (MAX_XHLOCKS_NR - 1));
-}
-
-void lockdep_init_task(struct task_struct *task)
-{
-	int i;
-
-	task->xhlock_idx = UINT_MAX;
-	task->hist_id = 0;
-
-	for (i = 0; i < XHLOCK_CTX_NR; i++) {
-		task->xhlock_idx_hist[i] = UINT_MAX;
-		task->hist_id_save[i] = 0;
-	}
-
-	task->xhlocks = kzalloc(sizeof(struct hist_lock) * MAX_XHLOCKS_NR,
-				GFP_KERNEL);
-}
-
-void lockdep_free_task(struct task_struct *task)
-{
-	if (task->xhlocks) {
-		void *tmp = task->xhlocks;
-		/* Diable crossrelease for current */
-		task->xhlocks = NULL;
-		kfree(tmp);
-	}
-}
-#endif
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 947d3e2ed5c2..9d5b78aad4c5 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1099,8 +1099,6 @@ config PROVE_LOCKING
 	select DEBUG_MUTEXES
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
 	select DEBUG_LOCK_ALLOC
-	select LOCKDEP_CROSSRELEASE
-	select LOCKDEP_COMPLETIONS
 	select TRACE_IRQFLAGS
 	default n
 	help
@@ -1170,37 +1168,6 @@ config LOCK_STAT
 	 CONFIG_LOCK_STAT defines "contended" and "acquired" lock events.
 	 (CONFIG_LOCKDEP defines "acquire" and "release" events.)
 
-config LOCKDEP_CROSSRELEASE
-	bool
-	help
-	 This makes lockdep work for crosslock which is a lock allowed to
-	 be released in a different context from the acquisition context.
-	 Normally a lock must be released in the context acquiring the lock.
-	 However, relexing this constraint helps synchronization primitives
-	 such as page locks or completions can use the lock correctness
-	 detector, lockdep.
-
-config LOCKDEP_COMPLETIONS
-	bool
-	help
-	 A deadlock caused by wait_for_completion() and complete() can be
-	 detected by lockdep using crossrelease feature.
-
-config BOOTPARAM_LOCKDEP_CROSSRELEASE_FULLSTACK
-	bool "Enable the boot parameter, crossrelease_fullstack"
-	depends on LOCKDEP_CROSSRELEASE
-	default n
-	help
-	 The lockdep "cross-release" feature needs to record stack traces
-	 (of calling functions) for all acquisitions, for eventual later
-	 use during analysis. By default only a single caller is recorded,
-	 because the unwind operation can be very expensive with deeper
-	 stack chains.
-
-	 However a boot parameter, crossrelease_fullstack, was
-	 introduced since sometimes deeper traces are required for full
-	 analysis. This option turns on the boot parameter.
-
 config DEBUG_LOCKDEP
 	bool "Lock dependency engine debugging"
 	depends on DEBUG_KERNEL && LOCKDEP
