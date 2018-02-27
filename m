Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:36163 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbeB0I57 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Feb 2018 03:57:59 -0500
Received: by mail-it0-f49.google.com with SMTP id u5so14452386itc.1
        for <linux-block@vger.kernel.org>; Tue, 27 Feb 2018 00:57:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <22580b82-0257-b156-9f0c-79afa34067e5@gmail.com>
References: <1511962879-24262-1-git-send-email-adrian.hunter@intel.com>
 <1511962879-24262-7-git-send-email-adrian.hunter@intel.com>
 <bc65b542-9703-aa04-f1c7-b10584e44391@gmail.com> <829308a3-3bf6-c173-65fa-e2a0f45f7f61@intel.com>
 <68886f99-97f5-897a-f754-6f414741bd5a@gmail.com> <22580b82-0257-b156-9f0c-79afa34067e5@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Feb 2018 09:57:58 +0100
Message-ID: <CACRpkdaWyV2VPFBsFAjt-a8t6f3F6XwonHxfR3HfUJ=C13uuWw@mail.gmail.com>
Subject: Re: [PATCH V15 06/22] mmc: block: Add blk-mq support
To: Dmitry Osipenko <digetx@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Feb 26, 2018 at 10:48 PM, Dmitry Osipenko <digetx@gmail.com> wrote:
> On 22.02.2018 20:54, Dmitry Osipenko wrote:
>> On 22.02.2018 10:42, Adrian Hunter wrote:

>>> SDIO (unless it is a combo card) should be unaffected by changes to the
>>> block driver.
>
> I don't know whether it's a combo card or not. Where I can find info about that?
> Is it mentioned in sysfs somewhere?

Combo cards were used with very old (2000s) PDAs which had only
one SD card slot which they wanted to use for WiFi and storage
at the same time.

They are very uncommon and I haven't been able to locate any
even for testing.

It is very unlikely that you have one.

However you would notice it from seeing a partition attachment
message (like with an ordinary SD card) when you plug in your
card.

Yours,
Linus Walleij
