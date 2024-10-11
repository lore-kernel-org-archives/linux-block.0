Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405F4188CB1
	for <linux-block@vger.kernel.org>; Fri, 11 Oct 2024 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728662538; cv=none; b=qSSkrmQ+/8vvsxJS+xUXHHI216AgQ0BOXSr/Z7R6FEYpEeaslEuPV/+BbPc/2rVatsghxxgXEhltOt5USAg4Bd4ckrePI+Bm+OI6zYc1Lwm6slKLWOsgjcjfYk0cDOxyh1ZINiRfweP1Gq3YTiQSNgOpC2+Xj/cd5NRyIfAQdaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728662538; c=relaxed/simple;
	bh=ZTII6T9aU4ziFxLFkAuZk61ywN02W0Xxx0mi3ScNxW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVQnyIX0FedIveGrFTuyhea9NVoUwq2mX0bmXzoQ3sZ9bZ1tnAf3+1fZ7f1o5sw5rIZO40nXL5872ykN3idSPr/vuvwcABbz9jK/TEw0POI9ObhWNxZNE6prrON0TkBGkccOXiH1QXBuGYJgTvDF773PjZznRDFDB3ITzgmLqJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fCmG+1st; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fCmG+1st"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8354851fcabso95402639f.2
        for <linux-block@vger.kernel.org>; Fri, 11 Oct 2024 09:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728662535; x=1729267335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=phe+hHZ+UlVRhNse6FVjcNzwCndL3mLDFlcwteQiikQ=;
        b=fCmG+1st+DdD8yziOUXgm4tS2hrA+CF4Cr5/jy3/6XzpujVlbpxATTIUlI58dqUbqJ
         z0+OpQS+XMaxZxL+ezqrl34g0uAaYNPLaXAtGoH69Qhj9WNuB/UN2WxAo2gtyVxJCZvW
         NDj5Y5mJb6ciA9SEvOHKq4icyKuZyQhFdHCCgTAMitqjB5vbwXgj00GdPziCkO3gc5lk
         geepW4YqzZR5VPZHg8l8KmF4/0R/k+GarYCLlK4+DA7j+gioJcXBC0iajaK19fxAgh0V
         f/R8fkfpEm+GOVve5MWwtWWW9Hb0xk/UYSszgbuV19Il7TESsuhV+cDgy+fl1+ubBmBv
         yDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728662535; x=1729267335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phe+hHZ+UlVRhNse6FVjcNzwCndL3mLDFlcwteQiikQ=;
        b=iOBHY+eGmXo6Z59/Nl210bHkxE1gWmHpAwXjDGkn94Pw4dXX5oL8srrQOXAJ0oY8u9
         9q59rUIMPuyaHLRN9CQdpDdlvOlcDtzJ2pw8OOzzzdWXG3iGFj423bNciTFAiDPLPM/+
         OKI0oJPAzoLExYg7h4CBHc1THV4GIfBLRfyIa5e5Yd11YDW6UqTqkOOnj5HHe0TL0IqN
         Z3fSx6Iw3GoGJy4j7TRGY5GRUdB8mTMif5XvbvmPFjFU5IDxUls8+yqQdVsS08znWZtE
         n38x/J+KUwA8QX/jQX59Zxfj8s0xLm/GI+kY+iZ3KzeiFJqa0l44gGL046oyD75MYTUD
         z8tA==
X-Forwarded-Encrypted: i=1; AJvYcCWUMFlZcwlI8sQg8Hx3IL/2X1dvHXsTpvktJEv3Mw7cl65cfiCaUnbxxq3oPDG1pRww+YYL+dV35IUd9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxefTXwvWDIboTbsSLIMS5ewaMffpm2JL+xovVlvl2s4rRANmks
	G/WmSmnQYD2Z26UL598Zv8Uc/lz9H1DNVALuDzFuk2nGZyUEOIEhJRf1nojBF9w=
X-Google-Smtp-Source: AGHT+IEwVoTkb0AmTtNdiha/56/Zql7nitdt3SgT2itHt7aFIvcIyKHHowpcvFIZrsj+wSWcS7wQ/A==
X-Received: by 2002:a05:6e02:13a7:b0:3a0:9159:1561 with SMTP id e9e14a558f8ab-3a3b5f233e1mr36980225ab.2.1728662535003;
        Fri, 11 Oct 2024 09:02:15 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbadaa9925sm693297173.145.2024.10.11.09.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 09:02:14 -0700 (PDT)
Message-ID: <b63b487a-09fc-4519-ae5b-dabf1fcf05b1@kernel.dk>
Date: Fri, 11 Oct 2024 10:02:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] elevator: do not request_module if elevator exists
To: Breno Leitao <leitao@debian.org>, hch@infradead.org,
 Damien Le Moal <dlemoal@kernel.org>
Cc: kernel-team@meta.com, "open list:BLOCK LAYER"
 <linux-block@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20241011154959.3198364-1-leitao@debian.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241011154959.3198364-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/24 9:49 AM, Breno Leitao wrote:
> Whenever an I/O elevator is changed, the system attempts to load a
> module for the new elevator. This occurs regardless of whether the
> elevator is already loaded or built directly into the kernel. This
> behavior introduces unnecessary overhead and potential issues.
> 
> This makes the operation slower, and more error-prone. For instance,
> making the problem fixed by [1] visible for users that doesn't even rely
> on modules being available through modules.
> 
> Do not try to load the ioscheduler if it is already visible.
> 
> This change brings two main benefits: it improves the performance of
> elevator changes, and it reduces the likelihood of errors occurring
> during this process.
> 
> [1] Commit e3accac1a976 ("block: Fix elv_iosched_local_module handling of "none" scheduler")
> Fixes: 734e1a860312 ("block: Prevent deadlocks when switching elevators")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changelog:
>  v2:
>    * Protecet __elevator_find() by elv_list_lock (Christoph Hellwig)
>  v1:
>    * https://lore.kernel.org/all/20241010141509.4028059-1-leitao@debian.org/
> 
>  block/elevator.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index 565807f0b1c7..1ac9be3e47d1 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -106,6 +106,17 @@ static struct elevator_type *__elevator_find(const char *name)
>  	return NULL;
>  }
>  
> +static struct elevator_type *elevator_find(const char *name)
> +{
> +	struct elevator_type *e;
> +
> +	spin_lock(&elv_list_lock);
> +	e = __elevator_find(name);
> +	spin_unlock(&elv_list_lock);
> +
> +	return e;
> +}

Probably just drop this helper. If it's only used in one spot, then we
don't need to add a helper for it.

-- 
Jens Axboe

