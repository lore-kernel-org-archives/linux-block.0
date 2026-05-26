Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A223AA9DA
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 20:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779829038; cv=none; b=VMvEx3o3bNJRtEIwKRBVWNKRfoVfbZkbdGzR4LYBz0ncIWZSa7pmoyJ898yqQ2WNK9WL4+GfVL2Bakh+YbFEUvoD02Xw19ab87XtmmZ0qE6y+FuozfSY5LiHwtj9yUTqy2LHfz3qFx/qfMDa9F51bV3I+2wF1aCzFAzz10mODlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779829038; c=relaxed/simple;
	bh=GcX4flGUJGhoixlAx8HL7oeZ9Ciknz+u2XdVpAZUXz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CI0mr15OOUf1CpLoFy0zojcgfJnIwsSBZTNMWi7yRyyQJCgmtION2TIvS0/OFMgs31gF8Cvp+cOFCmm7J2YNlSuR3av4vH1vofON7SpuPA2PUBxrISA+lMVJGPVHwgps0MV3gA+hF0mvBZuWaZeemE2/I6wQ+JvD4jP70sEDnPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FmlU09e6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FmlU09e6"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d7dab87e1so1206461f8f.3
        for <linux-block@vger.kernel.org>; Tue, 26 May 2026 13:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779829035; x=1780433835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ks4dTmlympIPYAqCrL2AXyLjzLfs8srlx+ar7BYAqs=;
        b=FmlU09e6K0BtJjO5e3iKnn+5NHt0G9Wc4lwTOFB+Dv/iLlvRrC+YQ0lGp7i9P94qTl
         qKn7btiEbUBB7s/v8PbCfkVhvYOdqqvmmJxBJWihIdeRNGgPWbo/NnYXkKIfCE66foln
         wO2/rqL2b3byfD9ipQqjYGy+T3L9FxRTOs8jxM4KqSK/zOyXbG3TDudDG1OZar8UxI+d
         qpRwqReTsVbFgyrRBjlWbvzZio/jQbn0/qPBEjrIi6Rktkjl0D2dd71eNm0mLqjUkf7S
         Ne3gwIOJfPOOjCUkA/Fmf8/TobA75IvRYZk8xrDusiqt/oFEil5FNPUp018pQN/5u7pE
         32Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779829035; x=1780433835;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ks4dTmlympIPYAqCrL2AXyLjzLfs8srlx+ar7BYAqs=;
        b=SOqUZMnKRWCezOQ8gMydQA0BfgaANQq+soy5lWNit9FXrDyVv9pCH9SBEo7LKJzoWp
         kYEKkU4SkVUZOdP09PJXwAWQIqmIXKWUh4LvJzDNcbwjcMd3/UVzh1Hukzr2gGQ32ISM
         6INItWmL3+M1k0rU6QfXwO8nYxFAdG6WJJTsLVcCkofiMP7s9klx9C+K00h7b3tuhXjm
         WtovzLN5LC+ZM4deguYuC8O98ir9hS6Z1s2PCB+xsi+duhm+JgVjph2bk4nrqb2aKrUb
         gc1xujjMqnvttnQdMQsTKmoMLOhgIVrkLP86YR/i8ahNoXbJ0bm4g8+ikxTWUKpNWMKA
         K9jw==
X-Forwarded-Encrypted: i=1; AFNElJ93ZzB0Rx+PaVKGtRJMwfkqTpbHC+Wsf/bPLXtBqbwGNbgepGxNlqUso1dF/vB5cFUBwQgUztQDpaaUZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXv6P/UrxVA4ONjtE4Q1+itQc4JqqipN+81mwR7sLdrNyABPJV
	tksMeFrEhHcPyLigUInqVaadBmLPhAxvC2phHVDDzwyttySK1UtHhCi5amqThF7iwwQ=
X-Gm-Gg: Acq92OG8bThtDKYwRNuX1tQYSpdlpWJ7mHao06S7/aCaO/NZZ2Zo5pSz9X5TFh1XRLO
	lgTKaJP7JlBRmNb73yBxi9YzEd4FMcpDSNFGxB0pEQ0HLvMOE+BX6zqkPnfCYI+Z/fsQ6kulUf0
	PtYMtyTNXw+epiZ6mGklIA7D6QM5PP+44H5G0UcajwjOsDa3PXGnuN3r8yZveP5VLHdLld4An/J
	2MQc5eWp+GiOkYz5+k1afzRcNMqEuSdnrqAKEKLhxGnHJM2LqtQHPpIAja2OHlT64T902SdGK7F
	qLMEPlxC5AYlcG5RRgGa33+4ZpA0lfHSo7wy9suMF33KdT9OjZeSXonzw/I0tkYxJfEOwFKfqcC
	RRMyMdhZUoMLeBFpOzxDVL0tb6nFsGto8hnVfviQTBAUEhGAxGqN7bNqtt2Kk+k5Ww5eFapVL3e
	zewxY89gHlZAYKn/XtqC8HOisX2cOLsCASvIwl0HXp4C4/zJjuhM2GwRS6barzyTY7rSRL
X-Received: by 2002:a05:600c:4706:b0:490:3fdd:d344 with SMTP id 5b1f17b1804b1-490424851e1mr156009965e9.1.1779829035120;
        Tue, 26 May 2026 13:57:15 -0700 (PDT)
Received: from ?IPV6:2001:1a48:8:903:1ed6:4f73:ce38:f9d4? ([2001:1a48:8:903:1ed6:4f73:ce38:f9d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5584b8sm848568f8f.11.2026.05.26.13.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 13:57:14 -0700 (PDT)
Message-ID: <8b780901-8184-4908-8bda-56fac42fe6b3@suse.com>
Date: Tue, 26 May 2026 22:57:13 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: partitions: replace __get_free_page() with
 kmalloc()
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260520-block-v1-1-6463dc2cf042@kernel.org>
 <ahPnX-CwVgK-9chp@infradead.org> <ahPxmSqT4Y4jcAbQ@kernel.org>
 <ahP3R2nH8-bHMVf0@infradead.org> <ahQX_JCgS9JWIhY-@kernel.org>
 <1dea9df9-18c2-46f5-bf47-abb3f088574b@suse.com>
 <ahWwD0eqj3cUgaKn@casper.infradead.org>
From: Vlastimil Babka <vbabka@suse.com>
Autocrypt: addr=vbabka@suse.com; keydata=
 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
 pYekxJujNeEDkUlky0Y=
In-Reply-To: <ahWwD0eqj3cUgaKn@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/26 16:37, Matthew Wilcox wrote:
> On Tue, May 26, 2026 at 02:07:36PM +0200, Vlastimil Babka wrote:
>> The main reasons for switching AFAIU would be related with the
>> folio/memdesc conversions? If one needs just a kernel memory buffer,
>> kmalloc() it is, even if it happens to be page size. Page allocator
>> should be only used if you need e.g. the refcounting or anything else
>> that struct page provides. But then in some cases the memdesc conversion
>> would need adjustments at some point. With kmalloc() we can forget about
>> this user.
> 
> No, I think this is unrelated to memdescs.
> 
> I've seen a few people say slightly wrong things about
> folios/pages/memdescs recently, so let me try to clarify the end state.
> 
> I do not intend to get rid of the ability to allocate a bare page of
> memory with something like alloc_pages() or get_free_page().  It's
> just that the struct page associated with it will contain far less
> information (because it's smaller).

Alright, but isn't it still the case that if you don't need any of what
struct page provides today or will do in the future, it's better if you just
use kmalloc()? I thought you said so yourself?

https://lore.kernel.org/all/aPQxN7-FeFB6vTuv@casper.infradead.org/

So what exactly would your rationale for "Most of them shouldn't be using
get_free_pages() at all, they should be using kmalloc()." be?

> https://kernelnewbies.org/MatthewWilcox/Memdescs has a bit more
> information, but to distill it:
> 
> You get a u64 worth of data (technically one per page, but if you
> allocate multiple pages, they're all going to be the same).
> Bits 0-3 will be type 0 (to indicate that it has no memdesc).  
> Bits 4-10 will be subtype 2 (to indicate no information about owner).
> Bit 11 will be clear to indicate that this page should not be mappable
> to userspace.
> Bits 12-17 will store the allocation order.
> The top few bits will encode zone/node/section like page->flags
> do today.
> 
> That doesn't leave many free bits for the user, but that's OK because
> most allocations don't actually need any bits in struct page.  If you do
> want something like a refcount or list_head, see the "Managed memory"
> section on that page.  If you actually want a full-fat folio, well,
> allocate a folio, not a page.

