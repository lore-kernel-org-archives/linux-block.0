Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06956F9EC
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 23:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470926; cv=none; b=rkxbx6TSpwhQPRnZq8J12W0rgcZ3y7FN6hG+YMWVjTuzoON6qTnXIvEW+0RlktEkoP+nX0bAS4KNCAKj61M5lmOoE4UFtFZZqSfjjI8xtQ8n7eKjCRCNoCM7O1tNTOwoLRZlCzDYBidi4+IdNoZqafzS5YpvFpjN+1iQJI6HC60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470926; c=relaxed/simple;
	bh=/ApYtlh3gCG0aZsiGKR6xNT252Ya6PKoxr+EOJYDEiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D3szrViZHqo6yyJVsk4wO8ebctE1D/ZaqpWbih6roOEu0IxIwwl0iVZozK3NNRZD7RFwOouMNdZ/29UJSqSw2KXrd9qnF96Z6Qp6EfrOyzhTmLpZoO2TS61bBonEf7/iEI3s3d1MCVxflko2pqHTIu9clahFyjhGRQaK81NVY0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Knnj/Qub; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Knnj/Qub"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8801f4e308dso1823406d6.0
        for <linux-block@vger.kernel.org>; Thu, 06 Nov 2025 15:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762470923; x=1763075723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FZDEIf5IrOr+nJD+jA/BAmbVKjZW2zFQ6TjjvXtBWfI=;
        b=Knnj/Qub42aYpTgNB9bN6I/zujoj/Lm+COUtcU0x8t5b9Du0p+zqdSxUskMkpxa1Hz
         NzZLuAI82QpfC4qiMmlEc83LMltQKEhuTyuYDM6FFOvwJkVYIBUoo7wj/4TXelStpVgu
         jjbv5aDfm6gOEauyTur5jZX6nswPoRDTY5JsHVNKVqIE19ufCSMwdrcNyefx5awuuqom
         RKrHF0QG0inqS7yubcLmjruDlNizxOgXJrrK3l7Qb/1Jk1mAv9bd+wb0m89Qb7uos7hm
         l5NqeC5TAKloLX2sYvFNT2rgSYivN9uUBL6kVxaNKxdZPIgLRhkb1q100+YNUDFgseeR
         DKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470923; x=1763075723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZDEIf5IrOr+nJD+jA/BAmbVKjZW2zFQ6TjjvXtBWfI=;
        b=NCxNkSvlm9bVgfeDCcy2kawGgJMwxNHfTPbed+aqcvws1GLQygATU0Cb7teOfbkHzX
         229WsFqW0NEnPxPSAJBYKYS2HZvoN+uNM+W6FUp75L34fRmSPG5TwRtaHPcNjKUa2FZ0
         uxw1bisrrUi02rNrdJP5KVMjWcnIQX8P2xlxEyVeL8g1amqpdCGXx1YDSB+/gkqKRlXG
         VpnVIe9fF7BDmV7CwkVq+lAKd4fAzvQylBgT2OCvEwwF9nwcm8Tg+Di3nmDQWPGjDxK3
         VGDeP6XYx7dBspVSJDSXYykDZIKPbbHWBAdw/Hp6ANqPoCGnng5xMVhNz+G3ze/oMEwO
         8T7A==
X-Gm-Message-State: AOJu0YxQCY2jLAutYhCwmzebnEk4UBqDIHDXmj5TDLPBfBim/2gHdCHW
	aXJMPxbOgC44Z1HKaWsa3jhbYkDMIuQr/BfVXH9fKfh32KmUE0uhvzYtjCVgCXA5m7E=
X-Gm-Gg: ASbGncuYm5YU4q4r9MxYpC4kZ+EtkRn0A9yTQ6ybkJD593v7dN3Tpmi6vYT/f8s5npO
	2mjca/igKoGhPYPUo7WofS0DtCEcf5Oyu6CDKZm6q9nRpNVKrQOO07gOoW9o9ByERfTyZd6UiSA
	loVq+PhxDt3alU+CcAzVTHjClXyebYfSp7+pNx0o31A2Mt/BXEr4OO3S6s8czOddMkUBZ0pg/V5
	ACb7UQZCI8b20qmRSqaswBcDjG3/JZHDYIrqp2daU0dE7ewmrC3WAru97W6mBKGEAsUik/eBBuA
	fxEH2JjKyqzZ8noSxEDlY4DmfE/MhRrnRxQo54Hvv5cx5V9l89gRr8k+bVy5mSNsypLEOhuEAR7
	fq0p5Ip80n2bU85XMbC+67aGvyKGIM1hBFNRKvOJR7sIcZ5T/BJU6ecvPINXl3SiTcgRa6n3GJJ
	/0wRVUWy4=
X-Google-Smtp-Source: AGHT+IH36s3Afd173aHhLPBFtGHn8HzKX+TYbHJJEFVcOd0l+fZf8vGpX9wUoGN2Ykp3Ath+jVKsHA==
X-Received: by 2002:a05:6214:d4d:b0:798:acd7:2bb with SMTP id 6a1803df08f44-881767620d9mr18180936d6.51.1762470922648;
        Thu, 06 Nov 2025 15:15:22 -0800 (PST)
Received: from [10.0.0.167] ([216.235.231.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880828c4570sm29589996d6.10.2025.11.06.15.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 15:15:21 -0800 (PST)
Message-ID: <6f4b4e85-6ebb-4f74-9b56-f024b0a3782a@kernel.dk>
Date: Thu, 6 Nov 2025 16:15:20 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: fix cached zone reporting after zone append
 was used
To: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org
References: <20251105195225.2733142-1-hch@lst.de>
 <20251105195225.2733142-3-hch@lst.de>
 <ad303562-5b34-4156-94f1-516787e873b1@kernel.org>
 <20251106110058.GA30278@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251106110058.GA30278@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/25 4:00 AM, Christoph Hellwig wrote:
> On Thu, Nov 06, 2025 at 01:10:28PM +0900, Damien Le Moal wrote:
>>> +	if (!test_bit(GD_ZONE_APPEND_USED, &disk->state))
>>> +		set_bit(GD_ZONE_APPEND_USED, &disk->state);
>>
>> We could remove the test_bit() here and unconditionally call set_bit(): single
>> atomic op instead of 2.
> 
> test_bit doesn't need a lock prefix (at least on x86) and avoid
> unconditionally dirtying the cache line.

It's a common enough trick that I'm surprised it isn't documented
somewhere. I've used it in the block stack too, since a long time
ago.

-- 
Jens Axboe

