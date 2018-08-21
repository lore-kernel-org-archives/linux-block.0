Return-Path: <jarkko.nikula@linux.intel.com>
Subject: Re: SDHCI Regression with 6ce3dd6eec11 ("blk-mq: issue directly if hw
 queue isn't busy in case of 'none'")
To: Adrian Hunter <adrian.hunter@intel.com>, linux-block@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>
References: <855d68f2-17ed-eaae-2f13-d0ff95b6834f@linux.intel.com>
 <2f4d5335-15dd-1dea-5d80-36b79455577a@intel.com>
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <fec7b30c-6cfe-b419-1e2a-d81a3ff6d9fa@linux.intel.com>
Date: Tue, 21 Aug 2018 16:45:41 +0300
MIME-Version: 1.0
In-Reply-To: <2f4d5335-15dd-1dea-5d80-36b79455577a@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 08/21/2018 04:03 PM, Adrian Hunter wrote:
> On 21/08/18 15:37, Jarkko Nikula wrote:
>> Hi
>>
>> I bisected some kind of SDHCI regression to commit 6ce3dd6eec11 ("blk-mq:
>> issue directly if hw queue isn't busy in case of 'none'") causing dumps
>> below and one or more systemd-udevd processes being in uninterruptible sleep
>> state preventing safe reboot/shutdown.
>>
>> This is from an Intel Baytrail based tablet with integrated eMMC but my
>> up-to-date Debian/testing rootfs (with systemd) is on USB stick.
>>
>> It doesn't revert cleanly on today's head 778a33959a8a but issue is gone if
>> I go to a commit before 6ce3dd6eec11 and occurs at 6ce3dd6eec11.
> 
> This was discussed here:
> 
> 	https://marc.info/?l=linux-block&m=153334717506073&w=2
> 
> Coincidentally, I just sent the fix patch:
> 
> 	https://marc.info/?l=linux-mmc&m=153485326025301&w=2
> 
Cool, it fixed my regression. I tested both on top of 6ce3dd6eec11 and 
head 778a33959a8a. Maybe you would like to add into your patch another 
fixes tag and my tested by:

Fixes: 6ce3dd6eec11 ("blk-mq: issue directly if hw queue isn't busy in 
case of 'none'")
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
