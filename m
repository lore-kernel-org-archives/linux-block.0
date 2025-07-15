Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2DD2882D3
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 14:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588399; cv=none; b=rHLv7UQN6SpBGvtOz3w8xu4/I6pxaP/Gmr0ApU/DTY16bhsm3JnAik40F5mCuyW3SKmTugyzs3MVG5vYGLgcnpVKcW8fDL8NRCqAUxr8D3yopmeBAAnyL1ErmS8rUUgARwo0Yp+v0dUoT5EG7+Virn3bYdey41vRWGzbXrrf7LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588399; c=relaxed/simple;
	bh=NGjl+k0iCeICYYeTIxSQzRMo78FaxzR0hHeAkayY7lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u8aHFLyG5flCLH/25DOO8gZ/qW/T4/TjOfgXkwxV/nzx4kQpzVK4N7TSJPlZ6WiPzw2HPHd6xGqCtIoghlzbxzuEFfwxerDNnb5pDIzi2bf3Q0dbiBxPGyvBTmM0lCk6opC18NA+qTkwPQ24rIFT2cy60XfKtYRNIfc+IDcM6QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EMaTk7ct; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMaTk7ct"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752588396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lBxA7fPx+kaOUHpIDxI1a9myrZ8g1CRn9224twnAPJQ=;
	b=EMaTk7cta1r5smvunyue5vdiU6h7iUpu9ThKEJV7G1b2ub8gNZMW++5WPxQ0E+9kx20zww
	tPguloWw0+/YFYN4uhMBVIcua9FH1uOmqAxp5u2H3Kbaxp4n4pRFVBt+rDpow3bZgPA9AL
	HCoD/8I4COsr7HrZsbIHZlsmwJ0cCew=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-PlZU0DEZMmCB1eVYE5sOvw-1; Tue, 15 Jul 2025 10:06:34 -0400
X-MC-Unique: PlZU0DEZMmCB1eVYE5sOvw-1
X-Mimecast-MFC-AGG-ID: PlZU0DEZMmCB1eVYE5sOvw_1752588393
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a50816ccc6so3401149f8f.1
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 07:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752588393; x=1753193193;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBxA7fPx+kaOUHpIDxI1a9myrZ8g1CRn9224twnAPJQ=;
        b=g5H9WlHgos/3CgG8M8om4BoO2uhK0An9wQbLbdgiQky3U64RjXx+pcGp/pTKMeZgJw
         zQM60HD/imP+w+n8qDyDyTkWUYBD0fkjU9Ny8wX0V/HVEUsmUHY3JEpW3PChp52uC7LH
         AjaMmehakFK+fr6JQ4XegbL9q9lTh1Ln12kc+C4q6ecGKCMQ3u7+bvpWK/tmaMZhsdQc
         hhMZEVbncOgddsiPMKXJqVr7QCsiRAiPeUkKB1FxIc6UXIrLx3itgvcpgDaexVI+msw0
         qQtq36dUFODRuaOGVUqDWFLuOkMXUE16VFZtgiQwvaXaFaid1y/nTUP950IoL+tSy6dj
         hrEw==
X-Forwarded-Encrypted: i=1; AJvYcCVsu5DXEFy9KVkCPPLIk78SIhHQJm3X3yW8ceRl6tJXdwqNdzksrsmin5gSe5nlTXsI61brpYp3ygIY1g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4/T5OsGP3Xk8NVe7YnNfQvEfHZAILr5mVzM1ssSujzUpBMZTu
	TXVL06oVhUx/rcM+sLZIkIh8oUyPlI7DY0fdBhpfi7JV/ImurfynyjgRWzBbpMbClZvi5ie855U
	s2nS1fTiAZb1/veFiQHdiV+Zcf7KaNCXFlC1pQi9WLAMV4mU3QYTsWV7AoRez8iBt
X-Gm-Gg: ASbGnctzoAVJD8EP5ewkNoXYWQ1VxFQR9yIQawUBdkhWBNlTqnDxin1RV8D1bemiXzE
	8h4PnfZS5GB0EMe/PLnuBAwfZtAp+d3EjVM5dRfYXnWeGNJCG+3TBUPmcQRtNboNpxOBN3VB3SA
	T4yZTmIcOo1+tMoIydLih0qHw/4/+5gxK2iJWtdU36twtvVjLWc62D0nUAdWq/9uWx10g6Fn7Q8
	AexTXQlyrEUqULpU/CXk7tGCyvzixcTKfxYiCXTlbdBuhLbNwqseav2ru40+4yhXftkgZXflVXg
	y96Sx71RIvo/5DtYmd07AEb6xhioLAXPNvvvtRg+c01woaaHq6EYmgsdzK+eKdQ4PLYkuv2iEgW
	Co6V+h+oUGIaNuCHh0BTWKduAPzIydNRe/jawvgzCTH/ZEtIZ28rELy1c/rKjV9ASolw=
X-Received: by 2002:a05:6000:2085:b0:3a4:e667:922e with SMTP id ffacd0b85a97d-3b5f2dacddamr13012967f8f.4.1752588392991;
        Tue, 15 Jul 2025 07:06:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWK4HuTxAUxy5B//ipMMWWwodJ7JkwfIbQV6DrOEaPS5dsc6t+pb8z58e8T3W45U4i7z4JQw==
X-Received: by 2002:a05:6000:2085:b0:3a4:e667:922e with SMTP id ffacd0b85a97d-3b5f2dacddamr13012870f8f.4.1752588392263;
        Tue, 15 Jul 2025 07:06:32 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc217esm14797863f8f.28.2025.07.15.07.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 07:06:31 -0700 (PDT)
Message-ID: <c3aa4e27-5b00-4511-8130-29c8b8a5b6d9@redhat.com>
Date: Tue, 15 Jul 2025 16:06:29 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] add static PMD zero page support
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Pankaj Raghav <kernel@pankajraghav.com>
Cc: Zi Yan <ziy@nvidia.com>, Suren Baghdasaryan <surenb@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 willy@infradead.org, linux-mm@kvack.org, x86@kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <F8FE3338-F0E9-4C1B-96A3-393624A6E904@nvidia.com>
 <ad876991-5736-4d4c-9f19-6076832d0c69@pankajraghav.com>
 <be182451-0fdf-4fc8-9465-319684cd38f4@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <be182451-0fdf-4fc8-9465-319684cd38f4@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.07.25 16:02, Lorenzo Stoakes wrote:
> On Wed, Jul 09, 2025 at 10:03:51AM +0200, Pankaj Raghav wrote:
>> Hi Zi,
>>
>>>> Add a config option STATIC_PMD_ZERO_PAGE that will always allocate the huge_zero_folio via
>>>> memblock, and it will never be freed.
>>>
>>> Do the above users want a PMD sized zero page or a 2MB zero page? Because on systems with non
>>> 4KB base page size, e.g., ARM64 with 64KB base page, PMD size is different. ARM64 with 64KB base
>>> page has 512MB PMD sized pages. Having STATIC_PMD_ZERO_PAGE means losing half GB memory. I am
>>> not sure if it is acceptable.
>>>
>>
>> That is a good point. My intial RFC patches allocated 2M instead of a PMD sized
>> page.
>>
>> But later David wanted to reuse the memory we allocate here with huge_zero_folio. So
>> if this config is enabled, we simply just use the same pointer for huge_zero_folio.
>>
>> Since that happened, I decided to go with PMD sized page.
>>
>> This config is still opt in and I would expect the users with 64k page size systems to not enable
>> this.
>>
>> But to make sure we don't enable this for those architecture, I could do a per-arch opt in with
>> something like this[1] that I did in my previous patch:
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 340e5468980e..c3a9d136ec0a 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -153,6 +153,7 @@ config X86
>>   	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64
>>   	select ARCH_WANT_HUGETLB_VMEMMAP_PREINIT if X86_64
>>   	select ARCH_WANTS_THP_SWAP		if X86_64
>> +	select ARCH_HAS_STATIC_PMD_ZERO_PAGE	if X86_64
>>   	select ARCH_HAS_PARANOID_L1D_FLUSH
>>   	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
>>   	select BUILDTIME_TABLE_SORT
>>
>>
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 781be3240e21..fd1c51995029 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -826,6 +826,19 @@ config ARCH_WANTS_THP_SWAP
>>   config MM_ID
>>   	def_bool n
>>
>> +config ARCH_HAS_STATIC_PMD_ZERO_PAGE
>> +	def_bool n
> 
> Hm is this correct? arm64 supports mutliple page tables sizes, so while the
> architecture might 'support' it, it will vary based on page size, so actually we
> don't care about arch at all?
> 
>> +
>> +config STATIC_PMD_ZERO_PAGE
>> +	bool "Allocate a PMD page for zeroing"
>> +	depends on ARCH_HAS_STATIC_PMD_ZERO_PAGE
> 
> Maybe need to just make this depend on !CONFIG_PAGE_SIZE_xx?

I think at some point we discussed "when does the PMD-sized zeropage 
make *any* sense on these weird arch configs" (512MiB on arm64 64bit)

No idea who wants to waste half a gig on that at runtime either.

But yeah, we should let the arch code opt in whether it wants it or not 
(in particular, maybe only on arm64 with CONFIG_PAGE_SIZE_4K)

-- 
Cheers,

David / dhildenb

