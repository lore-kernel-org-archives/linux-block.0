Return-Path: <gmazyland@gmail.com>
Return-Path: <gmazyland@gmail.com>
Subject: Re: [PATCH] loop: remember whether sysfs_create_group() succeeded
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, axboe@kernel.dk,
 jack@suse.cz
Cc: linux-block@vger.kernel.org
References: <20180502142434.GA10928@kroah.com>
 <201805042047.EFJ26068.OtOJFSLFFQOVHM@I-love.SAKURA.ne.jp>
 <3afa1009-c55e-08e2-32b9-49fde1c587c8@kernel.dk>
 <201805042327.CBF64097.OOVQFtFJFLSHOM@I-love.SAKURA.ne.jp>
 <6bf461ba-4bd0-6709-1605-b0fccd0f105d@kernel.dk>
 <201805042340.AIB51569.HOFQOJLFtVFSMO@I-love.SAKURA.ne.jp>
From: Milan Broz <gmazyland@gmail.com>
Message-ID: <7fec4767-64c5-5b3b-4a85-6c7d97d6b0b7@gmail.com>
Date: Sat, 5 May 2018 12:46:15 +0200
MIME-Version: 1.0
In-Reply-To: <201805042340.AIB51569.HOFQOJLFtVFSMO@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/04/2018 04:40 PM, Tetsuo Handa wrote:
> The loop module ignores sysfs_create_group() failure and pretends that
> LOOP_SET_FD request succeeded. I guess that the author of commit
> ee86273062cbb310 ("loop: add some basic read-only sysfs attributes")
> assumed that it is not a fatal error enough to abort LOOP_SET_FD request.

IIRC we added sysfs attributes to easily access loop info for a regular user
in lsblk command (and perhaps even in udev rules).

The ioctl interface was still controlling the loop device, so the failure
here was not meant to be fatal. TBH I think was not a great idea.
 
> Do we want to abort LOOP_SET_FD request if sysfs_create_group() failed?

I would prefer failure - there are several utilities that expects attributes in
sysfs to be valid (for example I print info from here in cryptsetup status
if the backing image is an image), so ignoring failure put the system
in inconsistent state.

Thanks for fixing this,
Milan
