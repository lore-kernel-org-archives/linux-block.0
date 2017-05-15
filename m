Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Subject: races between blk-cgroup operations and I/O scheds in blk-mq (?)
Message-Id: <C61C6E23-7A98-452A-A449-FE03552BE8E3@linaro.org>
Date: Mon, 15 May 2017 21:49:13 +0200
To: Tejun Heo <tj@kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
List-ID: <linux-block@vger.kernel.org>

Hi Tejun, Jens, and anyone else possibly interested in this issue,
I have realized that, while blk-cgroup operation are of course
protected by the usual request_queue lock, I/O scheduler operations
aren't any longer protected by this same lock in blk-mq.  They are
protected by a finer-grained scheduler lock instead.  If I'm not
missing anything, this exposes to obvious races any I/O scheduler
supporting cgroups, as bfq.  So I have tried to check bfq code,
against blk-cgroup, as carefully as I could.

The only dangerous operations I found in blk-cgroup, for bfq, are blkg
destroy ones. But the scheduler hook related to these operations
(pd_offline) seems to be always invoked before any other, possibly
dangerous, step.  It seems then enough that this hook is executed with
the scheduler lock held, to serialize cgroup and in-scheduler
blkg-lookup operations.

As for in-scheduler operations, the only danger I found so far is the
dereference of the blkg_policy_data pointer field cached in the
descriptor of a group.  Given the parent group of some process in the
scheduler, that pointer may have become a dangling reference if the
policy data it pointed to has been destroyed, but the parent-group
pointer for that process has not yet been updated (the parent pointer
itself is then a dangling reference).  In this respect, these updates
happen (only) after the arrival of new I/O requests after the
destruction of a parent group.

So, unless you tell me that there are other races I haven't seen, or,
even worse, that I'm just talking nonsense, I have thought of a simple
solution to address this issue without resorting to the request_queue
lock: further caching, on blkg lookups, the only policy or blkg data
the scheduler may use, and access this data directly when needed.  By
doing so, the issue is reduced to the occasional use of stale data.
And apparently this already happens, e.g., in cfq when it uses the
weight of a cfq_queue associated with a process whose group has just
been changed (and for which a blkg_lookup has not yet been invoked).
The same should happen when cfq invokes cfq_log_cfqq for such a
cfq_queue, as this function prints the path of the group the bfq_queue
belongs to.

Thanks,
Paolo
