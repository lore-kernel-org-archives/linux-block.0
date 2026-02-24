Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C502436BCDC
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771940925; cv=none; b=CccJm0a9viPKDuh6Uca1ahDRO6/0U0MYTJCA2OlLmethN9PwNNNiA5r5EyOyMX7vqKaYCgQHUFiROFc8Kl973CnwELFDAb7UIoxsx+wkjL6UR9SyQWvfg4bJ3d4cNblNCOHg614u7wkgGgThAUjflnDW9hOfdLU8d+2K6f1xTKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771940925; c=relaxed/simple;
	bh=EFzZrlZ2A8XJECXkGSOPGAYLDNQ9+SHBQIYlc/V/zf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gGX2QjVBjKmDcrbFeP9KSTUOXyzO2GhvYfOPTC+NFar3/9g3iWwG2zurcA/Oe/Ym4RBSakT+JMB1bQ8PDOz3/uVjaVjxy+MIAmTt0KEcuU9+mwX2eoIPSOowg2fm1YvtIcbKIRwVnwOIFhKbUVYJTz3NjHCqHl7o1bmH1+jeOy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzhlVvoJ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzhlVvoJ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4362507f396so5264885f8f.0
        for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 05:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771940922; x=1772545722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7doier/S6v57RTdBt1iVFnJdNLGw+lPl8KUgoSr5lVI=;
        b=EzhlVvoJr68dAV5eekTaSL5I86uAnH6oyagDe5AP2ZpWWis8KUIfu96ACoUQBUndoY
         2t6LuK6r0q2I80l0BY5oB9y3kuMH/c0B5L2yQbvVZEF7QWlp8sh6sQzLudZMg7k6CIiv
         bPPDABKEF4psEliEtsMnQb5vs9KH4B329JhIQrd05opQyH1Wpdp2wLRDDfeas+2H2W+H
         ZZxi7K6ayigCHchi2bZtZDc3LFiLgnQV9pfvWApPq3MKE4dRVBn2z0qS6+IRDq05Yw5a
         aj3gBTQ5CEZDHU8aK07nf4kfSiih7RHd77/yVDBuAUKJH90z6aD6grqmrf5KDuauRpF/
         FefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771940922; x=1772545722;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7doier/S6v57RTdBt1iVFnJdNLGw+lPl8KUgoSr5lVI=;
        b=UJaS4iHDBwyEpx1hDYCOBPS3LYfvgQ6869EEveXHoI86V0x70BluK3tjdiR9DAP9+2
         rhpRJT2nFRymDTVa6tv2QjLM0YQ7+whLUbE4wnk2MOnzISVWBxQFnBLe0FROjQpD4zEt
         mH6iHFGt9ThutlL8KtyJYcmPkGgwVW1tpKqHousLcgarM/l4NEQgRI5DoLoPfydbpbdO
         EmC/TXxeGkoBxDIczNakIbhg1RwddF30ROPsQhvhne+7RFz4zF/LosRhAr/+HUUOiZ93
         NFmue27lO8Z0r7fB/yoHuvRLAQHEumbGsq1CBk+dFBArkQukDZED87nEbKAxunp7JXdX
         Mo2Q==
X-Gm-Message-State: AOJu0Yw1BAo8S4IAX/TeOepanvm+tdNtxayPHaRpeqIBAxGOrODi66fl
	OCYmZHEfZorXjfVaFy2GOIq1Q43xmIf3E24ur43pX3d9efZFztp6dUYs
X-Gm-Gg: ATEYQzzGZCzvzyssgyBa2/1r1x2s7rLIfWDnRus9WWJ215UoCUyGm2MeExYcl1+itOp
	WujOYhplFR0OI3KOa7NkF8YEK9xFgwZuK0tWwnqVoklnfszuMtcFgduxSDJvZFaL7mV6uuPSV1l
	QMfx/85u4huNiyuvzeF/yDi/fruPwaeaG+oqqON0icH5mWYAFIJS/+8iDWmTQW9xyIg5hSZ8nBH
	j4n0N6u+ijuWqptV9b+OTRE19xnfFSabnJb8djvThsns38BNct3q9ARFSUOrwzp/KxpRmTjkyUR
	0yQ4l/KPj6i4FCa6LEiEADr2ngwaM/Irzl/TitDrZVcbmTfR+krUx/aLSwg1UMx3ngSAPXIV72Z
	+8t06+buUXASOVC+EIo6orkuiP/YW/Y9R5F8Id4NrOBL/ZZI7cdlATbjCm4gwmZl2e0JLUrg32v
	+SdzdkTLPRNx2skx1UZ9AJ0yOnQXHbnPp1fWSIFemBqYMYyLzt6keOHjg7GCrZFWgIBegMzvk8z
	9/l60fLcHcPtma960JPYi6R6n9kC+Xv2a2Tw3zEM9AiaOoqOQ1QRLmhQhdJkl9tEUWoY+rjDrqL
	Bw==
X-Received: by 2002:a5d:5d84:0:b0:437:69c0:9612 with SMTP id ffacd0b85a97d-4396f15af1dmr21713147f8f.13.1771940921895;
        Tue, 24 Feb 2026 05:48:41 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3fc12sm24786376f8f.24.2026.02.24.05.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 05:48:41 -0800 (PST)
Message-ID: <b091a8ae-4767-4ca4-a1b2-09cb525c4ff9@gmail.com>
Date: Tue, 24 Feb 2026 13:48:39 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] dmabuf backed read/write
To: "T.J. Mercier" <tjmercier@google.com>
Cc: linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Gohad, Tushar" <tushar.gohad@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
References: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
 <CABdmKX2+OiqobQKf5G0ABiTeW5oqXS0p1dH7wRe2H7Gwdroi0g@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CABdmKX2+OiqobQKf5G0ABiTeW5oqXS0p1dH7wRe2H7Gwdroi0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/24/26 00:13, T.J. Mercier wrote:
> On Tue, Feb 3, 2026 at 6:29 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> Good day everyone,
>>
>> dma-buf is a powerful abstraction for managing buffers and DMA mappings,
>> and there is growing interest in extending it to the read/write path to
>> enable device-to-device transfers without bouncing data through system
>> memory. I was encouraged to submit it to LSF/MM/BPF as that might be
>> useful to mull over details and what capabilities and features people
>> may need.
>>
>> The proposal consists of two parts. The first is a small in-kernel
>> framework that allows a dma-buf to be registered against a given file
>> and returns an object representing a DMA mapping. The actual mapping
>> creation is delegated to the target subsystem (e.g. NVMe). This
>> abstraction centralises request accounting, mapping management, dynamic
>> recreation, etc. The resulting mapping object is passed through the I/O
>> stack via a new iov_iter type.
>>
>> As for the user API, a dma-buf is installed as an io_uring registered
>> buffer for a specific file. Once registered, the buffer can be used by
>> read / write io_uring requests as normal. io_uring will enforce that the
>> buffer is only used with "compatible files", which is for now restricted
>> to the target registration file, but will be expanded in the future.
>> Notably, io_uring is a consumer of the framework rather than a
>> dependency, and the infrastructure can be reused.
>>
>> It took a couple of iterations on the list to get it to the current
>> design, v2 of the series can be looked up at [1], which implements the
>> infrastructure and initial wiring for NVMe. It slightly diverges from
>> the description above, as some of the framework bits are block specific,
>> and I'll be working on refining that and simplifying some of the
>> interfaces for v3. A good chunk of block handling is based on prior work
>> from Keith that was pre DMA mapping buffers [2].
>>
>> Tushar was helping and mention he got good numbers for P2P transfers
>> compared to bouncing it via RAM. Anuj, Kanchan and Nitesh also
>> previously reported encouraging results for system memory backed
>> dma-buf for optimising IOMMU overhead, quoting Anuj:
>>
>> - STRICT: before = 570 KIOPS, after = 5.01 MIOPS
>> - LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
>> - PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS
>>
>> [1] https://lore.kernel.org/io-uring/cover.1763725387.git.asml.silence@gmail.com/
>> [2] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.com/
>> --
>> Pavel Begunkov
>>
> 
> Hi, I'm interested in this topic. I'm guessing this will be in the FS track?

Forgot to mention, I submitted it to the storage track, thanks

-- 
Pavel Begunkov

