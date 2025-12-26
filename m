Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F174A28641F
	for <linux-block@vger.kernel.org>; Fri, 26 Dec 2025 23:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766790537; cv=none; b=fmwBk1sDedo8guBXEpIuM8sgBdWyAWAanLNfH8jGBWWx5n0WTJOFIwMYoUp7pN1LGUUJ5GURVeTgcIrEq+gHpPNIMjtR0rE7yhLhCTnwetn1l1EaTQ1E5ZIIsxTCnsN6SIc6fXbFTswgsrN+bCmTm6Kx0bZNzp3EB9nn+mebdGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766790537; c=relaxed/simple;
	bh=oghaDqCtoGuDQNAmtHfUkftbTAQMnzWTPNUYgFydFis=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YkH4pAP3beCU2yTDW1xE4C101HXzg1ZVRNFTQ9XgKhJlxOTEdz4tTjthQDbAMwJ+6TiGpgm2wP0EzaY3+BWHyzSXVpC7XsK1wSfQwsBwfFjJMtDT1sI+2NzM5BSwxy4SEU7beEYwukWmSl6KXgu1dLkGBHv0AwoSfSDf1F+9qVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MPPqP8Lw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dGMgwsnv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPPqP8Lw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGMgwsnv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766790534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPVYyOhmWYyUzd26KqEqEx9SiJ2wqcstK13CbukMaus=;
	b=MPPqP8LwYF8oNEYjd634HOi2+LUO3X2KSXzb+ZAjUXyTRx27Ny/60BNWxfke6n0keCi5hJ
	KMqiS4FQTJ6E7S/8Ujz3FlZY5i2Me4p3BXIYd5ufP4tr6QpNQzKYR+LCoOJMlh8dXGbZW1
	/XWtLnO2JGhjj3x1QgMDKA8HGc1HHrU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-sKySFgdmOIaG0McxTns4DA-1; Fri, 26 Dec 2025 18:08:52 -0500
X-MC-Unique: sKySFgdmOIaG0McxTns4DA-1
X-Mimecast-MFC-AGG-ID: sKySFgdmOIaG0McxTns4DA_1766790532
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-888825e6423so172576076d6.3
        for <linux-block@vger.kernel.org>; Fri, 26 Dec 2025 15:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766790532; x=1767395332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hPVYyOhmWYyUzd26KqEqEx9SiJ2wqcstK13CbukMaus=;
        b=dGMgwsnv0ChuiXtLIILgLtrBDzrl/8rCZlKeDtFn6vlyqKI3A3ulUNtS4MJEaWzGJg
         g253MNP+/r7OZjMZIm0KBgWZH1cfclKY+IUasqv9Uuk7rFAIL36uc/l4Y5ehbzQGX1B5
         H2iE79XQnxOH+ji2ExBkeq8tYKRabhSoKIpg9HnWYySn3GCv1GxDtBhGdY1Lbh++GizH
         o0gWSAqGxns5+2l/VtkIm01L4g5jaNxedVoqr1jEby4WlEQDO/A7WTBL7v9Gy5oF4XvO
         rUfmrTyQxddn2AI0+5Zzs7k42xgj7UoqHOXPIkx2TvSAX91bX3dx7cChlqz53Fz++WLN
         n/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766790532; x=1767395332;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hPVYyOhmWYyUzd26KqEqEx9SiJ2wqcstK13CbukMaus=;
        b=LdQtymYFKIr2lcN/i0rm8jcd1/ekjBZ5062m65/U7WhavOQ8PacdduRmi4M8cfvW1Q
         eaoyUG1M+ufKnRT5W6RW3DGh1rx6suXcGCWee4V9FFttBFdTRGbXTA8uKUjmXCNUjERC
         99XM7zwtWdiGHeaiGpbOxX3ZDtFCYcFcNThEGWDqlIWIab9B0TgB8RjJqEi4sK/hZcS9
         MNOMcc44f02jL+V4dT00AEmTeBmjXWZbRg8NG+ThqkFaTA5yk13arqTkhHa3Suf4e8gb
         spvCkuY0krotRURllhtIX3jyP24kfDjuy2llu4C6w4damZ9waanRti9cCl+wnYP1u/ob
         Ohgg==
X-Forwarded-Encrypted: i=1; AJvYcCWTK8c4x4rkTwM6tyq/XUGr8GZiHyN784gZqJ5eCW8RjmtVNBXfPHyCrs68EE54bZTlnPpiWltzj+Ij6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHt73qIN/m+9zxFM2lBhz1Wbh2+kCbmgY8ngI7OoqWEwugKjBr
	a2N1BdVkOqmx7k13tIiHhGYVu5JMFtQ5NSToRzigUG/Juu4iJ8WtPgHaowsUp6+lSc2rQqF4cvU
	3Uxb9DuVQCWyUVFeTSXWhCIdrovjltx+TVTa9ZFqVMdsaqWaVhT87+rM1e81Thgyo
X-Gm-Gg: AY/fxX4IctXO1x+OigcsyxffkPC9vXB696eiRf9AVVXs1IJWTijQPkMLKh9wuQqc18W
	iYnpk1qZ9pdfBvf7+cKdqk/tv0lvI5yFBbmNdbWUvNXa1ob6ViUOZ0d1Gwr0v2O2XkenF6kCQ/8
	x4wmgDq/MkDui8JWD1pot69UdjgyE2WHdB2z4MWjU6s9QxKaGsjjrAm8q7dVR2XL3KzSs/1IxPz
	1h1P3VhamfP7c5n14DpXWiVZPfINNh1+2d1N1asrSgv4jAfD+NRScv/IgGq+PhO133gUc0PXVpw
	9UXmWVLwTfbYJIjE6PnHKm8RD5ZpTeXSRF4/CBCW8qroVJYcoyrFfxPZbbFFHy69NZ182wSnzTc
	rEel2gEe2c/SJQrWfaxU/UqZkDcBYm42KxiaacUar0Iug0CAmpKXNFVxF
X-Received: by 2002:a05:6214:48b:b0:890:e31:9685 with SMTP id 6a1803df08f44-8900e319a28mr37823626d6.69.1766790532040;
        Fri, 26 Dec 2025 15:08:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpv55vF+vDJeT6imxDEvVCM6zgRYx4B3T4/k2S1vjNooJ5kJOtFWemCi2nC+rcnjO9pXNW8Q==
X-Received: by 2002:a05:6214:48b:b0:890:e31:9685 with SMTP id 6a1803df08f44-8900e319a28mr37823076d6.69.1766790531561;
        Fri, 26 Dec 2025 15:08:51 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d99d7dc1esm173664886d6.39.2025.12.26.15.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 15:08:50 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <2f892ef9-1965-486d-beab-eacf0b6b0386@redhat.com>
Date: Fri, 26 Dec 2025 18:08:43 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/33] sched: Switch the fallback task allowed cpumask to
 HK_TYPE_DOMAIN
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
 <20251224134520.33231-29-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-29-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
> Tasks that have all their allowed CPUs offline don't want their affinity
> to fallback on either nohz_full CPUs or on domain isolated CPUs. And
> since nohz_full implies domain isolation, checking the latter is enough
> to verify both.
>
> Therefore exclude domain isolation from fallback task affinity.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   include/linux/mmu_context.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
> index ac01dc4eb2ce..ed3dd0f3fe19 100644
> --- a/include/linux/mmu_context.h
> +++ b/include/linux/mmu_context.h
> @@ -24,7 +24,7 @@ static inline void leave_mm(void) { }
>   #ifndef task_cpu_possible_mask
>   # define task_cpu_possible_mask(p)	cpu_possible_mask
>   # define task_cpu_possible(cpu, p)	true
> -# define task_cpu_fallback_mask(p)	housekeeping_cpumask(HK_TYPE_TICK)
> +# define task_cpu_fallback_mask(p)	housekeeping_cpumask(HK_TYPE_DOMAIN)
>   #else
>   # define task_cpu_possible(cpu, p)	cpumask_test_cpu((cpu), task_cpu_possible_mask(p))
>   #endif
Acked-by: Waiman Long <longman@redhat.com>

