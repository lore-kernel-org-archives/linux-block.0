Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 07/15] bcache: Populate writeback_rate_minimum attribute
To: Coly Li <colyli@suse.de>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
 Ben Peddell <klightspeed@killerwolves.net>
References: <20181008124121.20192-1-colyli@suse.de>
 <20181008124121.20192-8-colyli@suse.de>
 <7ff3b94a-d9cb-ccc2-0ca5-4bd59f7ec1b1@kernel.dk>
 <d467304a-7e3d-d026-92ee-58b3c309d58a@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <18549996-09d8-8ba3-d10a-fd4454e72eb3@kernel.dk>
Date: Mon, 8 Oct 2018 09:22:40 -0600
MIME-Version: 1.0
In-Reply-To: <d467304a-7e3d-d026-92ee-58b3c309d58a@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/8/18 9:02 AM, Coly Li wrote:
> On 2018/10/8 下午10:19, Jens Axboe wrote:
>> On 10/8/18 6:41 AM, Coly Li wrote:
>>> From: Ben Peddell <klightspeed@killerwolves.net>
>>>
>>> Forgot to include the maintainers with my first email.
>>>
>>> Somewhere between Michael Lyle's original
>>> "bcache: PI controller for writeback rate V2" patch dated 07 Sep 2017
>>> and 1d316e6 bcache: implement PI controller for writeback rate,
>>> the mapping of the writeback_rate_minimum attribute was dropped.
>>>
>>> Re-add the missing sysfs writeback_rate_minimum attribute mapping to
>>> "allow the user to specify a minimum rate at which dirty blocks are
>>> retired."
>>>
>>> Fixes: 1d316e6 bcache: implement PI controller for writeback rate
>>
>> Remember to use the correct format for the Fixes line.
>>
> 
> Hi Jens,
> 
> This is my fault, it slips from my eyes. I'd like to resend a fixed up
> version to you.

I fixed it up when I applied it.

> BTW, now I only use checkpatches.pl to check patch format, do you use
> extra scripts as format checking hooks ?

I don't use checkpatch, I just use my eye balls :-)

-- 
Jens Axboe
