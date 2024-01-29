Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC9F657C4
	for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537336; cv=none; b=Mnt2mYbnal1Vdexo1TERj91mhJCEom5HV2ydKDJiaqpXqUTUQac3BZxWWE0IjDY8dfunOzJvCOaxVOugT7zNATSLdDN+pzm4FMubZ3jU/LoOLzpaPkgB9RLQdMlmM9G2yJrwodx9c35xDhxFS5O2mmpGNETgdkmIGhm6Xq9gj9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537336; c=relaxed/simple;
	bh=YaeXcqiP87h1vlZY4F77PCsMzchkACuuqInbpx8DQqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WVdNgjVWoI9QB20CAJRXBfdHOv+hro4w2u2aSq8fVMUhABUKNFFLh+PAqlkjBwgiRqD04K7IQgqYb4jAi0dWZSMSU5e+ijJCUlAOnJeRgIbZbvDECah0odiMeQwKri7ptnNXZLRkg+zgKy2GcaT6ugOsTPzW6TudS3dmv9SK+kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Tna1jScl; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Tna1jScl"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cfcf509fbdso728509a12.1
        for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 06:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706537334; x=1707142134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G9KKHKqHeKTxqmk7e3IjR8WXdYGcVRsY/057RPL3b2E=;
        b=Tna1jSclRBtBeCSEPsL8tYix1O2o7V3s91xahxK0Hm2LPGOgOqQ2bQgYxSkdKTii37
         l/KK9WnUo8pztFjCrQDC3ZwW54Y0ItTmsu1d2KBBb5PfUXFOnOpiPgaq5SogoAEXhSmx
         85bFaC25I/xtZBzhx7DetqcFeMdvq7KTSNAud0AEsJ4i18QKr6qHhXb58ECARmP+PePY
         XY7ZRUaZhngiqzUFW4bUnSBxqCIQdDAjt4MqCD4Mv5pG1c5khXJPQ+OrUUMncZxj19NY
         bLV7RUxgzgP35EcauKYOu5/GDmjv778DAYvQx8R2XxvejLQcRl0eusbiiM6+DyN05Hi2
         ELnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706537334; x=1707142134;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9KKHKqHeKTxqmk7e3IjR8WXdYGcVRsY/057RPL3b2E=;
        b=dSVQxO+nBu7/NZQPPKOANMAZr0YwrLmrxlRfV7mWHTz3kyqCSlp8CAqRfGPRm3NxKX
         GIi9sD0yvqnUQUanWhpJAUSutwsP0+xaFKlYtjQjar9TkSdsS/vcHWdRVRfHnP4bC2CA
         13wp2i7r/N5QjKqr2IVS77ITnQc6bt8vB2inbSmZiyIwysHGR7QZ+5EYzmYV2DMFyGUy
         wduZsZ0VUFSZ3VHwwhSCvk570WO1yWlEfOwNmQybIdc0MdoAi3ol+gXFN/gvM7lcGW7G
         MGqKYM1DqVx4giu3wgJZ0f2sJqgqjDnZaiaC9/EH6Mp8OoylCZyp/EzVgxo2znTU0Gcj
         w5mw==
X-Forwarded-Encrypted: i=0; AJvYcCV+8fG8nsKo+liwb36uCbJdhjLl/gREC1gE4uvJjRRGwtPcLEAStFkghki9YJrVQFbjIT0r5n9yJBc1vgRk5G7PjiTh2FIe83lDc8k=
X-Gm-Message-State: AOJu0Yz1PRmGVox9Rcnall0S1ZJH8+ty7Albj0RkwhQ/7VneLe97qghX
	Jw+hlmaUfDQsR5Ie0GMRae9wJFfsYdpZpzzNlJX4OQhCUywGMH3gXJU+zYwRYeruVsRtQOZzP0A
	JS9I=
X-Google-Smtp-Source: AGHT+IGH+XWLsmo2XHMBmmKJn+U1yqwL6cJjbaoQYMPoY31pfBuu5mVY/Ql6LuenCe5TejSan66Z/A==
X-Received: by 2002:a05:6a21:99a2:b0:19c:9b53:2ed8 with SMTP id ve34-20020a056a2199a200b0019c9b532ed8mr8839902pzb.1.1706537334409;
        Mon, 29 Jan 2024 06:08:54 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id y12-20020a170903010c00b001d72f06931bsm2382522plc.186.2024.01.29.06.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 06:08:53 -0800 (PST)
Message-ID: <ca969732-5d80-458c-b2dc-b5e65629e64b@kernel.dk>
Date: Mon, 29 Jan 2024 07:08:52 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] block: update cached timestamp post
 schedule/preemption
Content-Language: en-US
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20240126213827.2757115-1-axboe@kernel.dk>
 <20240126213827.2757115-5-axboe@kernel.dk>
 <9e13afd4-d073-4822-92ff-936788f0c2a1@wdc.com>
 <1b0c9f7f-9b1b-484b-a9fb-bf2c42d9a18d@kernel.dk>
 <c2cad14a-6add-4301-83b1-be40e48c0daf@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <c2cad14a-6add-4301-83b1-be40e48c0daf@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/24 7:06 AM, Johannes Thumshirn wrote:
> On 29.01.24 15:02, Jens Axboe wrote:
>> On 1/29/24 1:01 AM, Johannes Thumshirn wrote:
>>> On 26.01.24 22:39, Jens Axboe wrote:
>>>>    static void sched_update_worker(struct task_struct *tsk)
>>>>    {
>>>> -	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
>>>> +	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER | PF_BLOCK_TS)) {
>>>> +		if (tsk->flags & PF_BLOCK_TS)
>>>> +			blk_plug_invalidate_ts(tsk);
>>>>    		if (tsk->flags & PF_WQ_WORKER)
>>>>    			wq_worker_running(tsk);
>>>> -		else
>>>> +		else if (tsk->flags & PF_IO_WORKER)
>>>>    			io_wq_worker_running(tsk);
>>>>    	}
>>>>    }
>>>
>>>
>>> Why the nested if? Isn't that more readable:
>>
>> It's so that we can keep it at a single branch for the fast case of none
>> of them being true, which is also how it was done before this change.
>> This one just adds one more flag to check. With your change, it's 3
>> branches instead of one for the fast case.
>>
> 
> Although I don't really have hard feelings for it, that could be solved 
> as well:
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9116bcc90346..74beb0126da6 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6787,12 +6787,12 @@ static inline void sched_submit_work(struct
> task_struct *tsk)
> 
>    static void sched_update_worker(struct task_struct *tsk)
>    {
> -       if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
> -               if (tsk->flags & PF_WQ_WORKER)
> -                       wq_worker_running(tsk);
> -               else
> -                       io_wq_worker_running(tsk);
> -       }
> +	if (tsk->flags & !(PF_WQ_WORKER | PF_IO_WORKER | PF_BLOCK_TS))
> +		return;

Don't think that'd work :-)

> +       if (tsk->flags & PF_BLOCK_TS)
> +               blk_plug_invalidate_ts(tsk);
> +       if (tsk->flags & PF_WQ_WORKER)
> +               wq_worker_running(tsk);
> +       else if (tsk->flags & PF_IO_WORKER)
> +               io_wq_worker_running(tsk);
>    }
> 
> But yep, that's bikeshedding I admit

But agree, it'd accomplish the same. The patch is cleaner just keeping
the existing setup, however, rather than rewrite it like the above.

-- 
Jens Axboe

