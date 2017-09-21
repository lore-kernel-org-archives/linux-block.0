Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:63935 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751804AbdIULYJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 07:24:09 -0400
Subject: Re: [PATCH V8 12/14] mmc: block: Add CQE and blk-mq support
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
 <1505302814-19313-13-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFrJSsF-QLBe13c6huOvJngirm5D1m=JJSkbX2n9ruoFQg@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <013d1177-7c6e-4d32-bacb-5912d9e66753@intel.com>
Date: Thu, 21 Sep 2017 14:17:24 +0300
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrJSsF-QLBe13c6huOvJngirm5D1m=JJSkbX2n9ruoFQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 21/09/17 12:59, Ulf Hansson wrote:
> On 13 September 2017 at 13:40, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> Add CQE support to the block driver, including:
>>     - optionally using DCMD for flush requests
>>     - "manually" issuing discard requests
>>     - issuing read / write requests to the CQE
>>     - supporting block-layer timeouts
>>     - handling recovery
>>     - supporting re-tuning
>>
>> CQE offers 25% - 50% better random multi-threaded I/O.  There is a slight
>> (e.g. 2%) drop in sequential read speed but no observable change to sequential
>> write.
>>
>> CQE automatically sends the commands to complete requests.  However it only
>> supports reads / writes and so-called "direct commands" (DCMD).  Furthermore
>> DCMD is limited to one command at a time, but discards require 3 commands.
>> That makes issuing discards through CQE very awkward, but some CQE's don't
>> support DCMD anyway.  So for discards, the existing non-CQE approach is
>> taken, where the mmc core code issues the 3 commands one at a time i.e.
>> mmc_erase(). Where DCMD is used, is for issuing flushes.
>>
>> For host controllers without CQE support, blk-mq support is extended to
>> synchronous reads/writes or, if the host supports CAP_WAIT_WHILE_BUSY,
>> asynchonous reads/writes.  The advantage of asynchronous reads/writes is
>> that it allows the preparation of the next request while the current
>> request is in progress.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  drivers/mmc/core/block.c | 734 ++++++++++++++++++++++++++++++++++++++++++++++-
>>  drivers/mmc/core/block.h |   8 +
>>  drivers/mmc/core/queue.c | 428 +++++++++++++++++++++++++--
>>  drivers/mmc/core/queue.h |  54 +++-
>>  4 files changed, 1192 insertions(+), 32 deletions(-)
> 
> Adrian, this is just too hard for me to review. Please, can you split this up?
> 
> At least enabling mq support should be done in a separate and first
> step, then you could add the CQE bits on top.
> 
> I think that is important, because we want to make sure the mq
> deployment is done correctly first. Otherwise it becomes impossible to
> narrow down problems, because those could then be either CQE related
> or mq related.

I looked at splitting it up, but it makes more sense together.  Things are
the way they are to support all the different issue types.  It reads much
better together.  The CQE functions are named appropriately and practically
all the code is new, so it is not as though there are any intermediate steps.
