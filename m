Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] blk-mq: Make blk_mq_get_request() error path less
 confusing
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>
References: <20171016233226.5488-1-bart.vanassche@wdc.com>
 <1509733895.2473.30.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <464f9cda-e6c7-e947-e42f-8082a33dbf29@kernel.dk>
Date: Fri, 3 Nov 2017 12:34:52 -0600
MIME-Version: 1.0
In-Reply-To: <1509733895.2473.30.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/03/2017 12:31 PM, Bart Van Assche wrote:
> On Mon, 2017-10-16 at 16:32 -0700, Bart Van Assche wrote:
>> blk_mq_get_tag() can modify data->ctx. This means that in the
>> error path of blk_mq_get_request() data->ctx should be passed to
>> blk_mq_put_ctx() instead of local_ctx. Note: since blk_mq_put_ctx()
>> ignores its argument, this patch does not change any functionality.
> 
> Hello Jens,
> 
> Would it be possible to share your opinion about this patch?

Yeah looks fine, I queued it up.

-- 
Jens Axboe
