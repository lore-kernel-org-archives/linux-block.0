Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793128773;
	b=fRig4fWvbk3gKeeE+DmFpcCl02e2LozvbLw4NHhx/lfJzKJ58E/9zdKt6EgRadPdjAf9
	 zJx/8BahnkteOdYvJb9DPWmDHDnEZiSXjG6QklJ/+queU4qSCbmNvwSmyZjUepRInbZwZ
	 7t1R0UWIHpwxC5vLKsv0fUcWJwjq0p7bJ0xJV9OHapVS/VXvssxHB8e5qgK3AM7EC63fW
	 7Axlg1kS6JrJ83mWDUy81dor4PCJfnAsb3y3ladxnnjg/U49j87EqI+AH+CS0WuyymLq3
	 xRbdJmvlb5XGabLyTy4OsItqRpR8a0EfubAxrpKhaDeIWad/AE0ZrQMfG20sSHVHWiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128773;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NDq5khxQ+WqrT0Z/KGYDQfM27UlUOaUjQhhNJn0MrTg=;
	b=5dDYIdwwjF9BxDNJp9AxgrQV/QGhUxbxHJ4zaHHdaGx59Q+h2vA8Md8WGMKeoLKmZcNY
	 64lLxDTk03bhezJxUah84Gvkiy1jszY60eVPhXM3wqFPSkppxoiItEnG9MaQuqumt1DJM
	 lKZnHSA8RAVu0XyJKDguEYJ3BLb314NQk7hXr/TZfwOyJ7Ijn2Mrvo+rKWe2FzAo4Z85V
	 9Koxtof7XJNuN/WuLgs1Cq/Tyr5G+yPe00RxgMFwDMBPqjB4fcTpAkAPN1pqrjnK62ilV
	 8TCUwt525CA95UleGm1b7s75wF0QRkIytZhYlGAz6nzE9/ogwYFEoITmUllIfm/Z7Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f7MQKa0J;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pq89LmmQ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD82606A32A
	for <linux-block@vger.kernel.org>; Tue, 27 Oct 2026 19:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBD82606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f7MQKa0J;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pq89LmmQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793128772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NDq5khxQ+WqrT0Z/KGYDQfM27UlUOaUjQhhNJn0MrTg=;
	b=f7MQKa0JHYHbgsGlkPi/0wBouqQqMo6xrx0VTqPjnnq6R32tak+djejWRfTHJLjT8DBYZN
	QchHIKw/t53z7I2Vsc78vsY5hazCeKg+2OE/Ocq0iV5t828zf8sIA+meQpR0I8xaMGu25V
	4QM4pX3LO0Rdorqp9c2yL01lQxTuq80=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-LPLb1JFHPzqqT-gwhOI7yg-1; Tue, 27 Oct 2026 15:19:28 -0400
X-MC-Unique: LPLb1JFHPzqqT-gwhOI7yg-1
X-Mimecast-MFC-AGG-ID: LPLb1JFHPzqqT-gwhOI7yg_1793128767
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48dfa054f26so109926f8f.2
        for <linux-block@vger.kernel.org>; Tue, 27 Oct 2026 12:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793128767; x=1793733567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NDq5khxQ+WqrT0Z/KGYDQfM27UlUOaUjQhhNJn0MrTg=;
        b=pq89LmmQfTm76birDQGsUnlKrrrSm440ZfSV5tzfzPWom8IMOdy+1K8zA8TPRNeJd8
         txUfDwhBTCh6p7CooGKyEzdzQ3HDfr4CjGK7sWz5nnEgHX5u7NNryn2n4cSOUFwajVrA
         LpF6nNt/SgcubSbNPkPFB1ytQvpho9XoUe0G4j1vUbrfsQvkUTO7Z+lRN8FxaS4UZEF5
         hNmX2Hk0ksE1t/AZSpVdD4ADHwSDzTOCGjKPvuLgEJx1s2bkY54g1J20rrRZTSu+QCDr
         hiKmN69t8ZP/SIdxVLPdfYNXLn30zT8PK+6URY5kzkrcZQg7iZWioYZRtHp0tWZANmoR
         +lqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793128767; x=1793733567;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NDq5khxQ+WqrT0Z/KGYDQfM27UlUOaUjQhhNJn0MrTg=;
        b=InSHEWrwdWEYtQm7C87PSVyOZrTKum0m+0ONrJXNNyngS+cxCB0HpzFDI9kOmSbcQH
         mZMkFCfpYcJE4y1qpDsPiQLXCLnR+ey2P864DqUv9wts5clF2kZ+rwZq5mm1ymCzJv/7
         NPC4qJ0OT8EKsf+WuBJmNCZiM3kD7y0qBQTURPufcF8FDV62BKpZRQGC3xNLVfnhflbT
         2s0/ab0Ir+j47j5ETR3Qr+ZdqD1Lp4gn4HsOm3bFTeYN6cpmlb1FFrxxO2lPidorzY+k
         9Fi6gr/7/mfTkBTvbohU8LzDMfy6npq3D7RSfOoa61GmJujW5At+jvMoUxWwZ4etLrwc
         RCow==
X-Forwarded-Encrypted: i=1; AKwUvBzKfmnoFDu0AnhFF8VSOMH6SqoTQivCn90rizmLZo/l/G801L5wuNqadO/wH6+abcdXXCtbRTXmJa0Q0w==@vger.kernel.org
X-Gm-Message-State: AFq9FYLh+SkGSgsbqmQnuB2wySRwZ15ynQoLYOSoSCR1ef5UxP44AW+P
	s0M/QpxmnNFGBq/Ea/NoZ4yxDZWtZZsGw+AxeEyXVwOOqwqMU4YKiLXn1eGXMaaCLoaHbPxs0oP
	II9cTLFaF8QL0Uuws6TzkEkDwupAPZI8mByBRSxQAqvDMJhlMEeUW6eefnT0cDE3W
X-Gm-Gg: AYBFou1kq/tGycZlKG2Y+7YUT+dCO+Ftsw7NlXWeKjKrAa4BBUxwpxiOoOFPsyM3ebq
	xU9Lkf+t0AjYw9zmi3CK6mdWy17QJdf204xmT3wti8x0CvWRcNxYI0tDJ7TzuGVu8xms5gj+9z0
	mapJYxCCEjy0fLry78Z8+FS8Z9GObObj+1CDa6L1SeBaMIhWvKzaSSltwKv70lnrk898fTvXdyK
	8PMR+udf4YwdJAmGsaDlv5borEJMjLWNO3UdhSUzupltItowHltLB9IjSp4O5outykpVRJdaM7h
	bK5jNq6lorfegTWnh+ucNQI1DIsb763TE96M/+RByAmJQFyvZ10/u/t3RCRC7uy/tno=
X-Received: by 2002:a05:6000:1a8f:b0:48d:ee35:b3fe with SMTP id ffacd0b85a97d-48e5d45a495mr870580f8f.8.1793128767426;
        Tue, 27 Oct 2026 12:19:27 -0700 (PDT)
X-Received: by 2002:a05:6000:1a8f:b0:48d:ee35:b3fe with SMTP id ffacd0b85a97d-48e5d45a495mr870532f8f.8.1793128766789;
        Tue, 27 Oct 2026 12:19:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e4806e208sm19045689f8f.40.2026.10.27.12.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:19:25 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:19:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: shao.mingyin@zte.com.cn
Cc: jasowangio@gmail.com, virtualization@lists.linux.dev,
	pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com,
	hch@lst.de, dlemoal@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: Fix zone append sector reporting in batched
 completion
Message-ID: <20261027151917-mutt-send-email-mst@kernel.org>
References: <202610261955196384aSLGuy3_0MiTvlYXVdiC@zte.com.cn>
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
In-Reply-To: <202610261955196384aSLGuy3_0MiTvlYXVdiC@zte.com.cn>

On Mon, Oct 26, 2026 at 07:55:19PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> For zone append, the block layer copies req->__sector back into the
> bio in blk_zone_append_update_request_bio(), so the driver must update
> req->__sector with the sector reported by the device.
> virtblk_request_done() does that, but the batched completion path used
> by virtblk_poll() only unmaps and cleans up the requests before calling
> blk_mq_end_request_batch().
> 
> A zone append completed through polling therefore keeps the sector that
> was assigned at submission time, and the file system or application sees
> the wrong LBA for the written data.
> 
> Move the sector update into a helper and call it from both completion
> paths.
> 
> Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index c8bfbf8435ac..cc29b8238a4d 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -331,18 +331,25 @@ static inline u8 virtblk_vbr_status(struct virtblk_req *vbr)
>  	return *((u8 *)&vbr->in_hdr + vbr->in_hdr_len - 1);
>  }
> 
> +static inline void virtblk_update_zone_append_sector(struct request *req,
> +						     struct virtblk_req *vbr)
> +{
> +	struct virtio_blk *vblk = req->mq_hctx->queue->queuedata;
> +
> +	if (req_op(req) == REQ_OP_ZONE_APPEND)
> +		req->__sector = virtio64_to_cpu(vblk->vdev,
> +						vbr->in_hdr.zone_append.sector);
> +}
> +
>  static inline void virtblk_request_done(struct request *req)
>  {
>  	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
>  	blk_status_t status = virtblk_result(virtblk_vbr_status(vbr));
> -	struct virtio_blk *vblk = req->mq_hctx->queue->queuedata;
> 
>  	virtblk_unmap_data(req, vbr);
>  	virtblk_cleanup_cmd(req);
> 
> -	if (req_op(req) == REQ_OP_ZONE_APPEND)
> -		req->__sector = virtio64_to_cpu(vblk->vdev,
> -						vbr->in_hdr.zone_append.sector);
> +	virtblk_update_zone_append_sector(req, vbr);
> 
>  	blk_mq_end_request(req, status);
>  }
> @@ -1196,8 +1203,11 @@ static void virtblk_complete_batch(struct io_comp_batch *iob)
>  	struct request *req;
> 
>  	rq_list_for_each(&iob->req_list, req) {
> -		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
> +		struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
> +
> +		virtblk_unmap_data(req, vbr);
>  		virtblk_cleanup_cmd(req);
> +		virtblk_update_zone_append_sector(req, vbr);
>  	}
>  	blk_mq_end_request_batch(iob);
>  }

