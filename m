Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 4/6] mtip32xx: convert internal command issue to block IO
 path
To: Christoph Hellwig <hch@lst.de>
References: <1493398473-29872-1-git-send-email-axboe@fb.com>
 <1493398473-29872-5-git-send-email-axboe@fb.com>
 <20170502072810.GA11582@lst.de> <b5eae6e4-92f3-3266-5f8e-21c7ab6e69f6@fb.com>
 <a43cf987-6f97-a82d-38e7-f8880c4d63ae@kernel.dk>
 <da3549ce-74ad-07da-528c-3a8b84b275f9@kernel.dk>
 <20170502151607.GA22963@lst.de>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f2281c8c-0982-7d2f-ba35-060d9ea1bb48@kernel.dk>
Date: Tue, 2 May 2017 09:25:37 -0600
MIME-Version: 1.0
In-Reply-To: <20170502151607.GA22963@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 05/02/2017 09:16 AM, Christoph Hellwig wrote:
> This looks reasonable to me, although of course I don't have a way
> to test it.

I've got a few cards at least.

> Any reason for the move from ->end_io_data to ->special?  I thought
> that ->special was something we'd get rid of sooner or later now
> that we can have additional per-cmd data even for !mq.

With the switch to blk_execute_rq(), we can't be using end_io_data
and end_io, as we use that internally for the wakeup. So I have to
stuff it somewhere.

The obvious option would be to move it to mtip_cmd, but we can't
safely access that prior to having a driver tag assigned, which doesn't
happen until we end up in our ->queue_rq(). So we need to stuff it
somewhere.

-- 
Jens Axboe
