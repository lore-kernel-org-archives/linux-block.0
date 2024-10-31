Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9330012C522
	for <linux-block@vger.kernel.org>; Thu, 31 Oct 2024 01:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339058; cv=none; b=u7Dm9ctMVJwRyfbPnO+0AbgmYyeocMJEw4QPb4u5m4J/fwBlFhh3uHMkXeH2R+1R7l+mE8h+ea/19FeBgF/VERPbDPNSJpB2DIIhU3Zqu73AEqt8OWp83YHEdJ6cLmbsQGypFIr91XhSdrDNLDmP59wAIuUSPCxzN3M+fmV3ZDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339058; c=relaxed/simple;
	bh=OfvPc+5lwRb7y4SbauPRI4zVY/IksQfQWO+Wr/AIhFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bvsY/HXJy82TbNoRv4pyeptHKdnBeqyFVw8QbqCBqiyiPOoeaRwYS/eqsRdwgQHtoYhV8sbPAz52WKS0V1bslWvTRlKqkv3qEmcpSVzuS3FdtyBEQV/oXx6Oxf/WTcWRG63b2cgMunBUVcOQQOGzMgLg8Vm5Kn6GXXxPCqrhqO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tuf643hV; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tuf643hV"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7edb6879196so377551a12.3
        for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 18:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730339056; x=1730943856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R5HJbtUFcFXgZVBH0YtIsWB+OH8uOJ8D1+BabaE0bvE=;
        b=tuf643hV+ElfF954yMb77toE1oTjXBM1ZnTPWjIsarNiqJiWLJH3kVwqlx0n7wnyix
         Mlzo/QVip836Lq9BRDnT00HsemKyVERhP55CMuNi3qXORGgz+axl5HOO1gv2a0x75sFW
         Tt+JSfxEXB92xCrnzBBfduSg5vNF7ml7MZN6WAN77PPIDQuJJrY3iLmfxKqhmQxARi+7
         nA8yOJx+PjnVl9APuoL/sGMBVnBm+rWyOv2NkoackRF36CJu6hlxiJ8mQoYMouFQxiwI
         b4RQLnL4IdX7uG0YoERijcl85YOmCrthVAgS26Upyc9T2VRhPQCg3o/xqeqZqVwLGINY
         3Oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730339056; x=1730943856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R5HJbtUFcFXgZVBH0YtIsWB+OH8uOJ8D1+BabaE0bvE=;
        b=hwK++M6m1p3ZS77rKH8ADgyWetl/tH/waLLSTdeY8QbZKp+TFCsaD9CjWcKOG/I3hX
         +tsJIt3y7WYevhQQTC9qjOHNg4GJmd7ucMzfGv9RCacnT9NU94g7aVpBmwsEkJMCXvjd
         p36FEQ57VJBfhgJgCmsRMRRm6tsz4Fyltux2lQ1UWOCdLUF53A89ir0EKHrJODnveEA2
         7sfnF0SKcw/KoIUmau9uvtwlOEFApp9v13WQhKo19+7YdmRn1RbIpanU+EsAOrVR1rsu
         i5NzcEq65zQAJFyBjG7juefuR4CMduTHpayID3iW74psZ0e7W6mRt6REdHrF7Oxzc4t8
         FTnA==
X-Forwarded-Encrypted: i=1; AJvYcCWpu5KOn82KjdKzIaXJreE9Q4nihxYt0pN1YUjMbEMJbcgbQvy3GP7u6lTsiQ1k4N0Dtl8sN3m+xzHqkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOOqI0vjvARUmB5v+IVTXv/XsgiNWOhrEb91c6RCqLqCIGZvbC
	evufffM/T0dvL8LxDgKBNd2STBbaU5cfjbhe+L5ht/1+S//AdlfB2PUlheYfEb4=
X-Google-Smtp-Source: AGHT+IGsg2gMuDdd8QNd8tlE79QeVlOXl87E5sZsK92hB7UM4f0gqnlbEouiOfBHyppk70cC1W17JQ==
X-Received: by 2002:a05:6a21:4d8b:b0:1d9:b78:2dd3 with SMTP id adf61e73a8af0-1d9a840aaf4mr23384613637.26.1730339055795;
        Wed, 30 Oct 2024 18:44:15 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93daac966sm332679a91.17.2024.10.30.18.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 18:44:15 -0700 (PDT)
Message-ID: <3144b6e7-5c80-46d2-8ddc-a71af3c23072@kernel.dk>
Date: Wed, 30 Oct 2024 19:44:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <cover.1730298502.git.leon@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1730298502.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/24 9:12 AM, Leon Romanovsky wrote:
> Changelog:
> v1: 
>  * Squashed two VFIO patches into one
>  * Added Acked-by/Reviewed-by tags
>  * Fix docs spelling errors
>  * Simplified dma_iova_sync() API
>  * Added extra check in dma_iova_destroy() if mapped size to make code more clear
>  * Fixed checkpatch warnings in p2p patch
>  * Changed implementation of VFIO mlx5 mlx5vf_add_migration_pages() to
>    be more general
>  * Reduced the number of changes in VFIO patch
> v0: https://lore.kernel.org/all/cover.1730037276.git.leon@kernel.org
> 
> ----------------------------------------------------------------------------
> The code can be downloaded from:
> https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git tag:dma-split-oct-30

On Christoph's request, I tested this series last week and saw some
pretty significant performance regressions on my box. I don't know what
the status is in terms of that, just want to make sure something like
this doesn't get merged until that is both fully understood and sorted
out.

-- 
Jens Axboe
