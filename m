Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:35512 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753811AbdIDNs6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Sep 2017 09:48:58 -0400
Received: by mail-it0-f54.google.com with SMTP id c13so3006400itb.0
        for <linux-block@vger.kernel.org>; Mon, 04 Sep 2017 06:48:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8e636dd3-89e1-30b2-2c16-626ea33a12fd@intel.com>
References: <1504180616-14514-1-git-send-email-adrian.hunter@intel.com>
 <ff9eeab1-199a-3ab3-9fa8-cc2f08d52a54@intel.com> <CAPDyKFriJLD-Q76tyUwXkAWJ8D3g=KOMt1rAtmufg97=Wh3jAQ@mail.gmail.com>
 <19b101f2-f4ea-8360-ccd2-99a085ecc416@intel.com> <8e636dd3-89e1-30b2-2c16-626ea33a12fd@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 4 Sep 2017 15:48:57 +0200
Message-ID: <CAPDyKFqVmaTeyA4e3J2ck6tFmO4fnEyOxAkS7zNGtx811MXRMA@mail.gmail.com>
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

On 4 September 2017 at 09:06, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 01/09/17 16:28, Adrian Hunter wrote:
>> On 01/09/17 15:58, Ulf Hansson wrote:
>>> + Christoph
>>>
>>> On 1 September 2017 at 13:42, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>> On 31/08/17 14:56, Adrian Hunter wrote:
>>>>> Here is V7 of the hardware command queue patches without the software
>>>>> command queue patches, now using blk-mq.
>>>>>
>>>>> HW CMDQ offers 25% - 50% better random multi-threaded I/O.  I see a slight
>>>>> 2% drop in sequential read speed but no change to sequential write.
>>>>
>>>> Any comments?
>>>
>>> A couple of overall comments, for now.
>>>
>>> To make sure we don't overlook something when converting to mq, I
>>> would prefer that we first convert the existing mmc block code to mq,
>>> then we add CMDQ on top.
>>
>> That doesn't make sense.  This patch set is not converting the legacy driver
>> to mq therefore it cannot overlook anything for converting to mq.
>
> And then you go silent again.

We have weekends in Sweden - and I also work on other things than mmc :-).

I do however admit, that I could have been reviewing a bit faster
throughout the re-spins. Apologize for that, but I am only doing my
best.

>
> I can send blk-mq support for legacy requests in a few days if you like, but
> I want to hear a better explanation of why you are delaying CQE support.

That would be very nice, however be aware of that we are in the merge
window, so I am not picking new material for 4.14 from this point. I
assume you understand why.

Still, big changes is always nice to queue up early for a release
cycle. Let's aim for that!

Moreover, I am not delaying CQE, but really want it to be merged asap!
However, I am also having the role as a maintainer and the things that
comes with it. For example, I would like the community to reach
consensus around how to move forward with CQE, before I decide to pick
it up.

Kind regards
Uffe
