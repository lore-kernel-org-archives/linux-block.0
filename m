Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B449239E9A
	for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908993; cv=none; b=IhsLUMMMYRvGqAoLt4yhgEVsx7FhT2x4iK2vrCswS5b29K5oU/SfFfpEB1RBxQEDiLryWZJgfCnEk4Pje3uc/vHVRPemLPIy/rad+RQB+bGGKSqY4qaffVmpdovtqSE4WAypZrkjhyEDXpw5FXBi7r1V9D6WRtlHFOFl+Pm+ees=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908993; c=relaxed/simple;
	bh=MdOy/Vxue/t5Cm8NtySn/XHB3otuzfZost+Y82ARVgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mW4Uitz3D+II3P8abiJ0+o3tFnMpQjZy0DHx+ca73sWEzsuzxUKk5p+mWDY1K8CHGIlYQ4sMeE8Hw66xIBnuH1KTVtJ06ZiM9Qpub0Ai38E8VwbQACEmZSYaTn9J8q0X+b+R3aXSciEgAz73soHvdvTckigCCDG9TDFBOLTqS+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T9hSuZqM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9hSuZqM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754908990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=u3YjvvbdyzhFmGp/7Kma3wP//jygvfsZwyPlqFhfats=;
	b=T9hSuZqMqZhjnazUrMslebmSOcvBiyS+3ksYOi0F5ZvEHYo+RIC95VykoPsrsxBfGWXJYd
	0eanFZyiTIlDtrPFaUy0ngy7vpSIlgmN1PVOJYLVxSu4oLdYcR+SlV5dTYwVivBq9dleO3
	7FXSxXVR/lHKJ3ee4EaAv6VJcht3sFw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-BwC3iNqQM_6yccaCmiC6gQ-1; Mon, 11 Aug 2025 06:43:09 -0400
X-MC-Unique: BwC3iNqQM_6yccaCmiC6gQ-1
X-Mimecast-MFC-AGG-ID: BwC3iNqQM_6yccaCmiC6gQ_1754908988
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b7807a33faso1923479f8f.2
        for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 03:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908988; x=1755513788;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u3YjvvbdyzhFmGp/7Kma3wP//jygvfsZwyPlqFhfats=;
        b=NUJWI+7KVeeXF0/y/AK0FQa+vr84h+A3YE8xFuGrkqgd/M+mu5C6aJMn7OCgHFNIQY
         noQ+7GQmxbJjmT3iKK/rkXlJnqH3O8Ri2m9rnq36/DfoowOjq8COgSImMQZas0uU+oAG
         jI8eEEvgMgwobZHIHeJV2jUXLNe9DK5teJkESD/uGxvoBwiwcMhTOqqqmWY+Rs7RnHu9
         VzBuGAFJFQRh1gkBICrj4KedKEewKjE4u2xBO7wFRnXxQusxNhtpm+eTlmAQANT11pJE
         yYSiPnAdjTcoLcrqRrwRGBL3+rsH+ftPgPkcDfcSYtI/Sn5efgm0bijHslMpEe5ozbi3
         SZuw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ7kEiX735/jeXphB2CIQNKtUfujs68RPp9ayKRVttZmh9XhpB0xK+mJzv/d389hLpMkuaZ+YIzs1K3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfA2EYK4mbJayGl8gva8AFAQkpXuUXP8Kup9IFszKvmJyz2GVn
	Zx8FYJox4t6Ic7TxmLqm6MQHExQ41K7Dv17EOPe0wesorQYzvZmjchdjmpA6bHgYn4d3Bna7dOb
	Ppw2S0XulGKXMlypTq8P8dQWqVUY2fNSwVQQk7YY8M8DKdq44ruSV2asujZ4kZ6A4
X-Gm-Gg: ASbGncuNyi0X9vJ+anlvD9rSBHtl5pgwmGQcZhJAYdUQ3HAzkHu8sKoMXYwRdany6Jr
	vhApte+hGdf8qWQ09QJBzUNqu3YkxjYsLO4poMQtD8ugUZOYZZT0zP9gHlWvG0JZL5+QIkbmAQr
	grTMRKikbWrsamEowsd15jVhkBoggowi9rXh5ZLZRj0hQ62zmSt7iA3y/XpDMHRDU2bueHmonP/
	4oA8PYalB8a0zMuP7zwuO9TEaiQTDutWbF6oyNFlY2WL2yW0Wh6Zzk/AfmE0xSKbzv9OQZV1GTH
	YObbw3eFJZVTyPgzlP0bibeu4HIABgJlGttyFAcGhOdAOWvGZ+1Nc1//HAyyqxMDhInVrnbL+Jq
	WIFbkmQ8h6+w48tinycoHiSOqkQyT6hQI2Poukmpo+lnltxuQa0Q6Fd1zbRscYyX3zG8=
X-Received: by 2002:a05:6000:228a:b0:3a4:eb80:762d with SMTP id ffacd0b85a97d-3b900b55fe3mr10404683f8f.56.1754908988068;
        Mon, 11 Aug 2025 03:43:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZc2pYHJDG26+kHcbxUcn2VM0hxurOtrFpvAMDZsz3M0NPAfAOBWGBM/o0246hxTeJIrYCjQ==
X-Received: by 2002:a05:6000:228a:b0:3a4:eb80:762d with SMTP id ffacd0b85a97d-3b900b55fe3mr10404634f8f.56.1754908987580;
        Mon, 11 Aug 2025 03:43:07 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f06:a600:a397:de1d:2f8b:b66f? (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e6867193sm249292745e9.6.2025.08.11.03.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 03:43:06 -0700 (PDT)
Message-ID: <6afa5cab-2044-46fb-9afb-8be82fe8a39f@redhat.com>
Date: Mon, 11 Aug 2025 12:43:05 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] add persistent huge zero folio support
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Vlastimil Babka
 <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
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
 <112b4bcd-230a-4482-ae2e-67fa22b3596f@redhat.com>
 <rr6kkjxizlpruc46hjnx72jl5625rsw3mcpkc5h4bvtp3wbmjf@g45yhep3ogjo>
 <b087814e-8bdf-4503-a6ba-213db4263083@lucifer.local>
 <lkwidnuk5qtb65qz5mjkjln7k3hhc6eiixpjmh3a522drfsquu@tizjis7y467s>
 <57bec266-97c4-4292-bd81-93baca737a3c@redhat.com>
 <osippshkfu7ip5tg42zc5nyxegrplm2kekskhitrapzjdyps3h@hodqaqh5r26o>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <osippshkfu7ip5tg42zc5nyxegrplm2kekskhitrapzjdyps3h@hodqaqh5r26o>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.08.25 12:36, Kiryl Shutsemau wrote:
> On Mon, Aug 11, 2025 at 12:21:23PM +0200, David Hildenbrand wrote:
>> On 11.08.25 12:17, Kiryl Shutsemau wrote:
>>> On Mon, Aug 11, 2025 at 11:09:24AM +0100, Lorenzo Stoakes wrote:
>>>> On Mon, Aug 11, 2025 at 11:07:48AM +0100, Kiryl Shutsemau wrote:
>>>>>
>>>>> Well, my worry is that 2M can be a high tax for smaller machines.
>>>>> Compile-time might be cleaner, but it has downsides.
>>>>>
>>>>> It is also not clear if these users actually need physical HZP or virtual
>>>>> is enough. Virtual is cheap.
>>>>
>>>> The kernel config flag (default =N) literally says don't use unless you
>>>> have plenty of memory :)
>>>>
>>>> So this isn't an issue.
>>>
>>> Distros use one-config-fits-all approach. Default N doesn't help
>>> anything.
>>
>> You'd probably want a way to say "use the persistent huge zero folio if you
>> machine has more than X Gigs". That's all reasonable stuff that can be had
>> on top of this series.
> 
> We have 'totalram_pages() < (512 << (20 - PAGE_SHIFT))' check in
> hugepage_init(). It can [be abstracted out and] re-used.

I'll note that e.g., RHEL 10 already has a minimum RAM requirement of 2 
GiB. I think for Fedora it's 1 GiB, with the recommendation of having at 
least 2 GiB.

What might be reasonable is having a kconfig option where one (distro) 
can define the minimum RAM size for the persistent huge zero folio, and 
then checking against totalram_pages() during boot.

But again, I think this is something that goes on top of this series. 
(it might also be interesting to allow for disabling the persistent huge 
zero folio through a cmdline option)

-- 
Cheers,

David / dhildenb

