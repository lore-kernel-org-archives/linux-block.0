Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B86B1A08BC
	for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763228026; cv=none; b=SlNJ5M7xe9i7iQ2YDei/3nTAs3lFtS3DbWaV4dxUJzkgUhIXekaIVon1LUSjducnTxLWxnS8MHkpNlK3NAPBIeHA180XlGrZK1c2ySTNbgzsK9iFAiTjpobb4voQsdTcqjIKIjdDS+qe47+SkP6xX8/EKnjThSURd+1W5PM+9T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763228026; c=relaxed/simple;
	bh=2Bd7+uJuTUGNZAg6U87lorr66mjbki1AOCLtqFD1qs4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oD0/PuMOhHPH0lU0tso5UPS2vdSOYpBPMzAMRhylX5RqLwUh+k8mDiy2jZV9Zu16O4HhWyOOvuPX0g81lGorIe/GXo6VqfP/1h+RgdX9ITA1ME8KlIQropg1W0eocn/4axPx5T2evPElHLeWMqh9b3UsW13OHqkpCFWSilyC+Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T04pCplN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T04pCplN"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477770019e4so34962075e9.3
        for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 09:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763228023; x=1763832823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFzc+YcPufitKW9Rs5Vf2RxsuMATU2dwsVOJoOkPDOU=;
        b=T04pCplNzGSoaYb0oWb9UIdmJflylBd5SY7pmMjJOj4fSRbd/ZdUXsjA9zNkNoFiVE
         GduIrrA/A8c9NBc0s+EhRubANVRCX6H3B1x5Vxd/bGzmgK56kSX4EeCHinNpY5GOa9gL
         DBeVmo2DXqGWMh+1yNMZ1KH9iZR4bvrCRiulzmtpABhc2EhMfjyMjDT0todNRUtscaOm
         CnaDf5G9179h+bWju/oBZAW1nKoW6eUx317FRprCbAaiNGLnp71FA82RSLQQqZB0jJcs
         KaQDRt0cH2Cnq7em6d8RXzrK4qmmGP/vuvCSRmD9MOZY7A4EwRZ3TqkPweRQHsPTuqu9
         1eRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763228023; x=1763832823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qFzc+YcPufitKW9Rs5Vf2RxsuMATU2dwsVOJoOkPDOU=;
        b=oRLJrRH80Op03YWzYvpEC3BkLJVL6LT/G8uggNHyU/rjoP8ZSqis9TYgg37ZUvX3J3
         JaEaZipJw1UXM3VBhIAnJxEaqLtKQ4Aj8IpaHmg9ss0s2rY0sbGirKo0yJQFVY4IuBjd
         9izR8V6i1lywnu4QzX6TOgrehe+wM+Mq8h2oEky69ft3yrwCSlgoYXEd8FpAozicCyGe
         ierHLnvwRceFfbV0e2VLN4+WFKVjBYLpttACXp+Qa48+vtPrTOMAWFZQO03nQS/o59As
         YnULEhStNzr0HfA65U6hc7ugdGPMZV42SkWgRYvgIGZRUSVIibq4tXvmIRvt1Y0tyG3E
         /R4g==
X-Forwarded-Encrypted: i=1; AJvYcCUlTYQiN07pgQA8bG30/Zyt7Mc/h3AL4By5VWRB3uEclul569+7uMnrZz5fwZ+k51AKxCrNvzOwjog+yw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkxy+a+Ji5L//+ETFQWlzEWsSl/RNSpPEHddRjhqTpW9+GZV8a
	bYzIjAQBtrLdmvcwhiBoMFdD5yGhSixRoZCNozXcBlKpq7DXBwG9yNtB
X-Gm-Gg: ASbGncuID4HOQyyIODcmnpE8rNWtDMIFXsh3/ngF4CM04hbsa+5jq1YJ/uJ4uCXA9+7
	gyr4So8TmMB8x74DErYOGEjQcBjxf1x7dlPJlGuUeNkrVjFqM1fjJFbbbGwnCQ57EyRBGeomhm1
	ZJBxqAR0mUwNGd4ObADFBCTxf7xgewfnq1tAIMQZWtz5hgWoMaIsCPyAyFH1ahSji2RZhsgnW+0
	Mc4in0W64uTwV0ikp47WdfUod2ylP6ObdSAyowxDAFAf2ziWIdHubpfV1txnqlDsGN6qouannrI
	jDFpdcx9J0FW47tttz/yYJq4YoPnG+mucJKhlvK9R1bhrlwhj1apyzsdGMvSI+qv/n8O8x/Yi/N
	ISJEEkU/KzQ8n+4BvRUQh4XxvP/Xx5tJ4dnHgz0OVL9/o+twvfIV/22EYgP5HMyi5a2cW6feabA
	EVlSr5101lUMMKsIFjHhrqH6NOysx1NvcLyaowpHKIfwzajyHqravz
X-Google-Smtp-Source: AGHT+IHQ+EmtUAqO9yz3yFBpoimIZKZZzroUXyQeIyUrb6pbi8e+SUv2VPyJAkhU4fQ+Jp/lAq9i1A==
X-Received: by 2002:a05:600c:8b21:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-4778fe883e3mr76104755e9.30.1763228023039;
        Sat, 15 Nov 2025 09:33:43 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bb34278sm72414165e9.4.2025.11.15.09.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 09:33:42 -0800 (PST)
Date: Sat, 15 Nov 2025 17:33:41 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvme-pci: Use size_t for length fields to handle
 larger sizes
Message-ID: <20251115173341.4a59c97f@pumpkin>
In-Reply-To: <20251115-nvme-phys-types-v1-1-c0f2e5e9163d@kernel.org>
References: <20251115-nvme-phys-types-v1-0-c0f2e5e9163d@kernel.org>
	<20251115-nvme-phys-types-v1-1-c0f2e5e9163d@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Nov 2025 18:22:45 +0200
Leon Romanovsky <leon@kernel.org> wrote:

> From: Leon Romanovsky <leonro@nvidia.com>
> 
> This patch changes the length variables from unsigned int to size_t.
> Using size_t ensures that we can handle larger sizes, as size_t is
> always equal to or larger than the previously used u32 type.

Where are requests larger than 4GB going to come from?

> Originally, u32 was used because blk-mq-dma code evolved from
> scatter-gather implementation, which uses unsigned int to describe length.
> This change will also allow us to reuse the existing struct phys_vec in places
> that don't need scatter-gather.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  block/blk-mq-dma.c      | 14 +++++++++-----
>  drivers/nvme/host/pci.c |  4 ++--
>  2 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> index e9108ccaf4b0..cc3e2548cc30 100644
> --- a/block/blk-mq-dma.c
> +++ b/block/blk-mq-dma.c
> @@ -8,7 +8,7 @@
>  
>  struct phys_vec {
>  	phys_addr_t	paddr;
> -	u32		len;
> +	size_t		len;
>  };
>  
>  static bool __blk_map_iter_next(struct blk_map_iter *iter)
> @@ -112,8 +112,8 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
>  		struct phys_vec *vec)
>  {
>  	enum dma_data_direction dir = rq_dma_dir(req);
> -	unsigned int mapped = 0;
>  	unsigned int attrs = 0;
> +	size_t mapped = 0;
>  	int error;
>  
>  	iter->addr = state->addr;
> @@ -296,8 +296,10 @@ int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
>  	blk_rq_map_iter_init(rq, &iter);
>  	while (blk_map_iter_next(rq, &iter, &vec)) {
>  		*last_sg = blk_next_sg(last_sg, sglist);
> -		sg_set_page(*last_sg, phys_to_page(vec.paddr), vec.len,
> -				offset_in_page(vec.paddr));
> +
> +		WARN_ON_ONCE(overflows_type(vec.len, unsigned int));

I'm not at all sure you need that test.
blk_map_iter_next() has to guarantee that vec.len is valid.
(probably even less than a page size?)
Perhaps this code should be using a different type for the addr:len pair?

> +		sg_set_page(*last_sg, phys_to_page(vec.paddr),
> +			    (unsigned int)vec.len, offset_in_page(vec.paddr));

You definitely don't need the explicit cast.

	David

>  		nsegs++;
>  	}
>  
> @@ -416,7 +418,9 @@ int blk_rq_map_integrity_sg(struct request *rq, struct scatterlist *sglist)
>  
>  	while (blk_map_iter_next(rq, &iter, &vec)) {
>  		sg = blk_next_sg(&sg, sglist);
> -		sg_set_page(sg, phys_to_page(vec.paddr), vec.len,
> +
> +		WARN_ON_ONCE(overflows_type(vec.len, unsigned int));
> +		sg_set_page(sg, phys_to_page(vec.paddr), (unsigned int)vec.len,
>  				offset_in_page(vec.paddr));
>  		segments++;
>  	}
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 9085bed107fd..de512efa742d 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -290,14 +290,14 @@ struct nvme_iod {
>  	u8 flags;
>  	u8 nr_descriptors;
>  
> -	unsigned int total_len;
> +	size_t total_len;
>  	struct dma_iova_state dma_state;
>  	void *descriptors[NVME_MAX_NR_DESCRIPTORS];
>  	struct nvme_dma_vec *dma_vecs;
>  	unsigned int nr_dma_vecs;
>  
>  	dma_addr_t meta_dma;
> -	unsigned int meta_total_len;
> +	size_t meta_total_len;
>  	struct dma_iova_state meta_dma_state;
>  	struct nvme_sgl_desc *meta_descriptor;
>  };
> 

