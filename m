Return-Path: <Bart.VanAssche@sandisk.com>
Subject: Re: [PATCH 6/7] mq-deadline: add blk-mq adaptation of the deadline IO
 scheduler
To: Jens Axboe <axboe@fb.com>, <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1481228005-9245-1-git-send-email-axboe@fb.com>
 <1481228005-9245-7-git-send-email-axboe@fb.com>
CC: <paolo.valente@linaro.org>, <osandov@fb.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <d4534a17-7fc3-3c55-37fd-aa2fff326795@sandisk.com>
Date: Wed, 14 Dec 2016 09:09:45 +0100
MIME-Version: 1.0
In-Reply-To: <1481228005-9245-7-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset="windows-1252"
Return-Path: bart.vanassche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 12/08/2016 09:13 PM, Jens Axboe wrote:
> +static inline bool dd_rq_is_shadow(struct request *rq)
> +{
> +	return rq->rq_flags & RQF_ALLOCED;
> +}

Hello Jens,

Something minor: because req_flags_t has been defined using __bitwise
(typedef __u32 __bitwise req_flags_t) sparse complains for the above
function about converting req_flags_t into bool. How about changing the
body of that function into "return (rq->rq_flags & RQF_ALLOCED) != 0" to
keep sparse happy?

Bart.
