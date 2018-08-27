Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726988AbeH0LUD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Aug 2018 07:20:03 -0400
Date: Mon, 27 Aug 2018 15:34:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: No protection on the hctx->dispatch_busy
Message-ID: <20180827073416.GB20731@ming.t460p>
References: <306399af-99d9-ed45-bf3b-75908ff9187c@oracle.com>
 <20180827070002.GA20731@ming.t460p>
 <923fdf9f-7081-4952-8778-34d01836bb2b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <923fdf9f-7081-4952-8778-34d01836bb2b@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Aug 27, 2018 at 03:25:50PM +0800, jianchao.wang wrote:
> 
> 
> On 08/27/2018 03:00 PM, Ming Lei wrote:
> > On Mon, Aug 27, 2018 at 01:56:39PM +0800, jianchao.wang wrote:
> >> Hi Ming
> >>
> >> Currently, blk_mq_update_dispatch_busy is hooked in blk_mq_dispatch_rq_list
> >> and __blk_mq_issue_directly. blk_mq_update_dispatch_busy could be invoked on multiple
> >> cpus concurrently. But there is not any protection on the hctx->dispatch_busy. We cannot
> >> ensure the update on the dispatch_busy atomically.
> > 
> > The update itself is atomic given type of this variable is 'unsigned int'.
> 
> The blk_mq_update_dispatch_busy doesn't just write on a unsigned int variable,
> but read, calculate and write. The whole operation is not atomic.

It won't be a big deal since the update is exponential weighted wrt. busy, and again
hctx->dispatch_busy is just an hint for improving performance.

> 
> > 
> >>
> >>
> >> Look at the test result after applied the debug patch below:
> >>
> >>              fio-1761  [000] ....   227.246251: blk_mq_update_dispatch_busy.part.50: old 0 ewma 2 cur 2
> >>              fio-1766  [004] ....   227.246252: blk_mq_update_dispatch_busy.part.50: old 2 ewma 1 cur 1
> >>              fio-1755  [000] ....   227.246366: blk_mq_update_dispatch_busy.part.50: old 1 ewma 0 cur 0
> >>              fio-1754  [003] ....   227.266050: blk_mq_update_dispatch_busy.part.50: old 2 ewma 3 cur 3
> >>              fio-1763  [007] ....   227.266050: blk_mq_update_dispatch_busy.part.50: old 0 ewma 2 cur 2
> >>              fio-1761  [000] ....   227.266051: blk_mq_update_dispatch_busy.part.50: old 3 ewma 2 cur 2
> >>              fio-1766  [004] ....   227.266051: blk_mq_update_dispatch_busy.part.50: old 3 ewma 2 cur 2
> >>              fio-1760  [005] ....   227.266165: blk_mq_update_dispatch_busy.part.50: old 2 ewma 1 cur 1
> >>
> ...
> >>
> >> Is it expected ?
> > 
> > Yes, it won't be a issue in reality given hctx->dispatch_busy is used as
> > a hint, and it often works as expected and hctx->dispatch_busy is convergent
> > finally because it is exponential weighted moving average.
> I just concern the value of dispatch_busy will bounce up and down in small range
> with high workload on 32 or higher core system due to the cache and non-atomic update

If it is figured out as busy on one path, we take it as busy, that is fine in current
usage. If the IO dispatch finally becomes not busy, hctx->dispatch_busy will be updated
as expected sooner or later.

In short, I don't see actual issue by this simple way without any protection.

Thanks,
Ming
