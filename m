Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1165322069E
	for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 09:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905938; cv=none; b=bT/fX84mzmjeME0Mwlbk8aQfG8Rv7tBZAhIFmS+juisZfjiK1IhVa12Gd00E+kyjGdZYvSyndXizT7KwuL131urmJxHefkMxrymj/rYryjPyC5aKbIqpgfgQElifkHzdHth6Aboy9saLSb20yIJJ7oCFDZavBhNzc2vifj6UBJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905938; c=relaxed/simple;
	bh=fK7wtT/COxfPyPYLLWR2aJftZcQDgKDum3U+bf017MM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jcGlejzowVj7P5qt+iRYT74GQeSHAdqm6uwzRsct1bcPrEmZF3QlT3DjQ8rwN3FSsnkOTGstCkVudeCr3dN1478x3Z7ec8pLl0vwFcSnwh4T1PDpeX9qpvBNTcZKSEc5FXNN06dOiCMjfjF9hq5KaQV9QH1/3Sxe+TLjxFKn7Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bwxSZ338; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwxSZ338"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754905936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YXhxGhlzJsMH44DSBwLZywxa+L4HWbx5c6OEzPGb9fI=;
	b=bwxSZ338z7W9Nfv5cWo3PfQ2zRU6NCfF6jI/8knKOyjKZabSKYTMt1flqxWt6nOmyBKs4W
	a2IWrhDkXDYwR4kEmvHnqlHHpNHbW0mL6QCvkGr4aTCaEU6TRYklJY3GyoddK4MNgk2tdo
	XCjfzfspt4NlZtVyr5zliKP6XP5HrkU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-kJ85sShJPN62JG1YAOpHTg-1; Mon, 11 Aug 2025 05:52:14 -0400
X-MC-Unique: kJ85sShJPN62JG1YAOpHTg-1
X-Mimecast-MFC-AGG-ID: kJ85sShJPN62JG1YAOpHTg_1754905933
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-459d7da3647so35576595e9.0
        for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 02:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754905933; x=1755510733;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YXhxGhlzJsMH44DSBwLZywxa+L4HWbx5c6OEzPGb9fI=;
        b=fvq3h4Zrtw6tPCrAs6QV9+G7kN0EzWKd+q9+LejxsyAvDu4Qp2FcVyfgmEJVBHq5NK
         I64Ho2Hh+xTB+OLKz1OR+AYzs0YTFyiXQb0OhMFm10vmt80URVBvA5nD27oncgLC2u5b
         fdNTefWexKqq2aMHeU8OwWEP+seCoEjY/FPgQz19S0AY70Fph2OhCqMiG+qi8FAu7RbH
         CVxQ6lIMnYUBoan4eufOx5qRIb1zWRI4MaAn1j7Ez9T0G9HLJFWOO/zlsDralkNQhmqt
         +Bp0EYtkhi6A5UjWAxRAHZevX5iKRCIkd9REu8otazXTBrSE+HW5T9eSLd8wl5S6J5XK
         VJDA==
X-Forwarded-Encrypted: i=1; AJvYcCXO8z+znpzRG5ni4crF7Xr1reiK6QagqOBGftq/DzlMTm4hb66q+hb++yq+LhI0zw4S7rQSxS1NieD4Og==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaccv6cN0SFij8Gmg9fIerR260y2UreOO4h4IxqexWIaNtOTaE
	SjhAhYDlcUYZ/giEdOTCpzzEF3ZjWnMg5opPTdwhXxDn8jas69W7Nv2ENuhfMrjEmHj3u409gAm
	bbXEUTyE0T8mitKBaEMQWIyfgSeng0uipeVw24zF46tZrHxRG2PgjA3LBu7ds8TQT
X-Gm-Gg: ASbGnctJzolo4ShVirr626DuO6vOyLse6IU1uMsr62z0vQWLIWwYyboCsXVKpbG2h31
	qFPft9abEdY2YXttw/9jr6K7r9m/kfFIPK3vOUTqnWwVoQvwqiNdaySk9XdwxO/Ni+fGAUGhsud
	HesyBCgNfVVssEppeIXHhJJMeHXbXN3GMgUzrQPpkfnIdFn5WA+fgd8Wu/2iUyd3ovu1K5XvOLc
	R5RKaEWDdKKgh3xPuOP0MCyWJNhxQgd5oL3/e9a640nDfnx3d+fPIfZR6n5jJeXbmpakbVdcA+F
	Mty3qY5bIZgUqmyMoKx/rh4I02ok+0zbPaSyKjsUC7mwzv6oYW7tpkkDYiDDv8GoiX1Rv9POTMr
	ARgSalnlbWAEpiMnc0RiVrlHLqb0ScncVMEXruup/p8mO7QQxk30DnGhZsVuqFfCgk+o=
X-Received: by 2002:a05:600c:a06:b0:459:4441:1c07 with SMTP id 5b1f17b1804b1-459f4f9b5c6mr84913715e9.20.1754905933445;
        Mon, 11 Aug 2025 02:52:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdmdGHNNshi3yohcSrFEtt4H3QesbQ89l/f0p1bYBymKlSnx3ncfbPaKz1LYKXIyvDOoZ7FQ==
X-Received: by 2002:a05:600c:a06:b0:459:4441:1c07 with SMTP id 5b1f17b1804b1-459f4f9b5c6mr84913375e9.20.1754905932957;
        Mon, 11 Aug 2025 02:52:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f06:a600:a397:de1d:2f8b:b66f? (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e6214640sm256183205e9.1.2025.08.11.02.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 02:52:12 -0700 (PDT)
Message-ID: <112b4bcd-230a-4482-ae2e-67fa22b3596f@redhat.com>
Date: Mon, 11 Aug 2025 11:52:11 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] add persistent huge zero folio support
From: David Hildenbrand <david@redhat.com>
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
 <dfb01243-7251-444c-8ac6-d76666742aa9@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <dfb01243-7251-444c-8ac6-d76666742aa9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.08.25 11:49, David Hildenbrand wrote:
> On 11.08.25 11:43, Kiryl Shutsemau wrote:
>> On Mon, Aug 11, 2025 at 10:41:08AM +0200, Pankaj Raghav (Samsung) wrote:
>>> From: Pankaj Raghav <p.raghav@samsung.com>
>>>
>>> Many places in the kernel need to zero out larger chunks, but the
>>> maximum segment we can zero out at a time by ZERO_PAGE is limited by
>>> PAGE_SIZE.
>>>
>>> This concern was raised during the review of adding Large Block Size support
>>> to XFS[2][3].
>>>
>>> This is especially annoying in block devices and filesystems where
>>> multiple ZERO_PAGEs are attached to the bio in different bvecs. With multipage
>>> bvec support in block layer, it is much more efficient to send out
>>> larger zero pages as a part of single bvec.
>>>
>>> Some examples of places in the kernel where this could be useful:
>>> - blkdev_issue_zero_pages()
>>> - iomap_dio_zero()
>>> - vmalloc.c:zero_iter()
>>> - rxperf_process_call()
>>> - fscrypt_zeroout_range_inline_crypt()
>>> - bch2_checksum_update()
>>> ...
>>>
>>> Usually huge_zero_folio is allocated on demand, and it will be
>>> deallocated by the shrinker if there are no users of it left. At the moment,
>>> huge_zero_folio infrastructure refcount is tied to the process lifetime
>>> that created it. This might not work for bio layer as the completions
>>> can be async and the process that created the huge_zero_folio might no
>>> longer be alive. And, one of the main point that came during discussion
>>> is to have something bigger than zero page as a drop-in replacement.
>>>
>>> Add a config option PERSISTENT_HUGE_ZERO_FOLIO that will always allocate
>>> the huge_zero_folio, and disable the shrinker so that huge_zero_folio is
>>> never freed.
>>> This makes using the huge_zero_folio without having to pass any mm struct and does
>>> not tie the lifetime of the zero folio to anything, making it a drop-in
>>> replacement for ZERO_PAGE.
>>>
>>> I have converted blkdev_issue_zero_pages() as an example as a part of
>>> this series. I also noticed close to 4% performance improvement just by
>>> replacing ZERO_PAGE with persistent huge_zero_folio.
>>>
>>> I will send patches to individual subsystems using the huge_zero_folio
>>> once this gets upstreamed.
>>>
>>> Looking forward to some feedback.
>>
>> Why does it need to be compile-time? Maybe whoever needs huge zero page
>> would just call get_huge_zero_page()/folio() on initialization to get it
>> pinned?
> 
> That's what v2 did, and this way here is cleaner.

Sorry, RFC v2 I think. It got a bit confusing with series names/versions.

-- 
Cheers,

David / dhildenb

