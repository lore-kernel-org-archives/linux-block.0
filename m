Subject: Re: [PATCH 3/4] blk-mq: implement hybrid poll mode for sync O_DIRECT
To: Ming Lei <tom.leiming@gmail.com>
References: <1478034325-28232-1-git-send-email-axboe@fb.com>
 <1478034325-28232-4-git-send-email-axboe@fb.com>
 <CACVXFVOoUz7dZ9y=-jqLQFWaekYHnoEQk-ao1s8ydsdh5PJbOw@mail.gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-block <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
From: Jens Axboe <axboe@fb.com>
Message-ID: <5762c14d-eb4e-b601-a15f-71ef5fbfec3d@fb.com>
Date: Thu, 3 Nov 2016 07:41:28 -0600
MIME-Version: 1.0
In-Reply-To: <CACVXFVOoUz7dZ9y=-jqLQFWaekYHnoEQk-ao1s8ydsdh5PJbOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/03/2016 06:27 AM, Ming Lei wrote:
> On Wed, Nov 2, 2016 at 5:05 AM, Jens Axboe <axboe@fb.com> wrote:
>> This patch enables a hybrid polling mode. Instead of polling after IO
>> submission, we can induce an artificial delay, and then poll after that.
>> For example, if the IO is presumed to complete in 8 usecs from now, we
>> can sleep for 4 usecs, wake up, and then do our polling. This still puts
>
> I guess in reality it isn't easy to figure a perfect poll time:
>
> - for one driver, different CPU and different drive/disk may cause different
> completion time
>
> - for requests with different size, the completion time can be different too
>
> Is there one way to figure out the poll time automatically?

Yes, it's not easy to figure out the perfect time, the point is to try
and make a guess that's a bit better than the current "let's poll the
whole time". I suspect that for most real world cases, you are going to
be polling for smallish IO of roughly the same size. Hence the stats
should be useful.

But we could extend the tracking a bit and make it smarter.


-- 
Jens Axboe
