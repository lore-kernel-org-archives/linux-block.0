Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 3/5] bfq: Check kstrtoul() return value
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170830184211.12471-4-bart.vanassche@wdc.com>
Date: Fri, 1 Sep 2017 19:14:56 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Message-Id: <C7E01FF1-7311-449B-A410-E5F5C7369B9A@linaro.org>
References: <20170830184211.12471-1-bart.vanassche@wdc.com> <20170830184211.12471-4-bart.vanassche@wdc.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 30 ago 2017, alle ore 20:42, Bart Van Assche =
<bart.vanassche@wdc.com> ha scritto:
>=20
> Make sysfs writes fail for invalid numbers instead of storing
> uninitialized data copied from the stack. This patch removes
> all uninitialized_var() occurrences from the BFQ source code.
>=20
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Paolo Valente <paolo.valente@linaro.org>

Acked-by: Paolo Valente <paolo.valente@linaro.org>

> ---
> block/bfq-iosched.c | 52 =
+++++++++++++++++++++++++++++++++++++---------------
> 1 file changed, 37 insertions(+), 15 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 8c11c2e827a5..cf92f16eb5f2 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4802,13 +4802,15 @@ static ssize_t bfq_var_show(unsigned int var, =
char *page)
> 	return sprintf(page, "%u\n", var);
> }
>=20
> -static void bfq_var_store(unsigned long *var, const char *page)
> +static int bfq_var_store(unsigned long *var, const char *page)
> {
> 	unsigned long new_val;
> 	int ret =3D kstrtoul(page, 10, &new_val);
>=20
> -	if (ret =3D=3D 0)
> -		*var =3D new_val;
> +	if (ret)
> +		return ret;
> +	*var =3D new_val;
> +	return 0;
> }
>=20
> #define SHOW_FUNCTION(__FUNC, __VAR, __CONV)				=
\
> @@ -4849,8 +4851,12 @@ static ssize_t						=
		\
> __FUNC(struct elevator_queue *e, const char *page, size_t count)	=
\
> {									=
\
> 	struct bfq_data *bfqd =3D e->elevator_data;			=
\
> -	unsigned long uninitialized_var(__data);			=
\
> -	bfq_var_store(&__data, (page));					=
\
> +	unsigned long __data;						=
\
> +	int ret;							=
\
> +									=
\
> +	ret =3D bfq_var_store(&__data, (page));				=
\
> +	if (ret)							=
\
> +		return ret;						=
\
> 	if (__data < (MIN))						=
\
> 		__data =3D (MIN);						=
\
> 	else if (__data > (MAX))					=
\
> @@ -4877,8 +4883,12 @@ STORE_FUNCTION(bfq_slice_idle_store, =
&bfqd->bfq_slice_idle, 0, INT_MAX, 2);
> static ssize_t __FUNC(struct elevator_queue *e, const char *page, =
size_t count)\
> {									=
\
> 	struct bfq_data *bfqd =3D e->elevator_data;			=
\
> -	unsigned long uninitialized_var(__data);			=
\
> -	bfq_var_store(&__data, (page));					=
\
> +	unsigned long __data;						=
\
> +	int ret;							=
\
> +									=
\
> +	ret =3D bfq_var_store(&__data, (page));				=
\
> +	if (ret)							=
\
> +		return ret;						=
\
> 	if (__data < (MIN))						=
\
> 		__data =3D (MIN);						=
\
> 	else if (__data > (MAX))					=
\
> @@ -4894,9 +4904,12 @@ static ssize_t bfq_max_budget_store(struct =
elevator_queue *e,
> 				    const char *page, size_t count)
> {
> 	struct bfq_data *bfqd =3D e->elevator_data;
> -	unsigned long uninitialized_var(__data);
> +	unsigned long __data;
> +	int ret;
>=20
> -	bfq_var_store(&__data, (page));
> +	ret =3D bfq_var_store(&__data, (page));
> +	if (ret)
> +		return ret;
>=20
> 	if (__data =3D=3D 0)
> 		bfqd->bfq_max_budget =3D bfq_calc_max_budget(bfqd);
> @@ -4919,9 +4932,12 @@ static ssize_t bfq_timeout_sync_store(struct =
elevator_queue *e,
> 				      const char *page, size_t count)
> {
> 	struct bfq_data *bfqd =3D e->elevator_data;
> -	unsigned long uninitialized_var(__data);
> +	unsigned long __data;
> +	int ret;
>=20
> -	bfq_var_store(&__data, (page));
> +	ret =3D bfq_var_store(&__data, (page));
> +	if (ret)
> +		return ret;
>=20
> 	if (__data < 1)
> 		__data =3D 1;
> @@ -4939,9 +4955,12 @@ static ssize_t =
bfq_strict_guarantees_store(struct elevator_queue *e,
> 				     const char *page, size_t count)
> {
> 	struct bfq_data *bfqd =3D e->elevator_data;
> -	unsigned long uninitialized_var(__data);
> +	unsigned long __data;
> +	int ret;
>=20
> -	bfq_var_store(&__data, (page));
> +	ret =3D bfq_var_store(&__data, (page));
> +	if (ret)
> +		return ret;
>=20
> 	if (__data > 1)
> 		__data =3D 1;
> @@ -4958,9 +4977,12 @@ static ssize_t bfq_low_latency_store(struct =
elevator_queue *e,
> 				     const char *page, size_t count)
> {
> 	struct bfq_data *bfqd =3D e->elevator_data;
> -	unsigned long uninitialized_var(__data);
> +	unsigned long __data;
> +	int ret;
>=20
> -	bfq_var_store(&__data, (page));
> +	ret =3D bfq_var_store(&__data, (page));
> +	if (ret)
> +		return ret;
>=20
> 	if (__data > 1)
> 		__data =3D 1;
> --=20
> 2.14.1
>=20
