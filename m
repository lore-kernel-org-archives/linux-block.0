Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D5E2D607
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705602266; cv=none; b=b0/HjmA/dsCU+IultzjzA2uWqCVfMqw9TErPPBZywHBBVjZLR8izTQo8ykRl9PaDs17S7tKLHEFvLQRR9BK2X0mo1iTFThxYIU9AgNQPEdRTFqxd+Us80yFDdSug1LtbHP9WoA7oqlrxeo7Q1yJu5cRVSYuzPtKG2/xF/jHqu88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705602266; c=relaxed/simple;
	bh=uZXrXS6uDxOcH2u8B8OLpjyX5hBR9Q5EppPtsJ+zapM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LHX5UlZtUW5pyTx/4URVsuzL9ZTiSc3F/1aZmcm+2O1G4aQMwts3Yi/3GQ0Ri2T0t8jEFeop8BvxjjWvWXyLwwTTgQOagqJB8B11opnIWPTTWo5ytWNeccsNlH77pVQ6IvgqK4GtK/b36Wc+hgtBUBuhzV117A3KM+1tvv+YkcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cfaf7ef393so303553a12.3
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 10:24:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705602265; x=1706207065;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FPIU9d5BAOvPSFfQnC+vy5K6NMLMgKqb8AC9RSvoshg=;
        b=gPuk94bn6XPmT5ArppthqKgOluKpZ5Ymu/Nr7aDDjNn8ZNr7qffsyQHkQr1wIqvwzt
         KDnXyDcKCdkpXSEU3EllSTjS1X49YZZba1dw1yElIfFOtELN7jgdgUPm4s52OFsVDrGu
         Ejq6fNXC/i2WW/ct95QCYsBmhLv2pmRsk1cfgAkxRBqap95KGTJl4O0GcVvcHKZ0b73m
         zHuyBHg93UQuFZ32TTGNv0/dOCFxf9is1Eh7fKaHSWXLPWYX1NHYAJS/W8SXDuu51bXp
         fGYe7d51o4+y3+IzGZVFeXqEIU2k5rj0LTTp6w7+R34cAm6UXSzfZKo0Mm+EpzHQqPUL
         3tiA==
X-Gm-Message-State: AOJu0YzdYdYqqgP1JzcpjeCdBp9j1bxKktUpn28SGslvcZEKIFOlhzkw
	1O+ThBWTm20qr0+g2jLaOw+/JVIQ3kgvQhxV9NRRpWMcapuD+MFRO7EaC2qK
X-Google-Smtp-Source: AGHT+IGFnlpMnOjshwBJUgwsT81Mu63XGqweHuI+JCaRn0sqQvtdLb0EGC1pZCNEXqI0/L8SE9M+zw==
X-Received: by 2002:a05:6a20:258f:b0:19b:90d8:2a17 with SMTP id k15-20020a056a20258f00b0019b90d82a17mr1322398pzd.28.1705602264646;
        Thu, 18 Jan 2024 10:24:24 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:718b:ab80:1dc2:cbee? ([2620:0:1000:8411:718b:ab80:1dc2:cbee])
        by smtp.gmail.com with ESMTPSA id du11-20020a056a002b4b00b006d999f4a3c0sm3621268pfb.152.2024.01.18.10.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 10:24:23 -0800 (PST)
Message-ID: <d8485e78-5cf5-47c1-89d4-89f52ba7149f@acm.org>
Date: Thu, 18 Jan 2024 10:24:22 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block/mq-deadline: serialize request dispatching
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20240118180541.930783-1-axboe@kernel.dk>
 <20240118180541.930783-2-axboe@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240118180541.930783-2-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/18/24 10:04, Jens Axboe wrote:
> If we're entering request dispatch but someone else is already
> dispatching, then just skip this dispatch. We know IO is inflight and
> this will trigger another dispatch event for any completion. This will
> potentially cause slightly lower queue depth for contended cases, but
> those are slowed down anyway and this should not cause an issue.

Shouldn't a performance optimization patch include numbers that show by
how much that patch improves the performance of different workloads?

>   struct deadline_data {
>   	/*
>   	 * run time data
>   	 */
> +	struct {
> +		spinlock_t lock;
> +		spinlock_t zone_lock;
> +	} ____cacheline_aligned_in_smp;

Is ____cacheline_aligned_in_smp useful here? struct deadline_data
is not embedded in any other data structure but is allocated with 
kzalloc_node().

> +	/*
> +	 * If someone else is already dispatching, skip this one. This will
> +	 * defer the next dispatch event to when something completes, and could
> +	 * potentially lower the queue depth for contended cases.
> +	 */
> +	if (test_bit(DD_DISPATCHING, &dd->run_state) ||
> +	    test_and_set_bit(DD_DISPATCHING, &dd->run_state))
> +		return NULL;
> +

The above code behaves similar to spin_trylock(). Has it been considered 
to use spin_trylock() instead?

Thanks,

Bart.
