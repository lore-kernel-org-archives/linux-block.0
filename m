Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C681C5D53
	for <linux-block@vger.kernel.org>; Mon,  2 Jun 2025 20:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748896141; cv=none; b=hfM0/LtvhEBl0YJO2opH5GjHATGNZ6q/on09AC6Z3ruXbyqr561y5NminFyjtCREO78gEp98cMBJCbqEb21CAoG9BF9ZHRo2OqrOh6NIpsMevfNDld8Q9EfQyskZVA9hrHs/8bS59cZSSvRUvKFaKSj1xJ3jw/xuzyajgByCw5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748896141; c=relaxed/simple;
	bh=NaSlojcZ0ifXJIZoD0hyUTGOTRKGEAzb/GTIaXrEKDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JlBjKNYA0fs9LH+csDvnj6yqZumt9JxLJjVKy5yDm3WHZsfhlVMoGB+qFlezQHRD8pxV9+OmCxH6ta3Vp+hjy/OVzniGDrNCSwKjbQ/9QFko18o6tw2XVvNeVewzK68EVaUtFaMNzX+RrPB890x5eNCPCGuYYF7X2sZZy5MSKM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jn3Uvl6i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jn3Uvl6i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748896138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=i+jLNp1+bBkMPcUNLnkWqh9V3VeeeCz8sfTBLH1Dubg=;
	b=Jn3Uvl6iJ1w8vvyXHol2S9Sx+n1qazLfc5psTy6GRzs/2QUwAvnqbyckLYz55nKfnRDLlH
	z/ENmbps+hmFLJ3t+kcTcnVFdqapk1QK4ZEhneST/PjxMStoXcAEm+GGgg7cd0EcTtKOFu
	jV2tZWQNAggMsNwK8tgdrl5g9PRVrF0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-ICeHXQhkM2-e9BoLGv4Hyw-1; Mon, 02 Jun 2025 16:28:57 -0400
X-MC-Unique: ICeHXQhkM2-e9BoLGv4Hyw-1
X-Mimecast-MFC-AGG-ID: ICeHXQhkM2-e9BoLGv4Hyw_1748896136
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f6ba526eso2457503f8f.1
        for <linux-block@vger.kernel.org>; Mon, 02 Jun 2025 13:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748896136; x=1749500936;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i+jLNp1+bBkMPcUNLnkWqh9V3VeeeCz8sfTBLH1Dubg=;
        b=mvNq+1VzTFaIR94XWOFaaJa19PKc/jUyNA3xCbBESvuVw2QCZ+pnjYNSRMSZeWziCa
         r+SG8p1K8crDYL/42h/Xec5SfZvavjhP3XkWnk0sabSmMTYJkgUQebgvQ7oWVjQrMaDt
         C5ZzwcO0QpLH30MeHSx+oRXk9NRcA8WXO9cr7W/l6wMZG+lxN39nqx3EshG3eqX3Ux2/
         GqaJ3gUMLhVd64BlerGLfPYX8NAm66ztPUflBMNd0Pd03EwntO6nBz8qkf1oJmCid9Ps
         t02r+1syXKSXasql9lCp0Bnw9aSzK8E7sJUPtF275fsSmvdgRebq4KIrMA8d19JDNtcc
         PuPg==
X-Forwarded-Encrypted: i=1; AJvYcCUxU0fxvDcU0jHI+Y1jFqI+JUWC0YEGTPNTjaavEXZ2II7R08rwhzLC47DnbqsCPkqIclcFnwqGH5QKnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLIzE6wP73Rat45rmkBCZEqrwJmz3dgiSalUKjLVHbgJB9jbV+
	b8pWmep7MU+bQqxjQ0L4yco3IgSPh8gZzhWUzNjEnbkeNsk94lO5Z/IKL3rWloWnOHjgt4MLWnq
	gzMwFcU6ssJBOiy4Ct+kDa/bqoGI6d8Ti7kKx+TSBRfsT3y0flfC1Dc9EnVz7A/wd
X-Gm-Gg: ASbGncvAfFSP2rS5S+iC8LOZE0cTq7AxFasTHqoAiyBE3/pLte1siZcmRsXWYme+luf
	oMMuuB/FjkFTpcptYwnDdbUsGIqrtn/dUB8F2fDpwjPt1A+AfcYc/iwE0q1A71wCfwJUB85D+Ko
	dmVjnQlwf2+W3MuhnhTVVs8Cyy401AiyNVDx/RGXD39DdpZeWOmwfy5kEtCL0gGkRv8h/Vp0ew2
	qutBppi+tufs7mu9WO4jzmXTa1jYhgPbMcSnsnamZLhiw6LFF/L8J1mkwHcFjygLMiycssjk0jx
	CZJSkJEYqPL/a3UV7x3GCjL9utjk/W+XhKz2c1yhXOr0bxdc7t1B9VaFd4fZmGyimguOBd010C6
	50Woi8DfhxSzwAAvxDw6a8f9dZ4ZqUuFWcLKtC4kfK+ESF9h+mQ==
X-Received: by 2002:a05:6000:1aca:b0:3a0:9dfc:da4 with SMTP id ffacd0b85a97d-3a4f89da7a9mr10341282f8f.42.1748896136171;
        Mon, 02 Jun 2025 13:28:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/a10XT6j0KvqzZRmd5BI/F1rVt+h8hUFaigZcjYLo+RekVq1Wlju6PqEsxl9YDXkz6lgFsA==
X-Received: by 2002:a05:6000:1aca:b0:3a0:9dfc:da4 with SMTP id ffacd0b85a97d-3a4f89da7a9mr10341247f8f.42.1748896135802;
        Mon, 02 Jun 2025 13:28:55 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f34:a300:1c2c:f35e:e8e5:488e? (p200300d82f34a3001c2cf35ee8e5488e.dip0.t-ipconnect.de. [2003:d8:2f34:a300:1c2c:f35e:e8e5:488e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00972c1sm16239336f8f.68.2025.06.02.13.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 13:28:55 -0700 (PDT)
Message-ID: <04a27029-df1e-43a7-8642-15f351121438@redhat.com>
Date: Mon, 2 Jun 2025 22:28:53 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/3] mm: add STATIC_PMD_ZERO_PAGE config option
To: Pankaj Raghav <kernel@pankajraghav.com>, Christoph Hellwig <hch@lst.de>,
 Pankaj Raghav <p.raghav@samsung.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@suse.cz>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
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
 gost.dev@samsung.com
References: <20250527050452.817674-1-p.raghav@samsung.com>
 <20250527050452.817674-3-p.raghav@samsung.com>
 <20250602050307.GC21716@lst.de>
 <aa6fcbdd-5b1f-412c-a5db-f503f8a7af72@pankajraghav.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aa6fcbdd-5b1f-412c-a5db-f503f8a7af72@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.06.25 16:49, Pankaj Raghav wrote:
> On 6/2/25 07:03, Christoph Hellwig wrote:
>> Should this say FOLIO instead of PAGE in the config option to match
>> the symbol protected by it?
>>
> I am still discussing how the final implementation should be with David. But I will
> change the _PAGE to _FOLIO as that is what we would like to expose at the end.

It's a huge page, represented internally as a folio. No strong opinion, 
as ...

MMF_HUGE_ZERO_PAGE vs. mm_get_huge_zero_folio vs. get_huge_zero_page vs 
... :)

-- 
Cheers,

David / dhildenb

