Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:35326 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751480AbdIERy6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Sep 2017 13:54:58 -0400
Received: by mail-io0-f172.google.com with SMTP id i14so125408ioe.2
        for <linux-block@vger.kernel.org>; Tue, 05 Sep 2017 10:54:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9c7a50c5-b0a4-efae-442e-b331f93e1a8f@intel.com>
References: <1504180616-14514-1-git-send-email-adrian.hunter@intel.com>
 <ff9eeab1-199a-3ab3-9fa8-cc2f08d52a54@intel.com> <CAPDyKFriJLD-Q76tyUwXkAWJ8D3g=KOMt1rAtmufg97=Wh3jAQ@mail.gmail.com>
 <19b101f2-f4ea-8360-ccd2-99a085ecc416@intel.com> <8e636dd3-89e1-30b2-2c16-626ea33a12fd@intel.com>
 <CAPDyKFqVmaTeyA4e3J2ck6tFmO4fnEyOxAkS7zNGtx811MXRMA@mail.gmail.com>
 <e3610014-7eab-6b9f-759a-39771ea2d8df@intel.com> <CAPDyKFo9=eXzgQ=VwrkbgV_U5OwC7-yCb42wee-7zcRW=NVQAQ@mail.gmail.com>
 <9c7a50c5-b0a4-efae-442e-b331f93e1a8f@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 5 Sep 2017 19:54:57 +0200
Message-ID: <CAPDyKFp28BJuFq2jBVTYBAaeE4AnD8e2Ywj74SyA4wmG=BV9SQ@mail.gmail.com>
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

On 5 September 2017 at 10:10, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 05/09/17 10:24, Ulf Hansson wrote:
>> [...]
>>
>>>>>
>>>>> I can send blk-mq support for legacy requests in a few days if you like, but
>>>>> I want to hear a better explanation of why you are delaying CQE support.
>>>>
>>>> That would be very nice, however be aware of that we are in the merge
>>>> window, so I am not picking new material for 4.14 from this point. I
>>>> assume you understand why.
>>>
>>> Nope.  This is new functionality - doesn't affect anyone who doesn't have a
>>> command queue engine.  Next to no chance of regressions.  Tested by several
>>> in the community.  Substantially unchanged since February.  It is not even
>>> very much code in the block driver.
>>
>> Let me make it clear, once more - I don't want to maintain more hacks
>> in mmc block layer code.
>>
>> This series add blkmq support, using a method (which may be considered
>> as intermediate) via a new change in patch1 - but only for the new CQE
>> path. That means the old legacy mmc block path is still there. So, for
>> the reason stated above - no thanks!
>
> And where is your alternative.  When I pointed out you need a way to
> arbitrate between internal partitions, you went silent again.
>
> Can't have CQE without blk-mq but can't have blk-mq because you don't
> understand it, is hardly acceptable.

Adrian, this discussion seems to lead nowhere. Can we please stop and
be constructive instead!

Regarding the arbitration issue. We have been moving forward,
re-factoring the mmc block driver code, soon also solving the problem
for the rpmb internal partition [1]. Maybe the background to why Linus
is working on mmc block re-factoring, hasn't been entirely clear.
Anyway, it's exactly because of moving closer to address these issues.

Even if the problems certainly becomes a step harder to resolve for
the boot and the general purpose partitions, it's still a path we
should try to find a solution for. Yeah, that may mean we need to
suggest changes for the generic block layer, to teach it to better
deal with these kind of devices.

Finally, I have never said the arbitration issue *must* be solved
before converting to blkmq. Only that we should avoid performance
regressions, but that of course applies to whatever changes we do.

[...]

Kind regards
Uffe

[1]
https://patchwork.kernel.org/patch/9911463/
