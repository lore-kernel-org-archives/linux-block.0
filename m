Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:46789 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbdLKM2u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Dec 2017 07:28:50 -0500
Received: by mail-it0-f54.google.com with SMTP id t1so15379891ite.5
        for <linux-block@vger.kernel.org>; Mon, 11 Dec 2017 04:28:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrgC91Z3P-5U22gjKDqs_aZiQncGUrShWpFggkWzrRMjw@mail.gmail.com>
References: <1511962879-24262-1-git-send-email-adrian.hunter@intel.com> <CAPDyKFrgC91Z3P-5U22gjKDqs_aZiQncGUrShWpFggkWzrRMjw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 Dec 2017 13:28:49 +0100
Message-ID: <CAPDyKFo8TKPDDy-0UhaucEWwwcgJzpEP30+WpKeRR8_2FopN4g@mail.gmail.com>
Subject: Re: [PATCH V15 00/22] mmc: Add Command Queue support
To: Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
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
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 29 November 2017 at 16:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Hi Adrian,
>
> On 29 November 2017 at 14:40, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> Hi
>>
>> Here is V15 of the hardware command queue patches without the software
>> command queue patches, now using blk-mq and now with blk-mq support for
>> non-CQE I/O.
>
> I have applied patches 1->19 for next.  Deferring patch 21->23 for a while.

We haven't got any reports about big regressions, I think this looks solid!

So, I have decided to apply 21->23 for next as well.

[...]

Thanks and kind regards
Uffe
