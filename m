Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:13933 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751538AbdKWLh3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Nov 2017 06:37:29 -0500
Subject: Re: [PATCH V14 07/24] mmc: block: Use data timeout in
 card_busy_detect()
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
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Christoph Hellwig <hch@lst.de>
References: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com>
 <1511271770-3444-8-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFovzm6DuNGiJq3kBpa59zRwq35xAfw5dL6Cbq7FG1wapw@mail.gmail.com>
 <be5cdd62-92ba-12f5-946f-1b29493e6dc4@intel.com>
 <CAPDyKFp14kk-81Hn3T7E6EAQrZBKgL3HvPWYKb1DO0uDETQm1Q@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <71b597f9-04fa-9cbc-6fb4-14940a59d849@intel.com>
Date: Thu, 23 Nov 2017 13:37:07 +0200
MIME-Version: 1.0
In-Reply-To: <CAPDyKFp14kk-81Hn3T7E6EAQrZBKgL3HvPWYKb1DO0uDETQm1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 22/11/17 16:43, Ulf Hansson wrote:
> On 22 November 2017 at 08:40, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 21/11/17 17:39, Ulf Hansson wrote:
>>> On 21 November 2017 at 14:42, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>> card_busy_detect() has a 10 minute timeout. However the correct timeout is
>>>> the data timeout. Change card_busy_detect() to use the data timeout.
>>>
>>> Unfortunate I don't think there is "correct" timeout for this case.
>>>
>>> The data->timeout_ns is to indicate for the host to how long the
>>> maximum time it's allowed to take between blocks that are written to
>>> the data lines.
>>>
>>> I haven't found a definition of the busy timeout, after the data write
>>> has completed. The spec only mentions that the device moves to
>>> programming state and pulls DAT0 to indicate busy.
>>
>> To me it reads more like the timeout is for each block, including the last
>> i.e. the same timeout for "busy".  Note the card is also busy between blocks.
> 
> I don't think that is the same timeout. Or maybe it is.
> 
> In the eMMC 5.1 spec, there are mentions about "buffer busy signal"
> and "programming busy signal", see section 6.15.3 (Timings - Data
> Write).
> 
> Anyway, whether any of them is specified, is to me unclear.
> 
>>
>> Equally it is the timeout we give the host controller.  So either the host
>> controller does not have a timeout for "busy" - which begs the question why
>> it has a timeout at all - or it invents its own "busy" timeout - which begs
>> the question why it isn't in the spec.
> 
> Well, there are some vague hints in section 6.8.2 (Time-out
> conditions), but I don't find these timeouts values being referred to
> in 6.15 (Timings). And that puzzles me.
> 
> Moreover, the below is quoted from section 6.6.8.1 (Block write):
> ------
> Some Devices may require long and unpredictable times to write a block
> of data. After receiving a block of data and completing the CRC check,
> the Device will begin writing and hold the DAT0 line low. The host may
> poll the status of the Device with a SEND_STATUS command (CMD13) at
> any time, and the Device will respond with its status (except in Sleep
> state). The status bit READY_FOR_DATA indicates whether the Device can
> accept new data or not. The host may deselect the Device by issuing
> CMD7 that will then displace the Device into the Disconnect State and
> release the DAT0 line without interrupting the write operation. When
> reselecting the Device, it will reactivate busy indication by pulling
> DAT0 to low. See 6.15 for details of busy indication.
> ------
> 
>>
>>>
>>> Sure, 10 min seems crazy, perhaps something along the lines of 10-20 s
>>> is more reasonable. What do you think?
>>
>> We give SD cards a generous 3 seconds for writes.  SDHCI has long had a 10
>> second software timer for the whole request, which strongly suggests that
>> requests have always completed within 10 seconds.  So that puts the range of
>> an arbitrary timeout 3-10 s.
> 
>>>From the reasoning above, I guess we could try out 10 s. That is at
> least a lot better than 10 minutes.
> 
> I also see that we have at three different places (switch, erase,
> block data transfers) implementing busy signal detection. It would be
> nice to try to align those pieces of code, because they are quite
> similar. Of course, this deserves it's own separate task to try to fix
> up.
> 
> BTW, perhaps we should move this to a separate change on top of the
> series? Or is there as specific need for this in regards to blkmq and
> CQE?

It is related to the recovery changes, so can be moved later in the patch set.
