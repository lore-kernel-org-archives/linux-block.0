Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:48756 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbdKJISE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Nov 2017 03:18:04 -0500
Received: by mail-io0-f182.google.com with SMTP id d66so12753588ioe.5
        for <linux-block@vger.kernel.org>; Fri, 10 Nov 2017 00:18:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <03cc4d87-940c-797e-69e0-fffa630adc16@intel.com>
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com>
 <1509715220-31885-7-git-send-email-adrian.hunter@intel.com>
 <CACRpkdaf8nt1P32M+uYD3xSTTHMO8YMnP=Y56H179XiB9mvakQ@mail.gmail.com> <03cc4d87-940c-797e-69e0-fffa630adc16@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 10 Nov 2017 09:18:03 +0100
Message-ID: <CACRpkda9xV8D0M+-OYvUsxR-3MEnsOepCiHCE=dc_+cqmGaFWg@mail.gmail.com>
Subject: Re: [PATCH V13 06/10] mmc: sdhci-pci: Add CQHCI support for Intel GLK
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

On Thu, Nov 9, 2017 at 8:12 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 08/11/17 11:24, Linus Walleij wrote:
>> On Fri, Nov 3, 2017 at 2:20 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>>> Add CQHCI initialization and implement CQHCI operations for Intel GLK.
>>>
>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>
>> This patch seems OK in context, but it merely illustrates the
>> weirdness of .[runtime]_suspend/resume calling into CQE-specific
>> APIs rather than using generic host callbacks.
>
> Your comment makes no sense at all.  The host driver has
> [runtime]_suspend/resume callbacks and it is up to the host driver to decide
> what to do.  CQHCI provides helpers since that is the whole point of having
> a CQHCI library.

Yeah I didn't see it in context, the CQHCI library for these hosts
make a lot of sense.

Yours,
Linus Walleij
