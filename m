Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E6D2D8375
	for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771587356; cv=none; b=Z0hUUJyO68i+fYP6Xv9u3Leko4Sw9JMZZdJ0/TwDUaqaq7ZRHAH2pIUxtrG5AK3ZwYbf5OaT/7R7jiYrjgIeCuW8n2OylxyykXdiGAOlWfZTyrU4X7opq073zNdDNF3XAhnpiq1UsMhxJ3fp1/g8NrZeLJ2iAyWjDpvGWGYFL24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771587356; c=relaxed/simple;
	bh=2OoGpJ5Mywexi3BTt5E+ogbs4577B+O63xQ7OeKCEwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Se4Q8cwdqxgTvY4Fy9HauwSN3tZ9nopHJqLc/BrIr7VbY2LnyeJ3K5lWJWfKAmAKLnUrMqz819q4pb+rvUjJa1yxjyNdJOF7lhBrHBeYt8OSobUFriznnAO4pvT/w4bv7OvkvUNl4c32HxwsSD6xP7yWoIb5d/pYb1FlhA2y8GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=geMVNDIh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="geMVNDIh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771587353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WBLjTwFOuvMYqr5FtLunJpnAPsrf9ld2OSiOfvJCaJ4=;
	b=geMVNDIh1I+qYp03+QwbidHmoud4lFvbh8IwPXD/EqaAnuh9/7MADkiI58lrQzsdjO1RmO
	9iaI2AFVl/KgpyvRRwrMqu65YkpaVa6G7Cftq9QjIaj2RKVlmtppfA5iYhKHvXTy0LhSnR
	NmjOEq1w5HlsZMYWjIF96QlTgK0CGTU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-11eGQDexNP-d7MBgxcZyFg-1; Fri,
 20 Feb 2026 06:35:49 -0500
X-MC-Unique: 11eGQDexNP-d7MBgxcZyFg-1
X-Mimecast-MFC-AGG-ID: 11eGQDexNP-d7MBgxcZyFg_1771587348
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 168D31956059;
	Fri, 20 Feb 2026 11:35:48 +0000 (UTC)
Received: from fedora (unknown [10.72.116.11])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C22F5180058A;
	Fri, 20 Feb 2026 11:35:44 +0000 (UTC)
Date: Fri, 20 Feb 2026 19:35:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hannes Reinecke <hare@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] ublk: persistent device links
Message-ID: <aZhHC-mVNOeroiBS@fedora>
References: <20260216122730.144092-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216122730.144092-1-hare@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Feb 16, 2026 at 01:27:30PM +0100, Hannes Reinecke wrote:
> Implement a 'uuid' parameter to export a device UUID in a sysfs
> attribute 'uuid'. This allows udev to create persistent device
> links for ublk devices:
> 
> KERNEL=="ublkb*", ATTRS{uuid}=="?*", SYMLINK+="disk/by-id/ublk-$attr{uuid}"
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>  drivers/block/ublk_drv.c      | 57 +++++++++++++++++++++++++++++++++--
>  include/uapi/linux/ublk_cmd.h |  6 ++++
>  2 files changed, 61 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index aaf94d2fb789..859414065be0 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -89,7 +89,7 @@
>  	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
>  	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
>  	 UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT | \
> -	 UBLK_PARAM_TYPE_INTEGRITY)
> +	 UBLK_PARAM_TYPE_INTEGRITY | UBLK_PARAM_TYPE_UUID)
>  
>  struct ublk_uring_cmd_pdu {
>  	/*
> @@ -761,6 +761,16 @@ static int ublk_validate_params(const struct ublk_device *ub)
>  			return -EINVAL;
>  	}
>  
> +	if (ub->params.types & UBLK_PARAM_TYPE_UUID) {
> +		const struct ublk_param_uuid *p = &ub->params.uuid;
> +		uuid_t uuid;
> +
> +		import_uuid(&uuid, p->uuid);
> +		if (uuid_is_null(&uuid)) {
> +			printk("uuid is NULL\n");

pr_warn() could be better.

> +			return -EINVAL;
> +		}
> +	}
>  	return 0;
>  }
>  
> @@ -2971,6 +2981,49 @@ static int ublk_add_chdev(struct ublk_device *ub)
>  	return ret;
>  }
>  
> +static ssize_t uuid_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct gendisk *disk = dev_to_disk(dev);
> +	struct ublk_device *ub = disk->private_data;
> +	const struct ublk_param_uuid *p = &ub->params.uuid;
> +	uuid_t uuid;
> +
> +	import_uuid(&uuid, p->uuid);
> +	return sprintf(buf, "%pU\n", &uuid);
> +}
> +
> +static DEVICE_ATTR_RO(uuid);
> +
> +static struct attribute *ublk_attrs[] = {
> +	&dev_attr_uuid.attr,
> +	NULL,
> +};
> +
> +static umode_t ublk_attrs_are_visible(struct kobject *kobj,
> +		struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct gendisk *disk = dev_to_disk(dev);
> +	struct ublk_device *ub = disk->private_data;
> +
> +	if (a == &dev_attr_uuid.attr &&
> +	    (ub->params.types & UBLK_PARAM_TYPE_UUID))
> +		return S_IRUGO;
> +
> +	return a->mode;
> +}
> +
> +static const struct attribute_group ublk_attr_group = {
> +	.attrs = ublk_attrs,
> +	.is_visible = ublk_attrs_are_visible,
> +};
> +
> +static const struct attribute_group *ublk_attr_groups[] = {
> +	&ublk_attr_group,
> +	NULL,
> +};
> +
>  /* align max io buffer size with PAGE_SIZE */
>  static void ublk_align_max_io_size(struct ublk_device *ub)
>  {
> @@ -3149,7 +3202,7 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
>  			goto out_put_cdev;
>  	}
>  
> -	ret = add_disk(disk);
> +	ret = device_add_disk(NULL, disk, ublk_attr_groups);
>  	if (ret)
>  		goto out_put_cdev;
>  
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> index 90f47da4f435..b30a0de44b85 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -630,6 +630,10 @@ struct ublk_param_integrity {
>  	__u8	pad[5];
>  };
>  
> +struct ublk_param_uuid {
> +	__u8	uuid[16];
> +};
> +
>  struct ublk_params {
>  	/*
>  	 * Total length of parameters, userspace has to set 'len' for both
> @@ -645,6 +649,7 @@ struct ublk_params {
>  #define UBLK_PARAM_TYPE_DMA_ALIGN       (1 << 4)
>  #define UBLK_PARAM_TYPE_SEGMENT         (1 << 5)
>  #define UBLK_PARAM_TYPE_INTEGRITY       (1 << 6) /* requires UBLK_F_INTEGRITY */
> +#define UBLK_PARAM_TYPE_UUID            (1 << 7)
>  	__u32	types;			/* types of parameter included */
>  
>  	struct ublk_param_basic		basic;
> @@ -654,6 +659,7 @@ struct ublk_params {
>  	struct ublk_param_dma_align	dma;
>  	struct ublk_param_segment	seg;
>  	struct ublk_param_integrity	integrity;
> +	struct ublk_param_uuid		uuid;

Please document ublk server should provide persistent uuid for persistent
id or link.

Otherwise, this patch looks fine.


Thanks,
Ming

