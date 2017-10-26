Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:44189 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932234AbdJZOZQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Oct 2017 10:25:16 -0400
Received: by mail-io0-f179.google.com with SMTP id m16so5760718iod.1
        for <linux-block@vger.kernel.org>; Thu, 26 Oct 2017 07:25:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c40aa526-3ea5-205a-ba7c-c1f4ae004f4b@intel.com>
References: <1508834428-4360-1-git-send-email-adrian.hunter@intel.com>
 <CACRpkdZQEkvLB_-6H12Uo4xizLEV93KrLReONUq=Fq=cryKz8A@mail.gmail.com> <c40aa526-3ea5-205a-ba7c-c1f4ae004f4b@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 26 Oct 2017 16:25:15 +0200
Message-ID: <CACRpkdaLifRdH0hcnXX1LzC_7TqrhSgmYSvYvRBy_j9WbXoRbw@mail.gmail.com>
Subject: Re: [PATCH V12 0/5] mmc: Add Command Queue support
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

On Thu, Oct 26, 2017 at 3:49 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 26/10/17 16:32, Linus Walleij wrote:

>> My patch series switches the stack around to make it possible
>> to do this. But it doesn't go the whole way to complete the requests
>> from interrupt context.
>>
>> Since we have to send commands for retune etc request finalization
>> cannot easily be done from interrupt context.
>
> Re-tuning and background operations are rare and slow, so there is no reason
> to try to start them from interrupt context.

OK I will try to get them out of the way and see what happens,
hehe :)

What I mean is that we were checking - on every command -
if BKOPS or retune needs to happen. And then doing it. Thus
all was done in process context.

>> But I am thinking about testing to hack it
>> using some ugly approaches ... like assuming we don't need any
>> retune etc and just say all is fine and optimistically complete the
>> request directly in the interrupt handler if all was OK and wait
>> for errors to happen before retuning.
>
> It already works that way.  Re-tuning happens before you start a request.
> We prevent re-tuning in between dependent requests, like between starting a
> transfer and CMD13 polling for completion.

Ah that is what these if()s do ... right. I'll see if I can get around
this then.

Yours,
Linus Walleij
