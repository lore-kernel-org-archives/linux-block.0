Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A01202C48
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589016; cv=none; b=tKbLFA5uxzlIVvSSgyUis/d7q1m64KG4mtJd7ntDtP0t0nuT6zrM0kZEYCxJerSXxmQVdvMx/eZDgUBlquWYpbeAWY2GjEmcSdnFNpWWqxwHgkwvN2zeJFfxYrCsgVJgBmv17EnSG+mg8sJ5o2QuiMO8cMhhRf8IQQlroMUkLfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589016; c=relaxed/simple;
	bh=EeCCPvYaO/vZ02CLQpqwrR7TomDQ+vhuMVSKzhcc0jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqFOGl7M9kfm4vCecMoGZXrTDj8fmCuf7UTiA0lgdXkyoPG/64KRfZKXvYglgtWywsbIz9nufivCFgrnPuergXBVIA4u801jIbKR2mtgm6HZcSRmzXOzmU+Buc0MnntAyWtLJTpYqQOJ6KM8RbADISCL2vG5on9GX4NR/yHTcV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fenet4sW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fenet4sW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752589013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xtUFd8jIZdacMgVpErwt3tqjgeqdKXPmgyL5wbxQy4k=;
	b=fenet4sWzlha7+WRjXiUamx8KsleobFmvJT3QCUIVOHWzMPOevdvva493C3u9pYth6O27c
	zw0xUGnOo9O3aePJ4Pw0hXer/BDwdbP1xNgVSCoNMjOcUMrmXDPgW39bysni5Rgj5ReaPB
	/NVMRPdYWEjRfpT8EfVtBWg4FKfRbuo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-_4hO1HLvMWuGMB-o0Y55UQ-1; Tue, 15 Jul 2025 10:16:52 -0400
X-MC-Unique: _4hO1HLvMWuGMB-o0Y55UQ-1
X-Mimecast-MFC-AGG-ID: _4hO1HLvMWuGMB-o0Y55UQ_1752589011
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45359bfe631so33219255e9.0
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 07:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752589011; x=1753193811;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtUFd8jIZdacMgVpErwt3tqjgeqdKXPmgyL5wbxQy4k=;
        b=NG8dXjOfkOBlY2cVp8iyUPZBLAJpSo3hRiTFUCNNzgR+fEg4+H0yoQ7jiU8QcPic+a
         SLOcwWIam6c7PA3KS2w2heQ7bqwQNv4nRVF5Vil475225IaSVTaEcKkm3bdle+d8aHko
         /4A5ke5WioQnMe5kQroxl8OzBd4cXCW4NtIukk0ZTXJhwVm7PG21Euyt1y9+yqMSY3bf
         tk80DVAC1Gn7SD7RNEHrUrrLAEArsdFSbvEIO7Qm2L6SAlggdlIKaj/9gkdkImijaAPd
         FknoDgXS7MD/R8dNkduqvDsLhkjrnFew9Gyt79BJLXwC3iU9dCCxx/rDvxtD0gOGW9s3
         O3iw==
X-Forwarded-Encrypted: i=1; AJvYcCWnFJbk9kqbu/EeHwFBnsgywPuo+tmU+d62H++FJcZa9KscebS4aUBt50DEbN3qpwwk/yY71ovImHlF4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKA4mira13RNEopLaOpiD/JOBNf3/geWqOLQbVZPj9cwQgE1d9
	PEHQPsJFfG7WXOEksJwKnp920o7B/dUe9bfZJQPifW40ZLN7TragDzgn59veDWaZ7cg/6AFzM/I
	1Q9G4qtMc6ETfGDScdOO81f0Ma2gMlSeHm2Ybkva5ypP6hw3R0YKAzSaF/s2MATi3
X-Gm-Gg: ASbGnctZ6U7J08dWX+YUbSUom9GrepE9GNW6d2w1VHmWQx5rS/irLfh8LMrHp1zn7tz
	DsYOolKIToXkLtdqVFT2Y22VOGabz0y6P4jhLDqFxl3s7C8x1MEKQeiTl9CeF/abHVp5nr9Vl8Z
	SL4puYwtrdbmoah9SW1G7NnHV9GmEfvPep0MAICm09rA/Wla5a2wPPECcwXv4KCQHfAQOe0Jk/3
	+SQlR3Yx1EIDHrOK0e2mr2B58DPX4U7wrUYREZaovwQe1m39I0/MnEC0xan2nhlZmS55m0iRVyD
	39yZ9G4uBiSqth6R3dFVU9ypNp8V+VC2HtHfU2v6lCO1u5X3LdBTZXIm7Vlk0ZP6ImxO1oB4GIa
	xjQnqeI4swj+eZgrA0knlYFmIHwMv342Z7GPYV3vijnlpQno/SejPVLjTPYgse9oLU3g=
X-Received: by 2002:a05:6000:2283:b0:3a5:8600:7cff with SMTP id ffacd0b85a97d-3b5f1875938mr14092706f8f.1.1752589009138;
        Tue, 15 Jul 2025 07:16:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtF3aNyi3pbj6yCkk1zAFYxYfd7ezRbzUP3crF9cjiRso9uL/U1MBxt8As/NbiPD2fcAEmzQ==
X-Received: by 2002:a05:6000:2283:b0:3a5:8600:7cff with SMTP id ffacd0b85a97d-3b5f1875938mr14092465f8f.1.1752589006625;
        Tue, 15 Jul 2025 07:16:46 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1a2bsm15527533f8f.14.2025.07.15.07.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 07:16:46 -0700 (PDT)
Message-ID: <d7fa2e67-1960-4b1f-a8b7-147371e37010@redhat.com>
Date: Tue, 15 Jul 2025 16:16:44 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] add static PMD zero page support
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Pankaj Raghav <kernel@pankajraghav.com>, Zi Yan <ziy@nvidia.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 willy@infradead.org, linux-mm@kvack.org, x86@kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <F8FE3338-F0E9-4C1B-96A3-393624A6E904@nvidia.com>
 <ad876991-5736-4d4c-9f19-6076832d0c69@pankajraghav.com>
 <be182451-0fdf-4fc8-9465-319684cd38f4@lucifer.local>
 <c3aa4e27-5b00-4511-8130-29c8b8a5b6d9@redhat.com>
 <dca5912a-cdf4-4f7e-a79a-796da8475826@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <dca5912a-cdf4-4f7e-a79a-796da8475826@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.07.25 16:12, Lorenzo Stoakes wrote:
> On Tue, Jul 15, 2025 at 04:06:29PM +0200, David Hildenbrand wrote:
>> I think at some point we discussed "when does the PMD-sized zeropage make
>> *any* sense on these weird arch configs" (512MiB on arm64 64bit)
>>
>> No idea who wants to waste half a gig on that at runtime either.
> 
> Yeah this is a problem we _really_ need to solve. But obviously somewhat out of
> scope here.
> 
>>
>> But yeah, we should let the arch code opt in whether it wants it or not (in
>> particular, maybe only on arm64 with CONFIG_PAGE_SIZE_4K)
> 
> I don't think this should be an ARCH_HAS_xxx.
> 
> Because that's saying 'this architecture has X', this isn't architecture
> scope.
> 
> I suppose PMDs may vary in terms of how huge they are regardless of page
> table size actually.
> 
> So maybe the best solution is a semantic one - just rename this to
> ARCH_WANT_STATIC_PMD_ZERO_PAGE
> 
> And then put the page size selector in the arch code.
> 
> For example in arm64 we have:
> 
> 	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
> 
> So doing something similar here like:
> 
> 	select ARCH_WANT_STATIC_PMD_ZERO_PAGE if ARM64_4K_PAGES
> 
> Would do thie job and sort everything out.

Yes.

-- 
Cheers,

David / dhildenb

