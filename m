Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16AC2DC762
	for <linux-block@vger.kernel.org>; Tue, 30 Dec 2025 00:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767055058; cv=none; b=uL3FZaRVcxTkfeHE2C1rLjN34ND1wAskgcxvGNMTPkhAUh7WLgCuTAF8eVMjlDKYBcfwQPjddpbep3TzyHIgfeY81263CSjs/oigW+eub8Xa5pTV29tm4EEsF/fnVglm8Afo+n5BNY9wiuAEFE4XOhRxCwwXp/txYBfudHZGidI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767055058; c=relaxed/simple;
	bh=Eu/0MvqtXzKZbDhFka3bibWxt0bbXBOC90Q2iECgF+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYMKtLi9cN/Ij6XXwICYVBF11cKVZFtUeeYWnl1meQg6Zp7WEPF9KJN6PFAO499YnorjyJ+IVzMImXNklMrfl0ZzPZm0R81c2dkygTKStOofHwElt2qTKJIFmjSynwxjc5lwxMivjoCrBGNSPSfaYkfU4nzFH4ilWNumyhDSjso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=b75GFGci; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="b75GFGci"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7cc50eb0882so3514587a34.3
        for <linux-block@vger.kernel.org>; Mon, 29 Dec 2025 16:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767055052; x=1767659852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IheJhIQLOL+uGWt6XQ0zIC5UxYwT55m5ifEVRi78ko8=;
        b=b75GFGciNFmZMA1pAddG/IJyk0M4t8bjXViGqRPJUtlIXNSocJ3qCuRdzql4roVBtZ
         Qrdqe8iYz7Gqxf7ywr3VQyWONwdpO/lDW9ksNyJh+w7vmT1izd2arvO0pJy3QYropwn/
         A878rasRxsLtm+n5QK7MVcxyJlV40ig9KrV5JxxKyw8D0H+0TEIhgGsjCLH95Z0hiE7N
         8RWNwEm1HWyVBonRBhvnnUCwchniJf2BQPG5K6oxn0ODRncyVibOZ2qJcE15PPfMUrMk
         gB59gvD00SHa7wjiux9LcA7lI81kBy2sSg0xT3VH7QaujB/0Qbq9W14ydND7Y6Xw/Eft
         sQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767055052; x=1767659852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IheJhIQLOL+uGWt6XQ0zIC5UxYwT55m5ifEVRi78ko8=;
        b=AoAYBXVw0twcm8LacN4p6c3CbxHcIrWRwmc6Zu8JnDl/VxfeZYvXdxr3d4BXxHMRCb
         6B6GRZ8UMsOGnWbRQCr6qsM7R4NLDYY8FJF5Sm1uLtDdGVa66OieTOus9vHUQQ1ruTJT
         90PZevTFNbsMt7Znu/TDlZnLx3eBDmmna2JFVxcmwS/UgqqPHBNUFCFHEETxtZPlVN+R
         UE9RO6AfUmf7kc00ud+zldB5LSkasfT08P9YVZOt5ac2IXVg8TBgm6NP+XR5MPPb4e34
         nojmzn+Ky8Kou3Ngkn/Pme9guxwdII0Z/Ufo+KArOXKmLHz0lNlGMoUMZvTEb0y5jqi7
         1uJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPm8+okk3aTTABFnU2y9efQb/xoU9TIsz7icXo22AVTbDax9RscKsnGC9/gflcEpRjPKOC/SFF3UB5pQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+x8ARY8tkUam8xjeJ4joei6LpXITquhEg5AYvoVnUKI4uRxdx
	6iemIljeYxEZOGALW9CLlKOsUCWLFJ8YpAcnMDfT5R1sKqMHLkuULoYaWRHOHaxeWq4=
X-Gm-Gg: AY/fxX4Eqx9AUBx98fL6muPBDJiGNgABM/nhjzcKnArMFnmqHwJuYf6OyZrGoPx0Iz2
	BN4pw0ctzP8JSjbvE0eYX/SWe3eikuri5Tb0WZ8zoG0N/7lTKR82GmBFjYE+C1U+CAVDaVGjFSw
	Nq+pG903wD5c4pPBrnzfv4G5U9o/RhWFtWU538xaXarGZZ0hNafE+3eh+w+P0qkTmEHPPGVSA3Z
	BcMad+sPtPMCYfSiCdtsq4Y7tGJuZNrbuwdlEU8a0rafhQ2TSJVpGYSYg+y/UUcTkFPjMrisEAs
	avP/qVzkdAAAyE340iT4PwPd8PCLzAc8TQ4OkfdTcV65rXfvfqNVPhnTBYO2h2oDX8MS+dpzSyJ
	Ibv155heyaOoASnLH42+VIY/kRKVUwLJGJV6cYyjp2TKlXMbhHJjdVzAviE5CSyNeit09TAE3y/
	yUFQJpRW0w
X-Google-Smtp-Source: AGHT+IFl9yxlJpaq7sZYozgWoQTaTewr4cBUOiverIAjbR/CmqFwp/DL9X0O2bEGHsivPH5Emtcv9g==
X-Received: by 2002:a05:6830:2642:b0:7c7:6217:5c60 with SMTP id 46e09a7af769-7cc66a603d6mr14529090a34.25.1767055052471;
        Mon, 29 Dec 2025 16:37:32 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667d4f62sm21773347a34.19.2025.12.29.16.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 16:37:31 -0800 (PST)
Message-ID: <0f65c4fe-8b10-403d-b5b6-ed33fc4eb69c@kernel.dk>
Date: Mon, 29 Dec 2025 17:37:29 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/33] block: Protect against concurrent isolated cpuset
 change
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
 Johannes Weiner <hannes@cmpxchg.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Marco Crivellari <marco.crivellari@suse.com>,
 Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
 Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, netdev@vger.kernel.org
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-10-frederic@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251224134520.33231-10-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/24/25 6:44 AM, Frederic Weisbecker wrote:
> The block subsystem prevents running the workqueue to isolated CPUs,
> including those defined by cpuset isolated partitions. Since
> HK_TYPE_DOMAIN will soon contain both and be subject to runtime
> modifications, synchronize against housekeeping using the relevant lock.
> 
> For full support of cpuset changes, the block subsystem may need to
> propagate changes to isolated cpumask through the workqueue in the
> future.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  block/blk-mq.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 1978eef95dca..0037af1216f3 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4257,12 +4257,16 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>  
>  		/*
>  		 * Rule out isolated CPUs from hctx->cpumask to avoid
> -		 * running block kworker on isolated CPUs
> +		 * running block kworker on isolated CPUs.
> +		 * FIXME: cpuset should propagate further changes to isolated CPUs
> +		 * here.
>  		 */
> +		rcu_read_lock();
>  		for_each_cpu(cpu, hctx->cpumask) {
>  			if (cpu_is_isolated(cpu))
>  				cpumask_clear_cpu(cpu, hctx->cpumask);
>  		}
> +		rcu_read_unlock();

Want me to just take this one separately and get it out of your hair?
Doesn't seem to have any dependencies.

-- 
Jens Axboe
