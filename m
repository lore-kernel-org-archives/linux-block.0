Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:47796 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754360AbdKIMeR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Nov 2017 07:34:17 -0500
Received: by mail-io0-f176.google.com with SMTP id h70so9651488ioi.4
        for <linux-block@vger.kernel.org>; Thu, 09 Nov 2017 04:34:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <fcba7824-db15-d331-e580-7e26f07e6939@intel.com>
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com>
 <1509715220-31885-8-git-send-email-adrian.hunter@intel.com>
 <CACRpkdb_ggnC6tguEajiiyMaC=NiNQ-pdOydNJ5w69HgQ05SmQ@mail.gmail.com> <fcba7824-db15-d331-e580-7e26f07e6939@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 9 Nov 2017 13:34:16 +0100
Message-ID: <CACRpkdb2AZbqU=J8X8EtS5WG1vORgOhTuq8TgENUAnv9A7O5VQ@mail.gmail.com>
Subject: Re: [PATCH V13 07/10] mmc: block: blk-mq: Add support for direct completion
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

On Thu, Nov 9, 2017 at 8:27 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 08/11/17 11:28, Linus Walleij wrote:
>> On Fri, Nov 3, 2017 at 2:20 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>>> For blk-mq, add support for completing requests directly in the ->done
>>> callback. That means that error handling and urgent background operations
>>> must be handled by recovery_work in that case.
>>>
>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>
>> I tried enabling this on my MMC host (mmci) but I got weird
>> DMA error messages when I did.
>>
>> I guess this has not been tested on a non-DMA-coherent
>> system?
>
> I don't see what DMA-coherence has to do with anything.
>
> Possibilities:
>         - DMA unmapping doesn't work in an atomic context
>         - requests' DMA operations have to be synchronized with each other

So since MMCI need the post_req() hook called with
an error code to properly tear down any DMA operations,
I was worried that maybe your error path is not doing this
(passing an error code or calling in the right order).

I had a bunch of fallouts in my own patch set relating
to that.

>> I think I might be seeing this because the .pre and .post
>> callbacks need to be strictly sequenced, and this is
>> maybe not taken into account here?
>
> I looked at mmci but that did not seem to be the case.
>
>> Isn't there as risk
>> that the .post callback of the next request is called before
>> the .post callback of the previous request has returned
>> for example?
>
> Of course, the requests are treated as independent.  If the separate DMA
> operations require synchronization, that is for the host driver to fix.

They are treated as independent by the block layer but
it is the subsystems duty to serialize them for the hardware,

MMCI strictly requires that pre/post hooks per request
happen in the right order, so if you have prepared a second
request after submitting the first, and the first fails, you have
to back out by unpreparing the second one before unpreparing
the first. It is also the only host driver requireing to be passed
an error code in the last parameter to the post hook in
order to work properly.

I think your patch set handles that nicely though, because I
haven't seen any errors, it's just when we do this direct
completion I see problems.

Yours,
Linus Walleij
