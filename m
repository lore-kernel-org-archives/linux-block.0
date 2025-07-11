Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C32F4F1
	for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 00:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752193519; cv=none; b=nr6pdL4tVcd/u3lhlJxpabLZlrCAVz1OsrhNF163DHgL8LL9Seek4ty5QTqFZjXrM3LHgaIJJ8F7yjHMcXiOabewoBAQVpgJHnDoXkW6ytgjdJM34JcGDVOaeLiPj1WEWz3aVz//l8ALElQzS/5pfH8Y1iCKETwlAkRrvApMaLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752193519; c=relaxed/simple;
	bh=1I2nP/RazbeX5mYl+XahjtBktS/473Z+oE5MYios9gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTcLGZBqf1OiwDJIqvqh1s55MwMacX1YzQastl+ide3cTd/geFgTaiv+yoD0JqhLcqZTiXdSM2duPiUkNtcmCcYV591f9lsxTiw0D0FKTdg2dqU7s2hYvCPf6L3O4/cls/JDdkdquu6XlRiWIHRI70V4hyNaEEXmG1JIWjtbsxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cErRsY3/; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cErRsY3/"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-553bcf41440so1638498e87.3
        for <linux-block@vger.kernel.org>; Thu, 10 Jul 2025 17:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752193515; x=1752798315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f0xYRo3q1FuOmf/uo9+Clv8rD6u6T6bQdsELT6iY8zw=;
        b=cErRsY3/U/d8cdSPGTzaCapK7KlggUT+lruacGumMlsezQd1sjHCdQZL9P+KWj5ULM
         HvWPyNaSNUAXaSvlkBeyqGLuAGupzPRHr8u2+n6ndov/hQoQaOVMaPbzGEGYATtNCmAt
         Ev9EzdDE3biLcZxifLWpGHH9dlWiMfq5NZwI3v8kq2I/KVEmb9llfDuW99cDl77efMfa
         wuegVz9tdGY0rofHTVccwRT6lgVUHJKQQkxLhey9VhlbadeJ5wd/bcqpRflYlArMlqg+
         A2bkEB02zzSxdb51D36Itnt/Tp7JFTC0PZywDVCbIv/mdor012j2/gaHu1u7wOjXMz+F
         bJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752193515; x=1752798315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0xYRo3q1FuOmf/uo9+Clv8rD6u6T6bQdsELT6iY8zw=;
        b=T1eXHHtVBZJ8IoxX+Wq8FWH8YDDk9VxKLoMF94NImcxGewFNMaOLW0h+XEzVrCloeM
         RRj4S/h2fCEJdrM6h8tD0tD7fZD71UJsdBepwLZyZXVxbXT6Q5QWG8rgi+Z/cCfoaFmw
         6/w4wZ8ElabEqgKYDnp6WRyALbjj4qMioe4GbeuS9DocgYrzqT7tVva1oS+wtRUJddIY
         MeUDsIS1CKaI0MyXm4Hluj7XXFukjCgLcIadS/kq3gonO2uApP0tWXkoKZ8zsdlFxuHC
         7NoprnZgWRlJByz98xQ/b752Eks+24jayQaRo3kP9bsJzfybStz556oclk0th0ihwAVp
         ekuA==
X-Forwarded-Encrypted: i=1; AJvYcCUzfVVW527F+3gYWj+JiwMUK1U0RSM4Z+tW7wfeNvo8Edt9hij/vSR19qXWXzuvGNL2ElFwO3dFWbOfDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkREEXGh5pRIiH8TwelRweVzdJ92bJCqo9vgaEeiqsxRMRTmbM
	LNnfQxiwDvYmEaeOvqaMoyGqHXu6InVw+7oWK3ay9WgbetpFjKnxSWWv
X-Gm-Gg: ASbGncvbDhQJx4wpbQbBcp02DXVPLwp2RrAz2fJrtTPPZpxkyFgC6yIN353pocsDOu8
	D6z7yzx6V6nPrR6ofoeV5A8C9P2AdrIWm2fVTVQAafDc7eCUEZ4vKHUNW+FN6p9nbEIE4f5128k
	x79EBYKlAEbSLCKl7yaQJUBDHhjI4zBx2yb64qi0JgiK8kVqzqeg8sAhFOyzycBD2hFFqc0af45
	qFEQ7LwuEwEza27MkYtZ+BFg8rEBD3pQxxavjrVtjoTtv2gH8siSp5S7Ux6lf/7x1sxhuT2g+Ms
	t9NLblPdJhQ7TGxVau7p9nCX3mJaw7dT+qBgn2+X+2NKWUcItUFQ+YlXhDiJB2WLFcCPHRqkkrS
	wibm0Ct+9D3LvEFj47Oe4VuQvuztoj2AJPjrwPg==
X-Google-Smtp-Source: AGHT+IHgmojSsXVmJLNpUcis1HEVhG1ZELSQ0o+1uHEqr779Y+2mlXr00ijIcsH2LHiejfH6ll5vyw==
X-Received: by 2002:a05:6512:b18:b0:553:2eff:8d74 with SMTP id 2adb3069b0e04-55a0464ac0bmr190989e87.42.1752193514815;
        Thu, 10 Jul 2025 17:25:14 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-55943b6be39sm562461e87.181.2025.07.10.17.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 17:25:13 -0700 (PDT)
Date: Fri, 11 Jul 2025 02:25:12 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	ben.copeland@linaro.org, leon@kernel.org, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: fix dma unmapping when using PRPs and not
 using the IOVA mapping
Message-ID: <m72dvfp7wmycwghaaa65zs5adkzylsdtnk4smp7rdfgrsdw443@ry2laobzym7d>
References: <20250707125223.3022531-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707125223.3022531-1-hch@lst.de>

Hi,

On 2025-07-07 14:52:23 +0200, Christoph Hellwig wrote:
> The current version of the blk_rq_dma_map support in nvme-pci tries to
> reconstruct the DMA mappings from the on the wire descriptors if they
> are needed for unmapping.  While this is not the case for the direct
> mapping fast path and the IOVA path, it is needed for the non-IOVA slow
> path, e.g. when using the interconnect is not dma coherent, when using
> swiotlb bounce buffering, or a IOMMU mapping that can't coalesce.
> 
> While the reconstruction is easy and works fine for the SGL path, where
> the on the wire representation maps 1:1 to DMA mappings, the code to
> reconstruct the DMA mapping ranges from PRPs can't always work, as a
> given PRP layout can come from different DMA mappings, and the current
> code doesn't even always get that right.
> 
> Give up on this approach and track the actual DMA mapping when actually
> needed again.
> 
> Fixes: 7ce3c1dd78fc ("nvme-pci: convert the data mapping to blk_rq_dma_map")
> Reported-by: Ben Copeland <ben.copeland@linaro.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This patch seems to introduce a memory leak, causing the slab to grow
continuously. The easiest way I found to trigger it is along the lines
of

# dd if=/dev/nvme0n1 of=/dev/null bs=8M

It also seems to happen during normal use but much more slowly.
Reverting fixes the issue.

# cat /proc/allocinfo | sort -n | numfmt --invalid=ignore --to=iec-i | tail -n5
       146Mi     5285 mm/memory.c:4977 func:alloc_anon_folio 
       182Mi    24395 mm/shmem.c:1847 func:shmem_alloc_folio 
       420Mi    38746 mm/readahead.c:186 func:ractl_alloc_folio 
        29Gi  7383484 drivers/nvme/host/pci.c:767 func:nvme_pci_setup_data_prp 
        29Gi   937347 mm/slub.c:2487 func:alloc_slab_page

# slabtop --human --once | head
 Active / Total Objects (% used)    : 8966529 / 9031691 (99.3%)
 Active / Total Slabs (% used)      : 971257 / 971257 (100.0%)
 Active / Total Caches (% used)     : 128 / 211 (60.7%)
 Active / Total Size (% used)       : 28Gi / 28Gi (99.9%)
 Minimum / Average / Maximum Object : 0.01K / 3.32K / 8.00K

  OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME                   
7410112 7410112 100%    4.00K 926264        8       28Gi kmalloc-4k             
929920 929920 100%    0.12K  29060       32      113Mi kmalloc-128            
 81744  80996  99%    0.10K   2096       39      8.2Mi btrfs_free_space

My machine has 32 GiB of memory and if I leave it be it locks up and
sometimes panics.

# nvme id-ctrl /dev/nvme0 | grep sg
sgls      : 0

Let me know if there's anything else you need.

Regards,
Klara Modin

> ---
>  drivers/nvme/host/pci.c | 114 ++++++++++++++++++++++------------------
>  1 file changed, 62 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 6a7a8bdbf385..6af184f2b73b 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -173,6 +173,7 @@ struct nvme_dev {
>  	bool hmb;
>  	struct sg_table *hmb_sgt;
>  
> +	mempool_t *dmavec_mempool;
>  	mempool_t *iod_meta_mempool;
>  
>  	/* shadow doorbell buffer support: */
> @@ -262,6 +263,11 @@ enum nvme_iod_flags {
>  	IOD_SINGLE_SEGMENT	= 1U << 2,
>  };
>  
> +struct nvme_dma_vec {
> +	dma_addr_t addr;
> +	unsigned int len;
> +};
> +
>  /*
>   * The nvme_iod describes the data in an I/O.
>   */
> @@ -274,6 +280,8 @@ struct nvme_iod {
>  	unsigned int total_len;
>  	struct dma_iova_state dma_state;
>  	void *descriptors[NVME_MAX_NR_DESCRIPTORS];
> +	struct nvme_dma_vec *dma_vecs;
> +	unsigned int nr_dma_vecs;
>  
>  	dma_addr_t meta_dma;
>  	struct sg_table meta_sgt;
> @@ -674,44 +682,12 @@ static void nvme_free_prps(struct request *req)
>  {
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>  	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
> -	struct device *dma_dev = nvmeq->dev->dev;
> -	enum dma_data_direction dir = rq_dma_dir(req);
> -	int length = iod->total_len;
> -	dma_addr_t dma_addr;
> -	int i, desc;
> -	__le64 *prp_list;
> -	u32 dma_len;
> -
> -	dma_addr = le64_to_cpu(iod->cmd.common.dptr.prp1);
> -	dma_len = min_t(u32, length,
> -		NVME_CTRL_PAGE_SIZE - (dma_addr & (NVME_CTRL_PAGE_SIZE - 1)));
> -	length -= dma_len;
> -	if (!length) {
> -		dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
> -		return;
> -	}
> -
> -	if (length <= NVME_CTRL_PAGE_SIZE) {
> -		dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
> -		dma_addr = le64_to_cpu(iod->cmd.common.dptr.prp2);
> -		dma_unmap_page(dma_dev, dma_addr, length, dir);
> -		return;
> -	}
> -
> -	i = 0;
> -	desc = 0;
> -	prp_list = iod->descriptors[desc];
> -	do {
> -		dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
> -		if (i == NVME_CTRL_PAGE_SIZE >> 3) {
> -			prp_list = iod->descriptors[++desc];
> -			i = 0;
> -		}
> +	unsigned int i;
>  
> -		dma_addr = le64_to_cpu(prp_list[i++]);
> -		dma_len = min(length, NVME_CTRL_PAGE_SIZE);
> -		length -= dma_len;
> -	} while (length);
> +	for (i = 0; i < iod->nr_dma_vecs; i++)
> +		dma_unmap_page(nvmeq->dev->dev, iod->dma_vecs[i].addr,
> +				iod->dma_vecs[i].len, rq_dma_dir(req));
> +	mempool_free(iod->dma_vecs, nvmeq->dev->dmavec_mempool);
>  }
>  
>  static void nvme_free_sgls(struct request *req)
> @@ -760,6 +736,23 @@ static void nvme_unmap_data(struct request *req)
>  		nvme_free_descriptors(req);
>  }
>  
> +static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
> +		struct blk_dma_iter *iter)
> +{
> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +
> +	if (iter->len)
> +		return true;
> +	if (!blk_rq_dma_map_iter_next(req, dma_dev, &iod->dma_state, iter))
> +		return false;
> +	if (dma_need_unmap(dma_dev)) {
> +		iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
> +		iod->dma_vecs[iod->nr_dma_vecs].len = iter->len;
> +		iod->nr_dma_vecs++;
> +	}
> +	return true;
> +}
> +
>  static blk_status_t nvme_pci_setup_data_prp(struct request *req,
>  		struct blk_dma_iter *iter)
>  {
> @@ -770,6 +763,16 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
>  	unsigned int prp_len, i;
>  	__le64 *prp_list;
>  
> +	if (dma_need_unmap(nvmeq->dev->dev)) {
> +		iod->dma_vecs = mempool_alloc(nvmeq->dev->dmavec_mempool,
> +				GFP_ATOMIC);
> +		if (!iod->dma_vecs)
> +			return BLK_STS_RESOURCE;
> +		iod->dma_vecs[0].addr = iter->addr;
> +		iod->dma_vecs[0].len = iter->len;
> +		iod->nr_dma_vecs = 1;
> +	}
> +
>  	/*
>  	 * PRP1 always points to the start of the DMA transfers.
>  	 *
> @@ -786,13 +789,10 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
>  	if (!length)
>  		goto done;
>  
> -	if (!iter->len) {
> -		if (!blk_rq_dma_map_iter_next(req, nvmeq->dev->dev,
> -				&iod->dma_state, iter)) {
> -			if (WARN_ON_ONCE(!iter->status))
> -				goto bad_sgl;
> -			goto done;
> -		}
> +	if (!nvme_pci_prp_iter_next(req, nvmeq->dev->dev, iter)) {
> +		if (WARN_ON_ONCE(!iter->status))
> +			goto bad_sgl;
> +		goto done;
>  	}
>  
>  	/*
> @@ -831,13 +831,10 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
>  		if (!length)
>  			break;
>  
> -		if (iter->len == 0) {
> -			if (!blk_rq_dma_map_iter_next(req, nvmeq->dev->dev,
> -					&iod->dma_state, iter)) {
> -				if (WARN_ON_ONCE(!iter->status))
> -					goto bad_sgl;
> -				goto done;
> -			}
> +		if (!nvme_pci_prp_iter_next(req, nvmeq->dev->dev, iter)) {
> +			if (WARN_ON_ONCE(!iter->status))
> +				goto bad_sgl;
> +			goto done;
>  		}
>  
>  		/*
> @@ -3025,14 +3022,25 @@ static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)
>  static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)
>  {
>  	size_t meta_size = sizeof(struct scatterlist) * (NVME_MAX_META_SEGS + 1);
> +	size_t alloc_size = sizeof(struct nvme_dma_vec) * NVME_MAX_SEGS;
> +
> +	dev->dmavec_mempool = mempool_create_node(1,
> +			mempool_kmalloc, mempool_kfree,
> +			(void *)alloc_size, GFP_KERNEL,
> +			dev_to_node(dev->dev));
> +	if (!dev->dmavec_mempool)
> +		return -ENOMEM;
>  
>  	dev->iod_meta_mempool = mempool_create_node(1,
>  			mempool_kmalloc, mempool_kfree,
>  			(void *)meta_size, GFP_KERNEL,
>  			dev_to_node(dev->dev));
>  	if (!dev->iod_meta_mempool)
> -		return -ENOMEM;
> +		goto free;
>  	return 0;
> +free:
> +	mempool_destroy(dev->dmavec_mempool);
> +	return -ENOMEM;
>  }
>  
>  static void nvme_free_tagset(struct nvme_dev *dev)
> @@ -3477,6 +3485,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	nvme_dbbuf_dma_free(dev);
>  	nvme_free_queues(dev, 0);
>  out_release_iod_mempool:
> +	mempool_destroy(dev->dmavec_mempool);
>  	mempool_destroy(dev->iod_meta_mempool);
>  out_dev_unmap:
>  	nvme_dev_unmap(dev);
> @@ -3540,6 +3549,7 @@ static void nvme_remove(struct pci_dev *pdev)
>  	nvme_dev_remove_admin(dev);
>  	nvme_dbbuf_dma_free(dev);
>  	nvme_free_queues(dev, 0);
> +	mempool_destroy(dev->dmavec_mempool);
>  	mempool_destroy(dev->iod_meta_mempool);
>  	nvme_release_descriptor_pools(dev);
>  	nvme_dev_unmap(dev);
> -- 
> 2.47.2
> 
