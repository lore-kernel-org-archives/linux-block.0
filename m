Return-Path: <riteshh@codeaurora.org>
Subject: Re: [RFC PATCH] cfq: Give a chance for arming slice idle timer in
 case of group_idle
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stummala@codeaurora.org, ankijain@codeaurora.org
References: <1502283512-4379-1-git-send-email-riteshh@codeaurora.org>
 <016b90bd-8fde-7494-0a1c-3bf623b53714@codeaurora.org>
 <25fef483-9f23-0d59-908d-868d34642ee4@kernel.dk>
From: Ritesh Harjani <riteshh@codeaurora.org>
Message-ID: <3fab2871-20f6-2b96-704e-05cc24af80ce@codeaurora.org>
Date: Fri, 11 Aug 2017 21:03:56 +0530
MIME-Version: 1.0
In-Reply-To: <25fef483-9f23-0d59-908d-868d34642ee4@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>



On 8/11/2017 8:30 PM, Jens Axboe wrote:
> On 08/10/2017 11:15 PM, Ritesh Harjani wrote:
>> Hi Jens,
>>
>> Could you please take a look at below patch and the issue it is trying
>> to solve. Please let us know your thoughts on the below problem and the
>> patch.
> 
> It looks reasonable to me. I'll queue it up for 4.14.
> 

Thanks.

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, 
Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project.
