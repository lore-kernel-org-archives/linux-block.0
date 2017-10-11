Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:45079 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752029AbdJKNYi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Oct 2017 09:24:38 -0400
Received: by mail-it0-f47.google.com with SMTP id n195so2978060itg.0
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2017 06:24:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqsVOLCsCWqNOJHED6nYfu+NXv8bHG17Kxktsc6M2_iYg@mail.gmail.com>
References: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com> <CAPDyKFqsVOLCsCWqNOJHED6nYfu+NXv8bHG17Kxktsc6M2_iYg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 11 Oct 2017 15:24:37 +0200
Message-ID: <CAPDyKFpto2WvmLfqtYUKstVVsKtM0H8cqSJd9jeq=C69OemDew@mail.gmail.com>
Subject: Re: [PATCH V9 00/15] mmc: Add Command Queue support
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

On 27 September 2017 at 00:25, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 22 September 2017 at 14:36, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> Hi
>>
>> Here is V9 of the hardware command queue patches without the software
>> command queue patches, now using blk-mq and now with blk-mq support for
>> non-CQE I/O.
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
> I have looked at patch 1->8, and those looks nice to me so I have
> applied those for next. I will do my best to review the rest asap,
> however I am currently traveling so in worst case it will have wait
> until next week.

Adrian, I decided to drop patch6, the one which adds the Kconfig
option for blkmq for now. Please re-post it when you get to the point
of sending a version of the series.

Kind regards
Uffe
