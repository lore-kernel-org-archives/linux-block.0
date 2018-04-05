Return-Path: <sitsofe@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180402202951.GE388343@devbig577.frc2.facebook.com>
References: <CALjAwxh-PVYFnYFCJpGOja+m5SzZ8Sa4J7ohxdK=r8NyOF-EMA@mail.gmail.com>
 <de102067-b589-af05-ae71-496e948000f0@kernel.dk> <CALjAwxgtuEv=d1TfvH3EdXqZs=_6F7TinyVhbPdUmTsdK_5ghw@mail.gmail.com>
 <20180402202951.GE388343@devbig577.frc2.facebook.com>
From: Sitsofe Wheeler <sitsofe@gmail.com>
Date: Thu, 5 Apr 2018 09:14:15 +0100
Message-ID: <CALjAwxhofAEa1Nr8d1+KpB3jimYL9nODf4Fu38oTe7ptgM_+cQ@mail.gmail.com>
Subject: Re: [BISECTED][REGRESSION] Hang while booting EeePC 900
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Stefan Haberland <sth@linux.vnet.ibm.com>,
	Jan Hoeppner <hoeppner@linux.vnet.ibm.com>, Bart Van Assche <Bart.VanAssche@wdc.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On 2 April 2018 at 21:29, Tejun Heo <tj@kernel.org> wrote:
> Hello, Sitsofe.
>
> Can you see whether the following patch makes any difference?
>
> Thanks.
>
> diff --git a/block/blk-timeout.c b/block/blk-timeout.c
> index a05e367..f0e6e41 100644
> --- a/block/blk-timeout.c
> +++ b/block/blk-timeout.c
> @@ -165,7 +165,7 @@ void blk_abort_request(struct request *req)
>                  * No need for fancy synchronizations.
>                  */
>                 blk_rq_set_deadline(req, jiffies);
> -               mod_timer(&req->q->timeout, 0);
> +               kblockd_schedule_work(&req->q->timeout_work);
>         } else {
>                 if (blk_mark_rq_complete(req))
>                         return;

Just out of interest, does the fact that an abort occurs mean that the
hardware is somehow broken or badly behaved?

-- 
Sitsofe | http://sucs.org/~sits/
