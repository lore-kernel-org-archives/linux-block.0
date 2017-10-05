Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:45831 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbdJELMD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Oct 2017 07:12:03 -0400
Received: by mail-io0-f178.google.com with SMTP id i38so705942iod.2
        for <linux-block@vger.kernel.org>; Thu, 05 Oct 2017 04:12:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2081590.uFvUN0fvNT@amdc3058>
References: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com>
 <2384661.GfpEZ6rEzz@amdc3058> <CGME20171005105552epcas1p45c58d8d356f029a0089271b903af3e48@epcas1p4.samsung.com>
 <CAPDyKFrVK2hK9LEPKRfTTMOvP6WD5ug+VTwOt9tDaiMKKUBsNA@mail.gmail.com> <2081590.uFvUN0fvNT@amdc3058>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Oct 2017 13:12:01 +0200
Message-ID: <CAPDyKFpT-2=_Td+6Hc+-fA86ThOx=nEq_J7m7u20NkcdRHRNaA@mail.gmail.com>
Subject: Re: [PATCH V9 13/15] mmc: block: Add CQE and blk-mq support
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 5 October 2017 at 12:55, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> On Wednesday, October 04, 2017 11:48:27 AM Ulf Hansson wrote:
>> [...]
>>
>> >> MQ code that doesn't perform and therefore we cannot switch seamlessly
>> >> to MQ.
>> >
>> > I think that switching seamlessly to blk-mq in short/medium-term
>> > is not possible (SCSI tried and failed to do so). The changes to
>> > the old path are very complex and besides affecting performance
>> > they also affect error recovery handling (which needs to be tested
>> > properly before the switch).
>>
>> Agreed, and that's why I have queued up the new Kconfig option for
>> enabling the blkmq path from MMC.
>
> This seems premature - the new Kconfig option change for "mmc-mq" should
> belong to the patch adding "mmc-mq" support (otherwise it may just confuse
> users who enable it).

I agree!

However my plan was to move forward with the CMDQ series, but I
realize that I may need to drop the Kconfig patch, in case CMDQ don't
make it for 4.15.

Kind regards
Uffe
