Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7162D791
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 18:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705602706; cv=none; b=Qe7ZzsOEEuT7ZhAOc3KaMFU0SgLR6RZvPy/BZkzxPIPEZUP6ynBTyRHZCh1JJTO1MzVqQlYw0hTYlgFX42dPyLjr1M0DsZLmHArSfMHKcXvxegH15fDjD/HNX+VyOhIp9OpssMgEbfbn4ZBJgftzCFFXP/y/AMPoKbuXflhuyBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705602706; c=relaxed/simple;
	bh=5Qxa0Ct4m8CfB1bv9S4/Pc7jGugMfV813WL5KKS2NHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AFXGiJNqvRqftcwpG8rNyh591Tevx5l3UfJrXUSybCT4L72fwIGmh1Jv9ztDDQsfefCvrFKSxjllbtm+6JRCU6HjKmAOnmHe/UrkOFevxMdpITm9gTLUBFaHfkRwEZM9r/Q6H2f9DSwwabjzAJZhCY8Kuk+K7GdDK3iCyTcRH3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6db0c49e93eso581b3a.1
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 10:31:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705602704; x=1706207504;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Qxa0Ct4m8CfB1bv9S4/Pc7jGugMfV813WL5KKS2NHg=;
        b=VJTEKeFYesPfIWxeF8E7V0u0gRcQj+38B3/Tw0An7YBeW1YceS5G6/Y8AN8kNE4T/z
         HD1BJNrem6y4KvvDZEcUo+ADugKUB36O7UWYJhXAF9UOqRtDG7iyS/iv2pSET94gtZkj
         k2uOdTnZoK+5ItabY8eVV6ydNwsUeddaB2q7RIx1vVryOXXUf77K/WUvsyJWc2HH3SZZ
         w6dRgej5QoDOofsD4qsGtmrsvLiokCNK70F5uusuDmt0iTT/DKIL3L5wDoScudELwnE0
         Yudvt7h0bFySR5xr7WIklDlTRVHuQx2IjFuU1ZD8j6Ap4Ul4P36XTqvfZDyV0JiWdMJO
         8mhQ==
X-Gm-Message-State: AOJu0YxzHQxPsYntm0EssF1WWqrlZ22dmmcYUD3BiUj+UvACGFofgk+4
	BNnK7qZVNgqmGLXYUPBk/bAsX4VN96PQJVBWZzDhhD282fwV9YqcHxslVG7R
X-Google-Smtp-Source: AGHT+IGB0Q1KNR/xAZC2a1xBAk1+Ba1i4JFA9TWpu8YNPE+fcpucUUB8VMjrwhCuMPn1dxweBgwvBw==
X-Received: by 2002:a05:6a20:3d09:b0:19a:f4c9:5e96 with SMTP id y9-20020a056a203d0900b0019af4c95e96mr1502647pzi.34.1705602704031;
        Thu, 18 Jan 2024 10:31:44 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:718b:ab80:1dc2:cbee? ([2620:0:1000:8411:718b:ab80:1dc2:cbee])
        by smtp.gmail.com with ESMTPSA id z190-20020a6265c7000000b006d9c16b2089sm3740655pfb.188.2024.01.18.10.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 10:31:43 -0800 (PST)
Message-ID: <0ca63d05-fc5b-4e6a-a828-52eb24305545@acm.org>
Date: Thu, 18 Jan 2024 10:31:42 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block/mq-deadline: fallback to per-cpu insertion
 buckets under contention
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20240118180541.930783-1-axboe@kernel.dk>
 <20240118180541.930783-3-axboe@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240118180541.930783-3-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/18/24 10:04, Jens Axboe wrote:
> If we attempt to insert a list of requests but someone else is already
> running an insertion, then fallback to queueing it internally and let
> the existing inserter finish the operation.

Because this patch adds significant complexity: what are the use cases
that benefit from this kind of optimization? Are these perhaps workloads
on systems with many CPU cores and fast storage? If the storage is fast,
why to use mq-deadline instead of "none" as I/O-scheduler?

Thanks,

Bart.

