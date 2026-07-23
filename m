Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524C946D557
	for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 11:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784805488; cv=none; b=dtNOEfqGgDVQ36c6ayuwynb2VzHnNvUNyVhazAZEMD1m9Lu7wm6+y0BTRe2yYg0bJnanFfNssjczBHwwHch0JsqYVxJMYE9I5ATrbcn0U89GkGaqFFycQg+HiC40fiKtAQynf7x7929Okye6ClQeRiMaszu6WYcddnyCica8i10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784805488; c=relaxed/simple;
	bh=+Wkaj4UHoena/1Gfc+0sVRsK85mXOaIe+VRpgEhw/+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P72M8EmOO4CmW3nJazKUJirxNoVd6XN3+YTzgH9BR83tPH6bwAinu2VAoaRs+HlReQkIFMk8sCDKKaqJaNoHM+EoZMXh65z8vUidq0p78QBo7DQsIh66/GioOQvlIvIsry1i0jmRemTF53CM4ukIGJwi21WNGb27Plcab2QOFVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJwRFtML; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJwRFtML"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-382ef647e20so493982a91.1
        for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 04:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784805482; x=1785410282; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5p4lXkdpnCsbltYcC1FVF7UTY1mmokYIoR5useAxszA=;
        b=VJwRFtMLFtwwxQvdU515qnSw5GDF0xRHaRZPqHLtiYAZ1kKs/fHtLanrE0mejSMCYv
         fYUmo8IFfMyi0DfmjI31y6BBGF8LGZiOAzYbA/Pg21l+JliazaifAzZ+zOgrDeEbDc+9
         duGCgehvS4kJYIUSazDIv3/rw+dDGe17xPpdLXMbsCXTOWiooaM4NydPrUHDSOrJh6rk
         gdbEbjGzuFugh1qisFhpyK3byWqJyuLWEdInGNquqey3jKjseaL1lTCIO3e15wF8sfi1
         QHeuMZyp1/EDh2C78FZO0SqC6AuWcsMKqEP7jgII3qxGmaQuF1S0G0RZnIteAxcsKOte
         R1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784805482; x=1785410282;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5p4lXkdpnCsbltYcC1FVF7UTY1mmokYIoR5useAxszA=;
        b=Cmti8TuvxsXFZIKbSZyNCtiPEsR5XeS4N+EMACSpXQf5kULJ2G0zsqFWoaLj36NiDk
         QIHprHX3iGVy2GFqNZfbyitZid/pVxbOBNwcdQhHBFfFo6ovYlqU7XohwUaVSjbl4oe5
         RMbySzqnEJbLrC00z09vL6ZYTAWIEqTdna6oMyVol8Q2xJWplWfzHreLCg610vIOMsLe
         +07CqWJ2P0mZRW1oa/UPe/isBP8IBMSGbNdymnXK4FxmLCzFfECoI0yea8ADP+3G8XQQ
         4Na+xBk/yY/pJ2+Pz5Y72dzLn4pAKq7ZOEKf8tY+2DFWkZnInAGSDr6lfrcwuXX3BNxF
         YW/g==
X-Gm-Message-State: AOJu0YyX0NZLxC2a9LZlR7dDfiFY8LVZO47r/m9PSUnXRrfUQIGoZw3H
	8++H4BHAJM+j0TAKYaHyiDNaW7XyK4LHuNPCC0ds6nytr/5/JfUwdN7d
X-Gm-Gg: AR+sD11LUrwBjMJ6OayQrJ2QVxhkDFVT7qlS1Tv2JGh1yHmxfElL/XR9QPK+ZDIgtze
	RULQwFtDveFZlAtaKzcXXOS9V1JNQ6HHJ4m6y6Pr9V1ND46bahY9AnMqFz6Nuwk+cCFaaduG90f
	qWsJNHMj4ccd4J+4qEGyMMhCwZ9/0+rk3DWAJrI5YjJWi7gjEDzx2rIAfOwJHAE2MOuDBrJrQ9q
	p/hxmGDjilkB45T6FA2L65C5pCG7+BOM0ZIbLX5HeLht+3B4DzOiXOr/rgzgDbhQY0j1+P0wiKS
	+XcoJ81xvaArVBpedArT2iJnA+3ODw2xCieSNKOv2qSMeJ6d2KwXj0+W4AaGg83ov6l257+rjyz
	mJH8gMsJFoF8bDwX+ZjDfBnnBYN/IhftW305gy9QAghjL8gRECrC41agfzObcBXGPMMv1PMEd7q
	DK/8P0orS+J//ofRYOrIdV8H/+
X-Received: by 2002:a17:90b:1d48:b0:387:e0db:3d8e with SMTP id 98e67ed59e1d1-38ec665050cmr2866538a91.41.1784805481916;
        Thu, 23 Jul 2026 04:18:01 -0700 (PDT)
Received: from [10.22.68.205] ([118.201.124.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38ea5966676sm1591924a91.2.2026.07.23.04.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 04:18:01 -0700 (PDT)
Message-ID: <51865f65-7b75-40a8-b7ba-7029065f5840@gmail.com>
Date: Thu, 23 Jul 2026 19:17:57 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-cgroup: remove unused blk_queue_for_each_rl stub
To: Tao Cui <cui.tao@linux.dev>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, tj@kernel.org, yukuai@kernel.org,
 yangxiuwei@kylinos.cn, cuitao@kylinos.cn
References: <20260717102049.2080768-1-cui.tao@linux.dev>
Content-Language: en-US
From: Tang Yizhou <tangyeechou@gmail.com>
In-Reply-To: <20260717102049.2080768-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 17/7/26 6:20 pm, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> blk_queue_for_each_rl() was added by commit a051661ca6d1 ("blkcg:
> implement per-blkg request allocation") to iterate over the root request
> list and per-blkg request lists for the legacy (non-blk-mq) request
> allocation path.  The request_list code, including q->root_rl from
> struct request_queue, was later removed in 2018 by commit db6d99523560
> ("block: remove request_list code").
> 
> The macro definition left behind in the !CONFIG_BLK_CGROUP fallback
> branch of the private block/blk-cgroup.h header now references the
> removed q->root_rl field, and has no callers in-tree (it would fail to
> compile if expanded, so it cannot have any out-of-tree users either).
> 
> Remove the dead stub.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  block/blk-cgroup.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
> index 615390f751aa..6a309d2d3db5 100644
> --- a/block/blk-cgroup.h
> +++ b/block/blk-cgroup.h
> @@ -500,9 +500,6 @@ static inline void blkg_put(struct blkcg_gq *blkg) { }
>  static inline void blk_cgroup_bio_start(struct bio *bio) { }
>  static inline bool blk_cgroup_mergeable(struct request *rq, struct bio *bio) { return true; }
>  
> -#define blk_queue_for_each_rl(rl, q)	\
> -	for ((rl) = &(q)->root_rl; (rl); (rl) = NULL)
> -
>  #endif	/* CONFIG_BLK_CGROUP */
>  
>  #endif /* _BLK_CGROUP_PRIVATE_H */

Reviewed-by: Tang Yizhou <yizhou.tang@shopee.com>

-- 
Best Regards,
Yi

