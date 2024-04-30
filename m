Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08686127B68
	for <linux-block@vger.kernel.org>; Tue, 30 Apr 2024 09:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468533; cv=none; b=C9rkzh+Kn+NjZ0Am8NeMQiwynN5gtN+lTYjZfkwR4VZbhhCVfqR2P1XPSWeF9DIzXBQjEG/jNCWqUfqIey3B9//+Holnnv9ud2h0VyjmIOKjqeMN43tgOCdewysYHM+hvhF2nO1qelyzBThGTboMZaZG8hP/taED5YCPwYC5814=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468533; c=relaxed/simple;
	bh=PX2wYevPnDUylS+Wdktp8ntMAkOcqK4fc5FvoLy0B3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5ubxbUYNedMqsUJMYkNYYJeGF+GIW8Acn1+DSATZsema3T4T4/0pwdVGGIWeDWGvcjUFs8XHX7ZfWgSJQB6Ir5RX/2WQm33wSG8XTbPxBBzoP3xbyhmVoe5tifuBE/Hg3rVBS34lvOJzgukSpYYqlLlu7ZRXH3un6aPXF13YmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PDCMq3XP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDCMq3XP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714468529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GXnXlyNzboKrOaRTNtaRaGUuv72Dl+qdD7j3EITxL2E=;
	b=PDCMq3XPl0jZOXn4Ymoy+US8nLakYq70QGkxxJHX/GJViO6+bvo7iih5FH2aI+0/w3zw4u
	vJhxKmqJN1APoN22VWQTKXaODym+JP6jUk7UoXW1sDpgruNqoo0nWslntnwVJO13HyGJm1
	MBw7ZYPjJJrHouvqIdOh+dlxJ/S5rSc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-cLJSgwe2NkqpBaGDc5ZjyQ-1; Tue, 30 Apr 2024 05:15:25 -0400
X-MC-Unique: cLJSgwe2NkqpBaGDc5ZjyQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 595AB88E924;
	Tue, 30 Apr 2024 09:15:25 +0000 (UTC)
Received: from fedora (unknown [10.72.116.42])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F5BD202450F;
	Tue, 30 Apr 2024 09:15:22 +0000 (UTC)
Date: Tue, 30 Apr 2024 17:15:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Riley Thomasson <riley@purestorage.com>
Subject: Re: [PATCH] ublk: remove segment count and size limits
Message-ID: <ZjC2phkIYPeUdN2S@fedora>
References: <20240430005330.2786014-1-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430005330.2786014-1-ushankar@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Mon, Apr 29, 2024 at 06:53:31PM -0600, Uday Shankar wrote:
> ublk_drv currently creates block devices with the default max_segments
> and max_segment_size limits of BLK_MAX_SEGMENTS (128) and
> BLK_MAX_SEGMENT_SIZE (65536) respectively. These defaults can
> artificially constrain the I/O size seen by the ublk server - for
> example, suppose that the ublk server has configured itself to accept
> I/Os up to 1M and the application is also issuing 1M sized I/Os. If the
> I/O buffer used by the application is backed by 4K pages, the buffer
> could consist of up to 1M / 4K = 256 physically discontiguous segments
> (even if the buffer is virtually contiguous). As such, the I/O could
> exceed the default max_segments limit and get split. This can cause
> unnecessary performance issues if the ublk server is optimized to handle
> 1M I/Os. The block layer's segment count/size limits exist to model
> hardware constraints which don't exist in ublk_drv's case, so just
> remove those limits for the block devices created by ublk_drv.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> Reviewed-by: Riley Thomasson <riley@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index bea3d5cf8a83..835b0cc7c032 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2209,6 +2209,9 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
>  		lim.max_zone_append_sectors = p->max_zone_append_sectors;
>  	}
>  
> +	lim.max_segments = USHRT_MAX;
> +	lim.max_segment_size = UINT_MAX;

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

