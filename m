Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 11 Apr 2018 07:20:19 -0700
From: Tejun Heo <tj@kernel.org>
To: Alexandru Moise <00moses.alexander00@gmail.com>
Cc: axboe@kernel.dk, shli@fb.com, nborisov@suse.com, arnd@arndb.de,
	gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Message-ID: <20180411142019.GG793541@devbig577.frc2.facebook.com>
References: <20180407102148.GA9729@gmail.com>
 <20180409220938.GI3126663@devbig577.frc2.facebook.com>
 <20180411101242.GA2322@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180411101242.GA2322@gmail.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Wed, Apr 11, 2018 at 12:12:56PM +0200, Alexandru Moise wrote:
> > But we already do this through calling blkcg_exit_queue() from
> > __blk_release_queue().  What's missing?
> 
> Hi,
> 
> It might be the jetlag but I can't see how you end up calling
> blkcg_exit_queue() from __blk_release_queue().
> 
> As I see it the only way to reach blkcg_exit_queue() is from
> blk_cleanup_queue(), which I don't see anywhere in __blk_release_queue().
> 
> I suspect that I'm just fixing a corner case though and
> the general case is what you describe or similar.

Ah, that changed recently.  Can you please check out the current
upstream git master?

Thanks.

-- 
tejun
