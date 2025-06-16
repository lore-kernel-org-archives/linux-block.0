Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD2F20D4F8
	for <linux-block@vger.kernel.org>; Mon, 16 Jun 2025 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750065141; cv=none; b=Qyoyr6ZJVRfkGO5l9YVTF2Hqy8eeM7lxwVRGEXX8X+/b38QBm62XEcIyLgcyWo8DJ5WyXTEYmysHveRYhMhJ7K4UpX5x/l7JMRTBrJFOGsHiIJ2sB/0/I7+Fjp99SpSGpH2/K2ISJC4ScVN7ooutcE8T16p3Xj4B/cNfGrmManc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750065141; c=relaxed/simple;
	bh=CxFtkUaoICplqKg6mBF/vpC5ZoSwtzbG+6E2tKXhfc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APNdh9/qPqMkfKXygaoU9N9+78u7t95yH2X3EqeZbSBRUbDupAqUvA8/ml0yBFj+YJfJ3A774GYJsI4DBCT2cnNIXvU9qmFygK6GciE1RjIH7+FDQt37XK6FMFqQF49rx/GqwN5wOMOktxDwRp/92wsbhMy5s5BVgRMgdcte84Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U72jMJvX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U72jMJvX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750065138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GQSoqKrp/ddRa/kh3o1Hv7MhPgf13bzJssOJZXJAf18=;
	b=U72jMJvXCWJSMiIpjrvTqN0oicy483BDrPa7lbMIVsBjn7TO0u3t+NeyatOODhS/Z92uqk
	/8KtHIko+Rc+LWW9st8oddognTSa5kQ6B6IqMa2jlYf+0n7SPkq+gy2i41QOn1j/LfFhrs
	QB0lFvNxl1MX3NnnqGG7mNofW60JiKM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-hBjIEjpiOy-h8QfU3eCEHw-1; Mon, 16 Jun 2025 05:12:14 -0400
X-MC-Unique: hBjIEjpiOy-h8QfU3eCEHw-1
X-Mimecast-MFC-AGG-ID: hBjIEjpiOy-h8QfU3eCEHw_1750065133
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451d5600a54so34931075e9.2
        for <linux-block@vger.kernel.org>; Mon, 16 Jun 2025 02:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750065133; x=1750669933;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GQSoqKrp/ddRa/kh3o1Hv7MhPgf13bzJssOJZXJAf18=;
        b=KvSQEPft3/Iaohq76SyE96dbd/UqfPSjvnGYfZ2qFXzKRJ6CzTUwD3/5nq8KCwsMb5
         dA/vYavFMFG0vLuGAzB8wbHMIk1/9NxFrYfVhAoNaEY5aGDfnQU3j7HzhAVRvHM8pDv4
         ZQNgG/TS9KCifP1Mztuyyz7JRJQf4vWE/awEtvmH6evrmsvMI+crJt1fqAkAqB6EWYcq
         ObaLCz5TU/4EhHQapSlo4ypxujC3csBmaLM49UQpiykxwvPmzylaU5bWaH2QIgHGbSHO
         OZgQwTpDMiJF8igDgqvqyI5SLuBkz42A1g4trpudEzLQ68Sun9iSB5u9ldcNsG9sBHsD
         TPzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0KfrcvUFTSJrRPspshwInIUL//kZP2hyNojAgix1oNYzjEy/vxgz6upJZZwHi6Rtdg483M4xC5YNi4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8CPsZPDHTz5qZ2ZuWeyyYJyaJ/uEfOLEze98l5ONpuXgNyK9Q
	QPSTxIV3XW4IXDY0Dm3Uh+crMxSrctmkxd9GlbvU/qRdixLpx6aaRenvO4+1OSbFGAdsTnZInt9
	6LQugVVNt4yCHjdVESF6FaekLPcJRjfilZyxb+fLQfW78c2rDWUsgdFjaYQSeyeb4
X-Gm-Gg: ASbGncto7b8CRyJn2Z7XG6xHjE+EMEinF5j0CRq0XlBmt8l+ie+HuLkajl2vokf0nnt
	hYHe2R8UMMVNbRDvZvWea/dYUPwcgqtJeAh0iRMSo4LyJULzKODs3VNNSeVubF8Yk76k1TF90Dw
	22hjrjbgSV7jYSZW4ufcLv8j3DTIvg7DHxW3j3xN6Atxz4HEW89M59HzJqGTSTMAXq4fTkKqhdh
	eTczEMDSbfzAeY2o29f21+tEk/0qmCLxXP/mVuug1xRlm6MeYOpQM0x6OFrcXZ6iT0peNUhI9aX
	v5eTh9IC1W7CA2bJyTw4ufYb1yAGr/JLnC5zfKsP4JPB/+R3GgHG34ip/eLyA6d+MB2l+1cOX1M
	RhVyrxlogSKCNpZDuc2xJxDNXIqh2YtynJ0JXagNTKx5km1U=
X-Received: by 2002:a05:6000:2286:b0:3a4:d83a:eb4c with SMTP id ffacd0b85a97d-3a572e9a4bamr6400185f8f.57.1750065132606;
        Mon, 16 Jun 2025 02:12:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHJYnIt9dUbHvTScNyZFoVWDPNSRLqKY7Pq9JphyPgZ3sOj2Aaa3+c8Ekp/l0yglOVh/h4qQ==
X-Received: by 2002:a05:6000:2286:b0:3a4:d83a:eb4c with SMTP id ffacd0b85a97d-3a572e9a4bamr6400152f8f.57.1750065132106;
        Mon, 16 Jun 2025 02:12:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:bd00:949:b5a9:e02a:f265? (p200300d82f25bd000949b5a9e02af265.dip0.t-ipconnect.de. [2003:d8:2f25:bd00:949:b5a9:e02a:f265])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532dea1925sm141877845e9.12.2025.06.16.02.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 02:12:11 -0700 (PDT)
Message-ID: <b128d1de-9ad5-4de7-8cd7-1490ae31d20f@redhat.com>
Date: Mon, 16 Jun 2025 11:12:09 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] add STATIC_PMD_ZERO_PAGE config option
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Dave Hansen <dave.hansen@intel.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
 x86@kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de
References: <20250612105100.59144-1-p.raghav@samsung.com>
 <30a3048f-efbe-4999-a051-d48056bafe0b@intel.com>
 <nsquvkkywghoeloxexlgqman2ks7s6o6isxzvkehaipayaxnth@6er73cdqopmo>
 <76a48d80-7eb0-4196-972d-ecdcbd4ae709@intel.com>
 <jpuz2xprvhklazsziqofy6y66pjxy5eypj3pcypmkp6c2xkmpt@bblq4q5w7l7h>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <jpuz2xprvhklazsziqofy6y66pjxy5eypj3pcypmkp6c2xkmpt@bblq4q5w7l7h>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.06.25 10:58, Pankaj Raghav (Samsung) wrote:
> On Thu, Jun 12, 2025 at 02:46:34PM -0700, Dave Hansen wrote:
>> On 6/12/25 13:36, Pankaj Raghav (Samsung) wrote:
>>> On Thu, Jun 12, 2025 at 06:50:07AM -0700, Dave Hansen wrote:
>>>> On 6/12/25 03:50, Pankaj Raghav wrote:
>>>>> But to use huge_zero_folio, we need to pass a mm struct and the
>>>>> put_folio needs to be called in the destructor. This makes sense for
>>>>> systems that have memory constraints but for bigger servers, it does not
>>>>> matter if the PMD size is reasonable (like in x86).
>>>>
>>>> So, what's the problem with calling a destructor?
>>>>
>>>> In your last patch, surely bio_add_folio() can put the page/folio when
>>>> it's done. Is the real problem that you don't want to call zero page
>>>> specific code at bio teardown?
>>>
>>> Yeah, it feels like a lot of code on the caller just to use a zero page.
>>> It would be nice just to have a call similar to ZERO_PAGE() in these
>>> subsystems where we can have guarantee of getting huge zero page.
>>>
>>> Apart from that, these are the following problems if we use
>>> mm_get_huge_zero_folio() at the moment:
>>>
>>> - We might end up allocating 512MB PMD on ARM systems with 64k base page
>>>    size, which is undesirable. With the patch series posted, we will only
>>>    enable the static huge page for sane architectures and page sizes.
>>
>> Does *anybody* want the 512MB huge zero page? Maybe it should be an
>> opt-in at runtime or something.
>>
> Yeah, I think that needs to be fixed. David also pointed this out in one
> of his earlier reviews[1].
> 
>>> - In the current implementation we always call mm_put_huge_zero_folio()
>>>    in __mmput()[1]. I am not sure if model will work for all subsystems. For
>>>    example bio completions can be async, i.e, we might need a reference
>>>    to the zero page even if the process is no longer alive.
>>
>> The mm is a nice convenient place to stick an mm but there are other
>> ways to keep an efficient refcount around. For instance, you could just
>> bump a per-cpu refcount and then have the shrinker sum up all the
>> refcounts to see if there are any outstanding on the system as a whole.
>>
>> I understand that the current refcounts are tied to an mm, but you could
>> either replace the mm-specific ones or add something in parallel for
>> when there's no mm.
> 
> But the whole idea of allocating a static PMD page for sane
> architectures like x86 started with the intent of avoiding the refcounts and
> shrinker.
> 
> This was the initial feedback I got[2]:
> 
> I mean, the whole thing about dynamically allocating/freeing it was for
> memory-constrained systems. For large systems, we just don't care.

For non-mm usage we can just use the folio refcount. The per-mm 
refcounts are all combined into a single folio refcount. The way the 
global variable is managed based on per-mm refcounts is the weird thing.

In some corner cases we might end up having multiple instances of huge 
zero folios right now. Just imagine:

1) Allocate huge zero folio during read fault
2) vmsplice() it
3) Unmap the huge zero folio
4) Shrinker runs and frees it
5) Repeat with 1)

As long as the folio is vmspliced(), it will not get actually freed ...

I would hope that we could remove the shrinker completely, and simply 
never free the huge zero folio once allocated. Or at least, only free it 
once it is actually no longer used.

-- 
Cheers,

David / dhildenb

