Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB82495539
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020505; cv=none; b=IPohfj9PJ4j7vCgxeCZws0v8YolJjKs/3o+xvATl23xiRZ4SJy6WsPuPjNRuS+nr5sOhGC5tS+1lkDjtVBMt9S/SpS+bK4velzo0xTEz189c8P7iE6TWbQ90dYB8IxIhhGISklBCJsaL3TyRa7qhTXeiySEnkZIhyAwtGd1sJds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020505; c=relaxed/simple;
	bh=vh4wTHSupJWsPBBHRt4byAg9tmu3n/JJ3JkBimEoRGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8NlNr125WMuRIDSRkXSQ63/NHhIqfLhOOSerLkcxHFvDw+eczh3GpP++ZXowp0vAwB8DIuIsB8kO3sGzDxGDMdurVQO0uGROdjCxHB+nCbgChjPQjYJPDYBGXwfddlA8mkQVu72IptSfEJqJRulMaG3rj0zTbOuQMYMCkcuCeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cqZ1+/TW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tCBrKI2U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqZ1+/TW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tCBrKI2U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781020502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sFekO1yhKAjnCNx4nQmykHHEMqovGJRsN7iwpZ8ZFPs=;
	b=cqZ1+/TWvCjTnb4dpoOo1sYbWZzJ3k6pNZSw6gQP5+JlAE/L4eH8zdN6hNWfPs92EqfGog
	TlQyn3UHX7IhV90+a+hWjDplVEuHZlVUhOk717oF8B54ZnDOcAKfzKkSUKKq0yzJUGxkIJ
	uCI4vrSv1gNDWg2E4iqxYqvwz8/Rf7s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-WwBndwQGNiCgx5fpzMjMPA-1; Tue, 09 Jun 2026 11:55:00 -0400
X-MC-Unique: WwBndwQGNiCgx5fpzMjMPA-1
X-Mimecast-MFC-AGG-ID: WwBndwQGNiCgx5fpzMjMPA_1781020500
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45efa12a788so3981484f8f.2
        for <linux-block@vger.kernel.org>; Tue, 09 Jun 2026 08:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781020500; x=1781625300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sFekO1yhKAjnCNx4nQmykHHEMqovGJRsN7iwpZ8ZFPs=;
        b=tCBrKI2UNRqFwLVXeDZ7khxiDvArEYriYs8HnzuqRLVVt2rVZ42gCwRCzdv4DHdg9r
         0xi9VfxVFYyLqxjs56LZyRDOvSmy7cNmKzizUWRMzlBTrc+zYDBJC4rNE2KIRVqpXnc8
         1S6wFs2LUiav/cE7XO4cbrVOE9YeW8JTp/LyFu0Ld+OAURsqNrr0rapS2yJ+h7JFcpqT
         vooDCkTN6uFuPuFA4j2UGhHt0sunZSujVbvsQ6oQwycnD+LrW+XKLQTlBelggo//X1WP
         JJmIRuCEJszlxNzf6IFM3cy1UbKx8X+l2Qx0x+NYmMh+9tgjnKpBrfFvm6If7YTtjD1C
         lhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781020500; x=1781625300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFekO1yhKAjnCNx4nQmykHHEMqovGJRsN7iwpZ8ZFPs=;
        b=TquTXJSnE86+uzZ2MuCT0ttwI5idjQxGewonX6Z0APUSC2FIb/vr5AMeeX3nYEsyW7
         j1Te4n0hegqdQbg4hHoyUGkHXdi3av8n36u65vlQVP8E+YW4ti7GsDjbqfq1dOY0MnXr
         M4/+ej9WcUSwRfwz184sUKOGVXiqAfQPz/BdboKYuj2m9SaktX5jtb8u/Lb85fxjBBbT
         jDdvHfbsKmOPVNmYKbyJoUP7HqV1WKocc7sobpFc4BG5vHbw2PDP8uRsm8OSdp/2x3Zb
         rfSexzHhDnVF7WZlMKDM4DvzBATaatJvHFzmw1hRrCfw3r4fxI4s0DTyzpLuekw1aqWi
         aXpQ==
X-Forwarded-Encrypted: i=1; AFNElJ8obPdfHzXsX1N5zjT9qfhMoQy+YLked5XG82xdELiOLCzz/BF+Z0yx3Xmv9TnhB/wDvD2XWQyG6fMHzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtdnkEzPEMPHRzWjNYQDH0c2aFkK8COXaA2jFDL5jPG5NQi2Nh
	bOnhSduHJC1Wt9afa7sXeQYaCFnrkGa/x3tXN6RU7Vs6phaCaSGuFyrndyZ4DIjwsItwJ8DgsSY
	G/FbkpJ7H54nHUkxfg8ozIMUs+DKTxnO0GhVVABhIJt9KOmAIJkTBYmoOB0BnSngF
X-Gm-Gg: Acq92OGVZm+0K8jsL/XMyMXIr8s7gJm6DrpXV0YQ1fHPAZG57SvD8yugH8DkexFu7Dt
	puroBCebEYkkp4nFRR8PAjruLAq6/OV/u1ffKm5WpAC1gG+fgqALaiJhxS+mNA5d+gB0YY9MdTb
	c1QuKd96XzPyOowQaA19hsHMr9BAJEcbk+X/l8JxNYqXNjhkgGxJG28n0V2FgClNuQLg2WTw/qW
	Cz9JigCA8DMX7SmegZN9Lx6kf24JGVicNQbRLXqp9A9Y497qKVMRrftnLkGFaXFNtIwmyET44+D
	Z05sQ4JPf7CIqnm3RXvKoEt+Mm8E6hILGV+yNFfyMxmNjeqrit/h1z2VjZKGr+pusFW/+OZ3vIQ
	nFeyr0ONb5rI5X+hvufboIfnHnmdxJhqvqTTYg1OzVr52qW6LY9S9rQ==
X-Received: by 2002:a05:600c:c4a7:b0:490:b58a:dcc1 with SMTP id 5b1f17b1804b1-490c262183cmr324676845e9.29.1781020499582;
        Tue, 09 Jun 2026 08:54:59 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a7:b0:490:b58a:dcc1 with SMTP id 5b1f17b1804b1-490c262183cmr324676385e9.29.1781020499094;
        Tue, 09 Jun 2026 08:54:59 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c183asm496291625e9.6.2026.06.09.08.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:54:58 -0700 (PDT)
Date: Tue, 9 Jun 2026 11:54:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virtio-blk: clamp zone report to the report buffer
 capacity
Message-ID: <20260609115437-mutt-send-email-mst@kernel.org>
References: <20260607124834.3059944-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607124834.3059944-1-michael.bommarito@gmail.com>

On Sun, Jun 07, 2026 at 08:48:34AM -0400, Michael Bommarito wrote:
> virtblk_report_zones() trusts the device-reported number of zones when
> walking the report buffer:
> 
> 	nz = min_t(u64, virtio64_to_cpu(vblk->vdev, report->nr_zones),
> 		   nr_zones);
> 	...
> 	for (i = 0; i < nz && zone_idx < nr_zones; i++) {
> 		ret = virtblk_parse_zone(vblk, &report->zones[i], ...);
> 
> The buffer is allocated by virtblk_alloc_report_buffer(), whose size is
> capped by the queue's max hardware sectors and max segments and can
> therefore hold fewer descriptors than nr_zones. nz is bounded only by
> the device-supplied report->nr_zones and the requested nr_zones, never
> by the buffer's descriptor capacity. At probe time the request count is
> unbounded (blk_revalidate_disk_zones() calls report_zones() with
> nr_zones == UINT_MAX), so the device-supplied report->nr_zones is the
> sole gate: a device that reports more zones than fit in the buffer
> drives the loop to read report->zones[i] past the end of the allocation.
> 
> A malicious or buggy virtio-blk device that reports an inflated nr_zones
> triggers this during zone revalidation at probe. KASAN reports a
> vmalloc-out-of-bounds read in virtblk_report_zones() against the report
> buffer allocated a few lines earlier.
> 
> Clamp nz to the number of descriptors that actually fit in the report
> buffer.
> 
> Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v2: drop the explanatory comment per Michael S. Tsirkin's review; the
>     clamp itself is unchanged.
> 
>  drivers/block/virtio_blk.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index b1c9a27..32bf3ba 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -689,6 +689,8 @@ static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
>  
>  		nz = min_t(u64, virtio64_to_cpu(vblk->vdev, report->nr_zones),
>  			   nr_zones);
> +		nz = min_t(u64, nz,
> +			   (buflen - sizeof(*report)) / sizeof(report->zones[0]));
>  		if (!nz)
>  			break;
>  
> 
> base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
> -- 
> 2.53.0

