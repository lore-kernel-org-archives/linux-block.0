Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 5/5] bfq: Use icq_to_bic() consistently
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170830184211.12471-6-bart.vanassche@wdc.com>
Date: Fri, 1 Sep 2017 19:15:06 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Message-Id: <14F050D7-2A93-444F-825D-F99D9A04DD37@linaro.org>
References: <20170830184211.12471-1-bart.vanassche@wdc.com> <20170830184211.12471-6-bart.vanassche@wdc.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 30 ago 2017, alle ore 20:42, Bart Van Assche =
<bart.vanassche@wdc.com> ha scritto:
>=20
> Some code uses icq_to_bic() to convert an io_cq pointer to a
> bfq_io_cq pointer while other code uses a direct cast. Convert
> the code that uses a direct cast such that it uses icq_to_bic().
>=20
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Paolo Valente <paolo.valente@linaro.org>

Acked-by: Paolo Valente <paolo.valente@linaro.org>

> ---
> block/bfq-iosched.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index d375b29ad085..7d1b85e393b2 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -239,7 +239,7 @@ static int T_slow[2];
> static int T_fast[2];
> static int device_speed_thresh[2];
>=20
> -#define RQ_BIC(rq)		((struct bfq_io_cq *) (rq)->elv.priv[0])
> +#define RQ_BIC(rq)		icq_to_bic((rq)->elv.priv[0])
> #define RQ_BFQQ(rq)		((rq)->elv.priv[1])
>=20
> struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync)
> --=20
> 2.14.1
>=20
