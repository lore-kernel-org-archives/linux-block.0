Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V4] blk-mq: avoid to starve tag allocation after
 allocation process migrates
To: Omar Sandoval <osandov@osandov.com>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, stable@vger.kernel.org,
 Omar Sandoval <osandov@fb.com>
References: <20180524074910.32020-1-ming.lei@redhat.com>
 <20180524165216.GG12533@vader>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8aaf8f1d-9b5b-0b4c-d374-efbdf2c125ba@kernel.dk>
Date: Thu, 24 May 2018 10:53:37 -0600
MIME-Version: 1.0
In-Reply-To: <20180524165216.GG12533@vader>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/24/18 10:52 AM, Omar Sandoval wrote:
> On Thu, May 24, 2018 at 03:49:10PM +0800, Ming Lei wrote:
>> When the allocation process is scheduled back and the mapped hw queue is
>> changed, fake one extra wake up on previous queue for compensating wake up
>> miss, so other allocations on the previous queue won't be starved.
>>
>> This patch fixes one request allocation hang issue, which can be
>> triggered easily in case of very low nr_request.
>>
>> Cc: <stable@vger.kernel.org>
>> Cc: Omar Sandoval <osandov@fb.com>
> 
> Reviewed-by: Omar Sandoval <osandov@fb.com>
> 
> The longer explanation you gave would be nice to have in the commit
> message, but maybe Jens can add that when he applies it.

Exactly, I had planned on augmenting the commit message since I don't
think the above really explains it. I'll do that and get it applied.

-- 
Jens Axboe
