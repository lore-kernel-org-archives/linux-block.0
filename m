Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8074E15AF6
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 03:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726542727; cv=none; b=oOm7NaRhbb3yl0TlfMosezwbIU1e+4CzWDzMxIEo3stWLNAzaxqOtR6tZZHbz8tTAEQdQISS7LFCCGuGeZS/h79ApT5RyL6FWxHuQbeQuMS/45d3AVcPKMc0QovPj5BgDl4va7/fXtikOYAQrhPKyBUThp0UzTXPypXLXX0OMFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726542727; c=relaxed/simple;
	bh=d6RUdXmX65JlV4ifds0THcuSzXzdxdkkt/pSJg4W0v4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DvckCHihnr/XVdO/Azzvb7fQtSrOt6RiWfHKWINtH7mrpxcT65hjJe0CZTp2t6dDr1EM7j0W/1LezLDXHslZHd1ZEHjdmwpLY7b7vIaeQJSGzW/CfZARVUFiuzuPrDihEKAwRYD4qys8PGihI6LMD8YxoNGokrdMzRFLIO4gd7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KEmhaphZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KEmhaphZ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso38203265e9.0
        for <linux-block@vger.kernel.org>; Mon, 16 Sep 2024 20:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726542724; x=1727147524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pndO79yIEXi5D/T5Hiw5+hSCMV+JnoiyMVBfXesV0SY=;
        b=KEmhaphZtzMaBqdSlrH8S0d/XBDTrJ4JN0dEaado+hNrdc0aPYTs0foGkxuY+hW75c
         CWsy/v6tfXPujmLeWwJea1enao+wbWLTwWkJq96z1beLoQhPxRyV69j8c9TlmQXscMbZ
         iRJHOoxbrgVO9eF1kOjIokqR7JBPqD/vRNltZm3m/BPh18E4ldd0iU1OfH0lJ4+0sHhB
         wtufrHs546NX5zVUBZwXxWUYy4jYgYWJ9sPH2bMHANNjiH49GYqhNLi0DtcX70dhMkbv
         f1eSzeoVVALcszgoQFYmS+PU2FFmHD64fakEJRkjTUnZihd7lr/94KfqqaKRmLVMO+vv
         6whQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726542724; x=1727147524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pndO79yIEXi5D/T5Hiw5+hSCMV+JnoiyMVBfXesV0SY=;
        b=CDPfOJMCwNuZvAQ8JI1RvLDBiaSXrIlL3M4+27Kmg0fvsh2NTv9i7U9j4qTZ0FeMGJ
         nERWzHFgOq/aSkWobmrbCrvcwQAAnSdGvSCCPuy1W69uGIeYAL5VpM5GhBU/S1mahVaR
         AKXkernon6xL40plxEyrQFUjke4s4HSY0VuOVbHfTcFweu1ZHMazyQnH4l3zcmZ0mrN1
         6DAPPfpdnvN0JoNN7y2x8/ZnB6dQFD0bPBjq+V6+X+Oy9VQshD3qhZOdqeD2ecg/uc7g
         wfvGZKuvvYg0Qg+xtrRc0CxAe2d1i2UWpzftZqkF5SjTsPqVa4rotxfsXAWk02mCNRzE
         jndA==
X-Forwarded-Encrypted: i=1; AJvYcCWxR/3N7juyil1VgN8OGVUfW4867ubFTeqML0MvLVWIJjDHhkSWb8nJ9+R+fXzuxNLWuVAZulWZyUqXuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxT8UHS/YRl1AAEVjH/cxKGfETci8qD9oWMrhb7FV8UWxq4d/9E
	8gXEuYOGgy8+Y7eFTbri9FgT87ZzJlZdLCmKlTusaYfQwQBp5cWXrjx51x/BnLI=
X-Google-Smtp-Source: AGHT+IE3x6M8kqDP9HN0dSWPfZr9uevVahP/pokENG4Q7OcHHF7RCwUkr3dTJyAmWCiqUjtzbd6T6w==
X-Received: by 2002:adf:b50a:0:b0:374:d130:a43b with SMTP id ffacd0b85a97d-378c27a12cdmr10392856f8f.4.1726542723772;
        Mon, 16 Sep 2024 20:12:03 -0700 (PDT)
Received: from [192.168.0.216] ([185.44.53.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7805185sm8417966f8f.96.2024.09.16.20.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 20:12:03 -0700 (PDT)
Message-ID: <68e8c574-1266-42e1-9d0d-ed837c7105b6@kernel.dk>
Date: Mon, 16 Sep 2024 21:12:02 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] block: change wait on bd_claiming to use a
 var_waitqueue, not a bit_waitqueue
To: NeilBrown <neilb@suse.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20240826063659.15327-1-neilb@suse.de>
 <20240826063659.15327-2-neilb@suse.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240826063659.15327-2-neilb@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/24 12:30 AM, NeilBrown wrote:
> bd_prepare_to_claim() waits for a var to change, not for a bit to be
> cleared.
> So change from bit_waitqueue() to __var_waitqueue() and correspondingly
> use wake_up_var().
> This will allow a future patch which change the "bit" function to expect
> an "unsigned long *" instead of "void *".

Looks fine to me - since this one is separate from the series, I can snag
it and shove it into the block side so it'll make 6.12-rc1. Then at least
it won't be a dependency for the rest of the series post that.

-- 
Jens Axboe

