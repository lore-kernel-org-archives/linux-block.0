Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05052318144
	for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765363109; cv=none; b=RNyYH3iqY/IGCG5gvDGh4mz7snwh64GRzlCmyP4u8344/LBgA2nCdsH994lEKDkwjFKimcC4fRG3khKfpkIWLG2vI9m2MaGeFWJJdJybzlJD04yMgnL0wNaYFhsHnuABBkzquV8Xsgt4ND/vzMLE2kTa+oOGoJ2+3K09khnGGAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765363109; c=relaxed/simple;
	bh=HcHo6awj7Y6OzzGvutnKhys6GWnuUbO/D8GbePIlnVw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=olzJtbgt0DMLoafAd7iqR7ks23Thb2I5qTPDMy0PyuW/0MVBlBvxCxkeB+4qDWD91NUtyHZ3jGPQAmhhhBUGOdo+tXNq88WPbSz6jJF/vj49TnVbkMS1SIfjseQXaIhm4hfuOmo9ilPBcZ1dJS7LYDpMzrlxeGEIMBoMGaSt4Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nf+d9jts; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lxpVfmmK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nf+d9jts";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lxpVfmmK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765363100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RBSPNjp8WM10UYPHD5izpIdpdsZ1KPN0SdYbPqVNx+I=;
	b=Nf+d9jtsAjmzRcdmDqvyoFWTkRvA0qgIY5KOTEo6ENAmDiI3ZrTNdBn8W4N/LK7/V5L4lH
	D4svagV63opoUtz3NACW2VyxfK/hOxX95PhNxywpAoFU94ngoCVkiACl4ERV43Jn3aptHb
	OB67t6+P8yjDqn7LVJSr/ad0ixvp42o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-ea4h_qg5OU6_lpcgLYP1Ew-1; Wed, 10 Dec 2025 05:38:19 -0500
X-MC-Unique: ea4h_qg5OU6_lpcgLYP1Ew-1
X-Mimecast-MFC-AGG-ID: ea4h_qg5OU6_lpcgLYP1Ew_1765363098
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47a83800743so2868675e9.0
        for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 02:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765363098; x=1765967898; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RBSPNjp8WM10UYPHD5izpIdpdsZ1KPN0SdYbPqVNx+I=;
        b=lxpVfmmKH1LIuCnMkT5ModjNn4g4XWeMIted0+ACCgWAQ8vYGhv9mvkZh7Wth+IUgn
         7spW48f8qPiLu8xkgtxDfBcaN1zoJdttXp8Q7qDWYsDAcby/Qne/E4dihlo0Z0/OsxwN
         GxV13Uq0PYpS5z587BOGME3U9DQh+cDbpxZjzAZE4sli94R3yK7aTqJHIIF4/gltSq6x
         JS1LiJ7KkRUSFoDuhuU80BSly+r0QJE6440C9cdzPZt9FxQmk65d9eWg74FlpNt5NcM1
         r0Z7VpXgiBDTJoEa2lCOa8Hc+rS1OiTSr4hS4loZd2Q/UnGc1m+RViyzlKCLBjcz+7N/
         N41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765363098; x=1765967898;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RBSPNjp8WM10UYPHD5izpIdpdsZ1KPN0SdYbPqVNx+I=;
        b=rCdXtYn+qkcJxio1lnq9BbJTSNQFwmlhaig7h6oOb6hefOTKEbmFXCN5T5nuABboY1
         HZdaBz8/WEC5Cu2PPcd3i2fK/2rsxqw5RfVOkxIP21YYUzAQtZbQv42ide7sVwLWNJYS
         gSQOjm1BH+DOu20CABWevqCAWKxoXoBS/aQSsuqL2JsJ+Ebqme++A1G3Bae/0Xgki4zi
         150E2tfNkxmkr9S4vz7K04DdnjIDFCRCogjMK7W7Wa0SpauMblShMXMTUvdjGndDaqy8
         fZksz1CyqZgANDKxYsF+CgSaIJRB084vGY6PVkcQkqafKZ6xJP5BcB+LaHzcU6sJa8Uh
         uttw==
X-Gm-Message-State: AOJu0YxufpzCM3Xl5t95H/hE0R12jwQHs/6gwarc5Q+F5lNO3/vAmXZ/
	1w8ZoGJQLHwsby2XyGmAZYfR3aHkSuiegNWAtc6C6PYAHN9qqe4ciBRzQDouFzB9XYYNyLODr13
	8mHOqxhH7tphEIhj9/DEx3t84sM0cEG6JGGqXIfB8fj6TJEXStPb3dewSioTp5WdE
X-Gm-Gg: ASbGncty7XTqh0vSdrmW98TkAN3ImrC/aS3IH5fTOWWrRweD8qaslzx2tD/7XSOXOic
	DG7sow/8L/egxnoyCaR6vqjX57xlSk7h2vfI25OUxPbHBMrraMiQ6Uyz8ZzSqUr2jWo+5Bcmu6y
	HS51u3T2SxK8mpe/uXLfb4KUXr4PHwdylVVepiMIi2YyvtstAmDcLWwPO0utrkHzZlKugZwuTh2
	f+Qvf5rCRBhljicQfq1VU1eGX1jfxaA2X7wfMH/cq5L+Ja30KNepfQwuDPJGDWPnRmRTqmHm3eu
	iPLSpU89JX8/ztFNOTutpw1BirDKoX+swgZD7zbb80nrYY56A8cKiubdVHkeWt/1Key06IrGzvu
	3gAhRja7pcYcMrlBAZsMOTUnPn4TU+TIvxtafJiwzZZkEiZYsLRNLIHKaBTI=
X-Received: by 2002:a7b:c4c1:0:b0:477:9890:4528 with SMTP id 5b1f17b1804b1-47a7f90f296mr30116665e9.2.1765363097924;
        Wed, 10 Dec 2025 02:38:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGV87SR7tAL3h2rAtYUW4CUqvKE6+oCj9U0278AboUMTYTvAt9Bp6+tpd7hKx0uKoUr9O6MXA==
X-Received: by 2002:a7b:c4c1:0:b0:477:9890:4528 with SMTP id 5b1f17b1804b1-47a7f90f296mr30116535e9.2.1765363097478;
        Wed, 10 Dec 2025 02:38:17 -0800 (PST)
Received: from rh (p200300f6af498100e5be2e2bdb5254b6.dip0.t-ipconnect.de. [2003:f6:af49:8100:e5be:2e2b:db52:54b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a82d12609sm37572935e9.2.2025.12.10.02.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 02:38:16 -0800 (PST)
Date: Wed, 10 Dec 2025 11:38:14 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Keith Busch <kbusch@meta.com>
cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de, 
    Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] blk-mq-dma: always initialize dma state
In-Reply-To: <20251210064915.3196916-1-kbusch@meta.com>
Message-ID: <6b458a6e-4c30-f5d9-cfb1-d0d8ce013b04@redhat.com>
References: <20251210064915.3196916-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 9 Dec 2025, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
>
> Ensure the dma state is initialized when we're not using the contiguous
> iova, otherwise the caller may be using a stale state from a previous
> request that could use the coalesed iova allocation.
>
> Fixes: 2f6b2565d43cdb5 ("block: accumulate memory segment gaps per bio")
> Reported-by: Sebastian Ott <sebott@redhat.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> block/blk-mq-dma.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> index e9108ccaf4b06..4ca768e0cc7eb 100644
> --- a/block/blk-mq-dma.c
> +++ b/block/blk-mq-dma.c
> @@ -196,8 +196,9 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
> 		return false;
> 	}
>
> -	if (blk_can_dma_map_iova(req, dma_dev) &&
> -	    dma_iova_try_alloc(dma_dev, state, vec.paddr, total_len))
> +	if (!blk_can_dma_map_iova(req, dma_dev))
> +		memset(state, 0, sizeof(*state));
> +	else if (dma_iova_try_alloc(dma_dev, state, vec.paddr, total_len))
> 		return blk_rq_dma_map_iova(req, dma_dev, state, iter, &vec);
> 	return blk_dma_map_direct(req, dma_dev, iter, &vec);
> }
> --

Yes, that did the trick!
Tested on top of:
cc25df3e2e22 Merge tag 'for-6.19/block-20251201' of git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux
and on top the latest upstream:
0048fbb4011e Merge tag 'locking-futex-2025-12-10' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip

Tested-by: Sebastian Ott <sebott@redhat.com>

Thanks,
Sebastian

