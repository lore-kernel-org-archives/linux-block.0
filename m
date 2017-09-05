Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:33669 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752257AbdIEHYO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Sep 2017 03:24:14 -0400
Received: by mail-io0-f171.google.com with SMTP id y123so11603968iod.0
        for <linux-block@vger.kernel.org>; Tue, 05 Sep 2017 00:24:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e3610014-7eab-6b9f-759a-39771ea2d8df@intel.com>
References: <1504180616-14514-1-git-send-email-adrian.hunter@intel.com>
 <ff9eeab1-199a-3ab3-9fa8-cc2f08d52a54@intel.com> <CAPDyKFriJLD-Q76tyUwXkAWJ8D3g=KOMt1rAtmufg97=Wh3jAQ@mail.gmail.com>
 <19b101f2-f4ea-8360-ccd2-99a085ecc416@intel.com> <8e636dd3-89e1-30b2-2c16-626ea33a12fd@intel.com>
 <CAPDyKFqVmaTeyA4e3J2ck6tFmO4fnEyOxAkS7zNGtx811MXRMA@mail.gmail.com> <e3610014-7eab-6b9f-759a-39771ea2d8df@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 5 Sep 2017 09:24:13 +0200
Message-ID: <CAPDyKFo9=eXzgQ=VwrkbgV_U5OwC7-yCb42wee-7zcRW=NVQAQ@mail.gmail.com>
Subject: Re: [PATCH V7 00/10] mmc: Add Command Queue support
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

[...]

>>>
>>> I can send blk-mq support for legacy requests in a few days if you like, but
>>> I want to hear a better explanation of why you are delaying CQE support.
>>
>> That would be very nice, however be aware of that we are in the merge
>> window, so I am not picking new material for 4.14 from this point. I
>> assume you understand why.
>
> Nope.  This is new functionality - doesn't affect anyone who doesn't have a
> command queue engine.  Next to no chance of regressions.  Tested by several
> in the community.  Substantially unchanged since February.  It is not even
> very much code in the block driver.

Let me make it clear, once more - I don't want to maintain more hacks
in mmc block layer code.

This series add blkmq support, using a method (which may be considered
as intermediate) via a new change in patch1 - but only for the new CQE
path. That means the old legacy mmc block path is still there. So, for
the reason stated above - no thanks!

>
>>
>> Still, big changes is always nice to queue up early for a release
>> cycle. Let's aim for that!
>
> You said that in February.  Never happened.  You said you wanted blk-mq, so
> I waited to re-base on top, but it never appeared.

Yes, I want blkmq - and I believe I have explained why several times by now.

Unfortunate, blkmq just doesn't appear, we have to work on it - together.

>
>> Moreover, I am not delaying CQE, but really want it to be merged asap!
>> However, I am also having the role as a maintainer and the things that
>> comes with it. For example, I would like the community to reach
>> consensus around how to move forward with CQE, before I decide to pick
>> it up.
>
> It has been more than 6 months.  That is enough time to wait for "consensus".

Normally it should be more than enough, on the other hand, it has
turned out this was more complex than we first thought.

Kind regards
Uffe
