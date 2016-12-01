Return-Path: <riteshh@codeaurora.org>
Subject: Re: [PATCH] block: Factor out req_set_nomerge
To: Jens Axboe <axboe@kernel.dk>
References: <1480588058-29998-1-git-send-email-riteshh@codeaurora.org>
 <5db68671-c5ba-26d1-c9be-7e85cedc0b4c@kernel.dk>
Cc: linux-block@vger.kernel.org
From: Ritesh Harjani <riteshh@codeaurora.org>
Message-ID: <fb08d81d-c167-ed44-569e-f87bad20349b@codeaurora.org>
Date: Thu, 1 Dec 2016 23:45:01 +0530
MIME-Version: 1.0
In-Reply-To: <5db68671-c5ba-26d1-c9be-7e85cedc0b4c@kernel.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>



On 12/1/2016 9:08 PM, Jens Axboe wrote:
> On 12/01/2016 03:27 AM, Ritesh Harjani wrote:
>> Factor out common code for setting REQ_NOMERGE
>> flag which is being used out at certain places
>> and make it a helper instead (req_set_nomerge).
>
> I applied this, but I got rid of the inline. Let the compiler do it's
> job, if anything this should be marked out-of-line, since it's not a hot
> path.
>
> Beware that your email triggers the gmail spam filter, since it's
> failing the authenticity check. You might want to look into that.
>
Thanks for informing. I will take a look.
