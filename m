Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD98280324
	for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771604179; cv=none; b=u5y0Ha3lp6UDKUwFob1PPSvVW8Sgr57JtE/el1oErtqsillyUcH92N6Z8fDwFKnBBBkCLfod+VJ+Va+5pn6ELKKQE5/U74DLTJQRT/bbM72Xiz0DzFNdfki/Nz6NBfOWBW/2+QbQALRuSIzqtNmBMh0ohub08ogqJ+OHIyalz2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771604179; c=relaxed/simple;
	bh=nlPkKixl8A9A8Bps1EBRU1uZP5XpjnfYPSfLTw/iD2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTafUaWZLyf1dA4+XIbJajd9LM/CF2CUKKYw594rv+f0RatNt0tt1DTVLX/5yiawfV9iLjBcdqZJyF6f7xsbCaPeousH944Wd9Q5OwgDvVTzmEPGMktFGO7tRqqAFMdUi//lI/O8qiklyGYh/9hhNyr9kJMP+Kfq9MGbX4tLACc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QECz7N70; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QECz7N70"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771604177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ylk2jzYFf7apWz3381lpqfqP234aYXasJAwJNNkii4M=;
	b=QECz7N70CsaMJTcOJ09+8Y1UgFznAXz6z5psi3aB8WB0Sp3xe1Gkoemojs8wtEwZb00zui
	dPAW/y6+9l7N1stB4IoLJQFJ8AKS8sOfo5kGcdgqFa2M/ECortHP1VJpUEUUiWGfAr+xst
	nTZ8V4/UemrgM466uNY3e3E1OsEKGaw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-aihcA8KYP3-aK3QYir_B6w-1; Fri,
 20 Feb 2026 11:16:14 -0500
X-MC-Unique: aihcA8KYP3-aK3QYir_B6w-1
X-Mimecast-MFC-AGG-ID: aihcA8KYP3-aK3QYir_B6w_1771604173
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 37D3B1956088;
	Fri, 20 Feb 2026 16:16:13 +0000 (UTC)
Received: from fedora (unknown [10.72.116.11])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FE191800348;
	Fri, 20 Feb 2026 16:16:09 +0000 (UTC)
Date: Sat, 21 Feb 2026 00:16:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hannes Reinecke <hare@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHv2] ublk: persistent device links
Message-ID: <aZiIxIpki1Ao5m0G@fedora>
References: <20260220150651.19309-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220150651.19309-1-hare@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Feb 20, 2026 at 04:06:51PM +0100, Hannes Reinecke wrote:
> Implement a 'uuid' parameter to export a device UUID in a sysfs
> attribute 'uuid'. The ublk server is required to set the uuid
> parameter when creating the device.
> This allows udev to create persistent device links for ublk devices
> eg with this rule:
> 
> KERNEL=="ublk*", ATTRS{uuid}=="?*", SYMLINK+="disk/by-id/ublk-$attr{uuid}"
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>  drivers/block/ublk_drv.c      | 55 +++++++++++++++++++++++++++++++++--
>  include/uapi/linux/ublk_cmd.h |  6 ++++
>  2 files changed, 59 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index aaf94d2fb789..ffbd5acda36b 100644
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
> @@ -761,6 +761,14 @@ static int ublk_validate_params(const struct ublk_device *ub)
>  			return -EINVAL;
>  	}
>  
> +	if (ub->params.types & UBLK_PARAM_TYPE_UUID) {
> +		const struct ublk_param_uuid *p = &ub->params.uuid;
> +		uuid_t uuid;
> +
> +		import_uuid(&uuid, p->uuid);
> +		if (uuid_is_null(&uuid))
> +			return -EINVAL;
> +	}
>  	return 0;
>  }
>  
> @@ -2971,6 +2979,49 @@ static int ublk_add_chdev(struct ublk_device *ub)
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
> @@ -3149,7 +3200,7 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
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

It could be more friendly for ublk server writer to document that `uuid`
parameter should be persistent, otherwise:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

