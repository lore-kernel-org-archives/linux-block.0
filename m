Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6832E2C0282
	for <linux-block@vger.kernel.org>; Tue, 21 Oct 2025 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051482; cv=none; b=lx6ezil5+/O+eaHEMT8Aj54D2j/OoNjqe58R/TL4/k4eNCSTxnjmE7bvZ0oJZsOeLMvNJg+sJ/adDqSZfvJrAbqBlN0oCWaNJdJUv/sZXh/T4uJdVjLASIDm5t170IzHVfTSWhsiLJp0qUrEOnlZG361ZkIOCvVNbgh+3/b5MjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051482; c=relaxed/simple;
	bh=FfcoUUoPUpOsa0VkWk/Dk1Pdl70TqifwXFfjdZWH8QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOU3UVaWXFwGKBFZnIkQX2+1P/0VZguk/nb9gMqe8AydJe7AGnnFpAowJ9Vu30lQEC/oRKOvN6F9DgFglLa6Gw2Jn0aqC9vZAyRox26UTDSUbv7H0tnugOWhViVC55FHPVuKroJsW3gKCqahBBmP585rURahKOEsQIJrgTz6npo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KvUfadTO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KvUfadTO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DvdJq2dPLugSFjjKOvXm1LBOxtEu3BmwSDlhR75aYWo=;
	b=KvUfadTOtYd4YATO2qf/JDmnvJJrevXEbpk+CFSbWOhR7RckZ/3ODtaY7/IIu4+6r1Sy7L
	BcBiUYktOxQ43SVpj4S5LlRy363zrykdXmukbdx3gCk2Vx6HgAveg0093Yuq5XupkCEPUt
	7PXGSjjWpqpn9olEfwaroxKKHrLc4Zc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-QoHSj95_OY6ujWV7VXcg-A-1; Tue, 21 Oct 2025 08:57:58 -0400
X-MC-Unique: QoHSj95_OY6ujWV7VXcg-A-1
X-Mimecast-MFC-AGG-ID: QoHSj95_OY6ujWV7VXcg-A_1761051477
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47105bfcf15so30482785e9.2
        for <linux-block@vger.kernel.org>; Tue, 21 Oct 2025 05:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051477; x=1761656277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvdJq2dPLugSFjjKOvXm1LBOxtEu3BmwSDlhR75aYWo=;
        b=o04aXbQaSJVTG5BbUJ0eNOgGKeMo8TxhEEuu/Z/J63+G6sy803BgNM41THYcgI3nIX
         FUMDxeXV26eQRxdSsw3wCkJvSSTAI8Z95d7ygGBG91iHMAcvU7PKvqypHmZMjAwfdTF2
         WvrWomhV8+hUBTh6pzoJ3OL+nmFcFOl0yj4UVvi8F+ufvO24d1+4nCF82VgWesFb+VJb
         FPigmywkGXWTZMZeLJXZ8NMh/1FkO1a8lqEYn2mkIDUCRTNsTJeziYEzkFoL2H2UHI7O
         Dl/522sc36edVhDLZ/AxpCU8d3C9ACazR0IHgZbTwhojuVBLjtNz/481QE/sAcvxuvE4
         rcKw==
X-Forwarded-Encrypted: i=1; AJvYcCUfrBE24KPyANDNBqjdT5FdFFU59i/e757IOdG2fnHSXtr2BKgBi1VL2yRvVCdsNPrydJ0K1QGr5Hk7Mg==@vger.kernel.org
X-Gm-Message-State: AOJu0YytcHYwHACUZoEyCcRBl3/TdkmxTfLCNYVGK9B7nu2Wc+zypj5Y
	qUy46ykT8ZePvr0tspZOKikRRX2gYeR0JKhEo8hjfZx7mPTr+FDkxmm/yVUUlOW+fJ2ZLKwv+/O
	tzD1zfruA2PbL9MQbk71B8IsBKF75/U9KzWK0clRSzOx26IwYXao15BQT28jdmRw3
X-Gm-Gg: ASbGncuBZQSBSTm1MY6w/SgmtS+o2PsUHP09ZO8KS7ZcDoxciSN6nTAqvqkaGd0LwUt
	7ntV9OK07SxmwJx0aoWBId62WMlTcAnfl8io75NKVckPM5HB0hwlasbWoHyJ4SL4gnqNEDpjbja
	2rYW5NTylJzlr44XEoi0AAzUjalVvPUAKWBFutEZsHVtIpWHLQsV/Lo+3w0o+aOC7k+CoESwNn5
	4Sb7AupFBiWk6RUBHJTRW3EyQpYzAdF4Je0gTjsu7C4gn+Rdp5Ef/M8IZroajBaLI8tvypPxEBj
	OU0hmCZ6AeWWnVNGTvbsV4r+4euPBZ2fFStEWkecaLUfS6DXzhqGvks9D2d1R9/e6dWQ
X-Received: by 2002:a05:600c:198d:b0:46e:3c29:ce9d with SMTP id 5b1f17b1804b1-4711791c57bmr139775085e9.32.1761051476909;
        Tue, 21 Oct 2025 05:57:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMQOVxMDKEqgOB4aV0YZaSaGuRZMfduYN5i5pIKMunnPmVy9cLSdbbEF1RTdTSlw3qu+1DNA==
X-Received: by 2002:a05:600c:198d:b0:46e:3c29:ce9d with SMTP id 5b1f17b1804b1-4711791c57bmr139774785e9.32.1761051476400;
        Tue, 21 Oct 2025 05:57:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47154d3843csm195088345e9.11.2025.10.21.05.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 05:57:55 -0700 (PDT)
Date: Tue, 21 Oct 2025 08:57:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cong Zhang <cong.zhang@oss.qualcomm.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	pavan.kondeti@oss.qualcomm.com
Subject: Re: [PATCH] virtio_blk: NULL out vqs to avoid double free on failed
 resume
Message-ID: <20251021085030-mutt-send-email-mst@kernel.org>
References: <20251021-virtio_double_free-v1-1-4dd0cfd258f1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-virtio_double_free-v1-1-4dd0cfd258f1@oss.qualcomm.com>

On Tue, Oct 21, 2025 at 07:07:56PM +0800, Cong Zhang wrote:
> The vblk->vqs releases during freeze. If resume fails before vblk->vqs
> is allocated, later freeze/remove may attempt to free vqs again.
> Set vblk->vqs to NULL after freeing to avoid double free.
> 
> Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
> ---
> The patch fixes a double free issue that occurs in virtio_blk during
> freeze/resume.
> The issue is caused by:
> 1. During the first freeze, vblk->vqs is freed but pointer is not set to
>    NULL.
> 2. Virtio block device fails before vblk->vqs is allocated during resume.
> 3. During the next freeze, vblk->vqs gets freed again, causing the
>    double free crash.

this part I don't get. if restore fails, how can freeze be called
again?

> ---
>  drivers/block/virtio_blk.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index f061420dfb10c40b21765b173fab7046aa447506..746795066d7f56a01c9a9c0344d24f9fa06841eb 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1026,8 +1026,13 @@ static int init_vq(struct virtio_blk *vblk)
>  out:
>  	kfree(vqs);
>  	kfree(vqs_info);
> -	if (err)
> +	if (err) {
>  		kfree(vblk->vqs);
> +		/*
> +		 * Set to NULL to prevent freeing vqs again during freezing.
> +		 */
> +		vblk->vqs = NULL;
> +	}
>  	return err;
>  }
>  

> @@ -1598,6 +1603,12 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
>  
>  	vdev->config->del_vqs(vdev);
>  	kfree(vblk->vqs);
> +	/*
> +	 * Set to NULL to prevent freeing vqs again after a failed vqs
> +	 * allocation during resume. Note that kfree() already handles NULL
> +	 * pointers safely.
> +	 */
> +	vblk->vqs = NULL;
>  
>  	return 0;
>  }
> 
> ---
> base-commit: 8e2755d7779a95dd61d8997ebce33ff8b1efd3fb
> change-id: 20250926-virtio_double_free-7ab880d82a17
> 
> Best regards,
> -- 
> Cong Zhang <cong.zhang@oss.qualcomm.com>

