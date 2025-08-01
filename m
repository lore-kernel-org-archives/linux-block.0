Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A09F20326
	for <linux-block@vger.kernel.org>; Fri,  1 Aug 2025 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754062255; cv=none; b=MFqJhizMMcSDGpiqFqjjbZFaLb7DHZK4F3MQ+j/mm0EnRVi9lrbI0n5ZR8MIEchWQW8UTervitQ+G7g1Z0I1c0QnspK6D4E7RZsQ/huxcl1uvHi54DwvrYNgnWy5X3oVH8W6dSgPs7TNjCebIpia+WXkDw6fglAOUbBWQUCwjF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754062255; c=relaxed/simple;
	bh=7akrvybSuCww6Aao3DyWFeiL7vWdSkmvf97d4yc+JYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fdX4z+nzV3GatRBe0n0IdToNTbGfNHzxHMQEM0VHEYIwPGtcKQlnkk3Mn8m16FBjvRtm83X4FBphqwhgpGKOEZbRwWEhigzBATn6oIUw41V9FmIOkebleUnvdG2HfWtbwbfopUxr+LMFgKzmkNzwSw7YzyHWSSVvUUQcVuuQxV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aRxfUs9T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aRxfUs9T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754062252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TCi1+HoXdkRVSSOUpmZn555kzLpizeDbqqPts9w0KWE=;
	b=aRxfUs9T6Q26DjLMQn1sXRVROgZLT4j5A45i6UwEqIg7MnPddcebV8NCuAjMJu3POSoWhG
	U4zCa9gZy1gZFx4I2C7wmzFqFFLIu8dfNqa9eM1KmaDzUB5/5iuSNLzqeroMZ5rW849sGL
	gnWanJ7M7ZwjWala1spkpilH5pFX2Wo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-t32StREuNy2Xrt7Y5gEN2w-1; Fri, 01 Aug 2025 11:30:51 -0400
X-MC-Unique: t32StREuNy2Xrt7Y5gEN2w-1
X-Mimecast-MFC-AGG-ID: t32StREuNy2Xrt7Y5gEN2w_1754062250
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4560a30a793so3453745e9.3
        for <linux-block@vger.kernel.org>; Fri, 01 Aug 2025 08:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754062250; x=1754667050;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TCi1+HoXdkRVSSOUpmZn555kzLpizeDbqqPts9w0KWE=;
        b=DTqkvDzoqYwgxLtfLKPZ0QMaGYs5CH3hTUxHlgiYg51zjZd1h8ADc9TYDYSNpLicP5
         I1rDOqFuepn+tuGqEmDx0e09Lx0sf1kI4WMA7lvERZpsR/7aRr7OW1YFeBHBDI+dxNq1
         cApIZS3V47bT3VqDhgwqF+FqVyfWpz07HEHZeKkoHTrZtiL328w8/BPeU1z41K3Ai0W2
         SpdgF46xJQUIJjrT5Ddx/63q/vx1+AJH/TXrgdFT6RA1wvC1kSktcwOPG/oe4TTdkL2D
         p2LJdAOo4GvtzPrLeSa/z9gwKa6RYmB5oNw+P6DeHDi4gPfb8/XDuUDjCexPIsEdI2CR
         D60g==
X-Forwarded-Encrypted: i=1; AJvYcCU/t6aX2Ha089g18vNBE8PasOGbE1o5Ba9oJxtFKJ6QiyYudQzviiTU116DG9M1kRPDpmiiwvkXGfIVYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Wb7WS8AOyZwLe2h3gS5cGJGznsBidl62cYkaxFAVE9btZRJX
	qYIUwSl0wsFhpuGruOiiEa8V417mgSMHelLJQqIP6g0qECrp1GSfRUv+JNZuEfFrd+NXl6g3kUx
	rbbM8a4pDZr6bWkV+ZayYO5xLlaiYxZ7NUdE2YYHkWdv6TOx7vQN9lknaKZ4CsyME
X-Gm-Gg: ASbGnctphH2fJVy92zEZJCfu2x3kRLbfVMS2WyrVMjYKluBnFmq3bxP1K55zFoOHM35
	alHuZU/HjGjqo5ichiv1pSt6gZUkU3jmEqoG5fRtLMgBKRiaUwhmwvOZqc7BfTPvFhGw0pwCM++
	zeCK6jNP8kJINRThv/z8Nk2hsi/b9Pu1+gDqbjg5gY5an5XEnkiMiF6i7OqUEcL6iCZHTrKoIn5
	0cEilu/sgryQxPZ9FZkTX0jRZAvOhRAr3ORGbsXkxY2wSTaIt7MGxn2AsOt/4F3VyaHCBlSUcxa
	lLmPpEdbRe4DXEVH3zv5WKt5UhhzUiBruEkBHqg6Cwgm5A7nFlQSxbQ8vfikwlfhSDGFzrHm4MW
	SeBsLD5B3qRR2fHWgC2ANqDLmog9EvoU5//6+c+tqR4jKkVV/c3JGtb3SKoFwHs2k
X-Received: by 2002:a05:600c:8b6e:b0:456:27a4:50ad with SMTP id 5b1f17b1804b1-45892be4bf9mr92153795e9.33.1754062249732;
        Fri, 01 Aug 2025 08:30:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUB5TcsYvRJNB+TvTZn9gO82Mj1g+cFuoQumEuT1Z47ONxoVqJ+Dm0x1gQESNybtDTjIpcKQ==
X-Received: by 2002:a05:600c:8b6e:b0:456:27a4:50ad with SMTP id 5b1f17b1804b1-45892be4bf9mr92153235e9.33.1754062249262;
        Fri, 01 Aug 2025 08:30:49 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:7500:5f99:9633:990e:138? (p200300d82f2075005f999633990e0138.dip0.t-ipconnect.de. [2003:d8:2f20:7500:5f99:9633:990e:138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589edf54bdsm73593495e9.6.2025.08.01.08.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 08:30:48 -0700 (PDT)
Message-ID: <88296851-3bbe-44fc-a507-70964c0bea8c@redhat.com>
Date: Fri, 1 Aug 2025 17:30:46 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/4] mm: rename huge_zero_page_shrinker to
 huge_zero_folio_shrinker
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
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
References: <20250724145001.487878-1-kernel@pankajraghav.com>
 <20250724145001.487878-2-kernel@pankajraghav.com> <87v7n7r7xx.fsf@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <87v7n7r7xx.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.08.25 06:18, Ritesh Harjani (IBM) wrote:
> "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com> writes:
> 
>> From: Pankaj Raghav <p.raghav@samsung.com>
>>
>> As we already moved from exposing huge_zero_page to huge_zero_folio,
>> change the name of the shrinker to reflect that.
>>
> 
> Why not change get_huge_zero_page() to get_huge_zero_folio() too, for
> consistent naming?

Then we should also rename put_huge_zero_folio(). Renaming 
MMF_HUGE_ZERO_PAGE should probably be done separately.

-- 
Cheers,

David / dhildenb

