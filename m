Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:42463 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbcG2KzZ (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Fri, 29 Jul 2016 06:55:25 -0400
Subject: Re: [PATCH] nbd: fix race in ioctl
To: Markus Pargmann <mpa@pengutronix.de>
References: <1464346775-370-1-git-send-email-vegard.nossum@oracle.com>
 <22193884.IvLroPXQMD@adelgunde>
Cc: Jens Axboe <axboe@fb.com>,
	Quentin Casasnovas <quentin.casasnovas@oracle.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Clements <paul.clements@steeleye.com>,
	Pavel Machek <pavel@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>
From: Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <579B3605.4010900@oracle.com>
Date: Fri, 29 Jul 2016 12:55:01 +0200
MIME-Version: 1.0
In-Reply-To: <22193884.IvLroPXQMD@adelgunde>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/30/2016 02:58 PM, Markus Pargmann wrote:
> Hi,
>
> On Friday 27 May 2016 12:59:35 Vegard Nossum wrote:
>> Quentin ran into this bug:
>>
>> WARNING: CPU: 64 PID: 10085 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x65/0x80

[...]

>> It seems fairly obvious that device_create_file() is not being protected
>> from being run concurrently on the same nbd.
>>
>> Quentin found the following relevant commits:
>>
>> 1a2ad21 nbd: add locking to nbd_ioctl
>> 90b8f28 [PATCH] end of methods switch: remove the old ones
>> d4430d6 [PATCH] beginning of methods conversion
>> 08f8585 [PATCH] move block_device_operations to blkdev.h
>>
>> It would seem that the race was introduced in the process of moving nbd
>> from BKL to unlocked ioctls.
>>
>> By setting nbd->task_recv while the mutex is held, we can prevent other
>> processes from running concurrently (since nbd->task_recv is also checked
>> while the mutex is held).
>>
>> Reported-and-tested-by: Quentin Casasnovas <quentin.casasnovas@oracle.com>
>> Cc: Markus Pargmann <mpa@pengutronix.de>
>> Cc: Paul Clements <paul.clements@steeleye.com>
>> Cc: Pavel Machek <pavel@suse.cz>
>> Cc: Jens Axboe <axboe@fb.com>
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
>
> Thanks, applied.
>
> Best Regards,
>
> Markus

Hi,

I didn't see this patch in the batch that went into 4.8, so I'm just
following up to make sure it doesn't get lost.

Moreover, it should also probably go into stable.


Vegard
