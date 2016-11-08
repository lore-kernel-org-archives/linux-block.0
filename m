Subject: Re: BUG: Hung task timeouts in for-4.10/dio
To: Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
References: <366c9429-1bf8-a385-c8b3-a7e6c06a9907@deltatee.com>
 <8eed541f-b4c2-37c9-6650-216f3d0aa92f@fb.com>
 <21f0cddd-28d9-790d-b4fc-4635cca77ea8@deltatee.com>
Cc: linux-block@vger.kernel.org, Stephen Bates <stephen.bates@microsemi.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <9fe151a1-2d9f-28ef-25a7-bbcb01d8d972@fb.com>
Date: Tue, 8 Nov 2016 12:01:20 -0700
MIME-Version: 1.0
In-Reply-To: <21f0cddd-28d9-790d-b4fc-4635cca77ea8@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/08/2016 11:59 AM, Logan Gunthorpe wrote:
> Hi Jens,
>
> Thanks for the quick reply. I just built 82a78cd and I'm seeing the same
> problem as reported.

Hmm, very odd. Does it work if you run that branch and revert the commit 
you bisected as troublesome, b685d3d65ac7?

-- 
Jens Axboe
