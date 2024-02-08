Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770B186159
	for <linux-block@vger.kernel.org>; Thu,  8 Feb 2024 17:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414596; cv=none; b=GGyJ7nUMp19LQdWgpLGT3ZLScHURk3zhSOx3ek5MPUkzWheGHU4lS9IbNhVkZs43KeJotdUPoOwpgyVahja8l5fUU7pu8VVrNb8CPztWoZo5JnGruC88fBmvOLGqomIXm9U0fJLD0oD+SFEtGOvVTY8lmWD4pKl+JQYusNmkcOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414596; c=relaxed/simple;
	bh=Avj4yu2MM5ImiuE5+DUJwBTL1QbYr++j2dWiU/mFTlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fDHRDsrafMwDEHri/ZToKMDE6z/zclzAYs3GQGbK3noCDG94veFJUCQd9aw9W95iVLzCAMs9Bjpb4rR6cZkJSmIzyMVUFfD5COWujXmWTtzX+RjOAXYOIrkDv0DEZwJo0Up1l/BbbGFBslC//weTzpbCFb0/v5Kl/Nb48PzieYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BaxpnLem; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BaxpnLem"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso83739f.0
        for <linux-block@vger.kernel.org>; Thu, 08 Feb 2024 09:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707414592; x=1708019392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HdpAkoUbuRshwsWxZMXjJeI3qpV/uwbWvYNJ5S9P1pE=;
        b=BaxpnLembPWt12ftYLHqvAk0BrHduq1mVw3XsT8/dtdM/XrZ2BAHBKVk7+gk/q9329
         CV0QRs5bEVvG1Ma7flVoEb+mNoHMs2lV4COGJK2CN2hyQPkaiUZbSKPZoWFt+xvTw6Go
         Q28R5p0cdBHF/8buaVGnhKhgZC7b4+hkFA114JsjZHd0EPRoGFGcMOYBNX0yx8q4c5As
         1ewtKbNq7wKmK5LC4VMkYZTVEnTp19j94JgH94VqKu0vJx/gy9DDvg4YhbDhKV4E2JGt
         kwb/+VqDSbo+5NvhGl/npRcd4Ny95UAf9nJTtF4xSNZ37uPdM3+asSCHnbDGV9yZ7ypr
         lT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707414592; x=1708019392;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HdpAkoUbuRshwsWxZMXjJeI3qpV/uwbWvYNJ5S9P1pE=;
        b=Qy6WM2uk2vDuxGbTM4fS2Y5qpX1R1izGvzrVOWYd1Mj/jLXXKNwjPt1y8pWW6J+mJ2
         nS/LPHL13WwX/aw2OfL7uahPwhPiWWUO7nE8gOmXsWRc4d4yyKIbFWa6xtqy5HHrDLGj
         OdvZK0jgJDgJP2oXI9aWbx7/wDjSE8FYqHOKMGXAPovrEZ9kpEQXjftdAjYr8z3fozai
         MRhl4C9CqcsYF6DbS2fTwC1Ozj3bMA35X+Wlm4+oDT5KfYbB5YIxYdUhK4+jNJvbtkPa
         T53CW//nTFoiqd+H0YV7Dw7B4IzkOXBbGFtRRC32WImgaYcd2D1WIaUsIuqpnbZoX1/Z
         YjXA==
X-Gm-Message-State: AOJu0YwDbxqeWKRihqZvVTRlTPcYfUmF/bn4dWie3HTeSq6aT2OxP9Lp
	hAPQjcOYTRFaUQauv1oI2IBjz1FoLzCoZ6C5Xb3+g0Yh2yuXg7Z4fSeqdlMu55s=
X-Google-Smtp-Source: AGHT+IEcOIS2ktmvovrkx/0rKPokR8Dm9HGp/TzJdRAeIUJP1AVeLWAtwje8k/ojPzmvwHrtzs5NVA==
X-Received: by 2002:a6b:da0e:0:b0:7c4:1966:63e3 with SMTP id x14-20020a6bda0e000000b007c4196663e3mr293048iob.2.1707414592578;
        Thu, 08 Feb 2024 09:49:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUA7vvqdjyYh4bzD3MfyUvTE54+Jlv9ADT3QZEgGi2S3520wL2MV+lL1jYjuLI+0wKzl8p4F9wdfBXr9uwEs6Xgj+Yio38+hddf/QA/J/GMNmhtuX0QMDLGo2+nKtPYsleQSFl7Pvc6EZgrftXI6rYKb/Ky0DMu72UKB/Ljg2D+LBJ8N4P/ONFreWT1JC2YSIF6kGpFqiHi9RU5MYfSuVNMM9VQrZLvCOB/K6Y6goYsrW6/2nBV4pEbE/sE9XA88ITt5bTHzOgDPxIdDKIDjG9oVROUBjfj8OBD3q+gKplKNmOXIh6QGJSxSfywkWDv2PiHmJS2om1mzF+lAdBUv6en9jOlLqXEsQ==
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t22-20020a02c496000000b004715ce9d44csm395199jam.35.2024.02.08.09.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 09:49:52 -0800 (PST)
Message-ID: <ca00ff75-e98d-4652-9c52-94b2e876901e@kernel.dk>
Date: Thu, 8 Feb 2024 10:49:51 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] block: introducing a bias over deadline's fifo_time
Content-Language: en-US
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Yu Zhao <yuzhao@google.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
References: <20240208093136.178797-1-zhaoyang.huang@unisoc.com>
 <20240208093136.178797-3-zhaoyang.huang@unisoc.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240208093136.178797-3-zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/8/24 2:31 AM, zhaoyang.huang wrote:
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index f958e79277b8..43c08c3d6f18 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -15,6 +15,7 @@
>  #include <linux/compiler.h>
>  #include <linux/rbtree.h>
>  #include <linux/sbitmap.h>
> +#include "../kernel/sched/sched.h"
>  
>  #include <trace/events/block.h>
>  
> @@ -802,6 +803,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  	u8 ioprio_class = IOPRIO_PRIO_CLASS(ioprio);
>  	struct dd_per_prio *per_prio;
>  	enum dd_prio prio;
> +	int fifo_expire;
>  
>  	lockdep_assert_held(&dd->lock);
>  
> @@ -840,7 +842,9 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  		/*
>  		 * set expire time and add to fifo list
>  		 */
> -		rq->fifo_time = jiffies + dd->fifo_expire[data_dir];
> +		fifo_expire = task_is_realtime(current) ? dd->fifo_expire[data_dir] :
> +			CFS_PROPORTION(current, dd->fifo_expire[data_dir]);
> +		rq->fifo_time = jiffies + fifo_expire;
>  		insert_before = &per_prio->fifo_list[data_dir];
>  #ifdef CONFIG_BLK_DEV_ZONED
>  		/*

Hard pass on this blatant layering violation. Just like the priority
changes, this utterly fails to understand how things are properly
designed.

-- 
Jens Axboe

