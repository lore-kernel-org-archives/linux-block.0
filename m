Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:55514 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760684AbdJQKLF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Oct 2017 06:11:05 -0400
Received: by mail-wm0-f41.google.com with SMTP id u138so2839183wmu.4
        for <linux-block@vger.kernel.org>; Tue, 17 Oct 2017 03:11:04 -0700 (PDT)
From: Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Subject: high overhead of functions blkg_*stats_* in bfq 
Date: Tue, 17 Oct 2017 12:11:01 +0200
Message-Id: <07DF24AB-9B62-4EE5-8B45-3E04C1CEA84C@linaro.org>
Cc: linux-block <linux-block@vger.kernel.org>,
        Luca Miccio <lucmiccio@gmail.com>
To: Tejun Heo <tj@kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Tejun, all,
in our work for reducing bfq overhead, we bumped into an unexpected
fact: the functions blkg_*stats_*, invoked in bfq to update cgroups
statistics as in cfq, take about 40% of the total execution time of
bfq.  This causes an additional serious slowdown on any multicore cpu,
as most bfq functions, from which blkg_*stats_* get invoked, are
protected by a per-device scheduler lock.  To give you an idea, on an
Intel i7-4850HQ, and with 8 threads doing random I/O in parallel on
null_blk (configured with 0 latency), if the update of groups stats is
removed, then the throughput grows from 260 to 404 KIOPS.  This and
all the other results we might share in this thread can be reproduced
very easily with a (useful) script made by Luca Miccio [1].

We tried to understand the reason for this high overhead, and, in
particular, to find out whether whether there was some issue that we
could address on our own.  But the causes seem somehow substantial:
one of the most time-consuming operations needed by some blkg_*stats_*
functions is, e.g., find_next_bit, for which we don't see any trivial
replacement.

So, as a first attempt to reduce this severe slowdown, we have made a
patch that moves the invocation of blkg_*stats_* functions outside the
critical sections protected by the bfq lock.  Still, these functions
apparently need to be protected with the request_queue lock, because
the group they are invoked on may otherwise disappear before or while
these functions are executed.  Fortunately, tests run without even
this lock have shown that the serialization caused by this lock has a
little impact (5% of throughput reduction).  As for results, moving
these functions outside the bfq lock does improve throughput: it
grows, e.g., from 260 to 316 KIOPS in the above test case.  But we are
still rather far from the optimum.

Do you have any clue about possible solutions to reduce the overhead
of these functions?  If no relatively quick solution is available, we
are planning to prepare, in addition to the above patch to increase
parallelism, a further patch to give the user the possibility to
disable stats update, so as to gain a full throughput boost of up to
55% (according to the tests we have run so far on a few different
systems).

Thanks,
Paolo

[1] https://github.com/Algodev-github/IOSpeed
