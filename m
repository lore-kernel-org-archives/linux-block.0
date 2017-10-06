Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34252 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751800AbdJFIKM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 6 Oct 2017 04:10:12 -0400
Subject: Re: [PATCH V9 13/15] mmc: block: Add CQE and blk-mq support
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
References: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com>
 <1506083824-4024-14-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFoJxZ_t8cj1zL=-4wk5KhxrktjCP63MLZ38+_6UfYUzAw@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <6a1d5a05-16be-4bd6-6b91-0c4697202c8d@intel.com>
Date: Fri, 6 Oct 2017 11:03:23 +0300
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoJxZ_t8cj1zL=-4wk5KhxrktjCP63MLZ38+_6UfYUzAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/10/17 11:32, Ulf Hansson wrote:
> On 22 September 2017 at 14:37, Adrian Hunter <adrian.hunter@intel.com> wrote:
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
>>  drivers/mmc/core/block.c | 732 ++++++++++++++++++++++++++++++++++++++++++++++-
>>  drivers/mmc/core/block.h |   8 +
>>  drivers/mmc/core/queue.c | 427 +++++++++++++++++++++++++--
>>  drivers/mmc/core/queue.h |  54 +++-
>>  4 files changed, 1189 insertions(+), 32 deletions(-)
> 
> I have re-started to review this change now, however as stated earlier
> - the total number changes really doesn't make this easy to review.
> 
> Until I am done, I have published a new cmdq_v9 branch via my mmc tree.

Have you done any more testing?
