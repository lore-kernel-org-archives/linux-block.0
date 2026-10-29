Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388983;
	b=O02nn/THhST1rAsE7JAakVrvW3egjJVnijTv1V+pxALExrt9v8UPBHvojWdkACcIVjlS
	 wv7UnDLqmHt3d4Jf+JGo1RQLCCiexgF7pvIFdyvh6AHYXHN4cpf93283GkpX9gNcu3IAF
	 FiN0PnCtD1YaNhsRlwuGoQBLET/c+zUffPjypQQH5ePoJ+AuOLdpGhoJox8udFHeFI3W4
	 qibn18d5U+cwAO4bOC5VvWkB+ntoi6z4jfWYx4FaFAQg90zuxO59sl51gjbr2khKBYZhn
	 9hbHZ8ReaOrfeRccTCDDNEvlgZxCXVCxt+hWvtMq2HmBd4EF5MAfIY3wBUVfulJsNlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388983;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Scanned-By;
	bh=6ZGLcnzM25ZBbAMnXQdZDDXg7g2Des/O1G+uz9YDWng=;
	b=Ws8wAWrSk3h4D3pCl91/bh1/CCmJ0Utf+rM8eHWk1s3kpVXCvY9ANW+HKvuldUker1UW
	 2fXcA5t+FxnAlUv63qDW2ZOC+wqu+AxxfOkZGiRpRCrZoHKnCQiG1st7L4QMW3reEPtgj
	 pTq6X7rHBbqWRSipovwy8waQFDH8IOmaLJDb07ri+Ey0qO/mAZsG0GgKKbuw2VnMC1G7m
	 e7k3oh85qrWbFl1seawTVA7UgwUznYCqMG6FQ1WY/eosrsDb3yGcpEAfO3nkVncCNOhek
	 bhI9sDIuxgfrUgmVvcjyA5AI7vETKBS0lt3B47Xoc22mXImAN/sbN1ZATUlQ4TNGzCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TfmI6LJw;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AB3606A320
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 19:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6AB3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TfmI6LJw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793388981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ZGLcnzM25ZBbAMnXQdZDDXg7g2Des/O1G+uz9YDWng=;
	b=TfmI6LJwrP6WcnR1+lqiHSMqkjUP1qH0DTHiQpjS1d/+jmCYYgiV18+qzhwEORLpGZd7XG
	nlxpF7GmoSP1+CCWMPiRjft1PqtC/lqcQOrZzuIBHBxLC173TibKsgkw8WFBAGpLv7NZLs
	Pjpblgk7555kXXPOKvOLXGBNyuArDl4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-euRVEgwhOYqBjn-dl0f_dA-1; Fri,
 30 Oct 2026 15:36:20 -0400
X-MC-Unique: euRVEgwhOYqBjn-dl0f_dA-1
X-Mimecast-MFC-AGG-ID: euRVEgwhOYqBjn-dl0f_dA_1793388979
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FCE81800BDB
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 19:36:19 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 195241956088;
	Fri, 30 Oct 2026 19:36:18 +0000 (UTC)
Date: Thu, 29 Oct 2026 16:20:56 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alberto Faria <afaria@redhat.com>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] virtio_blk: add fua write support
Message-ID: <20261029202056.GB1589831@shajnocz.csb>
References: <20261021055235.648957-1-afaria@redhat.com>
 <20261021055235.648957-2-afaria@redhat.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021055235.648957-2-afaria@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Oct 21, 2026 at 06:52:33AM +0100, Alberto Faria wrote:
> Add the new virtio-blk request FUA flag uapi definitions and
> corresponding virtio-blk support.
> 
> Signed-off-by: Alberto Faria <afaria@redhat.com>
> ---
>  drivers/block/virtio_blk.c      | 15 +++++++++++++--
>  include/uapi/linux/virtio_blk.h | 13 +++++++++++--
>  2 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index c8bfbf8435ac7..f2ef0fdba181d 100644
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
> @@ -258,6 +261,9 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
>  	case REQ_OP_WRITE:
>  		type = VIRTIO_BLK_T_OUT;
>  		sector = blk_rq_pos(req);
> +		if (req->cmd_flags & REQ_FUA)

This does not check virtio_has_feature(vdev,
VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA). I'm not confident that REQ_FUA only
reaches here when supported. For example, dm-mpath might send it when
some paths do support FUA but the virtio_blk path does not.

> +			vbr->out_hdr.flags |= cpu_to_virtio32(vdev,
> +				BIT(VIRTIO_BLK_REQ_FLAG_OUT_FUA));
>  		break;
>  	case REQ_OP_FLUSH:
>  		type = VIRTIO_BLK_T_FLUSH;

Please check the situation with REQ_OP_ZONE_APPEND. We ignore the
REQ_FUA bit and that would be dangerous. Perhaps don't report FUA
support on zoned devices?

> @@ -1508,6 +1514,10 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	if (virtblk_get_cache_mode(vdev))
>  		lim.features |= BLK_FEAT_WRITE_CACHE;

Speaking of cache mode, cache_type_store() ->
queue_limits_commit_update_frozen() ->
queue_limits_commit_update() -> blk_validate_limits() can clear
BLK_FEAT_FUA:

  if (!(lim->features & BLK_FEAT_WRITE_CACHE))
      lim->features &= ~BLK_FEAT_FUA;

So cache_type_store() needs to restore BLK_FEAT_FUA when
BLK_FEAT_WRITE_CACHE is enabled again (provided the device supports
FUA).

>  
> +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS) &&
> +	    virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA))
> +		lim.features |= BLK_FEAT_FUA;
> +
>  	vblk->disk = blk_mq_alloc_disk(&vblk->tag_set, &lim, vblk);
>  	if (IS_ERR(vblk->disk)) {
>  		err = PTR_ERR(vblk->disk);
> @@ -1672,7 +1682,8 @@ static unsigned int features[] = {
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
> -- 
> 2.56.0
> 

