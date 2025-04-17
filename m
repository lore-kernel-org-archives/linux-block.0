Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB252472BC
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 12:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744893193; cv=none; b=DQvatJ6Q8aDDHAj8YawHWaXwqDpzneRAW9es7TmpIVAH0UAQeYdtVOBSzWlb/j/z4XRPIB8rMltCTtwYdAB36hHI74P+Rcnz441ZGvLTl248WRZmuVaQtAoN+Fj9DOa+q+RNZ3+yuAlS8ufF6n2RILmO1zVFrEL+Baeg+kFPO+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744893193; c=relaxed/simple;
	bh=1MV/K3U8QeTgYmL4TX71oMEy7/LuN+sXfozWdi6/Wjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lBrbPOgSPzGR+WU2Mpr1SiE8WRYFwZYGmGBMFCocSdugujM+9uBIbpQ3LK3sxE3vHLBSzn3oKdwTRbodnSybqRKgkhd4AP6swimikQ/4r5xI5DvQFpAyh2wdSO9RKihuNNZ44W3KVnXy1FW1yTFTZd+BdmCPZXWJj/GcPNPBliw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=P9eWbfNY; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="P9eWbfNY"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d58908c43fso2191775ab.0
        for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 05:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744893189; x=1745497989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SXppVvtbavbNcWmjc74YE35lG9q2D2kQ7SUthb89yf4=;
        b=P9eWbfNYP6/fmcHDlJwPlH3rPxHKy9jWHwdn2daJmshkGq3xpjMhIgM2+woJ/eI+Uh
         3VJR33mIV6K1QFSfjYbp/2AYm494w0ygkWa5lW0JF+ZwfaaVatWP47CmfBTrgh1WJ6zf
         ga642wEbG6sc9V6xNeOpHDGKYBSkZgVhdE/qXmjk9WSspBrX8TWuC1aZjxWSYeR2VvrG
         jJrcHI882A6KIO3z2pZFcHj7GN9Vey2pbt1XMKD0/Cg3nem475b7nnEwGGhU+PusYhnV
         rsFhdrn3lJVHtfTNOT9X/S/LGgozxkWrXqspkv8jnZAR3qr5X8awxGoSd8j8qxSk7I7H
         aDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744893189; x=1745497989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXppVvtbavbNcWmjc74YE35lG9q2D2kQ7SUthb89yf4=;
        b=X3CPtyBWEbhiW6P9Vl8WGy0o8U1VzDeTcZGlAK3JHB9JDGedOcbv+NoE4FOEi/SqHv
         +S5XQGAwLhzjov6oIzJeaYQK3cmYCbEzniejWgF9tEjS+pWf7pkbzGjGeH7rayLWOhaQ
         7+3nK09t4O+6FS6oRdxydCgO8/A5gaeDn1xIhxz+/TDwQ84hl5KbMopWt4SEFfxwMpG+
         7k4lMVtCHbAXHjF/3m0GUrsbwTAHS/EYydLeojmOyjkoSJuo2IJpIgjXPHtDUrilpdsu
         AvWjQfrd/Kx3o1uMaKL3D96GHbPSkrZiXBbHHS1dTIJZbM4OHaFjAYsdkQtSPPeJEagZ
         Yalw==
X-Forwarded-Encrypted: i=1; AJvYcCUrYnqv3snZUpLtqRWg6u+okQ8yf8phnYaz4/DhblkX5gVR7lVqs4123GxMjEecfdR4nRiaClumg20zvA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmms2rUMHRdMJ+cKDBm3jkcWBSvTWoWDU3cgtoOLXUYiBF7Ag4
	gKViKH7EYGvFHSI3MGUwTk6GsWk2W+wLniCUzG4dFpRuCRAcFVtRWnrieLuHiQMA9flHnu6vz+D
	d
X-Gm-Gg: ASbGncuruql3SjWcsaZrBsakyAKs3v72/pnHC18WJiXtDo1LxVpiLFHsVQ55q8Rn7b1
	t4q8mRuAgBCDmWHu4XR10NQ1pW4F6AufTtfov0qXzNLvYiHmpR1LB+4hB9pTeQr0UBiIqo58VKr
	J+zXV5DEif4ppR9pHF6OwvY6yshhoJaZg/wxecYS5QZhS/cKzIcOOX25Q9qmG0yoO6wRfw6l30f
	Sxih05lXobU++492P8HXykideIuhNpspOnmBdSwiwFQg2cuuZMuRgnkMzZ8eBdfj6MV247v/zvE
	ukGqlHXLL5WIk+zMIOu5PP8hZqZAPjMEQXChldda/xUTPdvH
X-Google-Smtp-Source: AGHT+IElAYMVC6sV+C8C47JpQv/6xHE6np7R9DqAHzl2vmiT+hY/9n5GM7YdQEh13S99/K1mboPw3g==
X-Received: by 2002:a92:c263:0:b0:3d6:d162:be02 with SMTP id e9e14a558f8ab-3d815b70c98mr57649405ab.21.1744893189577;
        Thu, 17 Apr 2025 05:33:09 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d81716f4c2sm6222775ab.23.2025.04.17.05.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 05:33:08 -0700 (PDT)
Message-ID: <89994086-e750-4dd8-9931-f2777890ab97@kernel.dk>
Date: Thu, 17 Apr 2025 06:33:08 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: blk-rq-qos: guard rq-qos helpers by static key
To: Yu Kuai <yukuai1@huaweicloud.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <ee26d050-dd58-4672-93c2-d5b3fa63bbae@kernel.dk>
 <207f1ba2-125c-66b1-a5e5-d336f3705ad9@huaweicloud.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <207f1ba2-125c-66b1-a5e5-d336f3705ad9@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/17/25 5:08 AM, Yu Kuai wrote:
> 在 2025/04/15 22:52, Jens Axboe 写道:
>> Even if blk-rq-qos isn't used or configured, dipping into the queue to
>> fetch ->rq_qos is a noticeable slowdown and visible in profiles. Add an
>> unlikely static key around blk-rq-qos, to avoid fetching this cacheline
>> if blk-iolatency or blk-wbt isn't configured or used.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
> LGTM
> 
> Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> 
> BTW, do we want the same thing for q->td?

We may want to do that - I haven't seen that in the hot path yet,
but I also think I may have it configured out...

-- 
Jens Axboe

