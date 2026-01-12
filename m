Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F2D21FF49
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 01:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768182215; cv=none; b=VhsMbd1uLQ3WF0EdLbVeRfvPFlyndBMGaInQV/ux0vL5J/Nn37M+UKM5B5Br4oHu8PTYiA1fR7ZfQFIXnKnAg3V8fvU4RGRNuJcLBYcZAydMUgQ0RSOk2IVNUlKJ19Hl/x/OYBVvFr11gwn30wigqdvT+U5PmHGTHdQhDu4Ii9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768182215; c=relaxed/simple;
	bh=hS5M2IBt+XDf18Gy4ts4vK0v+84GrMVmqYQzF/J1aLY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oxEz/D+xKsy6o9FIgnmOJKAogvT0dDywclCAb7gah48CiQl/JXjojxJ3nVFimu3exGwGl/s5rjEDo9zoFekZTknQXm2u572Tgi0kSumbg/n1CRfM/lriypr5X37BBvom6JSGWGWbCb/WCtZsmMn2zYdeQ7IXxU07FULhldtwtKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h20AJA39; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fM9c3APa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h20AJA39";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fM9c3APa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768182213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5g0eqFZw+saooIdmg9NsoPWVUWAMnQL8vdrqEmKZ9zg=;
	b=h20AJA39iueWpUfsWHIyMbWOwGr8njJH8B4VH6UaX9OhjXt+tovB3b7LQHHY5qVQKl6Eei
	xDpOBfFhSoOh9al/I60XBM719p4XDmEPiDT0H+lkx2j3j7ldZmy1lijmYRRAgUHxUZSg36
	uwZz3emhbIMqwGSSDShzUQS6iDs908A=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-sBtgy-D5PEmiAFGD19cyMQ-1; Sun, 11 Jan 2026 20:43:31 -0500
X-MC-Unique: sBtgy-D5PEmiAFGD19cyMQ-1
X-Mimecast-MFC-AGG-ID: sBtgy-D5PEmiAFGD19cyMQ_1768182211
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-563662e2266so6993436e0c.0
        for <linux-block@vger.kernel.org>; Sun, 11 Jan 2026 17:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768182211; x=1768787011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5g0eqFZw+saooIdmg9NsoPWVUWAMnQL8vdrqEmKZ9zg=;
        b=fM9c3APaS9aJm3sKodkftW12rE+dqCrcvZJlQSwfYYp7KL3/Y/xN4jk/jSEVwDnpaz
         7bBln+Xh0dI9j3tuBh9QKGmDbyt0E7wP9SE2I9OJUvkdbdErxkUlN16ucy4/k9W7bPGN
         AZFMFIN6EPk7/I19Ka2sf+rhZC5iD8DvAjrppEKF6Oks8qFP3kypCAFrnqFct6/rdaJt
         fjQaHZ+oOsSQhcEt+ZTjCmHL678zidC4VAnb6VlC5JjLQMWznEsiMlboBmzxowUWNCEg
         DJlLBUab+MHi4Svpsy2LvKLAh5qnh4YxIziY4jgK787VXKkpe1LeRiL2JGkhyZv1iPAG
         Znzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768182211; x=1768787011;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5g0eqFZw+saooIdmg9NsoPWVUWAMnQL8vdrqEmKZ9zg=;
        b=ITRF9PX9qOUR4nm49ahYaGbschUBh+5Sw+i+R/wmJFdawqVkkyH093zH+D7gsIi+3R
         2+nf/KxdwvhpqfCwCy4IL9tsD08DTZoz04QQTQvVEqOzS1Jz6Zu/Kt7WPAfQPGpObzxa
         naH29kO3sY/PpHE2FzfmVqA5Oh0LxyDoawEuisiOQGufu34EaFA6RmuHSlPBGAYcnwO5
         SUcC3lvcYSsof+piQaUajcdR0ldZKPNfe5osSeFhkf8ANh//07RPY4uLqCcYFZ/4tn9t
         ytOUMm84IU1LSX3t4AyPS8lWO1zosSJt6+9gaJEUkBFqT3G6DLY9Y3384O//z5lQh8EP
         4o6A==
X-Forwarded-Encrypted: i=1; AJvYcCU2jGHI1Zj8HkccPKjYmwi8nLqupnMmeQxOxBLjxr/O2DFaojrA+XN5oJoCjSPzTmli1fZdyJCeDnn5ZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWcE6cxiMewMMe6Nd8n6qIdNuShHaXFyhP7YUNVZTU0lprBT8a
	4kTCUE860G9szVPiSgUanxlWsXxz0N6+/HviG37kQ0mGKFgMSTBPeTtLtkhVCT6veaKbhcr1y0W
	VjRXHnUs38l9HA0n0aRhjdETwQ+0eQUNtx/JkxjfOJo5FZTh3IUuoO1PoPR0ufr4f
X-Gm-Gg: AY/fxX6iR4+wrdD9j1sInpmUZ7uChkADbbuBPfGi1iZFDk01k6H6bCDPaanO+xwi/3R
	VyG02/hz25Bry17COkLLJmuYFr+Njv55c9RYP6Ut2lOLwcVPojFd+jIni/8IigcjHl3KqAKjjtM
	qpNdXnH6KJnOQ8iJtTIJMp8yDt2NTpamktAKF+CUeFs6b5qY2dcZpOfHUZwjtvQ4tHG+4faDRkG
	WMY0PhLA3m1HyzUXCTpWtWw6d4dIGH35hUcCAbLi8nuTAub5oBOPmpPyBJdGCv+uikirLjvTDPZ
	chSYnHVwWz8+JXmXu9z7WeDgIuFiQLisxI+Nd+ayUABH+5R6acMH2NzIPR7z76gftDBwKmpnM2F
	b3emHANRxNNlt7tAEc1nf9GoC8DVBdzUUrLb/MW+rBtbB3HkTKI4C+JXw
X-Received: by 2002:a05:6122:3383:b0:55e:82c3:e1fb with SMTP id 71dfb90a1353d-563466b1471mr6360613e0c.10.1768182211333;
        Sun, 11 Jan 2026 17:43:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHV+QUILwqeHqopifLZI0TMkyTSwUxskEqEsydIK3wu+6ViPTcpBZklzMvbaEYb1jKTIvUBCg==
X-Received: by 2002:a05:6122:3383:b0:55e:82c3:e1fb with SMTP id 71dfb90a1353d-563466b1471mr6360599e0c.10.1768182210967;
        Sun, 11 Jan 2026 17:43:30 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56375cd7cd6sm4961512e0c.10.2026.01.11.17.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 17:43:30 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <e97d96fc-cbdf-4c03-aa1a-b0cde5419681@redhat.com>
Date: Sun, 11 Jan 2026 20:43:16 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/33] cpuset: Provide lockdep check for cpuset lock held
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
References: <20260101221359.22298-1-frederic@kernel.org>
 <20260101221359.22298-13-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20260101221359.22298-13-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/1/26 5:13 PM, Frederic Weisbecker wrote:
> cpuset modifies partitions, including isolated, while holding the cpuset
> mutex.
>
> This means that holding the cpuset mutex is safe to synchronize against
> housekeeping cpumask changes.
>
> Provide a lockdep check to validate that.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   include/linux/cpuset.h | 2 ++
>   kernel/cgroup/cpuset.c | 7 +++++++
>   2 files changed, 9 insertions(+)
>
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index a98d3330385c..1c49ffd2ca9b 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -18,6 +18,8 @@
>   #include <linux/mmu_context.h>
>   #include <linux/jump_label.h>
>   
> +extern bool lockdep_is_cpuset_held(void);
> +
>   #ifdef CONFIG_CPUSETS
>   
>   /*
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 3afa72f8d579..5e2e3514c22e 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -283,6 +283,13 @@ void cpuset_full_unlock(void)
>   	cpus_read_unlock();
>   }
>   
> +#ifdef CONFIG_LOCKDEP
> +bool lockdep_is_cpuset_held(void)
> +{
> +	return lockdep_is_held(&cpuset_mutex);
> +}
> +#endif
> +
>   static DEFINE_SPINLOCK(callback_lock);
>   
>   void cpuset_callback_lock_irq(void)

The cgroup/for-next tree already have a similar 
lockdep_assert_cpuset_lock_held() defined. So you can drop this patch if 
this series won't land in the next merge window.

Cheers,
Longman

