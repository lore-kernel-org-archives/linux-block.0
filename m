Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] loop: remember whether sysfs_create_group() succeeded
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, jack@suse.cz
Cc: linux-block@vger.kernel.org
References: <001a113ed2fa7bedfe055c8316a5@google.com>
 <94eb2c030882b2b1b505610813df@google.com>
 <55ff5960-eaab-5a36-5605-4e2230b77607@I-love.SAKURA.ne.jp>
 <20180502142434.GA10928@kroah.com>
 <201805042047.EFJ26068.OtOJFSLFFQOVHM@I-love.SAKURA.ne.jp>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3afa1009-c55e-08e2-32b9-49fde1c587c8@kernel.dk>
Date: Fri, 4 May 2018 08:15:58 -0600
MIME-Version: 1.0
In-Reply-To: <201805042047.EFJ26068.OtOJFSLFFQOVHM@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/4/18 5:47 AM, Tetsuo Handa wrote:
>>>From 626d33de1b70b11ecaf95a9f83f7644998e54cbb Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Wed, 2 May 2018 23:03:48 +0900
> Subject: [PATCH] loop: remember whether sysfs_create_group() succeeded
> 
> syzbot is hitting WARN() triggered by memory allocation fault
> injection [1] because loop module is calling sysfs_remove_group()
> when sysfs_create_group() failed.
> Fix this by remembering whether sysfs_create_group() succeeded.

Can we store this locally instead of in the loop_device? Also,
naming wise, something like sysfs_init_done would be more readily
understandable.

-- 
Jens Axboe
