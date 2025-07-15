Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65905271449
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589325; cv=none; b=CM6tWVqeVkkD13TbVFYlEaIHby5rqqVwtYNSTmwGxw8SIgSL1h0ZDvDr5WBai8dd7aiISIUwiJiDmAJrMpXL5P2gsamn6qZcM/I1EGYjUjpTn2H8HptrpmI5oRmKoAHFdCTd7M5RzjF5JawGX9XDwHxpKuQ/GT2zfX/HtNh1Ntg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589325; c=relaxed/simple;
	bh=6vTFftX9JgKJtLyS9WEX0i/rEg1WH40G07TigvFEHyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZM4Ah89FJSgd3UgpqJGY6ux9UYZwFWOgKBYP942IPSs09OO3k3pzwpfnoAluOT7yDLD/mmkgNIlyR36GXylgSswNDlUAbRyR3oafL2wACnbO1Z4WdSLPINpUtLgC0i/UK7b1Erkf393iThSAak2UBqHc5EZqdDI03t5XAhdCfls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I+2wgWrl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+2wgWrl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752589322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oDrEGUfdEY5bNUZj0OPBlZFo/nFLzvL2Qn0I2Pn5t0w=;
	b=I+2wgWrluEe7HTGbGvCg1KJ0YLtRiE1/D11mGVwM4jF5WIg4PgmRTbaKyuqEtl1BOuoQTu
	UEaz+vTG9y0KpoaojIYCwVZNxqn6SW7nkvi0DJwr/cFmOIaNbuCa83XM0aCWFWrDZOiHOw
	yBbQEWg3xltltyDJurgCUFPj0vDAmWA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-oUiDR8qeNumF4jzPxEPmPg-1; Tue, 15 Jul 2025 10:22:01 -0400
X-MC-Unique: oUiDR8qeNumF4jzPxEPmPg-1
X-Mimecast-MFC-AGG-ID: oUiDR8qeNumF4jzPxEPmPg_1752589320
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4561dbbcc7eso7652405e9.2
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 07:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752589320; x=1753194120;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDrEGUfdEY5bNUZj0OPBlZFo/nFLzvL2Qn0I2Pn5t0w=;
        b=BTOcmvOMsLTQy4JGBTiMqvGaUt8xWmnOY8dnp0ufj/lh4+ic/noxNpszXyd9oncJTw
         B0qsfiILUYOZTyJA4Y9b5ScW9vUgPyvu1SxA1M7IjATLm85z0VI9E8JYoHJvnJLwM6HJ
         nufF1hfiepoYf0DQbAy+NDs7qg8jZ7nE4al2GyGsG2OyV7F/SDsgP+DilIEO+BCeQv7i
         KFVzMZVehdbTogvsnu9Z8ER8O3jOEAKoH9bGTfPlSh88Bzvil1RWWZDctHSdWohFT+3S
         l8HafUoocVukz8sRPpB33RA+OXTDL7xficyY2wrSDgcKqhHmcymJyNo6D6nVT9DXDFp2
         85xw==
X-Forwarded-Encrypted: i=1; AJvYcCVFuzcQRhFsO3KGUARSeGECvA9qrQ1w/3ykZPEqrhDveeVhUNDgi8HHmkkr1jDnRGiZPo2/aaWXlqZxIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhqkZ1HYSEGmdW4/DULCX5AsMIPUsNEHo/R5r6cCpNbkqjNX9O
	SDn098D7/pahs8/I8NpWM+bNdURd0cdzSvCoYuvnqH75jSn0cwk+udzS1hnxRj9b73DNyipg0tm
	8wuQxaRkUslrBIaFmNwZa//zFMxZZKAN7y0CTbCZItjtMd45EwpvheEG98B43gpay
X-Gm-Gg: ASbGncvcRwRkreyGzU7o1CmU9YZRxYlYVd4V02k7hb9Sj9j5ilZ5y3zTYCZL1fQniXZ
	Vcif6IA3nHz0O5bzWF8wG1JIjsw/qkXnVG1qM3rQjPUqxKMfqI/x11YviXzrf02Dz3sry2wa+Nh
	txPJqIn2WhfdLEVlrM+OPnVwETlNlVYT5R3b5i7I2qysJo8SOr6Tj8+tahB1lP63kw9K7U6Jh0G
	h/vCy9G5hX72TMCeDWZqM2RSVX+cM5bXEYS40TQ9D2JnuVGz/wsuRfETFGQr6rxcdk6/G0zAG8V
	l5QMzZ3ETzifN+6VH/+ZhBYFbjbAd1RP+xLR/0a2NwN2IIvaHwkaucA9+Pv2levx9BOSGGuSjxE
	YOaSKW9U6ewmSIAmp3TK2GJSd3n+hmKGoqNzwfafSyiDRV75DHSQV12m6gVyud6M13RI=
X-Received: by 2002:a05:600c:a208:b0:456:27a4:50ac with SMTP id 5b1f17b1804b1-45627a4535fmr16117395e9.23.1752589319852;
        Tue, 15 Jul 2025 07:21:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmFicQGLhaeIqIZaRygdy0pZOKRG2JvGq7gYgR7tSdKq9ZAb0t0UWibnFtXm6Rsiqbr86/Tg==
X-Received: by 2002:a05:600c:a208:b0:456:27a4:50ac with SMTP id 5b1f17b1804b1-45627a4535fmr16117065e9.23.1752589319405;
        Tue, 15 Jul 2025 07:21:59 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e135sm15388978f8f.72.2025.07.15.07.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 07:21:58 -0700 (PDT)
Message-ID: <26fded53-b79d-4538-bc56-3d2055eb5d62@redhat.com>
Date: Tue, 15 Jul 2025 16:21:57 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm: add static PMD zero page
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 x86@kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <20250707142319.319642-4-kernel@pankajraghav.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <20250707142319.319642-4-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.07.25 16:23, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> There are many places in the kernel where we need to zeroout larger
> chunks but the maximum segment we can zeroout at a time by ZERO_PAGE
> is limited by PAGE_SIZE.
> 
> This is especially annoying in block devices and filesystems where we
> attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
> bvec support in block layer, it is much more efficient to send out
> larger zero pages as a part of single bvec.
> 
> This concern was raised during the review of adding LBS support to
> XFS[1][2].
> 
> Usually huge_zero_folio is allocated on demand, and it will be
> deallocated by the shrinker if there are no users of it left. At moment,
> huge_zero_folio infrastructure refcount is tied to the process lifetime
> that created it. This might not work for bio layer as the completitions
> can be async and the process that created the huge_zero_folio might no
> longer be alive.

Of course, what we could do is indicating that there is any untracked 
reference to the huge zero folio, and then simply refuse to free it for 
all eternity.

Essentially, every any non-mm reference -> un-shrinkable.

We'd still be allocating the huge zero folio dynamically. We could try 
allocating it on first usage either from memblock, or from the buddy if
already around.

Then, we'd only need a config option to allow for that to happen.

-- 
Cheers,

David / dhildenb

