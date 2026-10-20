Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509797;
	b=zoq7Igj88Ul3MEmNW/f9XzEjxOlQnWGIQDTe2Z1sCTfymfeaXLgNP1/MBIQh1Gb0+DMm
	 Cg0ZxoKHdl+iQIIY7ZCD290H6x6BUvJHs32m8S2O/MggTf6Fm0FfNbEIi4s1hWSEWxZWZ
	 f6i/LTJ6QjfWZDgNsL3msHWkJA2N1N5tYIVePnEtF45UX5le8naGWTH/lignA5iYnZIb2
	 RcKPVG57CpQn57/yglog7p4w4mFnIlgZBh3rnK9QqZspdZCIkG9liNbid21C6x0SbVUG2
	 lidJKcJF0nanMbKRfFpm7herfvFNZErsDKMqfq3OrymRgDkBNJjBhP4WMz5b/9DRwkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509797;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=gRK1N06gC7y4lklCZOXSgRG5jNtEwJRUHirNfgb2kAs=;
	b=dgqkCS8FYV6u2wDakpkBdUXSv3G9yE6sYUe3x1h/r+nQ+rNXKTBFmivSHn8JVV2RbDcg
	 XrQmA8Lxz7tUZlUTMfOzPkZWFiqM2dKJiOur025ZCxwZYR0pbtSnUP0RiIw/WCfv/kwtb
	 P1PRImzpilHCGrahzP/BOMgJHQz+buBJDlONiMIEbwrCOdwJ23vzK0mIVJtQZNBiG65uc
	 PfJtqTOhstU9uBgaTeLyRCeFDj9/gWZCS6Y/IkJmtxAAcbJXYFuaSFSn1kHoTrFrqHUCz
	 22t+ioSTapEvRNogvzJMLdblxEj1bCfrvF2ZI6bpO7T2gEMFg07UZsFqbVIruTKaeWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=dkPslbGk;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B8B606A31B
	for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 15:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70B8B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=dkPslbGk
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35f036b17easo1302649eec.1
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 08:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792509795; x=1793114595; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gRK1N06gC7y4lklCZOXSgRG5jNtEwJRUHirNfgb2kAs=;
        b=dkPslbGkC1nueqKNXl755MPhADryHbix1NVdewPX8G0v9UdD7ZfloAWtp9AAN7zC5/
         vaYuCEQu3zOAobsJcIgqUtf2wYzeZwthITqkeWWuj15jPJASH2wlHWmNoxpvWu6LHzWX
         pL4Cz7cFTpzkQ6kEDymUiK2vJpxXPX62Ob7r7tJb5oqf5bHEiNDpj+vDwbTRL6iD5CnZ
         +/vTZ6N4iowAvPU+hwW3vGLftpHfs7Z8U8fOkmCqAtbeN7lyo1IY8O4KrI1pJ4k4x21k
         tPgoO+JyoZSiG5fgtaAFynGDBmqqeXrNIOYbilx19pq1K07EMW5CyFNpGsVuNdmFuf8Y
         tGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792509795; x=1793114595;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gRK1N06gC7y4lklCZOXSgRG5jNtEwJRUHirNfgb2kAs=;
        b=QKrp0xXoVydn1v0wubbncbBXjBCCwIrxTjsi68nI3J0gvMqnDWOD+Wj6tvhbmouQ8J
         UT37fZLysPNhk78/tj+peyb3fNFA3l15ly3AcKwDAWVzLkEjACCMUpO2LPsgPYtSgsUE
         AoBnFxG9n41h0Rs/8jPIcR3bdtpEWRImtf7WH2nOmnuPPCF++DCdAp3bhjpK2+aucFlA
         Y9bjFZCC7w+86nxBZXc4QL18OzQPe2yqr47wlM2/bY/VJi3ZfDjEV41upayizcULYLfq
         DVV6OYWTm9HfWTXre7+UtqurWCp/l8e2yHD5CO/RhX9bFYURtsX45ApZ8SLS6ONNFFkt
         rAeQ==
X-Forwarded-Encrypted: i=1; AKwUvBzgnQhMTiaFquojzYSSKKBpPDmtwZg/vUceU3gT2skNv7rCMC6JVuzIfcdxjRQ5FxQFHBdLRXGYjX7Xkg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKDOpnd5n9V3pxaWqe1dP2830Z6fsv2vMOtiVimpeIRnAEqvA4c
	P8TxBVIkhSmMfEJKhAbFKeg33ciwdy3clYRlXcJSM7Adphtr03R+mgexC265JFROWWM=
X-Gm-Gg: AYBFou2H7TflFjkdePnmDuzl3hZWYXChdcN7rMbPGu6fT2g8tory4h81omYukUrKg+U
	JX1b180K4BV4IDQsSrXEamB782xnLfhsgbhwX8cxlukD70iULJL4dJHfO8zXUdYGouAfSRF41Se
	D1azUnJMD5SzHAkuGMz4Wl4X8qR/+v5m8amvGUnFtqVxHg5LKU9plvfR/ULnz+d4Gf2q3gpFex8
	7CDC+ueK8dKwQPy3mDLPV8gfRIW/ZSwuAb9mYMiY5798fUyuk8Oak1gw5CMO12ha4l39UMyTUYX
	d5bzDsh+zO3puOMfPQifDScqKSGmxZOhW9lsba+oSgJiInbRkJwwHSzPPWD837KZWukiPJNqKIO
	2sybWDpGcYvMli3FNOmpRv0jUgnn266PBT7mZFIdoHG+k0J1bwLgesH26C9jJL0x6EIdmGzC3ab
	PEAGNUayhQBIwtFP9wlzsuudvUDsoISNuhoWVf7mjZlMx9zwIYp2x/UktW22AojE7t6ZQvz2yHx
	OnbuD10tuqVNigOa024bMbIMH7WXStSa1rJbd24YQME4zh8jpT3pTTlA5leuaDbBqeOT7GWT3ed
	h9zYCQVHZdw7A0RXw6RCykimEd9jIXSCOldJVZ1x2IdohsjvnUEHBtRxsthabnObbK0lYxfertz
	mOtIK
X-Received: by 2002:a05:693c:62c2:b0:35f:f0:8ed1 with SMTP id 5a478bee46e88-361a2a3f147mr13596612eec.36.1792509795251;
        Tue, 20 Oct 2026 08:23:15 -0700 (PDT)
Received: from [10.61.8.29] ([155.98.132.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6ca5sm39540410eec.9.2026.10.20.08.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 08:23:12 -0700 (PDT)
Message-ID: <694b548c-5f34-48f2-8ccc-5aa020c76939@kernel.dk>
Date: Tue, 20 Oct 2026 09:23:10 -0600
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] blk-mq: dispatch kworker to housekeeping CPU when hctx
 cpumask is empty
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: tom.leiming@gmail.com, hare@suse.de, dwagner@suse.de,
 frederic@kernel.org, tj@kernel.org, sean@ashe.io,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261016052203.489760-1-atomlin@atomlin.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261016052203.489760-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/26 11:22 PM, Aaron Tomlin wrote:
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 025a799f35b9..1a113679f15b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2241,6 +2241,21 @@ static bool blk_mq_hctx_empty_cpumask(struct blk_mq_hw_ctx *hctx)
>          return hctx->next_cpu >= nr_cpu_ids;
>  }
>  
> +static inline int blk_mq_hctx_unbound_cpu(void)
> +{
> +	if (cpu_is_isolated(raw_smp_processor_id())) {
> +		int cpu;
> +
> +		guard(rcu)();
> +
> +		cpu = cpumask_any_and_distribute(housekeeping_cpumask(HK_TYPE_DOMAIN),
> +						 cpu_online_mask);
> +		if (cpu < nr_cpu_ids)
> +			return cpu;
> +	}
> +	return WORK_CPU_UNBOUND;
> +}

Not opposed to this, but let's please think about making the
common case the fast path. CPU isolation is not the common
path. That might mean annotating the hctx itself.

-- 
Jens Axboe

