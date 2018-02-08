Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33728 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbeBHJpc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Feb 2018 04:45:32 -0500
Received: by mail-lf0-f68.google.com with SMTP id t139so5519323lff.0
        for <linux-block@vger.kernel.org>; Thu, 08 Feb 2018 01:45:31 -0800 (PST)
Subject: Re: [PATCH V2] lightnvm: pblk: add padding distribution sysfs
 attribute
To: hans.ml.holmberg@owltronix.com
Cc: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1517918090-25321-1-git-send-email-hans.ml.holmberg@owltronix.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <7baf50a9-635f-01c1-48d5-a9b77a3875f9@lightnvm.io>
Date: Thu, 8 Feb 2018 10:45:28 +0100
MIME-Version: 1.0
In-Reply-To: <1517918090-25321-1-git-send-email-hans.ml.holmberg@owltronix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/06/2018 12:54 PM, hans.ml.holmberg@owltronix.com wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> When pblk receives a sync, all data up to that point in the write buffer
> must be comitted to persistent storage, and as flash memory comes with a
> minimal write size there is a significant cost involved both in terms
> of time for completing the sync and in terms of write amplification
> padded sectors for filling up to the minimal write size.
> 
> In order to get a better understanding of the costs involved for syncs,
> Add a sysfs attribute to pblk: padded_dist, showing a normalized
> distribution of sectors padded. In order to facilitate measurements of
> specific workloads during the lifetime of the pblk instance, the
> distribution can be reset by writing 0 to the attribute.
> 
> Do this by introducing counters for each possible padding:
> {0..(minimal write size - 1)} and calculate the normalized distribution
> when showing the attribute.
> 
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> Signed-off-by: Javier González <javier@cnexlabs.com>
> Rearranged total_buckets statement in pblk_sysfs_get_padding_dist
> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
> ---
> 
> Changes since V1:
> 
> * Picked up Matias rearrengment of the total_buckets_statement
> * Fixed build problems reported by kbuild on i386 by using sector_div
>    instead of / when calculating the padding distribution and turning
>    nr_flush into atomic64_t (which makes more sense anyway)
> 
>   drivers/lightnvm/pblk-init.c  | 16 +++++++-
>   drivers/lightnvm/pblk-rb.c    | 17 +++++----
>   drivers/lightnvm/pblk-sysfs.c | 86 ++++++++++++++++++++++++++++++++++++++++++-
>   drivers/lightnvm/pblk.h       |  6 ++-
>   4 files changed, 112 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index 7eedc5d..bf9bc31 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -921,6 +921,7 @@ static void pblk_free(struct pblk *pblk)
>   {
>   	pblk_luns_free(pblk);
>   	pblk_lines_free(pblk);
> +	kfree(pblk->pad_dist);
>   	pblk_line_meta_free(pblk);
>   	pblk_core_free(pblk);
>   	pblk_l2p_free(pblk);
> @@ -998,11 +999,13 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
>   	pblk->pad_rst_wa = 0;
>   	pblk->gc_rst_wa = 0;
>   
> +	atomic64_set(&pblk->nr_flush, 0);
> +	pblk->nr_flush_rst = 0;
> +
>   #ifdef CONFIG_NVM_DEBUG
>   	atomic_long_set(&pblk->inflight_writes, 0);
>   	atomic_long_set(&pblk->padded_writes, 0);
>   	atomic_long_set(&pblk->padded_wb, 0);
> -	atomic_long_set(&pblk->nr_flush, 0);
>   	atomic_long_set(&pblk->req_writes, 0);
>   	atomic_long_set(&pblk->sub_writes, 0);
>   	atomic_long_set(&pblk->sync_writes, 0);
> @@ -1034,10 +1037,17 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
>   		goto fail_free_luns;
>   	}
>   
> +	pblk->pad_dist = kzalloc((pblk->min_write_pgs - 1) * sizeof(atomic64_t),
> +				 GFP_KERNEL);
> +	if (!pblk->pad_dist) {
> +		ret = -ENOMEM;
> +		goto fail_free_line_meta;
> +	}
> +
>   	ret = pblk_core_init(pblk);
>   	if (ret) {
>   		pr_err("pblk: could not initialize core\n");
> -		goto fail_free_line_meta;
> +		goto fail_free_pad_dist;
>   	}
>   
>   	ret = pblk_l2p_init(pblk);
> @@ -1097,6 +1107,8 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
>   	pblk_l2p_free(pblk);
>   fail_free_core:
>   	pblk_core_free(pblk);
> +fail_free_pad_dist:
> +	kfree(pblk->pad_dist);
>   fail_free_line_meta:
>   	pblk_line_meta_free(pblk);
>   fail_free_luns:
> diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
> index 7044b55..8b14340 100644
> --- a/drivers/lightnvm/pblk-rb.c
> +++ b/drivers/lightnvm/pblk-rb.c
> @@ -437,9 +437,7 @@ static int pblk_rb_may_write_flush(struct pblk_rb *rb, unsigned int nr_entries,
>   	if (bio->bi_opf & REQ_PREFLUSH) {
>   		struct pblk *pblk = container_of(rb, struct pblk, rwb);
>   
> -#ifdef CONFIG_NVM_DEBUG
> -		atomic_long_inc(&pblk->nr_flush);
> -#endif
> +		atomic64_inc(&pblk->nr_flush);
>   		if (pblk_rb_flush_point_set(&pblk->rwb, bio, mem))
>   			*io_ret = NVM_IO_OK;
>   	}
> @@ -620,14 +618,17 @@ unsigned int pblk_rb_read_to_bio(struct pblk_rb *rb, struct nvm_rq *rqd,
>   			pr_err("pblk: could not pad page in write bio\n");
>   			return NVM_IO_ERR;
>   		}
> -	}
>   
> -	atomic64_add(pad, &((struct pblk *)
> -			(container_of(rb, struct pblk, rwb)))->pad_wa);
> +		if (pad < pblk->min_write_pgs)
> +			atomic64_inc(&pblk->pad_dist[pad - 1]);
> +		else
> +			pr_warn("pblk: padding more than min. sectors\n");
> +
> +		atomic64_add(pad, &pblk->pad_wa);
> +	}
>   
>   #ifdef CONFIG_NVM_DEBUG
> -	atomic_long_add(pad, &((struct pblk *)
> -			(container_of(rb, struct pblk, rwb)))->padded_writes);
> +	atomic_long_add(pad, &pblk->padded_writes);
>   #endif
>   
>   	return NVM_IO_OK;
> diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
> index 4804bbd..1680ce0 100644
> --- a/drivers/lightnvm/pblk-sysfs.c
> +++ b/drivers/lightnvm/pblk-sysfs.c
> @@ -341,15 +341,61 @@ static ssize_t pblk_sysfs_get_write_amp_trip(struct pblk *pblk, char *page)
>   		atomic64_read(&pblk->pad_wa) - pblk->pad_rst_wa, page);
>   }
>   
> +static long long bucket_percentage(unsigned long long bucket,
> +				   unsigned long long total)
> +{
> +	int p = bucket * 100;
> +
> +	sector_div(p, total);
> +	return p;
> +}
> +
> +static ssize_t pblk_sysfs_get_padding_dist(struct pblk *pblk, char *page)
> +{
> +	int sz = 0;
> +	unsigned long long total;
> +	unsigned long long total_buckets = 0;
> +	int buckets = pblk->min_write_pgs - 1;
> +	int i;
> +
> +	total = atomic64_read(&pblk->nr_flush) - pblk->nr_flush_rst;
> +	if (!total) {
> +		for (i = 0; i < (buckets + 1); i++)
> +			sz += snprintf(page + sz, PAGE_SIZE - sz,
> +				"%d:0 ", i);
> +		sz += snprintf(page + sz, PAGE_SIZE - sz, "\n");
> +
> +		return sz;
> +	}
> +
> +	for (i = 0; i < buckets; i++)
> +		total_buckets += atomic64_read(&pblk->pad_dist[i]);
> +
> +	sz += snprintf(page + sz, PAGE_SIZE - sz, "0:%lld%% ",
> +		bucket_percentage(total - total_buckets, total));
> +
> +	for (i = 0; i < buckets; i++) {
> +		unsigned long long p;
> +
> +		p = bucket_percentage(atomic64_read(&pblk->pad_dist[i]),
> +					  total);
> +		sz += snprintf(page + sz, PAGE_SIZE - sz, "%d:%lld%% ",
> +				i + 1, p);
> +	}
> +	sz += snprintf(page + sz, PAGE_SIZE - sz, "\n");
> +
> +	return sz;
> +}
> +
>   #ifdef CONFIG_NVM_DEBUG
>   static ssize_t pblk_sysfs_stats_debug(struct pblk *pblk, char *page)
>   {
>   	return snprintf(page, PAGE_SIZE,
> -		"%lu\t%lu\t%lu\t%lu\t%lu\t%lu\t%lu\t%lu\t%lu\t%lu\t%lu\t%lu\t%lu\n",
> +		"%lu\t%lu\t%ld\t%llu\t%ld\t%lu\t%lu\t%lu\t%lu\t%lu\t%lu\t%lu\t%lu\n",
>   			atomic_long_read(&pblk->inflight_writes),
>   			atomic_long_read(&pblk->inflight_reads),
>   			atomic_long_read(&pblk->req_writes),
> -			atomic_long_read(&pblk->nr_flush),
> +			(u64)atomic64_read(&pblk->nr_flush),
>   			atomic_long_read(&pblk->padded_writes),
>   			atomic_long_read(&pblk->padded_wb),
>   			atomic_long_read(&pblk->sub_writes),
> @@ -427,6 +473,32 @@ static ssize_t pblk_sysfs_set_write_amp_trip(struct pblk *pblk,
>   }
>   
>   
> +static ssize_t pblk_sysfs_set_padding_dist(struct pblk *pblk,
> +			const char *page, size_t len)
> +{
> +	size_t c_len;
> +	int reset_value;
> +	int buckets = pblk->min_write_pgs - 1;
> +	int i;
> +
> +	c_len = strcspn(page, "\n");
> +	if (c_len >= len)
> +		return -EINVAL;
> +
> +	if (kstrtouint(page, 0, &reset_value))
> +		return -EINVAL;
> +
> +	if (reset_value !=  0)
> +		return -EINVAL;
> +
> +	for (i = 0; i < buckets; i++)
> +		atomic64_set(&pblk->pad_dist[i], 0);
> +
> +	pblk->nr_flush_rst = atomic64_read(&pblk->nr_flush);
> +
> +	return len;
> +}
> +
>   static struct attribute sys_write_luns = {
>   	.name = "write_luns",
>   	.mode = 0444,
> @@ -487,6 +559,11 @@ static struct attribute sys_write_amp_trip = {
>   	.mode = 0644,
>   };
>   
> +static struct attribute sys_padding_dist = {
> +	.name = "padding_dist",
> +	.mode = 0644,
> +};
> +
>   #ifdef CONFIG_NVM_DEBUG
>   static struct attribute sys_stats_debug_attr = {
>   	.name = "stats",
> @@ -507,6 +584,7 @@ static struct attribute *pblk_attrs[] = {
>   	&sys_lines_info_attr,
>   	&sys_write_amp_mileage,
>   	&sys_write_amp_trip,
> +	&sys_padding_dist,
>   #ifdef CONFIG_NVM_DEBUG
>   	&sys_stats_debug_attr,
>   #endif
> @@ -540,6 +618,8 @@ static ssize_t pblk_sysfs_show(struct kobject *kobj, struct attribute *attr,
>   		return pblk_sysfs_get_write_amp_mileage(pblk, buf);
>   	else if (strcmp(attr->name, "write_amp_trip") == 0)
>   		return pblk_sysfs_get_write_amp_trip(pblk, buf);
> +	else if (strcmp(attr->name, "padding_dist") == 0)
> +		return pblk_sysfs_get_padding_dist(pblk, buf);
>   #ifdef CONFIG_NVM_DEBUG
>   	else if (strcmp(attr->name, "stats") == 0)
>   		return pblk_sysfs_stats_debug(pblk, buf);
> @@ -558,6 +638,8 @@ static ssize_t pblk_sysfs_store(struct kobject *kobj, struct attribute *attr,
>   		return pblk_sysfs_set_sec_per_write(pblk, buf, len);
>   	else if (strcmp(attr->name, "write_amp_trip") == 0)
>   		return pblk_sysfs_set_write_amp_trip(pblk, buf, len);
> +	else if (strcmp(attr->name, "padding_dist") == 0)
> +		return pblk_sysfs_set_padding_dist(pblk, buf, len);
>   	return 0;
>   }
>   
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 4b7d861..17e2f24 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -626,12 +626,16 @@ struct pblk {
>   	u64 gc_rst_wa;
>   	u64 pad_rst_wa;
>   
> +	/* Counters used for calculating padding distribution */
> +	atomic64_t *pad_dist;		/* Padding distribution buckets */
> +	u64 nr_flush_rst;		/* Flushes reset value for pad dist.*/
> +	atomic64_t nr_flush;		/* Number of flush/fua I/O */
> +
>   #ifdef CONFIG_NVM_DEBUG
>   	/* Non-persistent debug counters, 4kb sector I/Os */
>   	atomic_long_t inflight_writes;	/* Inflight writes (user and gc) */
>   	atomic_long_t padded_writes;	/* Sectors padded due to flush/fua */
>   	atomic_long_t padded_wb;	/* Sectors padded in write buffer */
> -	atomic_long_t nr_flush;		/* Number of flush/fua I/O */
>   	atomic_long_t req_writes;	/* Sectors stored on write buffer */
>   	atomic_long_t sub_writes;	/* Sectors submitted from buffer */
>   	atomic_long_t sync_writes;	/* Sectors synced to media */
> 

Thanks Hans. Applied for 4.17.
