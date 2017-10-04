Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:49702 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbdJDJs3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Oct 2017 05:48:29 -0400
Received: by mail-io0-f172.google.com with SMTP id 21so10009621iof.6
        for <linux-block@vger.kernel.org>; Wed, 04 Oct 2017 02:48:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2384661.GfpEZ6rEzz@amdc3058>
References: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com>
 <1506083824-4024-14-git-send-email-adrian.hunter@intel.com>
 <CGME20171004093941epcas1p1d5277f64b4cc5a78bf185bf9d5b1abfb@epcas1p1.samsung.com>
 <CACRpkdYZFW6zdt5ig3wNDxQAaVV6OYnrG5zPfcvzixwh8VbXig@mail.gmail.com> <2384661.GfpEZ6rEzz@amdc3058>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Oct 2017 11:48:27 +0200
Message-ID: <CAPDyKFrVK2hK9LEPKRfTTMOvP6WD5ug+VTwOt9tDaiMKKUBsNA@mail.gmail.com>
Subject: Re: [PATCH V9 13/15] mmc: block: Add CQE and blk-mq support
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
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

[...]

>> MQ code that doesn't perform and therefore we cannot switch seamlessly
>> to MQ.
>
> I think that switching seamlessly to blk-mq in short/medium-term
> is not possible (SCSI tried and failed to do so). The changes to
> the old path are very complex and besides affecting performance
> they also affect error recovery handling (which needs to be tested
> properly before the switch).

Agreed, and that's why I have queued up the new Kconfig option for
enabling the blkmq path from MMC.

Kind regards
Uffe
