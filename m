Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 11 Apr 2018 07:51:23 -0700
From: Tejun Heo <tj@kernel.org>
To: Alexandru Moise <00moses.alexander00@gmail.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Bart Van Assche <bart.vanassche@wdc.com>
Cc: axboe@kernel.dk, shli@fb.com, nborisov@suse.com, arnd@arndb.de,
	gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Message-ID: <20180411145123.GJ793541@devbig577.frc2.facebook.com>
References: <20180407102148.GA9729@gmail.com>
 <20180409220938.GI3126663@devbig577.frc2.facebook.com>
 <20180411101242.GA2322@gmail.com>
 <20180411142019.GG793541@devbig577.frc2.facebook.com>
 <20180411142859.GB2322@gmail.com>
 <20180411144616.GI793541@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180411144616.GI793541@devbig577.frc2.facebook.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

(cc'ing Bart)

On Wed, Apr 11, 2018 at 07:46:16AM -0700, Tejun Heo wrote:
> Hello,
> 
> On Wed, Apr 11, 2018 at 04:28:59PM +0200, Alexandru Moise wrote:
> > > Ah, that changed recently.  Can you please check out the current
> > > upstream git master?
> > > 
> > Just did, without my patch I see this crash:
> 
> lol I was looking at the old tree, so this is the fix for the new
> breakage introduced by the recent change.  Sorry about the confusion.
> Joseph, can you please take a look?

Oh, it wasn't Joseph's change.  It was Bart's fix for a problem
reported by Joseph.  Bart, a063057d7c73 ("block: Fix a race between
request queue removal and the block cgroup controller") created a
regression where a request_queue can be destroyed with blkgs still
attached.  The original report is..

 http://lkml.kernel.org/r/20180407102148.GA9729@gmail.com

Thanks.

-- 
tejun
