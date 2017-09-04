Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:31837 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751949AbdIDHNN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Sep 2017 03:13:13 -0400
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
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <8e636dd3-89e1-30b2-2c16-626ea33a12fd@intel.com>
Date: Mon, 4 Sep 2017 10:06:25 +0300
MIME-Version: 1.0
In-Reply-To: <19b101f2-f4ea-8360-ccd2-99a085ecc416@intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/09/17 16:28, Adrian Hunter wrote:
> On 01/09/17 15:58, Ulf Hansson wrote:
>> + Christoph
>>
>> On 1 September 2017 at 13:42, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 31/08/17 14:56, Adrian Hunter wrote:
>>>> Here is V7 of the hardware command queue patches without the software
>>>> command queue patches, now using blk-mq.
>>>>
>>>> HW CMDQ offers 25% - 50% better random multi-threaded I/O.  I see a slight
>>>> 2% drop in sequential read speed but no change to sequential write.
>>>
>>> Any comments?
>>
>> A couple of overall comments, for now.
>>
>> To make sure we don't overlook something when converting to mq, I
>> would prefer that we first convert the existing mmc block code to mq,
>> then we add CMDQ on top.
> 
> That doesn't make sense.  This patch set is not converting the legacy driver
> to mq therefore it cannot overlook anything for converting to mq.

And then you go silent again.

I can send blk-mq support for legacy requests in a few days if you like, but
I want to hear a better explanation of why you are delaying CQE support.
