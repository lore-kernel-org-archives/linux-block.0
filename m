Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14670 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752117AbdJKNG0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Oct 2017 09:06:26 -0400
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
 <2cd4c5fc-cc04-ba44-bea6-4547d84de3e2@intel.com>
 <CAPDyKFqE7UYOYrjykpV0GnQ+hg2oGXpALgn_8yKsQk19Y4nmSQ@mail.gmail.com>
 <9a789f9b-a8c4-8ae7-8f93-0d76f674bded@intel.com>
 <CAPDyKFoLa_aX3j693_tfkuaSKNvGB-ERdf2-9r4iF-+c0NnP9g@mail.gmail.com>
 <d41eee41-796a-db93-d388-b36123ecc364@intel.com>
 <CAPDyKFrMqXWagkPOtPk-PBThSUrSogUP=iL+9XeyD9E8qkp=bw@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <1b8bec1b-7340-cb89-65c0-e09b17037ca4@intel.com>
Date: Wed, 11 Oct 2017 15:58:44 +0300
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrMqXWagkPOtPk-PBThSUrSogUP=iL+9XeyD9E8qkp=bw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 11/10/17 15:13, Ulf Hansson wrote:
> On 10 October 2017 at 15:31, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 10/10/17 16:08, Ulf Hansson wrote:
>>> [...]
>>>
>>>>>>>
>>>>>>> I have also run some test on my ux500 board and enabling the blkmq
>>>>>>> path via the new MMC Kconfig option. My idea was to run some iozone
>>>>>>> comparisons between the legacy path and the new blkmq path, but I just
>>>>>>> couldn't get to that point because of the following errors.
>>>>>>>
>>>>>>> I am using a Kingston 4GB SDHC card, which is detected and mounted
>>>>>>> nicely. However, when I decide to do some writes to the card I get the
>>>>>>> following errors.
>>>>>>>
>>>>>>> root@ME:/mnt/sdcard dd if=/dev/zero of=testfile bs=8192 count=5000 conv=fsync
>>>>>>> [  463.714294] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>>>>>>> [  464.722656] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>>>>>>> [  466.081481] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>>>>>>> [  467.111236] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>>>>>>> [  468.669647] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>>>>>>> [  469.685699] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>>>>>>> [  471.043334] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>>>>>>> [  472.052337] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>>>>>>> [  473.342651] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>>>>>>> [  474.323760] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>>>>>>> [  475.544769] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>>>>>>> [  476.539031] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>>>>>>> [  477.748474] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>>>>>>> [  478.724182] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>>>>>>>
>>>>>>> I haven't yet got the point of investigating this any further, and
>>>>>>> unfortunate I have a busy schedule with traveling next week. I will do
>>>>>>> my best to look into this as soon as I can.
>>>>>>>
>>>>>>> Perhaps you have some ideas?
>>>>>>
>>>>>> The behaviour depends on whether you have MMC_CAP_WAIT_WHILE_BUSY. Try
>>>>>> changing that and see if it makes a difference.
>>>>>
>>>>> Yes, it does! I disabled MMC_CAP_WAIT_WHILE_BUSY (and its
>>>>> corresponding code in mmci.c) and the errors goes away.
>>>>>
>>>>> When I use MMC_CAP_WAIT_WHILE_BUSY I get these problems:
>>>>>
>>>>> [  223.820983] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>>>>> [  224.815795] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>>>>> [  226.034881] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>>>>> [  227.112884] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>>>>> [  227.220275] mmc0: Card stuck in wrong state! mmcblk0 mmc_blk_card_stuck
>>>>> [  228.686798] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>>>>> [  229.892150] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>>>>> [  231.031890] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>>>>> [  232.239013] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
>>>>> 5000+0 records in
>>>>> 5000+0 records out
>>>>> root@ME:/mnt/sdcard
>>>>>
>>>>> I looked at the new blkmq code from patch v10 13/15. It seems like the
>>>>> MMC_CAP_WAIT_WHILE_BUSY is used to determine whether the async request
>>>>> mechanism should be used or not. Perhaps I didn't looked close enough,
>>>>> but maybe you could elaborate on why this seems to be the case!?
>>>>
>>>> MMC_CAP_WAIT_WHILE_BUSY is necessary because it means that a data transfer
>>>> request has finished when the host controller calls mmc_request_done(). i.e.
>>>> polling the card is not necessary.
>>>
>>> Well, that is a rather big change on its own. Earlier we polled with
>>> CMD13 to verify that the card has moved back to the transfer state, in
>>> case it was a write. And that was no matter of MMC_CAP_WAIT_WHILE_BUSY
>>> was set or not. Right!?
>>
>> Yes
>>
>>>
>>> I am not sure it's a good idea to bypass that validation, it seems
>>> fragile to rely only on the busy detection on DAT line for writes.
>>
>> Can you cite something from the specifications that backs that up, because I
>> couldn't find anything to suggest that CMD13 polling was expected.
> 
> No I can't, but I don't see why that matters.
> 
> My point is, if we want to go down that road by avoiding the CMD13
> polling, that needs to be a separate change, which we can test and
> confirm on its own.
> 
>>
>>>
>>>>
>>>> Have you tried V9 or V10.  There was a fix in V9 related to calling
>>>> ->post_req() which could mess up DMA.
>>>
>>> I have used V10.
>>>
>>>>
>>>> The other thing that could go wrong with DMA is if it cannot accept
>>>> ->post_req() being called from mmc_request_done().
>>>
>>> I don't think mmci has a problem with that, however why do you want to
>>> do this? Wouldn't that defeat some of the benefits with the async
>>> request mechanism?
>>
>> Perhaps - but it would need to be tested.  If there are more requests
>> waiting, one optimization could be to defer ->post_req() until after the
>> next request is started.
> 
> This is already proven, because this how the existing mmc async
> request mechanism works.
> 
> In ->post_req() callbacks, host drivers may do dma_unmap_sg(), which
> is something that could be costly and therefore it's better to start a
> new request before, such these things can go on in parallel.

OK I will make a patch that takes care of both issues.  That will also mean
the request is not completed in the ->done() callback because ->post_req()
must precede block layer completion.
