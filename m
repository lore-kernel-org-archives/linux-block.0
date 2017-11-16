Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:27180 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758343AbdKPJqp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Nov 2017 04:46:45 -0500
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
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
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V13 00/10] mmc: Add Command Queue support
Date: Thu, 16 Nov 2017 10:46:40 +0100
Message-id: <1716036.6EalJ2kXtr@amdc3058>
In-reply-to: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com>
MIME-version: 1.0
Content-type: text/plain; charset="us-ascii"
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com>
        <CGME20171116094642epcas1p14018cb1c475efa38942109dc24cd6da9@epcas1p1.samsung.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Friday, November 03, 2017 03:20:10 PM Adrian Hunter wrote:
> Hi
> 
> Here is V13 of the hardware command queue patches without the software
> command queue patches, now using blk-mq and now with blk-mq support for
> non-CQE I/O.
> 
> HW CMDQ offers 25% - 50% better random multi-threaded I/O.  I see a slight
> 2% drop in sequential read speed but no change to sequential write.
> 
> Non-CQE blk-mq showed a 3% decrease in sequential read performance.  This
> seemed to be coming from the inferior latency of running work items compared
> with a dedicated thread.  Hacking blk-mq workqueue to be unbound reduced the
> performance degradation from 3% to 1%.
> 
> While we should look at changing blk-mq to give better workqueue performance,
> a bigger gain is likely to be made by adding a new host API to enable the
> next already-prepared request to be issued directly from within ->done()
> callback of the current request.

Tested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> [ for non-CQE changes ]

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
