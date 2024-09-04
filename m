Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757981CFEAC
	for <linux-block@vger.kernel.org>; Wed,  4 Sep 2024 13:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457633; cv=none; b=ebwp8LeuaA+KIvwJeIk3BoKJ8sY4sv3umEbRY7QEIGJoHaUcUToYQL20mI/43WuGDOXiQo/QIJBv/JfjxF88XH6BZHI+BRiHu370ZPQDi9pFTxK2QzslN4uMjeluq6B86yJ8wf++Xvbwv7OSUiAHlOb9GVU6Jj82g2lHGPgWGUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457633; c=relaxed/simple;
	bh=8DRUJzii4IYGIOFx9e3ZEAV2Os0UT1DAQRj1dho66Io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/RtuyqFLm+NMTehzFDqB4C7tFqL4Bz8nfbhyHuvaHd15cfHckKfx8jGQ/fSLFf+U+Lurm5H/fstjwFEwJf2mzr5Jdhse4GbGNKWfFiIpDwbmendXsmFBiSECYKqDp5IjwqqGgQuRCa0QxxL7LGuyGTQOfHqvWtkhXNO598Kg1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dILQ7Idc; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dILQ7Idc"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-82a10bd0d58so23873939f.0
        for <linux-block@vger.kernel.org>; Wed, 04 Sep 2024 06:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725457629; x=1726062429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3zUHNwN+aGVH5122ddYo+lwnksNLiafN5gFwGTnhwbI=;
        b=dILQ7IdcbEauS5zA61RlCYawQNbXgo4x+tRN3xbJ6AtVsE7cOAGlsBuc4IdzF6sulr
         EyOrQrd5/MGumOAz38Du7x/q4om7hRo/uJbuhzcgZcjxR4clnAEwjjYVjHYXoJJwLn6+
         +cNNoCdkDomOjE4vm77SWQrV3HLRBWjbvAqboy1aMrii7g/K4TSN2FYJaOg+CphI6JV2
         g8bpLqfvHbaiyNdUrtWYxMVIKDEXtUiIeFILv2Ndhpwq8RWofwONcBD3EapPx3u7AfAO
         QUdY5mI5X4ATkzyUoIeGIrxmxDmfjEDVG7s3L1rbWRJ+NtniT+CoogasatdV227N9dP1
         NDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725457629; x=1726062429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3zUHNwN+aGVH5122ddYo+lwnksNLiafN5gFwGTnhwbI=;
        b=HoF6H9shXCOfhXhKjFce6o2aY5XNbDpCHh9MQm3cBzypz32BkYvbhY2dFrHHYZvVX3
         YM9yhO/xfvXKMlN9eyifywslQ39WOVpMljQMfSt6It7FKRXphDmoMn1A7eBWKipRFGdj
         BGLxz3yWsQZ58mdopAVmFRjoyDs75yyX54D3m38TNOiy1gaOvJym1csoaLvS0GRMW4KI
         /cyc5kNRWGaGgYSFXQbJis3JBtpNnIOxCpbDlR9XfbfKTcyS8fcOTPB7wPIrZr01JPCP
         +BrZ8m/1yfAsVbLOBe+U9vgithCsuKTJYHsh1oX3ieRrv1DCrdjgp6Y3052RnuGCCv4B
         vKOg==
X-Gm-Message-State: AOJu0YxR0kCBCAOFQjOoIsCSUG4haXXm8Brcba+JklRsWtFDeQRyo0d9
	mqY4rQnT4/cafawC4AiiXx7qF3F36LVLUWuZjjUfqC5C48nKUOgvo3cFJ3DUPELmGrIUnkeZ5z+
	I
X-Google-Smtp-Source: AGHT+IHq1OuvhxYXQLqh5bCEPTlYV4kB/o6gyMBsa5372pVdoz34Z64xzCcUljVmiM5ro037XNCbQA==
X-Received: by 2002:a92:cda4:0:b0:39f:507a:6170 with SMTP id e9e14a558f8ab-39f797a59d9mr18092625ab.8.1725457629445;
        Wed, 04 Sep 2024 06:47:09 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f4f5e2603sm26581325ab.66.2024.09.04.06.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 06:47:08 -0700 (PDT)
Message-ID: <d8d1758d-b653-41e3-9d98-d3e6619a85e9@kernel.dk>
Date: Wed, 4 Sep 2024 07:47:07 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: move the BFQ io scheduler to orphan state
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <6fe53222-876c-4deb-b4e1-453eb689a9f3@kernel.dk>
 <CAPDyKFoo1m5VXd529cGbAHY24w8hXpA6C9zYh-WU2m2RYXjyYw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAPDyKFoo1m5VXd529cGbAHY24w8hXpA6C9zYh-WU2m2RYXjyYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/24 7:27 AM, Ulf Hansson wrote:
> On Tue, 3 Sept 2024 at 17:54, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Nobody is maintaining this code, and it just falls under the umbrella
>> of block layer code. But at least mark it as such, in case anyone wants
>> to care more deeply about it and assume the responsibility of doing so.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> I haven't spoken to Paolo recently (just dropped him an email), but I
> was under the impression that he intended to keep an eye on the BFQ
> scheduler.

But he hasn't, it's been a long time since he was involved. I've been
applying patches on an as-needed basis, but effectively nobody has
been maintaining it for probably 2 years at this point.

> BTW, why didn't you cc him?

That was an oversight, I think because I haven't seen anything from
him in a long time to assumed he was awol.

-- 
Jens Axboe


