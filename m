Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9134B218AA3
	for <linux-block@vger.kernel.org>; Mon,  4 Aug 2025 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754327299; cv=none; b=PhoIy0X5K4glyI31cSViKlH9AywAZrxFySHh28XXqi9bWkqCgmuB3RSTDkFO1sW4RxstKJS76uMC+1ZgiaA+HEza4DbRK9AVbYcgwRZ+Eq0vksHb5IERBolvWUEDaE1K4tWTNUqCS0K3VuAhvb7BBBWv/65U6DKArhLLjKrWLp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754327299; c=relaxed/simple;
	bh=ymZ3sa1hNGfe7y8dvtlpGYpFRcUlAKsT0zFGi5f619o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MQoWuccGD4Sdyi8WA954qmTylhpPJLHtwy8swHfae8Lr+SLVh8QR0hrqqBjMNyGrzDdIKwL1+qGI2eEaNo12JiumVdov4Ka50lkTzX1TMllSDJwIPnL39Hc8tpI5QE+BRH3AA77VaYO1qorIbHUBLoLHqQTQdx0CAK0kaUW+41s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GbFjTkYz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GbFjTkYz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754327296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ePyvgqQodTAe7mT85YIOOr5eczmwtpkJop4c22CcwJY=;
	b=GbFjTkYzsCYJ3xJPcJRvyt7kr0SXMA9ZD3z3CoJJzX03PGtDCVY/W2ZFH7eRIuW3dJWm4E
	w/0aPtND1ojWAFHEctJr6V2Q0uecyYNIA4aUo+wlwPF/WyjgQ65kr3gqxJgYdCbB7+ZbZw
	TH25Weew04EQ2zLYP7MGFFOAacmkE4I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176--9M10MtFN6iNfohThf8emw-1; Mon, 04 Aug 2025 13:08:15 -0400
X-MC-Unique: -9M10MtFN6iNfohThf8emw-1
X-Mimecast-MFC-AGG-ID: -9M10MtFN6iNfohThf8emw_1754327294
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-458a31421a3so17064575e9.0
        for <linux-block@vger.kernel.org>; Mon, 04 Aug 2025 10:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754327294; x=1754932094;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ePyvgqQodTAe7mT85YIOOr5eczmwtpkJop4c22CcwJY=;
        b=F8lWP/9wLrwtjLn9GYpthNAYC9bVpgBXSO9RRcYk+9NoUVZ19AqlOSAeqbSZEV1OTw
         jZugemshx15D6fzdKXMCF4JnUzMEtXF+13GfU9GSgnLQ9wn3NXIdDT4cswrlpBJGrfLt
         2P/YOH8161f5bncu2NCCe4Isaxcvbzs4NJVcszHoeWdxlue4otAlJOPe9F6eu2FplK/h
         UQkBFw4AdCdfQ5OyXJiosOBHKinM6CI/Lkyh/CZszpTiINz0tS3RjfQx/JU3VHbaJ0x3
         lhIrJLXI3h49nPTXb9apoChXELduupolKXhq+OM+lwCWJFzCAP+KBt2tqZEbD7QDIxnE
         7f6g==
X-Forwarded-Encrypted: i=1; AJvYcCXlieMgA7xkYCweqx1E+edNrN8ExcR88oL54pX08QWt2COXjZupKf4nDP2iSChxYPhNHQU1UnoVvU41LQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFqmDv/qVVP6AhL/p55x4yA1P6gX2KQ6Z7Lclt0paCy560dvGe
	Vr1bLZQI5oJL8SZDUuO/PTIwoz+msnNkbswBOrskendIMgg3c2Q9MMDYnF3h7DGK24PnCS1/ds6
	dyMPMt1RkfgJTrKGVDi4l+v5ZPStF9NrQJVuXcdXsMopCI/7O4Rb+1pjjGEZZHvgw
X-Gm-Gg: ASbGncuui9atFqKpbXpO3M8cBxCkYvs5M92C4BZSWaOaOZKm8wpufPAjQOn17hZwHAt
	FHb7QhCk4ou4VtWdIFASXBDXIOAsNavX6PZ7gKl9xqzaE0FWE7KaU/NIjDGmOqHVxXAFv+P+a+q
	CUJCCncM3cabfKTXJARHiO63zG15iZb4si2YgEJ2/Y8z2uEefjNCb2h3x5alKv9Z05OkUk/2QTZ
	32TyTy0Op2iiDconjpAINJ4ncsbP1PYZL5lBoFF7T1NkwVLziicOPxBxRIReCHnz2PYYK9WRO8A
	P4PnQ89rkr+oA6X45pQ5NKzJev/cDNBFQKu0w/UgP+bVFpzMxszSCvw+9G0VG74Ao7FxB4ytipS
	7051y6N0X3IcCsG8HvJpBIbz/IROKTSGO1A1YBAfJC5KE8li0MhxIFyxUNA+SVXOYMhc=
X-Received: by 2002:a05:600c:4589:b0:459:df07:6da4 with SMTP id 5b1f17b1804b1-459df076f1bmr21149005e9.5.1754327294067;
        Mon, 04 Aug 2025 10:08:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXcoz6+nacCoSSnpua2VvOnWpL+nvr6I9+9jOpUQ7Z7N4/rvdf3huzUgi2tBKgpqINlpL98g==
X-Received: by 2002:a05:600c:4589:b0:459:df07:6da4 with SMTP id 5b1f17b1804b1-459df076f1bmr21148505e9.5.1754327293635;
        Mon, 04 Aug 2025 10:08:13 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9? (p200300d82f0e2c00d6bb8859fbbcb8a9.dip0.t-ipconnect.de. [2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dc7e1ddesm37027195e9.27.2025.08.04.10.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 10:08:13 -0700 (PDT)
Message-ID: <0e682d8e-12d8-4eac-b4ec-95444bf46ea8@redhat.com>
Date: Mon, 4 Aug 2025 19:08:11 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] mm: add static huge zero folio
From: David Hildenbrand <david@redhat.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, x86@kernel.org,
 linux-block@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
 linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
 mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20250804121356.572917-1-kernel@pankajraghav.com>
 <20250804121356.572917-4-kernel@pankajraghav.com>
 <4463bc75-486d-4034-a19e-d531bec667e8@lucifer.local>
 <70049abc-bf79-4d04-a0a8-dd3787195986@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <70049abc-bf79-4d04-a0a8-dd3787195986@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index ff06dee213eb2..f65ba3e6f0824 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -866,9 +866,14 @@ static int __init thp_shrinker_init(void)
>    	huge_zero_folio_shrinker->scan_objects = shrink_huge_zero_folio_scan;
>    	shrinker_register(huge_zero_folio_shrinker);
>    
> -	deferred_split_shrinker->count_objects = deferred_split_count;
> -	deferred_split_shrinker->scan_objects = deferred_split_scan;
> -	shrinker_register(deferred_split_shrinker);
> +	if (IS_ENABLED(CONFIG_STATIC_HUGE_ZERO_FOLIO)) {
> +		if (!get_huge_zero_folio())
> +			pr_warn("Allocating static huge zero folio failed\n");
> +	} else {
> +		deferred_split_shrinker->count_objects = deferred_split_count;
> +		deferred_split_shrinker->scan_objects = deferred_split_scan;
> +		shrinker_register(deferred_split_shrinker);
> +	}

^ disabled the wrong shrinker, but you should get the idea

-- 
Cheers,

David / dhildenb

