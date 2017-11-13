Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH IMPROVEMENT/BUGFIX 0/4] block, bfq: increase sustainable
 IOPS and fix a bug
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
 lee.tibbert@gmail.com, oleksandr@natalenko.name, lucmiccio@gmail.com,
 bfq-iosched@googlegroups.com
References: <20171113063410.3029-1-paolo.valente@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6723bae7-4b0d-da0e-fe28-e0b7c12f6038@kernel.dk>
Date: Mon, 13 Nov 2017 10:53:27 -0700
MIME-Version: 1.0
In-Reply-To: <20171113063410.3029-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/12/2017 11:34 PM, Paolo Valente wrote:
> Hi,
> these patches address the following issue, raised and
> discussed in [1].
> 
> BFQ provides a proportional share policy for the blkio controller.  In
> this respect, BFQ updates the I/O accounting related to its policy,
> i.e., the statistics contained in the special files blkio.bfq.* in
> blkio groups (these files are the bfq counterpart of the blkio.*
> statistic files updated by CFQ).  To update these statistics, BFQ
> invokes some blkg_*stats_* functions.  We have found out that these
> functions take a considerable percentage, about 40%, of the total
> execution time of BFQ.
> 
> This patch series contains two patches to address this issue, namely
> the patches anticipated and discussed in their main aspects in [1].
> 
> The first of these two patches is patch 3/4 in this series: it enables
> BFQ to execute the above blkg_*stats_* functions, where possible, in
> parallel with the rest of the code of the scheduler.  With this
> improvement, the maximum request-processing rate sustainable with BFQ
> grows by 25%-30%, depending on the CPU.  For instance, it grows from
> 250 to 310 KIOPS on an Intel i7-4850HQ. These results, and the others
> reported in this letter, have been obtained and can be reproduced very
> easily with the script [2].
> 
> Unfortunately, even after the above improvement, blkg_*stats_*
> functions still cause a noticeable loss of sustainable throughput.  To
> give an idea, on an Intel i7-4850HQ, if the update of blkio.bfq.*
> statistics is not performed at all, then the sustainable throughput
> grows from 310 to 400 KIOPS.  This issue has been already discussed in
> [1] as well. In brief, we agreed to make a further commit, which
> introduces the possibility to disable/re-enable at boot, or at
> module-loading time, the updating of all blkio statistics for
> proportional-share policies, i.e., of both those updated by BFQ and
> those updated by CFQ.
> 
> We are already working on that commit, but finalizing it will take
> some time.  Fortunately, following a suggestion/recommendation of
> Tejun in the same thread [2], it is already possible to drastically
> increase BFQ performance, when no blkio-debugging information is
> needed. Tejun's suggestion/recommendation is to move most blkio.bfq.*
> statistics behind an already existing config option,
> CONFIG_DEBUG_BLK_CGROUP.  Patch 4/4 in this series does that.  Thanks
> to this change, if CONFIG_DEBUG_BLK_CGROUP is not set, then bfq does
> attain a further boost in sustainable throughput, which ranges from
> +30% to +45%, depending on the CPU (some figures in the
> documentation).
> 
> The above two patches are preceded by two preliminary patches.  The
> first updates the conservative range of IOPS (sustainable with BFQ)
> that was previously reported in the documentation.  The patch replaces
> this piece of information with the actual, much higher limits that we
> have measured while working at the above two commits.  The second
> preliminary patch fixes a functional bug, related to the update of the
> above statistics.
> 
> We waited for one week of testing from bfq users before submitting
> these patches. We hope we are still in time for having these
> improvements and fixes considered for 4.15.

Usually I'd say it's too late, but I knew this was coming. I'll get
this queued up.

-- 
Jens Axboe
