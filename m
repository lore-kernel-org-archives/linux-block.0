Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30586 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964836AbcJFQ2s (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Oct 2016 12:28:48 -0400
Date: Thu, 6 Oct 2016 12:39:35 -0400
From: Keith Busch <keith.busch@intel.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: Return invalid cookie if bio was split
Message-ID: <20161006163935.GB1778@localhost.localdomain>
References: <20160926230030.GB24200@localhost.localdomain>
 <20160927172536.53a1315f@tom-ThinkPad-T450>
 <20161003220040.GA1259@localhost.localdomain>
 <CACVXFVOrQHdZkqq+F159pd67iaj=Cx2hRG=uj-Mfr_m1OV9t+Q@mail.gmail.com>
 <20161005165127.GA4812@localhost.localdomain>
 <CACVXFVO_YqeQae3FCpK=wKHZ_U5vHtj=KMowAt5vJDpq43hcrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVO_YqeQae3FCpK=wKHZ_U5vHtj=KMowAt5vJDpq43hcrA@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Oct 07, 2016 at 12:06:27AM +0800, Ming Lei wrote:
> Hi Keith,
> 
> On Thu, Oct 6, 2016 at 12:51 AM, Keith Busch <keith.busch@intel.com> wrote:
> > On Wed, Oct 05, 2016 at 11:19:39AM +0800, Ming Lei wrote:
> >> But .poll() need to check if the specific request is completed or not,
> >> then blk_poll() can set 'current' as RUNNING if it is completed.
> >>
> >> blk_poll():
> >>                 ...
> >>                 ret = q->mq_ops->poll(hctx, blk_qc_t_to_tag(cookie));
> >>                 if (ret > 0) {
> >>                         hctx->poll_success++;
> >>                         set_current_state(TASK_RUNNING);
> >>                         return true;
> >>                 }
> >
> >
> > Right, but the task could be waiting on a whole lot more than just that
> > one tag, so setting the task to running before knowing those all complete
> > doesn't sound right.
> >
> >> I am glad to take a look the patch if you post it out.
> >
> > Here's what I got for block + nvme. It relies on all the requests to
> > complete to set the task back to running.
> 
> Yeah, but your patch doesn't add that change, and looks 'task_struct *'
> in submission path need to be stored in request or somewhere else.

The polling function shouldn't have to set the task to running. The
task_struct is the dio's "waiter", and dio_bio_end_io sets its state
to noromal running when every bio submitted and split chained bios
complete. Hopefully those all complete through the ->poll(), and
blk_poll will automatically observe the state changed.

> Then looks the whole hw queue is polled and only the queue num
> in cookie matters.
>
> In theory, there might be one race:
> 
> - one dio need to submit several bios(suppose there are two bios: A and B)
> - A is submitted to hardware queue M
> - B is submitted to hardware queue N because the current task is migrated
> to another CPU
> - then only hardware queue N is polled

Yeah, in that case we'd rely on the queue M's interrupt handler to do
the completion.

Avoiding the context switch was the biggest win for polling, as I
understand it. If the task is being migrated to other CPUs, I think
we've already lost the latency benefit we'd have got.
