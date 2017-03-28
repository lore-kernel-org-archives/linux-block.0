Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <f823dfb9-2acd-e9be-7132-a0b28659c316@intel.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
 <1486731352-8018-23-git-send-email-adrian.hunter@intel.com>
 <CACRpkdZkTgNEUFiG5JorBM+MiXVfp6iSnNH0-k27jYb+zjgiLw@mail.gmail.com>
 <e31765ec-3453-9c40-1710-bea881cd9dec@intel.com> <CACRpkdbjmUWw=ZPsVGGCS=6bsho=qw=OQVaE3p4AJWuccyGXag@mail.gmail.com>
 <f823dfb9-2acd-e9be-7132-a0b28659c316@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 28 Mar 2017 09:57:53 +0200
Message-ID: <CACRpkdatdkWG8L3NtZbJpv5XZEWGugRHWMo8QDYh4e_mFHjuKA@mail.gmail.com>
Subject: Re: [PATCH RFC 22/39] mmc: block: Prepare CQE data
To: Adrian Hunter <adrian.hunter@intel.com>, Paolo Valente <paolo.valente@linaro.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>,
	Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>,
	Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>,
	Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>,
	Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>,
	Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>,
	Venu Byravarasu <vbyravarasu@nvidia.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Fri, Mar 10, 2017 at 9:29 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 10/03/17 00:39, Linus Walleij wrote:
>> On Fri, Mar 3, 2017 at 1:22 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 15/02/17 15:49, Linus Walleij wrote:
>>>> On Fri, Feb 10, 2017 at 1:55 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>>> Enhance mmc_blk_data_prep() to support CQE requests.
>>>>>
>>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>>
>>>> Hey:
>>>>
>>>>> +#include <linux/ioprio.h>
>>>> (...)
>>>>> +       if (IOPRIO_PRIO_CLASS(req_get_ioprio(req)) == IOPRIO_CLASS_RT)
>>>>> +               brq->data.flags |= MMC_DATA_PRIO;
>>>>
>>>> What is this?
>>>
>>> It is the command queue priority.
>>>
>>> The command queue supports 2 priorities: "high" (1) and "simple" (0).  The
>>> eMMC will give "high" priority tasks priority over "simple" priority tasks.
>>>
>>> So here we give priority to IOPRIO_CLASS_RT which seems appropriate.
>>
>> So if I understand correctly, you are obtaining the block layer scheduling
>> priorities, that can (only?) be set by ionice has from the command line?
>
> AFAICS it is the ioprio_set() system call .

OK to be clear, correct, it is set by that system call.

And as far as I can tell there is exactly one program in the world that issues
that syscall, and that is ionice(1).

It is described to the world as a way for users to give hints to the
I/O scheduler
about how to manage requests. For example a user can hint that some IO
is a backup job and not important and some IO is a media player and really
important.

And since the block layer only handles this hint in the legacy blk CFQ scheduler
I want to know from the block layer developers if this priority has any future.
BFQ does not use this hint at all, I think Paolo described the ionice command
as problematic, and we need to understand if user-provided IO scheduling hints
is something that is going to be used in the future.

Yours,
Linus Walleij
