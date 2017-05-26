Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 4/5] blk-mq-debugfs: Show busy requests
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "hare@suse.com" <hare@suse.com>, "osandov@fb.com" <osandov@fb.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>
References: <20170525233810.23211-1-bart.vanassche@sandisk.com>
 <20170525233810.23211-5-bart.vanassche@sandisk.com>
 <fa7126bb-7652-ed01-da08-23c3f428c00b@kernel.dk>
 <1495833461.2634.7.camel@sandisk.com>
 <0c124a6c-8c2d-1fb9-118f-96ce7fadc64c@kernel.dk>
Message-ID: <dbbe5400-0c44-fbfe-f5b7-3f6d9ddceb0f@kernel.dk>
Date: Fri, 26 May 2017 15:21:33 -0600
MIME-Version: 1.0
In-Reply-To: <0c124a6c-8c2d-1fb9-118f-96ce7fadc64c@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/26/2017 03:20 PM, Jens Axboe wrote:
> On 05/26/2017 03:17 PM, Bart Van Assche wrote:
>> On Fri, 2017-05-26 at 07:26 -0600, Jens Axboe wrote:
>>> On 05/25/2017 05:38 PM, Bart Van Assche wrote:
>>>> Requests that got stuck in a block driver are neither on
>>>> blk_mq_ctx.rq_list nor on any hw dispatch queue. Make these
>>>> visible in debugfs through the "busy" attribute.
>>>>
>>>> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
>>>> Cc: Christoph Hellwig <hch@lst.de>
>>>> Cc: Hannes Reinecke <hare@suse.com>
>>>> Cc: Omar Sandoval <osandov@fb.com>
>>>> Cc: Ming Lei <ming.lei@redhat.com>
>>>> ---
>>>>  block/blk-mq-debugfs.c | 25 +++++++++++++++++++++++++
>>>>  1 file changed, 25 insertions(+)
>>>>
>>>> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
>>>> index 8b06a12c1461..70a2b955afee 100644
>>>> --- a/block/blk-mq-debugfs.c
>>>> +++ b/block/blk-mq-debugfs.c
>>>> @@ -370,6 +370,30 @@ static const struct seq_operations hctx_dispatch_seq_ops = {
>>>>  	.show	= blk_mq_debugfs_rq_show,
>>>>  };
>>>>  
>>>> +struct show_busy_ctx {
>>>> +	struct seq_file		*m;
>>>> +	struct blk_mq_hw_ctx	*hctx;
>>>> +};
>>>> +
>>>> +static void hctx_show_busy(struct request *rq, void *data, bool reserved)
>>>> +{
>>>> +	const struct show_busy_ctx *ctx = data;
>>>
>>> Let's not call that variable 'ctx', in blk-mq that's pretty much
>>> reserved for the sw queues.
>>
>> Hello Jens,
>>
>> How about renaming show_busy_ctx into show_busy_params and ctx into params?
> 
> I think that would be an improvement. Also, this:
> 
> 	blk_mq_debugfs_rq_show(ctx->m, &rq->queuelist);
> 
> doesn't look safe at all, as you are passing in a node instead of a
> head. I think you just want to use __blk_mq_debugfs_rq_show() here.

I guess it's safe as we don't iterate the list, but it's pointless
though. Just use __blk_mq_debugfs_rq_show().

-- 
Jens Axboe
