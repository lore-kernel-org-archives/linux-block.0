Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC283DB645
	for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773844251; cv=none; b=RE5zm4mJ8/4JKH8wSXQr0XrnDKZisR9KTRRvxTCXvjAqwvv+/4C9Pickdc6A3rQOWaJOsBqSY1QJhuxmiOqQl7q1Z5ZHD2mI5dSyUBcnRsBSEGmNS5Q+k1wnC7wq4mTzWGC8yjHLp/utMfQ78oNEmBPagnkekNpcw7nuogQGIsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773844251; c=relaxed/simple;
	bh=Bo5KghtYR32r9I0F8M73iprH2RmKUKLZxLpC+GK+qj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6awGQMsTMIzne/SKBuMqzohhIXPdLykcgrrXXZ7ImA6yCZRcfaDuE0CtC17eJ12ovwlgL/38azOJ6ZfxzoAXyGjBxUVtMTHXQt5Qo2DRCqbp0eeR+wzvqo50tBA9SF5Z+RmyYuRNk5i7BG32pcHna3veWdIa/eS+Z53c1Aj5Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=H1q+gCL7; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="H1q+gCL7"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d1872504cbso940733a34.0
        for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 07:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773844248; x=1774449048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N9eL1spLijSB7l3SaRHRFY6sekamDst6WgWZ8CEff1o=;
        b=H1q+gCL7vKvEV6Zt9nzNnG9IA9toPdbOHMQlEOC1Da5cC2iQtI6IQPTMetmRGiJf1Y
         CsV4wClp7o2Zn0uCQ1+F4K4GvLEYsuEoLYUWulRmeDuQrsTiovqH7hpIAelH3quwnKxz
         4DMex4yK2uLTpt3Vh6fIu2RyXg8jIvw87zwI7gtcFnxz4uw6+nOxD/9wosyl/bD5Ocjp
         XPp8Rr+ldwr5MpoNeEj21fBQJ5MdX6C7YNjr+KBoUhRwQ+m3CbgzauxjnZHeL0iOAKOM
         tzDbg9zeRTMfjRkYe0Dz+M6ztraqFDxkuDQBNagXg5QRvEumzNPBZMxO1+7noIlZaeBc
         7zkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773844248; x=1774449048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9eL1spLijSB7l3SaRHRFY6sekamDst6WgWZ8CEff1o=;
        b=SUf4PaEPtdSxMixTkyLA502GvSbaQhNR0P92aPJYCUb6iGYN/m6EP00VuiVLhYUlyB
         M43DuiLPJ/hGgckO5sZeh5O7TEsJL2szJip6WPPE5Y5/Ke3I9C/jcdQdPWe9qjIZPC6n
         LXHtx2wpuFiYcbxiU7hLra6Eboh3PuICiBah2GAseoVBQHPqjGyLX75dLnuutj5EOfpB
         RqokEwI7REaOI/djwl1cKjvEsdvOyi9rbuK9uJPonrtIjsJeeGrFitNH7ludg0pdVf1v
         D+Qiv3hqdzI4Q34mHZjRaSFi0WM37xBgRswtYFOfA4Ovk2lDNjMN+UgYPfLKgxEGVkoQ
         2B3w==
X-Gm-Message-State: AOJu0Ywahlqh5mY1l6WIXbq7fBzfLAJH7RxN2xBjzvKOHm0/AwjnZzCb
	dPap/TzIbzIicLjf8rSLI0ymjyjoN/Hsug1DNOcXh2v9Jw16I/Ha5cYEjat6UR0oWmqmFxJhGn9
	sBsygtUU=
X-Gm-Gg: ATEYQzzsMsy7Moz96JU7o/nZD9mnDbydAnRx0vgbMISBVuHADF+MnNIHDjWNI0rOiBc
	NNnc/Cqy805PIHiEl6tq64GdqbEYfFsw4Ub00FnIAduxB1LBRVfzJ5KsxFQ7Fx5MKWsnR9gS3yt
	5zMM48tKOnVDgsdw7Y3h418kw//jbsuEmTjZX/hmkC2FhOU1XFDgqd1CbO1CDDoA8alIr3FS0ts
	U19xXRblmPU3ulYDVDGvaUzcfeILi/PabgN38hYD/fw17WOD5613oK+ROXlKadVikxOngAR5Xwf
	9JEhER9qkpLNNTgFPfbRJoyhNt2QAaObHET2DcSOxYrIKZ0wu4+3+lcIfosE2sKt6xUkmZFq63x
	HomH4q3O6kIbbTeOX/GLGV4YxxP2jtjBjmqYkxlqTEwXD5X4TypyB7zYBCwsRGvBFvZOexfZrCU
	W9QVBj8/sSB4jpYCih2tSLbEoxjQAtEkuF3J3B69PcBiTMQOMBWVUB0UDbWFIRCwV0zSHfLA80g
	ksA7ccaog==
X-Received: by 2002:a05:6830:44ac:b0:7d4:ba6d:e33b with SMTP id 46e09a7af769-7d7c97c5abemr2580020a34.14.1773844248098;
        Wed, 18 Mar 2026 07:30:48 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7c9b38fbbsm2141263a34.13.2026.03.18.07.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 07:30:47 -0700 (PDT)
Message-ID: <116ce532-ae6e-47b4-982d-6066c8020022@kernel.dk>
Date: Wed, 18 Mar 2026 08:30:46 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: cleanup various NULL pointer comparisons
To: Alone Dangal <yogeshdangal66@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260227150641.28735-1-yogeshdangal66@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260227150641.28735-1-yogeshdangal66@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/26 8:06 AM, Alone Dangal wrote:
> Remove open-coded NULL comparisons to follow kernel coding style
> guidelines. While at it, remove a trailing whitespace in blk-core.c.

This is just unnecessary churn.

-- 
Jens Axboe

