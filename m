Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:54197 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753973AbdKIMEn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Nov 2017 07:04:43 -0500
Received: by mail-io0-f193.google.com with SMTP id 189so9558750iow.10
        for <linux-block@vger.kernel.org>; Thu, 09 Nov 2017 04:04:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <24ce2510-0b66-a9ff-ffd0-b04b095f7d1a@intel.com>
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com>
 <1509715220-31885-5-git-send-email-adrian.hunter@intel.com>
 <CACRpkda8znQ=jAN-b_SCMzSJU11PZwEyw6dzOE07T-2hf9T6XA@mail.gmail.com> <24ce2510-0b66-a9ff-ffd0-b04b095f7d1a@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 9 Nov 2017 13:04:42 +0100
Message-ID: <CACRpkdYWbNKAcY1VFXYDL0DRxDxStqZXnFZCUTfNfG0spie9ew@mail.gmail.com>
Subject: Re: [PATCH V13 04/10] mmc: block: Add CQE support
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

On Wed, Nov 8, 2017 at 2:20 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 08/11/17 11:00, Linus Walleij wrote:

>> This and other bits gives me the feeling CQE is now actually ONLY
>> working on the MQ path.
>
> I was not allowed to support non-mq.

Fair enough.

>> That is good. We only add new functionality on the MQ path,
>> yay!
>>
>> But this fact (only abailable iff MQ==true) should at least be
>> mentioned in the commit message I think?
>
> Why?  CQE is MQ only.

So if you read what I say, I think the commit message should
say that CQE is MQ only so that people know that CQE is
MQ only.

>> So why not ditch the old block layer or at least make MQ default?
>
> CQE is MQ only.

Yeah? So why keep it around for everything else?

>> When you keep it like this people have to reconfigure
>> their kernel to enable MQ before they see the benefits of MQ+CQE
>> combined, I think that should rather be the default experience.
>
> Not at all.  I guess you are confusing the legacy mmc with CQE.  CQE is not
> a layer on top of legacy mmc.  It is an alternative to legacy mmc.  CQE
> does not sit on top of the legacy mmc blk-mq support.  You don't have to
> enable legacy mmc blk-mq support to use CQE.

Now I am confused. I can't parse the last sentence. There is no
such thing as legcay blk-mq?

Yours,
Linus Walleij
