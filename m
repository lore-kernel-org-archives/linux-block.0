Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	tj@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 0/14][V6] Introduce io.latency io controller for cgroups
Date: Tue,  3 Jul 2018 11:14:49 -0400
Message-Id: <20180703151503.2549-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

kbuild test bot took a while to tell me I had a problem.

v5->v6:
- fix a !CONFIG_BLOCK compile error.
- added some commenting around the scale cookie change stuff.
- rebased onto Jens's for-linus branch.

v4->v5:
- fix lockdep mess with the stat stuff I hadn't noticed until now.
- fixed the wait loop so it would actually break properly.
- fixed a problem where unconfigured groups weren't being throttled.
- fixed some spelling mistakes.

v3->v4:
- deal with a child having a configuration but the parent not.
- fix use of setup_timer, there was an API change between the kernel I
  wrote/tested these patches on and the current kernel.
- change the initialization location for iolatency.
- fix some spelling mistakes in the documentation.

v2->v3:
- added "skip readahead if the cgroup is congested".  During testing we would
  see stalls on taking mmap_sem because something was doing 'ps' or some other
  such thing and getting stuck because the throttled group was getting hit
  particularly hard trying to do readahead.  This is a weird sort of priority
  inversion, fixed it by skipping readahead if we're currently congested to not
  only help the overall latency of the throttled group, but reduce the priority
  inversion associated with higher priority tasks getting stuck trying to read
  /proc files for tasks that are stuck.
- added "block: use irq variant for blkcg->lock" to address a lockdep warning
  seen during testing.
- add a blk_cgroup_congested() helper to check for congestion in a hierarchical
  way.
- Fixed some assumptions related to accessing blkg out of band that resulted in
  panics.
- Made the throttling stuff only throttle if the group has done a decent amount
  of IO in the last window.
- Fix the wake up logic to reduce the thundering herd issues we saw in testing.
- Put a limit on how much of a hole we can dig into the artificial delay stuff.
  We were seeing in multiple back to back tests that we'd get so deep into the
  delay count that we'd take hours to unthrottle.  This stuff was originally
  introduced to keep us from flapping from delay to no delay if we had bursty
  behavior from the misbehaving group, so capping this keeps that protection
  while also keeping us from throttling forever.
- Limit the maximum delay to 250ms from 1 second.  There was a bug in the
  congestion checking stuff, it wasn't taking into account the hierarchy so we
  would sometimes not throttle when we needed to, which led me to have a 1
  second maximum.  However when that bug was fixed it turned out 1 second was
  too much, so limit to 250ms like balance dirty pages does.

v1->v2:
- fix how we get the swap device for the page when doing the swap throttling.
- add a bunch of comments how the throttling works.
- move the documentation to cgroup-v2.txt
- address the various other comments.

==== Original message =====

This series adds a latency based io controller for cgroups.  It is based on the
same concept as the writeback throttling code, which is watching the overall
total latency of IO's in a given window and then adjusting the queue depth of
the group accordingly.  This is meant to be a workload protection controller, so
whoever has the lowest latency target gets the preferential treatment with no
thought to fairness or proportionality.  It is meant to be work conserving, so
as long as nobody is missing their latency targets the disk is fair game.

We have been testing this in production for several months now to get the
behavior right and we are finally at the point that it is working well in all of
our test cases.  With this patch we protect our main workload (the web server)
and isolate out the system services (chef/yum/etc).  This works well in the
normal case, smoothing out weird request per second (RPS) dips that we would see
when one of the system services would run and compete for IO resources.  This
also works incredibly well in the runaway task case.

The runaway task usecase is where we have some task that slowly eats up all of
the memory on the system (think a memory leak).  Previously this sort of
workload would push the box into a swapping/oom death spiral that was only
recovered by rebooting the box.  With this patchset and proper configuration of
the memory.low and io.latency controllers we're able to survive this test with a
at most 20% dip in RPS.

There are a lot of extra patches in here to set everything up.  The following
are just infrastructure that should be relatively uncontroversial

[PATCH 01/13] block: add bi_blkg to the bio for cgroups
[PATCH 02/13] block: introduce bio_issue_as_root_blkg
[PATCH 03/13] blk-cgroup: allow controllers to output their own stats

The following simply allow us to tag swap IO and assign the appropriate cgroup
to the bio's so we can do the appropriate accounting inside the io controller

[PATCH 04/13] blk: introduce REQ_SWAP
[PATCH 05/13] swap,blkcg: issue swap io with the appropriate context

This is so that we can induce delays.  The io controller mostly throttles based
on queue depth, however for cases like REQ_SWAP/REQ_META where we cannot
throttle without inducing a priority inversion we have a mechanism to "back
charge" groups for this IO by inducing an artificial delay at user space return
time.

[PATCH 06/13] blkcg: add generic throttling mechanism
[PATCH 07/13] memcontrol: schedule throttling if we are congested

This is more moving things around and refactoring, Jens you may want to pay
close attention to this to make sure I didn't break anything.

[PATCH 08/13] blk-stat: export helpers for modifying blk_rq_stat
[PATCH 09/13] blk-rq-qos: refactor out common elements of blk-wbt
[PATCH 10/13] block: remove external dependency on wbt_flags
[PATCH 11/13] rq-qos: introduce dio_bio callback

And this is the meat of the controller and it's documentation.

[PATCH 12/13] block: introduce blk-iolatency io controller
[PATCH 13/13] Documentation: add a doc for blk-iolatency

Jens, I'm sending this through your tree since it's mostly block related,
however there are the two mm related patches, so if somebody from mm could weigh
in on how we want to handle those that would be great.  Thanks,

Josef
