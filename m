Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D037141A85
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022545; cv=none; b=Tz48vxTwJQXO85J2L56cioJ17gqGCCEawXqntBy+pyaIbv+N/dxI8EZlaMish5kQN4Q8JkWbtXPotpGKY4JLlzvR44DwRXPeMo0z/s+61uUKYbqCno72eDWZF1Wa5/5UslzJYtdnBfUiMSqAWrhGarbsIv/E33mkII5iEZ1UlgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022545; c=relaxed/simple;
	bh=6MlqNG3sthSP5k/SOe9ddEU1Cp/XKlYZU8GZUusjK1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HjwiOUtv0H3cxlUH80JEqs0KpqjNmL5H40Dlb05Dyx3teaRX4UWtoQyuZZSOP1XSjXelpjdG1N56kyXsgqsS9Pm3pNKVP2Wz0KJ8oOHqu7r9b2rZdF1ZeMVANAWZCTxhqWj4vai0S5OTq2nCFHl+erAR4QMw8+DmbRmimYZR/Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d74045c463so14983935ad.3
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 07:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706022543; x=1706627343;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NoeC7zDq1mvguyHAhZoeMhkVymvRSfpvOQnlewBbLqc=;
        b=HkEgkOv30YtRTV8GfIBqZgDLvEbgoqGu3lEPsKW94snu7REGt1dD2Yt8+jjGdEr9ez
         3sds01I3Lp3ex15AiWTMPY2iY0Jww4LfF+OWQlBVU+rgYzEUaCBDL/GEzJMKSPFqb2tz
         RCYx3VXDgoCy5bjrqP8QDTlEKxZYxfcckPVHxOKvjHt4oJtFx/0G+ksaDTOlyIftCVG8
         /zuo+eKgvVQVtNn8Pak5v5XN3CdBhVAB1GJzgWVdpBJtQJ/fJAoh878B0O3nKrhACgvH
         eVX6y7TQS0oHYettitZwb2V0tgYs2Bvl06T6xrunUNNRiTkcN3/QQbRzeJl4JN0Xk3rm
         dXcQ==
X-Gm-Message-State: AOJu0Yxq6VyQ+wrQQu5feWpYVVoICtq2n15ptyaCzp0Px3KBaiyCs9pT
	OgsVo78Ue282HV/a3mHf4Cvs4+auN4DSd/2siCX0DD4EbMfFDarmPwIwz5E/
X-Google-Smtp-Source: AGHT+IG3Ja/r++nPN8gXeDgPB1cgy1SlN+d3koZSCfZCNMStjDgQxnwjE2E39AyifcWGmkiZIX5CKA==
X-Received: by 2002:a17:90a:65c5:b0:290:a1c8:91e5 with SMTP id i5-20020a17090a65c500b00290a1c891e5mr2057558pjs.61.1706022543009;
        Tue, 23 Jan 2024 07:09:03 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id sk1-20020a17090b2dc100b0028bd303dc58sm11798086pjb.11.2024.01.23.07.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 07:09:02 -0800 (PST)
Message-ID: <63db4419-2440-4348-8bb7-c6086d7ba88c@acm.org>
Date: Tue, 23 Jan 2024 07:09:01 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/mq-deadline: Optimize request insertion
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20240122235332.2299150-1-bvanassche@acm.org>
 <1f140e5c-c7b3-424b-9231-fe51ddb6fbf7@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1f140e5c-c7b3-424b-9231-fe51ddb6fbf7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/24 18:30, Damien Le Moal wrote:
> On 1/23/24 08:53, Bart Van Assche wrote:
>> Reduce lock contention on dd->lock by calling dd_insert_request() from
>> inside the dispatch callback instead of from the insert callback. This
>> patch is inspired by a patch from Jens.
> 
> I supposed this is a followup of the performance discussion with Jens. If so,
> can you add performance numbers here and so justifying the change ?
> Otherwise, it is hard to figure out the effect of the patch and so why you are
> making this change.

Hi Damien,

If I replace Jens' patch 3/4 with this patch I achieve 20% higher IOPS
for 1..4 CPU cores (null_blk + fio in an x86 VM).

Bart.

