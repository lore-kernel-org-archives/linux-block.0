Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:41171 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbeB0ME5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Feb 2018 07:04:57 -0500
Subject: Re: [PATCH V15 06/22] mmc: block: Add blk-mq support
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
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
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Thierry Reding <treding@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>
References: <1511962879-24262-1-git-send-email-adrian.hunter@intel.com>
 <1511962879-24262-7-git-send-email-adrian.hunter@intel.com>
 <bc65b542-9703-aa04-f1c7-b10584e44391@gmail.com>
 <829308a3-3bf6-c173-65fa-e2a0f45f7f61@intel.com>
 <68886f99-97f5-897a-f754-6f414741bd5a@gmail.com>
 <22580b82-0257-b156-9f0c-79afa34067e5@gmail.com>
 <CACRpkdaWyV2VPFBsFAjt-a8t6f3F6XwonHxfR3HfUJ=C13uuWw@mail.gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a15e8905-6ca8-d078-d891-58dc2f30f463@gmail.com>
Date: Tue, 27 Feb 2018 15:04:35 +0300
MIME-Version: 1.0
In-Reply-To: <CACRpkdaWyV2VPFBsFAjt-a8t6f3F6XwonHxfR3HfUJ=C13uuWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 27.02.2018 11:57, Linus Walleij wrote:
> On Mon, Feb 26, 2018 at 10:48 PM, Dmitry Osipenko <digetx@gmail.com> wrote:
>> On 22.02.2018 20:54, Dmitry Osipenko wrote:
>>> On 22.02.2018 10:42, Adrian Hunter wrote:
> 
>>>> SDIO (unless it is a combo card) should be unaffected by changes to the
>>>> block driver.
>>
>> I don't know whether it's a combo card or not. Where I can find info about that?
>> Is it mentioned in sysfs somewhere?
> 
> Combo cards were used with very old (2000s) PDAs which had only
> one SD card slot which they wanted to use for WiFi and storage
> at the same time.
> 
> They are very uncommon and I haven't been able to locate any
> even for testing.
> 
> It is very unlikely that you have one.
> 
> However you would notice it from seeing a partition attachment
> message (like with an ordinary SD card) when you plug in your
> card.

Thank you very much for the explanation. It's not a combo card.
