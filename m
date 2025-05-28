Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43DD22128A
	for <linux-block@vger.kernel.org>; Wed, 28 May 2025 20:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748464608; cv=none; b=fvXZsdVBZTQIcH9XiDFC0ImFErSbyU0bAKybMg5GNHIFPz5PoHkoTUX85kp1M9PMcfZJxRvKC2HZSbIVcboF2zzSBaZYUU7dMescZ77BuPe5o3aQZAuK5COI2iEkpXWHgtCkTCtym4qfAzd7mxjmSr3bpUfAOIbtEz6E7IMb2AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748464608; c=relaxed/simple;
	bh=LKuuiFod4XXbTge4GHdm/9QLj8tPwgj0K7XcZn50K68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/4Neu5IUeT2tdh1gtH+aGnB2aYBnC/3mTZESYmxJMo+3Os0OIldUiqJyDjKuMdbZkAuudeEcMJ12vnMddZy3p8byAdTdlXQMN6o8CJgUs3kQ1JnanB1qWmCa4pm8X0fSITMfLZEVMowqBhuNpNqVI+hQ7Mz67jTa6XCuQHsMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KCjbLJTp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCjbLJTp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748464602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iDHOfDzbDRVpg69jsOvmjB9r5MFng2zhSkjSqjMHIqA=;
	b=KCjbLJTpp7ns8JUD+KVn75xBEcBkclWphWXma3LOQ2fSRaM0+Zn42CixvxIkBJXW9H7oR8
	1bfxQvAvK0BjXFzxdB/l74uDMGUMfBCFu3STPRIrTIZ34wYTJc7NN+vIPVOrgAHkyBfBA8
	vd4Ye9TJRAV0o+TVkJOGa2QBLq43w5M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-wXAizTaYMYKMYU_3Xhf5oA-1; Wed, 28 May 2025 16:36:40 -0400
X-MC-Unique: wXAizTaYMYKMYU_3Xhf5oA-1
X-Mimecast-MFC-AGG-ID: wXAizTaYMYKMYU_3Xhf5oA_1748464597
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4d95f197dso128431f8f.3
        for <linux-block@vger.kernel.org>; Wed, 28 May 2025 13:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748464597; x=1749069397;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iDHOfDzbDRVpg69jsOvmjB9r5MFng2zhSkjSqjMHIqA=;
        b=Q3p7IVCFsPiB2hr7wgnJA5rzRvy12rgim3SQv/ebb32Ruy4a5nShFwZAuqHejLtTbv
         X0P3iqxyU9L+haaPbRWgqxDQfDIpLF5NRpKkgveP0jN6Sj/zg64xN8PqxmlQFBGjRSfx
         MSJMZq0JZkQejLni0e3IRKtMwIiRl7xtr7uh0Bkb3PPkvJenlhvr1qPvv7jJudcsfEoi
         +0mf7AcQxPek/HFUDxJkmNj6oO9c/V8D2jFEkUROTVNAWstaTHyIOpflHe4m2s5y+5Rb
         VqUoCmyPHZN/+STXXQnQ0w9IhT3o2+1rVohxcMQtDcFnjhQJinpZbGJkRwE8Rbx7mgYm
         jsTA==
X-Forwarded-Encrypted: i=1; AJvYcCVXqbLvroqX5QPi1uwzoST07dwaS4lc4JWUQRKyCtdpObLBjXc13kqOVf/Xmanpjx5R4RlIQn9lohT+ew==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWNUjjmKudDQXxuAblgziqYTGc5FbTcxEQ/GhdrOi1nGoPH8xz
	SacxkOs2BdDCdAiThBZDPciM85JpIIQMbkwXpQAbVnyYiyISChCkvJEfVZzjS76pqlZdefkLvmA
	rhZffiyH4RxCSxnsjZVUsZz9Byvm822LaShXl6/LqcBVX4o7SK9H4JbeHXcbnlINK
X-Gm-Gg: ASbGncvuMYqqpy/X/vHDo2vYEWOWN1JpwFiN9L+AO52GZjXeUbeoOvCoGKW4eLzP56t
	18biR70AJkoRpt7oiZ7wCTkd55+zbQ+baK9ts9jNzbqhrXdReob56OyuuotmuJBLfy9+KG8lqHP
	hMPg4nz2O3IFFeoUTWV9i/hUyZnr0mjceO5xpLo10gqG5t8prtxL3J6KgUOAorxjrv27n+qO7xb
	IoQGNLk39D5tDdbMZoY9wNCJgXvtjk+IP0A0vdGmRsToOEaqsW3Nsv9pK0C/iPHuLdGbZinU2pC
	89y86CjGPcKTYIC+zbVKrc/sXWSPAwydqxZgNJUWI0FomJgIwPKfILiulFSTFttHMQ5IrdApcyE
	XAmOJhKQguZZG+ZZ4X6mmVvCE325SQIbQoiE2IZs=
X-Received: by 2002:a05:6000:144b:b0:3a4:eda1:f64f with SMTP id ffacd0b85a97d-3a4eda1f745mr1926654f8f.30.1748464597165;
        Wed, 28 May 2025 13:36:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyw2FecFHjr2FE4rwo6929V09lCFuPkawv9vWLWEm5i38UkYZ4QCg7UaqjU3X8Av1gnPqQNQ==
X-Received: by 2002:a05:6000:144b:b0:3a4:eda1:f64f with SMTP id ffacd0b85a97d-3a4eda1f745mr1926619f8f.30.1748464596733;
        Wed, 28 May 2025 13:36:36 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:ec00:8f7e:58a4:ebf0:6a36? (p200300d82f30ec008f7e58a4ebf06a36.dip0.t-ipconnect.de. [2003:d8:2f30:ec00:8f7e:58a4:ebf0:6a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfbf4966sm1450355e9.6.2025.05.28.13.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 13:36:36 -0700 (PDT)
Message-ID: <31dd1efc-ccf3-4908-a06f-20dabac86ce1@redhat.com>
Date: Wed, 28 May 2025 22:36:33 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/3] mm: add STATIC_PMD_ZERO_PAGE config option
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Dave Hansen <dave.hansen@intel.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Vlastimil Babka <vbabka@suse.cz>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, willy@infradead.org,
 x86@kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de
References: <20250527050452.817674-1-p.raghav@samsung.com>
 <20250527050452.817674-3-p.raghav@samsung.com>
 <626be90e-fa54-4ae9-8cad-d3b7eb3e59f7@intel.com>
 <5dv5hsfvbdwyjlkxaeo2g43v6n4xe6ut7pjf6igrv7b25y2m5a@blllpcht5euu>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <5dv5hsfvbdwyjlkxaeo2g43v6n4xe6ut7pjf6igrv7b25y2m5a@blllpcht5euu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.05.25 20:00, Pankaj Raghav (Samsung) wrote:
> On Tue, May 27, 2025 at 09:37:50AM -0700, Dave Hansen wrote:
>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>> index 055204dc211d..96f99b4f96ea 100644
>>> --- a/arch/x86/Kconfig
>>> +++ b/arch/x86/Kconfig
>>> @@ -152,6 +152,7 @@ config X86
>>>   	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64
>>>   	select ARCH_WANT_HUGETLB_VMEMMAP_PREINIT if X86_64
>>>   	select ARCH_WANTS_THP_SWAP		if X86_64
>>> +	select ARCH_WANTS_STATIC_PMD_ZERO_PAGE if X86_64
>>
>> I don't think this should be the default. There are lots of little
>> x86_64 VMs sitting around and 2MB might be significant to them.
> 
> This is the feedback I wanted. I will make it optional.
> 
>>> +config ARCH_WANTS_STATIC_PMD_ZERO_PAGE
>>> +	bool
>>> +
>>> +config STATIC_PMD_ZERO_PAGE
>>> +	def_bool y
>>> +	depends on ARCH_WANTS_STATIC_PMD_ZERO_PAGE
>>> +	help
>>> +	  Typically huge_zero_folio, which is a PMD page of zeroes, is allocated
>>> +	  on demand and deallocated when not in use. This option will always
>>> +	  allocate huge_zero_folio for zeroing and it is never deallocated.
>>> +	  Not suitable for memory constrained systems.
>>
>> "Static" seems like a weird term to use for this. I was really expecting
>> to see a 2MB object that gets allocated in .bss or something rather than
>> a dynamically allocated page that's just never freed.
> 
> My first proposal was along those lines[0] (sorry I messed up version
> while sending the patches). David Hilderbrand suggested to leverage the
> infrastructure we already have in huge_memory.

Sorry, maybe I was not 100% clear.

We could either

a) Allocate it statically in bss and reuse it for huge_memory purposes

(static vs. dynamic is a good fit)

b) Allocate it during early boot and never free it.

Assuming we allocate it from memblock, it's almost static ... :)


I would not allocate it at runtime later when requested. Then, "static" 
is really a suboptimal fit.

-- 
Cheers,

David / dhildenb

