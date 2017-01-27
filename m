Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35978 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754189AbdA0H6S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2017 02:58:18 -0500
Received: by mail-wm0-f46.google.com with SMTP id c85so105102395wmi.1
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2017 23:58:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrB9UfkfGD08fTKegSB2W65pdWuDU=10mGukQmB=yhaqQ@mail.gmail.com>
References: <20170124101757.19676-1-linus.walleij@linaro.org> <CAPDyKFrB9UfkfGD08fTKegSB2W65pdWuDU=10mGukQmB=yhaqQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 27 Jan 2017 08:58:16 +0100
Message-ID: <CAPDyKFq6wzw=_6oc=hyW3B_tBAGfqzrixoy-gr=ki=M2wyhiNg@mail.gmail.com>
Subject: Re: [PATCH 0/6] mmc: block: command issue cleanups
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

+Maxime

On 26 January 2017 at 09:07, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 24 January 2017 at 11:17, Linus Walleij <linus.walleij@linaro.org> wrote:
>> The function mmc_blk_issue_rw_rq() is hopelessly convoluted and
>> need to be refactored to it can be understood by humans.
>>
>> In the process I found some weird magic return values passed
>> around for no good reason.
>>
>> Things are more readable after this.
>>
>> This work is done towards the goal of breaking the function in
>> two parts: one just submitting the requests and one checking the
>> result and possibly resubmitting the command on error, so we
>> can make the usual path (non-errorpath) smooth and quick, and
>> be called directly when the driver completes a request.
>>
>> That in turn is a prerequisite for proper blk-mq integration
>> with the MMC/SD stack.
>>
>> All that comes later.
>>
>> Linus Walleij (6):
>>   mmc: block: break out mmc_blk_rw_cmd_abort()
>>   mmc: block: break out mmc_blk_rw_start_new()
>>   mmc: block: do not assign mq_rq when aborting command
>>   mmc: block: inline command abortions
>>   mmc: block: introduce new_areq and old_areq
>>   mmc: block: stop passing around pointless return values
>>
>>  drivers/mmc/core/block.c | 108 ++++++++++++++++++++++++++---------------------
>>  drivers/mmc/core/block.h |   2 +-
>>  2 files changed, 60 insertions(+), 50 deletions(-)
>>
>> --
>> 2.9.3
>>
>
> Thanks, applied for next!

Linus,

Seems like this series may have issues. I have looked at boot reports
from kernelci, and particular the reports for
https://kernelci.org/boot/sun7i-a20-bananapi/job/ulfh/ are
interesting.

Apparently, this board has an SD card attached. There have been errors
reported in the log for a while when doing data transfers, although
none of these errors have triggered the kernelci to report a boot
error.

However, I suspect that some of the changes in this series make it
worse. Perhaps because of a changed error handling the mmc block
layer!?

Particular, look at the difference between these [1] boot logs, it
might give you some hints. I have also added Maxime to this thread,
perhaps he can help out with the sunxi mmc driver.

Kind regards
Uffe

[1]
Successful boot - sun7i-a20-bananapi:
https://storage.kernelci.org/ulfh/v4.10-rc5-86-g2ed14a2aac8a/arm-sunxi_defconfig/lab-baylibre-seattle/boot-sun7i-a20-bananapi.txt

Failing boot - sun7i-a20-bananapi:
https://storage.kernelci.org/ulfh/v4.10-rc5-97-ge1defa2da4d3/arm-sunxi_defconfig/lab-baylibre-seattle/boot-sun7i-a20-bananapi.txt

Kind regards
Uffe
