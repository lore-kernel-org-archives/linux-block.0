Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE28142068
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DLqGcl7w"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso47935239f.1
        for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 10:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704999023; x=1705603823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Y0Y3lcXs1CkGENA+5723JFop/quNxoTFM/pVeOizRA=;
        b=DLqGcl7wZmFbWsj9Ur9wHbIQjQ9yuET2QuLfxdKatvgWD9FeOo32nCAIPj++1saBEK
         OxTRyrGAT/PNse5REpNE0q5Ryqj32EUzknZ5UfgetHNewoAZ2xdXOH3OjY++SCQGLuMT
         l6ucOjknCvUDh3OizoVAavhP69C9ZOkF+OK4Fc2aCxS85Iafy4+dLffYQ/47wnBp+MrF
         w33USGXLs78G8RtbNYNpEUspJ4XoMfW6oTWQZAjBs3R2t7GBlGCwTMS9vndgayznISx3
         P71jM/AOYCQnbj9BucjrCc53gMkcZCfXvWG8Q3TP12s4e28fwo56a8if/zxBXy5RFQFB
         1qiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704999023; x=1705603823;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Y0Y3lcXs1CkGENA+5723JFop/quNxoTFM/pVeOizRA=;
        b=S6ATEeLm0e4n8xDxlx7JwPbsJAgyuQKTvtF6HVguiNK9P26+UhkicvAJOL2E6kcy02
         lvu4eZMA7XdCw3fBRmNhWhNRz8FKhD4P5xk4s8LDoubRLRGqNCKy5GmFcLmaIDhve/hw
         kA/NrU+0vpoi9Bd92qUJxY8IBykQpcyjkEYkPPWKLM+oUG5MKZSot6+pPcqS6P0miGjm
         g6fjOFiULspKfoJ1PwjQsc86YMD+uSDiRxoG7AgPZftJyN8uIBJi9IOJjnYto+1dzANc
         bx83WJGFN5kLLqkuNAALElbgjE9IFpsDrVQTiXCa+Vmd9qIkZA5cN5s4aYrN3QCWif/K
         BR+Q==
X-Gm-Message-State: AOJu0YzctMvH1E+v1hY2rbjpERpblIn14wrjcopaKcT+qbSpkLRFwHh6
	eu/ks+J6jocUGb6ZFn31tzq4c9Qp1WnLC0dCDSjwiWBY6kRXdQ==
X-Google-Smtp-Source: AGHT+IE7TTmq6ikTJAPj1V/ogM+wvYI4r0HkEK3Qg1q8c0hlZ+NByE8LjEsVNAFsKvd6HS8r9y2+Ag==
X-Received: by 2002:a05:6602:4f14:b0:7bc:207d:5178 with SMTP id gl20-20020a0566024f1400b007bc207d5178mr179246iob.2.1704999023671;
        Thu, 11 Jan 2024 10:50:23 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id s11-20020a5eaa0b000000b007bf1c0b408fsm68728ioe.32.2024.01.11.10.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 10:50:23 -0800 (PST)
Message-ID: <84b3a60d-876f-41b6-b06d-06a15f118b7d@kernel.dk>
Date: Thu, 11 Jan 2024 11:50:22 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] block: only call bio_integrity_prep() if necessary
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com
References: <20240111160226.1936351-1-axboe@kernel.dk>
 <20240111160226.1936351-4-axboe@kernel.dk>
 <ZaAXN7MI5WPkdAvC@kbusch-mbp.dhcp.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZaAXN7MI5WPkdAvC@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 9:28 AM, Keith Busch wrote:
> On Thu, Jan 11, 2024 at 09:00:21AM -0700, Jens Axboe wrote:
>> Now that the queue is flag as having an actual profile or not, avoid
>> calling into the integrity code unless we have one. This removes some
>> overhead from blk_mq_submit_bio() if BLK_DEV_INTEGRITY is enabled and
>> we don't have any profiles attached, which is the default and expected
>> case.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  block/blk-mq.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 37268656aae9..965e42a1bbde 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2961,7 +2961,8 @@ bool blk_mq_submit_bio(struct bio *bio)
>>  
>>  	bio_set_ioprio(bio);
>>  
>> -	if (!bio_integrity_prep(bio))
>> +	if (test_bit(QUEUE_FLAG_INTG_PROFILE, &q->queue_flags) &&
>> +	    !bio_integrity_prep(bio))
>>  		return false;
> 
> I'm confused. The bio_integrity_prep() allocates the metadata buffer.
> Drivers that were previoulsy using the 'nop' profile for odd formats
> don't get a metadata buffer anymore?

Yeah, I just came to the same conclusion diving a bit deeper into
this. It's a bit of a mess imho, but you are right that previously,
by default, we'd get metadata buffers attached with a dummy profile
and with this we would not.

I'll drop this for now, I think this requires more involved work
to make this sane.

-- 
Jens Axboe


