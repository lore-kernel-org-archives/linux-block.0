Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9974E3B186
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764598689; cv=none; b=M1r1Se3KJ4NkPtBdNLXi7cHTE+O4kvN0UAL37lnWCQPiYZjOiUFwMoU9c3ZO6/fmpMmNw7zYawDpNC8B0AzhVhPcgYfmsoLTElTlktj0j62DDxaYC5A4DWR/mRlTpoH54RgGEPkxLuhx9McVXkEh7DmEAJlU8ZSWcz4nY6XPK+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764598689; c=relaxed/simple;
	bh=h3rbZP3fV0IHuVr1GQKmxQeLDqhbQnnVkhaz+tvSvRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CvMxTBBzFgFAkDBscbZ77jXr7PxUAPlqg/s6cFMl7akWwl5Ybo5GhZDkW2dMtT+kX+KY4gVLu3qmuO4NpffBUuAvWp0mwnzvBwMFQi53jlBitRaVXYO/Ev/Mx3F29PGW0/aAQ9KcGwlBVGeqzgbY6znlmrB07uILTth2GIweKlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=M8TwWvT0; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="M8TwWvT0"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-9486354dcb2so181924039f.3
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 06:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764598684; x=1765203484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F/6CFxxBHG/WIoG6WEATxfC9c0gYCxW+OS9tRPY2quM=;
        b=M8TwWvT04Cjo2FCeweu0nzG3j/SLwq+ogNeAtzdJl06AG8+YM1SscNWe1AT/wis1nw
         XGJd6svYmojkTckTV2NcSS5Gv2MPad2NBnwNx5VkDNbR275wRa1e+xinlVLrqKGKLml9
         DxgvRyaR7dRzXyyQdGUZIzAvXM3hoXmaId39l7e2wX52bna+8g+FsFaomfnisbhlhSUF
         eqgb4B2NfN9MHsFMGhHJ/tXvMt85tCGeeU8C9UvAuj3qEzfEVwVkJMn6ubaxwKgNkAJh
         8BT4pKIC6OxGqdU0sxX+peFjS6UIQK9HGlmxpDpmLLvKbDqljFgEsAbuyXkogwSm4rzR
         lgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764598684; x=1765203484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/6CFxxBHG/WIoG6WEATxfC9c0gYCxW+OS9tRPY2quM=;
        b=ZVoAMHtD3OOKhG3xyuLz6aXSc/jhEw6UvH/5gul1ffSw+hKCXPMiCDJMBJNeCfAlG0
         OTS+H2u6FL4UD0FMLrgur1bwy0ug/20/BgzbR63HdMspfZe1AtYZAvfi3hEAjHOi7dVt
         IDzqHV+1JR26VpvoaenLClGVGebfmCnZ7CVwAWK8tBQvecloCAHJ7OLiLbgCdohUTaxJ
         8OWOW/OwHiBFqVmwfTKeIYQV2mR8NPGj/bx6NCpDvP1ebSbVuTaj/gZvRH7xhVWvzT1Z
         G7O1ofx5o7XD2mVSdPWuvscxCRQwDyN7a5CsWsLFFngwp0w1TDdRfTbgK6QB/zaL2z5H
         nJjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMH1FomxVm3pe6S6Oz8pNd+gmE+YHSrFAyzQfln2uHHW7E9z4gxo56v/cLinswoQtwTpDN1axIJXRZXA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/+6EQiDbe3wDQxdcQGrvAo8+Ar7pNqqRARDvXAaldPnnNHAgP
	pREwqHrOMxd94ZqskPDD5KCM1Y9AJESDLnx5LQAiQgwHJ6sAHI7o9oMCigOflLJdLMo=
X-Gm-Gg: ASbGnctFUmovcCv5VJWISfsdbmtAHEuP9BjEXmCqHcCkaqMP7lTm4hpXwfxBEqDookO
	nN75qtegAr56R7GweAcU/X/Op0kcLG8ZAy2bqXHJwKv89VEtxu6LOS3XzcDDXegzz8NSyLJTyjL
	8JHkRTvZPkXBDTqpVwCv5n0Nz1wKaJ3E4CnfD0wYze1X2OpI46TJSmo26Dq3RzELctVp55DXC8U
	67gkWW7phW1h/BhtChjwsjM5xMfF1YMJCFMZ/XvAK7LuWm1j5vNn44kCm5KvOSg/GmJwbgFcyJS
	h0o4ZYRxfRlH1YfBSAmfIO9bIYvLXg7rx+48YJn8j4dSBblwyuo5YaBBb9WohZvWL1MteHTwNNj
	tYMWvkS+yOrdqJ/DDH752k++YIHy1ghGjC6FCy3s3+G8ZB3t4MtAezJXtPHZSxuJN5/+MnVNdaZ
	PN3/9Ysg==
X-Google-Smtp-Source: AGHT+IF3G9KyDrcr/dsaGOdHNybcvbHc9D/O83zkxW0e7cuWx4cN9hmlcRysu39o8lsbeH4dxl9jFQ==
X-Received: by 2002:a02:c995:0:b0:5b7:d710:662b with SMTP id 8926c6da1cb9f-5b967ac8e72mr28523100173.22.1764598684358;
        Mon, 01 Dec 2025 06:18:04 -0800 (PST)
Received: from [192.168.1.99] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b9bc768ae9sm5966579173.37.2025.12.01.06.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 06:18:03 -0800 (PST)
Message-ID: <b5f09d4e-5e46-473a-b7e4-f4ea06793551@kernel.dk>
Date: Mon, 1 Dec 2025 07:18:02 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: use queue_hctx in blk_mq_map_queue_type
To: Fengnan Chang <fengnanchang@gmail.com>, linux-block@vger.kernel.org,
 ming.lei@redhat.com, hare@suse.de, hch@lst.de, yukuai@fnnas.com
Cc: Fengnan Chang <changfengnan@bytedance.com>
References: <20251201122504.64439-1-changfengnan@bytedance.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251201122504.64439-1-changfengnan@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/1/25 5:25 AM, Fengnan Chang wrote:
> Some caller of blk_mq_map_queue_type now didn't grab
> 'q_usage_counter', such as blk_mq_cpu_mapped_to_hctx, so we need
> protect 'queue_hw_ctx' through rcu.
> 
> Also checked all other functions, no more missed cases.
> 
> Fixes: 89e1fb7ceffd ("blk-mq: fix potential uaf for 'queue_hw_ctx'")
> Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>

Reported-by: Jens Axboe <axboe@kernel.dk>

?

I'll queue it up.

-- 
Jens Axboe

