Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AFA3C199C
	for <linux-block@vger.kernel.org>; Fri, 17 Jul 2026 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784287541; cv=none; b=iUWTh6o+NF5HhkKkUfPqWHxLomW1v67qV9j9N5QUyWG7cTuqC9E+XnxLqtKZ2Co4SCAgnEGhQOYA4TQ9LjzUiamtzcT0ouX5f9ZLXJwNlGL7goVv4YELBxuLMbfrQVX1sUJavW6XZtXbgrrHi6boSN29zaNhsFDFnuekHKgBjwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784287541; c=relaxed/simple;
	bh=b13YWFUSi2ABCS9GNvKmbC8JRTyS6lZ2xmdiWv/pWXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VhYDSxb9C6AerKEiIKnP6L06Z81IriqQDZy0d4Ba/ooKFoGQs/7GBvggIjUZ1Et1Y/9z2axB0E2pHyKNqK2V5Tb3Ro/X27jUAwfNsyFcUYjf/2wID53QuP4BytCKvTIa+Tibl1zz/gicKd9EPeEphZ8jQXk8BACpT56HFvlpUrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIOcj4Ss; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIOcj4Ss"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso47479355ad.2
        for <linux-block@vger.kernel.org>; Fri, 17 Jul 2026 04:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784287540; x=1784892340; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pVuierYlugSu0sUY+XJcj2RzObrDWMBeCLTVAQKDCbA=;
        b=mIOcj4SsowtR8l7Sy2SghhLQEv4P+821zCh2DDE6VFx1nwQYpFmP8/OvLFU+yeiHWn
         bADl6Eh03bVk6mBZupCOBp/GAT/jXyazu5PZq3Kyr05GmKkCzLlp9GVBHDPJlciYJSEW
         M3ZwY3m8oeWosIdOWu7oQIanUXPb64BJU7rSEJmH8l/R1EWaO8xGWR7IzXpvDNRv7qbR
         nBrkQsoOXpbXC8wB7xkq9eYmuhUKrXrXKuDBJfPas+CCUVRTFpBBJ+tO7TNn51cIrzRe
         LfOF4kAZT5Qe+BqKreQ72qH5+s6XJtajTRwTCQhwaet6BY06Qxav6Pgf12qEda3sIyax
         9FnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784287540; x=1784892340;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pVuierYlugSu0sUY+XJcj2RzObrDWMBeCLTVAQKDCbA=;
        b=VPXcCwh+EKRirCDJgQeOru6bfeZJI3IQWVibFPgMbFAcdR002u+dQ3F4geolfUqimi
         Y2fNwtNbNv5udodBeS9pkDcs22qhU8N3jvE/t9gthzi1HYFFF+57m0umQS4e3TaItqnc
         Ngtvm4h//uVJ8yfUaOMOcbddbGb0Q0FX4B9GjuRSgAHy+aYiLh8Xg1NdxoKC0B7iukcz
         DQKTcywAbWmgnCemoLLcmgSR3V0ny0Fm63KA2y9bzKG7wyXzKBhj7fd6w2VRlCGVom85
         x4R0aKrTmNpqxCloRlXlGUvjeVWWQmxGeNqMkiqJNIZt6fdLFO00miJpyOKoc2ZSPJq3
         qJuA==
X-Forwarded-Encrypted: i=1; AHgh+Ro4hCOkY8QvQ/i9/46unZfpqXlvSDE8INbhTt0Ia8wXUAmW6GePYpRELUzv18bO6ma0m8+nl0gCPC0FpA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl7G4hT2HGnw6qf8qYmxAKIsqGjeLr++VMBhaDtKSKQn0gIOLa
	NMPdRy5cIYD8Zouhm39KE9Ck9kWvw2Lfs+aSvrTH032HSDOiBTgGayvzk9HVzkJX/eaSBnFk
X-Gm-Gg: AfdE7ckGzESX2AgdQWxnCQq/PgMthlcJzdTGR8qrIzEDHKbPfRcK6zQ3E/e0xi5vKwB
	qgLXFTwsPgBpCuWUw+FmcFxcv/PQlgG0BuPKCBTcHlzI7VS2emjjxS5/JAyiBj/n1raHiUYKlq/
	tAiTsG7CQ+Q/NiUmnXVmoPxwuNrHfTOYllR/rvJGzuDVirQkRF/7qEdD0QzaWGYv9KqItLmCjZH
	VzovDEhBwQBNm/cpSnxqqvOSjBp5P3zKMFXbwZhEQ2zGKYwWT9YtGPT65FtWPB6WK5Ftpmak/lU
	HWhu6qXV6DI7grYLiLxlEYWHDUZI9Ennc4dIoHEl66bcb1FFdoiBNbnUgP6XRHuuC3nhM94UC4j
	COqCLnQzx14kineUoHJ4cNnnqNh94GK0UWk3f511U9AwxvMrZcwIuWjAe3NN++0MEOso1nJKWTN
	FJJDYi73iHFQcy04IqvgmdTM59+37Md9lPyu1Paodx036kyY3ymukNKycfIl7Ul8oORCAtu3vpG
	A==
X-Received: by 2002:a17:903:1b2e:b0:2ca:281:27f9 with SMTP id d9443c01a7336-2cf349978f5mr22647765ad.27.1784287539501;
        Fri, 17 Jul 2026 04:25:39 -0700 (PDT)
Received: from ?IPV6:2400:79e0:1203:64b0:6cf3:a642:5711:319? ([2400:79e0:1203:64b0:6cf3:a642:5711:319])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344d80e6sm8978785ad.29.2026.07.17.04.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 04:25:38 -0700 (PDT)
Message-ID: <3a711d12-5184-45b0-a4d5-2d02a17d8b3b@gmail.com>
Date: Fri, 17 Jul 2026 19:25:35 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-throttle: remove dead field last_check_time from
 throtl_grp
To: Tao Cui <cui.tao@linux.dev>, axboe@kernel.dk, linux-block@vger.kernel.org
Cc: tj@kernel.org, josef@toxicpanda.com, yukuai3@huawei.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>
References: <20260717054855.2018578-1-cui.tao@linux.dev>
Content-Language: en-US
From: Tang Yizhou <tangyeechou@gmail.com>
In-Reply-To: <20260717054855.2018578-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/7/26 1:48 pm, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> The last_check_time field in throtl_grp was used by the
> CONFIG_BLK_DEV_THROTTLING_LOW mechanism (in throtl_upgrade_check() and
> the downgrade logic) to timestamp the last upgrade/downgrade check.
> 
> Commit bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW")
> removed all five of its uses in blk-throttle.c and the surrounding LOW
> fields (latency_target, last_finish_time, checked_last_finish_time,
> avg_idletime, idletime_threshold, bio_cnt, bad_bio_cnt,
> bio_cnt_reset_time), but missed the field definition itself.
> 
> It has been a dead field since then: zero references in blk-throttle.c
> and the whole tree.  Remove it.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  block/blk-throttle.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> index 9d7a42c039a1..1b5775771e07 100644
> --- a/block/blk-throttle.h
> +++ b/block/blk-throttle.h
> @@ -120,8 +120,6 @@ struct throtl_grp {
>  	int64_t bytes_disp[2];
>  	int io_disp[2];
>  
> -	unsigned long last_check_time;
> -
>  	/* When did we start a new slice */
>  	unsigned long slice_start[2];
>  	unsigned long slice_end[2];

Reviewed-by: Tang Yizhou <yizhou.tang@shopee.com>

-- 
Best Regards,
Yi

