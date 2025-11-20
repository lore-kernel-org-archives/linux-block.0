Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4137081F
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650901; cv=none; b=u3T5YzzK3OEGtHztmhjK5vlg43yRIm2BqWJt/kpkvxXzutT1PSftyl2os0JwRfvkBEl6zJe9N70oHWsHJpmK3Zt4WbPP06FnMIhWxdqywp0WBW94dzUcwkZBLe4bgl1t0lu+pe8RkMClLFom3hMtSp86qFWUJX5FTu7XrtzpJVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650901; c=relaxed/simple;
	bh=i7+z/ltNygDaEsok5KxXK0dj4UVl1aNJuWbKb2K6wi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OkZXGd6UZsGOPtU6sAAcqFkbhlb4C+8ZczALEqgNQisRaGGQBcRYQaM3OAUWg2625tojjlv7fSYoOntghBM/LouztK10RhlTg6XOeiyO2axMiUBFGpwlwknwyvi4/oLi0DvgbFb+iMU6GRxWvBdHOT/YHKZXWB/1zT59l4KpAUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=n6AXODaL; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="n6AXODaL"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-4330d2ea04eso4099445ab.3
        for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 07:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763650898; x=1764255698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LSDxdZVcIR29RyQwmW4yTqg5tQo8W9h4CxDjkRHZbCM=;
        b=n6AXODaLVpbO1ypoaTakIOYTXdQlwbo8iDVFc1ZIN9FFHyJSZWmbT0C3Qoen/2l7G3
         bG4QzLu8976h8Z959/TDeNmmRC0si/ELJhniCZ70IOiTqHHyAE6IKXi2K7p0yIfee0Pu
         XUvS1r8Zx1AqksX1WM5iGiGOKchRw5VV/+J0vqzczmVnvRuJh+hR+k9b2RddPhVsoYlY
         5jewNi6+UCZEqfQE+G5vQWwXLJLkKPIavQRg9j561qcGrATBOXLEDuLQ3SXc/inRSM8V
         RriWB37G0WIhQ8xJOX2cKV4X7y4yOtjyrbc3vatanwfs5sBLO6TDTZAzkS3Ual/9kv0k
         /MXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763650898; x=1764255698;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LSDxdZVcIR29RyQwmW4yTqg5tQo8W9h4CxDjkRHZbCM=;
        b=pk+NWpDHq5VrwopFGD4jjoK1gUe5ML2wFDOzVFdHkXw/d5eWUrXPPOX7nK8xW1oXIx
         0b5R65z6U2reF7GWToNYkB0kASRjPWzwgWezXm+wavBEdbiss0ZIl/kul78JjPvnTagD
         iPaiGPkrnrTL+jOo0OogCbwWsa6ynixupft4khk/6QLiZP7kKTYGfEUxmNEX5X6Rb4ky
         ZMEUJlB6ekROcD2GxUYNpLlG0Wot3i9oiziD0qUEwo9earQjWEfYC57NMSb3pIcrBA6a
         geGDpylSo/wvOVcTFjAGHIdwb6a7eUYAHo2kR5yqu/4b0efOCGagOqW6D6pcdlK/4YL5
         4CuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsStUxBmJGG1b0drXhCGeBUlLnXlzorksFocawBi4Spkvb9Kc5921+cKgOEOZJL/j77UlbPHmYlWhTag==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjVKAUUebQ38XzXXpUv5StuVpb/gxVoTummCkhau90N6NsH/+s
	x5GQRVO6CcPuHIA/UuoqAzHQk8REsTuZYIOI4NA4teL8d1Mo7aEgRcW0NHkxVBDkxNc=
X-Gm-Gg: ASbGncsgPr9Ps/xoDWJQ0j1hJajHMOnagU1eeI80jW+SOswVyGQfp75D/iipuUNCwrn
	L5yDc4noQospD8wAp3zbBMkaJKG4mDHt32RIA18OxzMcOOD4L/VyGs4+osXLwBmDMBuFBZaJGuE
	LY1pmjDO+6gJ4WsMJWk2FRsxesqxy8YelB9i2ZuMH6qLAIA1LnMmkvDv3RF7OtxF7kNRBYSJ5ZJ
	U4JT0IVBAsvugS+vfc/TzZTpqZLpQ9EV09ygSUFjA3tZoT373vNiNdQeTObj0lpy29o54PK9vEm
	e+EUX3MhhQ4BQvhPk3R2IjzE35SCpsYj4aYAzn320iuMhDkoHPUidU/3nszfCF7fitVLooSkPGZ
	6//PYUQgpYGTep3i/NRKB99Tqq0/fk/XUXdgc+OSYas5aHwVUkBqrz12gyQtsjYB/Clg=
X-Google-Smtp-Source: AGHT+IF9pA8fiysc4Hl7hdjzMkPNNGnxmNPLweWW+SrgIIlEz+A3x3KG5QLYzwBs/R37Gi6WOjPr3g==
X-Received: by 2002:a05:6e02:3a03:b0:433:7e2f:839d with SMTP id e9e14a558f8ab-435a9074d95mr28325845ab.21.1763650897829;
        Thu, 20 Nov 2025 07:01:37 -0800 (PST)
Received: from [192.168.1.96] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-435a8fc0020sm11590255ab.0.2025.11.20.07.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 07:01:36 -0800 (PST)
Message-ID: <d01e0be0-6c4e-4308-8663-b408ab74a911@kernel.dk>
Date: Thu, 20 Nov 2025 08:01:34 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] blk-mq: fix potential uaf for 'queue_hw_ctx'
To: Fengnan Chang <fengnanchang@gmail.com>, linux-block@vger.kernel.org,
 ming.lei@redhat.com, hare@suse.de, hch@lst.de, yukuai3@huawei.com
Cc: Fengnan Chang <changfengnan@bytedance.com>
References: <20251120031626.92425-1-fengnanchang@gmail.com>
 <20251120031626.92425-3-fengnanchang@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20251120031626.92425-3-fengnanchang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index eed12fab3484..82195f22befd 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4524,7 +4524,12 @@ static void __blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>  		if (hctxs)
>  			memcpy(new_hctxs, hctxs, q->nr_hw_queues *
>  			       sizeof(*hctxs));
> -		q->queue_hw_ctx = new_hctxs;
> +		rcu_assign_pointer(q->queue_hw_ctx, new_hctxs);
> +		/*
> +		 * Make sure reading the old queue_hw_ctx from other
> +		 * context concurrently won't trigger uaf.
> +		 */
> +		synchronize_rcu();
>  		kfree(hctxs);
>  		hctxs = new_hctxs;

Might make sense to use the expedited version here, to avoid odd ball
cases that end up doing this for tons of devices.

> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 80a3f0c2bce7..ccd8c08524a4 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -87,6 +87,17 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *
>  	return q->queue_hw_ctx[q->tag_set->map[type].mq_map[cpu]];
>  }
>  
> +static inline struct blk_mq_hw_ctx *queue_hctx(struct request_queue *q, int id)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +
> +	rcu_read_lock();
> +	hctx = *(rcu_dereference(q->queue_hw_ctx) + id);
> +	rcu_read_unlock();
> +
> +	return hctx;
> +}

I think that'd read a lot better if the type was **hctx and you just
return *hctx instead.

-- 
Jens Axboe
