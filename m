Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D9714A8A
	for <linux-block@vger.kernel.org>; Tue,  2 Jan 2024 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="C5zJ7uxX"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36016c6e19eso4043435ab.1
        for <linux-block@vger.kernel.org>; Tue, 02 Jan 2024 07:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704210459; x=1704815259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ySBFOJIM0DSvIVDKhQcLqvBT2yyLab4gqIewIhfdbtY=;
        b=C5zJ7uxXGYqBgl1NpgoOSuA7SP2BBeUjv4TRU8MCeQpj4fpi4ZO92a7MofpFmLzoan
         DrsZCtcO1eVAOWa5H54qkDGN743LyFSfmZHLztwRiikfI5VYdFCiWUso5ZwJdrsp/l52
         maYJVrnFv+Q9Rw5OVFxYCpYhgd6XXJu5caf8hSP3uZhmXBLMpIAzIdSZF8G03aiWlqhE
         WePrt5pJ/o5kDDbll9j0tH7IISFR2h9JDkB8ph8628RVZdpRXN3c1NjibdDizTy0xGs2
         oGKqIWRfDBjyRTnmaFlLQ9MiUlTwUaaE5rtBNfjtRLNGyWtOxsk1ScVU942Sm+OmTEkR
         G0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704210459; x=1704815259;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ySBFOJIM0DSvIVDKhQcLqvBT2yyLab4gqIewIhfdbtY=;
        b=VIHRfKh75Cc/tVOJgVNloBshgTsn5YfWE64xhC99rgzhU7hnFd8xQcE2ERUFyS34Rt
         DgZlOM5fR5cKV4DGc3F6tU5fQMs9W3DounXG3zIq9OTAK1P6EzM+NUOaXsuFmeSd0VCX
         7Ig9KJ+2crCIFvkjkJaDEwCYGZoX4QUSnf+7DXCMnxa1GaV/XTMji5UFKwOL4A969Kzk
         zTucTF94cwbQq7ftKxbzPQciRfc0ZWtExoOfXfAnDCj7Ak51SXH10oDJJYCQpF/daTpZ
         fMaRqbPguovxF2w/nKWzj82TJMWoT7E0kNnBzPUdhioe5PpPtmYPbte8EOsHuh6p+6VF
         cdKA==
X-Gm-Message-State: AOJu0YxIqwrznN1eK3gLO3Nkls7WprWqkuVE9aSNMyShYlzxFQEf1WZP
	JncwlQWL9fLNJaxGK0fMybmBD4WeJUpMDA==
X-Google-Smtp-Source: AGHT+IFs9GZ/Ey7ptKHRHLLO93hZlIAauQjofaYqCnhw5oeOlPvARiPsQn3KTgYcoEx49b9b2zgL8Q==
X-Received: by 2002:a92:c26f:0:b0:35f:efdc:7738 with SMTP id h15-20020a92c26f000000b0035fefdc7738mr26703798ild.2.1704210459220;
        Tue, 02 Jan 2024 07:47:39 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id cb6-20020a056e02318600b0036003f7ce61sm5383610ilb.87.2024.01.02.07.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 07:47:38 -0800 (PST)
Message-ID: <92011368-a4a5-428b-9801-26a6a6a96752@kernel.dk>
Date: Tue, 2 Jan 2024 08:47:36 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] zram: use the default discard granularity
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Josef Bacik <josef@toxicpanda.com>, Minchan Kim <minchan@kernel.org>,
 Coly Li <colyli@suse.de>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-um@lists.infradead.org,
 linux-block@vger.kernel.org, nbd@other.debian.org,
 linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20231228075545.362768-1-hch@lst.de>
 <20231228075545.362768-8-hch@lst.de> <20240102011543.GA21409@google.com>
 <400dbdbf-e99e-4747-94db-54fb6674fdd5@kernel.dk>
 <f3758a5a-986f-485c-9a6b-c11af20c3aa5@kernel.dk>
In-Reply-To: <f3758a5a-986f-485c-9a6b-c11af20c3aa5@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/2/24 8:44 AM, Jens Axboe wrote:
> On 1/2/24 8:40 AM, Jens Axboe wrote:
>> On 1/1/24 6:15 PM, Sergey Senozhatsky wrote:
>>> On (23/12/28 07:55), Christoph Hellwig wrote:
>>>>
>>>> The discard granularity now defaults to a single sector, so don't set
>>>> that value explicitly
>>>
>>> Hmm, but sector size != PAGE_SIZE
>>>
>>> [..]
>>>
>>>> @@ -2227,7 +2227,6 @@ static int zram_add(void)
>>>>  					ZRAM_LOGICAL_BLOCK_SIZE);
>>>>  	blk_queue_io_min(zram->disk->queue, PAGE_SIZE);
>>>>  	blk_queue_io_opt(zram->disk->queue, PAGE_SIZE);
>>>> -	zram->disk->queue->limits.discard_granularity = PAGE_SIZE;
>>
>> Yep, that does indeed look buggy.
> 
> Ah no it's fine, it'll default to the sector size of the device, which
> is set before the discard limit/granularity. So should work fine as-is.

Replying to myself again... It does then default it to the logical block
size, not the physical one. Which does look odd, seems like that should
be the physical size?

In any case, this does change behavior for zram.

Christoph?

-- 
Jens Axboe

