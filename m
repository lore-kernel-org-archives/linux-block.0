Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6061E47AD
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590808; cv=none; b=kHZok5FT9ymqM/XLVInoUO38LR4pGLuLj/IUzabROsv1Pl4hyrt/JqfNSHn9lyvLVadvA0EG4CoCSs+fEuLwg7dL1MgmFakuoGX1kn+WO+27PBowBnAbA1nDaCOAO1iowrygU+z0V3xiIpQPJ6hK/SdtWzydjW1nsvfcwUNuvRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590808; c=relaxed/simple;
	bh=4Dx7X+adfNMe1QrirxtiVSDzHq+xAnMsYW1YjuFFRVc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KReSrHOiuxa8BgogugFa5aYEiiBL5yDpFcZuzZAET19EHRqoR5UxAsvNvQeIu/WElh4qsjuwEnV70IC4d0bvN9KcVPGctptWApLsg6e3D17o0XPyMku5MZMUHdCG03+HF7zfAdT27fCVvWeHRM+kR97eEqhNw4O6SNyz50fN1kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HZzXCqt0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZzXCqt0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752590805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pzGhqdPWIdp6qa4/aszQPMFbX29AViQCZYajzErY1Go=;
	b=HZzXCqt0IO+6rIn24nrQ4aod1aAiWcwuVWU7TXWE+Xu5v5x9Q0AANwR0Wquz7+IpkqElcJ
	hMm9Wg5TEretY9Hx870PpTnnuN7I1UUX4rhHXZ7nDHGy7htxh334PNtCll1mq26/gINNhc
	32Wrp69TVCwfl4NJSI201ZPZrv/bME4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-N3BJF0kKMl-t_LIv_a45qg-1; Tue, 15 Jul 2025 10:46:43 -0400
X-MC-Unique: N3BJF0kKMl-t_LIv_a45qg-1
X-Mimecast-MFC-AGG-ID: N3BJF0kKMl-t_LIv_a45qg_1752590802
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4560b81ff9eso20560965e9.1
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 07:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752590802; x=1753195602;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzGhqdPWIdp6qa4/aszQPMFbX29AViQCZYajzErY1Go=;
        b=Ob6Zuh+ou6pZaqAxDVG/fUbRY7MCnd1nICXkA29mcTq+1esbGJl8t8ySmeLsnEs7gh
         e5AJJsHdLR0GR4kR5CNeM6hmE2fGRSEOPaCFizPO0hQX63V2hwrwKXaC8W8bYwMFFGx9
         V6eWB0Vpx7drZzSfF7foLLrT0hXdv1Dyssb4eEso3cuwZlKLnltvXlq2ay/JoMsf/FAb
         xtZcpqeTeluegiSoZjfYu6Z+pMz4BbL202ikUUO2KXljH0Y2cwyuRMCtDOmZsWacoQg8
         GGKVrHvcQ3Cf1q+b+OYuO16Of58CJvbRXdLJAArteNOlJzf/KUZhVqRFVp2ayiMXufir
         WtRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXofCSCOdMnDtxLn4ryiO8UcVkjDmvjT19Nr6WOqRANgNOR5D+aUyw30XA7i9GN4toSTc3IoJew7Rr2qA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWGoHzakqjvjlRzJFRCp8NjL/kBtzQJyd8Uy9ffh1Z19feJLWH
	RXIqDRnyT82pzkTL7+pigbuOWQ4KK88pYB/pFgAa6PIM/K0qxY4KTDI3GECgbhZ4nAubOvfobSc
	GLpiLggX0xxJUFWTwgPMwDnDFJ+CTEPM2UnQiIfCklokKUcxZg3I3VVyLh0oPpjBB
X-Gm-Gg: ASbGnct5QDInoh5k7PtGPEYwqSt4z7NgJoakqcxbfhL/UjTexXPdFFbWwh3ZAlCstwb
	oWXp9Loaiu3g/LnPlNDNehCgfugbZ61grE+XkdK1vsj2Qz/yg9OJ34wrwHExbrZfHvb9my8FF0O
	dqZNRmlfTEqUc1N72qKxcclR5DVC1lBhLwxQbaZWyPtwm8n4Sy84i0WXTtOoUfT08jM6iF5sWcA
	/YuFoPa4J2sbHKuDg8kCriDxWJJsiHQQrdXl2wXFz2NX+ozFSHdWTn5Sg1RpXFcXSa7e9NmPiwL
	wCcevsGYVghcAmmfB38OZWpI7eK1WVEwnJiV6HFe10prBZS6ENdLzBX88mEXKuP1dP9z5dqUK1Z
	shSm5LRBDr/aF04QUWWniqimJS18kbOlCtTDov8+6I/V3PQf1gS+K1RgbLNXqK9u8M6g=
X-Received: by 2002:a05:600c:1913:b0:442:c993:6f94 with SMTP id 5b1f17b1804b1-4561a16064fmr92241275e9.12.1752590802054;
        Tue, 15 Jul 2025 07:46:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqjgRt6fG2l+5726ftG86wKHrZnvMgD5gCYV3wjOd0XaKxS9B031j2vkd+aj4JONoIpTYuyQ==
X-Received: by 2002:a05:600c:1913:b0:442:c993:6f94 with SMTP id 5b1f17b1804b1-4561a16064fmr92240845e9.12.1752590801526;
        Tue, 15 Jul 2025 07:46:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b600722780sm7615699f8f.23.2025.07.15.07.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 07:46:40 -0700 (PDT)
Message-ID: <bfbb1fa6-6537-4714-b5ff-a386a86c06c8@redhat.com>
Date: Tue, 15 Jul 2025 16:46:39 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] mm: add largest_zero_folio() routine
From: David Hildenbrand <david@redhat.com>
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
 <0793154d-a6ca-43b7-a0c3-01532d9cccc8@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <0793154d-a6ca-43b7-a0c3-01532d9cccc8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.07.25 16:16, David Hildenbrand wrote:
> On 07.07.25 16:23, Pankaj Raghav (Samsung) wrote:
>> From: Pankaj Raghav <p.raghav@samsung.com>
>>
>> Add largest_zero_folio() routine so that huge_zero_folio can be
>> used without the need to pass any mm struct. This will return ZERO_PAGE
>> folio if CONFIG_STATIC_PMD_ZERO_PAGE is disabled or if we failed to
>> allocate a PMD page from memblock.
>>
>> This routine can also be called even if THP is disabled.
>>
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> ---
>>    include/linux/mm.h | 28 ++++++++++++++++++++++++++--
>>    1 file changed, 26 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 428fe6d36b3c..d5543cf7b8e9 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -4018,17 +4018,41 @@ static inline bool vma_is_special_huge(const struct vm_area_struct *vma)
>>    
>>    #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
>>    
>> +extern struct folio *huge_zero_folio;
>> +extern unsigned long huge_zero_pfn;
> 
> No need for "extern".

Scratch that, was confused with functions ...

-- 
Cheers,

David / dhildenb

