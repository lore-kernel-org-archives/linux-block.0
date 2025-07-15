Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8C0188000
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588919; cv=none; b=qd+rmk1LOKzSgZ3SL33d5Lbv32E2YvHo2Iy55LsZZjUXKudAe17AJzo9IwbFOij69nCmSogSRDkc4Qi5rpD9WMdTvZ2IXXKxBxsLPSbxiLMSbuv2rljGwJQF1D/0EZ1MXiBXpzBNw/TDOhra3Lr42vVXY7pfWQUO2WXCmfJnu8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588919; c=relaxed/simple;
	bh=cYRvBfFBk+zWv7ODYqVflfYipFPbgCULQ+V/P58YDwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qMmwFXjDW8gC9hxnTxPfU00zideFs6cmP2GqhRkbG2R44k2Xq/5YY+akX7Jl+Y938lnxQQhWW1Mgk7mjl1FGXZHSyCDNjLaGD7cOzfuVqMB3rmSQ9RV0L0xFiJmeANm/gwoTctWzR8Co3/AKg+C8yhOeZv/sEb3sNl5uKSpj4ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OVCdclGu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVCdclGu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752588916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uHaC3NM9+QwIy3pXqxbGtfDGOu55CkwVkRhyKfVul1g=;
	b=OVCdclGuRSmdsKFSWAId5MIwMhyznWTTEEx4L93bBYIkTc1vNLPGVT8Cy34RR+qIiv8bCQ
	VdXJsUAPG7FydNFQT5gDO67UjFp4hqCBVsmZmpOLzN6rM3cwSI1WfLHSKJc2c0I20pEAXi
	4i/zFw05zs8Gq2xHMcO0mNJ0kSixwXk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-YHdrv9IkNKGXwo8MEiQrVg-1; Tue, 15 Jul 2025 10:15:14 -0400
X-MC-Unique: YHdrv9IkNKGXwo8MEiQrVg-1
X-Mimecast-MFC-AGG-ID: YHdrv9IkNKGXwo8MEiQrVg_1752588913
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a50816ccc6so3409669f8f.1
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 07:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752588912; x=1753193712;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uHaC3NM9+QwIy3pXqxbGtfDGOu55CkwVkRhyKfVul1g=;
        b=jTqSgQTwZXuDRuz/Sjt//BFDAjGPll7BkihzuOY4N9YmO1umwHxIHj1w3RjTicCPV7
         KyFcjcz5Vs7/osxKcZpVZXoNiW0FASaxkirc0y5ymTKo13Q5thVsiasz5iQYPr8nXK5H
         70dtZjXIXnsgrs2AuIjWkKT9zpnTFgVcLKMjMbnwe3qSIn3EG+CPvyJfekj3Qe7ZG8jE
         xtphAGQd6qOA5VYOomKAt7CZB8LaEhlUOnPGWA0NFeS7KTAWPfHA0lFHrAW/LQY4SYhS
         X/m5kmZF1gidu5THXbdXFLObV9xeFqnV/yZ7Bk9NgHmop99YucpNv23a9B0/V2qjBNGS
         rbTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXRx6sY7JYnCosheSuN6Wege+/niTKLBqUf7TVIR9ifZeuNNP201K/IJEFK/tmrz0k2iu7f2OE4UfxYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHAcHGzGfbDrebPhMh1gZxjUl2UATXHoJv6Szqn81jp9G7U8yX
	gjHTNC5ls/tD6WBiNUbYBXymVbAEK/amIEh0P9ti3nHnrus0uHQEwf/1RkPmaQiViBr4F6pcN+m
	qPZQuPTWsjyG5MIgl5Eizw5kzPPGhpC9cRYu7fFQThw4czG+9AA8A3DCXZw73UaUf
X-Gm-Gg: ASbGncs3xWemCrDIsiT4Gqlm+ME/9ZYZmPrBq91C0h7yZpT3pbi1yfL9lrxP7iZq9Zk
	senFZP+mWUa/JAGaL9mTEPwjXZyXzzu1wbDAjJPOBkYAPcMAi/ezhEdfOucJVBqaRAo/k84UzIW
	QB1z109BuQYlXE2h15jHZtEZqNgvJZ8ckzl5+1rntkPPiX73F96RmMtiHmblc81LWvr0bIjp10i
	fq/wDOd+B5LY1o71ZeNIjME4kMg1CyWZMCmdtcQ+ygrmERYPGd6PRUXrURUOQ+Y4t+2ZWDwHtpV
	aEEcWB3Ue3LYIDN24I9bVQ6mEJDIPteeapH72aebhnlPdBv2ZyeMf8oDkj5YQb3GXgQFve4HSsO
	iYBEqbI6Ou1+OdnPIV9x5tD/l7X1TuWv+2Tb+X9sTSQKixHVqVO805XSIq42Imp/ML8A=
X-Received: by 2002:a5d:5d0c:0:b0:3a4:e629:6504 with SMTP id ffacd0b85a97d-3b5f2e448d9mr10913833f8f.49.1752588912207;
        Tue, 15 Jul 2025 07:15:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpyohQnpn/KxIdJ2KMc18WnTagGh3ivybzKaAC/ozw+/YD8D8CtWgwEjyEVReYxDXso7vSlw==
X-Received: by 2002:a5d:5d0c:0:b0:3a4:e629:6504 with SMTP id ffacd0b85a97d-3b5f2e448d9mr10913779f8f.49.1752588911647;
        Tue, 15 Jul 2025 07:15:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1833sm14841701f8f.8.2025.07.15.07.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 07:15:11 -0700 (PDT)
Message-ID: <9c9b78fd-4698-4982-919c-34e679bbac84@redhat.com>
Date: Tue, 15 Jul 2025 16:15:09 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] add static PMD zero page support
To: Andrew Morton <akpm@linux-foundation.org>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Thomas Gleixner <tglx@linutronix.de>,
 Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 x86@kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <20250707153844.d868f7cfe16830cce66f3929@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <20250707153844.d868f7cfe16830cce66f3929@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.07.25 00:38, Andrew Morton wrote:
> On Mon,  7 Jul 2025 16:23:14 +0200 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com> wrote:
> 
>> There are many places in the kernel where we need to zeroout larger
>> chunks but the maximum segment we can zeroout at a time by ZERO_PAGE
>> is limited by PAGE_SIZE.
>>
>> This concern was raised during the review of adding Large Block Size support
>> to XFS[1][2].
>>
>> This is especially annoying in block devices and filesystems where we
>> attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
>> bvec support in block layer, it is much more efficient to send out
>> larger zero pages as a part of a single bvec.
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
>> We already have huge_zero_folio that is allocated on demand, and it will be
>> deallocated by the shrinker if there are no users of it left.
>>
>> At moment, huge_zero_folio infrastructure refcount is tied to the process
>> lifetime that created it. This might not work for bio layer as the completions
>> can be async and the process that created the huge_zero_folio might no
>> longer be alive.
> 
> Can we change that?  Alter the refcounting model so that dropping the
> final reference at interrupt time works as expected?

I would hope that we can drop that whole shrinking+freeing mechanism at 
some point, and simply always keep it around once allocated.

Any unprivileged process can keep the huge zero folio mapped and, 
therefore, around, until that process is killed ...

But I assume some people might still have an opinion on the shrinker, so 
for the time being having a second static model might be less controversial.

(I don't think we should be refcounting the huge zerofolio in the long term)

-- 
Cheers,

David / dhildenb

