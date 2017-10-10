Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:53917 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755866AbdJJMMB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Oct 2017 08:12:01 -0400
Received: by mail-it0-f47.google.com with SMTP id n195so2204086itg.2
        for <linux-block@vger.kernel.org>; Tue, 10 Oct 2017 05:12:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2cd4c5fc-cc04-ba44-bea6-4547d84de3e2@intel.com>
References: <1505302814-19313-1-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFr-XbMOmOkz1yXwmG1t=77eSsUO2kU7kKV0V1wrfcmWKg@mail.gmail.com> <2cd4c5fc-cc04-ba44-bea6-4547d84de3e2@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Oct 2017 14:12:00 +0200
Message-ID: <CAPDyKFqE7UYOYrjykpV0GnQ+hg2oGXpALgn_8yKsQk19Y4nmSQ@mail.gmail.com>
Subject: Re: [PATCH V8 00/14] mmc: Add Command Queue support
To: Adrian Hunter <adrian.hunter@intel.com>
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
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 21 September 2017 at 11:44, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 21/09/17 12:01, Ulf Hansson wrote:
>> On 13 September 2017 at 13:40, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> Hi
>>>
>>> Here is V8 of the hardware command queue patches without the software
>>> command queue patches, now using blk-mq and now with blk-mq support for
>>> non-CQE I/O.
>>>
>>> After the unacceptable debacle of the last release cycle, I expect an
>>> immediate response to these patches.
>>>
>>> HW CMDQ offers 25% - 50% better random multi-threaded I/O.  I see a slight
>>> 2% drop in sequential read speed but no change to sequential write.
>>>
>>> Non-CQE blk-mq showed a 3% decrease in sequential read performance.  This
>>> seemed to be coming from the inferior latency of running work items compared
>>> with a dedicated thread.  Hacking blk-mq workqueue to be unbound reduced the
>>> performance degradation from 3% to 1%.
>>>
>>> While we should look at changing blk-mq to give better workqueue performance,
>>> a bigger gain is likely to be made by adding a new host API to enable the
>>> next already-prepared request to be issued directly from within ->done()
>>> callback of the current request.
>>
>> Adrian, I am reviewing this series, however let me comment on each
>> change individually.
>>
>> I have also run some test on my ux500 board and enabling the blkmq
>> path via the new MMC Kconfig option. My idea was to run some iozone
>> comparisons between the legacy path and the new blkmq path, but I just
>> couldn't get to that point because of the following errors.
>>
>> I am using a Kingston 4GB SDHC card, which is detected and mounted
>> nicely. However, when I decide to do some writes to the card I get the
>> following errors.
>>
>> root@ME:/mnt/sdcard dd if=/dev/zero of=testfile bs=8192 count=5000 conv=fsync
>> [  463.714294] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>> [  464.722656] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>> [  466.081481] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>> [  467.111236] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>> [  468.669647] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>> [  469.685699] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>> [  471.043334] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>> [  472.052337] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>> [  473.342651] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>> [  474.323760] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>> [  475.544769] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>> [  476.539031] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>> [  477.748474] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>> [  478.724182] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>>
>> I haven't yet got the point of investigating this any further, and
>> unfortunate I have a busy schedule with traveling next week. I will do
>> my best to look into this as soon as I can.
>>
>> Perhaps you have some ideas?
>
> The behaviour depends on whether you have MMC_CAP_WAIT_WHILE_BUSY. Try
> changing that and see if it makes a difference.

Yes, it does! I disabled MMC_CAP_WAIT_WHILE_BUSY (and its
corresponding code in mmci.c) and the errors goes away.

When I use MMC_CAP_WAIT_WHILE_BUSY I get these problems:

[  223.820983] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
[  224.815795] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
[  226.034881] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
[  227.112884] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
[  227.220275] mmc0: Card stuck in wrong state! mmcblk0 mmc_blk_card_stuck
[  228.686798] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
[  229.892150] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
[  231.031890] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
[  232.239013] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
5000+0 records in
5000+0 records out
root@ME:/mnt/sdcard

I looked at the new blkmq code from patch v10 13/15. It seems like the
MMC_CAP_WAIT_WHILE_BUSY is used to determine whether the async request
mechanism should be used or not. Perhaps I didn't looked close enough,
but maybe you could elaborate on why this seems to be the case!?

Kind regards
Uffe
