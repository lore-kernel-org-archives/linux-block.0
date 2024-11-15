Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29431DA23
	for <linux-block@vger.kernel.org>; Fri, 15 Nov 2024 20:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701800; cv=none; b=gfF3Bd+n24SxEcrBtbW4Iouwv4vCZTGyMrt2oikbs8w47011VB1ATMmCLtuPrplc+vsFAz9qbnULjvcI7BRqhWxm3jadyA+he6SeqSTUi8qVgYQk0j9jne3Lvrl7HpWei1R0QPpExDqy2jTYmVpEyaeRWPmROYbek73nM3gT2cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701800; c=relaxed/simple;
	bh=1SznUmdqtZegKerQ3VgWTpXRnwOhIQ/2Dr8SUd0yV3Y=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=knDVBC8Eofk8YMswhICyXlLxwhM4V/lY8YTEhiIietzYtMzNIw3BIsWAeUDpBrYlhJ8n/g65AOuur5GOlztep6mH7PQlNBaMfEb6LE4UFp8y+3tVXkNPlQq91ZmlzqkwxjBmUDIbwVb6uhFoDzuTXLtpuIn/KW4VojXCMMF8cag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g7TWOFWN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7TWOFWN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731701797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47jct9np3l3LaIFZ4OXk56isjcp/0L3e+wDt5EGa+/8=;
	b=g7TWOFWNoaijwH40IQkIGe3wTTyZVRVKD+PnsPlpNZK8LNOGKFYeibeVcm6CWUfdbr1jMc
	+RGMFcRN02DhVbTrqiW0LiiMfkaq0zohrZHf44kCJVZRO92831HFrwSaWicKjvqBDCBxA7
	hIhb+6BsRhJqkbc4G8t3zpM1zhFsDNA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-8uRbFeNrN9Gw9mTTSO9x_A-1; Fri, 15 Nov 2024 15:16:36 -0500
X-MC-Unique: 8uRbFeNrN9Gw9mTTSO9x_A-1
X-Mimecast-MFC-AGG-ID: 8uRbFeNrN9Gw9mTTSO9x_A
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4615d80492eso28349031cf.1
        for <linux-block@vger.kernel.org>; Fri, 15 Nov 2024 12:16:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731701795; x=1732306595;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47jct9np3l3LaIFZ4OXk56isjcp/0L3e+wDt5EGa+/8=;
        b=ZjY2oTIpP2Mm5AAfBykyZPyyzQPS6zXBO79y6Biel4l1QZhzJQeNR/j+h3Lt958z5K
         KCOWVIuhHqKzqjf6jw4Bxe0g565LlRF8fEj3JxI3XuIzDsgR9lCYUWpQQ/kxD+2FFNYx
         r8GMUIJhTSrM91J92QdojUEEl17dIFwZggnxhm/rrCRzxP7oRg0no29jO/eMJCA5JLbs
         dabEq7mzViI5wyXIwWogFriKgD8cEib28VxqpwpHMdRVWTdp6tY34jDlTaD3mDCbpcjl
         kB8EBo1JMLMfNAuRVH7h3YxW1k/YyE+w0wPoZm9VoYrvQsA0EkLM+iGMr3GX7puRqDc9
         Ce0g==
X-Forwarded-Encrypted: i=1; AJvYcCX1Oku/YkupQwCeA2jhzHc6VvVfKX2Yr6ni2JWc/vkhsQGt41qL8iOmcaayHl3FwizPhoU7KlCAiPYAfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzD+NhQofseHMBzmSzwJ1Hv16obrh17Dw6svFnqEcWpTPv26IU/
	LO/L8CwpOZlKonj8G1WrdIQWuJK4vBH688wN5j03O+T91Qm0EIwBrVoXH3br9zM/O73nG+FLcks
	T0PHgdGV3EXOY2jhPc5lCldsbr7cAqOxu9+USMTyHwN/ehMZjr5ouofa8BFaJ
X-Received: by 2002:a05:622a:298d:b0:458:4ce6:5874 with SMTP id d75a77b69052e-46363e100c6mr44684171cf.21.1731701795698;
        Fri, 15 Nov 2024 12:16:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERnY+JbNXc4WeIlKHasy1jkDmzupHTdQb4rkdAIssWtSl07qv5EwwZHB2cPIgwgHVNBb/tLA==
X-Received: by 2002:a05:622a:298d:b0:458:4ce6:5874 with SMTP id d75a77b69052e-46363e100c6mr44683821cf.21.1731701795305;
        Fri, 15 Nov 2024 12:16:35 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635a9cc353sm23604461cf.18.2024.11.15.12.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 12:16:34 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a840176f-2a46-4a2f-b48f-9eab40e542f9@redhat.com>
Date: Fri, 15 Nov 2024 15:16:33 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] blk-mq: isolate CPUs from hctx
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Costa Shulyupin <costa.shul@redhat.com>
Cc: ming.lei@redhat.com, Jens Axboe <axboe@kernel.dk>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
References: <20241108054831.2094883-3-costa.shul@redhat.com>
 <qlq56cpm5enxoevqstziz7hxp5lqgs74zl2ohv4shynasxuho6@xb5hk5cunhfn>
Content-Language: en-US
In-Reply-To: <qlq56cpm5enxoevqstziz7hxp5lqgs74zl2ohv4shynasxuho6@xb5hk5cunhfn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/15/24 10:45 AM, Michal Koutný wrote:
> Hello.
>
> On Fri, Nov 08, 2024 at 07:48:30AM GMT, Costa Shulyupin <costa.shul@redhat.com> wrote:
>> Cgroups allow configuring isolated_cpus at runtime.
>> However, blk-mq may still use managed interrupts on the
>> newly isolated CPUs.
>>
>> Rebuild hctx->cpumask considering isolated CPUs to avoid
>> managed interrupts on those CPUs and reclaim non-isolated ones.
>>
>> The patch is based on
>> isolation: Exclude dynamically isolated CPUs from housekeeping masks:
>> https://lore.kernel.org/lkml/20240821142312.236970-1-longman@redhat.com/
> Even based on that this seems incomplete to me the CPUs that are part of
> isolcpus mask on boot time won't be excluded from this?
> IOW, isolating CPUs from blk_mq_hw_ctx would only be possible via cpuset
> but not "statically" throught the cmdline option, or would it?

The cpuset had already been changed to take note of the statically 
isolated CPUs and included them in its consideration. They are recorded 
in the boot_hk_cpus mask. It relies on the fact that most users will set 
both nohz_full and isolcpus boot parameters. If only nohz_full is set 
without isolcpus, it will not be recorded.

Cheers,
Longman


