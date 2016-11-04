Subject: Re: [PATCH 3/5] block: move poll code to blk-mq
To: Christoph Hellwig <hch@lst.de>
References: <1478202307-1947-1-git-send-email-axboe@fb.com>
 <1478202307-1947-4-git-send-email-axboe@fb.com>
 <20161104144410.GA29203@lst.de>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <a3933168-a17c-1e98-4a95-3e79f0d4beb0@fb.com>
Date: Fri, 4 Nov 2016 09:30:00 -0600
MIME-Version: 1.0
In-Reply-To: <20161104144410.GA29203@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/04/2016 08:44 AM, Christoph Hellwig wrote:
> On Thu, Nov 03, 2016 at 01:45:05PM -0600, Jens Axboe wrote:
>> The poll code is blk-mq specific, let's move it to blk-mq.c. This
>> is a prep patch for improving the polling code.
>>
>> Signed-off-by: Jens Axboe <axboe@fb.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> So I gave my ok earlier, but I spent some more time looking at this
> this morning and now I wonder why we even bother to keep some
> code in blk-core.c.  How about just renaming the whole damn thing
> to blk_mq_poll and move it to blk-mq.c instead of that split?

I pondered that too, and I guess we might as well since the likelihood
of supporting polling on non-mq is pretty close to 0%.

-- 
Jens Axboe
