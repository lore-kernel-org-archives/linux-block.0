Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:39887 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751915AbdKJI3h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Nov 2017 03:29:37 -0500
Received: by mail-it0-f45.google.com with SMTP id y15so750722ita.4
        for <linux-block@vger.kernel.org>; Fri, 10 Nov 2017 00:29:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <6d116e6e-cf99-989c-6d66-7fef10541de2@intel.com>
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com>
 <1509715220-31885-6-git-send-email-adrian.hunter@intel.com>
 <CACRpkdYY_a3fuayN3z5xn952t=YYJ8LA6wqXDtd=7ea03a187w@mail.gmail.com>
 <a9eb7e73-31b4-6ff6-4a0d-1416c938039b@intel.com> <CACRpkdZ2Xr9xKg-FD1QB_Kq=E6TpBDg-3giamAVbuykAxi=9vw@mail.gmail.com>
 <6d116e6e-cf99-989c-6d66-7fef10541de2@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 10 Nov 2017 09:29:36 +0100
Message-ID: <CACRpkdaHU0A2dbjpuy9N85vJqEVxqBpfjzcjjWPa25rR3wGNzQ@mail.gmail.com>
Subject: Re: [PATCH V13 05/10] mmc: cqhci: support for command queue enabled host
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

On Thu, Nov 9, 2017 at 1:55 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 09/11/17 14:26, Linus Walleij wrote:

>>>> I think the above approach to put any CQE-specific callbacks
>>>> directly into the struct mmc_host_ops is way more viable.
>>>
>>> Nothing to do with CQE.  This is CQHCI.  Please try to get the difference.
>>
>> I am trying, please try to think about your language.
>
> I strongly disapprove of being rude but sadly it seems to get results.

Conflict is a natural part of human existence. Using it deliberately
to get one's way is manipulation. Admitting to being manipulative
is losing one's face in public.

Yours,
Linus Walleij
