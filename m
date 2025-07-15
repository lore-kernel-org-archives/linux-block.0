Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5C41FF1B4
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588979; cv=none; b=hn5ivDDvcbMw1Yvzz8wghEMpTUiDD6t+b21Z+vMVHhtJs1EMhoTtjDUwbUp+oSyfgoPZ+v+AjcEsZLYjrnp5V9XAZx9wGcBzKezxeQS3vAo/alNB+0jNbN5uB0n7Majem4VuTPFSaaUsvCx+GcO3kkOCtvMWM3o0xf0lMKaBoHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588979; c=relaxed/simple;
	bh=8O5XHcA9URsEqVwfZ2BVmgYjHoEc3boGu08XIia6nIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0rAfo395TdxT3qQiHe5pcStZOBfBr4awnf+aLVMPx2WVy6BDWLvnr0nvGYEpzwEo02Cw4g2g5vp7giLRUNB25o+4nKKb2xPTcE2gjFAihIyvGVF4N82IQZvMnt05JsrCHuKdsIiDFWwQTMZEn1IwYhCT5+buyKg3OY8ryd1oOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H0UOYUtj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0UOYUtj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752588976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2XcCNe/nf+U5xyNDth20FvcaJ04LceEfyGFSZgo7zRQ=;
	b=H0UOYUtjApWr+FrvIbXiYAEl7yhL6EvNeW6vVuTuFhqnb7RpVcgNuZJTfJ3BJYtyKLERTK
	HfvYnVPhvh8Cy41ugvMXrFpAzkk3IoHTNSwYqoBtzh49vRu9U6qrEHqHzb4ktsBzmbq7g2
	Ln7X3evVjqQgJKtYqQMeoa4F8FiKjxM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-LWA9O3U1OYmaa3JVzwFW8A-1; Tue, 15 Jul 2025 10:16:14 -0400
X-MC-Unique: LWA9O3U1OYmaa3JVzwFW8A-1
X-Mimecast-MFC-AGG-ID: LWA9O3U1OYmaa3JVzwFW8A_1752588973
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451ecc3be97so29432475e9.0
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 07:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752588973; x=1753193773;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2XcCNe/nf+U5xyNDth20FvcaJ04LceEfyGFSZgo7zRQ=;
        b=QBxzESqx1uPZb1LKrqJUf8tzhFISbd1fb3CBfFGFfO4Ae5O5t6q91KIAmH0jr5I5TF
         OGmLNFDrTq86lPA1JmfuuvR2gH7XD2/fC0tVUhaaX/zaoEImC9co4JJEb1oxamKJnnX3
         oJkGwiW5wzXv+F50aePUZn5CTLssdDCLqszFjHiOfSfu/qsf+pEhwgFyK83YtykCpnjE
         Q8zxuVyYwRDQ6spuSBwzzdoLlP9CHtziDFOywBxP6FGZfqixB2TJCUOdraMPT/ytI5Qr
         WlR22dCxXuAK98j4X8y7mTebxKQPlDuMj62lx+6j3tQZO8g+Rw76YC96apVrn9DV9cwI
         x+Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVvVuuuAZslvKevPaE1OeIhbCDtuKKyLDFcP9KEEW97KREhsPxytL533k6Q2V3k5zUTAIZqoNXeP0eX4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSDElJd/uIt+rzlxq3z1CvdYg/PTkZ1k4F6843eq0TVvqEX0DZ
	ci1Va0hDWeS7RC1mT/l8JLIbFLXwiJHyNQL3aR9WPCSn+Cs/l/uSM6XwOnLbFdurFD4mU3QaPQ7
	bhnHnXRHXk1umskw9hT4vo7XrI7Bh91rUpcXKhPKViFcNxTXr1DAtGAXHsRRzAXPt
X-Gm-Gg: ASbGncst8EtzDyLXCRIhrv/KNOCO2AFwJ7JvUzcl4O3Tua8ciLSAIte7SBi67oCmNKT
	JIFLk7pHJble4055L8/0vrjeevshg7P/hAgnSXThlXDjb+K5EhypWIHUoFSKQLfrOy2BLT5U86R
	8ug3IxxlhQ6Eqz4/tgVYMr142Hnt3n3IfXJGSYzj043qiEveJvzoGeTq6O8c0bsNVqY9xBlSySn
	hmFJEtPhpMg+yBR+AlpOesKUfdXs5/TJugcYQm8mvFM19f8KC8h5qFa/LVIl1HWGyQ/eQcVZfph
	q0MAym8OZgE0TYc/pRxvjcQxZ5H9zZ1HP+Uuj5OuuWcnXHXcXPyo2sW+WKAijyRDL7DsFnPoI7P
	8L9Up1WeREUbPiGDTjxBHzer9golU0oUumrHi1/vsNfvIJp4QlyeoReOg0hAKFALLx28=
X-Received: by 2002:a05:600c:1ca2:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-4561a699783mr74094225e9.13.1752588972824;
        Tue, 15 Jul 2025 07:16:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdAqd5mpjTzNtfViNTbx93bOKhaoN2CcHdxMowaucQPZVJnCVBn40lvRB+aBNGrYrmkgSNKg==
X-Received: by 2002:a05:600c:1ca2:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-4561a699783mr74093285e9.13.1752588972104;
        Tue, 15 Jul 2025 07:16:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5032fcbsm203995455e9.6.2025.07.15.07.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 07:16:11 -0700 (PDT)
Message-ID: <0793154d-a6ca-43b7-a0c3-01532d9cccc8@redhat.com>
Date: Tue, 15 Jul 2025 16:16:09 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] mm: add largest_zero_folio() routine
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 x86@kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <20250707142319.319642-5-kernel@pankajraghav.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <20250707142319.319642-5-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.07.25 16:23, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Add largest_zero_folio() routine so that huge_zero_folio can be
> used without the need to pass any mm struct. This will return ZERO_PAGE
> folio if CONFIG_STATIC_PMD_ZERO_PAGE is disabled or if we failed to
> allocate a PMD page from memblock.
> 
> This routine can also be called even if THP is disabled.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   include/linux/mm.h | 28 ++++++++++++++++++++++++++--
>   1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 428fe6d36b3c..d5543cf7b8e9 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4018,17 +4018,41 @@ static inline bool vma_is_special_huge(const struct vm_area_struct *vma)
>   
>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
>   
> +extern struct folio *huge_zero_folio;
> +extern unsigned long huge_zero_pfn;

No need for "extern".

> +
>   #ifdef CONFIG_STATIC_PMD_ZERO_PAGE
>   extern void __init static_pmd_zero_init(void);
> +
> +/*
> + * largest_zero_folio - Get the largest zero size folio available
> + *
> + * This function will return a PMD sized zero folio if CONFIG_STATIC_PMD_ZERO_PAGE
> + * is enabled. Otherwise, a ZERO_PAGE folio is returned.
> + *
> + * Deduce the size of the folio with folio_size instead of assuming the
> + * folio size.
> + */
> +static inline struct folio *largest_zero_folio(void)
> +{
> +	if(!huge_zero_folio)

Nit: if (!huge_zero_folio), but see below

I assume this check is only in place to handle whether static allocation 
failed, correct?

> +		return page_folio(ZERO_PAGE(0));
> +
> +	return READ_ONCE(huge_zero_folio);

READ_ONCE should not be required if it cannot get freed.

> +}
> +
>   #else
>   static inline void __init static_pmd_zero_init(void)
>   {
>   	return;
>   }
> +
> +static inline struct folio *largest_zero_folio(void)
> +{
> +	return page_folio(ZERO_PAGE(0));
> +}
>   #endif

Could we do:

static inline struct folio *largest_zero_folio(void)
{
	if (IS_ENABLED(CONFIG_STATIC_PMD_ZERO_PAGE) &&
  	    likely(huge_zero_folio))
		return huge_zero_folio;
	return page_folio(ZERO_PAGE(0));
}
	

-- 
Cheers,

David / dhildenb

