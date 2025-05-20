Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBA92B9A9
	for <linux-block@vger.kernel.org>; Tue, 20 May 2025 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757701; cv=none; b=LoNFov3BDHmld7KIydE+puA7it6u9kAfzFFiYVSaZNaP4di28uaugmlBwD/uH5ma70Y029xMCF+tsKsEKv0u9zg6UPUAM9eaAPrTxSCUwFbyzEOvRyBEKmD9Z5f8g0HLZljC1UtILSmKJNofsvDd+Beic51FAakOyprKNDwRoNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757701; c=relaxed/simple;
	bh=/eUy4pgfX7Ui4xWgZQE2CswyClCMy2DPqmMaQtzNqKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=McoFT319Tj6Vqz/cPiZ5hhWSZqXH1zN9r8igF/uZrVhWJCK4XinttPMtjIDJpOkYbn99UW9c2inERJEuPx3vhGzgG35O0XEyQXXMCNevR8/KqKjawlfN2Lz1BNTi8ROvEs6ZnGhX7qbiNDZByJ65Jd9sVx54/84AYJg8zehzf2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gBIA8/Sw; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gBIA8/Sw"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70900a80907so52632617b3.0
        for <linux-block@vger.kernel.org>; Tue, 20 May 2025 09:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747757698; x=1748362498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jNI+eyCxVvzZ3yWBOQLs4twgf1ouYdI/dHpJKVcoJ5I=;
        b=gBIA8/SwEAx3J+6ejt8LWmD9FCtvzSLODD9po3xln8g0hCmvdhyjWd3lTekARhceK7
         /jIvLh+WJH35ec0uNm+Ys9w5dXip/16XmLQDnQIwVQFg1NLvkiADhV1mtTLfqKvyY+N2
         QjLWb29k/kqitURwmL7wF4h61zriG/ThqBfWdyb1GSuIhalWpY2laB2/cH7fSIiBiAxq
         wo7LolUMbCKzCOxiCxA0Zh8LzIxeBTrdWcEeZEgg8lpHtnY+30joQvmUxFORt3wqxQV6
         yxxwHojRKdfICHvMOMyZrrkif9aTPZPzxHzarrdS1gT+CbXl0jvLSHjSbOb6mb8l5qJj
         c+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747757698; x=1748362498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jNI+eyCxVvzZ3yWBOQLs4twgf1ouYdI/dHpJKVcoJ5I=;
        b=QcAYuzNubbj3QxBfgomleskQ6WUqr3UHZLojutZtf0bGWQRz1MhYG8JJKelmsX8k0K
         1kMdMzifo+nxMST9HsI+klsaYc/qAlYBdzpI8CJ5BZavgsiFe2cLdaczcV795tMVWuts
         pYSbG8uskYvH6oyd7hU/sAUT9Zt2KQ6vivYfOixaT+vSf031qiWJvk53XMS42dhwgkiw
         1Jk5lgeR593MNIp/cQ3SlgGHHzVtKV/FoWAypJhdlTApJkes98kFBQX5fKNXt0tgUNGk
         mWx80E4p7V8ACxle9MwT7f55g7N1ahIL1jgwD7ijvNFTdSlKCdjBtPcg30VwscAgfXo1
         6ccQ==
X-Gm-Message-State: AOJu0Yyv3f43FwqO0Whqd8HBohIGxbwxCWZFiO994BvhvvoZIGtqNpcb
	o21Y1MXgiwLleIJbZaqSzv3/JD2BBGvuMZbWiKAfsJ3gXY07Lw3thYwbNh9EriaYZsWPpQAv4vb
	XUlm6
X-Gm-Gg: ASbGncv6vlOaGV428nvzPYfWUY1YptIw6p4xYLSsPPbrJVGPt2KvdSfvLh335C1VMtc
	sU6HHc7A2brgqtu9Wu0Ls0ngljLEB9OV8ggw4O3pymEHAVI+vZkBep0llVUHKfcTEQEShCKMG5P
	i6YyWJMmT3+QdCMcxYNDYMODDL2Sr7OLxf0JYd5o8NLRGr8S3vK1naQOp/zG3Pe5in129P7IAbp
	tv0rV9sVOpj3b3gpzkkqPqhfoncjQ0yYOuKKh894VoZzQ1QtAlkHboJvzaiyvE8eJ4E1/DOGFPi
	HmYz/xrI25HwidxEthwNHbrevBwNd3pTiZsBFw7c1IFzS2k=
X-Google-Smtp-Source: AGHT+IFcy7gIAABkUAz4oVAxJQVMe5uB7za8pcx2PX4nx5y+S4aJfjyYDqiBJCea66mlfm6pVDqgwA==
X-Received: by 2002:a05:6e02:184c:b0:3db:754c:63b with SMTP id e9e14a558f8ab-3db842de1b9mr202158035ab.12.1747757686851;
        Tue, 20 May 2025 09:14:46 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc7f126188sm2141495ab.65.2025.05.20.09.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 09:14:46 -0700 (PDT)
Message-ID: <94f91748-8538-42b4-87c8-7067b5369045@kernel.dk>
Date: Tue, 20 May 2025 10:14:45 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 6.16
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-mm@kvack.org
References: <aCyniHQRl2HMjsvu@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aCyniHQRl2HMjsvu@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/20/25 10:02 AM, Christoph Hellwig wrote:
> NOTE: this includes changes to mm/dmapool.c.  We've not managed to
> get any replies from mm folks for it despite repeated pings.
> 
> 
> The following changes since commit 496a3bc5e46c6485a50730ffbcbc92fc53120425:
> 
>   blk-mq: add a copyright notice to blk-mq-dma.c (2025-05-16 08:43:41 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.16-2025-05-20
> 
> for you to fetch changes up to 9e221d8cf90b8599a6a3d62a1ebb712468f42a35:
> 
>   nvme: rename nvme_mpath_shutdown_disk to nvme_mpath_remove_disk (2025-05-20 05:34:52 +0200)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.16
> 
>  - add per-node DMA pools and use them for PRP/SGL allocations
>    (Caleb Sander Mateos, Keith Busch)
>  - nvme-fcloop refcounting fixes (Daniel Wagner)
>  - support delayed removal of the multipath node and optionally support
>    the multipath node for private namespaces (Nilay Shroff)
>  - support shared CQs in the PCI endpoint target code (Wilfred Mallawa)
>  - support admin-queue only authentication (Hannes Reinecke)
>  - use the crc32c library instead of the crypto API (Eric Biggers)
>  - misc cleanups (Christoph Hellwig, Marcelo Moreira, Hannes Reinecke,
>    Leon Romanovsky, Gustavo A. R. Silva)

Pulled, thanks.

-- 
Jens Axboe

