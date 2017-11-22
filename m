Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:26544 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751148AbdKVHkp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Nov 2017 02:40:45 -0500
Subject: Re: [PATCH V14 07/24] mmc: block: Use data timeout in
 card_busy_detect()
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
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
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Christoph Hellwig <hch@lst.de>
References: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com>
 <1511271770-3444-8-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFovzm6DuNGiJq3kBpa59zRwq35xAfw5dL6Cbq7FG1wapw@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <be5cdd62-92ba-12f5-946f-1b29493e6dc4@intel.com>
Date: Wed, 22 Nov 2017 09:40:24 +0200
MIME-Version: 1.0
In-Reply-To: <CAPDyKFovzm6DuNGiJq3kBpa59zRwq35xAfw5dL6Cbq7FG1wapw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 21/11/17 17:39, Ulf Hansson wrote:
> On 21 November 2017 at 14:42, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> card_busy_detect() has a 10 minute timeout. However the correct timeout is
>> the data timeout. Change card_busy_detect() to use the data timeout.
> 
> Unfortunate I don't think there is "correct" timeout for this case.
> 
> The data->timeout_ns is to indicate for the host to how long the
> maximum time it's allowed to take between blocks that are written to
> the data lines.
> 
> I haven't found a definition of the busy timeout, after the data write
> has completed. The spec only mentions that the device moves to
> programming state and pulls DAT0 to indicate busy.

To me it reads more like the timeout is for each block, including the last
i.e. the same timeout for "busy".  Note the card is also busy between blocks.

Equally it is the timeout we give the host controller.  So either the host
controller does not have a timeout for "busy" - which begs the question why
it has a timeout at all - or it invents its own "busy" timeout - which begs
the question why it isn't in the spec.

> 
> Sure, 10 min seems crazy, perhaps something along the lines of 10-20 s
> is more reasonable. What do you think?

We give SD cards a generous 3 seconds for writes.  SDHCI has long had a 10
second software timer for the whole request, which strongly suggests that
requests have always completed within 10 seconds.  So that puts the range of
an arbitrary timeout 3-10 s.
