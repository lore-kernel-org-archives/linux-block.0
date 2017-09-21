Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:54982 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751569AbdIUJu7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 05:50:59 -0400
Subject: Re: [PATCH V8 00/14] mmc: Add Command Queue support
To: Ulf Hansson <ulf.hansson@linaro.org>
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
References: <1505302814-19313-1-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFr-XbMOmOkz1yXwmG1t=77eSsUO2kU7kKV0V1wrfcmWKg@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <2cd4c5fc-cc04-ba44-bea6-4547d84de3e2@intel.com>
Date: Thu, 21 Sep 2017 12:44:12 +0300
MIME-Version: 1.0
In-Reply-To: <CAPDyKFr-XbMOmOkz1yXwmG1t=77eSsUO2kU7kKV0V1wrfcmWKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 21/09/17 12:01, Ulf Hansson wrote:
> On 13 September 2017 at 13:40, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> Hi
>>
>> Here is V8 of the hardware command queue patches without the software
>> command queue patches, now using blk-mq and now with blk-mq support for
>> non-CQE I/O.
>>
>> After the unacceptable debacle of the last release cycle, I expect an
>> immediate response to these patches.
>>
>> HW CMDQ offers 25% - 50% better random multi-threaded I/O.  I see a slight
>> 2% drop in sequential read speed but no change to sequential write.
>>
>> Non-CQE blk-mq showed a 3% decrease in sequential read performance.  This
>> seemed to be coming from the inferior latency of running work items compared
>> with a dedicated thread.  Hacking blk-mq workqueue to be unbound reduced the
>> performance degradation from 3% to 1%.
>>
>> While we should look at changing blk-mq to give better workqueue performance,
>> a bigger gain is likely to be made by adding a new host API to enable the
>> next already-prepared request to be issued directly from within ->done()
>> callback of the current request.
> 
> Adrian, I am reviewing this series, however let me comment on each
> change individually.
> 
> I have also run some test on my ux500 board and enabling the blkmq
> path via the new MMC Kconfig option. My idea was to run some iozone
> comparisons between the legacy path and the new blkmq path, but I just
> couldn't get to that point because of the following errors.
> 
> I am using a Kingston 4GB SDHC card, which is detected and mounted
> nicely. However, when I decide to do some writes to the card I get the
> following errors.
> 
> root@ME:/mnt/sdcard dd if=/dev/zero of=testfile bs=8192 count=5000 conv=fsync
> [  463.714294] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
> [  464.722656] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
> [  466.081481] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
> [  467.111236] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
> [  468.669647] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
> [  469.685699] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
> [  471.043334] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
> [  472.052337] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
> [  473.342651] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
> [  474.323760] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
> [  475.544769] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
> [  476.539031] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
> [  477.748474] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
> [  478.724182] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
> 
> I haven't yet got the point of investigating this any further, and
> unfortunate I have a busy schedule with traveling next week. I will do
> my best to look into this as soon as I can.
> 
> Perhaps you have some ideas?

The behaviour depends on whether you have MMC_CAP_WAIT_WHILE_BUSY. Try
changing that and see if it makes a difference.
