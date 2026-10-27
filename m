Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111351;
	b=j4Y8OTR+AdMTQElQDLEzJjSPYQ27W6rrscdYDnyduJekMBCmwO+3QHxT5ey4Pl4glwd/
	 Hajzn8ZYafwGVqLTi1J1QVdPKMKumf6UXzqmqrLm1woZhigVtQu9OJqJrgaq5zke8095c
	 dqTQQ+oh9OHhl+ScxDw82+xrefrmH/DftPDOkmQ3pHKbDu21QkUimRBkz6Wmvs4Oum/av
	 jUxueAFXe7OwBNbWtnb/U8DPvjJdd3jqrtGEg32EQDF5YQQWVuvs6X2ZoF3LWEwm5cq8g
	 HMhMT0ztXTirRp0xHQaAWMp+Vvfwii7o2e+dtnwpcVWdFog9JZN+gQhKq3fcCuHMIRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111351;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=DdqPE1hxlr3HcgV5Z9+I8/97tTXj8KtZhhg4o4QDLzc=;
	b=q68Um7cHRKaVl6vHrwR3qxbgcui974jU8SEx87YRirlcXq6LAH/sZeUQm2B9D7TxU/J5
	 nD77AgEX0BbCaERDNxfxMr4f816ikhd0gdYP18cG1EWfGhOjC40aSO93Ntf4g9ybJEPJh
	 aV/zZpEQv9RbszPZoRi/JvWg8WIH5wCTrQUbTRf08scWnw1MRY6wvM6KuT1Ue8LJj4fUD
	 s7hzhtPm1YTepmtaGRXwIVksQs36mzy5Ds21wjbIGt5eEuucNvND3uIHKUK4Y2g0up7Bc
	 JUYb6vqf0CnZ9+HBeUfrh9mDsMxaQ1jS7was+EfVCjjglCaREsOmwm2KV7Fg0Pd3gqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jOOcrNBy;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7B6606A31A
	for <linux-block@vger.kernel.org>; Tue, 27 Oct 2026 14:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E7B6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jOOcrNBy
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so592640366b.3
        for <linux-block@vger.kernel.org>; Tue, 27 Oct 2026 07:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793111350; x=1793716150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DdqPE1hxlr3HcgV5Z9+I8/97tTXj8KtZhhg4o4QDLzc=;
        b=jOOcrNBy0FCbE6+c969W9rfT356iP2ufLG5aWWx4Fnm5Yoru447H6ciVzyJ1qRAX89
         rYphNbPduTGtPiCP8aOfAmtqJpAlTE5+prDhVckMyv7ELOOJUC+k00cekiam2iAlynAG
         uJ+LcsGirSK+IbvPag7PnbmT5E38EGWjfPlhIbALz7F8zsTUJBHsaaktF0Il3+g4Y33Q
         HQTkMmPEtgQPUD7UUwm+ByUrW9I1E//fDbmaDw9B1ctE0491CB0l/vxzX457iR0VzZuw
         +hVSH/uefx01AwR9wgbRxF3T+SVZiEabxKEtqVA7pH1hMrosj2eJdjuDPkELLrtqdorC
         N+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793111350; x=1793716150;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DdqPE1hxlr3HcgV5Z9+I8/97tTXj8KtZhhg4o4QDLzc=;
        b=Chrd7/jzXi8pcT9awSrNpO5abJCfhfWqZ/3r++rgERST4t3gVx5Eifig++jzNNU/qx
         yvmTz1oLzt9obNf8uNs2Va1rGH5fMwV/1Hnx3V/73Vrq8C9sm7IL8IZbUwPgfYzZ/sOu
         vNUsIKv6aWa9RICGwbP3R9oNbPp+rV1tA8V0X1YgkUQjE9vNiaXqogHN2KQqnNljnDhS
         Lkq4s5gBcp2Fj+gWC0DcuKk48EeGWZYJZ5tFgJMK0juYXDV+4gIRQXfVPI1ZhLLtg7zf
         LRPowf71glEUnHR5sKbnJtXpJxAnZI+3EhwfVLCiYzDP9YjHEUj0cjHOJWqhdJatVLjz
         LZQg==
X-Forwarded-Encrypted: i=1; AKwUvBxM56nJd21wr1C/U967UHNBlZMh/BRGCbw4iUeILy4cbxD/dCuF4JTi+gzRDYDdj1r/tzw3AxZBqly0ZA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLktuqDaEmeE7IgALxGhyXNergTTQXbs36mXy5VFtMXjNtlFf9i
	LcB9diNG5s2WuUvzuS77qtsoMNu/iP0EDTimo+JW4Gu7G/mzWcP07++U
X-Gm-Gg: AYBFou3NmLCCQDh2y7u0goU2FoP9Rf+Ka65s5244Oaz5VHblqBK0+np+JJ7tbYLQ7Du
	FXZv4Ftiv3pUVIqmRekhN6bro0mM60iax+aXJxWCLUkdoGbPMwZa+qxwH+lTAV8CyCuaDuJuj4h
	YjyyIWFc2uPV6E5hfASL72wk1UMD1lG/Y7pP377DOzYJrU1bNKjFReBZpw0ilFPT7aOy1LC3uHx
	2k1iiWW6tSZ7ntKtV0DS3kHIo4bXOLAhJu6VeZRlXTzGf24AQIjzfg/vYbOXyQIbjNfTFvw/FNB
	mu8ZhBuRHxrCgaNoWAWOP5K4yMyG1cstSZKKW2YDfmazyk8U0S17KTPv9Wg4uYoQwB/S7xTqDVt
	GnkyWF69EmsvfJY7Kl79WQgDt0MUCMOv/c6WguzorK23qCI8Ud+h29qwCq1LVFgVI2KFlnxicM2
	tNE2RSjwL1qBkGe2LjJFvh0zy6RpDyQloYqaVIYrVU/OGxiHiOrj2u0fiTcSDq6qnbaYWg1si/+
	3QvRqyde7djgKOQAZ0SAWkbW2bTd4P5Ue7S+useG8xt9bj+j7JhdsAgD0+wsWIpaLnCGMk3hQg+
	m6/MCBN5k+eH3LfxzxP+sCUWUZTNrqys6X6auHJoB7CgWeIf+V3u/mYAL5/RjxObcrSXN2un8H3
	9KKKlGd1RvB30/zg/jza7vj4du4IvaA==
X-Received: by 2002:a17:907:6d22:b0:c2e:4b90:3c56 with SMTP id a640c23a62f3a-c46bddb306amr1127968566b.13.1793111349505;
        Tue, 27 Oct 2026 07:29:09 -0700 (PDT)
Received: from [10.54.182.141] (82-132-213-26.dab.02.net. [82.132.213.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c49a50c434asm151877066b.5.2026.10.27.07.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 07:29:08 -0700 (PDT)
Message-ID: <08e772c7-5e32-4e0c-b161-49ba970c6595@gmail.com>
Date: Tue, 27 Oct 2026 14:28:59 +0000
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] block, nvme: minor fixes to dma-buf support
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@kernel.dk
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>
References: <20261021184658.644645-1-kbusch@meta.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261021184658.644645-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/26 19:46, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Just a couple minor fixes. I wish I could say I caught the first one
> myself, but no, I prompted an LLM to look at it.
> 
> I am assuming changing the bi_offset type to accomodate large offsets
> isn't acceptable as the bvec_iter's size appears to be packed to be
> small. I think there's a path to accepting larger offsets through
> bi_idx, but the patch proposed here is a safer quick fix.

It'd be curious to hear how you want to pack it. On the same note,
we'll eventually also need support vectored readv/writev and very
likely have the same problem. E.g. we'd either need to keep map in
another field (perhaps in bio only), or demormalising data and
keeping an array of {map,off,len}.


> Keith Busch (2):
>    block: reject dma-bufs larger than 4GiB
>    nvme-pci: detach dma-bufs only on removal
> 
>   block/fops.c            | 4 ++++
>   drivers/nvme/host/pci.c | 4 +---
>   2 files changed, 5 insertions(+), 3 deletions(-)
> 

-- 
Pavel Begunkov

