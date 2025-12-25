Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868D829BDBD
	for <linux-block@vger.kernel.org>; Thu, 25 Dec 2025 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766701685; cv=none; b=rh8phfm5adTzVLIbGTCd1XTGYsuRvJ3KVOZzpq2QCqbeBEV96689jdTbMqPLDkJPYRjo09PeOrMBfuSmuPRPOK07xshkKWX9AX2VcpbFx7kfC/cqrWQZ6dxo7LMWADE9x3Ch+4RF5I//X/8x6ExndPSoQc6ID9nIxeUb9rVLTUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766701685; c=relaxed/simple;
	bh=ly8xlAcwEq5AylEYJRI18D+dCgZKx0t1PbpMqP7W2Io=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MqJw8MYV+FHUsp+dMXc2aLRW2VxgZn4M5+kK5Joh5bhmr9Dd12zDihQayImGXIuULS8fhjvcG/1dbXqmHYwX7hsDD4cRf5CuICx5++CQys+pt34nn+G37oVKgAOIVFNtCFkcfNQ9aRShyX6A4lPZIHoYNvNkzJ5L16NN59uWFUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NTzyyZTK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q7aHiHAh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTzyyZTK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q7aHiHAh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766701682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PeNHvsN1ZBvb8Hdsv//kNjFTWoycJwfijVViJF41qv8=;
	b=NTzyyZTKAi+1p0EJ9DGkep+IfGVWOPiYNgfLeIF8l9mtC7emjX2vS66Id0WH9bm7MDt67Z
	vkb3oMtcB4qu4346L097XKLPpdbX2G7G+q6UPHdqnI4dKPm34V9eJ+eHxVyUZek2S/PuBN
	pRIt3j3Q+hZ5QFOZTXcEtStnDf1HQfw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-_rtjeaA6PdCRLcr4vY-stQ-1; Thu, 25 Dec 2025 17:28:00 -0500
X-MC-Unique: _rtjeaA6PdCRLcr4vY-stQ-1
X-Mimecast-MFC-AGG-ID: _rtjeaA6PdCRLcr4vY-stQ_1766701680
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b2f0be2cf0so2405002785a.0
        for <linux-block@vger.kernel.org>; Thu, 25 Dec 2025 14:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766701680; x=1767306480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PeNHvsN1ZBvb8Hdsv//kNjFTWoycJwfijVViJF41qv8=;
        b=q7aHiHAhKiDFctYhmJS8WvOtJaLGJJEUm41lj1/1YVBLxmzbbIDbpp1MWcUFgJGuEw
         2/EMTXdVNHQYo0PqfBqjIPv9eBwmHTUegV+Y98OtcB8cdlCbGOSQzFdIQ3HZ2/aCWKGB
         iCTtxpM2oQThBS5VplpTT0UkLMGVYf0pSZpZkPkCVHg9CEcEUjt+AZ01K8hMCwY09ZIY
         bhe3xukhHvsQ/06yaEwMhpILaP4JSKuwPo5iu7iRW+kUzuUQxkJlwVo0cfQT/loVNRe9
         IcbgVKJN9brswEY9XFv4jEV95MdxoPFneV5GYiiRKRPDJioBQCBE++lCpNVRhQGmXz3X
         RAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766701680; x=1767306480;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PeNHvsN1ZBvb8Hdsv//kNjFTWoycJwfijVViJF41qv8=;
        b=lhh61Tdo7FmYbVeR1gPry/r3CNjFbez4rf3c3z8T0R9QyeyiJ5XVTNcvFOmqibY1y1
         3er0RxIeIi07pDh875nkpRjmE4aAyFQqVA9f0B9qMYwHu2KdfsIkc/0cUECWxN+GETyw
         jl3gNfJEES5cUkFCv1DQBKOWIra8O5kiJq0ZJHTpm0/yMtGSAL143+7htK9opvKvq8RV
         TlfsmZ5lWQ94nKTJnxikIA10d/US+9VJx6/nZOFY56NFcuRgmTyq8h9i/sqN6Gn7femm
         zycXxNnh1DHtvg0c4xuGzERUAXNI1Ih4/E/cYGF6fJe9DL/6B1jdxErQeCqoBJ4KUXEo
         eYzg==
X-Forwarded-Encrypted: i=1; AJvYcCVVFwHgWNdral0HaPoYE1wi8KDJoNwksGFU/NEXzslz+NuyCUwiyqEvQj3cwNaeh3fh8EmVWCNzN87Hbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIcwqg9js78QPkvS2rSjUhB0n7ta82QuONuPepNxaUS6DWnPHW
	YHRCBL5ng0Cmae51dFNdfQFpIOILp58s/+LwhzCbw/71eoiRvoqKEL0S95v9LCBLoytB6STNXte
	URBIJRd5zZV2zsUV3rEHs91WHF7gsVI5DQ/j04+hOjXEgqXollOuphYEtCO3kOWv3
X-Gm-Gg: AY/fxX6LQA6p3F0KFxwsRIDfHaMRyicFq+JcicoYtOg0ys3Zr2XIUEK3JzP0sVfFHCI
	/bF2OXu42lwVrbZfkTz9lXh/tDu6igjcnX58tu2yLvMBm8vznfzqzy85QJTQAUw6l4OnO8lADBT
	OWsMRJ/OYprI3i0i6Sb9jFeOr9eSULyKEcBe5ERiNcdd+EISpVHAEhGV4mEyCRpwQDz3W3s6Ldw
	Z6v77+0xpzYEdhmM6kFm8THxQjU/rpv6i6okvDYT/qYhvg16MdKhnE/kFV+5BncepUA1QDvFHKQ
	twA/Dz4h0/acLSe0UerSpm1/BDsd6I4RDNy8D86aIfm3THmUut7TvP8JhXv/1aULcUhLG3kvfV2
	U2w89DHmjg6RiYPR3yRzoHwwPgGkI1krO8DnzrkP1ZFynlrNH9blUrLbX
X-Received: by 2002:a05:620a:414c:b0:8bb:26db:e22f with SMTP id af79cd13be357-8c08fbb5432mr3197587785a.30.1766701679937;
        Thu, 25 Dec 2025 14:27:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkk34PfoZDZVXHOsdvaSoOtEJlSomrI6NhnO1ciZ/uaqISBnHAQBKZ+i37TxyEDRNXrTUZhA==
X-Received: by 2002:a05:620a:414c:b0:8bb:26db:e22f with SMTP id af79cd13be357-8c08fbb5432mr3197585085a.30.1766701679541;
        Thu, 25 Dec 2025 14:27:59 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0970f5fdasm1605628285a.35.2025.12.25.14.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 14:27:58 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <04708b57-7ffe-4a97-925f-926d577061a6@redhat.com>
Date: Thu, 25 Dec 2025 17:27:54 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/33] sched/isolation: Save boot defined domain flags
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
 <20251224134520.33231-6-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-6-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:44 AM, Frederic Weisbecker wrote:
> HK_TYPE_DOMAIN will soon integrate not only boot defined isolcpus= CPUs
> but also cpuset isolated partitions.
>
> Housekeeping still needs a way to record what was initially passed
> to isolcpus= in order to keep these CPUs isolated after a cpuset
> isolated partition is modified or destroyed while containing some of
> them.
>
> Create a new HK_TYPE_DOMAIN_BOOT to keep track of those.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Phil Auld <pauld@redhat.com>
> ---
>   include/linux/sched/isolation.h | 4 ++++
>   kernel/sched/isolation.c        | 5 +++--
>   2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index d8501f4709b5..109a2149e21a 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -7,8 +7,12 @@
>   #include <linux/tick.h>
>   
>   enum hk_type {
> +	/* Revert of boot-time isolcpus= argument */
> +	HK_TYPE_DOMAIN_BOOT,
>   	HK_TYPE_DOMAIN,
> +	/* Revert of boot-time isolcpus=managed_irq argument */
>   	HK_TYPE_MANAGED_IRQ,
> +	/* Revert of boot-time nohz_full= or isolcpus=nohz arguments */
>   	HK_TYPE_KERNEL_NOISE,
>   	HK_TYPE_MAX,
>   

"Revert" is a verb. The term "Revert of" sound strange to me. I think 
using "Inverse of" will sound better.

Cheers,
Longman

