Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE372206A9
	for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905771; cv=none; b=XXedWUcvTo7huGf2KczrGM1Zkh4wXu1+d3bW+FdGvG76F+qUFK59AyQ2K/zxxeOyyywqiECHFIZ1fzXFejw0Dq7wVh3g1HrLLF+ejFuU18AQ+hIe6J2rXv2ITW8cIvv7uLcvNnJWtwi3WcyAz/j91yj98j7YONF5aSvjBNSG3xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905771; c=relaxed/simple;
	bh=YSH8u5PGqlODmLctM5GhdiruLiZoyKvrWvgnlKQlSMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0QjQ5YMve2DEsmTPpdjlDBEYqRURumofNbAla8jQ1TcNtUaRdMXmozh311cx70jdP2n/WOo1CkFwjm12dHPKv+8pnbqK5I7ITEwdxbiESRS+179u/0sDHZN1lNzRu6llK9KB/KpLa9Y1WqcW5kkL4REl+oMlIvKtgVbPRGXSwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFqldyWu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFqldyWu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754905767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zy7zoeBHdfB1I6ns8dWDx/bnOQrMxjU4C6kURFFGtA8=;
	b=HFqldyWujbK8CCRRy2ZivPZMTj+CY3Xi6/vycOFTQHjvutHlKLvEKOGp+AbA3tnO2KOVuS
	KxTL6vhovZORQVVBJ/YDmrGicMaxY3AVcxGYVKDTbd+P8SSORFBk7DgKjWGs8uXmC3n/26
	rxOJ2ANMK7EEABKcrXHkHhV9i32LUT0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-USW40IMsNK2o6F_u_gOdpw-1; Mon, 11 Aug 2025 05:49:25 -0400
X-MC-Unique: USW40IMsNK2o6F_u_gOdpw-1
X-Mimecast-MFC-AGG-ID: USW40IMsNK2o6F_u_gOdpw_1754905763
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4538f375e86so31675275e9.3
        for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 02:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754905763; x=1755510563;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zy7zoeBHdfB1I6ns8dWDx/bnOQrMxjU4C6kURFFGtA8=;
        b=rU+R5q5s4Vm+b8Sb0gVp/x/HTDBNMo+PAF2OXHdxEeytscGmsJVA5SFbub9wRRkENa
         um7N4cqP+plH48CLSyVFxMqYlzUHgAz5R7aK2lEJzyZkduScQCuNtsb9qKQfREVsHoRR
         Zztlocnmdkx0liOdYkMbFheQMeYvSN8N4SVAcXEmZX/X3HADtT/ygJHti0+vuQOszrcT
         86lIpK4TfxnzRGZhbxZNIBAnx194YM03KJ28MgC7VhTG8mJ8doFz/1vzCQskR4ykMq6m
         nMjqihd+Dw6GAqFNiV97R8W3nbotbQbqDe3o5uIOOoNlwGNrACLwxMwIEBEP1T5dCfuU
         KLhw==
X-Forwarded-Encrypted: i=1; AJvYcCWt9uinYYROuHbqgA7VJCrhVOuQWMGh0BdZWyU/u+mYf2GVJ9iO1eve+4hBkprqbqItS4/MTwdW5+xo4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz4fjBzcVOs6YNcwD+SGnWm5Qeeqt1DIuZ2vD9h4q0VRhi8uDe
	g4GBjKbXRhDd6QW29Zw09NeD2NbCmwEuLVrkRxdTFA4NRhH9Uj8D7tioZoFXEHHhkFIYyjs5mbH
	qgIqAO6XpauSo51FzAimc/kqWtddKR5JKc7KhSvv2Ycc6fC+rVv/Iz1tYsCXqiqEA
X-Gm-Gg: ASbGncv1AbOgje2rVMAI4/4GYcU4tSwZ2pDkuXUmTGoKr9IheulBjVpKdjp7ZVYU9YF
	NJCF1WMlOvllYy4yHUd054BngoTnXbCZSRDLjruBqEEqYjznvX78g//qmpXOwdaOWkS9+L5DWHI
	3MrU8PZy+Eiy6nnK2PRba77aqzcBQ2EIljx63wtezJYctPVUKHXOHXA2rFNODvjiZUjz6z6gylN
	tTCQrxl3F4XT0aHqLFxfUw8GnzAZBNHhKOGatgCv4/aFSP6yTKnVXa18dv/YHcplTaixTZ3bc+a
	lUdju34OokuZ0+RrQ3vyoRY309HHNG/RgZTinEzWcY8JE9M3MkGnBIaWZ2bNcwylgElMnL9gtyZ
	o0CAAdkRzAiUxrj324hbMavp3vJtw9MA/30Oamic0gNtJkITdjbB5hP/unGT4yjjH0Nk=
X-Received: by 2002:a05:600c:8207:b0:459:dc81:b189 with SMTP id 5b1f17b1804b1-459f4fc40e3mr130800365e9.31.1754905762845;
        Mon, 11 Aug 2025 02:49:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEa+lMPdCvEQQa/1iCFQjPws3MuVXvht3etKiuOL4kCcQ5Vr73iEgsX0YCT2GWYa35XBoE9g==
X-Received: by 2002:a05:600c:8207:b0:459:dc81:b189 with SMTP id 5b1f17b1804b1-459f4fc40e3mr130800075e9.31.1754905762394;
        Mon, 11 Aug 2025 02:49:22 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f06:a600:a397:de1d:2f8b:b66f? (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9386sm40066956f8f.18.2025.08.11.02.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 02:49:21 -0700 (PDT)
Message-ID: <dfb01243-7251-444c-8ac6-d76666742aa9@redhat.com>
Date: Mon, 11 Aug 2025 11:49:19 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] add persistent huge zero folio support
To: Kiryl Shutsemau <kirill@shutemov.name>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Vlastimil Babka
 <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org,
 Ritesh Harjani <ritesh.list@gmail.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
 mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20250811084113.647267-1-kernel@pankajraghav.com>
 <hzk7e52sfhfqvo5bh7btthtyyo2tf4rwe24jxtp3fqd62vxo7k@cylwrbxqj47b>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <hzk7e52sfhfqvo5bh7btthtyyo2tf4rwe24jxtp3fqd62vxo7k@cylwrbxqj47b>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.08.25 11:43, Kiryl Shutsemau wrote:
> On Mon, Aug 11, 2025 at 10:41:08AM +0200, Pankaj Raghav (Samsung) wrote:
>> From: Pankaj Raghav <p.raghav@samsung.com>
>>
>> Many places in the kernel need to zero out larger chunks, but the
>> maximum segment we can zero out at a time by ZERO_PAGE is limited by
>> PAGE_SIZE.
>>
>> This concern was raised during the review of adding Large Block Size support
>> to XFS[2][3].
>>
>> This is especially annoying in block devices and filesystems where
>> multiple ZERO_PAGEs are attached to the bio in different bvecs. With multipage
>> bvec support in block layer, it is much more efficient to send out
>> larger zero pages as a part of single bvec.
>>
>> Some examples of places in the kernel where this could be useful:
>> - blkdev_issue_zero_pages()
>> - iomap_dio_zero()
>> - vmalloc.c:zero_iter()
>> - rxperf_process_call()
>> - fscrypt_zeroout_range_inline_crypt()
>> - bch2_checksum_update()
>> ...
>>
>> Usually huge_zero_folio is allocated on demand, and it will be
>> deallocated by the shrinker if there are no users of it left. At the moment,
>> huge_zero_folio infrastructure refcount is tied to the process lifetime
>> that created it. This might not work for bio layer as the completions
>> can be async and the process that created the huge_zero_folio might no
>> longer be alive. And, one of the main point that came during discussion
>> is to have something bigger than zero page as a drop-in replacement.
>>
>> Add a config option PERSISTENT_HUGE_ZERO_FOLIO that will always allocate
>> the huge_zero_folio, and disable the shrinker so that huge_zero_folio is
>> never freed.
>> This makes using the huge_zero_folio without having to pass any mm struct and does
>> not tie the lifetime of the zero folio to anything, making it a drop-in
>> replacement for ZERO_PAGE.
>>
>> I have converted blkdev_issue_zero_pages() as an example as a part of
>> this series. I also noticed close to 4% performance improvement just by
>> replacing ZERO_PAGE with persistent huge_zero_folio.
>>
>> I will send patches to individual subsystems using the huge_zero_folio
>> once this gets upstreamed.
>>
>> Looking forward to some feedback.
> 
> Why does it need to be compile-time? Maybe whoever needs huge zero page
> would just call get_huge_zero_page()/folio() on initialization to get it
> pinned?

That's what v2 did, and this way here is cleaner.

-- 
Cheers,

David / dhildenb

