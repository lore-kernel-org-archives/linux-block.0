Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/5] bfq: Annotate fall-through in a switch statement
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170830184211.12471-2-bart.vanassche@wdc.com>
Date: Fri, 1 Sep 2017 19:14:26 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Message-Id: <9A526DBC-19D0-442B-8C4D-880E3EB94DBD@linaro.org>
References: <20170830184211.12471-1-bart.vanassche@wdc.com> <20170830184211.12471-2-bart.vanassche@wdc.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 30 ago 2017, alle ore 20:42, Bart Van Assche =
<bart.vanassche@wdc.com> ha scritto:
>=20
> This patch avoids that gcc 7 issues a warning about fall-through
> when building with W=3D1.
>=20
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Paolo Valente <paolo.valente@linaro.org>

Acked-by: Paolo Valente <paolo.valente@linaro.org>

> ---
> block/bfq-iosched.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 6a7a26b6cec1..8c11c2e827a5 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -3780,6 +3780,7 @@ bfq_set_next_ioprio_data(struct bfq_queue *bfqq, =
struct bfq_io_cq *bic)
> 	default:
> 		dev_err(bfqq->bfqd->queue->backing_dev_info->dev,
> 			"bfq: bad prio class %d\n", ioprio_class);
> +		/* fall through */
> 	case IOPRIO_CLASS_NONE:
> 		/*
> 		 * No prio set, inherit CPU scheduling settings.
> --=20
> 2.14.1
>=20
