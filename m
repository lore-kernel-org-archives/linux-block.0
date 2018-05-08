Return-Path: <gmazyland@gmail.com>
Return-Path: <gmazyland@gmail.com>
Subject: Re: [PATCH] loop: remember whether sysfs_create_group() succeeded
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, axboe@kernel.dk,
 jack@suse.cz
Cc: linux-block@vger.kernel.org
References: <3afa1009-c55e-08e2-32b9-49fde1c587c8@kernel.dk>
 <201805042327.CBF64097.OOVQFtFJFLSHOM@I-love.SAKURA.ne.jp>
 <6bf461ba-4bd0-6709-1605-b0fccd0f105d@kernel.dk>
 <201805042340.AIB51569.HOFQOJLFtVFSMO@I-love.SAKURA.ne.jp>
 <7fec4767-64c5-5b3b-4a85-6c7d97d6b0b7@gmail.com>
 <201805052049.IDD12470.OLHVOMFFOQtSFJ@I-love.SAKURA.ne.jp>
From: Milan Broz <gmazyland@gmail.com>
Message-ID: <fa79ae8f-b135-eaf2-0dfd-03a14e205a7a@gmail.com>
Date: Tue, 8 May 2018 11:02:43 +0200
MIME-Version: 1.0
In-Reply-To: <201805052049.IDD12470.OLHVOMFFOQtSFJ@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/05/2018 01:49 PM, Tetsuo Handa wrote:
> Milan Broz wrote:
>>> Do we want to abort LOOP_SET_FD request if sysfs_create_group() failed?
>>
>> I would prefer failure - there are several utilities that expects attributes in
>> sysfs to be valid (for example I print info from here in cryptsetup status
>> if the backing image is an image), so ignoring failure put the system
>> in inconsistent state.
> 
> I see. But can we for now send v1 patch for 4.17 release (and postpone making
> LOOP_SET_FD request fail if sysfs_create_group() failed)? This bug has so far
> crashed syzbot tests for 6432 times in 190 days.

Jens already merged it in the block git. So syzbot should be more happy now :)
> We have a lot of bugs regarding loop module which prevent syzbot from
> finding other bugs. I want to immediately squash bugs in block/loop so that
> we can reduce false-positive hung task reports.

Sure, syzbot is definitely very useful idea, thanks!

Milan
