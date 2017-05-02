Subject: Re: [PATCH ] block: don't call blk_mq_quiesce_queue() during
 switching mq sched
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>
References: <20170428073250.9579-1-ming.lei@redhat.com>
 <88cb69a2-34a7-6315-cc18-b254a46914dc@fb.com>
 <1493395159.2767.5.camel@sandisk.com>
Cc: "hch@infradead.org" <hch@infradead.org>, "osandov@fb.com" <osandov@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <c9276658-f67e-3cca-b807-c2dafd50ad3b@fb.com>
Date: Tue, 2 May 2017 11:31:10 -0600
MIME-Version: 1.0
In-Reply-To: <1493395159.2767.5.camel@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/28/2017 09:59 AM, Bart Van Assche wrote:
> On Fri, 2017-04-28 at 07:42 -0600, Jens Axboe wrote:
>> On 04/28/2017 01:32 AM, Ming Lei wrote:
>>> We have freezed queue already, not necessary to call
>>> blk_mq_quiesce_queue() any more, so remove it.
>>
>> Are you sure? It ensures that we also aren't in the middle of
>> blk_mq_make_request(), we need a stable view of the sched
>> status throughout that.
> 
> Hello Jens,
> 
> My understanding is that blk_mq_freeze_queue() provides stronger
> guarantees than blk_mq_quiesce_queue(). The former waits until all
> pending requests have finished while the latter only waits until
> pending .queue_rq() calls have finished. blk_mq_freeze_queue() also
> causes new blk_get_request() calls to wait until
> blk_mq_unfreeze_queue() is called while blk_get_request() can still
> succeed after blk_mq_quiesce_queue() returned and before
> blk_mq_start_stopped_hw_queues() is called.
> 
> Regarding blk_mq_make_request(): I think that the blk_queue_enter()
> call in generic_make_request() prevents that blk_mq_make_request()
> gets called after a queue has been frozen.

Bart, you are right, I'm fine with the patch.

-- 
Jens Axboe
