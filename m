Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306A23E51E7
	for <linux-block@vger.kernel.org>; Mon, 18 May 2026 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096566; cv=none; b=leKNAiDKczemSN+tDH6c7HHB8VgWWZVFyj8BYG484FgicywOcShrx4m3TBgESkTbNRckSHbpQACfvxHgZ6DUQ/nmZAgC/ClQ/zNOa0HjxhDuGw+gbW5ZTJcjsdjCCS8MeP5D/xejzfxU/ByMT8OKTNiARNe7RiTxhAxViXjc5KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096566; c=relaxed/simple;
	bh=r0/J3kQR5yeiimzsreh80xsM6C9KNUlXaQl9kU29TUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJuiQhBUYktIesJLl9/GDmx3+s9caz2vLoT6aXvHDrq+A3VI6NV/c6b+0CdE32qP72tCr1r/UUMj0Hwpi5Vkb88ayNxNMpMc5KHKq6ogb1S1zToLupQGG1lfe3o4UzgwImXCbynlZLzoUrNl2YxqtH5wB7XbhJs2d9UTeSabw2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6sihm9e; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6sihm9e"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso25534515e9.0
        for <linux-block@vger.kernel.org>; Mon, 18 May 2026 02:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779096563; x=1779701363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CDwQwZfzQ+v4zAM7BuOooX+kRgbnUOKOzvArP/cGiqU=;
        b=B6sihm9e1ft7GQekyoXBNogAiSuG3QW34W93kkgKsnnNNCDv5J6PKfz6fFTivh/Gss
         0aeFH+dUmUOPPFDfzXy+bVNg8/JbM8bVScJP8cGlfl6x6NdamFBBcJNpcrzmbTnSBFQP
         xLI9pHzOFEB+/TAjplJRJusm7Il+vpUm9nUJLFPj2xfh1LlIzWrqsltuOIr2zo56HwCq
         t9Gr2zAI2FqfHBmRgBbouS+cBThIAKbF3/6s37Ifde0OdwJ76X2qqp/elc7yo+1FUyO/
         5lCFkIBDoLApQ4ZPiUA5LuXTZHogsG91YKqTcgJs8DHnSw/kXU9BQMdHeSsyU+OQoV7g
         6vEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779096563; x=1779701363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDwQwZfzQ+v4zAM7BuOooX+kRgbnUOKOzvArP/cGiqU=;
        b=RbiHDzDQlKkAtBTV6RvVYhg3Q4FA3qAVg8OrwZffedyu8SCwsT2+23RpQ4lQUdfKAO
         8id+dTAv53Z3SoTzI3JTlhhuTHQOD/oR1ob9pREWzOi6YorEcWtk+xSWTEYhgqKiM3OQ
         P8XFP58LsaRTgCxeZqX48IMqv0qDsDFI+7Ea/UjblD1ySy13TGMFmKnEISLXTwm6hN9r
         lZc21Rn1Eex+YMqum4EpuNQ4CemP0H/EycD79Frul0Q15Uo6YEWhSGWfphBZ/hXm30Fj
         WnRZ0tq88lpa//2JcJshWEOxO5YWoIxGrp1iGSmBZy4icjYVxUiU4BURk8HrXQaFQf5m
         pxAA==
X-Forwarded-Encrypted: i=1; AFNElJ/Cnk0vDPUVV5xrSYykioEzYcydMJXOmrjD6JB7qTsRns6CSDM7hWp/CrInoBtAfWA7Kusap5lLPjILwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBNS2ng8kvMCng8zQTEEhjcrI0PQJy5jeDaztE7pzW+a6f/RIz
	+AW+J7T5Y03deHLcwcG5hVYmRNYdXgA1lnePu0mdblEaX3iDMml7OZ2M
X-Gm-Gg: Acq92OEXUjvtubxouqR3vtisfDMCErExhtLhSub1BnljfXEMD80pEfVGke57x8QJd6Q
	Rbj/nu9ko9lJTyWF9WLC7MheFQnAWesn2jC4W9T/i4kpefGKrcSvLeFNrT6KD9EPbBkkwbutP8l
	tF3TVlqUkjo1HgIaRX6YdS1a4Np2DDXJ7oYx3JF5qSEH4AO1P1S+QxDKLygjtYzYff5ZFLpdTVS
	0urRSsnCvwl6lBmjXJx3oRr+vgJC1HR9MbeL9k+1lx4XFn9cvff8AzC2ToTlcUpYIR4fSBcxTGk
	DoUlwKod9vwo+wfkOyYQ5rcjjVYL/b894yvywgAd4w7LHLR49iSo0PJMv+S9Dk+pLgBFz3SIHd6
	+s6dDKcbgO9zbLw19W320lAsCU2K+o1dcuxDa9Y2luMx0lyBQzYlcI1CIQ5pphzDETCQQ6UtGiz
	vSrUhG+G0vjbXLtDEw2J3+GKsfs135ncr3pjJvyA+DY6YKF0I8q/a/7mm0jfltKdd6l7T3NiFqy
	x32BpCtNBkfigXyfn3uSTxBTUeSig+Q+elukSG5sbMCW0JsdwviqMe3b3fJ5ArkoAb1tQ==
X-Received: by 2002:a05:600c:34cc:b0:48e:635a:18d7 with SMTP id 5b1f17b1804b1-48fe59b047bmr240818345e9.0.1779096563202;
        Mon, 18 May 2026 02:29:23 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:6e9b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe582e3sm88451385e9.15.2026.05.18.02.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 02:29:22 -0700 (PDT)
Message-ID: <50ed7240-d8d3-4816-bcc9-ce8adbbbf841@gmail.com>
Date: Mon, 18 May 2026 10:29:18 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] nvme-pci: implement dma_token backed requests
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <5cecb1157ab784f9f303a91449fdf11b03aa6002.1777475843.git.asml.silence@gmail.com>
 <20260513083817.GC6461@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260513083817.GC6461@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/26 09:38, Christoph Hellwig wrote:
> FYI, I really want SGL support before this get merged, but ignoring that
> for now:

I was hoping to let Samsung guys to send a follow up they already have,
but I'll ask them to have about taking it into this patch set.

>> +struct nvme_dmabuf_map {
>> +	struct io_dmabuf_map base;
>> +	dma_addr_t *dma_list;
>> +	struct sg_table *sgt;
>> +	unsigned nr_entries;
> 
> I'd make dma_list a variable-sized array at the end of the struture to avoid
> an extra allocation and pointer derefernece.

Ok

>> +static void nvme_dmabuf_map_sync(struct nvme_dev *nvme_dev, struct request *req,
>> +				 bool for_cpu)
>> +{
>> +	int length = blk_rq_payload_bytes(req);
>> +	struct device *dev = nvme_dev->dev;
>> +	enum dma_data_direction dma_dir;
>> +	struct bio *bio = req->bio;
>> +	struct nvme_dmabuf_map *map;
>> +	dma_addr_t *dma_list;
>> +	int offset, map_idx;
>> +
>> +	dma_dir = rq_data_dir(req) == READ ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
>> +	map = container_of(bio->dmabuf_map, struct nvme_dmabuf_map, base);
>> +	dma_list = map->dma_list;
>> +
>> +	offset = bio->bi_iter.bi_bvec_done;
>> +	map_idx = offset / NVME_CTRL_PAGE_SIZE;
>> +	length += offset & (NVME_CTRL_PAGE_SIZE - 1);
> 
> Please initialize the variable at declaration time and use or add proper
> helpers to simplify this:

> static inline struct nvme_dmabuf_map *
> to_nvme_dmabuf_map(struct io_dmabuf_map *map)
> {
> 	return container_of(map, struct nvme_dmabuf_map, base);
> }
> 
> ....
> 
> 	enum dma_data_direction dma_dir = rq_dma_dir(req);
> 	struct device *dev = nvme_dev->dev;
> 	struct bio *bio = req->bio;
> 	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
> 	dma_addr_t *dma_list = map->dma_list;
> 	int offset = bio->bi_iter.bi_bvec_done;
> 	int mmap_idx = offset / NVME_CTRL_PAGE_SIZE;
> 	int length = blk_rq_payload_bytes(req) +
> 		offset & (NVME_CTRL_PAGE_SIZE - 1);
> 
> Also a lot of these ints sound like they should be unsigned.

Ok

>> +
>> +	while (length > 0) {
>> +		u64 dma_addr = dma_list[map_idx++];
>> +
>> +		if (for_cpu)
>> +			__dma_sync_single_for_cpu(dev, dma_addr,
>> +						  NVME_CTRL_PAGE_SIZE, dma_dir);
>> +		else
>> +			__dma_sync_single_for_device(dev, dma_addr,
>> +						     NVME_CTRL_PAGE_SIZE,
>> +						     dma_dir);
>> +		length -= NVME_CTRL_PAGE_SIZE;
>> +	}
>> +}
> 
> Nothing should be using these __dma_sync helpers that are internal
> details. Using them means you call into sync code that should be skipped
> on most common server class systems.

Yeah, the kernel test robot already flagged it as well

> Also the for_cpu argument is a bit ugly.  I'd rather have separate
> routines as in the core dma-mapping code, even if that means a little bit
> of code duplication.
> 
>> +static blk_status_t nvme_rq_setup_dmabuf_map(struct request *req,
>> +					     struct nvme_queue *nvmeq)
>> +{
>> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>> +	int length = blk_rq_payload_bytes(req);
>> +	u64 dma_addr, prp1_dma, prp2_dma;
>> +	struct bio *bio = req->bio;
>> +	struct nvme_dmabuf_map *map;
>> +	dma_addr_t *dma_list;
>> +	dma_addr_t prp_dma;
>> +	__le64 *prp_list;
>> +	int i, map_idx;
>> +	int offset;
>> +
>> +	nvme_dmabuf_map_sync(nvmeq->dev, req, false);
>> +
>> +	map = container_of(bio->dmabuf_map, struct nvme_dmabuf_map, base);
>> +	dma_list = map->dma_list;
>> +
>> +	offset = bio->bi_iter.bi_bvec_done;
>> +	map_idx = offset / NVME_CTRL_PAGE_SIZE;
>> +	offset &= (NVME_CTRL_PAGE_SIZE - 1);
>> +	prp1_dma = dma_list[map_idx++] + offset;
> 
> Same comments as for the sync helper above.
> 
>> +	length -= (NVME_CTRL_PAGE_SIZE - offset);
>> +	if (length <= 0) {
>> +		prp2_dma = 0;
>> +		goto done;
>> +	}
>> +
>> +	if (length <= NVME_CTRL_PAGE_SIZE) {
>> +		prp2_dma = dma_list[map_idx];
>> +		goto done;
>> +	}
>> +
>> +	if (DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE) <=
>> +	    NVME_SMALL_POOL_SIZE / sizeof(__le64))
>> +		iod->flags |= IOD_SMALL_DESCRIPTOR;
>> +
>> +	prp_list = dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
>> +			&prp_dma);
>> +	if (!prp_list)
>> +		return BLK_STS_RESOURCE;
>> +
>> +	iod->descriptors[iod->nr_descriptors++] = prp_list;
>> +	prp2_dma = prp_dma;
> 
> And I really hate how this duplicates all the nasty PRP building logic,
> although right now I don't have a good answer to that.
> 
>> +static inline bool nvme_rq_is_dmabuf_attached(struct request *req)
>> +{
>> +	if (!IS_ENABLED(CONFIG_DMABUF_TOKEN))
>> +		return false;
>> +	return req->bio && bio_flagged(req->bio, BIO_DMABUF_MAP);
>> +}
> 
> This is something that should go into the block layer.

I'll move it

-- 
Pavel Begunkov

