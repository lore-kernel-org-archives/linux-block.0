Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:40787 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753560AbdK1TPi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Nov 2017 14:15:38 -0500
Received: by mail-it0-f66.google.com with SMTP id f190so1030643ita.5
        for <linux-block@vger.kernel.org>; Tue, 28 Nov 2017 11:15:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CACRpkdYVUj4=z9jANGjHtYGUhWqM6Hxo_Mr2rRvBSbQZMMP_RQ@mail.gmail.com>
References: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com> <CACRpkdYVUj4=z9jANGjHtYGUhWqM6Hxo_Mr2rRvBSbQZMMP_RQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 28 Nov 2017 20:15:37 +0100
Message-ID: <CAPDyKFpicjrRPi0YeJTq29BeG_H_nK2w1_=pPjESdS_SeyjU_A@mail.gmail.com>
Subject: Re: [PATCH V14 00/24] mmc: Add Command Queue support
To: Linus Walleij <linus.walleij@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: Paolo Valente <paolo.valente@linaro.org>,
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
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Linus, Adrian,

On 28 November 2017 at 10:42, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Nov 21, 2017 at 2:42 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
>> Here is V14 of the hardware command queue patches without the software
>> command queue patches, now using blk-mq and now with blk-mq support for
>> non-CQE I/O.
>>
>> V14 includes a number of fixes to existing code, changes to default to
>> blk-mq, and adds patches to remove legacy code.
>
> I have looked over the code, I was unable to find a good mergebase to apply
> it on (I guess it is based on linux-next at some date in the past) so mostly
> I just looked at it overall, and I can solidly say that this patch series:
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Great, thanks!

>
> I gave some more explicit review on some initial patches that I think
> should go in as fixes.

Thanks, and already taken care of.

>
> I do not expect it to perform any less than the previous iteration on my
> systems where it was already performing well and Bartlomiej also has
> confirmed that the patch set works for him.
>
> Ulf: I suggest this be applied (+/- some rebasing) early for v4.15.

Yes, I am up for that!

I have now also completed my review of the series and in the end, most
of my comments turned out to be of minor issues, hopefully easily
addressed.

>
> I am positively convinced that we can make things work on top of this.
>
>> HW CMDQ offers 25% - 50% better random multi-threaded I/O.  I see a slight
>> 2% drop in sequential read speed but no change to sequential write.
>
> Fully acceptable I think.
>
>> Non-CQE blk-mq showed a 3% decrease in sequential read performance.  This
>> seemed to be coming from the inferior latency of running work items compared
>> with a dedicated thread.  Hacking blk-mq workqueue to be unbound reduced the
>> performance degradation from 3% to 1%.
>
> Also acceptable I think.
>
>> While we should look at changing blk-mq to give better workqueue performance,
>> a bigger gain is likely to be made by adding a new host API to enable the
>> next already-prepared request to be issued directly from within ->done()
>> callback of the current request.

I assume that is taken care of by adding the new host cap
(MMC_CAP_DIRECT_COMPLETE).

So, then it's just a matter of adopting all host drivers, and when we
are done with that, we can remove that cap. :-)

>
> I agree.
>
> Yours,
> Linus Walleij

I am awaiting a re-based v15 version - and eager to apply it! :-)

Thanks and kind regards
Uffe
