Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A498554F9A
	for <linux-block@vger.kernel.org>; Mon,  8 Jan 2024 19:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+xjo1wN"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d3ef33e68dso14736315ad.1
        for <linux-block@vger.kernel.org>; Mon, 08 Jan 2024 11:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704741762; x=1705346562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k0da4vV/GMGXTZtLUwCi2abiuYb8GHNe8y83VdpSzlE=;
        b=i+xjo1wN000bdSGN2qV8TUzf5WBwKV49ekZym6My/WVmGmIQzlFquQNWjXbG7hFWqA
         WDRSDiNegQ1l80NBEXQpIjyvUpNmyHnpLDJjH7qs1LP/8qLN4RITOkeDbiMHhJPgUV02
         /gi2Hcw/xXHAZzqASbv3nLqulB4UPXEXbHQAicAMho+SDi1mp9aXbevRwCXkgNucJBZ0
         d48cyRCb9yJZAp3u/4H52a7NIaKN7W5xFoO/sIhS52V5O/or4Qb7RJV+mNOsMQLAbp/j
         yrUopaQLIZ549GrP4TCmQz8FwDyjDok1+0fcszqMXNBi9QKcT/YXwLrTl9QrFHFG/kgX
         1N+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704741762; x=1705346562;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0da4vV/GMGXTZtLUwCi2abiuYb8GHNe8y83VdpSzlE=;
        b=wdHOxFJglTh5wUmyfuSlv4/kOdcT452FaanoYtRE96iTxHj1o9CwJt/dGeUNc4NNvJ
         2lu0WqE78U+ylsiZvcwu1Hh0ch3jUi3UxcH8QJg9ZYYrZweX64LYz6/tyvr/CZNLs7W6
         lHBucruce1O/lxAfsiC2VukULuGrimmM24R02NB9O5Emdgk8dvnYLX4pYuiTL4stprMW
         SA7pBQkKmouBzMQzJmpRRLQU5/psuW5oZrVf1+i3VS/snUE/iO1jgCzXYoutcXOJAEiS
         Cb+OEJB57avzGIPVRk9rqsNO/mHKf8lUpvDy4TArO3buZsqtJ45rxU7rmC3tjZkXkDqn
         8c7w==
X-Gm-Message-State: AOJu0YzTOJSkBXehtS/PyHkV50+S3Xxu2X8FtcEYuZpX8mZFWP+awkq9
	opVVbfPPF9k9/7XJ2+BTdOk=
X-Google-Smtp-Source: AGHT+IE+QKV2cWkMSQNFo8zDnPuKsPQES9lO5ftQjI00JRYWHfb19houpV3uKNA0Cp7m0EIXDTZPyQ==
X-Received: by 2002:a17:902:ea12:b0:1d4:f42:de02 with SMTP id s18-20020a170902ea1200b001d40f42de02mr318201plg.16.1704741761704;
        Mon, 08 Jan 2024 11:22:41 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:fe53:b285:ad53:95e0? ([2620:0:1000:8411:fe53:b285:ad53:95e0])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db8500b001d4c955cc00sm238217pld.271.2024.01.08.11.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 11:22:41 -0800 (PST)
Message-ID: <5c07dc1b-9247-482f-8f38-75e578201f5b@gmail.com>
Date: Mon, 8 Jan 2024 11:22:39 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: make __get_task_ioprio() easier to read
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20240108190113.1264200-1-axboe@kernel.dk>
 <20240108190113.1264200-3-axboe@kernel.dk>
From: Bart Van Assche <bart.vanassche@gmail.com>
In-Reply-To: <20240108190113.1264200-3-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/24 10:59, Jens Axboe wrote:
> We don't need to do any gymnastics if we don't have an io_context
> assigned at all, so just return early with our default priority.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   include/linux/ioprio.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
> index d6a9b5b7ed16..db1249cd9692 100644
> --- a/include/linux/ioprio.h
> +++ b/include/linux/ioprio.h
> @@ -59,13 +59,13 @@ static inline int __get_task_ioprio(struct task_struct *p)
>   	struct io_context *ioc = p->io_context;
>   	int prio;
>   
> +	if (!ioc)
> +		return IOPRIO_DEFAULT;
> +
>   	if (p != current)
>   		lockdep_assert_held(&p->alloc_lock);
> -	if (ioc)
> -		prio = ioc->ioprio;
> -	else
> -		prio = IOPRIO_DEFAULT;
>   
> +	prio = ioc->ioprio;
>   	if (IOPRIO_PRIO_CLASS(prio) == IOPRIO_CLASS_NONE)
>   		prio = IOPRIO_PRIO_VALUE(task_nice_ioclass(p),
>   					 task_nice_ioprio(p));

Shouldn't it be mentioned in the subject that this patch is a performance
optimization? Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
