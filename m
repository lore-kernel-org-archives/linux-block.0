Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1536313298
	for <linux-block@vger.kernel.org>; Tue,  9 Dec 2025 21:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765314333; cv=none; b=n4aK9pybGUzOaQTpR8DfkNNBpOWG/KTq9bUSnx3UJVsncj9RPOK6y41bEGd19viMtE9fSWS0pffxU00NUpa1OBlFYCzR+cZLOhMMBe/X4uuK5DlQlGVEkyLrLs0Qhr9oP2FxpFSUq1XwsAL+SXpljWJA+g9E0QVLB3R4cMSYlN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765314333; c=relaxed/simple;
	bh=ydHiuDxIrW5FazFjw0AZzylfnfdPPZlpeSRd2sqLG7o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lZTGht6QfzhySUPesmeI9mvpw6AhcFNvWsQVKIt6yrmbH81onAdIYxD+ltBra6ZEBojp53CE5y3uON9KIExgDQ7NFb0TqrfsO4tCjkCEDxsv5PJOQbvmXiffHAt6ju+3HIIs/yOequ8Rw6TihQ43tdhe/8qFK86OMP3Kv1TZhdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hPWoNszm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cfoZ4DRS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hPWoNszm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfoZ4DRS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765314330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5JtO+/e6kTnIf7NZZ+Q5LHQ9Py7x/v7ASju/lUvZ3DY=;
	b=hPWoNszmH2Rp6jS81jfBq9chRheafqXWuW0SrUcYmnqR8LyCBo3GEjlJLbVubtA3f61r6Z
	GwBwNflrjLRrfHmNtWeRzjr8Zoh4tXtJhfBJD/uKhp6M2FphHc6psQ1NjzVqrbdCl032ca
	7l1HW0Zmdj8cKI9+FzMi/G2lKY3iI+Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-Tzd4niOzOICGxn4OPyXHQg-1; Tue, 09 Dec 2025 16:05:29 -0500
X-MC-Unique: Tzd4niOzOICGxn4OPyXHQg-1
X-Mimecast-MFC-AGG-ID: Tzd4niOzOICGxn4OPyXHQg_1765314328
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso76418045e9.2
        for <linux-block@vger.kernel.org>; Tue, 09 Dec 2025 13:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765314328; x=1765919128; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5JtO+/e6kTnIf7NZZ+Q5LHQ9Py7x/v7ASju/lUvZ3DY=;
        b=cfoZ4DRS/W455VUxw7qfWByJAwdWwTGvFxyzaOXEe5uGMX9EWVh9a0JnSIWE7ZGeQU
         OXslLQVg3EXOL8i6ldEZ2QkHb19Kuet/ktn+R9bgU/IqL3OrCCVF7+dwQfMv8WfSC+Ct
         lApHg9gnTzgs0pRaYba/LF88E1ztoKGCprVyZ2bTvGRwKXnyG1xJnemi8tX/yLy0JQni
         3KC7WDBU4WZKjjDJD5KwKMQRvFo2p+1EPmh+kSggEuINBWmPo1WCCDcr2itZBUQcC7MS
         ZFs7IDjoCQhppjU2U35Ze1HaRWnHD+WG0lXv3Ffn+zx7vdoRMW4YJHhQkrQHE1DrCM3L
         T/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765314328; x=1765919128;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JtO+/e6kTnIf7NZZ+Q5LHQ9Py7x/v7ASju/lUvZ3DY=;
        b=tEIoRxR/K/8WZFkFN4ZheS+QEisZY7PxU+sMje4XOqhWmNDH3fmSZk4hBIe2RswPRD
         KYQKayJ/F5oi5SRDeeyv//z5/ZqUBmcxZxXUZ9AjDwClJsdrXs93I/6RIQu4iipMNTZs
         3+L4rOI3pqTj957FtkVIRswk2quMpBsUObm6ZQ0XihLXR058OZ+ouLDUIUVr+lmQ0A+n
         +0TZw0xODXurotD4GBjCmpv+ENn8woztJTl7LhfWzknPFefeJKC/ccVvaaWbvpue1q/U
         4RkMIARCY8c78WN2iEMcX6uzOQDzD1qO6x5k7f6Nw/Y09/t3COTHRVpLeVykmjTHmDts
         VGsA==
X-Forwarded-Encrypted: i=1; AJvYcCVPT5vtRJ9AEvZ4rvYAMYAKolCzv3wOjmtAuDIXXmiwKTjzmZdxTyWHOE2M2SaAU4cPCQprN2DIrlBIaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5LwfK/YV3CCyHevzdQ6ENbf3zmQ1xwp899vQWeRP30Y1Gi2MS
	8y/NPlwpg/imLqIjwKiewMsxs63gg4jb4qMQ5vprEIx1AIv8xw+Q0TPpdrJG7RdmeK/QUdfT7Pc
	1J5KrG3zRMDtSQdziwvtauFNcqXx+bpN6q0tqk6Bt8vhUOqwKMZAnXFYpNOheUO8v
X-Gm-Gg: ASbGnctDQfuN3fbIMuJp7Cm+S1WY8QxPiZkoh3So1b24TjZQ1saMW80ldDCp3rYhPF5
	t4motE1VSnX71YKdFKnukbGmR5SzvlxuGt0vRhcoK+vN4KUFLLw/bUrb6FWCgfoIo3Orw4BcSIv
	Gj6UbV/jUV+J3YNrqHx7ukhXaUS3Whfxe8OMsSA6OZNjhxpEW7g9o1PQN4Zfb+wfu30IOpYy1q/
	km6OXoiI+PPg4LU8c6lozDHWhZZAXOU00RuGmMeZ9sr/KkfRQR0fy3emJNkk3nk34zPkeguFFvR
	2LM/jH/+P6tv4g+3DRGhN1Q7BpDi7JYpYPTEA9Jb3t0HAyNG/soJdhqTFGqzk+39Zbecou3h+jI
	MJ6vxWDKX4boeKlnudWfcn+frhhd/WkYR7hquYJqQpt+l/zBHDYc9B4deulY=
X-Received: by 2002:a05:600c:34d1:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-47a83744a33mr2306415e9.2.1765314327653;
        Tue, 09 Dec 2025 13:05:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtCAFhErGwzqpGWe7IpcJT0+41Hr+cUdeizf5PIDHvpAkbhAflBzeSLnGEysOKGluXPZLr/A==
X-Received: by 2002:a05:600c:34d1:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-47a83744a33mr2306225e9.2.1765314327245;
        Tue, 09 Dec 2025 13:05:27 -0800 (PST)
Received: from rh (p200300f6af498100e5be2e2bdb5254b6.dip0.t-ipconnect.de. [2003:f6:af49:8100:e5be:2e2b:db52:54b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a82cb12fbsm10202915e9.0.2025.12.09.13.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 13:05:26 -0800 (PST)
Date: Tue, 9 Dec 2025 22:05:25 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: linux-nvme@lists.infradead.org, iommu@lists.linux.dev, 
    linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-xfs@vger.kernel.org, Jens Axboe <axboe@fb.com>, 
    Christoph Hellwig <hch@lst.de>, Will Deacon <will@kernel.org>, 
    Carlos Maiolino <cem@kernel.org>
Subject: Re: WARNING: drivers/iommu/io-pgtable-arm.c:639
In-Reply-To: <4386e0f7-9e45-41d2-8236-7133d6d00610@arm.com>
Message-ID: <99e12a04-d23f-f9e7-b02e-770e0012a794@redhat.com>
References: <170120f7-dd2c-4d2a-d6fc-ac4c82afefd7@redhat.com> <4386e0f7-9e45-41d2-8236-7133d6d00610@arm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 9 Dec 2025, Robin Murphy wrote:
> On 2025-12-09 11:43 am, Sebastian Ott wrote:
>>  Hi,
>>
>>  got the following warning after a kernel update on Thurstday, leading to a
>>  panic and fs corruption. I didn't capture the first warning but I'm pretty
>>  sure it was the same. It's reproducible but I didn't bisect since it
>>  borked my fs. The only hint I can give is that v6.18 worked. Is this a
>>  known issue? Anything I should try?
>
> nvme_unmap_data() is attempting to unmap an IOVA that was never mapped, or 
> has already been unmapped by someone else. That's a usage bug.

OK, that's what I suspected - thanks for the confirmation!

I did another repro and tried:

good: 44fc84337b6e Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
bad:  cc25df3e2e22 Merge tag 'for-6.19/block-20251201' of git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux

I'll start bisecting between these 2 - hoping it doesn't fork up my root
fs again...

Thanks,
Sebastian

