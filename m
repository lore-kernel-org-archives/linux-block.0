Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597757;
	b=LkyhhrXXmWfudKCBivmIt5Jz9DWAhgnN+mI97qugbmjMSgL7B09lUcxX2ek6TV3PetZz
	 /Sx8NcklX4j8P5ijR2Waq4A4uBs9931I3WosCVYIoqtPp2uh6kG7VDs+vfPziQTV8Msi1
	 N5nBFkAz/XlXmke6mVBjQL3t4L84UkIiWs/+EsAgTn6oZ4RWa6ctdnab0yGhsbKqWcbrr
	 1ZsWzXF2Mhf/rpJOp29c8m6aR07pzuQkR57eQa3uuDsXq2vJBjWdFjhH8XJFQrQTFmKWm
	 L5D6IMF8B5X4FvEWRUhkm75fAYzCu5FKC6maXlqz/S/t7R9t5rzg1tyS1OYI3SZZsIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597757;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=vt+EhBcZZWmdLvvCDDQxXdt+x1JKxTJJeVjjo8w0SQY=;
	b=1hCB+PQac4UKmVwqzLWCE5MiLCYwZwGqz2uUFdlpAWYCjCSssghEUd9/ua0XQNNrNez6
	 Cii3KfrA5yboTyCSXRffMJFrF0ZniE8Iy2CjkK1555c6Cv2FPRWLlyp+NSZMPL3EJPrlB
	 Ev8yQpfBy2DkwhZZKaVW8vmoY3GelNWsGJi+Th10sjKM7hYFKfWh+uRIiISYeIem1jmwf
	 LPr5bcR8nCGuQBbIPdHYLl+7TTrYSkxk7dKVc4RPqRNyGNFBia/++FyBTD645xO7+Q2m/
	 ChlrzDHaJV1bP0imoHWZ3eOmZX93fmnDaFcIhRfaBzZa53a+rkC5ytbjocpNAEffmQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U4ohL1Mo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB6D606A32E;
	Wed, 25 Nov 2026 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U4ohL1Mo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FA91F000CA;
	Wed, 25 Nov 2026 09:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795597756;
	bh=vt+EhBcZZWmdLvvCDDQxXdt+x1JKxTJJeVjjo8w0SQY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=U4ohL1MoCwf/mUMK44EMt6WtVaZ3YkM38HV+QAE+i0sC8sqwrCUS+08Gq/OdlKSyy
	 chbyQ5/rdMxKL4cWo5zaLrlZDJ7iy7/EG917JBRcPL8vRuc34EuquSue04doeKK3jD
	 jRevyzrv1kxTZEvPUfN3ZEaUztY49Pexi+IusSPfCmlcGGwq7kYVcGs1rD/MfrhfCs
	 WOkGeu7pxhP20u+6eTJHAzZExkELZWmcQY6a4WRgowtoPF8/63789TItYLaVUmw8DH
	 Gu+l/oFVKWUT0xG4Pr+rFux5kD2MCyqjIrQwf0WIWd8SWGkNunfIfvuRwqbOncnUPI
	 dvlhjrqB8ayXg==
Message-ID: <b274eaac-4bf3-4d6e-8451-461c02c1fad7@kernel.org>
Date: Wed, 25 Nov 2026 18:09:13 +0900
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] virtio_blk: add fua write support
To: Alberto Faria <afaria@redhat.com>, linux-block@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowangio@gmail.com>
References: <20261125083947.263216-1-afaria@redhat.com>
 <20261125083947.263216-2-afaria@redhat.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261125083947.263216-2-afaria@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/11/25 17:39, Alberto Faria wrote:
> Add the new virtio-blk request FUA flag uapi definitions and
> corresponding virtio-blk support.
> 
> Signed-off-by: Alberto Faria <afaria@redhat.com>
> ---
>  drivers/block/virtio_blk.c      | 29 +++++++++++++++++++++++++++--
>  include/uapi/linux/virtio_blk.h | 13 +++++++++++--
>  2 files changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 2b462005cdb68..7ee2e6a6a591b 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -248,7 +248,10 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
>  		return BLK_STS_NOTSUPP;
>  
>  	/* Set fields for all request types */
> -	vbr->out_hdr.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
> +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS))
> +		vbr->out_hdr.flags = 0;
> +	else
> +		vbr->out_hdr.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
>  
>  	switch (req_op(req)) {
>  	case REQ_OP_READ:
> @@ -258,6 +261,11 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
>  	case REQ_OP_WRITE:
>  		type = VIRTIO_BLK_T_OUT;
>  		sector = blk_rq_pos(req);
> +		if ((req->cmd_flags & REQ_FUA) &&
> +		    virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS) &&
> +		    virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA))
> +			vbr->out_hdr.flags |= cpu_to_virtio32(vdev,
> +				BIT(VIRTIO_BLK_REQ_FLAG_OUT_FUA));
>  		break;
>  	case REQ_OP_FLUSH:
>  		type = VIRTIO_BLK_T_FLUSH;
> @@ -1151,10 +1159,17 @@ cache_type_store(struct device *dev, struct device_attribute *attr,
>  	virtio_cwrite8(vdev, offsetof(struct virtio_blk_config, wce), i);
>  
>  	lim = queue_limits_start_update(disk->queue);
> +

White line change.

>  	if (virtblk_get_cache_mode(vdev))
>  		lim.features |= BLK_FEAT_WRITE_CACHE;
>  	else
>  		lim.features &= ~BLK_FEAT_WRITE_CACHE;
> +
> +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS) &&
> +	    virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA) &&
> +	    !(lim.features & BLK_FEAT_ZONED))
> +		lim.features |= BLK_FEAT_FUA;
> +
>  	i = queue_limits_commit_update_frozen(disk->queue, &lim);
>  	if (i)
>  		return i;
> @@ -1575,6 +1590,15 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	if (virtblk_get_cache_mode(vdev))
>  		lim.features |= BLK_FEAT_WRITE_CACHE;
>  
> +	/*
> +	 * Do not advertise FUA when the device is zoned, since we
> +	 * would not be able to handle it on REQ_OP_ZONE_APPEND.
> +	 */

Why is that? I do not see any reason for this.

> +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS) &&
> +	    virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA) &&
> +	    !(lim.features & BLK_FEAT_ZONED))
> +		lim.features |= BLK_FEAT_FUA;
> +
>  	vblk->disk = blk_mq_alloc_disk(&vblk->tag_set, &lim, vblk);
>  	if (IS_ERR(vblk->disk)) {
>  		err = PTR_ERR(vblk->disk);
> @@ -1740,7 +1764,8 @@ static unsigned int features[] = {
>  	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>  	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
> -	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_ZONED,
> +	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_ZONED, VIRTIO_BLK_F_REQ_FLAGS,
> +	VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA,
>  };
>  
>  static struct virtio_driver virtio_blk = {
> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> index 3744e4da1b2a7..c5047e6a9a9bc 100644
> --- a/include/uapi/linux/virtio_blk.h
> +++ b/include/uapi/linux/virtio_blk.h
> @@ -42,6 +42,8 @@
>  #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
>  #define VIRTIO_BLK_F_SECURE_ERASE	16 /* Secure Erase is supported */
>  #define VIRTIO_BLK_F_ZONED		17	/* Zoned block device */
> +#define VIRTIO_BLK_F_REQ_FLAGS		18	/* Request flags supported */
> +#define VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA	19	/* FUA flag supported */
>  
>  /* Legacy feature bits */
>  #ifndef VIRTIO_BLK_NO_LEGACY
> @@ -211,6 +213,9 @@ struct virtio_blk_config {
>  #define VIRTIO_BLK_T_BARRIER	0x80000000
>  #endif /* !VIRTIO_BLK_NO_LEGACY */
>  
> +/* Request flag bits */
> +#define VIRTIO_BLK_REQ_FLAG_OUT_FUA	0
> +
>  /*
>   * This comes first in the read scatter-gather list.
>   * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated,
> @@ -219,8 +224,12 @@ struct virtio_blk_config {
>  struct virtio_blk_outhdr {
>  	/* VIRTIO_BLK_T* */
>  	__virtio32 type;
> -	/* io priority. */
> -	__virtio32 ioprio;
> +	union {
> +		/* io priority. */
> +		__virtio32 ioprio;
> +		/* Request flags. */
> +		__virtio32 flags;
> +	};
>  	/* Sector (ie. 512 byte offset) */
>  	__virtio64 sector;
>  };


-- 
Damien Le Moal
Western Digital Research
