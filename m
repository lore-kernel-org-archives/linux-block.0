Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08AB50A64
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 19:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706037215; cv=none; b=EWQosq7J75m0edwSY55g4oPPLmh2qLfgVqAgNjBCl65DmJevY1pgslXypOeIyavDz7Tmd9iV6HZndrlgRAnsG5S3C+wV0leAsm6CkN7hMjZSmJkJh8/KAzFn8L21VQdtpO8VcIsA5QkjCfrbVPhix1jvRLMem3ceNzYp4sT2I+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706037215; c=relaxed/simple;
	bh=RNtD7GWyKPzJAt9dkBQHz9GkdmZiAblftBEnWOTIue0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X3Gv1HMRXL+mb3/pmRj33j7wSuwwkttCpESHvGSwrem+Rx0HpNe7ZFEXuDp8TcP3efVCCztfo9OIUgwnxb2bEpt142LVAR7rOpVT9z3KULZnlotRwJ+wAUeCdN/2glMkkxFaWZ+7HS/VY+clMk31ZOgtjriMsQjwBxlrF/Bl8lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=U3l/wFLP; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="U3l/wFLP"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bee9f626caso63580939f.0
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 11:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706037210; x=1706642010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NWbXsxiaRPq8yrV89xSmnjmATp5aclQduE6/LbAlN74=;
        b=U3l/wFLPGR73JcwSgdyZuXdvjdWgldGnijxuE/sA1UktoUzOoINc4NUr8T+9eS+yE0
         ugjEm3xiMwidBW+14Wo7f5jR/T2+7NjnLI3gyGYETuiqhJzoMgysOWs5V790FxjR/C2N
         vSAvutGdQC9yB40OOiP7bRueTDtaF5Nh20Yrh+1YEA8tCaVpPYXfTNxu5bwQ2zHytHkS
         6iam2WlEP2QXU3UwSA+gwFtYcHyJnG1cuNU1U9EksEsoe42k4Ob/EiklLxpazZWs1ymv
         dq4CZ5QpwOksnfWkveTUSM3GMWjkYfr6C/ANdIFwpbGTM2tWclsAE49HUjsCJDdaFR/E
         6xWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706037210; x=1706642010;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NWbXsxiaRPq8yrV89xSmnjmATp5aclQduE6/LbAlN74=;
        b=EKFyxoT3SpserVQgMHaac3pg8cyX2NceKCNDKfqQS/63h0TOCDqYdyUPmNXpwe+YiK
         PBEhQ3Jt7LS3MTbj49TIAJWtMcd40tPIQP7dqygtdb+nQlFyDjX+Y/CnNIF1h19afqaz
         5e8ooGGrquCe1DpBmmiUt2Oyfw3UjN+SG3Xpcn91gUxEC2IkpMqzgoeAq/TfHLAKy77L
         xcU9AhGZ1aFh4RzRBiusQEh+Y5PoEk6BNH1MmW/RAbmGcPz6d6VsC1O9kodcfiqlbZVe
         Wt7XdRubtcGfaqbyCrllsIR29NAK9pxdJax4X9TE8Cdw/H8zcy1NxWiD+6fdzfn/duio
         WHjw==
X-Gm-Message-State: AOJu0YwDO5me2qwRJmHhjBa1UQHeOnQHXmkGZ6K7x2bFOOyFlqerIszp
	AJPDckIkMKMdicfshHI7THwJIJ2/t/8fz1GsiqynAFsfMDujaNC1UsnSzA8UM6GNvDlPFCD1cPH
	jLL8=
X-Google-Smtp-Source: AGHT+IHlp5EbEyNJq2Qhh5CLrKnU8SLrn7bVxAH2wgOWQi+KCiOKfRiIBKsyrynQa4pr2yrnbze41A==
X-Received: by 2002:a92:c24a:0:b0:35f:b9ea:16dd with SMTP id k10-20020a92c24a000000b0035fb9ea16ddmr241562ilo.0.1706037210576;
        Tue, 23 Jan 2024 11:13:30 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l4-20020a056e020e4400b00361a956a57bsm3445104ilk.53.2024.01.23.11.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 11:13:29 -0800 (PST)
Message-ID: <77209dea-406f-4143-98b7-b034b4d1dfe6@kernel.dk>
Date: Tue, 23 Jan 2024 12:13:29 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] block/mq-deadline: serialize request dispatching
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20240123174021.1967461-1-axboe@kernel.dk>
 <20240123174021.1967461-3-axboe@kernel.dk>
 <1c695e25-af8e-41b2-adfe-58c843e7dbc1@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1c695e25-af8e-41b2-adfe-58c843e7dbc1@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 11:36 AM, Bart Van Assche wrote:
> On 1/23/24 09:34, Jens Axboe wrote:
>> +    struct {
>> +        spinlock_t lock;
>> +        spinlock_t zone_lock;
>> +    } ____cacheline_aligned_in_smp;
> 
> It is not clear to me why the ____cacheline_aligned_in_smp attribute
> is applied to the two spinlocks combined? Can this cause both spinlocks
> to end up in the same cache line? If the ____cacheline_aligned_in_smp
> attribute would be applied to each spinlock separately, could that
> improve performance even further? Otherwise this patch looks good to me,
> hence:

It is somewhat counterintuitive, but my testing shows that there's no
problem with them in the same cacheline. Hence I'm reluctant to move
them out of the struct and align both of them, as it'd just waste memory
for seemingly no runtime benefit.

> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Thanks!

-- 
Jens Axboe

