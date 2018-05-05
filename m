Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
To: gmazyland@gmail.com, axboe@kernel.dk, jack@suse.cz
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH] loop: remember whether sysfs_create_group() succeeded
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <3afa1009-c55e-08e2-32b9-49fde1c587c8@kernel.dk>
	<201805042327.CBF64097.OOVQFtFJFLSHOM@I-love.SAKURA.ne.jp>
	<6bf461ba-4bd0-6709-1605-b0fccd0f105d@kernel.dk>
	<201805042340.AIB51569.HOFQOJLFtVFSMO@I-love.SAKURA.ne.jp>
	<7fec4767-64c5-5b3b-4a85-6c7d97d6b0b7@gmail.com>
In-Reply-To: <7fec4767-64c5-5b3b-4a85-6c7d97d6b0b7@gmail.com>
Message-Id: <201805052049.IDD12470.OLHVOMFFOQtSFJ@I-love.SAKURA.ne.jp>
Date: Sat, 5 May 2018 20:49:26 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Milan Broz wrote:
> On 05/04/2018 04:40 PM, Tetsuo Handa wrote:
> > The loop module ignores sysfs_create_group() failure and pretends that
> > LOOP_SET_FD request succeeded. I guess that the author of commit
> > ee86273062cbb310 ("loop: add some basic read-only sysfs attributes")
> > assumed that it is not a fatal error enough to abort LOOP_SET_FD request.
> 
> IIRC we added sysfs attributes to easily access loop info for a regular user
> in lsblk command (and perhaps even in udev rules).
> 
> The ioctl interface was still controlling the loop device, so the failure
> here was not meant to be fatal. TBH I think was not a great idea.

Thanks for reply.

>  
> > Do we want to abort LOOP_SET_FD request if sysfs_create_group() failed?
> 
> I would prefer failure - there are several utilities that expects attributes in
> sysfs to be valid (for example I print info from here in cryptsetup status
> if the backing image is an image), so ignoring failure put the system
> in inconsistent state.

I see. But can we for now send v1 patch for 4.17 release (and postpone making
LOOP_SET_FD request fail if sysfs_create_group() failed)? This bug has so far
crashed syzbot tests for 6432 times in 190 days.

We have a lot of bugs regarding loop module which prevent syzbot from
finding other bugs. I want to immediately squash bugs in block/loop so that
we can reduce false-positive hung task reports.

> 
> Thanks for fixing this,
> Milan
> 
