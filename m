Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177265026D
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2ysZoSs0"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-360630beb7bso3836165ab.0
        for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 08:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704989863; x=1705594663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gGFCYeJ0KcfGjB9XZoOHmxzp6z5RsKlCVtTHrcyBPdA=;
        b=2ysZoSs0BVIEozfwOxQSWMkzg8puxRrvxPEr3uTSUrDO9QovSfBor/6TDjRpQ4YVGJ
         fhgCjeez60M/u066HGRFyKxqGa4uW3Gx8rcsrHRxRI7S0PCyqKvyOGaVmCHZD44BTyuu
         l2vvimW6J9W9tweq1yiqGYAwQOK5QMuhD/YYLSfTf0Gn5iC9Go8idEChv3uRrxEsnIJd
         QMPHN0Ieu52ok+6KlMiqRuQYQHK3KdZP4Ez/Fjr3++sP71+J6I9fW3zjYy9ChnLgiaPu
         ZwD97K8DbUhD/d0uzXSbddp4iye0FjKiJmAICYsXZtH/An2GRKZChbLlbqXKTHC0kt/A
         v16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704989863; x=1705594663;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gGFCYeJ0KcfGjB9XZoOHmxzp6z5RsKlCVtTHrcyBPdA=;
        b=KeOunIpviE2EnRbPwVZFqAOXbbH0B0yOaGH/ZgvktXDjylhJI3CBi83v5H5P0v276g
         Vq7XqKghFMxe7W4EWsoARAIy3pPobUqHr1qHQ9s/O4b6YNwrZ+2seWQ5kNEH6Rlz9FM5
         4Na2+2Mz7RFWlCfDgJyz7YuGwf+PSGKLtzvFSbpQstD+G/R9A9pSHXaaKPDu1qG+qH91
         PBKsp9C4zKP0RNlXZC4agzryA8adogh8JwPkICRqa+4QLoUnbjILA7smjP8eUcKdFWNY
         dpbpMQKRTAJ/oVluTcxXBeSSVGrfw33AS2m6LprrRhhTIuvhw/C9ulEVa3VnpNwD3kyh
         2qRg==
X-Gm-Message-State: AOJu0YzqlQrzvi7WXqX5L9boL4lxFrY7ChIK5M4EhmybOJe02dmduHro
	z3j+KJpSNSoGKcNNY/eBJ2SBDcMkZCAtTQ==
X-Google-Smtp-Source: AGHT+IFOBrwqRm4xfs66279Bp3qH/dzWmMwqpaTTaODyid9L5wXn6NjYTIzx499BE8Db7cNsuLYihw==
X-Received: by 2002:a5e:df03:0:b0:7be:d855:4893 with SMTP id f3-20020a5edf03000000b007bed8554893mr2731277ioq.2.1704989863151;
        Thu, 11 Jan 2024 08:17:43 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id eh3-20020a056638298300b0046e578ed0aasm224566jab.96.2024.01.11.08.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 08:17:42 -0800 (PST)
Message-ID: <d91cb6ee-50bd-4397-b82f-d34dfc135b4a@kernel.dk>
Date: Thu, 11 Jan 2024 09:17:41 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] blk-mq: ensure a q_usage_counter reference is held
 when splitting bios
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20240111135705.2155518-1-hch@lst.de>
 <20240111135705.2155518-3-hch@lst.de>
 <d713fe1b-3eaa-4de4-99a6-5910247ffad5@kernel.dk>
 <20240111161440.GA16626@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240111161440.GA16626@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 9:14 AM, Christoph Hellwig wrote:
> On Thu, Jan 11, 2024 at 09:12:23AM -0700, Jens Axboe wrote:
>> On 1/11/24 6:57 AM, Christoph Hellwig wrote:
>>> q_usage_counter is the only thing preventing us from the limits changing
>>> under us in __bio_split_to_limits, but blk_mq_submit_bio doesn't hold it.
>>>
>>> Change __submit_bio to always acquire the q_usage_counter counter before
>>> branching out into bio vs request based helper, and let blk_mq_submit_bio
>>> tell it if it consumed the reference by handing it off to the request.
>>
>> This causes hangs for me on shutdown/reset:
> 
>> which seems to indicate that a reference is being leaked. Haven't poked
>> any further at it, I'll drop these two for now.
> 
> Can you send me your .config?

Don't think it's .config related, hit it on my test box and then in my
vm as well. It's likely due to batched allocations, would be my guess.
I can start/halt the vm fine with just a boot, but if I do:

$ ~/git/fio/t/io_uring -p1 -d128 -b512 -s32 -c32 -F1 -B1 -R0 -X1 -P1 /dev/nvme0n1

for just a brief moment, nvme0 will hang on shutdown.

-- 
Jens Axboe


