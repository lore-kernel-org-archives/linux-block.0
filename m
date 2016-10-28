Subject: Re: clean up block ops defintions
To: Christoph Hellwig <hch@lst.de>
References: <1476969135-32732-1-git-send-email-hch@lst.de>
 <20161025120158.GA2706@lst.de>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <9bc8680d-09e6-7909-8958-008dafa82047@fb.com>
Date: Fri, 28 Oct 2016 08:40:40 -0600
MIME-Version: 1.0
In-Reply-To: <20161025120158.GA2706@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/2016 06:01 AM, Christoph Hellwig wrote:
> Hi Jens,
>
> any comments on this series? I addition to fixing up the zoned command
> direction issue it's also the base for some more work that I'm doing
> at the moment, so I'd really like to know if you're fine with the direction.

I think it looks reasonable, currently the mess of what flags are 
shared, which ones are not, etc is a big pain in the ass. So making the 
distinction clearer is an improvement.

I'll work on getting this applied to 4.10/block.

-- 
Jens Axboe
