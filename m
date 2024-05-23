Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D18171C2
	for <linux-block@vger.kernel.org>; Thu, 23 May 2024 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476517; cv=none; b=LDs3DsIhz4kqfjXRRwXVvozJn5BxS6Bg0Tk7DHTdQglTuRaQH7saNA9lsmGxYrdcFSZHjMmNnvsIofkjAMQguM06+wixBtH1c9hkeUzMyK4OWdvPrMRn29g499CWmrnHKBfuguoxt72vhEbyJxFcVCJ62voAPOHx/HAOMQ/O5+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476517; c=relaxed/simple;
	bh=96p6cGIocNyfQnz75nfi/xAg5yk+fox+pMVOyHhqhu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pnYOsqtshP/pOqQu30UHNgvHDxqwnqLq5VQ5zr8gvAzkmA+nohiUY+UcALwgWvfnOXRiVB4CKmhLDbLABHbH3aNwt+QWq4qwvQA3uDsJD6ukZOk8Yvwi4KaWW/NGWqJaM2qkwNH5RPAageXBtUolW7P8szjwPkI5fMZSAY1vK+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jBupuf5q; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jBupuf5q"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36da87c973cso3110375ab.0
        for <linux-block@vger.kernel.org>; Thu, 23 May 2024 08:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716476514; x=1717081314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QwmN1/wcgDERsUT+7vZXM1tYtlmgawVxm4hFkdYbTEI=;
        b=jBupuf5q/dHymeXIvGc9Q5nUNuwAGhoyPniDcQ37s1ylz5GxTFBBCjOQYB04SVP9LV
         u5LquJ6fBDvb8Wjg/DskTkS8H2edgQOPZbh003bNDo/kQxLYpd/TElo16UJ2ua0T0vEP
         5mT+4cAvyb4CO5Ssmf612le/Bm5KNdI5sQZCu6urB77G2LSzYeyQv0aI8Bl9NSH7oEDr
         wVMxbTdWUbYJJp/SCdjCW4y1wuVqRG8VXdT8Vt8wZbRWo9qYfo7bWX9STDv3XUh7Vphn
         H0GDwv1mQsZZSHLgSSC1rwbPwJPRMgslZSqQ0F/OTpBJurGwachgOYEB8Uv1jliOq4Vv
         iNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716476514; x=1717081314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QwmN1/wcgDERsUT+7vZXM1tYtlmgawVxm4hFkdYbTEI=;
        b=MkxGM3QajxvBf6kHe5SV5S3nhDVC8Y/6Vb/LnC+fIdnNYChgFKJ0duHAatBU2Nwjzu
         GzVBl+q+VZIFrW+q718IOlby0XwOp6bjYbnLTAYje6XeoVGXD7K1IaoVvgQnhYXZNeaE
         ZwYttjjMq4fI/m5pB64eFYXFsgVxRZ7q1fuVu2ui0bsXLdRGKSa/+7r2GjlJecHB6RPm
         xGw6If7QIAWpA7JnRh0rdlA+//MmG1d0uVkJfAteD3bdwa5mAOjhcHo7SHaOgR4ccBss
         nbURcTfzAxHiR+RXNjhwJFZx0M1tSDDguU3ie8o3EE8+VedW6r/woS8aIA09aE9oeFUp
         0cxA==
X-Forwarded-Encrypted: i=1; AJvYcCWutVlsD3CKB39jTyGSPIYhADwxkZlUZ+2n4GGIN8T0Q5FHmLHyPrDDHh6OtmrtlSF/4NeuJFysYK+qxOUaYnC4WdjaHSx7Oxy3Uq4=
X-Gm-Message-State: AOJu0YylAe5htaC74MObhIaCvkvy799b9Rwj1LUYsZsT38fVQTjMu0VJ
	yHS0KVD5KiOK90DYDM37RGszxJuyJZhsvhqlBqy/6pvQYFUxl8QHmwtH/9iI4Bk=
X-Google-Smtp-Source: AGHT+IHVmz1AA++sDfIunHQVTPZc2XbKAqF221gNkGhUA8RDMTfsc9xZRdyGFYY4e4U1yfCatj6GJQ==
X-Received: by 2002:a05:6e02:1447:b0:36c:3856:4386 with SMTP id e9e14a558f8ab-371f92ff411mr67410825ab.3.1716476509096;
        Thu, 23 May 2024 08:01:49 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3714fa835dasm12756975ab.58.2024.05.23.08.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 08:01:48 -0700 (PDT)
Message-ID: <b1ca89ae-1500-4c3c-bd8a-74e081aa8dd3@kernel.dk>
Date: Thu, 23 May 2024 09:01:46 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: change rq_integrity_vec to respect the iterator
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@kernel.org>,
 Milan Broz <gmazyland@gmail.com>, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org
References: <f85e3824-5545-f541-c96d-4352585288a@redhat.com>
 <c366231-e146-5a2b-1d8a-5936fb2047ca@redhat.com>
 <8522af2f-fb97-4d0b-9e38-868c572da18a@kernel.dk>
 <7060a917-6537-4334-4961-601a182bca54@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <7060a917-6537-4334-4961-601a182bca54@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/24 8:58 AM, Mikulas Patocka wrote:
> 
> 
> On Wed, 15 May 2024, Jens Axboe wrote:
> 
>> On 5/15/24 7:28 AM, Mikulas Patocka wrote:
>>> @@ -177,9 +177,9 @@ static inline int blk_integrity_rq(struc
>>>  	return 0;
>>>  }
>>>  
>>> -static inline struct bio_vec *rq_integrity_vec(struct request *rq)
>>> +static inline struct bio_vec rq_integrity_vec(struct request *rq)
>>>  {
>>> -	return NULL;
>>> +	BUG();
>>>  }
>>>  #endif /* CONFIG_BLK_DEV_INTEGRITY */
>>>  #endif /* _LINUX_BLK_INTEGRITY_H */
>>
>> Let's please not do that. If it's not used outside of
>> CONFIG_BLK_DEV_INTEGRITY, it should just go away.
>>
>> -- 
>> Jens Axboe
> 
> Here I'm resending the patch with the function rq_integrity_vec removed if 
> CONFIG_BLK_DEV_INTEGRITY is not defined.

That looks better - but can you please just post a full new series,
that's a lot easier to deal with and look at than adding a v2 of one
patch in the thread.

> @@ -853,16 +855,20 @@ static blk_status_t nvme_prep_rq(struct
>  			goto out_free_cmd;
>  	}
>  
> +#ifdef CONFIG_BLK_DEV_INTEGRITY
>  	if (blk_integrity_rq(req)) {
>  		ret = nvme_map_metadata(dev, req, &iod->cmd);
>  		if (ret)
>  			goto out_unmap_data;
>  	}
> +#endif

	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) && blk_integrity_rq(req)) {

?

> @@ -962,12 +968,14 @@ static __always_inline void nvme_pci_unm
>  	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
>  	struct nvme_dev *dev = nvmeq->dev;
>  
> +#ifdef CONFIG_BLK_DEV_INTEGRITY
>  	if (blk_integrity_rq(req)) {
>  	        struct nvme_iod *iod = blk_mq_rq_to_pdu(req);

Ditto

> Index: linux-2.6/include/linux/blk-integrity.h
> ===================================================================
> --- linux-2.6.orig/include/linux/blk-integrity.h
> +++ linux-2.6/include/linux/blk-integrity.h
> @@ -109,11 +109,11 @@ static inline bool blk_integrity_rq(stru
>   * Return the first bvec that contains integrity data.  Only drivers that are
>   * limited to a single integrity segment should use this helper.
>   */
> -static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> +static inline struct bio_vec rq_integrity_vec(struct request *rq)
>  {
> -	if (WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1))
> -		return NULL;
> -	return rq->bio->bi_integrity->bip_vec;
> +	WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1);
> +	return mp_bvec_iter_bvec(rq->bio->bi_integrity->bip_vec,
> +				 rq->bio->bi_integrity->bip_iter);
>  }

Not clear why the return on integrity segments > 1 is removed?

-- 
Jens Axboe

