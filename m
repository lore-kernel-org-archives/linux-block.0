Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF73B3515F8
	for <linux-block@vger.kernel.org>; Sun,  2 Aug 2026 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785705043; cv=none; b=ozvCDmrFLF6LEU0ifP0w6vrxe0QaoLk2YGPjufuJ3Dda6iwMwk+F6sOFWYckXGXkY2IrpkQdfk9/CNK6YQx11kZzfAyd+FaoG7aG/pT6BkpfX7zCwlzGXNBy+oN/Apo4WAbe8Ac6IazW98F/LUOxGah2yXCh4Kncmx+o3pcIHcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785705043; c=relaxed/simple;
	bh=8XHhBJSaOao1ra7Th8dCO+IUDowG1Hd6FxTnD1DgZPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4Ni9W7kgPM+IUAaSicsxPB7laq8gvIH8Plsny3BbsobQfHwOZNWjXasDCu/ZS8yLQpvEZGHXcyWf/QkJyqQiYAsT2w04MCjB6g9Rop3RLLbL+GYJhxRKI+5dF29/zL3JDch9WleCrmPAvJS/XL0mSp0nDK3H4MJwb8tRbJE7So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UbXWNCc9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SRQ8HWjm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UbXWNCc9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRQ8HWjm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785705028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Xqxsjy354sVq1muPTWLc7ZtrNPulk9p/RuRel+d6OA=;
	b=UbXWNCc9E4KW3VQHQg/F3IIkI0wFP1S/so7+4vyNyhyors7kV9YrSksH1wa7uwzReCUI0L
	9vbv8qEJzChcRpLVtmnl5umUZ043hB05M621gYUNBFIprlWM5U5tPopc2fvsnCTW5YSAtO
	2o/9t1JJMIiTybn6P9R0aKlCVNoZtnQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-gs9XjTjJOlO2Niyzfl304A-1; Sun, 02 Aug 2026 17:10:27 -0400
X-MC-Unique: gs9XjTjJOlO2Niyzfl304A-1
X-Mimecast-MFC-AGG-ID: gs9XjTjJOlO2Niyzfl304A_1785705026
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4954dcd6131so16083365e9.3
        for <linux-block@vger.kernel.org>; Sun, 02 Aug 2026 14:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785705026; x=1786309826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Xqxsjy354sVq1muPTWLc7ZtrNPulk9p/RuRel+d6OA=;
        b=SRQ8HWjmelDM09YhRw3HhQhpm5BmT2o6TdisHyJwFB41jbmNt5FAM2eNFdb890f9nu
         OFy9wNBPaI+fki74y4Isv4Q2F6L85agQgGYZaPggVT4qKVCMY1uSD2Ak7MVuFmGvC/sM
         PbUrwEoQRpS//ycmDe68LquND9DUWCP1Oqgf69Hy257pk3j2z1BfE9sWZGkQNPQmdvQc
         R0Kz5MVC5h9sJEUZf/ZCU4g8+XdaGPQo6ifS62lzru79BjOoOIZtfWS6+mCK98prnWak
         6D8DSrKSiY/2NOvJqtrXFHw9R/AXOzEU688kTv1o/heFsEspnFd1P/SbwlUeQGKFYWN8
         a8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785705026; x=1786309826;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Xqxsjy354sVq1muPTWLc7ZtrNPulk9p/RuRel+d6OA=;
        b=WP+BJo0r4JRaCdIFRuePSFfYnlh8nw+YRa9Q6G4ec0tSezcrJ7aKWAIsMqbnBkhfzI
         A785RGXBsHrX5XZrtNKubp14PZlgtyYjveYhOL4IeRwb2FhWrkABBfU+x0FT95INOO4F
         l1PsOB891urYTuGr38PYAS8G6uP4244EVcmAP1id9uhxky1atWkJL3Fcqldxx8KNyiBn
         9PK2l1lQvsmX+0S+x5Ue7OeC3ongCTgoeLXLuVtRHwn/bcSwCMncxIrHWOaBAA0+W9qR
         IVxp3/8A452dm1J8d8WQ4ulvm1BxA4lxuNlLQ2v88hx2N8jWaDQJI1k4bpsY2iAypMr3
         s9Fw==
X-Gm-Message-State: AOJu0YzqkZ1iWylT77RT9qlWTKvtBEhmCjcNPR6v05+YXhlZpJDWT5K9
	q04AXb7cav39SPVhf3Bxo/YvmD8tmnq0MC497bkLNMcjqrz0FcpVzExr7WtuUr7xq2duylwentH
	WrZxfbSaM9Us0WJ3PcWEj2XYL+mUhtTNDz+N1zf5M+N6KJYWLgqE1Xj43bg3BYAJS
X-Gm-Gg: AR+sD11U1Ij/HK6Mb3UD0L1MpMDNkU3wq0biNN+RE/i2/TFL2xk7kGJZUedoIycdELH
	Qx1akGe0HLlBadx+mLp5gsYdcwarszfBmOljit/nsawBMJBx5gDzBAnYJrLqWGqlep8qBTg+kK2
	Mo9tN0rGdpBKm0AyIIoNdWbZP75FWxctO9qcCS+wM6n0W7lRPkEPWi2K8/V1V/W+xqNbhlxy2Iw
	4OmfIdkNXaU6mXi0JRffGFMIlGSUYNiE70L7zNw4XeNaPxE+2AsA+B/UpzhuaY2gxD3NJHAUhbg
	onh2VoED3qwj4IxTPBC3QrdyAgVWTkyxHK/ngZ0kCfSFFHdJ0V3bMo+92i63n3G6jRkwHLihodr
	ycZKuwaU1HjpvJpiof7x7dQ==
X-Received: by 2002:a05:600c:19cf:b0:495:7a04:b006 with SMTP id 5b1f17b1804b1-4980c66b572mr144625965e9.8.1785705026060;
        Sun, 02 Aug 2026 14:10:26 -0700 (PDT)
X-Received: by 2002:a05:600c:19cf:b0:495:7a04:b006 with SMTP id 5b1f17b1804b1-4980c66b572mr144625545e9.8.1785705025517;
        Sun, 02 Aug 2026 14:10:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4980878dbaesm284117615e9.12.2026.08.02.14.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 14:10:24 -0700 (PDT)
Date: Sun, 2 Aug 2026 17:10:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xixin Liu <liuxixin@kylinos.cn>
Cc: linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
	axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] virtio-pci: add error_detected for PCI AER
 recovery
Message-ID: <20260802165915-mutt-send-email-mst@kernel.org>
References: <cover.virtio-blk-ers-v1.1780449274.git.liuxixin@kylinos.cn>
 <cover.virtio-blk-ers-v2.1785468000.git.liuxixin@kylinos.cn>
 <e2dda946e70e.v2.1785468000.git.liuxixin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2dda946e70e.v2.1785468000.git.liuxixin@kylinos.cn>

On Fri, Jul 31, 2026 at 11:17:00AM +0800, Xixin Liu wrote:
> virtio-pci only registered reset_prepare/reset_done.  The PCI error
> recovery core treats devices without error_detected as NO_AER_DRIVER and
> does not deliver pci_channel_io_perm_failure to the driver after a failed
> recovery.

Maybe it should?

> Virtio devices therefore miss the normal ERS quiesce/teardown
> sequence.
> 
> Register error_detected: quiesce on frozen (reset_prepare) before bus
> reset; on perm_failure break virtqueues and return DISCONNECT.  Block-layer
> cleanup for virtio-blk is handled in the follow-up patch.
> 
> Assisted-by: DeepSeek:deepseek-v3
> Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
> ---
>  drivers/virtio/virtio_pci_common.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 164f480b18a6..fff6b6e2d0c5 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -828,7 +828,37 @@ static void virtio_pci_reset_done(struct pci_dev *pci_dev)
>  		dev_warn(&pci_dev->dev, "Reset done failure: %d", ret);
>  }
>  
> +static pci_ers_result_t virtio_pci_error_detected(struct pci_dev *pci_dev,
> +						  pci_channel_state_t state)
> +{
> +	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
> +
> +	/*
> +	 * PCI ERS error_detected: quiesce on frozen before bus reset; on
> +	 * permanent failure break virtqueues (follow-up may call driver
> +	 * .shutdown for block teardown).

block specifically? this is common code.

> +	 */
> +	switch (state) {
> +	case pci_channel_io_normal:
> +		return PCI_ERS_RESULT_CAN_RECOVER;
> +	case pci_channel_io_frozen:
> +		pci_info(pci_dev, "frozen error detected, quiesce device\n");
> +		if (virtio_device_reset_prepare(&vp_dev->vdev))
> +			dev_warn(&pci_dev->dev, "frozen: reset prepare failed\n");
> +		return PCI_ERS_RESULT_NEED_RESET;

so I guess pci will do slot reset? but what will call driver reset later? confused.


> +	case pci_channel_io_perm_failure:
> +		dev_warn(&pci_dev->dev,
> +			 "permanent failure, disconnecting device\n");
> +		virtio_break_device(&vp_dev->vdev);
> +		return PCI_ERS_RESULT_DISCONNECT;
> +	default:
> +		break;
> +	}
> +	return PCI_ERS_RESULT_NEED_RESET;

here, too, and we didn't virtio_device_reset_prepare either.

> +}
> +
>  static const struct pci_error_handlers virtio_pci_err_handler = {
> +	.error_detected = virtio_pci_error_detected,
>  	.reset_prepare  = virtio_pci_reset_prepare,
>  	.reset_done     = virtio_pci_reset_done,
>  };
> -- 
> 2.43.0

