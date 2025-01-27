Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4C51FCFD6
	for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737986972; cv=none; b=c9vYvnMucyeEJ/wO0L2MyU2/hxz8/cz86jYWcIc2/3VQsQOUZAxV+JAgPHhMOhHMYt25xythnZ8QiQ04pzUd8t41uUuDpM+qjru0iLSM8AkpmFHCEtrA9QjWbpdWcNbgl2HnnuyjU0kFavFWJgAnI9VK1jB4e3DvC0twHc8jk3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737986972; c=relaxed/simple;
	bh=HOiBWB/RTY22NyI9YEthoXytHU/KGCy6+/1YDcvvheM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tK99Cz2sb9M0vKRa0eqiWfHDnSqdgaatK7VNM0Xr/U8GLo+P1dGMOWWlUOO9EngQBf//B0VhDPYk8gW9SMBqjcA8VFlJvKTwYzWzO6Iw2qOvMVguPot/LERYFkqXihFugj9+Rpc2FnNYx3uRmo7EIHDEalvarNhglJJBfUay8R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D8PKcBpQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8PKcBpQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737986969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PMAThEskvb6BByDS8Og4WVQHcMWJkXn2vL7PMgjUI7Q=;
	b=D8PKcBpQiShj6ozUDplOAvXsddnPFPkP7CciWo9HE9aKH5DH5AUC+g7vOVta4pn0AN/70u
	bCE20Y13g2nWA0B1VRk2mFdTpql7M+hn/aXN4RzXrmZP+qrEevEc12jsqTJZp/BEK7jIZS
	mdaT/Bx1+2FRRGSh1mwFHnSY52PoPLc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-clt31qoTNWChlgxRoQ6Rhw-1; Mon, 27 Jan 2025 09:09:28 -0500
X-MC-Unique: clt31qoTNWChlgxRoQ6Rhw-1
X-Mimecast-MFC-AGG-ID: clt31qoTNWChlgxRoQ6Rhw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385e1fd40acso2650670f8f.3
        for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 06:09:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737986966; x=1738591766;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PMAThEskvb6BByDS8Og4WVQHcMWJkXn2vL7PMgjUI7Q=;
        b=KghNgu+kMzxuntVsMQD9XVavfzx3V2zkqTmvZulmHSrEAUDX8j+qoDNU/CQB6yd9Xe
         RawyB8oNHMfdLsiGiGxYSVtqzP4Axgij0WDvkfI/FF2IIkM556beTk6oK97nRnGZKFc6
         4tJ+ALRzqqVFLRcfnNKW2sD0X5TKm2OqIVp0Cs+vSYtgsz2etO0JzoVgeAH4TaB1RsAG
         /c32B/BJhVTUrVifr/AOgHrYxhVzaNFPfg2FiwIzDAdfBq8U7MverVxdPHVoaq3TvFiJ
         n7A1xNo05H5kh/HqKtSyrnxvHu6TjOxWO3T3a3bXc6+VzcuoM9P/AOTHklYhA+g/eh3e
         hXJQ==
X-Gm-Message-State: AOJu0YwZ2WJcilsfL8NaHjDQseTnMjGHH9Ea7DwBduE/eys+QzyBfZpu
	dsNNAR5+eJ8CH3v1pC7pNI/8IbNYIs4A9YUcvrVljsXbAPwLKdTeAWj8r1IlFBs4s2KL5EqhusC
	Q5BoVmafcftPN2fgZvYMHw1UD7pkMDH++mHKPbp+cIBRF8zVOgFp1wA3rRcgh
X-Gm-Gg: ASbGncslH+PlLpuNjtdeez8tfOdB284Im0vMkd9fWUtIWSF9eFe9Z/I+4eMk3vV5qiv
	KUZvz6vaAYaaGXGbWOEQNXKXWlcMHz24S4TuXhloxV59Uw12xJjsPFI4AIG/GD0Rzg2744H7E6X
	lEuvlBQYzfeSG5X1ftsgsWc9W3YvGqdGrqY+7QNFEzkDmW80UQuGuew2K6LB6Km/8DW7EdSADHV
	aTt0sxo/oJbwpbRSRKEtiW/EqcqlX1UA8zU+NpUT4TTFwdu+feKIEAN+/VOcFA9b1SY50H1J81T
	7jK5jVRrzNxD5rPydmmrgquyL0C+Mw7sQkMwfC2/lecPi1tomm/wwvkttEIqlFYAguCzNLxN/re
	CCyrnuFNyo+WG0pE/jK63mr3EOfLE51mb
X-Received: by 2002:a5d:438c:0:b0:38a:2b39:679d with SMTP id ffacd0b85a97d-38bf57a9d66mr26731273f8f.32.1737986966380;
        Mon, 27 Jan 2025 06:09:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuaw7OBO/jCK1QSCEgvo+PMAXwmWjl9WioW5ZjVX1pbgqwDlBdt9wgGi+uhD5iENSul83oVg==
X-Received: by 2002:a5d:438c:0:b0:38a:2b39:679d with SMTP id ffacd0b85a97d-38bf57a9d66mr26731255f8f.32.1737986966057;
        Mon, 27 Jan 2025 06:09:26 -0800 (PST)
Received: from ?IPV6:2003:cb:c736:ca00:b4c3:24bd:c2f5:863c? (p200300cbc736ca00b4c324bdc2f5863c.dip0.t-ipconnect.de. [2003:cb:c736:ca00:b4c3:24bd:c2f5:863c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1c3994sm10960317f8f.81.2025.01.27.06.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 06:09:24 -0800 (PST)
Message-ID: <e0ba55af-23c4-455e-9449-e74de652fb7c@redhat.com>
Date: Mon, 27 Jan 2025 15:09:23 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Direct I/O performance problems with 1GB pages
To: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Cc: linux-block@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
 Jane Chu <jane.chu@oracle.com>
References: <Z5WF9cA-RZKZ5lDN@casper.infradead.org>
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
In-Reply-To: <Z5WF9cA-RZKZ5lDN@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.01.25 01:46, Matthew Wilcox wrote:
> Postgres are experimenting with doing direct I/O to 1GB hugetlb pages.
> Andres has gathered some performance data showing significantly worse
> performance with 1GB pages compared to 2MB pages.  I sent a patch
> recently which improves matters [1], but problems remain.
> 
> The primary problem we've identified is contention of folio->_refcount
> with a strong secondary contention on folio->_pincount.  This is coming
> from the call chain:
> 
> iov_iter_extract_pages ->
> gup_fast_fallback ->
> try_grab_folio_fast
> 
> Obviously we can fix this by sharding the counts.  We could do that by
> address, since there's no observed performance problem with 2MB pages.
> But I think we'd do better to shard by CPU.  We have percpu-refcount.h
> already, and I think it'll work.
> 
> The key to percpu refcounts is knowing at what point you need to start
> caring about whether the refcount has hit zero (we don't care if the
> refcount oscillates between 1 and 2, but we very much care about when
> we hit 0).
> 
> I think the point at which we call percpu_ref_kill() is when we remove a
> folio from the page cache.  Before that point, the refcount is guaranteed
> to always be positive.  After that point, once the refcount hits zero,
> we must free the folio.
> 
> It's pretty rare to remove a hugetlb page from the page cache while it's
> still mapped.  So we don't need to worry about scalability at that point.
> 
> Any volunteers to prototype this?  Andres is a delight to work with,
> but I just don't have time to take on this project right now.

Hmmm ... do we really want to make refcounting more complicated, and 
more importantly, hugetlb-refcounting more special ?! :)

If the workload doing a lot of single-page try_grab_folio_fast(), could 
it do so on a larger area (multiple pages at once -> single refcount 
update)?

Maybe there is a link to the report you could share, thanks.

-- 
Cheers,

David / dhildenb

