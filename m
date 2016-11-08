Subject: Re: BUG: Hung task timeouts in for-4.10/dio
To: Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
References: <366c9429-1bf8-a385-c8b3-a7e6c06a9907@deltatee.com>
Cc: linux-block@vger.kernel.org, Stephen Bates <stephen.bates@microsemi.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <8eed541f-b4c2-37c9-6650-216f3d0aa92f@fb.com>
Date: Tue, 8 Nov 2016 11:21:43 -0700
MIME-Version: 1.0
In-Reply-To: <366c9429-1bf8-a385-c8b3-a7e6c06a9907@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/08/2016 11:16 AM, Logan Gunthorpe wrote:
> Hi guys,
>
> We were looking at testing the new IO polling improvements and we built
> a kernel from the 'for-4.10/dio' (64ead7d) branch in linux-block.
> However this branch seems to cause hung tasks when booted. Most
> noticeably, dhclient seems to always hang as it tries to read from it's
> leases file, and that means networking does not work on the computers we
> tested on. Other tasks seemed to hang occasionally and randomly.
>
> We tested on two machines with radically different hardware but both
> running Debian Jessie.  (One is a dual-socket server system with the
> root FS on an HDD and the other is an off the shelf commodity
> motherboard with root on an SSD.)
>
> We performed a bisect to find the culprit commit to be:
>
> [b685d3d65ac791406e0dfd8779cc9b3707fea5a3] block: treat REQ_FUA and
> REQ_PREFLUSH as synchronous
>
> I've attached a bisect log.

I don't think that's right. The version you ran has a bug in the stats
code. Please update to the current for-4.10/dio branch (82a78cd682bf)
and I think you'll have more luck.

-- 
Jens Axboe
