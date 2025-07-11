Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E01B3925
	for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224834; cv=none; b=CijHxGiLkEEKX4C2W+vkcJBJY0b1Uo38NrJF73DtjM29T4q9AoURyovAMb5y5pnED3BcLd4MEg3P1aLbYEfRCD/Dg0k3/AufN8O1gEISO9eZ+7GKFKeZ91KK+EJ051QFsZaQGlax6sHXoPMc+wMbE6xL5p7snfXLpZtNwL50ftw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224834; c=relaxed/simple;
	bh=Sw6RzxXBNd/NLpqn6qvIzHXfIW24kSQSFc8y5BigGAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5n5La1GKmfE5yAeHHnNXGQ85TmJNZZDEumz1ysxwPHRuIAe5GYY5pD5SWpPvXoe4O0gGHJ2qjQatMXse5hoCjKrQ8K9xyqCXPTZsoDR4xwgNY2UOPko+O77Ii4dSHlqI49r6bvV3IR/kc//aNP5NuAmIrvoFaON9NIskSFM13U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPKDzgyi; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPKDzgyi"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-553b3316160so1931303e87.2
        for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 02:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752224831; x=1752829631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=drrPqlvrN7nEqRHRRiM3RHqwBps46EJCmsEKgD9+IAM=;
        b=RPKDzgyiggLgF+V5pFZw0us7zp2J3aJVjS0044aKUOdKqXnxpHb2+4Td7UWh+Af8us
         nJNiyLYmJSavYXn38hiD2lNZEzzdWzsmDlWWnfteZpA1iBj4+YnvhjJoinhHBPcBTRzp
         k7s2YwIfPJbEy2oI+2/42oZLKZd4to26LTY7cIHefUGDfoIWoM78XiSZhdWp815VjbFx
         JmhtFOjrqVCDZAtY2DtPzD71sDDX9gApVWQSqKKJnya/qCW9GSVuBHLM1XqQ48/XWacp
         4qpbOowMCOWi+IlwTO6e7XhcbIlCr/c38aLCP7OW92Elps9D89xXb6+/j9TWyQJ5vAgR
         84Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752224831; x=1752829631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drrPqlvrN7nEqRHRRiM3RHqwBps46EJCmsEKgD9+IAM=;
        b=JVXRpHauF5CceRYeEiAu31BR/APxMY3nCQ1hzfBneRgt0LTsNfla4ABqNXMoD7ITxS
         hrPb33CCIwmLnBt5JFHjkcy5aPkE+jnpJlEBUtTCBOXz9sIrqbZ0BKk3uDIVo2KNOqXd
         2M7+4zhzPLpRW5sEcRehTwwXS7UuheZHTOCaVtACL1GVi2wXb2Ry2crBGydtwMsKlpga
         jKXp4B4uM1eAUvxahKC+xpttPbP4u02ND5Dw7uC+LrhQTRUVixOJyE8Yuz3hN5wlKfkB
         hp58+Yag8Y8BYazK5ubsQd0bL0GLUenBHBKKkygZu425k3IYfDA3K1eTjmFMmfm1j92B
         cF2g==
X-Forwarded-Encrypted: i=1; AJvYcCVdMsKzcqN3jxFTiW4A64HsBeKN7SwvqhRX8Rh93b6H7Ebl2F31leiStDXBly71LhFBEGx9ko1ElbkH1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKAKYsTV0lxzH/cryafes0Qg9c811iWC3xTbkDhHWa/1tGMBJk
	z1sD3vpku36bh3ijqE5ZcrlFft/CTZbwD7V5lM0xc73Ti836konhIzaU
X-Gm-Gg: ASbGncvr9c+Ow8xnQ0Lv3v1CKCd6xPipKPxgfW5twIrZoKLIFeCuTjE4gdd9XQspwqB
	MDaXNoLDAo47fptkMk0DB3d8Yk+0+Qs8TfNHk9xi9fukqRlBoSNVP6H3gVwg05brOQeW+3AeSRi
	O6FPl/ja7U5Vv5SIYnh2nfPhPA28il6KVa3HdCgjDRiUQmP/5/9eiCDfOZ7gv7fFmeo+xrz6l2G
	nvYwhAB8VHUOFjFAvftGAvxGFVjT8TNR6c41mxAdM92/8/itt/UpcOcJIEGK3vSOPs1+EQHaFT4
	DTA5La7zqBqCCD991wKNXj9kXNTyGKrgm3pwTq20Lkrqh9hDseaZlAP6jrZiQEyKzo7e0XLgdwb
	U6sPmsAUvMoGcL2p9w3qa/tcWawJQ5sKhZQSdvw==
X-Google-Smtp-Source: AGHT+IHZI/IIgnxTd7WLW/WH+T/NiSsc0Cr50QQFVHQqbXaxpsNFHDaZQfkKSMlzB3+s5Li4oKvOoA==
X-Received: by 2002:a05:651c:411a:b0:32b:492c:5d10 with SMTP id 38308e7fff4ca-3305343e596mr4340301fa.22.1752224830459;
        Fri, 11 Jul 2025 02:07:10 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-32fab91a64csm6235321fa.111.2025.07.11.02.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 02:07:09 -0700 (PDT)
Date: Fri, 11 Jul 2025 11:07:08 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	ben.copeland@linaro.org, leon@kernel.org, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: fix dma unmapping when using PRPs and not
 using the IOVA mapping
Message-ID: <trukrims2ubfcf7j7po4qhfpcceb2hbs3jmj3triu4jgex2ips@oqnk54qyrrtb>
References: <20250707125223.3022531-1-hch@lst.de>
 <m72dvfp7wmycwghaaa65zs5adkzylsdtnk4smp7rdfgrsdw443@ry2laobzym7d>
 <20250711083251.GA6931@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711083251.GA6931@lst.de>

Hi,

On 2025-07-11 10:32:51 +0200, Christoph Hellwig wrote:
> Hi Klara,
> 
> can you try the attached patch?
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 6af184f2b73b..ac3b90d31380 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -745,7 +745,7 @@ static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
>  		return true;
>  	if (!blk_rq_dma_map_iter_next(req, dma_dev, &iod->dma_state, iter))
>  		return false;
> -	if (dma_need_unmap(dma_dev)) {
> +	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {
>  		iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
>  		iod->dma_vecs[iod->nr_dma_vecs].len = iter->len;
>  		iod->nr_dma_vecs++;
> @@ -763,7 +763,7 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
>  	unsigned int prp_len, i;
>  	__le64 *prp_list;
>  
> -	if (dma_need_unmap(nvmeq->dev->dev)) {
> +	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(nvmeq->dev->dev)) {
>  		iod->dma_vecs = mempool_alloc(nvmeq->dev->dmavec_mempool,
>  				GFP_ATOMIC);
>  		if (!iod->dma_vecs)

Yes, this fixes it for me.

Thanks,
Tested-by: Klara Modin <klarasmodin@gmail.com>
