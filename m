Return-Path: <david@fromorbit.com>
Date: Thu, 10 Nov 2016 11:00:27 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	hch@lst.de
Subject: Re: [PATCH 7/8] blk-wbt: add general throttling mechanism
Message-ID: <20161110000027.GV28177@dastard>
References: <1478034531-28559-1-git-send-email-axboe@fb.com>
 <1478034531-28559-8-git-send-email-axboe@fb.com>
 <20161108133930.GQ32353@quack2.suse.cz>
 <20161108154109.GA2834@kernel.dk>
 <20161109084034.GY32353@quack2.suse.cz>
 <85a891d5-0eec-a051-702f-9aac13e13b03@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <85a891d5-0eec-a051-702f-9aac13e13b03@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Nov 09, 2016 at 09:07:08AM -0700, Jens Axboe wrote:
> On 11/09/2016 01:40 AM, Jan Kara wrote:
> >Also I'm not sure why such logic for devices with writeback cache is
> >needed. Sure the disk is fast to accept writes but if that causes long
> >read latencies, we should scale down the writeback limits so that we
> >eventually end up submitting only one write request anyway -
> >effectively the same thing as limit=0 - won't we?
> 
> Basically we want to avoid getting into that situation. The problem with
> write caching is that it takes a while for you to notice that anything
> is wrong, and when you do, you are way down in the hole. That causes the
> first violations to be pretty bad.

Yeah, slow RAID devices with a large BBWC in front of them are
notorious for doing this. You won't notice the actual IO performance
until the write cache is filled (can be GB in size) and by then it's
way too late to fix up with OS level queuing...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
