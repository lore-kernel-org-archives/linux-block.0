Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C175522258C
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862468; cv=none; b=kYf1/T/etUZPwmC+JHi2lZyO+ZCbwOVDBRrmnYvdqoV6nAfZw4cda2Wvf5bUvbHbHl+DroAj0CBJNaGgOqP+fSJ/7kiCm6Ubsz5UHKlUx0jzm4g44zbZGLOdgTgz4bPjLAg12Bx9FTbZKRVAa5surWz8+RdBbzlngSgohOCjgO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862468; c=relaxed/simple;
	bh=RBDa0jIO4VbsfMCQSIREc9cffsT7gvfxFla9G/UD7gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YSTZM5YNjcAb/tnpf5+7ECNniDDESxTvYK1pO7XQdXCQNeNIzIgpe53mM3VzMpOq533MB0E6Mi5E1Zq+hFmAG0OaXTio7/g9cGGk6JmAEtX2mH6RHIy54ltFfxVFsRwElmqM/7oh6JdzMVYE5bNoTwDUv5slcTlzteSWPAoSVq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PqHtQ0ke; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PqHtQ0ke"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d195166b2cso3128919a34.3
        for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 08:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771862466; x=1772467266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HX29uEwlmShEjfFqkdwl8Eb5l/ZDj+DL2kVuvz05S4k=;
        b=PqHtQ0kegO9Jus8W4cxNJI34/48vONyAjPHsLA84w3xhcTH+ehRGLWMutcJXZ2RAc/
         sIIW38BVXjib20Hzzie5/NskGtknX8AWizrrYqFC+cHd9PikB2egS7JaNbi54oMe6P/4
         ddf9EB7qZxkwqk3fcPIUygOni6aWtkYOvu4jDSCBwwynMsMsONTgNsrQ6SoIaPGchix5
         apan0c7Jll92fM9SkRm6Fx8tqeLhj2uls5bV+0bT0tWyuhs39yMoF4q2AatkXEkfO9jQ
         WZmQcIv6TmU8UxJu44cTa6JGtGGdPs47Tmw+CdciuwJYkd046huqr3OenbIXyacOEqFB
         SY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771862466; x=1772467266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HX29uEwlmShEjfFqkdwl8Eb5l/ZDj+DL2kVuvz05S4k=;
        b=mPmu9r1MRL1b99sdTF9oZ9DZ0driGQoC3ThTu2N+r240NQwoCrR0nZ/WEfmTbTj9JC
         Ig1gwdzO49508c6KvWf5pIHSMIIAVIgS0DB2r9AKh1mTXPGndI3JwI5HLsla66cSelES
         J1YpHEYKLj138Gfrho66zVYxiJsnppWJlGItL9GPpVNaom1A0psqOs6Ra5C6wVekc+eF
         UkloVsxON0Kf4zSl2VGQdavSAJCs6TTFYV8kSixTwi9UzlIGHBVhxlywomDDaZVwub45
         pmx2dsKsNsYf341CodVOwwqiXFuJYrgjhmAN6YhC96ZLUGZDHSE+GeTvcAx9o8RN66Vj
         L+4w==
X-Forwarded-Encrypted: i=1; AJvYcCUxfXgRvWKsMzaTHDhwzAm7UlLTx4aYsjaGN8jiH2AQxjcVFKW/U6XJYtF0N+HcW1lwi2V4VSB7stb2pw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaZB74SXeu9Vptx21d9EGJrWQbH/GTZg56Rv+gV3bv1GRgeCdU
	KT04l/N2I3SDy4S7we5fkHOp0aD64mN4rt3YNP4MLGKZBa7t7KviihAkRT8MyPvwwvo=
X-Gm-Gg: AZuq6aI3az0D1joPxOAGM9jRN73hSg1VhsXSF9xAO27M1iYP1pumJprS+QJfKETcqcb
	pqSUP/6ubUxxtBpVsflC16ooZs5L172IrXPgFy+0kCjpAYuRR2jN0+HJrPhvHbGpF6pN6w640yP
	qxgFRnFzcKVmJg6pNHBe030UBlYBOw3gAqog/wZfDZI9g/gwilzAUqI2pmo9EwEY+je7Blwe6Z0
	XH9+7MDx6pMm+ImbuH8eyG+MdTr4bkg3/45i/NJXY9DUs16YDBOC+j/+ubKEddCx0IrN1L7q67p
	fsKqI4bGEeljnTrA5O4CkbPGg1fKMIvMRZo48jnKX5oO8iKTVApAQ7aEL4tr4tSF4Shg1oCyxTl
	l7BCwKozz9EIJt9h1D10JrbM7k38LU0umpXJyJsFrVdsQ2/RG47rsuT2oTmlBOnQqkZSv9R7X/J
	vp4SeEfzbLYZNgLvtbhkxuKZY+bBqJQWkNH67TgDS0fN5S2dlgFwhe9EDIVK+QNzaqmWvr2Khlo
	TbJMM0lag==
X-Received: by 2002:a05:6830:3153:b0:7d1:853c:83e3 with SMTP id 46e09a7af769-7d52bdf416bmr6177467a34.2.1771862465520;
        Mon, 23 Feb 2026 08:01:05 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e37:2309:3937:4469? ([2600:8803:e7e4:500:e37:2309:3937:4469])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d55b9a8498sm1062950a34.28.2026.02.23.08.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 08:01:05 -0800 (PST)
Message-ID: <47be2ff3-c25a-4aab-89fc-53921af8b0a9@baylibre.com>
Date: Mon, 23 Feb 2026 10:01:03 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/33] mm: vmstat: Prepare to protect against concurrent
 isolated cpuset change
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
 Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
 Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, netdev@vger.kernel.org
References: <20260101221359.22298-1-frederic@kernel.org>
 <20260101221359.22298-5-frederic@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260101221359.22298-5-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/1/26 4:13 PM, Frederic Weisbecker wrote:
> The HK_TYPE_DOMAIN housekeeping cpumask will soon be made modifiable at
> runtime. In order to synchronize against vmstat workqueue to make sure
> that no asynchronous vmstat work is pending or executing on a newly made
> isolated CPU, target and queue a vmstat work under the same RCU read
> side critical section.
> 
> Whenever housekeeping will update the HK_TYPE_DOMAIN cpumask, a vmstat
> workqueue flush will also be issued in a further change to make sure
> that no work remains pending after a CPU has been made isolated.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  mm/vmstat.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 65de88cdf40e..ed19c0d42de6 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -2144,11 +2144,13 @@ static void vmstat_shepherd(struct work_struct *w)
>  		 * infrastructure ever noticing. Skip regular flushing from vmstat_shepherd
>  		 * for all isolated CPUs to avoid interference with the isolated workload.
>  		 */
> -		if (cpu_is_isolated(cpu))
> -			continue;
> +		scoped_guard(rcu) {
> +			if (cpu_is_isolated(cpu))
> +				continue;

I think this might have introduced a bug - or at least an unintentional change
in the program flow.

scoped_guard() is implemented using a for loop. Now this continue statement will
only exit the scoped_guard() scope rather than continuing the outer for loop. This
means that cond_resched() will be called when it previously was not.

>  
> -		if (!delayed_work_pending(dw) && need_update(cpu))
> -			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
> +			if (!delayed_work_pending(dw) && need_update(cpu))
> +				queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
> +		}
>  
>  		cond_resched();
>  	}

