Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7841DFF0
	for <linux-block@vger.kernel.org>; Sun,  7 Jun 2026 02:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780799016; cv=none; b=tJ8aWSpbtjJ3S5qwiQYkfOoLL/NT+h47pqf83DY4/vQj0P8KqQw5wi81RcIFoX7mEqyVdvUsq91YLyR83pzeGwwAvvcG80O0H6zKt1MJODHHgohbwjrDJ9iR9ofLbkQRlydf86rbkcxnv8Kg7pLKwjTjleEpiP+SPHsWBO2crr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780799016; c=relaxed/simple;
	bh=saswmV1voX+J31K8+1YYxt1/oMBSX7yd+TmMmd4PTPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YO0tOEYNMIuarnn3VJNczCsM0BuutjK3d3BwfgyXu88UuO2zhe70nLE2tDWEKNIIkR12mNM4//pYv9oQ+sBuOzHAwIS7u4WsgWOnrVYDQrTLAtFZNhBK69ymD707nLgfGTmTKSVxI4SKKhbndwIteduLMtK1V6Wcnr1c7268Y6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SsSWhFYl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kON2mTCv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsSWhFYl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kON2mTCv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780799013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AkOun8GEXS2QG9yZ2UAlUL4A5OCbW95isM2TUiOZFI0=;
	b=SsSWhFYlcnDTL08mIPzgxvLVo3Csk9SK8oOqhJ8grTnfN+ODgqMkXf8+V6UirVw9MrQd6w
	F+A4+7deTVWLsW9vGo+xvrsPZTVMViGliEjtJCgLivX4h34zA61cHd9s3NZcqPMzZEigOH
	eWDu5DlN0RPCLbkU0zoxmQvxIvsMwB4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-QkTocapxNtSejAH0q-XPow-1; Sat, 06 Jun 2026 22:23:31 -0400
X-MC-Unique: QkTocapxNtSejAH0q-XPow-1
X-Mimecast-MFC-AGG-ID: QkTocapxNtSejAH0q-XPow_1780799010
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4600c8cb13aso1858693f8f.1
        for <linux-block@vger.kernel.org>; Sat, 06 Jun 2026 19:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780799010; x=1781403810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AkOun8GEXS2QG9yZ2UAlUL4A5OCbW95isM2TUiOZFI0=;
        b=kON2mTCvIwurEMexKY+XC//8EuZI9pX0ThSKNWA7VhV9mDkt83pOCqG68dkws+siHB
         9m8FpgxdeqmiEknMePu3Bm+J+VwYTJjELPNCEzprP5yTLDNVeYg9jj8yX0f8ZMzqay1u
         8LJ8xZs4J1ErYbVn3Jk6xexFxDdoByMixQyt9bNWDTWCWBARNO0i1uQhN8b7psp0/fBu
         jvvX9S23Ans54or//IFVZNn5pND59NH9DXPbjjzVjxQy+5xhKS1yEbPFCesrZJWCfqFV
         u5uhGJpMU11FB2WYdpIdZRgjtYXg/mW48HsydeJ772v78eCORZG5BYbI7UNqh2lbwIeF
         W3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780799010; x=1781403810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkOun8GEXS2QG9yZ2UAlUL4A5OCbW95isM2TUiOZFI0=;
        b=GO7a1tyXS4YDszrOLjpN9mbirLKGxlniNrmUKXwHZePIJphSKw7udSJjxngwxMsgyi
         L5S4NGfzYrZXKnupugzxQMoWWVT3CYlh8DSuaCoYpkDQdVm7l/0EFQ9hjXHqmzf/pPSp
         OG16DBVsQ9tdEQx/OXzrdElMWB1eASs1NvH7aojRJQuK/GKEVt6J7+w/CnFZ0/wBesvo
         9ECHLJL+dLNsFLqQT3wck/TmiYEwpT1e+7l9sUKSoPKW9picj0BTWNtl8E4XioojotwZ
         XTzC0whslw6S2GF0JSQJ2kq1bBeuOq+GERQh1PxmMAxg5/A5fcS0QpiQSgNMxoALlFkr
         y61g==
X-Forwarded-Encrypted: i=1; AFNElJ8VhLO0L0inSj4HIZp6VQ2DdjLFE7Qv/VZlENmw2o6TGvcYf/RBo73tLurXDTjh4EZRO4eqO2pLoMEjlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6BlabWfaAhiVeoN/QOUr0gzsSxq0+aLN7ol52WagMaA99EkAM
	98+EyfvsaTJLAD9pNp5O75DZ20559aeZ2mkUE4iDZ0SjIg9OxQOn8/rvIYC8Wdw0HLBpfN0t0vC
	84ipfy2wzCsjz3r7kol6A9FxzUE7imkggatk4SmTz3PDBFbNUE2DvKPu+T6BC5Rqg
X-Gm-Gg: Acq92OFP1tCHXz4prA89M3L7fetwl2Mp6+9Nej8utM/5YwYe9deyFqA1bWTnyx8uuEw
	CdiMTZgg5HybxLQo8C82fowhOOVM7qyv7VsjB0eUJCfNxnZzU/aVYA34BRsXpMHveYgiVOVfta9
	fSEDmEUXQ8ML4wjzBrnlJYfm60O3IPLP70kEzduaA3G6RMS4L18U+RqjgwX6x115aXQtvgD4MTS
	K02Zu1kIXNF03jBcPcSSBx+hDt1T+DQ7gX8qknDgmQ8g8JeAkqmC0Z4kJSR5M5SmdAUamQFYekr
	pEpsmGuR6pZG88sVr44qsUesKXDaA0ZZVNBQzJ62/jFmnZ9jSqngY7ZsxNk/w9pr390dn6nrwL1
	jPND76npyco3edJntfkzPN4Y=
X-Received: by 2002:adf:f2cf:0:b0:45e:f381:cd85 with SMTP id ffacd0b85a97d-4603050230cmr13522045f8f.20.1780799010192;
        Sat, 06 Jun 2026 19:23:30 -0700 (PDT)
X-Received: by 2002:adf:f2cf:0:b0:45e:f381:cd85 with SMTP id ffacd0b85a97d-4603050230cmr13522025f8f.20.1780799009700;
        Sat, 06 Jun 2026 19:23:29 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm40650274f8f.20.2026.06.06.19.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 19:23:28 -0700 (PDT)
Date: Sat, 6 Jun 2026 22:23:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: clamp zone report to the report buffer
 capacity
Message-ID: <20260606221933-mutt-send-email-mst@kernel.org>
References: <20260606170415.1523660-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606170415.1523660-1-michael.bommarito@gmail.com>

On Sat, Jun 06, 2026 at 01:04:15PM -0400, Michael Bommarito wrote:
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
> ---
>  drivers/block/virtio_blk.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index b1c9a27fe00f3..d50aaf956d558 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -689,6 +689,14 @@ static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
>  
>  		nz = min_t(u64, virtio64_to_cpu(vblk->vdev, report->nr_zones),

I think nr_zones should have been le64, bot virtio64.


>  			   nr_zones);
> +		/*
> +		 * The device-reported nr_zones is untrusted;

this part depends on the config. just drop it.

> clamp it to the
> +		 * number of descriptors that actually fit in the report buffer
> +		 * so a malicious or buggy device cannot drive the parse loop
> +		 * past the allocation.
> +		 */
> +		nz = min_t(u64, nz,
> +			   (buflen - sizeof(*report)) / sizeof(report->zones[0]));
>  		if (!nz)
>  			break;
>  
> 
> base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
> -- 
> 2.53.0

