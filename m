Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2881F9424
	for <linux-block@vger.kernel.org>; Mon, 21 Oct 2024 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518325; cv=none; b=SFuMK+/+qeosrCNX+d6tz5KcvrtJLZn/uxyiBMW81Y6JCL43ETj144up9NjYVXr7mKj7rJM1PauvTi01YIKJD97RVdbaTF1zrrMn3F/O0PbhC3d9d2JUle8BP/QBjtaqbJBBFi4SQyBPgEcaKNarcay4MlABXyXf3RNBHuAj6dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518325; c=relaxed/simple;
	bh=t1He/A5hzUmgmTjzLbYbSEEOBFdMRWGt4pzi6nDCHLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bsH7qy5I2XseGAlAdwWwUuYluxw7AvO32G99ADM/C1kMOmp/uwHvgIkR4nqqJ10sbH28gSCSn5eKdVxlk4NkDDq8/Doo3pZHRbCGqQADhD0GE6f00CF3oD8CTI7GfYGpWdDEXDNFGS2g1QPWyUbb6ayBarfHo8h33qFMdl4CwCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FIuQo+VZ; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FIuQo+VZ"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-83ace760016so42790439f.1
        for <linux-block@vger.kernel.org>; Mon, 21 Oct 2024 06:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729518321; x=1730123121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z5DjyIFnxBJCDtMArSsp9CEXODWyJb8IyJZS+DJGzds=;
        b=FIuQo+VZY/Z4is57G2ro8JA5KlMlvQXCHzaU3k1M+2a6ywCKqF7KXUsngF50Ll8DM2
         87DhJJRRx1vYc/7ZkK44NGDT39mSnU6ScikdiGzlcboHvAvA29scFfYB8WNQqbyDm2AF
         i7GiRWz7Hq+tzhhsukksBHkhbdKRHIxIWoTbnxz1c3wxG+4o0S22LzuAQKJLMVipc9nc
         RUDirpMCtiKJKu4uXITp7PoO5GyfZKhP/fQ1OGvuZMfJof+meQo5l9U6rJjRpwRWGEVd
         q5UDfFb8yQ+xt3PTkTWmDx579Hsj1DLYTlo2MM2v3+xtPCfF9SfoMQHlgwH2jqlFjIOw
         VIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729518321; x=1730123121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5DjyIFnxBJCDtMArSsp9CEXODWyJb8IyJZS+DJGzds=;
        b=nKyOo1ySnQ4eLPrWD4qYScvctir4ZdP1g/9cTlVhYx5SdoXNMR63jqsMr3w0nl4GdE
         H3IJDhm2HyreVUEytpGrYs10kdmM5AtzqvJc/MUeq22GJX8DqY3Bt9F5ad8x5X48Eh8K
         +st6WtDPmNPUX8HxZ8ttNo+smYkztOUORzGKBNl3+iyfzhtjf1Mnc6TIvZEIMrJW+Yx2
         w2zWh+fTa7psVAwDqPWgfa2GDs/DX3F1F51+yZHyHFvhmTVz/hffIyFP3MyVSux/aOIs
         ldaLtj/+sSu6LTyodkIRMjcJigaRWuYTtFMQ+HHFcZvw/cUSonKoX/T/TG9ciMPDVK4S
         o4Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXQbIzkjEd+tcfGUMt0GhirA++opQMZLYx39GzHQkEqYW0KD7FE+XGMtZRQy4jRf7K8Im5RBRRvL4vs6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn7TozVPD4BXBURNMKPwV21CzqhQIu3Jo8HPAVSjddzRPT0Rs7
	1bFhHrvJucm6Zf74T7pVtQfuLQWuJnIwTVBaQWClkE0dm8fzLJaprgyZojmesAo=
X-Google-Smtp-Source: AGHT+IGaZ2Kxhv2AHL9JRdXlTyGbBEnLcVsFhhuxb4rR6JZYfDWlpqBSZi+dbUjB6QvmlcsIpp9gWA==
X-Received: by 2002:a05:6e02:1886:b0:3a0:ce5a:1817 with SMTP id e9e14a558f8ab-3a3e51391femr111400275ab.0.1729518320461;
        Mon, 21 Oct 2024 06:45:20 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a6092fbsm957268173.119.2024.10.21.06.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 06:45:19 -0700 (PDT)
Message-ID: <ab3720ec-b12b-4c0a-8e56-930753c709fd@kernel.dk>
Date: Mon, 21 Oct 2024 07:45:19 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: remove redundant explicit memory barrier from
 rq_qos waiter and waker
To: Muchun Song <songmuchun@bytedance.com>
Cc: josef@toxicpanda.com, oleg@redhat.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, muchun.song@linux.dev,
 Omar Sandoval <osandov@osandov.com>
References: <20241021085251.73353-1-songmuchun@bytedance.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241021085251.73353-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/24 2:52 AM, Muchun Song wrote:
> The memory barriers in list_del_init_careful() and list_empty_careful()
> in pairs already handle the proper ordering between data.got_token
> and data.wq.entry. So remove the redundant explicit barriers. And also
> change a "break" statement to "return" to avoid redundant calling of
> finish_wait().

Not sure why you didn't CC Omar on this one, as he literally just last
week fixed an issue related to this.

> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  block/blk-rq-qos.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> index dc510f493ba57..9b0aa7dd6779f 100644
> --- a/block/blk-rq-qos.c
> +++ b/block/blk-rq-qos.c
> @@ -218,7 +218,6 @@ static int rq_qos_wake_function(struct wait_queue_entry *curr,
>  		return -1;
>  
>  	data->got_token = true;
> -	smp_wmb();
>  	wake_up_process(data->task);
>  	list_del_init_careful(&curr->entry);
>  	return 1;
> @@ -274,10 +273,9 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
>  			 * which means we now have two. Put our local token
>  			 * and wake anyone else potentially waiting for one.
>  			 */
> -			smp_rmb();
>  			if (data.got_token)
>  				cleanup_cb(rqw, private_data);
> -			break;
> +			return;
>  		}
>  		io_schedule();
>  		has_sleeper = true;


-- 
Jens Axboe

