Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 7/8] mq-deadline: add blk-mq adaptation of the deadline IO scheduler
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1481933536-12844-8-git-send-email-axboe@fb.com>
Date: Tue, 20 Dec 2016 10:34:43 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 osandov@fb.com
Message-Id: <99111D0B-F051-4D8F-94EF-E7962F47FFD9@linaro.org>
References: <1481933536-12844-1-git-send-email-axboe@fb.com> <1481933536-12844-8-git-send-email-axboe@fb.com>
To: Jens Axboe <axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 17 dic 2016, alle ore 01:12, Jens Axboe <axboe@fb.com> ha =
scritto:
>=20
> This is basically identical to deadline-iosched, except it registers
> as a MQ capable scheduler. This is still a single queue design.
>=20
> Signed-off-by: Jens Axboe <axboe@fb.com>
> ...
> +
> +static bool dd_has_work(struct blk_mq_hw_ctx *hctx)
> +{
> +	struct deadline_data *dd =3D =
hctx->queue->elevator->elevator_data;
> +
> +	return !list_empty_careful(&dd->dispatch) ||
> +		!list_empty_careful(&dd->fifo_list[0]) ||
> +		!list_empty_careful(&dd->fifo_list[1]);

Just a request for clarification: if I'm not mistaken,
list_empty_careful can be used safely only if the only possible other
concurrent access is a delete.  Or am I missing something?

If the above constraint does hold, then how are we guaranteed that it
is met?  My doubt arises from, e.g., the possible concurrent list_add
from dd_insert_request.

Thanks,
Paolo

> +}
> +
> +/*
> + * sysfs parts below
> + */
> +static ssize_t
> +deadline_var_show(int var, char *page)
> +{
> +	return sprintf(page, "%d\n", var);
> +}
> +
> +static ssize_t
> +deadline_var_store(int *var, const char *page, size_t count)
> +{
> +	char *p =3D (char *) page;
> +
> +	*var =3D simple_strtol(p, &p, 10);
> +	return count;
> +}
> +
> +#define SHOW_FUNCTION(__FUNC, __VAR, __CONV)				=
\
> +static ssize_t __FUNC(struct elevator_queue *e, char *page)		=
\
> +{									=
\
> +	struct deadline_data *dd =3D e->elevator_data;			=
\
> +	int __data =3D __VAR;						=
\
> +	if (__CONV)							=
\
> +		__data =3D jiffies_to_msecs(__data);			=
\
> +	return deadline_var_show(__data, (page));			=
\
> +}
> +SHOW_FUNCTION(deadline_read_expire_show, dd->fifo_expire[READ], 1);
> +SHOW_FUNCTION(deadline_write_expire_show, dd->fifo_expire[WRITE], 1);
> +SHOW_FUNCTION(deadline_writes_starved_show, dd->writes_starved, 0);
> +SHOW_FUNCTION(deadline_front_merges_show, dd->front_merges, 0);
> +SHOW_FUNCTION(deadline_fifo_batch_show, dd->fifo_batch, 0);
> +#undef SHOW_FUNCTION
> +
> +#define STORE_FUNCTION(__FUNC, __PTR, MIN, MAX, __CONV)			=
\
> +static ssize_t __FUNC(struct elevator_queue *e, const char *page, =
size_t count)	\
> +{									=
\
> +	struct deadline_data *dd =3D e->elevator_data;			=
\
> +	int __data;							=
\
> +	int ret =3D deadline_var_store(&__data, (page), count);		=
\
> +	if (__data < (MIN))						=
\
> +		__data =3D (MIN);						=
\
> +	else if (__data > (MAX))					=
\
> +		__data =3D (MAX);						=
\
> +	if (__CONV)							=
\
> +		*(__PTR) =3D msecs_to_jiffies(__data);			=
\
> +	else								=
\
> +		*(__PTR) =3D __data;					=
\
> +	return ret;							=
\
> +}
> +STORE_FUNCTION(deadline_read_expire_store, &dd->fifo_expire[READ], 0, =
INT_MAX, 1);
> +STORE_FUNCTION(deadline_write_expire_store, &dd->fifo_expire[WRITE], =
0, INT_MAX, 1);
> +STORE_FUNCTION(deadline_writes_starved_store, &dd->writes_starved, =
INT_MIN, INT_MAX, 0);
> +STORE_FUNCTION(deadline_front_merges_store, &dd->front_merges, 0, 1, =
0);
> +STORE_FUNCTION(deadline_fifo_batch_store, &dd->fifo_batch, 0, =
INT_MAX, 0);
> +#undef STORE_FUNCTION
> +
> +#define DD_ATTR(name) \
> +	__ATTR(name, S_IRUGO|S_IWUSR, deadline_##name##_show, \
> +				      deadline_##name##_store)
> +
> +static struct elv_fs_entry deadline_attrs[] =3D {
> +	DD_ATTR(read_expire),
> +	DD_ATTR(write_expire),
> +	DD_ATTR(writes_starved),
> +	DD_ATTR(front_merges),
> +	DD_ATTR(fifo_batch),
> +	__ATTR_NULL
> +};
> +
> +static struct elevator_type mq_deadline =3D {
> +	.ops.mq =3D {
> +		.get_request		=3D dd_get_request,
> +		.put_request		=3D dd_put_request,
> +		.insert_requests	=3D dd_insert_requests,
> +		.dispatch_requests	=3D dd_dispatch_requests,
> +		.completed_request	=3D dd_completed_request,
> +		.next_request		=3D elv_rb_latter_request,
> +		.former_request		=3D elv_rb_former_request,
> +		.bio_merge		=3D dd_bio_merge,
> +		.request_merge		=3D dd_request_merge,
> +		.requests_merged	=3D dd_merged_requests,
> +		.request_merged		=3D dd_request_merged,
> +		.has_work		=3D dd_has_work,
> +		.init_sched		=3D dd_init_queue,
> +		.exit_sched		=3D dd_exit_queue,
> +	},
> +
> +	.uses_mq	=3D true,
> +	.elevator_attrs =3D deadline_attrs,
> +	.elevator_name =3D "mq-deadline",
> +	.elevator_owner =3D THIS_MODULE,
> +};
> +
> +static int __init deadline_init(void)
> +{
> +	if (!queue_depth) {
> +		pr_err("mq-deadline: queue depth must be > 0\n");
> +		return -EINVAL;
> +	}
> +	return elv_register(&mq_deadline);
> +}
> +
> +static void __exit deadline_exit(void)
> +{
> +	elv_unregister(&mq_deadline);
> +}
> +
> +module_init(deadline_init);
> +module_exit(deadline_exit);
> +
> +MODULE_AUTHOR("Jens Axboe");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("MQ deadline IO scheduler");
> --=20
> 2.7.4
>=20
