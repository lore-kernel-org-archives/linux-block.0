Subject: Re: [PATCHSET] block: IO polling improvements
To: Christoph Hellwig <hch@lst.de>
References: <1478034325-28232-1-git-send-email-axboe@fb.com>
 <20161102145148.GA13964@lst.de>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Dave Chinner <david@fromorbit.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <1cc557ba-8030-8dd8-87bf-4b13817ffb8d@fb.com>
Date: Wed, 2 Nov 2016 08:54:28 -0600
MIME-Version: 1.0
In-Reply-To: <20161102145148.GA13964@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/02/2016 08:51 AM, Christoph Hellwig wrote:
> On Tue, Nov 01, 2016 at 03:05:21PM -0600, Jens Axboe wrote:
>> This builds on top of Christophs simplified bdev O_DIRECT code,
>> posted earlier today [1].
>
> Btw, can you create a stable branch just for the
> "block: add bio_iov_iter_get_pages()" so that we can use it as
> a baseline for the iomap dio work?

Sure

-- 
Jens Axboe
