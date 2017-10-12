Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:49340 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752006AbdJLI2w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Oct 2017 04:28:52 -0400
Received: by mail-it0-f50.google.com with SMTP id y15so6309603ita.4
        for <linux-block@vger.kernel.org>; Thu, 12 Oct 2017 01:28:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACRpkdZSOsFHxPhcJptOM2SQ+EGj7sJx_CYyv+zsf1=RS_8paA@mail.gmail.com>
References: <1505302814-19313-1-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFr-XbMOmOkz1yXwmG1t=77eSsUO2kU7kKV0V1wrfcmWKg@mail.gmail.com>
 <2cd4c5fc-cc04-ba44-bea6-4547d84de3e2@intel.com> <CAPDyKFqE7UYOYrjykpV0GnQ+hg2oGXpALgn_8yKsQk19Y4nmSQ@mail.gmail.com>
 <9a789f9b-a8c4-8ae7-8f93-0d76f674bded@intel.com> <CAPDyKFoLa_aX3j693_tfkuaSKNvGB-ERdf2-9r4iF-+c0NnP9g@mail.gmail.com>
 <d41eee41-796a-db93-d388-b36123ecc364@intel.com> <CAPDyKFrMqXWagkPOtPk-PBThSUrSogUP=iL+9XeyD9E8qkp=bw@mail.gmail.com>
 <1b8bec1b-7340-cb89-65c0-e09b17037ca4@intel.com> <CAPDyKFqoMVemtCSHBzfK5YTqLsGEr_v_z7o=HOKCwEdVz0tH_w@mail.gmail.com>
 <CACRpkdZSOsFHxPhcJptOM2SQ+EGj7sJx_CYyv+zsf1=RS_8paA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 12 Oct 2017 10:28:51 +0200
Message-ID: <CAPDyKFpNQDohcHSXUjB8WzQf9TeH9cQjm9LQjQFmSVcGvgTNYA@mail.gmail.com>
Subject: Re: [PATCH V8 00/14] mmc: Add Command Queue support
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
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

On 12 October 2017 at 10:08, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Oct 11, 2017 at 3:58 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>> Actually completing the request in the ->done callback, may still be
>> possible, because in principle it only needs to inform the other
>> prepared request that it may start, before it continues to post
>> process/completes the current one.
>
> I try to do that in this patch:
> https://marc.info/?l=linux-mmc&m=148665460925587&w=2

Yeah, something like that!

>
> I'm trying to rebase this work now.

Great!

>
>> However, by looking at for example how mmci.c works, it actually holds
>> its spinlock while it calls mmc_request_done(). The same spinlock is
>> taken in the ->request() function, but not in the ->post_req()
>> function. In other words, completing the request in the ->done()
>> callback, would make mmci to keep the spinlock held throughout the
>> post processing cycle, which then prevents the next request from being
>> started.
>
> It seems my patch would not deliver in some drivers until we look
> into the locking semantics in the drivers.

Yes!

As a matter of fact the above change may actually introduce
performance regressions, in case the behavior of the driver doesn't
follow the expectations from the core. For that reason, either we have
to invent a new MMC cap to allow drivers to opt-in using the
"shortcut" or fix host drivers first.

Kind regards
Uffe
