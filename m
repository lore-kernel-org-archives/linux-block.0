Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D051C07C3
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753980950; cv=none; b=LULfe4hCIUm8q8w7VusrMkbzhg2j7ezc+wA/AcaYDUseYcreO26PLWO0qkQoWwm2GKqa+K2BTX1feP8mNinrhR8s+OAQxXxglcquTmzLizDjWK0TR1MVSvBev9ylvx+K0wtpzvu8UTZ4SjlRfbbMn/o+7EkzAOzger9rGSfD3RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753980950; c=relaxed/simple;
	bh=1rcVnOmKcFqXybJP64OLJfeGRmgbxintHb+KtJLth4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dv6fqLNA8S1C4M33tQQ4HJ+OlXU+iR1tj7QPdDdrwznJJ8Ydy+wcFQagaZ93W0XU2rz/gf+WfulZXZCDO1KIz4Eq4aGozgBW5/NKpIpIZYrSh+aGQTskyB7jzanh8FpbJ/hLioR0Tj9QjngvLYWz51QWOChyHk6s1lCNoeuLJrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=f8wt0SwS; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="f8wt0SwS"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-74121e0fb77so230052a34.2
        for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 09:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753980946; x=1754585746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FSDxbK07W8AVyHd9cJSd+DPYfd611H9p/rcU8K0ZniQ=;
        b=f8wt0SwSuQNMXpE4jaONEsVg3BHVzK+wybKCF6AIDXZ4BxTyFiAlLMzgGYKtbkt7hO
         LGqI+hUgKxChn74h9LwAE2G4Ltoarxw35GNeuC7APJ4sXrj4/m+iXmrmCqZhkkour/sV
         Znc2nQOb9msp8/5w16wV3oTe9EGTJE7VdkMHNNeiFBDRjdzPtxUThAXvbQbYQS4bB7xA
         1CQioIqIXd+JLJIF2gEQ1AkBS3QhgprKoB8ORVmjp5FFSInKuopBvG8YltifaRLy/W81
         WKKjkKhV11T8Sns1HooOsnKsSms5FDuW6ep1A62xkfbMdXTjN1gY8AKzeGWjLnOz3eTN
         RUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753980946; x=1754585746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSDxbK07W8AVyHd9cJSd+DPYfd611H9p/rcU8K0ZniQ=;
        b=lNR+0o66O4wLFeH5YtgJpMwWS4hasqSQ+3aksmHp9LB05I4Rsjd8+cn4lJTmB9F8Bb
         sf2+xVQN73zTIbI3tJBuCgNtQcs/+Qfk0gtg/Q5QD+xEQ2cXcYXqQIgZ40vE1QpbOSd4
         RRj+OVjUEGcQ8rzo4+w6z7URIgG08XE/D33ZU5SUtRCwEJcBWCgPB8mlTOWljXHMkDQA
         JGxdbbuIDiaFaVZgzOqXx4qk7AQ58KY2UVfKiZs66dxJAJJV84IZ9YPv3T7vOkv7G/rO
         wCtZ9gZU0NwvqmFmxuJ2AgnCeb15aVwHI6hT7099ietlJzFy5vFEJcL8jr8uTXNegzfd
         3TzQ==
X-Gm-Message-State: AOJu0Yz6/e6GXg+rgowrd7rj7J0xq6JTHWImF5Usz+SptLtV5+ZQvUR9
	fTTKSWtS4lUfD3h3s5Ew5klsnO7GoOyD/xguFIyH1G/a3P+OK8GdMDEagADpD1X5bu4=
X-Gm-Gg: ASbGncuLg+P+Xhj8TKQf3ORgcOUbhLXp95r+UqbzRxXRUKR0DnAfU7vkn9lmRdKQW6c
	11BinleglEGzQL+KpIoUq5QdMgI/NtFL5JjSMCzzTgjbM5koBsCzaKaiHMDM9sLh6AOhnnJVLN6
	T6skKGFjr2ESD256Dzn5PqhTgF08hTaUHPD5/YZ2+Pw37yJlR8C+zyYGqZsmpRTYGXAJ2znjQ8z
	yaymJO1k4J/a+A2xREpb9qohMeeVxghLyo+6yG/28kCRu8BZbqEQ/qGUudSp+ssuNX2BPHcovU6
	TuEwDVC3lYRKNnEIAAd2DudmRek8/jaNiyKR+5hMpuB//x8aoocem9UpOL4QY0a/Y0zwa3nK+jV
	NLk+IA4DDhUY1/3eC5A==
X-Google-Smtp-Source: AGHT+IGcqLPvX2byoEbvS8JWIBfH9x2heV5qHLZk2PAWhIXT8vEiajkPM4wjhrW3C/Kl2vqmdXYTOQ==
X-Received: by 2002:a05:6808:1a11:b0:40c:fc48:33b5 with SMTP id 5614622812f47-43199c847d7mr4264174b6e.12.1753980946077;
        Thu, 31 Jul 2025 09:55:46 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55db1402sm615015173.93.2025.07.31.09.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 09:55:45 -0700 (PDT)
Message-ID: <fdd15ad1-a1e6-4e22-9cef-0dfce1f8b24d@kernel.dk>
Date: Thu, 31 Jul 2025 10:55:44 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 6.17
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <aIt40gBo9MuyC9Y2@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aIt40gBo9MuyC9Y2@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/25 8:08 AM, Christoph Hellwig wrote:
> The following changes since commit 5421681bc3ef13476bd9443379cd69381e8760fa:
> 
>   blk-ioc: don't hold queue_lock for ioc_lookup_icq() (2025-07-29 06:26:34 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.17-2025-07-31
> 
> for you to fetch changes up to 367c240b0a99c7ada700a44345dd3144a02b6164:
> 
>   nvme: fix various comment typos (2025-07-31 06:35:58 -0700)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.17
> 
>  - add support for getting the FDP featuee in fabrics passthru path
>    (Nitesh Shetty)
>  - add capability to connect to an administrative controller
>    (Kamaljit Singh)
>  - fix a leak on sgl setup error (Keith Busch)
>  - initialize discovery subsys after debugfs is initialized
>    (Mohamed Khalfella)
>  - fix various comment typos (Bjorn Helgaas)
>  - remove unneeded semicolons (Jiapeng Chong)

Pulled, thanks.

-- 
Jens Axboe

