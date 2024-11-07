Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF212170B2
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 23:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731022033; cv=none; b=TNVuQxIMawml6gLgHH5XBxYxj7CF7MMzlG2yrqLF5O8ni2NeauW20PexKCX4g1vv7PoUXyZ2v7HwXkLZjU1UCAteEep2NLKsNZcMaDpuL99fXIsohhbTS/LQQ9/H+GTXOp1osJK0gFQ+Uq6vo4IrJczJy2liqrcCKhz/SAdgiRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731022033; c=relaxed/simple;
	bh=R24pBbUsLdcjrGFo+digg2Qk/kM/BAe7DQQ8kqbMOJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxjsx2WMpA5hZ+YuHRaXOKmPrBFpa7i1wF0n0Ta2DAlFqa4WUcJDFXfFO7fV2G9eR097Lf83ycYL14RTgui9mzvwXmEac4Ex2Xc3ejshrzv1khM6phW4ZTit2MfYJKIhht/y3WA0Qbdplg1keH5KLAnAJDxz4k0WZ65HC2YNx4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xcxYtj6m; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xcxYtj6m"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-72410cc7be9so680504b3a.0
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2024 15:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731022030; x=1731626830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sMndnABs/yn3sDeZnRicouWrldSwOMd0CcgOdJuPLfI=;
        b=xcxYtj6mDBQSYhU8d96gbwuyz1cgduguBYFiWXeyLcveLkR+t0YBal/2j+1amDZvZf
         6Ojx0stCwdu6McK4eJ6wgWzAod4W2GQvfi2ivVA3SqbMb4IZZl3eDjs6nodmOOIVjjne
         8jZvpvSmMAA+J6rvcwn5pBuUoeybDOt7lSvB0Cmx1/0moPK5mQD0SYYfU6iB1vbS6JAK
         I2MDL3qeUwxBtyAUEhNBR+7YBBHrsbwsS1PBdPKrjAkSQJBArrVfB/aRJrC4I3ZwRKbd
         XbA5HG/uIPxqQQoznIl/BJDoCC7njffxoYP0lzctUw5Fn0z5QK2HryMftK41+V9/dUpr
         9yCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731022030; x=1731626830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sMndnABs/yn3sDeZnRicouWrldSwOMd0CcgOdJuPLfI=;
        b=dJLjuG0N81MeFeAX1YcRdcCzmHE1pbxT63GidABshRz9MbkajRvFhya1q0XTPccJoR
         LhAwO/IJcuoJEyrUBEadX3VLhs3lM5LgKICT4fsu6MW0J0IylNZTgf4kG4jFIxXy+2vB
         o2IEjlAD3QpEMeIL9jsDylaAy5RT6/+DV0kVzcDN0sHhreikvYmzaJlJtH199PzRPaI2
         dwrOhyTinoVU8tbOFoPW41IBXVupF3PYNl/DwJmGehtcVeep381JWs3s/8Cr+EQSMwBP
         I5x0uvaYSffxGi+JQqvWd7xZ7jw/J4sHinRzKg0AwZng4BF9AyKNYf5Luaxhllz+CM2c
         axPA==
X-Forwarded-Encrypted: i=1; AJvYcCXh2PmytFIgEkI/lkdgmfNbc0iqy+ATCgNczcaDWXpB572oWSZw/6/mL2e8yfoIZHV4E/k2epBYZzd3bQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZVN9yyZP93jcYJLq/133cDPo6lbSwZJJgF07oWscE6WF7mBC+
	18vEfIvvYzaOb+YKgagNjX5yuAGGLf0OZzFTzW6GQgyhGv3IrjNwE9/pWhb2wssLzGwubmtSYOh
	kYgs=
X-Google-Smtp-Source: AGHT+IGpB+vXErS9MgmD97K6d3f0kRDSpM+myUS7KQvvZp4jUSIxK3kmidroSr7Q11jXuBBZPi/Vfw==
X-Received: by 2002:a05:6a21:788f:b0:1db:f98b:ddbf with SMTP id adf61e73a8af0-1dc22b43bb4mr1069672637.40.1731022030314;
        Thu, 07 Nov 2024 15:27:10 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f65aa9csm2065002a12.74.2024.11.07.15.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 15:27:09 -0800 (PST)
Message-ID: <cccc9209-29c2-49c5-92e9-b7e76fab65b4@kernel.dk>
Date: Thu, 7 Nov 2024 16:27:08 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/4] block: freeze/unfreeze lockdep fixes
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20241031133723.303835-1-ming.lei@redhat.com>
 <Zyq3N8VrrUcxoxrR@fedora>
 <CAFj5m9KV0gnUr3jy-sU_5Msv86wQgqoHwAoyS_0h_inGybR1Rg@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAFj5m9KV0gnUr3jy-sU_5Msv86wQgqoHwAoyS_0h_inGybR1Rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/24 4:21 PM, Ming Lei wrote:
> On Wed, Nov 6, 2024 at 8:24?AM Ming Lei <ming.lei@redhat.com> wrote:
>>
>> On Thu, Oct 31, 2024 at 09:37:16PM +0800, Ming Lei wrote:
>>> Hello,
>>>
>>> The 1st patch removes blk_freeze_queue().
>>>
>>> The 2nd patch fixes freeze uses in rbd.
>>>
>>> The 3rd patches fixes potential unfreeze lock verification on non-owner
>>> context.
>>>
>>> The 4th patch doesn't verify io lock in elevator_init_mq() for fixing
>>> false lockdep warning.
>>>
>>> V2:
>>>       - drop patch 1 and fix rbd by adding unfreeze (Christoph)
>>>       - add reviewed-by
>>
>> Hi Jens,
>>
>> This patchset fixes several lockdep false positive warnings, can you
>> merge them if you are fine?
>>
>> https://lore.kernel.org/linux-block/Zym_h_EYRVX18dSw@fedora/
> 
> Hi Jens,
> 
> There are lots of lockdep reports which need the fixes, so ping...

Oops indeed, not sure why I missed this one.

-- 
Jens Axboe
