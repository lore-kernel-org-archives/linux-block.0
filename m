Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:49295 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbdJEOOv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Oct 2017 10:14:51 -0400
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
Date: Thu, 05 Oct 2017 16:14:45 +0200
Message-id: <1916712.dEBEVKDoTZ@amdc3058>
In-reply-to: <1591139.5Ihy91Pq6o@amdc3058>
MIME-version: 1.0
Content-type: text/plain; charset="us-ascii"
References: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com>
        <363DA0ED52042842948283D2FC38E4649BF33EFD@IRSMSX106.ger.corp.intel.com>
        <1591139.5Ihy91Pq6o@amdc3058>
        <CGME20171005141447epcas1p42fc9f210c5c00824d19824ebb01906b6@epcas1p4.samsung.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thursday, October 05, 2017 02:00:48 PM Bartlomiej Zolnierkiewicz wrote:

> > > > I am trying to wrap my head around this large patch. The size makes it
> > > > hard but I am doing my best.
> > > 
> > > I also think that this patch should be split on two patches. The 1st one
> > > introducing blk-mq and the 2nd one adding CQE support.
> > > 
> > > [ I don't agree that they make more sense together, on the contrary,
> > >   it is very difficult to properly analyze blk-mq changes on their
> > >   own while there are mixed with CQE related ones. ]
> > 
> > The CQE and non-CQE code paths are clearly marked.  But maybe you
> 
> The combined patch is > 1 kLOC which is a lot and since the CQE and
> non-CQE code paths are clearly marked it should be really easy to
> split them.
> 
> > are asking what the code would look like if we *never* had to support CQE.
> > And my point is we *do* have to support CQE. 
> 
> We *do* but not in the same step, it is just normal kernel engineering
> practice to split patches on logical changes. This is not asking about
> something extraordinary.

BTW:

I sympathize with you that it takes long time to get CQE merged
upstream and that you weren't told earlier that no new users of
the old block API are welcomed.

However since "mmc-mq" support has to be added as a preparation for
CQE please try do it *properly* and also consider that many people
may want just "mmc-mq" without CQE as their hardware simply doesn't
support CQE.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
