Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2551FB1
	for <linux-block@vger.kernel.org>; Fri, 26 Dec 2025 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766784426; cv=none; b=QIW8xaKRk7UxVYI8o9q2WlYOYiGV39+wvSbgHssl7xYbPw9OYRHUhS222pGnFL1Hp2e3e3WvRqDs0J/fKtXE6qxoMKCW0RS53xvo9vtpo32TRYzrUxRmoq4JSwBVbVVwJSrG9Sc2oDN5PTvsdjdCy4IhK5LCcbcNDU+qVVvhrP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766784426; c=relaxed/simple;
	bh=EVYVJsyRRz0shMqFnKsULoSUbGZk5zLkzZoCXi8IKXU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qOAmh/VoSlMHBU9TIy/L4oQvTvObvxr2f7JjIR5pU4zEkSBg/Ff7CqOJ0AwhvJoAQdnfkr/8Q6jjpMcxep/fYH0LUP9oN1tobnAzzDjHyMJBad2tq4nEoLwGQ3+lZGuFTXd020RBpItaV/B+sJ9qAnkeP9MisjVzFslp/9PfRuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dK9qEbZ1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FaeVBzda; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dK9qEbZ1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaeVBzda"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766784422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hl0E323tW0AxgEnWj1OLKxpboSYa7xNjNvCKjrDAdIc=;
	b=dK9qEbZ1EOkXSDnsFlpLv/nhmy10vJX+UZmjZO8Ndo83KfSQj8qEUINl2F8hMX5V/5EWeE
	VtdBHHLBS/04hkXtRvML6XpjPyl3aWg8GEDFGB0nneS3pPEt+sqrqW9o2kTp6jflYP1orR
	dRXnzWbhzhgp79Nrgim124m6Rt/7cQo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-Uv_iLwBAO1K_PX0_LmTefw-1; Fri, 26 Dec 2025 16:27:01 -0500
X-MC-Unique: Uv_iLwBAO1K_PX0_LmTefw-1
X-Mimecast-MFC-AGG-ID: Uv_iLwBAO1K_PX0_LmTefw_1766784421
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8888a6cb328so191932646d6.0
        for <linux-block@vger.kernel.org>; Fri, 26 Dec 2025 13:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766784421; x=1767389221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hl0E323tW0AxgEnWj1OLKxpboSYa7xNjNvCKjrDAdIc=;
        b=FaeVBzdam3yTjkRXFFvifhDtPNljjImA33hHnQmiEDX1zd8E0DJNrY8JMgRFaE8MXf
         HiOnCjJW0umymCr2Si/STRTaGPcDsBaAVPnZsWNp2FRrmK+skMY2tNL8C9ObYFVhqpCV
         mcm3WGJ5V8R45Un6bk/3NovUPjswl3E7x4bo7sdSGM/JzEWbIlrWliNSYztCmrtNhRCv
         GL04Bk3HDy2VRc7rZ+vRU4yxftmGgZJ4+e3uVhrTwcOu8NcEQlt1V6WVLsqsczoHB1jx
         lcgFIa/hoUUvBZYU+QkRHDD6e7NgURgMQ2k+UHoWrfKSZ5GtBdxySacFtk2uqNxp09iQ
         tn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766784421; x=1767389221;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hl0E323tW0AxgEnWj1OLKxpboSYa7xNjNvCKjrDAdIc=;
        b=CHmzW65lN9Nz6bivf9nPtU9WjVUsf3fNSBwn31yOhYD/asNqgZ8MlqRz0yRdE56QId
         53AaghbPpJUJ2ZaP0Q2k6r7lxWXEcjsbCbiMAHBjYDeemn0yGXkHtGM12hJPYLEmZaPF
         xCNoChppidSSvL4eX9hLTMK+rYFIitvXkglJ4+ZEh9ML7eXdRvO5KsGi8sEpPshNCb6w
         gZwKxD6p0BdHk5Qhwc1Th4MLjfA539qAhLlrcdBmHpm93yvmZsmw5L54pGpyNMs1s1nI
         tuQuQY4UV5jozXbw4rVZITaI+2SzYQWOkeebsvlh2phKp+RNsXAUGOA1mb2D/idCxLEH
         l62g==
X-Forwarded-Encrypted: i=1; AJvYcCVRXL4i55wnEF2wACYCxVKqsQreRUXmTor5NII71LbERX966+Be2L5frJI5nhNjMHaM69x035V1cOKQ2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwbFu9AxNGViGf1hzeiuTB7r5jSZcR6RpY2N6A24j2XVabHjn9
	7XjPspQrz63B+DDVCrmwVKzmq4u9DW+p7DWBIAaeFzezw7pi2sRarUjmaLghV/IM2WUnDTOS0FL
	qi/Knfm2S9VXFlx4ztozMwFk1sAH6qh8j2vzS1bzFnNLGfgKCyStL2SozD7yGg4MF
X-Gm-Gg: AY/fxX7pB5mNZi0lF76hex4eN5du1d5Zz8UMkfiyewSOV9IHG0xyMKgPISJe6fHKox7
	zpKupwA0u0WdHW0l0JfIRRydabH3ueSQCqMpbnIrpAxBjd0Ef1BkHPw6ad7HCkYqyNrxZ+ChUgg
	NKTjjvSCghZAxzyxzrdOnYmwagzU6hhtYS2klptnPyQSk908GhcRCeyBNLIYn4iLN3DAsuFmZZv
	SmABOlC5uWlfafIJd2/9hM7RvDWZKO43dRJceenPLm4TXBm7B0ctGbhMYj4q+uVE+aNmcoQNi2n
	haj1lPtod8niD8oAMA8QuRffEMpzzEHzwGLA19W+ebQQSnSvrsxw3rPQNqBUBJDJxXu5m+Yfj/j
	km3JkEy+ccWCJ5Ow5qaJbA4HQ94iFauT8tO82q4fnoKjAc3+1h4W3b/bR
X-Received: by 2002:a0c:fb45:0:b0:88a:529a:a530 with SMTP id 6a1803df08f44-88d82041773mr328947826d6.23.1766784420881;
        Fri, 26 Dec 2025 13:27:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfZAYYIQ2fUbZyPMB45iQArY9ihsQ/fJKmBvKtaCb5+ZXeC6tWw3vCNx5szpnr8D6LkXzAiQ==
X-Received: by 2002:a0c:fb45:0:b0:88a:529a:a530 with SMTP id 6a1803df08f44-88d82041773mr328947536d6.23.1766784420468;
        Fri, 26 Dec 2025 13:27:00 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9aa3ac8fsm175993226d6.56.2025.12.26.13.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 13:26:59 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <bc573163-c5a8-4bb9-a280-45ca48431999@redhat.com>
Date: Fri, 26 Dec 2025 16:26:55 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/33] sched/isolation: Remove HK_TYPE_TICK test from
 cpu_is_isolated()
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
 <20251224134520.33231-23-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-23-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
> It doesn't make sense to use nohz_full without also isolating the
> related CPUs from the domain topology, either through the use of
> isolcpus= or cpuset isolated partitions.
>
> And now HK_TYPE_DOMAIN includes all kinds of domain isolated CPUs.
>
> This means that HK_TYPE_KERNEL_NOISE (of which HK_TYPE_TICK is only an
> alias) should always be a subset of HK_TYPE_DOMAIN.
>
> Therefore if a CPU is not HK_TYPE_DOMAIN, it shouldn't be
> HK_TYPE_KERNEL_NOISE either. Testing the former is then enough.
>
> Simplify cpu_is_isolated() accordingly.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   include/linux/sched/isolation.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index 19905adbb705..cbb1d30f699a 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -82,8 +82,7 @@ static inline bool housekeeping_cpu(int cpu, enum hk_type type)
>   
>   static inline bool cpu_is_isolated(int cpu)
>   {
> -	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
> -	       !housekeeping_test_cpu(cpu, HK_TYPE_TICK);
> +	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN);
>   }
>   
>   #endif /* _LINUX_SCHED_ISOLATION_H */
Acked-by: Waiman Long <longman@redhat.com>

