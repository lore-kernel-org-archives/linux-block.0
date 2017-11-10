Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:53744 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbdKJIZU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Nov 2017 03:25:20 -0500
Received: by mail-it0-f42.google.com with SMTP id m191so753318itg.2
        for <linux-block@vger.kernel.org>; Fri, 10 Nov 2017 00:25:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <22024e13-0c04-c25c-9377-65c2cf606b4f@intel.com>
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com>
 <1509715220-31885-9-git-send-email-adrian.hunter@intel.com>
 <CACRpkdb2_D3WZZp2f2o+f+zc7R-jU=wfs7Ec1rppim0mTd-sDw@mail.gmail.com>
 <afcf5ce3-2795-3f88-3544-d939d3513f4f@intel.com> <CACRpkdaHhp2dQAsFX8ps9hsG5BjcS5eywfz4ty1qkCyZmOqX+A@mail.gmail.com>
 <22024e13-0c04-c25c-9377-65c2cf606b4f@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 10 Nov 2017 09:25:18 +0100
Message-ID: <CACRpkdY4P=1FR3upQF_Y3HUtrWh4yyz2p4_XYrkXjk8EhDjsOA@mail.gmail.com>
Subject: Re: [PATCH V13 08/10] mmc: block: blk-mq: Separate card polling from recovery
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
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

On Thu, Nov 9, 2017 at 2:02 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 09/11/17 14:52, Linus Walleij wrote:
>> On Thu, Nov 9, 2017 at 8:56 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 08/11/17 11:30, Linus Walleij wrote:
>>>> On Fri, Nov 3, 2017 at 2:20 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>>> Recovery is simpler to understand if it is only used for errors. Create a
>>>>> separate function for card polling.
>>>>>
>>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>>
>>>> This looks good but I can't see why it's not folded into
>>>> patch 3 already. This error handling is introduced there.
>>>
>>> What are you on about?
>>
>> You are attacking your most valuable resource, a reviewer.
>>
>> And I even said the patch looks good.
>>
>> The only thing you attain with this kind of langauge is alienante
>> me and discourage others to review your patch set. You also
>> give your employer a bad name, since you are representing
>> them.
>
> 6 months of being messed around will do that.

Blessed are the meek, for they will inherit the earth.

Nobody is after you, this is just hard stuff and too few people care to
help out with review etc. With this and with the block layer as well.
That makes things slow. It's noone's agenda to slow things down.

Yours,
Linus Walleij
