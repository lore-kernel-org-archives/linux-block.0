Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:47373 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750936AbdIEIRQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Sep 2017 04:17:16 -0400
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
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <9c7a50c5-b0a4-efae-442e-b331f93e1a8f@intel.com>
Date: Tue, 5 Sep 2017 11:10:37 +0300
MIME-Version: 1.0
In-Reply-To: <CAPDyKFo9=eXzgQ=VwrkbgV_U5OwC7-yCb42wee-7zcRW=NVQAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/09/17 10:24, Ulf Hansson wrote:
> [...]
> 
>>>>
>>>> I can send blk-mq support for legacy requests in a few days if you like, but
>>>> I want to hear a better explanation of why you are delaying CQE support.
>>>
>>> That would be very nice, however be aware of that we are in the merge
>>> window, so I am not picking new material for 4.14 from this point. I
>>> assume you understand why.
>>
>> Nope.  This is new functionality - doesn't affect anyone who doesn't have a
>> command queue engine.  Next to no chance of regressions.  Tested by several
>> in the community.  Substantially unchanged since February.  It is not even
>> very much code in the block driver.
> 
> Let me make it clear, once more - I don't want to maintain more hacks
> in mmc block layer code.
> 
> This series add blkmq support, using a method (which may be considered
> as intermediate) via a new change in patch1 - but only for the new CQE
> path. That means the old legacy mmc block path is still there. So, for
> the reason stated above - no thanks!

And where is your alternative.  When I pointed out you need a way to
arbitrate between internal partitions, you went silent again.

Can't have CQE without blk-mq but can't have blk-mq because you don't
understand it, is hardly acceptable.

> 
>>
>>>
>>> Still, big changes is always nice to queue up early for a release
>>> cycle. Let's aim for that!
>>
>> You said that in February.  Never happened.  You said you wanted blk-mq, so
>> I waited to re-base on top, but it never appeared.
> 
> Yes, I want blkmq - and I believe I have explained why several times by now.
> 
> Unfortunate, blkmq just doesn't appear, we have to work on it - together.

If we are working on it together, how come you have never taken the time to
find out how blk-mq works?

> 
>>
>>> Moreover, I am not delaying CQE, but really want it to be merged asap!
>>> However, I am also having the role as a maintainer and the things that
>>> comes with it. For example, I would like the community to reach
>>> consensus around how to move forward with CQE, before I decide to pick
>>> it up.
>>
>> It has been more than 6 months.  That is enough time to wait for "consensus".
> 
> Normally it should be more than enough, on the other hand, it has
> turned out this was more complex than we first thought.

Nonsense.  I have raised the issues time and again but there have never been
any replies.
