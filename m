Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE2F17BCF
	for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uhZX1/Ah"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bee9f626caso48374539f.0
        for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 06:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705416089; x=1706020889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AO1cGJ6yR5rhuGGsnNJ25N8iwi3HgScYUyOHxA7RNBc=;
        b=uhZX1/AhV88opPWcP8TYkVidtBr+gZjcpcks0JdhqNaNYX9qUzBw+IEA7II0xPgGvg
         fyaPH4Rr4OEeNOB4O1QK9MF2YEfblKj+zCWhyeN9Six+2yqRfmNndiwGPZIkSZRpB+L3
         gUJYls7MMUZ0Q5FaAEJT3vxy5WKF8EUac1VyRmSZIkhRHEUiCLkEiSFsQO5cadA1vlo8
         n29Jmy1ZqBHOeVRkVoO/DGg4GtIawW+tnFu9avdeZjBIz7v8Zb/O1oEO+aG8NvHb8BSp
         iUyTDqDIKYqK39daXEcsDaKMBwjtVzsKOQ0D4vj15d9NBD68YBLSxsGmli+hy+ChVM+Q
         Q4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705416089; x=1706020889;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AO1cGJ6yR5rhuGGsnNJ25N8iwi3HgScYUyOHxA7RNBc=;
        b=Y3NiJC+Py295CRw+CJyCBFCUEsWLgThyqM6M9aJM3bcwfnaBVN1zsw8S4nUZdR4aUz
         QR2oa/Mcd9W20diTbPAlC/P07EQ12wPe1eBMeD6PZjTAgOcne+E96zqn/OmOfF+4XY/U
         AcOAmZlgQXs/+SMUSwBCF3nKyOB2s8eN7uo9PB+clycaxc4+OuVYTCRSDgwIg9Am4HaX
         YA5Zlha5DecDozYriNqfwgcDuTfggvFDMa8XFdQlppbwOe5LD1JNEleL/hZv6MuWOpVZ
         xf40+SZe8ZFZODJt43OxV73o97A3LGUz41fWGwr5Y6N8drMLWiZZ2MGSaqUR1gc6ejJk
         5PjA==
X-Gm-Message-State: AOJu0YyHjo03IS9E5KsYsxTHU5OoBHvlqozaRySHxQ+k3hhCM0EHUEEL
	4a9OTDFQGw5t0+iBn+gVN3LledcmqawWIA==
X-Google-Smtp-Source: AGHT+IGEh6yRc5Pqp/2ull0BRDSZMtMmuQTOwd/w9S53EyIIKsQvqIoeVK2Ht/D6ruqzllzCYMQS1w==
X-Received: by 2002:a6b:c845:0:b0:7bc:2603:575f with SMTP id y66-20020a6bc845000000b007bc2603575fmr13648184iof.0.1705416089580;
        Tue, 16 Jan 2024 06:41:29 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gm25-20020a0566382b9900b0046df77733acsm2953403jab.102.2024.01.16.06.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 06:41:28 -0800 (PST)
Message-ID: <4493b71b-4596-4117-950d-5fe8aa11975a@kernel.dk>
Date: Tue, 16 Jan 2024 07:41:28 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: add blk_time_get_ns() helper
Content-Language: en-US
To: Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240115215840.54432-1-axboe@kernel.dk>
 <20240115215840.54432-2-axboe@kernel.dk>
 <a67e7a44-5ac4-b18d-b0c8-b0a4b42e1224@huaweicloud.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <a67e7a44-5ac4-b18d-b0c8-b0a4b42e1224@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/24 11:42 PM, Yu Kuai wrote:
> Hi,
> 
> ? 2024/01/16 5:53, Jens Axboe ??:
>>   @@ -2810,7 +2810,7 @@ static void ioc_rqos_done(struct rq_qos *rqos, struct request *rq)
>>           return;
>>       }
>>   -    on_q_ns = ktime_get_ns() - rq->alloc_time_ns;
>> +    on_q_ns = blk_time_get_ns() - rq->alloc_time_ns;
> 
> Just notice that this is from io completion path, and the same as
> blk_account_io_done(), where plug does not exist. Hence ktime_get_ns()
> will still be called multiple times after patch 2.
> 
> Do you think will this worth to be optimized? For example, add a new
> field in request so that each rq completion will only call
> ktime_get_ns() once. Furthermore, we can optimize io_tices precision
> from jiffies to ns.

Right, as mentioned this is just an issue side optimization, my intent
is/was to convert all callers of ktime_get_ns() to use the internal one.
The completion side will just not get any amortization of the frequency
of time calls for now, but then it's prepared for that later on. That,
to me, was nicer than doing selective conversions as then it's not clear
if the two time sources could be compared.

It isn't complete yet, I just did the main components.

Putting it in the request is one way, ideally we'd have completion
batching via struct io_comp_batch for the completion side. At least that
was my plan.

-- 
Jens Axboe

