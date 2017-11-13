Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	broonie@kernel.org,
	linus.walleij@linaro.org,
	lee.tibbert@gmail.com,
	oleksandr@natalenko.name,
	lucmiccio@gmail.com,
	bfq-iosched@googlegroups.com,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH IMPROVEMENT/BUGFIX 0/4] block, bfq: increase sustainable IOPS and fix a bug
Date: Mon, 13 Nov 2017 07:34:06 +0100
Message-Id: <20171113063410.3029-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hi,
these patches address the following issue, raised and
discussed in [1].

BFQ provides a proportional share policy for the blkio controller.  In
this respect, BFQ updates the I/O accounting related to its policy,
i.e., the statistics contained in the special files blkio.bfq.* in
blkio groups (these files are the bfq counterpart of the blkio.*
statistic files updated by CFQ).  To update these statistics, BFQ
invokes some blkg_*stats_* functions.  We have found out that these
functions take a considerable percentage, about 40%, of the total
execution time of BFQ.

This patch series contains two patches to address this issue, namely
the patches anticipated and discussed in their main aspects in [1].

The first of these two patches is patch 3/4 in this series: it enables
BFQ to execute the above blkg_*stats_* functions, where possible, in
parallel with the rest of the code of the scheduler.  With this
improvement, the maximum request-processing rate sustainable with BFQ
grows by 25%-30%, depending on the CPU.  For instance, it grows from
250 to 310 KIOPS on an Intel i7-4850HQ. These results, and the others
reported in this letter, have been obtained and can be reproduced very
easily with the script [2].

Unfortunately, even after the above improvement, blkg_*stats_*
functions still cause a noticeable loss of sustainable throughput.  To
give an idea, on an Intel i7-4850HQ, if the update of blkio.bfq.*
statistics is not performed at all, then the sustainable throughput
grows from 310 to 400 KIOPS.  This issue has been already discussed in
[1] as well. In brief, we agreed to make a further commit, which
introduces the possibility to disable/re-enable at boot, or at
module-loading time, the updating of all blkio statistics for
proportional-share policies, i.e., of both those updated by BFQ and
those updated by CFQ.

We are already working on that commit, but finalizing it will take
some time.  Fortunately, following a suggestion/recommendation of
Tejun in the same thread [2], it is already possible to drastically
increase BFQ performance, when no blkio-debugging information is
needed. Tejun's suggestion/recommendation is to move most blkio.bfq.*
statistics behind an already existing config option,
CONFIG_DEBUG_BLK_CGROUP.  Patch 4/4 in this series does that.  Thanks
to this change, if CONFIG_DEBUG_BLK_CGROUP is not set, then bfq does
attain a further boost in sustainable throughput, which ranges from
+30% to +45%, depending on the CPU (some figures in the
documentation).

The above two patches are preceded by two preliminary patches.  The
first updates the conservative range of IOPS (sustainable with BFQ)
that was previously reported in the documentation.  The patch replaces
this piece of information with the actual, much higher limits that we
have measured while working at the above two commits.  The second
preliminary patch fixes a functional bug, related to the update of the
above statistics.

We waited for one week of testing from bfq users before submitting
these patches. We hope we are still in time for having these
improvements and fixes considered for 4.15.

NOTE.

Two definitions of empty functions in patch 4/4 trigger the following
checkpatch error: "open brace '{' following function definitions go on
the next line". Unfortunately, following this recommendation does seem
to worsen code in our case: in addition to making these two
definitions slightly harder to read, it would break symmetry with
respect to all other definitions of empty functions, both those
already present in the base code, and those added by the patch
itself. In particular, in all those other definitions, the empty body
of the functions is on the same line as the prototypes of the
functions. Oddly, the latter definitions do not cause the same error
report.

Thanks,
Paolo

[1] https://www.spinics.net/lists/linux-block/msg18943.html
[2] https://github.com/Algodev-github/IOSpeed

Luca Miccio (2):
  block, bfq: add missing invocations of bfqg_stats_update_io_add/remove
  block, bfq: move debug blkio stats behind CONFIG_DEBUG_BLK_CGROUP

Paolo Valente (2):
  doc, block, bfq: update max IOPS sustainable with BFQ
  block, bfq: update blkio stats outside the scheduler lock

 Documentation/block/bfq-iosched.txt |  43 +++++++++--
 block/bfq-cgroup.c                  | 148 ++++++++++++++++++++----------------
 block/bfq-iosched.c                 | 117 ++++++++++++++++++++++++++--
 block/bfq-iosched.h                 |   4 +-
 block/bfq-wf2q.c                    |   1 -
 5 files changed, 233 insertions(+), 80 deletions(-)

--
2.10.0
