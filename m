Subject: Re: [PATCH 6/7] mq-deadline: add blk-mq adaptation of the deadline IO
 scheduler
To: Bart Van Assche <bart.vanassche@sandisk.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1481228005-9245-1-git-send-email-axboe@fb.com>
 <1481228005-9245-7-git-send-email-axboe@fb.com>
 <d4534a17-7fc3-3c55-37fd-aa2fff326795@sandisk.com>
Cc: paolo.valente@linaro.org, osandov@fb.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <d48260a6-c7f1-d5ed-bc21-80b69ed9d2f6@fb.com>
Date: Wed, 14 Dec 2016 08:02:59 -0700
MIME-Version: 1.0
In-Reply-To: <d4534a17-7fc3-3c55-37fd-aa2fff326795@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/14/2016 01:09 AM, Bart Van Assche wrote:
> On 12/08/2016 09:13 PM, Jens Axboe wrote:
>> +static inline bool dd_rq_is_shadow(struct request *rq)
>> +{
>> +	return rq->rq_flags & RQF_ALLOCED;
>> +}
> 
> Hello Jens,
> 
> Something minor: because req_flags_t has been defined using __bitwise
> (typedef __u32 __bitwise req_flags_t) sparse complains for the above
> function about converting req_flags_t into bool. How about changing the
> body of that function into "return (rq->rq_flags & RQF_ALLOCED) != 0" to
> keep sparse happy?

Sure, I can fold in that change.

-- 
Jens Axboe
