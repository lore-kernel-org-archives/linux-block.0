Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:17906 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752745AbdLANOK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 Dec 2017 08:14:10 -0500
Subject: Re: [PATCH V15 00/22] mmc: Add Command Queue support
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
References: <1511962879-24262-1-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFrgC91Z3P-5U22gjKDqs_aZiQncGUrShWpFggkWzrRMjw@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <d35cff56-0923-cd9e-72ac-087819d4fed6@intel.com>
Date: Fri, 1 Dec 2017 15:13:46 +0200
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrgC91Z3P-5U22gjKDqs_aZiQncGUrShWpFggkWzrRMjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 29/11/17 17:47, Ulf Hansson wrote:
> Hi Adrian,
> 
> On 29 November 2017 at 14:40, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> Hi
>>
>> Here is V15 of the hardware command queue patches without the software
>> command queue patches, now using blk-mq and now with blk-mq support for
>> non-CQE I/O.
> 
> I have applied patches 1->19 for next.  Deferring patch 21->23 for a while.

Thank you!

> 
> For those patches that was more or less the same as in v14, I added Linus' ack.
> 
> Hopefully we get some help for the community to test this series on
> different HW (and I will be checking kernelci's boot reports). I
> haven't added Bartlomiej's tested-by and neither Linus' (because of
> the changes that has been made), so I hoping that will happen sooner
> or later.
> 
> Moreover, I will gladly add more peoples acks/reviewed-by and
> tested-by tags, at any point during this release cycle.

I also encourage anyone testing to report their results even if they don't
want to have a tested-by tag.
