Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:46905 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbdIVOBz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2017 10:01:55 -0400
Received: by mail-io0-f180.google.com with SMTP id d16so3266360ioj.3
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2017 07:01:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <032894b4-8575-9d93-bf74-c96e7b778d9b@intel.com>
References: <1505302814-19313-1-git-send-email-adrian.hunter@intel.com>
 <1505302814-19313-9-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFqvE3YUnmLFUoU36jwYh6kKG89mj5pOy82zW6=EdWRN+g@mail.gmail.com> <032894b4-8575-9d93-bf74-c96e7b778d9b@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 22 Sep 2017 16:01:54 +0200
Message-ID: <CACRpkdbQU3V3SGH6dgOZU41W-384=GYw-pY=A6AnUY1MNWEKUA@mail.gmail.com>
Subject: Re: [PATCH V8 08/14] mmc: core: Add parameter use_blk_mq
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

On Fri, Sep 22, 2017 at 3:30 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 21/09/17 12:47, Ulf Hansson wrote:

>> I asume the goal of adding this option is to enable us to move slowly
>> forward. In general that might be a good idea, however for this
>> particular case I am not sure.
>>
>> The main reason is simply that I find it unlikely that people and
>> distributions will actually go in and change the default value, so in
>> the end we will just be adding new code, which isn't really going to
>> be much tested. That's what happened in scsi case.
>
> The argument that no one is going to test anyway so we shouldn't give them
> the opportunity, is not a sustainable vision for the future.  Instead we
> should reach out to relevant stakeholders and get them to do their testing
> with blk-mq first.

We *could* simply invert the option then. Default it to "y" and
only leave it as a debugging aid so that people can set it to
"n" if they want to test with MQ disabled.

This is also simple to revert by a oneliner just removing "default y"
if there are problems with it.

Yours,
Linus Walleij
