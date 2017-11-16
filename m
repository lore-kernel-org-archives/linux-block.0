Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:41580 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757171AbdKPHTa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Nov 2017 02:19:30 -0500
Received: by mail-io0-f169.google.com with SMTP id g73so4231551ioj.8
        for <linux-block@vger.kernel.org>; Wed, 15 Nov 2017 23:19:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a1d26e3a-f9bc-a6ba-9abd-a31cf760473d@intel.com>
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com>
 <1509715220-31885-4-git-send-email-adrian.hunter@intel.com>
 <CACRpkdbLRc8PMguqHOokhyZVUua2TGLL11BCxTawQoWdD2ZaGg@mail.gmail.com>
 <416a00a8-3ea0-b600-aa60-b0d176c967a3@intel.com> <CACRpkdakoJ+Ktyz-NyR=Ut7Qff+9yMdZQa9hqL7jAXdWwtLxjQ@mail.gmail.com>
 <000ada93-ff28-a166-c95d-542a01cf926a@intel.com> <CACRpkdY1Jn+=rs0KDX3wrQy56KP3mJKCS7Hs7_DqusvQXNJMjg@mail.gmail.com>
 <CAPDyKFossXeuRsRfe13U0_Qokwm66S5batLB3VPBSMa2HHhQDA@mail.gmail.com> <a1d26e3a-f9bc-a6ba-9abd-a31cf760473d@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 16 Nov 2017 08:19:28 +0100
Message-ID: <CAPDyKFoUjXdL98RrQ8QdEPaARRQmX0KXFWEsSzdoGtzZ4VFG7A@mail.gmail.com>
Subject: Re: [PATCH V13 03/10] mmc: block: Add blk-mq support
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
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

On 15 November 2017 at 14:07, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 15/11/17 12:55, Ulf Hansson wrote:
>> Linus, Adrian,
>>
>> Apologize for sidetracking the discussion, just wanted to add some
>> minor comments.
>>
>> [...]
>>
>>>
>>>>> But what I think is nice in doing it around
>>>>> each request is that since mmc_put_card() calls mmc_release_host()
>>>>> contains this:
>>>>>
>>>>> if (--host->claim_cnt) { (...)
>>>>>
>>>>> So there is a counter inside the claim/release host functions
>>>>> and now there is another counter keeping track if the in-flight
>>>>> requests as well and it gives me the feeling we are maintaining
>>>>> two counters when we only need one.
>>>>
>>>> The gets / puts also get runtime pm for the card.  It is a lot a messing
>>>> around for the sake of a quick check for the number of requests inflight -
>>>> which is needed anyway for CQE.
>>
>> Actually the get / puts for runtime PM of the card is already done
>> taking the host->claim_cnt into account.
>
> We do pm_runtime_get_sync(&card->dev) always i.e.
>
> void mmc_get_card(struct mmc_card *card, struct mmc_ctx *ctx)
> {
>         pm_runtime_get_sync(&card->dev);
>         __mmc_claim_host(card->host, ctx, NULL);
> }

You are absolutely correct, so let's leave the inflight counter in.
Apologize for the noise!

I was thinking about the runtime PM of the host dev, which is managed
by mmc_claim|release host().

[...]

>>>> Well I saw 3% drop in sequential read performance, improving to 1% when an
>>>> unbound workqueue was used.
>>
>> Can you please make this improvement as a standalone patch on top of
>> the mq patch?
>
> Unfortunately it was just a hack to the blk-mq core - the block layer does
> not have an unbound workqueue.  I have not had time to consider a proper
> fix.  It will have to wait, but I agree 3% is not enough to delay going forward.

I see, thanks!

[...]

Kind regards
Uffe
