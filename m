Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BEC55764
	for <linux-block@vger.kernel.org>; Mon,  8 Jan 2024 19:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso1687440a12.0
        for <linux-block@vger.kernel.org>; Mon, 08 Jan 2024 11:24:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704741898; x=1705346698;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DgcdrMgx1zwBBcH1OirZ6VF4VTdQz9xHnLrUhLWCxBI=;
        b=BLX/RHAjMtN5MBPdgkG0oSwA+S91XkBqY7Jl1v5rYJhc3VFbx4nhO/AlMdFgvoSjdJ
         GBa5cP9w1+7SDpnMQ5N8BhTbbi5XzAD8vbdGQtvauWR6tsSynl805UDU5AYgTPxZx6+j
         M1eBHrPYcYlsaMKa+9rZUOl7jzyBr3ZlKxuohUumwf8GECiq8vdFfIIdn/UZGq8XA9jz
         cpSTnnXJIOePGwrIcG9/LgKWcnYdjpwUsUh0I/6lWHot0vlDJsdzqXvwO8Qjk3i4abj5
         A9UY/sIdh7mxPJG1Ynvl1r9yNRj25Kpdnt/4i1pj0eq8QF019xNSwZEb1eFP7OQPTton
         smAA==
X-Gm-Message-State: AOJu0YyWtT2XGMANnrdqIfNlZSN+xhXO51+QgnNLI7El9ilxtl5lvIna
	gg3vIjgDzUglRbb1r0Yb0OpSClIj1OI=
X-Google-Smtp-Source: AGHT+IFxLWF93nZ6ClFZr68J/q8mhKNYZjeb1lWaO4i5CpvNZ1xqZnwjV7rMXoaQGKsnPMHg68j/Vw==
X-Received: by 2002:a05:6a20:429c:b0:199:e2f5:72 with SMTP id o28-20020a056a20429c00b00199e2f50072mr577966pzj.44.1704741897555;
        Mon, 08 Jan 2024 11:24:57 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:fe53:b285:ad53:95e0? ([2620:0:1000:8411:fe53:b285:ad53:95e0])
        by smtp.gmail.com with ESMTPSA id 30-20020a630f5e000000b005ceb4a6d72bsm212745pgp.65.2024.01.08.11.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 11:24:56 -0800 (PST)
Message-ID: <a7c35161-45af-4f57-bedf-7a28674fb39f@acm.org>
Date: Mon, 8 Jan 2024 11:24:56 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: move __get_task_ioprio() into header file
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20240108190113.1264200-1-axboe@kernel.dk>
 <20240108190113.1264200-2-axboe@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240108190113.1264200-2-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/24 10:59, Jens Axboe wrote:
> We call this once per IO, which can be millions of times per second.
> Since nobody really uses io priorities, or at least it isn't very
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

We have plans to set an I/O priority for most Android processes in the
near future. According to what Damien wrote on linux-block, there is
probably a significant number of hard disks for which I/O priority is
configured.

> common, this is all wasted time and can amount to as much as 3% of
> the total kernel time.

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

