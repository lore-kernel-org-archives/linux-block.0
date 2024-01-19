Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61AC58ACF
	for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 23:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705706684; cv=none; b=BiL8VsbgSCnvLH5dbfGxsocg6+ZcsH2cBBsjb92qpnbjMePOPBns73/w+tqrMapw6pwRMTxPA50ATRAVRBtyhp67nPWsjsXrt9H21qk27fbErM0K7A4L4Yo8frusCnLGCNF8ugze4moDHBqcBqHSFEg2NU9J+nIEQu/5Q8zSGpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705706684; c=relaxed/simple;
	bh=s6//0CcCgupY8f+IfWIV5xakaGX6WjQp8sjTX0c9kmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A+avBtgDTCOJ5GrAwc3zRQI9j1WcZUvYzSZqZ75OsILAPCUAj+HfHKn1aIq6zADW0m5tDCHrDLs8p86D5UipWZynannKZ6ltqjwOWokT1XgDov4WEl79ZnOOVy6xdDXhKb2MR562mh0SSdt3V4qWt3ilZzCij33Nibo/jEJ/i2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso943573a12.1
        for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 15:24:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705706682; x=1706311482;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2l19R9M1hbLsTX5rO1SBIYL4vdqAjBR6wxU2gGcWbcs=;
        b=V/N4eMIr7FPlpw3K8rpDS1MDaCLVn0f/Nb6r5g/qDlx3bqBd8c1Ydm8yw0uOK6j7o+
         aY2LFJlI6DPhbGKx1maY7DI1ChFNbC/bcVTX6iIXgl8sGmT51ajyf51ADXQurIZhEbxu
         H5wydQr/Dk5pCAVgL5QcY3oa1Oc3QG5mAs8k8isne4wujkALEsh1y3jBs1qDCYiiQhPO
         f+pa6rJZKvBCqrwiotNEeIfw8TBBo/6B2+NVgsNknCZM9lW10YQSnj0Sdr1FzxHGHXRF
         fEmAoTc3lyL8MtTsKu9HT5XvEKlM02LBahMAfiXWV4SUc8cN81uQV5qLSUNtQ6QcxXOK
         p/ow==
X-Gm-Message-State: AOJu0Yx8gkZLJnSmMQEdJCXFIFRe2y/yZrFc5Z0yBAnKfBVTBFolqB0p
	WJsvahGO2vBazYnnzLXg88WKgL8cAOaPMv8AEoAjUXWDu6OEpNrwcLQV7UKL
X-Google-Smtp-Source: AGHT+IHjUHHDabSj7TRoozjBe6a2zoS9eRlsb5DuitqsL2Q5P+pNtXq+tjtL1pcnz+57kzCwXY+RIg==
X-Received: by 2002:a17:902:c94f:b0:1d6:f4a4:5dc5 with SMTP id i15-20020a170902c94f00b001d6f4a45dc5mr771087pla.39.1705706682060;
        Fri, 19 Jan 2024 15:24:42 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:4855:2a4:21e0:417? ([2620:0:1000:8411:4855:2a4:21e0:417])
        by smtp.gmail.com with ESMTPSA id g8-20020a170902740800b001d714ccf7b3sm2363174pll.180.2024.01.19.15.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 15:24:41 -0800 (PST)
Message-ID: <711e450e-e8ef-40b0-a519-dba510bffa86@acm.org>
Date: Fri, 19 Jan 2024 15:24:40 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] block/mq-deadline: serialize request dispatching
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20240119160338.1191281-1-axboe@kernel.dk>
 <20240119160338.1191281-3-axboe@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240119160338.1191281-3-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/19/24 08:02, Jens Axboe wrote:
> +	/*
> +	 * If someone else is already dispatching, skip this one. This will
> +	 * defer the next dispatch event to when something completes, and could
> +	 * potentially lower the queue depth for contended cases.
> +	 *
> +	 * See the logic in blk_mq_do_dispatch_sched(), which loops and
> +	 * retries if nothing is dispatched.
> +	 */
> +	if (test_bit(DD_DISPATCHING, &dd->run_state) ||
> +	    test_and_set_bit(DD_DISPATCHING, &dd->run_state))
> +		return NULL;
> +
>   	spin_lock(&dd->lock);
>   	rq = dd_dispatch_prio_aged_requests(dd, now);
>   	if (rq)
> @@ -616,6 +635,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>   	}
>   
>   unlock:
> +	clear_bit(DD_DISPATCHING, &dd->run_state);
>   	spin_unlock(&dd->lock);

 From Documentation/memory-barriers.txt: "These are also used for atomic RMW
bitop functions that do not imply a memory barrier (such as set_bit and
clear_bit)." Does this mean that CPUs with a weak memory model (e.g. ARM)
are allowed to execute the clear_bit() call earlier than where it occurs in
the code? I think that spin_trylock() has "acquire" semantics and also that
"spin_unlock()" has release semantics. While a CPU is allowed to execute
clear_bit() before the memory operations that come before it, I don't think
that is the case for spin_unlock(). See also
tools/memory-model/Documentation/locking.txt.

Thanks,

Bart.
