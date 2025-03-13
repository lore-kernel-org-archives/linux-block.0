Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6824610C
	for <linux-block@vger.kernel.org>; Thu, 13 Mar 2025 01:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741828099; cv=none; b=LN8otc80zeNbwGgUmj9myV90HDFC4gnbIi03Jzj1MOl/uXCb4iuR/qxgRGgAM8m47UGHL54GLsxbK9qpUTY6Bylg3HlzB0XNOFWG4pNIsImQ1+qlo+eKyNx058ZSyiYAnPUOx8PVqvFgchRwG/Yf7hYvuMyDSVSX7FC9Ch/K3EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741828099; c=relaxed/simple;
	bh=MBv9XzTUGYPJjVrxIu+txses2UVQqUgv59w1fMbFACY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbtpjOmv4RrTiV0z1NqZ5Yy6/qjqV7IIplelIB7IHFPzucQAk+cZ/WmiW/uB3/KceXGzg+wcUgg/vKzhVDnyADeIeUQ6UtKlk2BNshI+vPb8kfJfJq82hgrreKxIuyhQLGk+BTqdnpPT2liPNLWXS/pSAcDQyH6ldCfQuQJyaN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ex9SeB/I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ex9SeB/I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741828096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wutst5qZ94UnhD3x5JmelF6pckDcOxzOB686lbtU1ZU=;
	b=ex9SeB/IKHkJn+OpEVkfYOsAumvY8ZfSS22jn6TgkXBkEInMjxnbQF5hLgt+5rcMzTY5ci
	alx1jMev6od5ke4pU0yGu9irVvjDSxxM3IcW6EPKHF1wJYUm3bNhaKH0Xuj2/XDdJ2C641
	F8eisLSmIQgSlPSflfjq1B9EJWLp6BQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-pyDsc1fVO5Gl_sH8vflCng-1; Wed, 12 Mar 2025 21:08:15 -0400
X-MC-Unique: pyDsc1fVO5Gl_sH8vflCng-1
X-Mimecast-MFC-AGG-ID: pyDsc1fVO5Gl_sH8vflCng_1741828094
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2240a7aceeaso7381495ad.0
        for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 18:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741828093; x=1742432893;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wutst5qZ94UnhD3x5JmelF6pckDcOxzOB686lbtU1ZU=;
        b=Uaes21v/GbKsi/1qCNFJ0JJh82/MSkCi/3hwZbmUcbF5MiPaeab9DJ4mWU0glNcIry
         3LQ8HB+p7LjRgklDvtZmM8goYQp5dWo52dQrxHYAdQz/AqNp/cBi1NUpGerjbBbQ2MB3
         7UehyTeTOS2zEdsSaPq9lwH1/6l+4cV9/KP56aMYgb8SpHN2v6pzhXdb+k/WBLGrjBTB
         ZnrSPhVaiJb94zC/GgPva87a8U3nKixn/cjN42N5myhioXIgppdQucPZgUknxBGTGsSn
         pve10GLmqHayiOLijKYRfcbnydYegamzz2keKmPfGJ8Yfy7qpbAFVOBPpLlGNiL45w60
         Nbfw==
X-Forwarded-Encrypted: i=1; AJvYcCXv1+RwVyah1w+Dl+4TjMTTVFUdSUkCFoX9ZDAD3fKWK0gZ+bS1G01nV5go0wXTrA3n/LFCICriwne5sA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAyLsBE6mF5nEgFCos46emh6PUyf41oLH+Yzeez8KEyCeDYkTl
	I5rxb5KRHZnXBG1LBzqAlXc7/syJJBcN1ss8CWT7fNvWAKt0qt4FeexhGwICjjw/XOCcNQaXvyx
	lNtc23aiyp075NwLIQyV+VUk31A29lJhe7hM5dAIz5oAcc6kVuXIesEFtsQk6IbF+JwgZ
X-Gm-Gg: ASbGncvgnjTU9YIBDIXCBF+YRFFd5QvYE8GrHUGzbsdKttbWLGQESP49QRQKfNlMb6S
	KDuiLwbbtWPs1POKnZIBQgehwqbWmlMVcS5c+WK3IipF9opr1Z2sjxzocB7BWO0PAMwUG/QdxeP
	RyVzyFf0Wm9MgB9kqp/5U8kZA7dBnBMM+cWLRDqIq/6dOY6hNVfCE4hiZryXGGxZO7wEOmQzjAR
	H/OfLJml/I5cgmRg9ujHXo0QF+0j1MAe+RQEQoGkVUh2Vy8uCyYGpfsj19Mf0c6rFX0cBAUehQO
	+fnMKlpYuJWEAMKPcA==
X-Received: by 2002:a17:902:da84:b0:224:10a2:cae7 with SMTP id d9443c01a7336-22428c057cemr426189515ad.40.1741828093685;
        Wed, 12 Mar 2025 18:08:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIZcmrCoKZ/BkX0AkwyhURpfSQPZ55JEBp+LSHzf23umBLBHhzalnRPPxlUnWGk3FWhOD46w==
X-Received: by 2002:a17:902:da84:b0:224:10a2:cae7 with SMTP id d9443c01a7336-22428c057cemr426189155ad.40.1741828093386;
        Wed, 12 Mar 2025 18:08:13 -0700 (PDT)
Received: from [192.168.68.55] ([180.233.125.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6ee9sm1968875ad.121.2025.03.12.18.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 18:08:12 -0700 (PDT)
Message-ID: <56dab1e8-67b6-4887-a9a6-b313a84343cb@redhat.com>
Date: Thu, 13 Mar 2025 11:08:08 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] block: fix adding folio to bio
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Kundan Kumar <kundan.kumar@samsung.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>
References: <20250312145136.2891229-1-ming.lei@redhat.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250312145136.2891229-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/25 12:51 AM, Ming Lei wrote:
>> 4GB folio is possible on some ARCHs, such as aarch64, 16GB hugepage
> is supported, then 'offset' of folio can't be held in 'unsigned int',
> cause warning in bio_add_folio_nofail() and IO failure.
> 
> Fix it by adjusting 'page' & trimming 'offset' so that `->bi_offset` won't
> be overflow, and folio can be added to bio successfully.
> 
> Fixes: ed9832bc08db ("block: introduce folio awareness and add a bigger size from folio")
> Cc: Kundan Kumar <kundan.kumar@samsung.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- trim `offset` unconditionally(Matthew)
> 	- cover bio_add_folio() too (Matthew)
> 	
> 
>   block/bio.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 

Thanks for fixing it quickly, Ming. It fixes my issue where the guest can't boot
successfully when 16GB hugetlb pages are used on ARM64 host. With this applied,
the guest can boot up successfully.

Tested-by: Gavin Shan <gshan@redhat.com>

> diff --git a/block/bio.c b/block/bio.c
> index f0c416e5931d..42392dd989ec 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1026,9 +1026,10 @@ EXPORT_SYMBOL(bio_add_page);
>   void bio_add_folio_nofail(struct bio *bio, struct folio *folio, size_t len,
>   			  size_t off)
>   {
> +	unsigned long nr = off / PAGE_SIZE;
> +
>   	WARN_ON_ONCE(len > UINT_MAX);
> -	WARN_ON_ONCE(off > UINT_MAX);
> -	__bio_add_page(bio, &folio->page, len, off);
> +	__bio_add_page(bio, folio_page(folio, nr), len, off % PAGE_SIZE);
>   }
>   EXPORT_SYMBOL_GPL(bio_add_folio_nofail);
>   
> @@ -1049,9 +1050,11 @@ EXPORT_SYMBOL_GPL(bio_add_folio_nofail);
>   bool bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
>   		   size_t off)
>   {
> -	if (len > UINT_MAX || off > UINT_MAX)
> +	unsigned long nr = off / PAGE_SIZE;
> +
> +	if (len > UINT_MAX)
>   		return false;
> -	return bio_add_page(bio, &folio->page, len, off) > 0;
> +	return bio_add_page(bio, folio_page(folio, nr), len, off % PAGE_SIZE) > 0;
>   }
>   EXPORT_SYMBOL(bio_add_folio);
>   

