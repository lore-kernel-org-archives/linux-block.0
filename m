Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88801E48E
	for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 23:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705707349; cv=none; b=Af/DljN/Gx/Zl9ohxQL61aK7l2oDOMgul9x8Z+r9PIwMCusBqyYRMVqKB/62nVv4BSSdLhx0lVt8m6ziIFtb3sgYv0Kv/k9QKE3GABbhGMopGsk6h0TgL9Ma3+8kjDMU78V0+HlK07XGBYqO44sbmzr4WW5K5in0NxliKPqJvKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705707349; c=relaxed/simple;
	bh=zZI/4IyttGnCjQPny8bG/mtfGXbMNHToIB0zc38DIkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TONm9x5mb8PfKw6bs8eujXy08KGBu+RY/g6WO/9uDnqV+bbfJZEqOVez72I4z4eeAMlj0qrOQ8AbZJonoiUL1wtJv6j5SztsO1LpDIoKdY4K2DDk/oRu2/GXjF8PEJNsXHf6nvVZk/nhPYpHxH2O+M5ijJTTBg/UuE0oyL9Dxw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6dbb003be79so1591478b3a.0
        for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 15:35:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705707347; x=1706312147;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BCKjBH8nEVJLv6/ngmOVeZWG5JdXn1id8m8w/drv8C0=;
        b=qIfjlCjqv6v3EpoOOzsVWcjpjI1yZuq2S5kwltsijoS+HPRtgJHdP4TNVrirxBkFT9
         7KEWHgKavbRH2ZwyeF1Vq0nGFRVVIeT4CMAig0/YY+Xp9lGGDJ0dKz2LG6X5NDmeJUE4
         npa6pr+ZFwwHsfWVdr3DYt1PwNB0GwXMBigtljlBs8KvomQx8nIgRpVb7TJsDK7+2xAp
         iVtdUH0XGtiIcyrpvUAaGRKuOTXlaVkR4hcMDHZayWT+Lnpmmld/XbkIXGl/p92h+vvU
         SgblIgm23fFr9zqfKr8EEa5ZoY8B5Ov5txAVFLrz8CbNtMB591/S7xg5QaLWX2R0iPlL
         L7xg==
X-Gm-Message-State: AOJu0YzBLSOk/A8qzh7F2eiSgQYQHVUEM7qzh4Pce1EgKHvjkoi81MyG
	hP7jsYBWqFoGAchd3jhNUEgn6fzN2dmW3rhiRdgnni/YIdTO27iC
X-Google-Smtp-Source: AGHT+IGqD9kgsNzkRv4fRzcmkUIznplqNbCa2y5OTXCAO1c5ekNCbcKz8xHyXYfNJvHc/77HFmuq2g==
X-Received: by 2002:a05:6a20:9288:b0:19a:4ea3:ce79 with SMTP id q8-20020a056a20928800b0019a4ea3ce79mr1875890pzg.58.1705707347036;
        Fri, 19 Jan 2024 15:35:47 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:4855:2a4:21e0:417? ([2620:0:1000:8411:4855:2a4:21e0:417])
        by smtp.gmail.com with ESMTPSA id s10-20020a65644a000000b005ceb4a70483sm3510126pgv.7.2024.01.19.15.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 15:35:46 -0800 (PST)
Message-ID: <beb3f990-93ac-4b34-b928-7f8202d3ba23@acm.org>
Date: Fri, 19 Jan 2024 15:35:44 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] block/mq-deadline: pass in queue directly to
 dd_insert_request()
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20240119160338.1191281-1-axboe@kernel.dk>
 <20240119160338.1191281-2-axboe@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240119160338.1191281-2-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/19/24 08:02, Jens Axboe wrote:
> The hardware queue isn't relevant, deadline only operates on the queue
> itself. Pass in the queue directly rather than the hardware queue, as
> that more clearly explains what is being operated on.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/mq-deadline.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index f958e79277b8..9b7563e9d638 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -792,10 +792,9 @@ static bool dd_bio_merge(struct request_queue *q, struct bio *bio,
>   /*
>    * add rq to rbtree and fifo
>    */
> -static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
> +static void dd_insert_request(struct request_queue *q, struct request *rq,
>   			      blk_insert_t flags, struct list_head *free)
>   {
> -	struct request_queue *q = hctx->queue;
>   	struct deadline_data *dd = q->elevator->elevator_data;
>   	const enum dd_data_dir data_dir = rq_data_dir(rq);
>   	u16 ioprio = req_get_ioprio(rq);
> @@ -875,7 +874,7 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
>   
>   		rq = list_first_entry(list, struct request, queuelist);
>   		list_del_init(&rq->queuelist);
> -		dd_insert_request(hctx, rq, flags, &free);
> +		dd_insert_request(q, rq, flags, &free);
>   	}
>   	spin_unlock(&dd->lock);

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
