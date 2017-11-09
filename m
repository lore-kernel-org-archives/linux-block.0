Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:45150 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752560AbdKIMw2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Nov 2017 07:52:28 -0500
Received: by mail-it0-f45.google.com with SMTP id u132so7549666ita.0
        for <linux-block@vger.kernel.org>; Thu, 09 Nov 2017 04:52:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <afcf5ce3-2795-3f88-3544-d939d3513f4f@intel.com>
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com>
 <1509715220-31885-9-git-send-email-adrian.hunter@intel.com>
 <CACRpkdb2_D3WZZp2f2o+f+zc7R-jU=wfs7Ec1rppim0mTd-sDw@mail.gmail.com> <afcf5ce3-2795-3f88-3544-d939d3513f4f@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 9 Nov 2017 13:52:27 +0100
Message-ID: <CACRpkdaHhp2dQAsFX8ps9hsG5BjcS5eywfz4ty1qkCyZmOqX+A@mail.gmail.com>
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

On Thu, Nov 9, 2017 at 8:56 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 08/11/17 11:30, Linus Walleij wrote:
>> On Fri, Nov 3, 2017 at 2:20 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>>> Recovery is simpler to understand if it is only used for errors. Create a
>>> separate function for card polling.
>>>
>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>
>> This looks good but I can't see why it's not folded into
>> patch 3 already. This error handling is introduced there.
>
> What are you on about?

You are attacking your most valuable resource, a reviewer.

And I even said the patch looks good.

The only thing you attain with this kind of langauge is alienante
me and discourage others to review your patch set. You also
give your employer a bad name, since you are representing
them.

> If we're going to split up the patches (which I
> argued against - the new code is all new, so it could be read independently
> from the old mess) then this is a logically distinct step.  Polling and
> error-recovery are conceptually different things and it is important to
> separate them to make the code easier to understand.

I understand it can be tough to deal with review comments
and it can make you loose your temper when people (sometimes
even the same person!) say contradictory things.

But in hindsight, don't you think these 5 last lines of your message
had been enough without that first line?

Yours,
Linus Walleij
