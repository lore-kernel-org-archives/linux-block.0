Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1342E78C91
	for <linux-block@vger.kernel.org>; Tue, 28 Jan 2025 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738057642; cv=none; b=H4p8Yq9oqxuI01cSXG0VfMFkVNQX0j2hqRLQQ6PgP4CpTWZIdR59g5rc2pqw7W+aDLwHJSZHfuMjga9sNE4Pd7MgI23kWg7UYeKRc++YFJi/f5OMNtBY5Q2L4TayJpqEG9bfjjVsIKRD9PLiU8CAJWlDs6Ko8NOKmCw/7tAd+ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738057642; c=relaxed/simple;
	bh=csdfJDJRcLYp1SBqTDmhEjLQGVSJjJ0yKrJd3jtGKTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7XcKlk0hVw4jfLndeBeSTcwYOVFw/+7L65DkCquDR2Oh82RQb3nqiOM/x8XfGu52g/6mEzce9fiX/VTy92rHAxhKaRH7k2FPFNHgQZhQmGGMvk6s3lWGzL0XkMTZBg/09g/+ShXGDMoa7ePTM/ghl5+IXmExrap7ngeaNSzDfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V9+vOfed; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9+vOfed"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738057639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WVOWkkrE+TIkSeiZWX/FWt30SOkhDf3aK6WbHWD9TC4=;
	b=V9+vOfed3qT7FdMGClemcnbEYZ+qh8kzjo9KLbxIigCxNBeiHx+crtTLKl5AAaLfOCm3J8
	aAWwbEmvjRfUM1lC0Qho8Cge/htnTiJt9wrle/XD6fJuzRsDzhuK5vkqAYHnqDXHN26/pv
	Zh4JINCmDHcTFAkunGxc5Vq1E2UuWfM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-ddpuHL0MMfWOGD5eTL9Gsw-1; Tue, 28 Jan 2025 04:47:17 -0500
X-MC-Unique: ddpuHL0MMfWOGD5eTL9Gsw-1
X-Mimecast-MFC-AGG-ID: ddpuHL0MMfWOGD5eTL9Gsw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4362b9c15d8so26286765e9.3
        for <linux-block@vger.kernel.org>; Tue, 28 Jan 2025 01:47:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738057636; x=1738662436;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WVOWkkrE+TIkSeiZWX/FWt30SOkhDf3aK6WbHWD9TC4=;
        b=kUh6VBK5VQ+CAA9sGIIS0dlxPBe/vbhKdZRLcuGs1pH2K91qKIAtjvddlv98cqhOlG
         V/oKhzHPMtADME4cd241MfDZVXfnDUZL1BhGnHfKwWtbPUbcfYxMMq8r2FvhxC24c3u0
         bMnj8aTLKOzeH0rIjc9PXEUVWDjqCg55DwJsfwRD8v2n73jjyWIrPIJb467xio5s/e5H
         bUPu8ohxiVv4dGA7wXGGeLl2LXdLi0SZm8L2CBaaqhtHRfzeYPruMk1JiYAi5Do3Zj73
         KROP2lNBBGf7sZxiGWK5ayx8ST+PKfDslAi98Q+DHZd3qcNLkhcYfxy4A+3uYQjeC/J0
         gXSw==
X-Forwarded-Encrypted: i=1; AJvYcCUqbyKdhpUyPhuA/KVkb68xtMy3rQyhjny9IDeexMkFjeAFoU1fo6T6/0beOyvPqEVXicyzIca58AQ0/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTh5wYx94mIabMySeVMkw5DM1EwLhLDouG+BKpkdwStBlc9dKR
	BfslAblB+VA5KzUsgsMTwY8Gqv+fO74Ss81kT44svvd92cjFnwZKAUhShdZmSoJA6L29oGmlKb2
	I1l1zMkdqx4LpsuFu3tjQAuB4+/0g9eLZfRCFBh2PYDvbk523krYvec3nrmxx
X-Gm-Gg: ASbGncu3w4FGIoL6+W90KWY7f49LUwgB6kL58Ipq+aUek74Q9MFDvpTyMnnj11EESrb
	TDviQdUPYg+GUQyi/aUjPOPqHo1bKmw5Dis+Yc2pZPzYCaBlsCLMEdwT6WvkGCj2dcaDBHsHyQI
	tKqRsGDc+qm5QswIVgENywIeGjfDzuyhRSjf7vY1+rUtKxdXsKZpbxVfZxPxdieiRkO3sZj3uD2
	bh86BJcX6D/22Hk773B9SX4ApIJ/i/HLhcLZ8ovDMLvHt3SFd81MYCaLkM7JVxA52Xm2JxNxj3n
	A7AhSLZg7JXbLvM8BDbzNfmJfzC4IHulX66N8ioXlW8YpgP6EfNDCn3Lq5J0Y2DbOAZdojwuMUo
	WY/FheGwejMSEPJcDUEKy98SX09AaGMfU
X-Received: by 2002:a05:600c:46ca:b0:434:a367:2bd9 with SMTP id 5b1f17b1804b1-438913dfd7fmr470318765e9.14.1738057636178;
        Tue, 28 Jan 2025 01:47:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+9k4APRw8xSMDaM5HWlZTt9Y6CtcxPipnQOKSFGJ6ZtbhcYT+5O5y29YAO3usm6mdVI18bQ==
X-Received: by 2002:a05:600c:46ca:b0:434:a367:2bd9 with SMTP id 5b1f17b1804b1-438913dfd7fmr470318445e9.14.1738057635751;
        Tue, 28 Jan 2025 01:47:15 -0800 (PST)
Received: from ?IPV6:2003:cb:c73f:ce00:1be7:6d7f:3cc3:563d? (p200300cbc73fce001be76d7f3cc3563d.dip0.t-ipconnect.de. [2003:cb:c73f:ce00:1be7:6d7f:3cc3:563d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd501721sm161002865e9.9.2025.01.28.01.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 01:47:14 -0800 (PST)
Message-ID: <d2471b37-15bf-4d67-932c-7e25c226db79@redhat.com>
Date: Tue, 28 Jan 2025 10:47:12 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Direct I/O performance problems with 1GB pages
To: Christoph Hellwig <hch@infradead.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-block@vger.kernel.org,
 Muchun Song <muchun.song@linux.dev>, Jane Chu <jane.chu@oracle.com>
References: <Z5WF9cA-RZKZ5lDN@casper.infradead.org>
 <Z5hxnRqbvi7KiXBW@infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z5hxnRqbvi7KiXBW@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.01.25 06:56, Christoph Hellwig wrote:
> I read through this and unfortunately have nothing useful to contribute
> to the actual lock sharding.  Just two semi-related bits:
> 
> On Sun, Jan 26, 2025 at 12:46:45AM +0000, Matthew Wilcox wrote:
>> Postgres are experimenting with doing direct I/O to 1GB hugetlb pages.
>> Andres has gathered some performance data showing significantly worse
>> performance with 1GB pages compared to 2MB pages.  I sent a patch
>> recently which improves matters [1], but problems remain.
>>
>> The primary problem we've identified is contention of folio->_refcount
>> with a strong secondary contention on folio->_pincount.  This is coming
>> from the call chain:
>>
>> iov_iter_extract_pages ->
>> gup_fast_fallback ->
>> try_grab_folio_fast
> 
> Eww, gup_fast_fallback sent me down the wrong path, as it suggests that
> is is the fallback slow path, but it's not.  It got renamed from
> internal_get_user_pages_fast in commit 23babe1934d7 ("mm/gup:
> consistently name GUP-fast functions").  While old name wasn't all
> that great the new one including fallback is just horrible.  Can we
> please fix this up?

Yes, I did that renaming as part of that series after the name was 
suggested during review. I got confused myself reading this report.

	internal_get_user_pages_fast() -> gup_fast_fallback()

Was certainly an improvement. Naming is hard, we want to express "try 
fast, but fallback to slow if it fails".

Maybe "gup_fast_with_fallback" might be clearer, not sure.

> 
> The other thing is that the whole GUP machinery takes a reference
> per page fragment it touches and not just per folio fragment.

Right, that's what calling code expects: hands out pages, one ref per page.

> I'm not sure how fair access to the atomics is, but I suspect the
> multiple calls to increment/decrement them per operation probably
> don't make the lock contention any better.

The "advanced" logic in __get_user_pages() makes sure that if you GUP 
multiple pages covered by a single PMD/PUD, that we will adjust the 
refcount only twice (once deep down in the page table walker, then in 
__get_user_pages()).

There is certainly a lot of room for improvement in these page table 
walkers ...

-- 
Cheers,

David / dhildenb

