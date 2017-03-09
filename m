Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <e31765ec-3453-9c40-1710-bea881cd9dec@intel.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
 <1486731352-8018-23-git-send-email-adrian.hunter@intel.com>
 <CACRpkdZkTgNEUFiG5JorBM+MiXVfp6iSnNH0-k27jYb+zjgiLw@mail.gmail.com> <e31765ec-3453-9c40-1710-bea881cd9dec@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 9 Mar 2017 23:39:51 +0100
Message-ID: <CACRpkdbjmUWw=ZPsVGGCS=6bsho=qw=OQVaE3p4AJWuccyGXag@mail.gmail.com>
Subject: Re: [PATCH RFC 22/39] mmc: block: Prepare CQE data
To: Adrian Hunter <adrian.hunter@intel.com>, linux-block@vger.kernel.org,
	Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>,
	Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>,
	Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>,
	Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>,
	Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>,
	David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>,
	Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Fri, Mar 3, 2017 at 1:22 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 15/02/17 15:49, Linus Walleij wrote:
>> On Fri, Feb 10, 2017 at 1:55 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>>> Enhance mmc_blk_data_prep() to support CQE requests.
>>>
>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>
>> Hey:
>>
>>> +#include <linux/ioprio.h>
>> (...)
>>> +       if (IOPRIO_PRIO_CLASS(req_get_ioprio(req)) == IOPRIO_CLASS_RT)
>>> +               brq->data.flags |= MMC_DATA_PRIO;
>>
>> What is this?
>
> It is the command queue priority.
>
> The command queue supports 2 priorities: "high" (1) and "simple" (0).  The
> eMMC will give "high" priority tasks priority over "simple" priority tasks.
>
> So here we give priority to IOPRIO_CLASS_RT which seems appropriate.

So if I understand correctly, you are obtaining the block layer scheduling
priorities, that can (only?) be set by ionice has from the command line?

We need to discuss this with the block maintainers.

I'm not so sure about the future of this. The IOPRIO is only used with the CFQ
scheduler, only two other sites in the kernel use this and MQ and its schedulers
surely does not have ionice handling as far as I know.

The BFQ does not use it, AFAIK it is using different heuristics to prioritize
block traffic, and that does not include using ionice hints.

Is ionice:ing something we're really going to do going forward?
Should this be repurposed so that the block scheduler use this prio to
communicate to the driver layer to prioritize certain traffic?

Yours,
Linus Walleij
