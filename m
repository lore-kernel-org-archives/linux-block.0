Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E272EAB83
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763745170; cv=none; b=YQGXMvTZXiHTbRuUOSrTuuHGCO3C8vjumT4iT0I0kHJL/Ju70nmeks8ZK7YUQeW0poFOCIDkcbE6qIehMtmTW0KLgW1fOynybxRedyKTcMaSgz9dTuPQDiARf6tAYy1nYN8uqYUBDMC0OMAdvsEmCFRt6xVutv0lgnH+NTbZNbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763745170; c=relaxed/simple;
	bh=4knX7UdpV5PqcFPGudPF/uxcuJbYSUmyGMDEJIBJ6aQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNuyvYb4C2308oxl9c5KmQZUH8hTq6/1IOcyWiyX8K3STmygA631t+GEE46TsVcEWJ55hbhNI7KKkeUawmDYNRB8edod3+WLx1N5JfHGNz68hgIABjNqvHDAN5DfttWHo5QRu3Y2SvzRCd0tg0CnXv1z1cll1sspFxDHa7Ql0Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TKyZ9dCI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K8GIaqpj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKyZ9dCI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8GIaqpj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763745168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FRU2qLfbf/wNhvSHqqWH92nPqYewb6NVEbhZtNPwvUI=;
	b=TKyZ9dCI/ORoEf75OqjHdF3K1AGC/JzmiGEAzCMmLdMvI3HgzYJzHLryr7WtknVJ4+ClCk
	0q5e+etQdWfVhHg9VgTFassZ2iJSqZ2G8vDmqj9gRWN5Z8QlD3tjbFNVesQwgNRixSstJS
	hBdkevc1JPxWm0e4MJu7Mg1WSL3METY=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-9TG9mOSQMQu1mAhhDkD6Vw-1; Fri, 21 Nov 2025 12:12:40 -0500
X-MC-Unique: 9TG9mOSQMQu1mAhhDkD6Vw-1
X-Mimecast-MFC-AGG-ID: 9TG9mOSQMQu1mAhhDkD6Vw_1763745160
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-78a82709389so25094717b3.0
        for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 09:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763745160; x=1764349960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRU2qLfbf/wNhvSHqqWH92nPqYewb6NVEbhZtNPwvUI=;
        b=K8GIaqpjeDrEiOedlgcj7Uqvf3/t8g8cTMrGb1tkUTxOiDnEDiu3eRXNs5tbYsf83v
         getj3IFliZKAb3QYO3a6xmsXLJkiQgmSq4nxrM3nr+e67x7p90bfaMojk/L5twjeJABH
         DVfvgvc0YiPm7jH329MX5kRDzLtMmrg1Df8JmJFgEu8ZCozAVh2IFAova/fEK4hod9pc
         dt1TG3jIV/RpaWxLVVI6uXAqw2gc9P3CUJr1D81KhMqNny5953/5QNzPbPiIMh695k0i
         D5SR5Ujin56/fDstB8b086wLqWKciz5EqEZhA4ARo8P/7wLvzaVcVeHSboskLBVMRphH
         txww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763745160; x=1764349960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FRU2qLfbf/wNhvSHqqWH92nPqYewb6NVEbhZtNPwvUI=;
        b=kxJu51ogCt/xx7hZ73UG6ATPQICiSYrKaRhA4mE0Wn04u6Y2PxWPTdCu4BbrPghYGV
         sIAjY3p1m/YmMwCs11eV1z1ch630cYBgx0XMC50tk75gGtSTHYnKGYyjDKYlZVY+D73K
         1Stj9WNDtQgk28j76bwc9kiHGKb5fl+JSprimM/s29YMrYqOijj6ROzC22G5x3JMqsTN
         urV4bH0kSqDSzisKJ+KYihrBJjLYHo9OH580ZIEOCK48PfGhEbXLUjAsYIRkLzyrNNiG
         YWGWMYFQT+ze4mR2dDs7Sp2u4mDVYhFJ4nAe3r/51SDavEWGPBmGXL4kbwtjS49MV5AT
         nAGA==
X-Forwarded-Encrypted: i=1; AJvYcCWbK4aGZh+o8R68bVPnZaoJXz9b/TLESuCgWNIv0DWBXEf1pRiV+cyd4iGvVW0IhhyHRrswaqYfH4reRg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3JLIO+jFZnT2Zn2t5gWgBpdTFfm9pGb9ze7Q2+4ZosGC9mpgM
	zoYf/ZyNpIPTQ1+qEd3m3c8m+rnBdWnciOgwyw+HZPw4GJ4dfwLV34iHY4O/r8XK0D3dZg5S7Ny
	iRTH6j+w/UzFhCe4YsdzvFoPffUmxMSIVyG4fz/qEBossHhbFxk4IktDJVGpMC2q/cB8yNWQ9Z8
	3nBYnszHUd9QwKv6XEjw9Vmj6wD4DVeflDKz34Y0MJivgxPvI=
X-Gm-Gg: ASbGncuL8hdGbunUtpdGBhcHX7HHgevgqLXsWEuXrasgwTNXB5G33DY1yV1oHjYUd4l
	7ThpxTRuh/jJFG8mNQlSV94E4D6zdXSfZmb63hDpGoV5ydJjTIhAfolShBLGzLFG1OVMq9hRnLG
	bPd7wof9pvsweKmqTvPKPalB4N4eUKM1NqVuuaF3ta6mBxn3b6ay8wz0ifayVKolEs
X-Received: by 2002:a05:690c:4c09:b0:787:bf16:d489 with SMTP id 00721157ae682-78a8b5681a0mr24167037b3.62.1763745160076;
        Fri, 21 Nov 2025 09:12:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJMtLvkeHiv5tBcVk8Zunn6fcLBfbMFj2OlEQ7sDWssH1e01yWoO2IMY4KicgI4AI0qMGjQLfshccde2mHq/o=
X-Received: by 2002:a05:690c:4c09:b0:787:bf16:d489 with SMTP id
 00721157ae682-78a8b5681a0mr24166847b3.62.1763745159764; Fri, 21 Nov 2025
 09:12:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn> <20251121081748.1443507-3-zhangshida@kylinos.cn>
In-Reply-To: <20251121081748.1443507-3-zhangshida@kylinos.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 21 Nov 2025 18:12:28 +0100
X-Gm-Features: AWmQ_bnhlFe4bz2evbPrSI0Jb0EHnrWDpAVAemzJqi8jgCPnPPGI5CuseKDcbLY
Message-ID: <CAHc6FU7eL6Xuoc5dYjm9pYLr=akDH6ETow_yNPR0JpLGcz8QWw@mail.gmail.com>
Subject: Re: [PATCH 2/9] block: export bio_chain_and_submit
To: zhangshida <starzhangzsd@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 9:27=E2=80=AFAM zhangshida <starzhangzsd@gmail.com>=
 wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  block/bio.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/block/bio.c b/block/bio.c
> index 55c2c1a0020..a6912aa8d69 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -363,6 +363,7 @@ struct bio *bio_chain_and_submit(struct bio *prev, st=
ruct bio *new)
>         }
>         return new;
>  }
> +EXPORT_SYMBOL_GPL(bio_chain_and_submit);
>
>  struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
>                 unsigned int nr_pages, blk_opf_t opf, gfp_t gfp)
> --
> 2.34.1

Can this and the following patches please go in a separate patch
queue? It's got nothing to do with the bug.

Thanks,
Andreas

