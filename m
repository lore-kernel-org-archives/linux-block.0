Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:62581 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdJDJjn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Oct 2017 05:39:43 -0400
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Alex Lemberg <alex.lemberg@sandisk.com>,
        Mateusz Nowak <mateusz.nowak@intel.com>,
        Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Das Asutosh <asutoshd@codeaurora.org>,
        Zhangfei Gao <zhangfei.gao@gmail.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V9 13/15] mmc: block: Add CQE and blk-mq support
Date: Wed, 04 Oct 2017 11:39:38 +0200
Message-id: <2384661.GfpEZ6rEzz@amdc3058>
In-reply-to: <CACRpkdYZFW6zdt5ig3wNDxQAaVV6OYnrG5zPfcvzixwh8VbXig@mail.gmail.com>
MIME-version: 1.0
Content-type: text/plain; charset="us-ascii"
References: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com>
        <1506083824-4024-14-git-send-email-adrian.hunter@intel.com>
        <CACRpkdYZFW6zdt5ig3wNDxQAaVV6OYnrG5zPfcvzixwh8VbXig@mail.gmail.com>
        <CGME20171004093941epcas1p1d5277f64b4cc5a78bf185bf9d5b1abfb@epcas1p1.samsung.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Hi,

On Wednesday, October 04, 2017 09:39:45 AM Linus Walleij wrote:
> On Fri, Sep 22, 2017 at 2:37 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
> > Add CQE support to the block driver, including:
> >     - optionally using DCMD for flush requests
> >     - "manually" issuing discard requests
> >     - issuing read / write requests to the CQE
> >     - supporting block-layer timeouts
> >     - handling recovery
> >     - supporting re-tuning
> >
> > CQE offers 25% - 50% better random multi-threaded I/O.  There is a slight
> > (e.g. 2%) drop in sequential read speed but no observable change to sequential
> > write.
> >
> > CQE automatically sends the commands to complete requests.  However it only
> > supports reads / writes and so-called "direct commands" (DCMD).  Furthermore
> > DCMD is limited to one command at a time, but discards require 3 commands.
> > That makes issuing discards through CQE very awkward, but some CQE's don't
> > support DCMD anyway.  So for discards, the existing non-CQE approach is
> > taken, where the mmc core code issues the 3 commands one at a time i.e.
> > mmc_erase(). Where DCMD is used, is for issuing flushes.
> >
> > For host controllers without CQE support, blk-mq support is extended to
> > synchronous reads/writes or, if the host supports CAP_WAIT_WHILE_BUSY,
> > asynchonous reads/writes.  The advantage of asynchronous reads/writes is
> > that it allows the preparation of the next request while the current
> > request is in progress.
> >
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> I am trying to wrap my head around this large patch. The size makes it hard
> but I am doing my best.

I also think that this patch should be split on two patches. The 1st
one introducing blk-mq and the 2nd one adding CQE support.

[ I don't agree that they make more sense together, on the contrary,
  it is very difficult to properly analyze blk-mq changes on their
  own while there are mixed with CQE related ones. ]

> Some overarching questions:
> 
> - Is the CQE only available on the MQ path (i.e. if you enabled MQ) or
>   on both paths?
> 
> I think it is reasonable that if we introduce a new feature like this
> it will only
> be available for the new block path. This reflects how the block maintainers
> e.g. only allow new scheduling policies to be merged on the MQ path.
> The old block layer is legacy and should not be extended with new cool
> features that can then be regarded as "regressions" if they don't work
> properly with MQ. Better to only implement them for MQ then.
> 
> - Performance before/after path on MQ?
> 
> I tested this very extensively when working with my (now dormant) MQ
> patch set. Better/equal/worse?
> (https://marc.info/?l=linux-mmc&m=148665788227015&w=2)
> 
> The reason my patch set contained refactorings of async post-processing,
> removed the waitqueues and the context info, up to the point where I
> can issue requests in parallel, i.e. complete requests from the ->done()
> callback on the host and immediately let the core issue the next one,
> was due to performance issues.
> 
> It's these patches from the old patch set:
> 
>   mmc: core: move some code in mmc_start_areq()
>   mmc: core: refactor asynchronous request finalization
>   mmc: core: refactor mmc_request_done()
>   mmc: core: move the asynchronous post-processing
>   mmc: core: add a kthread for completing requests
>   mmc: core: replace waitqueue with worker
>   mmc: core: do away with is_done_rcv
>   mmc: core: do away with is_new_req
>   mmc: core: kill off the context info
>   mmc: queue: simplify queue logic
>   mmc: block: shuffle retry and error handling
>   mmc: queue: stop flushing the pipeline with NULL
>   mmc: queue: issue struct mmc_queue_req items
>   mmc: queue: get/put struct mmc_queue_req
>   mmc: queue: issue requests in massive parallel
> 
> I.e. I made 15 patches just to make sure the new block layer did not
> regress performance. The MQ-switch patch was just the final step of
> these 16 patches.
> 
> Most energy went into that and I think it will be necessary still to work
> with MQ in the long haul.
> 
> I am worried that this could add a second MQ execution path that
> performs worse than the legacy block path for the above reason, i.e.
> it doesn't really take advantage of the MQ speedups by marshalling
> the requests and not doing away with the waitqueues and not
> completing the requests out-of-order, so we get stuck with a lump of

BTW The out-of-order approach taken by the above patchset seems racy
(at least when it comes to error handling), the details were in my
review mails which have not been answered yet:

https://www.spinics.net/lists/linux-mmc/msg42751.html

Also the patchset itself has never worked on my setup:

https://www.spinics.net/lists/linux-mmc/msg42759.html

> MQ code that doesn't perform and therefore we cannot switch seamlessly
> to MQ.

I think that switching seamlessly to blk-mq in short/medium-term
is not possible (SCSI tried and failed to do so). The changes to
the old path are very complex and besides affecting performance
they also affect error recovery handling (which needs to be tested
properly before the switch).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
