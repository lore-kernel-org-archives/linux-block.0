Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3392C1589
	for <linux-block@vger.kernel.org>; Thu,  4 Sep 2025 21:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021919; cv=none; b=ioExv+Fx5ffdMEC6HNCLU4NBrkl7bEBhGGwLLv9FQgFeng4NpnP9eJrTnRbE1P5bvXNkxdId3mUVk9fBWPsQRJg+2fIwT7YQPE35kOceK2oK5YdEZ3JZ8yY0+T6e+OUVj/cmUArUQKHAYHcEEalIRIRA8kGIB8Frx2DnC9pkl2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021919; c=relaxed/simple;
	bh=+ZrUvtnLM9xSVjfFb/jug+Mxt/vh9q4WYgIFgX9cQDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmIUj6/h34Yg63JXpT6E7A+T425ReGvfU3V2e6hdhVtYao7pEWgplpNH5D0hIj8WHPYJL0GpL7KeEaCND62pCdLijJlVHVhqUbBZHuocxwyVdheqvK/MZ2xbutNaFyCh7wx+R5Fh/kIu9SBtczns0tmRS+8aULdMrN7Qzwj4ESA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e9Abxpzu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9Abxpzu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757021915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9rHD7plJVEZkv8PkFJEx5BeBVBt5QFBtzvV5bLJfU1s=;
	b=e9AbxpzukcoKaOXSeXcp2w3w7k2MS+2IyhSpbfnhUREQ0UIZ7BCE9qj1yqrtxOdSrvzjTC
	YPGkhDyA76fdqF+amJQ3SE2d/QTdtu/tmsliab5J2tRhxI89SVzLzsByv5Ijve04EkS0du
	meZvvHlh2Zv+1cNBUPG2Y5DjPFA8Y5c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-MGhHZUMcNj2RyeI6JXRgFg-1; Thu, 04 Sep 2025 17:38:34 -0400
X-MC-Unique: MGhHZUMcNj2RyeI6JXRgFg-1
X-Mimecast-MFC-AGG-ID: MGhHZUMcNj2RyeI6JXRgFg_1757021913
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b96c2f4ccso8174455e9.0
        for <linux-block@vger.kernel.org>; Thu, 04 Sep 2025 14:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757021913; x=1757626713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rHD7plJVEZkv8PkFJEx5BeBVBt5QFBtzvV5bLJfU1s=;
        b=EliEggX0csP+CwlUEYduDPHdErNl90Wow3C6fxvhhUeu9nsBFnzS32qKLsrJO2vzq4
         YLyOVo06yegjh3+S0dr3WNccwm6mlSj4vWDSQ16SK7evHxDtb206cGCgCk7j4kMGHVqE
         cVudTQcn0/OLnBMhDiojCjg1NqkP4g4ygBA4Vg7+QIqww9L2380ZEmBrIrJ51KBTX5m0
         hNiSTABlpJAsO58dDkg4xhM0aCEhgY0TvCY99imKlC8thUT4O8R9mOpv3wxQHwFOwl6z
         jdO4Om6Qc7aUTh/Q84AqHaJd48vqSJ1L/cu800R58Gu3MfKEZKC3L2dyJPByM/qsjP0z
         XPAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzvh3rigql3rNBDs6fbQguJwKctuJu1+0Gf+6YLkeeyL8X/SgIgks97Btps3YAP0arFI7Qs934GAm8YQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqJ1+2Y/Zl3Zp6Cc8LhtQhlGuanG1hyArWUd8z1gpqM//Z7mFO
	v9DypSwhPgTSfuG29YVyD8Og5In3K2km9/1PGT1Pu+Q39Cl4+Tcn6WsceJDCHlbt5quZSN11eUI
	dPOiMRaHSNiGfIwV2miV4BfMijPE4kOQmDHbjSByzw+CMvB5Jr719xoA4vUm7YKDg
X-Gm-Gg: ASbGncvZj7DfaWWeUxgnn2GWxqVq34WoyjA5hRRn6z7V2EBXo6VZp7eMBLKIDel84+5
	OaYcQLTiXMyKcSoF944ulBWya0/1DzlD2R606ucQQmR6U1lPyfNJ+3DpPnQIm6NEiXf7kJaxRpr
	Bh0WwnV6yyomNBvWh4e4fAMSv3xkmwY5h6EMHnjq0s23Yp+NiMO+PxCYxaSgdhAdDbBV9yo+PtU
	azrFtBWzUfa38NVqc+ER81tF6z1PXY3dP3GQWlPSOVF1xnNbrn2DVjSsvUkVl1r93+71jvYYeSp
	3YxPhhi9j6M2bUh+JLnLOF9+Hag8ZjDFyfSXx8VcC8oAZDxOXsSvHVSErTIwdgB3xg==
X-Received: by 2002:a05:600c:1d10:b0:45b:891f:afcf with SMTP id 5b1f17b1804b1-45b891fb24dmr144597865e9.27.1757021913369;
        Thu, 04 Sep 2025 14:38:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWbBDlkpyRRxeIt/+qH4VagktWDBCJazVbSXDHRMhx/diXSZUFSBaQ6M24PtRDNYL0yu7m/g==
X-Received: by 2002:a05:600c:1d10:b0:45b:891f:afcf with SMTP id 5b1f17b1804b1-45b891fb24dmr144597725e9.27.1757021912965;
        Thu, 04 Sep 2025 14:38:32 -0700 (PDT)
Received: from redhat.com (93-51-222-138.ip268.fastwebnet.it. [93.51.222.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf3458a67fsm1872200f8f.62.2025.09.04.14.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 14:38:32 -0700 (PDT)
Date: Thu, 4 Sep 2025 17:38:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-efi@vger.kernel.org, virtualization@lists.linux.dev,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 7/7] virtio_balloon: Stop calling page_address() in
 free_pages()
Message-ID: <20250904173824-mutt-send-email-mst@kernel.org>
References: <20250903185921.1785167-1-vishal.moola@gmail.com>
 <20250903185921.1785167-8-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903185921.1785167-8-vishal.moola@gmail.com>

On Wed, Sep 03, 2025 at 11:59:21AM -0700, Vishal Moola (Oracle) wrote:
> free_pages() should be used when we only have a virtual address. We
> should call __free_pages() directly on our page instead.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/virtio/virtio_balloon.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index eae65136cdfb..7f3fd72678eb 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -488,8 +488,7 @@ static unsigned long return_free_pages_to_mm(struct virtio_balloon *vb,
>  		page = balloon_page_pop(&vb->free_page_list);
>  		if (!page)
>  			break;
> -		free_pages((unsigned long)page_address(page),
> -			   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> +		__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
>  	}
>  	vb->num_free_page_blocks -= num_returned;
>  	spin_unlock_irq(&vb->free_page_list_lock);
> @@ -719,8 +718,7 @@ static int get_free_page_and_send(struct virtio_balloon *vb)
>  	if (vq->num_free > 1) {
>  		err = virtqueue_add_inbuf(vq, &sg, 1, p, GFP_KERNEL);
>  		if (unlikely(err)) {
> -			free_pages((unsigned long)p,
> -				   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> +			__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
>  			return err;
>  		}
>  		virtqueue_kick(vq);
> @@ -733,7 +731,7 @@ static int get_free_page_and_send(struct virtio_balloon *vb)
>  		 * The vq has no available entry to add this page block, so
>  		 * just free it.
>  		 */
> -		free_pages((unsigned long)p, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> +		__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
>  	}
>  
>  	return 0;
> -- 
> 2.51.0

