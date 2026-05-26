Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2A13D6489
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 12:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779797260; cv=none; b=Yu0dGlKEOn98tcM+uJe1cLCIttLxueQ4s52ygQAsRKxozqd7XbhkWqLQATqI/c7PcoevjRtQ6l3KfDtP3vpR8M89qbh/+6EPI2XvysTPkdkISvSCy105EiigmlxDX3dk3EYc2lrPm2D0IISBWdA4mfIJY/OoWBTJd70HMyQKljE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779797260; c=relaxed/simple;
	bh=TGKilWqHCNmwW2kaxE8OvKst4U2AzAghy0Me37K4aOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9lJlLz1KS7TxOGZVAVozvuWS6nFu3dqdH3f4vk3eFxMF6W5nXOMHSc4sl60NsZtD/wOB7ZAAiEJvLhYEp43kzx5Tw+3i7y2aSB4F0LtwOVf8NfZ7ffO3w/shq2WN/TB0y4hr1cdjxUI4xryCCThUzqPBvqj96J0R5m1HQukjaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wy9+6tn7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wy9+6tn7"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48962cd0864so9597755e9.1
        for <linux-block@vger.kernel.org>; Tue, 26 May 2026 05:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779797257; x=1780402057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HdCzA4cxs/UXVY1rBI+ynwKuOH0VRJEDWv8W0sC8Rh0=;
        b=Wy9+6tn7hS1LDxQKI/Pob7NfvVVxJJh3hT8V4rm7sP5Mi4l2Y0WGs4VCMfgIOE8For
         Kytn5FxU4eWeF9APwqWZVHKqQibIMQcPzaV/LqgdN9+byjn2ZqjPo5L2jpCLzkFC1yhH
         sp0bJHmYROhUKXoNudt/XBjsqYGP/5ASjcYwHwJcyhpQeAb5O8ih8AonFK59jTGsoIO1
         g5ua8KgCMqfVKLy2bc+zFNibSER4cp080+mJC7pgd+u4/fc/CZLlq6zczQdgYry8gNnt
         LAH44Pnai7G4POWbAzdVMMrDZDilNLp+grMeq5UMk6SpbgXxRVPpGkYjFCKWyyHjHs0+
         TC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779797257; x=1780402057;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdCzA4cxs/UXVY1rBI+ynwKuOH0VRJEDWv8W0sC8Rh0=;
        b=PV49SkqC1IS8sLvdfQSNM6rgdYO4TenA/IsziKS4Gk2mR+wyiWdz+a3FlUfkYa2oAF
         +xqLKKHuG4lCTY0xLCi3k0aq13GmJKP8VZW4gJBGdNMuAwZL/PQ/EVK006pEuoAS+ydx
         DVxLoavaCjpOyI6SW2L1IQUCML51Jbl2ZYxr2Formqj+7FeALcjGr7ZKesvdUHCECxOC
         u1LLoWa7DZjwifX9r5our1+B2sQIV7nZk7MAdi0HmeHnn647fwxXMYNfB++sNXb/VOXa
         nhIUJDtmhcVxj6NfDwfDGUyq8wr18/ZWAETBlbdWr8eJTRER2WCJy1BOpoWVVsch9OHg
         m0Bw==
X-Forwarded-Encrypted: i=1; AFNElJ8TTr+bv2QxE338IXA4itjTNVNeZ55TIEbWeGGIXLFNUrgoD/YVZ8GSN/0HDzysKY5TsX3vEbtn/qjGIw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi80SP8OYmxNxUnTS6heghYBuhDvFOnY8Mji14eCC/dMiGVss+
	HctCS1rPPN6oTJpsjF26awgvnPkF/X7+erR3mveMDsVtw7LxMNFaHr0zPqPzAqitfVo=
X-Gm-Gg: Acq92OHjlADB1OZzt1V071wULhMb8xSAOHY5VX0fw3qwxdcWHrpWHJbMvMNwAA89WhN
	dkYNQAS5pNbR0H/hldzNBU2sbt9wpgavxv1txqzQXIwkXwShcbA9EQ1+vzdRhidWZKommmQtkDW
	GuHUYWBco5wKHDb4iLDqNga/232zzA3nu9sYKW99ZuMEE4bD0YJmV+iGExhMSPOKy8Kr162a2g7
	0obG4lBmUJlKmBdgD/PydJvBTEYYUGwZNtJx5ALeuITBMpZII0+iqK5OUIEVDRrNs9ExlKir0Cq
	yMlaVtMlhOh7VELRjJbB1f18tU9Rgb7sULY/ynmKNVNUXo1+l2Niq86cGeFyCEMwcxXUlQAb5q0
	m+gvhcX+P3jg+h4txRKWgMAhYC47lVFfzMx3Ydn25FnYeoYPZvrHDpPnDR0YN7dyQ5/iZCKNb/j
	wK2P2Ltd7+hC85EVcPocTYzg/0xr4xYhqTaGBFHMI=
X-Received: by 2002:a05:600c:b96:b0:490:4923:aa3e with SMTP id 5b1f17b1804b1-4904923ab35mr126128205e9.7.1779797257109;
        Tue, 26 May 2026 05:07:37 -0700 (PDT)
Received: from [192.168.43.36] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490452765f5sm332553945e9.5.2026.05.26.05.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 05:07:36 -0700 (PDT)
Message-ID: <1dea9df9-18c2-46f5-bf47-abb3f088574b@suse.com>
Date: Tue, 26 May 2026 14:07:36 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: partitions: replace __get_free_page() with
 kmalloc()
To: Mike Rapoport <rppt@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260520-block-v1-1-6463dc2cf042@kernel.org>
 <ahPnX-CwVgK-9chp@infradead.org> <ahPxmSqT4Y4jcAbQ@kernel.org>
 <ahP3R2nH8-bHMVf0@infradead.org> <ahQX_JCgS9JWIhY-@kernel.org>
From: Vlastimil Babka <vbabka@suse.com>
Content-Language: en-US
In-Reply-To: <ahQX_JCgS9JWIhY-@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/25/26 11:35 AM, Mike Rapoport wrote:
> On Mon, May 25, 2026 at 12:16:23AM -0700, Christoph Hellwig wrote:
>>
>> This does, but it still fails to explain why kmalloc performs just as
>> well as __get_free_page(s) these days.
> 
> I don't think that in this case - a single allocation on the cold path -
> the performance difference is even measurable.
> 
> Nevertheless allocations from slab caches are way faster than
> __get_free_page() (i.e.  alloc_pages()) as it's essentially lockless
> cmpxchg. Allocations that need to refill the cache do alloc_pages() with a

Probably not "way faster" but the fast path is quite similar - percpu
pcplist protected by spin_trylock (pages) vs sheaves with local_trylock
(slab), should slightly favour slab because spinlocks are typically not
inlined and local_trylock is.

The main reasons for switching AFAIU would be related with the
folio/memdesc conversions? If one needs just a kernel memory buffer,
kmalloc() it is, even if it happens to be page size. Page allocator
should be only used if you need e.g. the refcounting or anything else
that struct page provides. But then in some cases the memdesc conversion
would need adjustments at some point. With kmalloc() we can forget about
this user.

Matthew can probably state it better or even link to something
authoritative?

> little of slab bookkeeping overhead.
> 

