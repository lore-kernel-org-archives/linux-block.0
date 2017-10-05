Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:44014 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbdJEMAy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Oct 2017 08:00:54 -0400
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: "Hunter, Adrian" <adrian.hunter@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Alex Lemberg <alex.lemberg@sandisk.com>,
        "Nowak, Mateusz" <mateusz.nowak@intel.com>,
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
Date: Thu, 05 Oct 2017 14:00:48 +0200
Message-id: <1591139.5Ihy91Pq6o@amdc3058>
In-reply-to: <363DA0ED52042842948283D2FC38E4649BF33EFD@IRSMSX106.ger.corp.intel.com>
MIME-version: 1.0
Content-type: text/plain; charset="us-ascii"
References: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com>
        <2384661.GfpEZ6rEzz@amdc3058>
        <363DA0ED52042842948283D2FC38E4649BF33EFD@IRSMSX106.ger.corp.intel.com>
        <CGME20171005120050epcas1p12545f3cd0939b83010aa5e0355ac9818@epcas1p1.samsung.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Hi,

On Wednesday, October 04, 2017 07:23:07 PM Hunter, Adrian wrote:
> > -----Original Message-----
> > From: Bartlomiej Zolnierkiewicz [mailto:b.zolnierkie@samsung.com]
> > Sent: Wednesday, October 4, 2017 12:40 PM
> > To: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Hunter, Adrian <adrian.hunter@intel.com>; Ulf Hansson
> > <ulf.hansson@linaro.org>; linux-mmc <linux-mmc@vger.kernel.org>; linux-
> > block <linux-block@vger.kernel.org>; linux-kernel <linux-
> > kernel@vger.kernel.org>; Bough Chen <haibo.chen@nxp.com>; Alex
> > Lemberg <alex.lemberg@sandisk.com>; Nowak, Mateusz
> > <mateusz.nowak@intel.com>; Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>;
> > Jaehoon Chung <jh80.chung@samsung.com>; Dong Aisheng
> > <dongas86@gmail.com>; Das Asutosh <asutoshd@codeaurora.org>;
> > Zhangfei Gao <zhangfei.gao@gmail.com>; Sahitya Tummala
> > <stummala@codeaurora.org>; Harjani Ritesh <riteshh@codeaurora.org>;
> > Venu Byravarasu <vbyravarasu@nvidia.com>; Shawn Lin <shawn.lin@rock-
> > chips.com>; Christoph Hellwig <hch@lst.de>
> > Subject: Re: [PATCH V9 13/15] mmc: block: Add CQE and blk-mq support
> > 
> > 
> > Hi,
> > 
> > On Wednesday, October 04, 2017 09:39:45 AM Linus Walleij wrote:
> > > On Fri, Sep 22, 2017 at 2:37 PM, Adrian Hunter <adrian.hunter@intel.com>
> > wrote:
> > >
> > > > Add CQE support to the block driver, including:
> > > >     - optionally using DCMD for flush requests
> > > >     - "manually" issuing discard requests
> > > >     - issuing read / write requests to the CQE
> > > >     - supporting block-layer timeouts
> > > >     - handling recovery
> > > >     - supporting re-tuning
> > > >
> > > > CQE offers 25% - 50% better random multi-threaded I/O.  There is a
> > > > slight (e.g. 2%) drop in sequential read speed but no observable
> > > > change to sequential write.
> > > >
> > > > CQE automatically sends the commands to complete requests.  However
> > > > it only supports reads / writes and so-called "direct commands"
> > > > (DCMD).  Furthermore DCMD is limited to one command at a time, but
> > discards require 3 commands.
> > > > That makes issuing discards through CQE very awkward, but some CQE's
> > > > don't support DCMD anyway.  So for discards, the existing non-CQE
> > > > approach is taken, where the mmc core code issues the 3 commands one
> > at a time i.e.
> > > > mmc_erase(). Where DCMD is used, is for issuing flushes.
> > > >
> > > > For host controllers without CQE support, blk-mq support is extended
> > > > to synchronous reads/writes or, if the host supports
> > > > CAP_WAIT_WHILE_BUSY, asynchonous reads/writes.  The advantage of
> > > > asynchronous reads/writes is that it allows the preparation of the
> > > > next request while the current request is in progress.
> > > >
> > > > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > >
> > > I am trying to wrap my head around this large patch. The size makes it
> > > hard but I am doing my best.
> > 
> > I also think that this patch should be split on two patches. The 1st one
> > introducing blk-mq and the 2nd one adding CQE support.
> > 
> > [ I don't agree that they make more sense together, on the contrary,
> >   it is very difficult to properly analyze blk-mq changes on their
> >   own while there are mixed with CQE related ones. ]
> 
> The CQE and non-CQE code paths are clearly marked.  But maybe you

The combined patch is > 1 kLOC which is a lot and since the CQE and
non-CQE code paths are clearly marked it should be really easy to
split them.

> are asking what the code would look like if we *never* had to support CQE.
> And my point is we *do* have to support CQE. 

We *do* but not in the same step, it is just normal kernel engineering
practice to split patches on logical changes. This is not asking about
something extraordinary.

> Do you have any questions about the code?

I would really hope to see more documentation about blk-mq changes
first before starting to review it. The patch description documents
CQE changes but not blk-mq ones and the code itself is also lacking
in-code documentation describing new functions added for blk-mq.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
