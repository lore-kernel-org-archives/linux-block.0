Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:37603 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752289AbdKOKzZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Nov 2017 05:55:25 -0500
Received: by mail-io0-f174.google.com with SMTP id v21so1149226ioi.4
        for <linux-block@vger.kernel.org>; Wed, 15 Nov 2017 02:55:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CACRpkdY1Jn+=rs0KDX3wrQy56KP3mJKCS7Hs7_DqusvQXNJMjg@mail.gmail.com>
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com>
 <1509715220-31885-4-git-send-email-adrian.hunter@intel.com>
 <CACRpkdbLRc8PMguqHOokhyZVUua2TGLL11BCxTawQoWdD2ZaGg@mail.gmail.com>
 <416a00a8-3ea0-b600-aa60-b0d176c967a3@intel.com> <CACRpkdakoJ+Ktyz-NyR=Ut7Qff+9yMdZQa9hqL7jAXdWwtLxjQ@mail.gmail.com>
 <000ada93-ff28-a166-c95d-542a01cf926a@intel.com> <CACRpkdY1Jn+=rs0KDX3wrQy56KP3mJKCS7Hs7_DqusvQXNJMjg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 15 Nov 2017 11:55:24 +0100
Message-ID: <CAPDyKFossXeuRsRfe13U0_Qokwm66S5batLB3VPBSMa2HHhQDA@mail.gmail.com>
Subject: Re: [PATCH V13 03/10] mmc: block: Add blk-mq support
To: Linus Walleij <linus.walleij@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
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

Linus, Adrian,

Apologize for sidetracking the discussion, just wanted to add some
minor comments.

[...]

>
>>> But what I think is nice in doing it around
>>> each request is that since mmc_put_card() calls mmc_release_host()
>>> contains this:
>>>
>>> if (--host->claim_cnt) { (...)
>>>
>>> So there is a counter inside the claim/release host functions
>>> and now there is another counter keeping track if the in-flight
>>> requests as well and it gives me the feeling we are maintaining
>>> two counters when we only need one.
>>
>> The gets / puts also get runtime pm for the card.  It is a lot a messing
>> around for the sake of a quick check for the number of requests inflight -
>> which is needed anyway for CQE.

Actually the get / puts for runtime PM of the card is already done
taking the host->claim_cnt into account.

In other words, the additional in-flight counter does not provide an
additional improvement in this regards.

For that reason, perhaps the in-flight counter should be added in the
CQE patch instead, because it seems like it is there it really
belongs?

[...]

>
> OK I guess I'm more forging ahead with such things. But we could
> at least enable it by default so whoever checks out and builds
> and tests linux-next with their MMC/SD controllers will then be
> testing this for us in the next kernel cycle.
>
>>> But I think I would prefer that if a big slew of new code is
>>> introduced it needs to be put to wide use and any bugs
>>> smoked out during the -rc phase, and we are now
>>> hiding it behind a Kconfig option so it's unlikely to see testing
>>> until that option is turned on, and that is not good.
>>
>> And if you find a big problem in rc7, then what do you do?  At least with
>> the config option, the revert is trivial.
>
> I see your point. I guess it is up to Ulf how he feels about
> trust wrt the code. If a problem appears at -rc7 it's indeed
> nice if we can leave the code in-tree and work on it.

Well, it's not an easy decision, simply because it moves the code in
an even worse situation maintenance wise. So, if you guys just
suddenly have to move on to do something else, then it becomes my
problem to work out. :-)

However, as I trust both of you, and that you seems to agree on the
path forward, I am fine keeping the old code for while.

Although, please make sure the Kconfig option starts out by being
enabled by default, so we can get some test coverage of the mq path.

Of course, then we need to work on the card removal problem asap, and
hopefully we manage to fix them. If not, or other strange errors
happens, we would need to change the default value to 'n' of the
Kconfig.

[...]

>>> Hm! What you are saying sounds correct, and we really need to
>>> consider the multi-CPU aspects of this, maybe not now. I am
>>> happy as long as we have equal performance as before and
>>> maintainable code.
>>
>> Well I saw 3% drop in sequential read performance, improving to 1% when an
>> unbound workqueue was used.

Can you please make this improvement as a standalone patch on top of
the mq patch?

I think that would be good, because it points out some generic
problems with mq, which we then, at least short term, tries to address
locally in MMC.

[...]

>
>>> If you just make a series also deleteing the old block layer
>>> I will test it so it doesn't break anything and then you can
>>> probably expect a big Acked-by on the whole shebang.
>>
>> I will add patches for that - let's see what happens.

Yes, please. However, I will as stated, be withholding that change for
a while, until we fixed any showstoppers in the mq path.

[...]

Kind regards
Uffe
