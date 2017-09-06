Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33367 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750986AbdIFH1B (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Sep 2017 03:27:01 -0400
Subject: Re: [PATCH V7 00/10] mmc: Add Command Queue support
To: Ulf Hansson <ulf.hansson@linaro.org>
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
References: <1504180616-14514-1-git-send-email-adrian.hunter@intel.com>
 <ff9eeab1-199a-3ab3-9fa8-cc2f08d52a54@intel.com>
 <CAPDyKFriJLD-Q76tyUwXkAWJ8D3g=KOMt1rAtmufg97=Wh3jAQ@mail.gmail.com>
 <19b101f2-f4ea-8360-ccd2-99a085ecc416@intel.com>
 <8e636dd3-89e1-30b2-2c16-626ea33a12fd@intel.com>
 <CAPDyKFqVmaTeyA4e3J2ck6tFmO4fnEyOxAkS7zNGtx811MXRMA@mail.gmail.com>
 <e3610014-7eab-6b9f-759a-39771ea2d8df@intel.com>
 <CAPDyKFo9=eXzgQ=VwrkbgV_U5OwC7-yCb42wee-7zcRW=NVQAQ@mail.gmail.com>
 <9c7a50c5-b0a4-efae-442e-b331f93e1a8f@intel.com>
 <CAPDyKFp28BJuFq2jBVTYBAaeE4AnD8e2Ywj74SyA4wmG=BV9SQ@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <e6ae92d2-b3a5-2d5a-28fd-4793bab20914@intel.com>
Date: Wed, 6 Sep 2017 10:20:09 +0300
MIME-Version: 1.0
In-Reply-To: <CAPDyKFp28BJuFq2jBVTYBAaeE4AnD8e2Ywj74SyA4wmG=BV9SQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/09/17 20:54, Ulf Hansson wrote:
> On 5 September 2017 at 10:10, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 05/09/17 10:24, Ulf Hansson wrote:
>>> [...]
>>>
>>>>>>
>>>>>> I can send blk-mq support for legacy requests in a few days if you like, but
>>>>>> I want to hear a better explanation of why you are delaying CQE support.
>>>>>
>>>>> That would be very nice, however be aware of that we are in the merge
>>>>> window, so I am not picking new material for 4.14 from this point. I
>>>>> assume you understand why.
>>>>
>>>> Nope.  This is new functionality - doesn't affect anyone who doesn't have a
>>>> command queue engine.  Next to no chance of regressions.  Tested by several
>>>> in the community.  Substantially unchanged since February.  It is not even
>>>> very much code in the block driver.
>>>
>>> Let me make it clear, once more - I don't want to maintain more hacks
>>> in mmc block layer code.
>>>
>>> This series add blkmq support, using a method (which may be considered
>>> as intermediate) via a new change in patch1 - but only for the new CQE
>>> path. That means the old legacy mmc block path is still there. So, for
>>> the reason stated above - no thanks!
>>
>> And where is your alternative.  When I pointed out you need a way to
>> arbitrate between internal partitions, you went silent again.
>>
>> Can't have CQE without blk-mq but can't have blk-mq because you don't
>> understand it, is hardly acceptable.
> 
> Adrian, this discussion seems to lead nowhere. Can we please stop and
> be constructive instead!

If you want to be constructive you will queue CQE support for v4.15 now!

> 
> Regarding the arbitration issue. We have been moving forward,
> re-factoring the mmc block driver code, soon also solving the problem
> for the rpmb internal partition [1]. Maybe the background to why Linus
> is working on mmc block re-factoring, hasn't been entirely clear.
> Anyway, it's exactly because of moving closer to address these issues.

Nope, wrt blk-mq you are moving sideways with no clear idea where you're going.

> Even if the problems certainly becomes a step harder to resolve for
> the boot and the general purpose partitions, it's still a path we
> should try to find a solution for. Yeah, that may mean we need to
> suggest changes for the generic block layer, to teach it to better
> deal with these kind of devices.

You mean you have no idea how to do it but we are still expected to wait.
How is that acceptable!

> Finally, I have never said the arbitration issue *must* be solved
> before converting to blkmq. Only that we should avoid performance
> regressions, but that of course applies to whatever changes we do.

Then there is no problem in queuing up the CQE patches now!
