Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
To: axboe@kernel.dk, jack@suse.cz, gmazyland@gmail.com
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH v2] loop: remember whether sysfs_create_group() succeeded
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <6bf461ba-4bd0-6709-1605-b0fccd0f105d@kernel.dk>
	<201805042340.AIB51569.HOFQOJLFtVFSMO@I-love.SAKURA.ne.jp>
	<a3c15779-226c-5e26-6be2-68397a8b3d04@kernel.dk>
	<201805050114.GDF05771.JVtFOQMLOSFFHO@I-love.SAKURA.ne.jp>
	<2a75e5fb-7f29-d372-b87d-a69820fb750c@kernel.dk>
In-Reply-To: <2a75e5fb-7f29-d372-b87d-a69820fb750c@kernel.dk>
Message-Id: <201805050147.BBJ81237.JtOMSFFOFQVOLH@I-love.SAKURA.ne.jp>
Date: Sat, 5 May 2018 01:47:12 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Jens Axboe wrote:
> On 5/4/18 10:14 AM, Tetsuo Handa wrote:
> >>>> If that's not easily done, then my next suggestion would be to
> >>>> use a loop flag for it, LO_FLAGS_SYSFS_SETUP or something like that.
> >>>
> >>> Yes, that would be possible.
> >>
> >> Let's make that change.
> > 
> > Since LO_FLAGS_* are defined in include/uapi/linux/loop.h as userspace visible
> > flags, I feel that using "struct loop_device"->lo_flags for recording whether
> > sysfs entry exists might be strange... Anyway, updated patch is shown below.
> 
> Hmm yes, I forgot about that, I guess that makes the flags approach
> pretty much useless. Let's just go with your v1 in that case.
> 

OK. You can s/sysfs_ready/sysfs_init_done/ before you apply to your tree.
