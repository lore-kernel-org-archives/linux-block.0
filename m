Subject: Re: [PATCH 0/7] blk-mq: fix queue quiescing
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20170525042131.13172-1-ming.lei@redhat.com>
 <1495689892.3045.2.camel@sandisk.com> <20170525090917.GB15737@ming.t460p>
 <1495733047.2615.1.camel@sandisk.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <fb4abb2d-d6b4-5f90-b348-ae7e347e8fc3@fb.com>
Date: Thu, 25 May 2017 11:31:30 -0600
MIME-Version: 1.0
In-Reply-To: <1495733047.2615.1.camel@sandisk.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/25/2017 11:24 AM, Bart Van Assche wrote:
> On Thu, 2017-05-25 at 17:09 +0800, Ming Lei wrote:
>> Another big issue is that 'srcu_struct' is very big, which shouldn't
>> be embedded into hctx, since we only have one real user of
>> BLK_MQ_F_BLOCKING.
>>
>> So I will fix that too.
> 
> Hello Ming,
> 
> Is something like the (untested) patch below perhaps what you had in mind?
> 
> Subject: [PATCH] blk-mq: Reduce blk_mq_hw_ctx size
> 
> Since the srcu structure is rather large (184 bytes on an x86-64
> system), only allocate it if needed.

On my normal laptop setup, it's actually 408 bytes (!!).

-- 
Jens Axboe
