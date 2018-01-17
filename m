Return-Path: <houtao1@huawei.com>
Subject: Re: [PATCH] blktrace: support enabling cgroup info per-device
To: <linux-block@vger.kernel.org>
References: <20180111040946.21674-1-houtao1@huawei.com>
CC: <axboe@kernel.dk>, Shaohua Li <shli@kernel.org>
From: Hou Tao <houtao1@huawei.com>
Message-ID: <c2816776-2e1e-65d2-3130-f12c4ff962ad@huawei.com>
Date: Wed, 17 Jan 2018 14:10:43 +0800
MIME-Version: 1.0
In-Reply-To: <20180111040946.21674-1-houtao1@huawei.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

Any comments on this patch and the related patch set for blktrace [1] ?

Regards,
Tao

[1]: https://www.spinics.net/lists/linux-btrace/msg00790.html

On 2018/1/11 12:09, Hou Tao wrote:
> Now blktrace supports outputting cgroup info for trace action and
> trace message, however, it can only be enabled globally by writing
> "blk_cgroup" to trace_options file, and there is no per-device API
> for the new functionality.
> 
> Adding a new field (enable_cg_info) by using the pad after act_mask
> in struct blk_user_trace_setup and a new attr file (cgroup_info) under
> /sys/block/$dev/trace dir, so BLKTRACESETUP ioctl and sysfs file
> can be used to enable cgroup info for selected block devices.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  include/linux/blktrace_api.h      |  2 ++
>  include/uapi/linux/blktrace_api.h |  1 +
>  kernel/trace/blktrace.c           | 14 ++++++++++++--
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
> index 8804753..f120c6a 100644
> --- a/include/linux/blktrace_api.h
> +++ b/include/linux/blktrace_api.h
> @@ -18,6 +18,7 @@ struct blk_trace {
>  	unsigned long __percpu *sequence;
>  	unsigned char __percpu *msg_data;
>  	u16 act_mask;
> +	bool enable_cg_info;
>  	u64 start_lba;
>  	u64 end_lba;
>  	u32 pid;
> @@ -102,6 +103,7 @@ static inline int blk_trace_init_sysfs(struct device *dev)
>  struct compat_blk_user_trace_setup {
>  	char name[BLKTRACE_BDEV_SIZE];
>  	u16 act_mask;
> +	u8  enable_cg_info;
>  	u32 buf_size;
>  	u32 buf_nr;
>  	compat_u64 start_lba;
> diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
> index 20d1490d..d9d9fca 100644
> --- a/include/uapi/linux/blktrace_api.h
> +++ b/include/uapi/linux/blktrace_api.h
> @@ -136,6 +136,7 @@ enum {
>  struct blk_user_trace_setup {
>  	char name[BLKTRACE_BDEV_SIZE];	/* output */
>  	__u16 act_mask;			/* input */
> +	__u8  enable_cg_info;   /* input */
>  	__u32 buf_size;			/* input */
>  	__u32 buf_nr;			/* input */
>  	__u64 start_lba;
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 987d9a9a..f420400 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -180,7 +180,8 @@ void __trace_note_message(struct blk_trace *bt, struct blkcg *blkcg,
>  	n = vscnprintf(buf, BLK_TN_MAX_MSG, fmt, args);
>  	va_end(args);
>  
> -	if (!(blk_tracer_flags.val & TRACE_BLK_OPT_CGROUP))
> +	if (!((blk_tracer_flags.val & TRACE_BLK_OPT_CGROUP) ||
> +		  bt->enable_cg_info))
>  		blkcg = NULL;
>  #ifdef CONFIG_BLK_CGROUP
>  	trace_note(bt, 0, BLK_TN_MESSAGE, buf, n,
> @@ -549,6 +550,7 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>  	bt->act_mask = buts->act_mask;
>  	if (!bt->act_mask)
>  		bt->act_mask = (u16) -1;
> +	bt->enable_cg_info = buts->enable_cg_info;
>  
>  	blk_trace_setup_lba(bt, bdev);
>  
> @@ -625,6 +627,7 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
>  
>  	buts = (struct blk_user_trace_setup) {
>  		.act_mask = cbuts.act_mask,
> +		.enable_cg_info = cbuts.enable_cg_info,
>  		.buf_size = cbuts.buf_size,
>  		.buf_nr = cbuts.buf_nr,
>  		.start_lba = cbuts.start_lba,
> @@ -773,7 +776,8 @@ blk_trace_bio_get_cgid(struct request_queue *q, struct bio *bio)
>  {
>  	struct blk_trace *bt = q->blk_trace;
>  
> -	if (!bt || !(blk_tracer_flags.val & TRACE_BLK_OPT_CGROUP))
> +	if (!(bt && (bt->enable_cg_info ||
> +			 (blk_tracer_flags.val & TRACE_BLK_OPT_CGROUP))))
>  		return NULL;
>  
>  	if (!bio->bi_css)
> @@ -1664,6 +1668,7 @@ static BLK_TRACE_DEVICE_ATTR(act_mask);
>  static BLK_TRACE_DEVICE_ATTR(pid);
>  static BLK_TRACE_DEVICE_ATTR(start_lba);
>  static BLK_TRACE_DEVICE_ATTR(end_lba);
> +static BLK_TRACE_DEVICE_ATTR(cgroup_info);
>  
>  static struct attribute *blk_trace_attrs[] = {
>  	&dev_attr_enable.attr,
> @@ -1671,6 +1676,7 @@ static struct attribute *blk_trace_attrs[] = {
>  	&dev_attr_pid.attr,
>  	&dev_attr_start_lba.attr,
>  	&dev_attr_end_lba.attr,
> +	&dev_attr_cgroup_info.attr,
>  	NULL
>  };
>  
> @@ -1794,6 +1800,8 @@ static ssize_t sysfs_blk_trace_attr_show(struct device *dev,
>  		ret = sprintf(buf, "%llu\n", q->blk_trace->start_lba);
>  	else if (attr == &dev_attr_end_lba)
>  		ret = sprintf(buf, "%llu\n", q->blk_trace->end_lba);
> +	else if (attr == &dev_attr_cgroup_info)
> +		ret = sprintf(buf, "%u\n", q->blk_trace->enable_cg_info);
>  
>  out_unlock_bdev:
>  	mutex_unlock(&q->blk_trace_mutex);
> @@ -1861,6 +1869,8 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
>  			q->blk_trace->start_lba = value;
>  		else if (attr == &dev_attr_end_lba)
>  			q->blk_trace->end_lba = value;
> +		else if (attr == &dev_attr_cgroup_info)
> +			q->blk_trace->enable_cg_info = !!value;
>  	}
>  
>  out_unlock_bdev:
> 
