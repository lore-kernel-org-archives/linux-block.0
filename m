Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D8F2F6162
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765568998; cv=none; b=caokrHtyfbkkH3Q7BMptqJYpuvVwajhhMzN9L5WfkmLQbyTgzQBKrqvnFw9YkcgF7AlunVGJ+LSHdzZHwJAvB8YHycsu+Dq5TMIGlpwozkokzsWZ/8iTsz5paEvt2rkc0eUhvW7YXsqtP/x2B3Rjqz7s2cuKzZla/IJEX4dGC5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765568998; c=relaxed/simple;
	bh=rU8lIWP77HJ7GCeE8ZqNAeBdplhUZjJW3ZMJOiqroh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S5fZlFLAVz8DneaPr9piSOED7MVlKNAEXYrrVMd/LhzW3s/H2K7PbLzicXRMh/jbCE+UEEnsPULrWyIrNKbEzkteVFAT1YBQwkfXca1S+N5NnHe55F9PJBB684hodxxz+kObCN1bmlrKvupEFqID0rwhjvJLn0Nq8XxfxRw7l80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PbO3bXr2; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PbO3bXr2"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c1d98ba11so603081a91.3
        for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 11:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765568992; x=1766173792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BiuaqIft23N+8FJdxI9Pu5YlV8vaPnKq9U66155ejrY=;
        b=PbO3bXr2Kuyw8QzkEUxSJsKFKpB5z3r3VlIj0b3db0mbsCO9GVqYZV9PNnqINIMOLt
         DDzu5nT1pvq03P37mGMvv0Xee3yJh0YBmjRQzx6akUeSSTEmUzBzG0cil4GsuQLLxg0i
         F+7oLIIQcpB3tENruor4UBJ+NW/0+HWA7mIeNxrrk8Ns4m4QwIAyLdOWCCVVu0NuoS2m
         dn1o6DuRq7P37s7B2UHr0mlB69lO+nFA1xUrU/zecT2B21XWRn06Ws/HSzRPPyWOXaa7
         INtUgMoIR9/0c2rEWolvbVp3scD0n+cWY5Xjk9sqbIryK4nOcWEvZeUm3i1pGJ3ZqXjp
         3SFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765568992; x=1766173792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BiuaqIft23N+8FJdxI9Pu5YlV8vaPnKq9U66155ejrY=;
        b=tm2aP9SxbHLhZl3MnBrHOzX8CJQD0+sZ/vw6aptfswSYGB2ycTNZy+nqEOpiqxQSPi
         /q90+oNFROLh6ZvwVtwVnZoucxK5IMk4d6qhsFeP528lCLjRgfCcmoYg8sGZ37X3ZphX
         sTkRoGLoX+IxR1p/AcJL2UmV2XxqXXQL9maiw14vVY34hp2JX4obdBH0X/a4p3uiGO2Y
         8/OG5S+ypNXeYnSFmLBJpg1H8RZvtUVSO/0qbNwmLyV8SBObYLn3n+VhQUq2DOaUgt+c
         AH44TyBTvPDyzYJMmoKz7go0ruKjDMNH3Y683qTuAuB36DGr/jTvzvih7fcY+trBJl6s
         E0eA==
X-Forwarded-Encrypted: i=1; AJvYcCXXeRxv5XI5Z9R7xSVCmf1vuyJojdIXD3ABy+nFOG5UNiarDuqugMlpvOEN6H3r6dIbqDrvL0QevuD5CA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6mPL8pHGKmh1Dt3QA4UtuTPPPs8kZ2z4Uk8zn6KC/Hm2lkl5D
	0UwYkZhkx0G7Wz39YwCANfSG8LxEfzGlDbmVuPH4uRLDFtdgnEaoD3tu0UKoMQIqozg=
X-Gm-Gg: AY/fxX4LiOHhJRoa6w37wpRkHZI1l3W4Hi/L0KGNlD2DPq1xIN7/gJ6R7pkvjoAE9GT
	tQ4GyfIcB+6XPKc5sq9YPuRNT+6TCyNHhNxLT3BC6Ep6vRp8k/7WL3cJeLp6XRuFqQEkFbjhwSC
	4l+QdpaEgXoE9Qal6+kp9vBcltF+lxrsQfomoXTFqVffD4+XGjvDsdhGcrYrUBUonclQZ+elTu5
	asYlmxZSJ0fETsLAz3jpDj7GRTDO17l/J58GOQ+o39Vt83eJP+Udctl5hruaUy4ggHeVkb+bgG5
	I4DcRUkeSSv8f0lMVu2esVyMhaekOylXnjMtRXl9DxtfI1eoFZUPbmW8yBORRLmibIOLV+S0ajq
	upZ9B4rk6gi6t0jIRTUqpo3j/eXY8gFc5I5j3gANj7kA/1LXU9FsyBBMgdjAhtgTv6Wc8pJnFS4
	fQmws0wFl871pgdUMJdNskv0FlXyvcXTA3GIh19YIGKGzx3Jfc+ui0EzL0VxLh
X-Google-Smtp-Source: AGHT+IHl0uGiZeXYOe0BpcuUHzoZIzr1AiRxnMx9qgyqmd3KYpi21rBPhdmh9aCOYR5Am+GGS4V3vQ==
X-Received: by 2002:a05:7022:fe02:b0:11f:391c:d01f with SMTP id a92af1059eb24-11f391cd0cbmr925111c88.38.1765568992058;
        Fri, 12 Dec 2025 11:49:52 -0800 (PST)
Received: from [172.20.4.188] (221x255x142x61.ap221.ftth.ucom.ne.jp. [221.255.142.61])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e3048d9sm20604224c88.14.2025.12.12.11.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 11:49:51 -0800 (PST)
Message-ID: <8dd3c141-3e92-44f3-91e2-2bf4827b36a4@kernel.dk>
Date: Fri, 12 Dec 2025 12:49:49 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] ublk: fix deadlock when reading partition table
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
 Uday Shankar <ushankar@purestorage.com>
References: <20251212143415.485359-1-ming.lei@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251212143415.485359-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/25 7:34 AM, Ming Lei wrote:
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index df9831783a13..38f138f248e6 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1080,12 +1080,20 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
>  	return io_uring_cmd_to_pdu(ioucmd, struct ublk_uring_cmd_pdu);
>  }
>  
> +static void ublk_end_request(struct request *req, blk_status_t error)
> +{
> +	local_bh_disable();
> +	blk_mq_end_request(req, error);
> +	local_bh_enable();
> +}

This is really almost too ugly to live, as a work-around for what just
happens to be in __fput_deferred()... Surely we can come up with
something better here? Heck even a PF_ flag would be better than this,
imho.

> @@ -1117,14 +1125,26 @@ static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
>  	if (unlikely(unmapped_bytes < io->res))
>  		io->res = unmapped_bytes;
>  
> -	if (blk_update_request(req, BLK_STS_OK, io->res))
> +	/*
> +	 * Run bio->bi_end_io() from softirq context for preventing this
> +	 * ublk's blkdev_release() from being called on current's task
> +	 * work, see fput() implementation.

But that's not what it does, running it from softirq context. It simply
disables local bottomhalf interrupts to trick __fput_deferred(), it's
not scheduling ->bi_end_io() to run from softirq context itself.

-- 
Jens Axboe
