Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77653481238
	for <linux-block@vger.kernel.org>; Mon, 18 May 2026 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112800; cv=none; b=kGs3K6VobfBacLsHmYOFCSanyFpUp2AQGflQsh8iSBUkDhrn+BGnEYnF3YBEeXUCm4l5VbmmQWMh7cAeCLTjo/Icxbo07hodJudx/LT+5Qpu8kLiZqrxNPsiK9dMdqsvvh1B2RxYlGacMaHhcWVb6fXn9jWQBNT5oaluXx7h3JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112800; c=relaxed/simple;
	bh=MXTgLfPj/f1h325rq7FWLxCdh3CeoPcDyvJ5aI3aWzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/BoOFEXdBnv7qVQ+iczN2UgYLihbzdPSIqpQ1WlJaQdRTLm5ntYsRg0FnkdFHqy6tMHeCmbRE+B48GQxonVzwbrC7ttkb6o//r6n3DcoNAVbfbTswzo4V/fCMBYZJINhbbEOgIzZzvvSNWPW6sFGv47YhX8rjZpcxxepJZ6OKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOOc+c5J; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOOc+c5J"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67b32c695efso7118976a12.1
        for <linux-block@vger.kernel.org>; Mon, 18 May 2026 06:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779112797; x=1779717597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+WT00WHtAu4WqCgP+skKdKZ8K4Rq+JbbmW7SvyUtdIs=;
        b=OOOc+c5JDZpSmhka23oYEOg+ROkjXJVULMzl2HVHv64Ntjq7Dh8Yd7RWeENxZo9ps5
         KZUQpoIuFMqYgZJmDwjQxwB9VWa7YEtiEWSD1JL3PWwpiwM+iGAcC9vmq8YL+1ZFZcnk
         Pw7BriH8opyUYq0yCxYVdVr4gRcncSEPsnVSvWEQTvF3Gm3bMk1b44T8BMKI9eX9k7Wh
         kk2zXj+9okLSUDZ1fQx0DR9R826qiAdQVWZvZbkPFV6XY3r/jAiok7Jt+DEyvjUZCL3C
         JI8b1ADQtCWzvtZQ+TMmSzNjjvGM5O4y9DKH7WJ0ngBwdJT37RxaXUC/saca5NI91v7m
         2kkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779112797; x=1779717597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+WT00WHtAu4WqCgP+skKdKZ8K4Rq+JbbmW7SvyUtdIs=;
        b=SAZDiDO41jAigp1WS9wuSZtJQpW4VxEnUbBltKHQ7WYGOotgmzpokpy4G/krELaBgP
         kTpXLR6GNVMB4gda7sHsecTXvwMptWKmapxsOcWZDuorTgnufGyRGtUess7jXeAc/Ybm
         jyzT7/F4SIMPgLyc2Ogqsqz7gbsbp+vJPD0iJ7BqWDNN+/scQy44C+5EsODhj+5XDo82
         BNbTiHEYFGY4EliWH5xDTSetwU6P3FsImcK+W+2CAfsWRewaDvDAcQa+PVK3kdEzqNa7
         aMjIGjW32pKMXLTrRb70QWuJuDpOebkvuk2S+izX4bXuMkfGdrHWUBmd0NfYxaSCEWJ1
         ForQ==
X-Forwarded-Encrypted: i=1; AFNElJ+UR4e0QjmyFBWxoc2NAUF0wiqVqndvwIpzUHOOWBSMgUu/R6AlTIfojKyZoC4YtYdKY+Fh8MYFAswoOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxL1xPmo8TWfXyDJ1ExBVHKsgusBWKG0p915X0xAFK0+TmqXVrE
	v7ZbcifVxNQogo3P8SUp/AFGuWyysOZl8gVh1rk9ipYU7L8e7fjVgh0B
X-Gm-Gg: Acq92OE8kEWNCF4R6WO9Wz3ZVoGp0njct7K0dprJCCo/hftVg8EmzPiPBUCTul6Y5kr
	BK5POM5E/oHigsoJAzQiLCxOF/iAVF4tLn4eDS0yhPVJq9dLZfZZ5nppPACLmbT0QLuQgRh2pCs
	R7mkIYgq7Uv0FlIjc+AuqUDP5I2VSAeZD/n9wYNW/rzFH5Z/ZEXLfUpBNjcPuLGuiGaJL7fnUly
	JZL2cMpzF9rF0wWxNKQOznbG30167ICF3vFgKfrAIRM0P1xLRGOXdiSXOaH5FIY97SyAtBo8qm7
	3ByEO3gnOtpg5ROknG+3CvXLhsx97tJ4iBoRIjg0q54fM4Anmlrp/0ZbWTkYhs0J+9g3VgxlKlT
	bc+ZktmA8pSSX3EBxZz27vQ3JuwyTm3yg3CSacUYRXqdXK+BdEE16yRw5gxgpPIjXHfKbTsQpxZ
	Q25jzplwIK4gtU7cwIl7sXhyKtKlCXAX320Rj9GcvQjKL0uc3ASf7HC2uw7eFNICc6RDYBXncJ7
	CO1M+9a8Ag8NUUT0fiP1O3TZkUSafKRToiWOqmx4p+DLWlNJ/Vnyq/6LlK8AKOibYNGUB1sdLiX
	Pz9h4MGYGZ7v
X-Received: by 2002:a17:907:3f1d:b0:bc1:7da0:21 with SMTP id a640c23a62f3a-bd4f34bd0e3mr858876966b.23.1779112796524;
        Mon, 18 May 2026 06:59:56 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4dea94bsm565057266b.33.2026.05.18.06.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 06:59:55 -0700 (PDT)
Message-ID: <166da921-77bd-422e-85af-ef67d6fccc42@gmail.com>
Date: Mon, 18 May 2026 14:59:54 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] block: introduce dma map backed bio type
To: Christoph Hellwig <hch@lst.de>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Nitesh Shetty <nj.shetty@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com>
 <20260513081929.GD5477@lst.de>
 <24833f76-2289-4859-86d1-9215b11a1258@gmail.com>
 <df697a76-c700-4908-ac08-a47ad07e0796@amd.com>
 <4561c621-817c-46be-8ff0-0b557f6c819d@gmail.com>
 <20260518125713.GC5754@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260518125713.GC5754@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/18/26 13:57, Christoph Hellwig wrote:
> On Mon, May 18, 2026 at 01:40:18PM +0100, Pavel Begunkov wrote:
>>> When that is really a performance critical path then you can use the likely() and unlikely() macros to give the compiler the hint which one to prefer.
>>
>> That might be more penalising than placing them in the right order,
>> and it might be fine as it's new and all that, but it's not a clear
>> cut as it's definitely not created to be a slow path.
> 
> Yes.  Whatever the caller is using at a given time is the fast path here,
> and dynamic branch prediction in modern cpus handles this really well.
> 
>> TBH, not sure
>> why we're bike shedding such things, is it somewhere in the code
>> style?
> 
> It makes reading the code annoying, so it better have a good reason.
> Now for a single conditional it's not much of an issue, but these
> things tend to pile up and then start to get really annoying.
> Always write your code the most straight forward way unless you
> have a good reason not to.

For me, having the most common case first is more natural and
readable, but I'm going to flip it just to avoid spending more
time here.

-- 
Pavel Begunkov

