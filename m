Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035DE1662E7
	for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737997198; cv=none; b=gMljuQST/UKDQIjt1PDAbr8CLy+oVW/spqEqUCWKaMg8QZ5Bh47zQ9BbPoQPkBkRAfcHdnO/2A+uj8HqXrQ78F5JFPueua0rmzCYyfxPhO/1ruJ6f0zZu7I+J6eDEVidrJZzwMU61Pj0PnBKVZJKVnuyFcix08gzmY/+dhJe/Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737997198; c=relaxed/simple;
	bh=EnAuVkYyEoDzth17bQuHo0Xt2Rdw3X86sC/ynCRSPrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A8DTyhDyQu6Qq7lmp8lx+xZX9usfRUw9UI7E+BQgvcYJAmBN85PshoXk3ln05BoCiPM+UZAkBVTWqYuuqvE01wmZ6V01Rcy8wCG8UIFHDbybpVJk3F9U11423A1b1SVZorzKKjv51khl/m2WX2K7gKZZbffxPy1ybNwoK8CFqao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bWs32FBq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWs32FBq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737997195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Gg6xSa4aH4O1RPvgzdabSWR7ON+7U7aSszV2WgC1xm4=;
	b=bWs32FBq3Jiz3Sgpi6wi55jscyAQIuO+0JjJSWNnpcyZ3YAt8uATvrpjW+Ke74oOAg4MS4
	WeI0xW5ovNCOtySaqG/vcVJJttGesLjVYd85M0OuVtaOvhPuGhTX6ve/KETD5cWnlrbKT9
	0cznBqv5uG/lah3gGIZALNt+5o7QeL0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-zYpnnYlyMmejMvvjrs-PJQ-1; Mon, 27 Jan 2025 11:59:52 -0500
X-MC-Unique: zYpnnYlyMmejMvvjrs-PJQ-1
X-Mimecast-MFC-AGG-ID: zYpnnYlyMmejMvvjrs-PJQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38629a685fdso1598661f8f.2
        for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 08:59:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737997191; x=1738601991;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gg6xSa4aH4O1RPvgzdabSWR7ON+7U7aSszV2WgC1xm4=;
        b=Z+bUpsal06eu3wsY907fKovGZZlzeOiT8Zm1D7vwds8hLfJ+FkRWaiYF+ZcIB5jY7h
         Me7babT5sXLC3ERFJ0pxgfDrPb4a5iERjPsIogIZ2a8XNKRJksf0eYAxkiNY+RT03H84
         Qn0qHAYnvjHNOBoLmDxYwx88j5Dxxew7wNLSKv6vIKsnOuDcJtiNX2NQ36bg1hLM+Rtk
         4ASCGzduZOTu4lSc5UQmxQHaabHXyxBceHgSsH+BmJjeVYtT9R8oIq3mH2YJpyVhwH+l
         qZ5BrytnOrv3Nx20TuPeVIExHmyw5An3I9b3YFAUpibimZDgqcVQpx1YbZ8KDpJOIJU0
         XXPA==
X-Forwarded-Encrypted: i=1; AJvYcCXcksRmxRlUWiVmcsPoDlk38HbWsCSGVs0993sxsORICfY04QwEXF4DRFirL81fRZX7cqbvwoDKTDtYJw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc48aJfQff6c+wgXsSfeMIk1Hnv3fpPT7lbMMSWRTUBsWaW57L
	ybYO1DP8eeygdcPtOVnlNqjw+qk39VHo8g99bpxINNhKw/ybRmyevVpsVeyLYyNL8/P/AqiL3do
	TA4rWZqFcaMPeDmY7fat+PsrjCr3MkF9LHa8zoXoIip+VEBd+hawij/xZfj6H
X-Gm-Gg: ASbGncvKnembueWviUbINv+Obw5boEztn5YC7DbNJkuCjUQ2sjJdm9/IxH2JthcR9yJ
	US1v5ASLvio0g9w7U6+l15kO66YDfwfwAEk8JBfrXI9vOhXGH18fv3cu66nAkm05T0nmi3tHWyf
	8O1wtP44fCHfd31Tq2Xf1QCAQhHbiIui/H8lWE5H/sdAbAXEYsJ/M029V6U+KueOODuOjIODHXI
	gHA+vrqBiFkrVPVpWiOhSOKxjCgMGntJus3WepiEnSWmoQf64ugt+hJzvarVuSoQ+TyvMYWcZ3l
	m1N572sA3kKqF1Cbs76xyA2dSQJx2yAef4WCa3XLEOObBbZ/uth8YMzzVvVmFNboHem1hLowscp
	QwGEVyut8cGGp9X13Iou7+NRzt/89KlwT
X-Received: by 2002:a05:6000:1863:b0:385:df2c:91aa with SMTP id ffacd0b85a97d-38bf565579fmr33649077f8f.7.1737997191275;
        Mon, 27 Jan 2025 08:59:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQ/PMqF3e1zaJl6Xd14meyKX4o2aJ0GCGQDzLJt6dJ9YypjazFw+CdYIhlZ+4HBZ1nfGKqWg==
X-Received: by 2002:a05:6000:1863:b0:385:df2c:91aa with SMTP id ffacd0b85a97d-38bf565579fmr33649059f8f.7.1737997190926;
        Mon, 27 Jan 2025 08:59:50 -0800 (PST)
Received: from ?IPV6:2003:cb:c736:ca00:b4c3:24bd:c2f5:863c? (p200300cbc736ca00b4c324bdc2f5863c.dip0.t-ipconnect.de. [2003:cb:c736:ca00:b4c3:24bd:c2f5:863c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a188915sm11481591f8f.41.2025.01.27.08.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 08:59:49 -0800 (PST)
Message-ID: <79534193-31c9-43a0-87af-023500c22042@redhat.com>
Date: Mon, 27 Jan 2025 17:59:47 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Direct I/O performance problems with 1GB pages
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-block@vger.kernel.org,
 Muchun Song <muchun.song@linux.dev>, Jane Chu <jane.chu@oracle.com>,
 Andres Freund <andres@anarazel.de>
References: <Z5WF9cA-RZKZ5lDN@casper.infradead.org>
 <e0ba55af-23c4-455e-9449-e74de652fb7c@redhat.com>
 <Z5euIf-OvrE1suWH@casper.infradead.org>
 <f3710cc4-cbbf-4f1e-93a0-9eb6697df2d3@redhat.com>
 <503c29c8-bcc7-4a6c-ab2e-ebf238a9a1db@redhat.com>
 <Z5e6p4itt-g5Ys97@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z5e6p4itt-g5Ys97@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.01.25 17:56, Matthew Wilcox wrote:
> On Mon, Jan 27, 2025 at 05:20:25PM +0100, David Hildenbrand wrote:
>>>>        14.04%  postgres         [kernel.kallsyms]          [k] try_grab_folio_fast
>>>>                |
>>>>                 --14.04%--try_grab_folio_fast
>>>>                           gup_fast_fallback
>>>>                           |
>>>>                            --13.85%--iov_iter_extract_pages
>>>>                                      bio_iov_iter_get_pages
>>>>                                      iomap_dio_bio_iter
>>>>                                      __iomap_dio_rw
>>>>                                      iomap_dio_rw
>>>>                                      xfs_file_dio_read
>>>>                                      xfs_file_read_iter
>>>>                                      __io_read
>>>>                                      io_read
>>>>                                      io_issue_sqe
>>>>                                      io_submit_sqes
>>>>                                      __do_sys_io_uring_enter
>>>>                                      do_syscall_64
>>
>> BTW, two things that come to mind:
>>
>>
>> (1) We always fallback to GUP-slow, I wonder why. GUP-fast would go via
>> try_grab_folio_fast().
> 
> I don't think we do?
> 
> iov_iter_extract_pages() calls
> iov_iter_extract_user_pages() calls
> pin_user_pages_fast() calls
> gup_fast_fallback() calls
> gup_fast() calls
> gup_fast_pgd_range() calls
> gup_fast_p4d_range() calls
> gup_fast_pud_range() calls
> gup_fast_pud_leaf() calls
> try_grab_folio_fast() which is where we see the contention.
> 
> If that were to fail, we'd see contention in __get_user_pages_locked(),
> right?

Sorry, my brain stripped the "_fast" in the callchain above :( -- it 
*is* try_grab_folio_fast() :)

So yes, we are in GUP-fast as one would expect.

-- 
Cheers,

David / dhildenb

