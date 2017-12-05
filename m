Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:41720 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753026AbdLEPxS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Dec 2017 10:53:18 -0500
Received: by mail-it0-f50.google.com with SMTP id x28so2649425ita.0
        for <linux-block@vger.kernel.org>; Tue, 05 Dec 2017 07:53:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CACRpkda-hgDdTi6rEu3cL41QDzXGxBkY1x6CXJE8kUbLAR-uQQ@mail.gmail.com>
References: <1511962879-24262-1-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFrgC91Z3P-5U22gjKDqs_aZiQncGUrShWpFggkWzrRMjw@mail.gmail.com> <CACRpkda-hgDdTi6rEu3cL41QDzXGxBkY1x6CXJE8kUbLAR-uQQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 5 Dec 2017 16:53:16 +0100
Message-ID: <CAPDyKFrSpVaQ6kMD4kyZRdjpJLKD6P27FoEJjFfb-aUNBwrW6A@mail.gmail.com>
Subject: Re: [PATCH V15 00/22] mmc: Add Command Queue support
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
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
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 5 December 2017 at 11:10, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Nov 29, 2017 at 4:47 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>> I have applied patches 1->19 for next.  Deferring patch 21->23 for a while.
>>
>> For those patches that was more or less the same as in v14, I added Linus' ack.
>
> My ACK goes for the new set as well.

Great, I add it!

>
>> Hopefully we get some help for the community to test this series on
>> different HW (and I will be checking kernelci's boot reports). I
>> haven't added Bartlomiej's tested-by and neither Linus' (because of
>> the changes that has been made), so I hoping that will happen sooner
>> or later.
>
> I have run some tests yesterday and today using dd, find and
> iozone, vanilla and with fault injection of 1% errors and 10%
> errors, then stressing it additionally by ejecting the card
> in flight randomly a few times. Everything survived, it's rock solid
> from what I can tell!
>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>

Great, I add this as well.

>
> I am eager to see 21->23 applied too so I can see the end result
> and figure out if there is anything left in my patches that need
> to be catered for or if I can just focus on other stuff.

Yeah, if nothing happens, I may apply them early next week.

Kind regards
Uffe
