Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDFC5CAF
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 18:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035262; cv=none; b=hfuyzg7QpILBTijB+sS6y2dHGrLAoJWw2ZppC/gDFN4hUmLQFUNO+hiMmf1adMY9BrbgVL/4PxehmFZsWU+Aw7MS2MFzC8qeirAyGWvJdSIju5SM9V+Dta57QvpLe9kGu/bFC5rip5RmNmqWOedU+NjLfBpBn7KZ8jMS9GznIjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035262; c=relaxed/simple;
	bh=sCxmilOr20fhEHEUTe3kcpwbWQ5ehbyglS90N/ge31o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Sbz43CH4tlO428PqUXotoBTMgY71vmCsPiDx5ysdt7Cn7bbsL9uoyXwB9WcBe6kkU11xNNJ4uRj6WOBrQwS3RhG9nQ2erO+GyQEdvvWglAkuRhodvCeEVzmKDoezrpw7Wm2OcRI0va8vGExKiyCDuHCADD+on5FgCPRWGB9dKjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d70a98c189so26790075ad.1
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 10:41:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706035260; x=1706640060;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22OkGYnPQFBG6joqaq5x7xp+Mmo9Aw1rDGG7ujl2mcY=;
        b=miuCejsTLWVHTgc5H6OQdZasJ1NrM3Of5y0Mk7SzCSRN//GD4NdyuBva3nlvz4Tspb
         c/R0HzL0uRVEllaQxkcM/Jck4jYOqQ3bM5OuUTYA9+C2W5AhUQaBwBG5VSYJgcLBRjeA
         bRBDbIvfrSA5kDH7VZDnywrbpdBtM31qfDnhMn7WgNYJnLlRBBOS90cdrqDYxakVVI4x
         8XZ2xKZtCwP9y8T/Mm0XX4Z33C/BgGWWNtlfEmDczGJYxxvaod/SthBxCibsETbONAA5
         6UbwJpFWHt0ITZKudNqI5WsZtsOkdG+Okq415h5yQQhC9BEzFTRDWIQy6UEnmOMlhau4
         C4bQ==
X-Gm-Message-State: AOJu0YycZUoaVDXvoyJxqgNqEiwB87koQ6WdbHwN6GknpNxhE/WEYwF1
	LpZ5P+TpmTkLi3h6tc56qWos3fm23cy3G8GJBZeLGX1bnW2UlN33
X-Google-Smtp-Source: AGHT+IEvro1iVW7b4CuX9T6GqU4QK0/Vk7YdaVrWa+txtPRCwso9s2mUaf0U97/8/2MIl8YfxQXrlA==
X-Received: by 2002:a17:902:e548:b0:1d7:4c32:ed0c with SMTP id n8-20020a170902e54800b001d74c32ed0cmr2936771plf.122.1706035259947;
        Tue, 23 Jan 2024 10:40:59 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902eacc00b001d71729ec9csm7847792pld.188.2024.01.23.10.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 10:40:59 -0800 (PST)
Message-ID: <dfd46b3b-0135-4e1c-987f-91f52cafee4c@acm.org>
Date: Tue, 23 Jan 2024 10:40:58 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] block/bfq: serialize request dispatching
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20240123174021.1967461-1-axboe@kernel.dk>
 <20240123174021.1967461-7-axboe@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240123174021.1967461-7-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/24 09:34, Jens Axboe wrote:
> If we're entering request dispatch but someone else is already
> dispatching, then just skip this dispatch. We know IO is inflight and
> this will trigger another dispatch event for any completion. This will
> potentially cause slightly lower queue depth for contended cases, but
> those are slowed down anyway and this should not cause an issue.
> 
> By itself, this patch doesn't help a whole lot, as the dispatch
> lock contention reduction is just eating up by the same dd->lock now
                                                           ^^^^^^^^
Does this perhaps need to be modified into bfqd->lock?

>   struct bfq_data {
> +	struct {
> +		spinlock_t lock;
> +	} ____cacheline_aligned_in_smp;

Hmm ... why is the spinlock surrounded with a struct { }? This is not
clear to me. Otherwise this patch looks good to me.

Thanks,

Bart.
