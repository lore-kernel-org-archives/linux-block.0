Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EBE41C2E8
	for <linux-block@vger.kernel.org>; Mon, 18 May 2026 12:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108024; cv=none; b=ETlbe0a/ANfXLSHqxgc4bTRrkbxzowYh7L/CuVKtWTHWr3MW6gkTGf68m9PGw2Snk7+xcDcpkLJ6bRtJ6SI6sZSS4mGvMNwADrHtqFlwMr9ho5ybpL5W7TzdjlDbrWy6kaYJYi6qgB2V4hroo/+MbK83b+TnwLwkI7ymzrPNnq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108024; c=relaxed/simple;
	bh=Mcv0gCsXAUFhkjqy5dwsfsmky6PBnJ9/bZQl4jFqXoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1LXzj6EnoLEvjxYlh5SlYy9L1frdRZH7opBeA0nMP0EPM8wdm3Of5LGYFg3RmzyGFURcEnLF3e8k0ZVkbWNOdL6BGZhtqRaR83rqZV5TkC1PyQB3ltSEChSIkfH5o/6ATIT0t9EEOWUpcjpBSgnjZuPdSbSVpvAHrziLuyy+VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldE6kcPi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldE6kcPi"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso16779455e9.2
        for <linux-block@vger.kernel.org>; Mon, 18 May 2026 05:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779108021; x=1779712821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QXVLM8myHSCmhmEigozDJCG9BugvlW9svyQsziHjoMk=;
        b=ldE6kcPijQ/Hej3uTb2mO+vEIefs2sqY1NKId/V+147wlqd3oqIKkGon8DEsKZa5dk
         T6Ix7dztbeyZ45XcmyYdewf/zIUmYooD3KWj+I7aYQaroDlRCD/Al3Nz/suqK0DJrB9n
         hpmHIKEFi6UPyBYwKC7D4LacIPfYR3QPnxbfoKiQH5ZcA71vDhee1bs+jArrNZY8nOY/
         2fZ/a7g7sOa9ZQtdBWmCI252Pz4WOB+qrC9s4x4nmAJ3LtQlj+uC35X9HztbaGmDWYZu
         MSFcZajGYOABIfHqGsgYm9Tp0nsR2VcLRag533bANJQsH90f3lv2QHY5SpF3ElD9n196
         0Gjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779108021; x=1779712821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QXVLM8myHSCmhmEigozDJCG9BugvlW9svyQsziHjoMk=;
        b=al+F3gNvIuEL8MNMvjA3gKfs8W0LXxvDJ3oSDIFeoKnMidknY6htovFV3xJ01h2Z8Z
         QJt55ZTR97u4OT7rat6gx6YYx0S6Tj4scsdEosocU43Vwk+W9lIKVJX9lDY2vYEApq0w
         YPA+p773AtNOHgoQboUEyvZQxEuf2VKXkILcRpqCg/Yji12+lFmEjx4eBmDaMfp3UqDN
         uKfq+tLZ4PnJNJw0qsGryLDlaWf1X3fQTXPtl7IxE2lWwol40tI538n9kztS3gBd+aRw
         wnIzR6p7ddOm+MB8vyssF7395sDxrQWmRQr7+aWALNdSRqzajesFbjwHjCUyrKszGq7I
         V0Cw==
X-Forwarded-Encrypted: i=1; AFNElJ9Ui3/UIQ0wM9yPYHY8uFg62J7lxHFSkjb89Z7vCehXW8cATvFrYPKZLOe1VvNm9Iu5Swj7AUsfazQQIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9gzxZvuN0viIFlcY7MB7adyEDEXmEEOcWV01iN0Se5YIyQe3p
	Zo14asUgQXoesIYXH3hjIznZHdvTYLxEs2QBGQydU7VfIWFYoe6L23Ku
X-Gm-Gg: Acq92OEZHLE5rN9sdUV/6w+oKnbCc5Dk4xyGl/E7pm4bZGo0xOFst0KCCv8ka5Y8YEG
	q3VgGOvSCFMod1odB/zMBt5H73fjV9V58P/LzWVKAMEJXayEgWUA3BP/t0EUW4gaRjzsUmO3Pnd
	TUD2kt3KIKdhcarUEra8yyrVx5eBRy/ceR/XBmMp5OC743nZ9y9HtdSPtQh4oROGE65BcWR+Tma
	wcRbrVapPuzY+q8XHop5wV8dAGk09ux/ugmq9dtjQwXuYY6iij5nOzMI1VivuYaAiBytMQIpL8q
	GOUoge+cDAurukB5qPnQ9n04OsRWaSl6ft7TAuSdWuDMHQg0U1YDXGpMW26dgqaM0NJff5OjjQN
	vNQpS1puRKAUWD7vhLJM3JsD3fTDUJnoTArtuU6RxIPouUs9/eTJGChbcLhZQY6S3WBCp7nA9kI
	9Qb2/zBiX17NDTx7zPY+3QblKkrEAxgaRNe5adHBmpwQwlK4v+1ssO+yT6nzv04fHhq3bKq1knE
	ydiFzmi6oU8Ap7bZRH++2pfeck5UtDDuLtDcpCSGgxAs/yNdzzFDRc7o5d+141E+neACk1hmGAZ
	Hy9fM5Ko7dfA
X-Received: by 2002:a05:600c:6592:b0:48a:557e:6b4f with SMTP id 5b1f17b1804b1-48fe62f8861mr237008575e9.23.1779108020601;
        Mon, 18 May 2026 05:40:20 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8d39esm256597555e9.7.2026.05.18.05.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 05:40:20 -0700 (PDT)
Message-ID: <4561c621-817c-46be-8ff0-0b557f6c819d@gmail.com>
Date: Mon, 18 May 2026 13:40:18 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] block: introduce dma map backed bio type
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
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
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <df697a76-c700-4908-ac08-a47ad07e0796@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/18/26 13:22, Christian König wrote:
> On 5/18/26 12:29, Pavel Begunkov wrote:
>> On 5/13/26 09:19, Christoph Hellwig wrote:
>>>> +    if (!bio_flagged(bio_src, BIO_DMABUF_MAP)) {
>>>> +        bio->bi_io_vec = bio_src->bi_io_vec;
>>>> +    } else {
>>>> +        bio->dmabuf_map = bio_src->dmabuf_map;
>>>> +        bio_set_flag(bio, BIO_DMABUF_MAP);
>>>> +    }
>>>
>>> This is backwards, please avoid pointless negations:
>>
>> I can flip it, but compilers tend to prefer the true branch. E.g. this
>>
>> if (cond) A; else B;
>> C;
>>
>> can get compiled into:
>>
>> jmpcc cond B
>> A: ...
>> C:
>> return;
>> B: ...
>> jmp C;
> 
> When that is really a performance critical path then you can use the likely() and unlikely() macros to give the compiler the hint which one to prefer.

That might be more penalising than placing them in the right order,
and it might be fine as it's new and all that, but it's not a clear
cut as it's definitely not created to be a slow path. TBH, not sure
why we're bike shedding such things, is it somewhere in the code
style?
> What could be useful is to have the true path for the more common and the false path for the less common case for documentation purposes, but in that case I would expected some code comments as well.
What kind of comment are you thinking about? A "this is not a likely
path" type of comment before each mention of the flag is usually not
very useful.

-- 
Pavel Begunkov

