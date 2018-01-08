Return-Path: <holger@applied-asynchrony.com>
Subject: Re: [PATCH 2/8] blk-mq: protect completion path with RCU
To: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, jack@suse.cz,
 clm@fb.com, jbacik@fb.com
Cc: kernel-team@fb.com, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, peterz@infradead.org,
 jianchao.w.wang@oracle.com, Bart.VanAssche@wdc.com,
 linux-block@vger.kernel.org
References: <20180108191542.379478-1-tj@kernel.org>
 <20180108191542.379478-3-tj@kernel.org>
 <774b9fa0-c1f9-f528-09c3-2f3bd67e0fd5@applied-asynchrony.com>
 <93157cfd-7c3c-c260-14e2-25784fe43314@kernel.dk>
 <7b22068e-85a5-06e0-c699-d1e970bbb3a6@kernel.dk>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Message-ID: <229f2475-733d-d20a-ccef-6f2c0c5ae7b7@applied-asynchrony.com>
Date: Tue, 9 Jan 2018 00:27:49 +0100
MIME-Version: 1.0
In-Reply-To: <7b22068e-85a5-06e0-c699-d1e970bbb3a6@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 01/08/18 23:55, Jens Axboe wrote:
> On 1/8/18 1:15 PM, Jens Axboe wrote:
>> On 1/8/18 12:57 PM, Holger Hoffstätte wrote:
>>> On 01/08/18 20:15, Tejun Heo wrote:
>>>> Currently, blk-mq protects only the issue path with RCU.  This patch
>>>> puts the completion path under the same RCU protection.  This will be
>>>> used to synchronize issue/completion against timeout by later patches,
>>>> which will also add the comments.
>>>>
>>>> Signed-off-by: Tejun Heo <tj@kernel.org>
>>>> ---
>>>>  block/blk-mq.c | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index ddc9261..6741c3e 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -584,11 +584,16 @@ static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
>>>>  void blk_mq_complete_request(struct request *rq)
>>>>  {
>>>>  	struct request_queue *q = rq->q;
>>>> +	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, rq->mq_ctx->cpu);
>>>> +	int srcu_idx;
>>>>  
>>>>  	if (unlikely(blk_should_fake_timeout(q)))
>>>>  		return;
>>>> +
>>>> +	hctx_lock(hctx, &srcu_idx);
>>>>  	if (!blk_mark_rq_complete(rq))
>>>>  		__blk_mq_complete_request(rq);
>>>> +	hctx_unlock(hctx, srcu_idx);
>>>>  }
>>>>  EXPORT_SYMBOL(blk_mq_complete_request);
>>>
>>> So I've had v3 running fine with 4.14++ and when I first tried Jens'
>>> additional helpers on top, I got a bunch of warnings which I didn't
>>> investigate further at the time. Now they are back since the helpers
>>> moved into patch #1 and #2 correctly says:
>>>
>>> ..
>>> block/blk-mq.c: In function ‘blk_mq_complete_request’:
>>> ./include/linux/srcu.h:175:2: warning: ‘srcu_idx’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>>>   __srcu_read_unlock(sp, idx);
>>>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> block/blk-mq.c:587:6: note: ‘srcu_idx’ was declared here
>>>   int srcu_idx;
>>>       ^~~~~~~~
>>> ..etc.
>>>
>>> This is with gcc 7.2.0.
>>>
>>> I understand that this is a somewhat-false positive since the lock always
>>> precedes the unlock & writes to the value, but can we properly initialize
>>> or annotate this?
>>
>> It's not a somewhat false positive, it's a false positive. I haven't seen
>> that bogus warning with the compiler I'm running:
>>
>> gcc (Ubuntu 7.2.0-1ubuntu1~16.04) 7.2.0
>>
>> and
>>
>> gcc (GCC) 7.2.0
>>
>> Neither of them throw the warning.
> 
> Are you on non-x86? Really bothers me to have to add a work-around
> for something that's obviously a false positive.

No, plain old x86-64 on Gentoo (*without* crazy hardening or extras).
But don't bother spending too much time on this, I can live with the
warning even though I found it curious. Not even sure why you don't
see this; according to git -Wmaybe-uninitialized is part of the
"extrawarn" make flags since ~2016.

Apparently gcc can't see that the first branch in the lock-helper
implies that the first branch in the unlock helper will also be taken
unconditionally (and how could it? nested branch condition elision?),
so it concludes srcu_idx "may" be used uninitialized in unlock, and
that's not generally wrong. It just happens to be in this case.

> I forget if we have some gcc/compiler annotation for this, otherwise

I actually went looking for gcc bugs, pragmas, annotations and whatnot;
there are many bugs depending on optimizer, the #pragmas don't work
and a potential __attribute__(initialized) was only discussed, but
apparently never implemented. \o/

> the good old
> 
> int srcu_idx = srcu_idx;
> 
> should get the job done.

(Narrator: It didn't.)

Isn't there some magic value that will never be used by regular
operations? 0 or -1? It should not matter much since it will be
consistently overwritten or left alone.

cheers
Holger
