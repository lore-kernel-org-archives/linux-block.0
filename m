Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3B8C282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 14:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDE52083B
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 14:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfBDOaH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:30:07 -0500
Received: from verein.lst.de ([213.95.11.211]:49114 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfBDOaG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Feb 2019 09:30:06 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id ABA3B68DD6; Mon,  4 Feb 2019 15:30:05 +0100 (CET)
Date:   Mon, 4 Feb 2019 15:30:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Zachary Hays <zhays@lexmark.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] mmc: block: handle complete_work on the system_highpri
 workqueue
Message-ID: <20190204143005.GB12581@lst.de>
References: <1548965800-3080-1-git-send-email-zhays@lexmark.com> <CAPDyKFpcmyKnF-QPBV1vbTfGdSYN30GayZSA5O9Gm_EbZjfdAw@mail.gmail.com> <1557f936-9d3d-7834-6247-01387fcb04fe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557f936-9d3d-7834-6247-01387fcb04fe@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 04, 2019 at 10:02:18AM +0200, Adrian Hunter wrote:
> On 4/02/19 8:24 AM, Ulf Hansson wrote:
> > + Jens, Christoph, Adrian, Linus
> > 
> > On Thu, 31 Jan 2019 at 21:16, Zachary Hays <zhays@lexmark.com> wrote:
> >>
> >> The kblockd workqueue is created with the WQ_MEM_RECLAIM flag set.
> >> This generates a rescuer thread for that queue that will trigger when
> >> the CPU is under heavy load and collect the uncompleted work.
> >>
> >> In the case of mmc, this creates the possibility of a deadlock as
> >> other blk-mq is also run on the same queue. For example:
> >>
> >> - worker 0 claims the mmc host
> >> - worker 1 attempts to claim the host
> >> - worker 0 schedules complete_work to release the host
> >> - rescuer thread is triggered after time-out and collects the dangling
> >>   work
> >> - rescuer thread attempts to complete the work in order starting with
> >>   claim host
> >> - the task to release host is now blocked by a task to claim it and
> >>   will never be called
> >>
> >> The above results in multiple hung tasks that lead to failures to boot.
> >>
> >> Switching complete_work to the system_highpri queue avoids this
> >> because system_highpri is not flagged with WQ_MEM_RECLAIM. This allows
> >> the host to be released without getting blocked by other claims tasks.
> >>
> > 
> > Thanks for fix and the detailed description to the problem!
> > 
> >> Signed-off-by: Zachary Hays <zhays@lexmark.com>
> >> ---
> >>  drivers/mmc/core/block.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> >> index aef1185f383d..59b6b41b84c6 100644
> >> --- a/drivers/mmc/core/block.c
> >> +++ b/drivers/mmc/core/block.c
> >> @@ -2112,7 +2112,7 @@ static void mmc_blk_mq_req_done(struct mmc_request *mrq)
> >>                 if (waiting)
> >>                         wake_up(&mq->wait);
> >>                 else
> >> -                       kblockd_schedule_work(&mq->complete_work);
> >> +                       queue_work(system_highpri_wq, &mq->complete_work);
> > 
> > Even if this solves the problem, I think we need some input from some
> > of the block experts/maintainers to understand if this is the correct
> > way to fix the problem. So, I have lopped them in.
> > 
> > I am guessing MMC is not the only block device driver that have this
> > kind of locking issue. Or perhaps it is..
> 
> WRT kblockd_workqueue, there is also still this issue outstanding:
> 
> 	https://lore.kernel.org/lkml/20170921140729.GA17333@lst.de/

Did you post your summary to the block list?  Or even looked into a
prototype that uses a kthread for the deferred submission in blk-mq
instead of a workqueue?
