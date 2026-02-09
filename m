Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB3436E49B
	for <linux-block@vger.kernel.org>; Mon,  9 Feb 2026 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770635725; cv=none; b=e33EtQuEOnkVhyeisbfq+uwca5ZHlxZodbCqZDaKaSh5IHO/el30etQU3vqfAYR8L88xFDgVZi+tQ/284Y2AMknEzY6fOFtQ+cW6LItpZ24tlAFMKXNuBT6XbV1MrzbtKoW0ybixhmq/DdcGze/elx2AxXGGVlMjbQRFCct1LcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770635725; c=relaxed/simple;
	bh=eFyLq2eShSuSoRftAfNzIMk7e5J3AUWEPeBcMfu5m68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sn/r6AU9IDc2TnfSSgky19txJkGR7282jSKst5mJbCpFSP3/USPPMrQw3r5uRpUbbAlLx0a/RqhgEfPhArodCU441eefniD1KtPcF5TKHyOdENIYuE2yfLsZq44Ouv4dvXXxq1SDOaYcgvVuyqYrUZVcQYtyXVuEq72z/nyROFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LW7YteST; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW7YteST"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-435a11957f6so3340311f8f.0
        for <linux-block@vger.kernel.org>; Mon, 09 Feb 2026 03:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770635723; x=1771240523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3wbG3Hwlnnt7XslslOQ5Ajzf6jd6ChHMQtwpqlWp/yk=;
        b=LW7YteSTTFZNudE7wYSq4uzKRotya6t+c/tpDKe0aQubmcjnbywKTV4ZD6djoh5Awl
         +SDAinaG2Iuz4DJ6Ti6gJ9ahiLrQRG8o9beCRW+gM9MGuOBgqiRdAWzfRpiGUZWjqv/R
         Ep/aeauG4Ax784yVdeh0Xel1S6PlwumZtaJSg7dugdtPl5Sv8jvMC9x7FJJI0ie4xtaY
         XpEM+n6N8ShL7PWD+z9YjGDjhya6P/SfF4rspdbi8U74I/Fm/cAd9fiuiQTlR7VRAt6F
         evyzvU92lGCuyG1O6/fqh86AriJYe+oeZvHl1RXfS8ZhGUmF6lbN/1yCaI2ces8rtFFE
         JFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770635723; x=1771240523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3wbG3Hwlnnt7XslslOQ5Ajzf6jd6ChHMQtwpqlWp/yk=;
        b=ImkjwAlaLm3hRkPEhMaz58RwwqS2ZDrQ1kvgGHkIeYJH5l5iEfd/2PT/+X/ZkfOBvV
         K/YuRm5xfCQBxyuJPfn6HbS+45upoQgtiH9n9suuU2Ky0xJ9MX/EL2vds98n3wB8pckw
         eGRtG3kMTmY3J3x2L85VsZKtvaYVvdqzbg+/jH5x1OzaEIkgpFE5wTUuVKhaoIMjz0X7
         zX+j9eME0tt8k7ueUH4S3pTWjctzteaAiYbs94DLOwcHD3vaw1KevYAGboGVth4CHfvL
         CUCSSxYaZB0iliSM8v8v2/MaPtYYKr4IiJ50j9s+90ic8FcOX07YbqTLrlkldB6z/Uqo
         uPlQ==
X-Gm-Message-State: AOJu0Yx10uTC1AN+QExRB43UVTxJtzAhKG3ZQDW/+UTNeryS5n4wBNRe
	0/0V/JS2ZixdIVyt4+WRAyVHtnlhN7iT35WckaDGYrDH/tRbB991pJKg
X-Gm-Gg: AZuq6aL5HBbXrG2U3FqXgWuAU5DvM5CpqYWUo5JfaMvgn1eefL9FdpyQJXj+PqklYhn
	f5YAjrC63HvO3R1RrF72LNsABE0esEd2d7L4X54szHOGke/HjiIyGyeIQkfZOi5ShSlHMOJ3kpp
	JWFAuSws7IoeVxkp/RI4t71Qt32zKcwanpXVlhpBmTh6M5iafvqh8uENY7WRrpV1lWtDbBSHjyu
	9ivGOEaX+stUNxA46Qr/jy1NT2cT2L/SdBsP/OwQ7JPdzegn4+cmv+aeYL7MDEhJMEAXsNuK2cE
	A0+m1MLZJg6I+Kl6IP+Flu0WKIoZtHEtQnGZPgy/0dLKFQb/d/05vHZ8KM5rpVMl6HjQyPqtca+
	J3cm37Uk4T8cXeIuShaTUw2ErG1kJ5GyWCsDxClgAbmr82JxIM4+FpucV3MMrh1lnu9t8pSzH9U
	9w4hg235vkp6mkH9xGNXZp2ZdnoGiS7rCSinAqTjU1Qg++uRjaz8l+VImJWT6RmWid9EUvLH20E
	JIYaWDoPZNFLI/vr6IG23gjR6hzf9+M7x31s749M0z0XXo=
X-Received: by 2002:a05:6000:2209:b0:435:9241:37b4 with SMTP id ffacd0b85a97d-4362938ffe3mr19185555f8f.53.1770635723028;
        Mon, 09 Feb 2026 03:15:23 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:9b67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376806626fsm12638100f8f.37.2026.02.09.03.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 03:15:22 -0800 (PST)
Message-ID: <76299bc2-4871-4571-bef6-9886ee0d2c5f@gmail.com>
Date: Mon, 9 Feb 2026 11:15:22 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] dmabuf backed read/write
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
References: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
 <CGME20260204153051epcas5p1c2efd01ef32883680fed2541f9fca6c2@epcas5p1.samsung.com>
 <20260204152634.gyybb2axszwpewrk@green245.gost>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260204152634.gyybb2axszwpewrk@green245.gost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/4/26 15:26, Nitesh Shetty wrote:
> On 03/02/26 02:29PM, Pavel Begunkov wrote:
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
> We have been following the series, its interesting from couple of angles,
> - IOPS wise we see a major improvement especially for IOMMU
> - Series provides a way to do p2pdma to accelerator memory
> 
> Here are few topics which I am looking into specifically,
> - Right now the series uses a PRP list. We need a good way to keep the
>    sg_table info around and decide on‑the‑fly whether to expose the buffer
>    as a PRP list or an SG list, depending on the I/O size.
> - Possibility of futher optimization for new type of iov iter to reduce
>    per IO cost

There is a bunch of improvements that we can have on the NVMe driver
side, just take a look what Keith was doing in his series ([2] in the
first email in the thread), that looked very exciting (I dropped it for
simplicity). I was planning to take a closer look at optimising the driver
part after, but if someone wants to take it off my hands, it'll definitely
be welcome!

-- 
Pavel Begunkov

