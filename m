Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:38364 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752560AbdKIMzu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Nov 2017 07:55:50 -0500
Subject: Re: [PATCH V13 05/10] mmc: cqhci: support for command queue enabled
 host
To: Linus Walleij <linus.walleij@linaro.org>
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
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com>
 <1509715220-31885-6-git-send-email-adrian.hunter@intel.com>
 <CACRpkdYY_a3fuayN3z5xn952t=YYJ8LA6wqXDtd=7ea03a187w@mail.gmail.com>
 <a9eb7e73-31b4-6ff6-4a0d-1416c938039b@intel.com>
 <CACRpkdZ2Xr9xKg-FD1QB_Kq=E6TpBDg-3giamAVbuykAxi=9vw@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <6d116e6e-cf99-989c-6d66-7fef10541de2@intel.com>
Date: Thu, 9 Nov 2017 14:55:34 +0200
MIME-Version: 1.0
In-Reply-To: <CACRpkdZ2Xr9xKg-FD1QB_Kq=E6TpBDg-3giamAVbuykAxi=9vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/11/17 14:26, Linus Walleij wrote:
> On Wed, Nov 8, 2017 at 3:14 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 08/11/17 11:22, Linus Walleij wrote:
>>> On Fri, Nov 3, 2017 at 2:20 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
>>> (...)
> 
>>>> +EXPORT_SYMBOL(cqhci_resume);
>>>
>>> Why would the CQE case require special suspend/resume
>>> functionality?
>>
>> Seems like a very strange question.
> 
> Please realize that patch review is partly about education.
> 
> Educating me or anyone about your patch set involves
> being humbe and not seeing your peers as lesser.
> 
> Making your reviewer feel stupid by saying the ask
> "strange" or outright stupid questions is not helping
> your cause.

Please try to forgive me for being rude, it is just frustration.

> 
>> Obviously CQHCI has to be configured
>> after suspend.
> 
> Yeah. I think I misunderstood is such that:
> 
>> Also please don't confuse CQE and CQHCI.  CQHCI is an implementation of a
>> CQE.  We currently do not expect to have another implementation, but it is
>> not impossible.
> 
> OK now you educated me, see it's not that hard without
> using belitteling language.
> 
>>> This seems two much like on the side CQE-silo engineering,
>>> just use the device .[runtime]_suspend/resume callbacks like
>>> everyone else, make it possible for the host to figure out
>>> if it is in CQE mode or not (I guess it should know already
>>> since cqhci .enable() has been called?) and handle it
>>> from there.
>>
>> That is how it works!  The host controller has to decide how to handle
>> suspend / resume.
> 
> OK.
> 
>> cqhci_suspend() / cqhci_resume() are helper functions that the host
>> controller can use, but doesn't have to.
> 
> OK.
> 
>>> Why would CQE hosts need special accessors and the rest
>>> of the host not need it?
>>
>> Special accessors can be used to fix up registers that don't work exactly
>> the way the standard specified.
> 
> Yeah this is fine as it is for CQHCI, I didn't get that
> part :)
> 
>>> ->enable and ->disable() for just CQE seem reasonable.
>>> But that leaves just two new ops.
>>>
>>> So why not just put .cqe_enable() and .cqe_disable()
>>> ops into mmc_host_ops as optional and be done with it?
>>
>> Ok so you are not understanding this at all.
> 
> No I did not get it. But I do now (I think).
> 
>> As a CQE implementation, CQHCI interfaces with the upper layers through the
>> CQE ops etc.
>>
>> But CQHCI also has to work with any host controller driver, so it needs an
>> interface for that, which is what cqhci_host_ops is for.  All the ops serve
>> useful purposes.
> (...)
>> The whole point is to prove a library that can work with any host controller
>> driver.  That means it must provide functions and callbacks.
> 
> OK
> 
>>> I think the above approach to put any CQE-specific callbacks
>>> directly into the struct mmc_host_ops is way more viable.
>>
>> Nothing to do with CQE.  This is CQHCI.  Please try to get the difference.
> 
> I am trying, please try to think about your language.

I strongly disapprove of being rude but sadly it seems to get results.
