Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B192270545
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781008914; cv=none; b=JqZ5h4O4UZyMw8Kvt7zHnuFbmeCi8lB9lk4QTh22BB0GSb80GMQPkyHAE3Sl+3icdN7BswMd4vNK/xgJkn5YDSFfYCnHLy12af4KlrHkrgy533eiiuO2HIhxt+au7kZ6gqb7ZLBXrJoLayvPHv/Vcuj5MIX82e6QbF/YbK1v3ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781008914; c=relaxed/simple;
	bh=0sRnAiQwyo5LWQA10od9GdAJyVCjnXzuURU9C000+Vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PjdJNjSaHH6JmT1087Qy5PudBprDUKZmOJagiSvpVgugkLPgHDD9bl4pJnRluwpCk6b4Se6h9heWrs24I78AfLd79RO2fbPZ3GlFjVI1lGHE4bb2FMjPaNxc5ZgYEy82NBfSVB4UdPfS0+HYaiyLUNCS/vLgrJkPKWr3s3onEcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=v9PB/87+; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="v9PB/87+"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e6d991991dso4640735a34.3
        for <linux-block@vger.kernel.org>; Tue, 09 Jun 2026 05:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781008911; x=1781613711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qemc36QcctB0mBOvoYkmDPjHz6qq64817hRg4sKK8w8=;
        b=v9PB/87+PgTMQHSLqlznNgTo58NbwriJNAAnbYxRdA+gYrs074uRS9H39Sw/Ed7dSk
         K2FdCfZKMQUk3QWmQ7i1Uof4Zc8PNOxwcbfQFE84a0SxHyCnzGEKO+P7UhV+fbl1zPUW
         RhjVKJ7sHvkwaYXjiERy3PdSzjmwZa0R3dX57g0CHozevqWesn5FqSjVaNIy3DCGxxxG
         qDlwkdhJvyFT1s94nQbnMfhirGPfo50g/Tjyoa+BAYxi9fHHfJrPcqnvNJ3tPovfRVb3
         vit+dUqsCkPYHuez63WytGA34oTXJk3fhzNGtFJkyswSIINXhTrX3hvAn6ic/vaRY1dR
         6How==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781008911; x=1781613711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qemc36QcctB0mBOvoYkmDPjHz6qq64817hRg4sKK8w8=;
        b=FWff6h2U8fqLq/+UWSHBiW749oq/2uynN0qYu5ZJiYcUZ7eX5Uw9jZfkPhwZs0FsaF
         dUhavzBzJCEgnkkXgVI9eVIBBssFod1VfODjHEM8iNeQnSX0qyb3zCdBRwVdGve7fdUr
         ktdABrDCxdUrV9YvjRgh1wIt3L4gMNqeko2+zLcE3U+1RXu9C+BqXFkeG1820Yb2mrVH
         jDJYW8y9BcCDEPvR99mW71HO9TorQwhIHtT44ZnWIRreh+iLohH3/PgQivCF+DMVqxpM
         FSAwpyd3HDPgSOd+PyXrCtPWZdSAi6GZ0XE2RYSx+0CV6lBXBedmhfiIp4WFa8ZS35n+
         IOeg==
X-Forwarded-Encrypted: i=1; AFNElJ+OW7lj9uAROD0fXYtTxFPIWCUuMsXnlL6PYYy1tuwk0A9PzlPiJobuTz0/dyGVhGWBktLIGYiVLax7zQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnESIrzXRF9Ec2Cqlp1Ll/2KwsrJPCnGo4ev6BhClzi4GkC+TQ
	RUa7mUwuRJF/WMLvUTyQX6M9A/BcNevQJBjZcFg3w03Y617U+s9xiiXVDwZDzzhYmNo=
X-Gm-Gg: Acq92OGmYXv/nJL3WmafQfKcig69pKsGv64zS/hVMICDMs2d3ZY0szCEe81EvgvEton
	0yvtRvXcrdY/10BVB8Xmth0JjrzA1iKpVHlt2JBZ24K+jebj06ViWpzp/8tEKSGkPJJYFKzI4mS
	u4hLinAyvQ+tYNy8s4kj89g9m/qLY3qvjkNroJJtYHzEMjJ7hRSbONxtRlnF+Tm2cy14TSNQxNw
	POncJjXQo7VBE6+5ajksSCROfAwHUeL+2MCY6tO7a6SknPxVPF7ZcKqYUlzF8EAqpVYhAHxUCrw
	gE2bXZlgsopB7sgWjBjOEQ2Ban/vciSDE2bSBHjzY0g4Oy3jj6K64qOVqgYEOSRTGMYBRYDAl3K
	9DkWnE9LKb/YeuQVSGbMcUO6ewLHnKZ1Ln3/2797BgPb8CyZOgZ1SQmWj0MFHHTIXtAOaUiwOhq
	KC/TEJ1kELG+zenm8wGuU70alsVC49aqeoUnx96cnNpktSKcxXfyuoxL4t/IfOBRgcGerM7CLGH
	Pt+TkyzGDIA+JKaXqBmGd5v8654APg=
X-Received: by 2002:a05:6830:3491:b0:7d7:f031:37bf with SMTP id 46e09a7af769-7e70c7ebe14mr11914902a34.19.1781008911428;
        Tue, 09 Jun 2026 05:41:51 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e71fe69esm14843081a34.0.2026.06.09.05.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 05:41:50 -0700 (PDT)
Message-ID: <8b2f0830-23cf-4f6f-89a4-1390cb0f2e88@kernel.dk>
Date: Tue, 9 Jun 2026 06:41:49 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Kernel Bug] INFO: rcu detected stall in disk_check_events
To: Longxing Li <coregee2000@gmail.com>, syzkaller@googlegroups.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAHPqNmzE6bcNb3T+nJavn-mg=w2B0F1YCv47qv-Tsbn4xOrGmw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHPqNmzE6bcNb3T+nJavn-mg=w2B0F1YCv47qv-Tsbn4xOrGmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/9/26 5:52 AM, Longxing Li wrote:
> Dear Linux kernel developers and maintainers,
> 
> We would like to report a new kernel bug found by our tool. INFO: rcu
> detected stall in disk_check_events. Details are as follows.
> 
> Kernel commit: v7.0.6
> Kernel config: see attachment
> report: see attachment
> 
> We are currently analyzing the root cause and  working on a
> reproducible PoC. We will provide further updates in this thread as
> soon as we have more information.

Please include pertinent information in the email rather than some
shared drive somewhere.

-- 
Jens Axboe

