Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD9A30103F
	for <linux-block@vger.kernel.org>; Fri, 26 Dec 2025 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766781923; cv=none; b=UKdu/JS+EyXZ3jba3/RWM1SqL5bAXpDFMssetE2cnTSgnt6A5kW+A35f5z8Fx6ZrpMLkqZ3NJrxBC6hApQqzFziuUdGPVR2rAyJPJqYwlGjo5h4vNJNb3I7zNU7w+7gqycCNJUnf7+9LgIb00GcYhQe1qJPxIiE2bkTbPWDOPzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766781923; c=relaxed/simple;
	bh=vj2ixsyycj6S5A1zLEL/RQ+pdJrAF0mx54PTAW+DzIM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OuJPlYSDY1D9Ub70ArCyZZ/MJ0mBLqEjmkiSOfv/0bjjOLHKs4eXGNRj4In1evQG6pb42FIGGV2ZZJSmXGM314Ny66S+ZPAQqZRkI/utJ3ZxetqyUpAYV4SqHt8wdCpuAwMFK3ic2EXP9ezmHHVjsF5wuspPKEfWD47eqUtp0Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8euMJKG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=To4PyOlS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8euMJKG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="To4PyOlS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766781920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TeXICaWTl/KfVZ8H31EGm2TJnHW3xapz5vNb0Sw/RM=;
	b=U8euMJKGQtFlOA15dlVWuSnGT5RdzrnTqSNqC9+jZTeyfo8Q19ruZL2jguLvglZ8IJDCcC
	iMS0glWu5ThsSOngS8zzDcMA37p+KFwWjaDQGcuSYK8k9SytA8gLhxJYdqduoEGwgemyLg
	PXfBRiSo9KhzxLpNeSn+x7EUYpSPp9c=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-SwcSRTCMOre1yQcEHuDLVA-1; Fri, 26 Dec 2025 15:45:18 -0500
X-MC-Unique: SwcSRTCMOre1yQcEHuDLVA-1
X-Mimecast-MFC-AGG-ID: SwcSRTCMOre1yQcEHuDLVA_1766781918
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b2e235d4d2so2762668285a.3
        for <linux-block@vger.kernel.org>; Fri, 26 Dec 2025 12:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766781918; x=1767386718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3TeXICaWTl/KfVZ8H31EGm2TJnHW3xapz5vNb0Sw/RM=;
        b=To4PyOlSk3bG39KS3qaPLY/QIUerQXqjT955zkSZ0fI3qaTGXDWAwcEIvObkGvfY+G
         08X576NUsSCY3BGo3/CqK9mWuR7zRObNrCICrBv4yjmYehhlkaNaGALEbP8HywHObp8b
         MvmffUqNXFl+fpinNxMIIj7HFE+N7pHGsY8EMF8GzglkRbYi3LN3+xVEBfInVz36XS45
         zHuhlRFriIzpuE8jMHU6JiOPMjRyTnYpggl1z/7DduM4WSCc4FB0KNlrdactCIhetwu5
         JgL/GcQC+vP5znktw+ewHQ81oyu2YBZ8SSJ4I9UAE1Rg2Rk+z+hLbH3OiJpXTDLghZKg
         qK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766781918; x=1767386718;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3TeXICaWTl/KfVZ8H31EGm2TJnHW3xapz5vNb0Sw/RM=;
        b=KmCspUh1+/v6wVi7av1qUjCA0N/zMj0MNqXPka763EMT8D8H+9rQfEb/zwVuC7PfJN
         nxDwYz/Vqecf41HA9kBuAho630UJBPPkRY+6FJWkKgokjLfBY2MQFvd0dWkz+hXWhx3y
         YyHHmfdIryha9wNhWQxKJ5rxrnJ9YGEHxBIIUuXC5Z+kvTX0RKImTUVDy/8YouFekafg
         HQHdEMOSqTq3sVe9DiFfwfEoqvPy/5kKSyrz+L2H5jNXwjJQUYScrJe09Gq4QjqlURNx
         nC8cSmIfLQLBr7ixbuVSxMo8yBuHL9hj5Hy3DFwoksW0IUJNVGh7Nrwh80vQ6pkX4biw
         9Cmg==
X-Forwarded-Encrypted: i=1; AJvYcCW3qgU7K5zOWKsD3zoqJ3diTrlRn1IS9DKmr6FuBHPacdvYE3iv9QkDosS4zJbDCafIm6H6+OnDZGnt6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyqK21kokDlgnAwfADDsahrmBcTL5MZsAf9rLwOkqt92EURYES
	kIHmEJAYs5iuehSN/oxry0MLSiDLPmCzLIlAcNKaU20DUWGNzzkCZ5clEL59dYVpaJuIqtcyu8d
	dwX4EdguXKH3svTiiDHQmXBoSQdGjIYGAEVEfkc36OCtIxu2NlKRWPeXDQB5v/Mj+
X-Gm-Gg: AY/fxX613w/O93w/m6XrBM9tamfTFbmJSfzhDkL2jC1cY0wGCN8CBORLikJ+plm0jCN
	Lap951tzvM8Q0OgY2pW4H9wf+ycAoCt4B/FD5kS89Tmjc+1EMyc70wbBqmj37rKtoSeJ729Hxem
	TaSmAjhscywx8waUKtmx6ofzjXjUwV4biNmO+d39F78Ge0cHWe7mIqsCiu1fenwi+v1KSMQVhRu
	RWan6Bp9r3ln6uNQ0YTl44TmogxDxoECEen+CAHsBnXkihzDqF1xBc1jOI6xcHszVQhKvCj1f42
	jKsgYs8416O2WDQU6KsQ4V5mkrWEDWHrkAEjUmbYUJbGAzXSFS6HaZWCs5G6MzXF8qyvCmAX4Lp
	5YJjqDioJFmeXm2cB0SpXieHe+H/kgOgDWO7jYYerhiE7O80x9fYy9PfL
X-Received: by 2002:a05:620a:29c5:b0:8b2:dec7:d756 with SMTP id af79cd13be357-8c08fab88a2mr3620501085a.66.1766781918238;
        Fri, 26 Dec 2025 12:45:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXv60plEpPy2fU+PATnpKAA1Y80YGBXC1cy+B1fIWSmCaoTRFPW7/kxK6mjum3QMoJNZ6o1Q==
X-Received: by 2002:a05:620a:29c5:b0:8b2:dec7:d756 with SMTP id af79cd13be357-8c08fab88a2mr3620496685a.66.1766781917751;
        Fri, 26 Dec 2025 12:45:17 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c09689153asm1727228085a.17.2025.12.26.12.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 12:45:17 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8282d85f-37b6-4f39-a70a-de5e6c77fb0b@redhat.com>
Date: Fri, 26 Dec 2025 15:45:12 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/33] timers/migration: Remove superfluous cpuset
 isolation test
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chen Ridong <chenridong@huawei.com>, Danilo Krummrich <dakr@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-21-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-21-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
> Cpuset isolated partitions are now included in HK_TYPE_DOMAIN. Testing
> if a CPU is part of an isolated partition alone is now useless.
>
> Remove the superflous test.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   kernel/time/timer_migration.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> index 3879575a4975..6da9cd562b20 100644
> --- a/kernel/time/timer_migration.c
> +++ b/kernel/time/timer_migration.c
> @@ -466,9 +466,8 @@ static inline bool tmigr_is_isolated(int cpu)
>   {
>   	if (!static_branch_unlikely(&tmigr_exclude_isolated))
>   		return false;
> -	return (!housekeeping_cpu(cpu, HK_TYPE_DOMAIN) ||
> -		cpuset_cpu_is_isolated(cpu)) &&
> -	       housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE);
> +	return (!housekeeping_cpu(cpu, HK_TYPE_DOMAIN) &&
> +		housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE));
>   }
>   
>   /*
Reviewed-by: Waiman Long <longman@redhat.com>

