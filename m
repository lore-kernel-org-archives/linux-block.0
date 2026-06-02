Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9F92EBB84
	for <linux-block@vger.kernel.org>; Tue,  2 Jun 2026 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780406764; cv=none; b=jtKmHwTy88VdIq0hIkAwnYIjDfivOV5kRW3amjoBNoQaRQxbwwZs7OwWLNiJXgkLdHD48sYoPqwkEBoYUOW1V6gwSk8Pg6XsE2IRoVqWtilewBWNMwkxMrC0BjlYunrWHSOUE60auOfwO1w8csqleDGQKuXS1wu0Iol1K51lScQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780406764; c=relaxed/simple;
	bh=DjJh5Vz+DIpIxNj9vIl6A6fILvuSHXlULnA3zQxPSvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QN6+wX2LPLQK+nsi0OeRl0TabChOMsyVW2VI0pnVW8Tz16YRCW1W4XqTI6njRMKGvmRRxdf4vijsHParLj70LME/n19Dreu3n5f/k4RmrTAS5LIBXCBuxsGJMb6VeVGb8BQ0tMCzxeXdii7/AsrpJ7Xnv1Rz0u6JiBTmDzkX2Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=CJASIm/I; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="CJASIm/I"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e6dcad6018so321974a34.3
        for <linux-block@vger.kernel.org>; Tue, 02 Jun 2026 06:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780406761; x=1781011561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BrRkTKsR9LVAlCmXEY3FI1B5R324cdtBBFgVNnHPDbo=;
        b=CJASIm/I+y0b4wGXxdV0q8XTNgm4QesUzTwDKa7KvQjHgQlVoc5QiNZhoCg9pzj71T
         /FoCkcsol2VqODVjKfQvxKqGQFDPVB+CTT7gXM39cdI/o+WtdcrQ9cvGs8Ndefladeyx
         vdzYenABNxFacMduSMHypAJZC4BmH4QkBo0OASYrMbx3EpKfTHz1TFcvQzmYXtynDXgV
         ZKxDzhMTuG0nCxgUvf3j7J/cwTcIguDrYu1uPTLjCr818ahgdgQFSAO20sLPe0m1luFV
         l6jRofc/vqqMVM/Y4Z8ColJR0SK/j32eplAI/s45Q3yoTG2a36V5+LxI2fUUeUnBGNCH
         bCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780406761; x=1781011561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BrRkTKsR9LVAlCmXEY3FI1B5R324cdtBBFgVNnHPDbo=;
        b=oYpyNCPbdZLYf0707gJI8nBcoyvp7vtvISkMJg3MB2bTv7ouhmLlSNbRo3kdy/Calv
         cbLrU/ToDwJ5h5hiBYC1+YVJvIfR/MTl1r+nfba8uYHdOQOEmtRiLenSqRgrplmN4dyo
         yd42touzPTrBDdKfzMrUv+gX7d6n6qk0mscP5LeCsh+wP3aBC9ch1SLmAQQgCZKP7COc
         cr4Al2TLpwgNofciazmuu292uqiNzuAha4+Q8bGkZZ298wdWDANEuwChq21u/u0645/c
         jPlYZjXkzsNe3E3umyznXU7+0ySqLDNWi9xn1sTrCP2yYF7fBZT9JFc1g/cjPwMWjSim
         Q2Kw==
X-Gm-Message-State: AOJu0YxqhSkOZb9vmekoP3KFUu9aMdqDEhRgOe6jYaKhZMEyImXpabdg
	1vn01sPmAPjoSblafdYT596jXQtRhfPNtIgDJPsWuSIpGHlqIy0TOCH5LSJt62+oQ4g=
X-Gm-Gg: Acq92OFavb2xeux+QPufONRdBUxV/NxkVLzrM0nPZBil0j923D7RkAHRk2zP7TZd4oF
	7PuAvgqAiSnxrPBSkp/dV3AOr8nbeN0D1TsSgLut1NhIoSS/rFeVj/TGXWRNSF9V2xQYDeXULsN
	29Yhf2BejvDfHicXnOmRPm4Qfc5cbksf/PzBChjiPENXPmhbvYmsAk8i4l+okArnsR4iGwvvKdR
	6FP5V8+6vXdfxmz47Q4LHH3zBkGKIGBpL4nyXamqW53u+WXFTkuqO/7GRRFRaF/bLS5I/NNv92j
	fKTKCLGISWFyrETu7+ip16aJ/G9vOoqLM0MHPBgrGEWJThcy72k2LePYSaLs6z5q7H49ODHo/EQ
	eaB09bPh2LURye6Y+/psMXB6fYytb5vqcpPx65HJPOvAY6fpgZQPkrnSlBWZDgMGpAip6OwuWPG
	CDKIZyPoUIb5+jpiPmNhHU/ru28rpC8mjUn5gBhFgR1T5l70JDegXyni+NHh1dQ5St58X0ij3hf
	8o5/GhSflHKNHIBXD+s
X-Received: by 2002:a05:6820:338a:20b0:69e:2523:2f3c with SMTP id 006d021491bc7-69e2523366cmr3964864eaf.18.1780406761336;
        Tue, 02 Jun 2026 06:26:01 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43c93b15991sm10177259fac.8.2026.06.02.06.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 06:26:00 -0700 (PDT)
Message-ID: <ac87c25f-6708-4307-ad03-645f984dfb1c@kernel.dk>
Date: Tue, 2 Jun 2026 07:25:59 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-iocost: use irq-safe locking in cgroup handlers
To: Bart Van Assche <bart.vanassche@gmail.com>, Yu Kuai <yukuai@fygo.io>,
 tj@kernel.org, josef@toxicpanda.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260601061312.896801-1-yukuai@fygo.io>
 <8709b8e7-8328-47e8-950f-e5726bd70dbc@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <8709b8e7-8328-47e8-950f-e5726bd70dbc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/1/26 3:50 PM, Bart Van Assche wrote:
> On 5/31/26 11:13 PM, Yu Kuai wrote:
>> @@ -3378,14 +3378,14 @@ static u64 ioc_cost_model_prfill(struct seq_file *sf,
>>       if (!dname)
>>           return 0;
>>   -    spin_lock(&ioc->lock);
>> +    spin_lock_irq(&ioc->lock);
>>       seq_printf(sf, "%s ctrl=%s model=linear "
>>              "rbps=%llu rseqiops=%llu rrandiops=%llu "
>>              "wbps=%llu wseqiops=%llu wrandiops=%llu\n",
>>              dname, ioc->user_cost_model ? "user" : "auto",
>>              u[I_LCOEF_RBPS], u[I_LCOEF_RSEQIOPS], u[I_LCOEF_RRANDIOPS],
>>              u[I_LCOEF_WBPS], u[I_LCOEF_WSEQIOPS], u[I_LCOEF_WRANDIOPS]);
>> -    spin_unlock(&ioc->lock);
>> +    spin_unlock_irq(&ioc->lock);
>>       return 0;
>>   }
> 
> This change is wrong. ioc_cost_model_prfill() only has one caller,
> namely blkcg_print_blkgs(). blkcg_print_blkgs() calls the above function
> with interrupts disabled. The spin_unlock_irq(&ioc->lock) at the end of
> the above function enables interrupts while q->queue_lock is held. If an
> interrupt happens on the same CPU core before q->queue_lock is unlocked,
> and that interrupt tries to lock q->queue_lock, a deadlock will occur.

Agree, it's broken. Which makes me suspect of the traces shown. Yu,
can you please shed some light on this?

I've dropped it, thanks Bart.

-- 
Jens Axboe

