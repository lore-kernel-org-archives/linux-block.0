Subject: Re: [PATCH 4/6] mtip32xx: convert internal command issue to block IO
 path
To: Christoph Hellwig <hch@lst.de>
References: <1493398473-29872-1-git-send-email-axboe@fb.com>
 <1493398473-29872-5-git-send-email-axboe@fb.com>
 <20170502072810.GA11582@lst.de>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <b5eae6e4-92f3-3266-5f8e-21c7ab6e69f6@fb.com>
Date: Tue, 2 May 2017 07:53:38 -0600
MIME-Version: 1.0
In-Reply-To: <20170502072810.GA11582@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 05/02/2017 01:28 AM, Christoph Hellwig wrote:
> Looks fine for now:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> But rather sooner than later we need to make this path at least go
> through the normal end_request processing.  Without that we're just
> bound to run into problems like we had with the tag changes again
> when the driver is using the block layer APIs incompletely.

I completely agree, I'll see if I can find some time to do that
soon.

-- 
Jens Axboe
