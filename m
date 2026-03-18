Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B675292B54
	for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848200; cv=none; b=SkoLBB0FhWt5wom+ugezrlXVmz0QLpBN9S/jMI5v+QMEah9Kstjsax6zrkNeIBPmO79TsDr0zVShVEPLARnx0nTYLAVe0hyUfYGOcEBC7oRMimkDct8WMqvtq32/5MYjIkkhFs7eHykNcBKVI7sJ0n+FNQm9YwQxuSfVyqvfCsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848200; c=relaxed/simple;
	bh=Gq09rieLcY90X+GsgHoSdT6R4xhIe2SjI4qCEjUpk6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MH8l0KoxlkgD6oz+DS6rk+CSPMbby+dLctjrmbMNjvuVlf2eN90jegc1zqrqfbcCBtiYVxo2W/del/ofgdl8gZKdETI/QkKkogMT6wbyftgNKexCppUVR0YY6+Ip6KKxr+4OSl4wFICHerAyTZxoD8V53rSQjGr+H5nUb1IWmE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=Pnzh8CVy; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="Pnzh8CVy"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso59725635e9.2
        for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 08:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1773848195; x=1774452995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2z7/lL0P74ieZc6NvB+xXjYjCxDI3Y0Z54tFhE7jN5g=;
        b=Pnzh8CVyhoWFyD8PLuFrxhZEmnVplnSTxIZy41G0yMyCd1HMYd6HlfwM2vP3DPhNmx
         Yq94vT5Ukqv15po4XCRqVMlAxAvYi+/ld6KL6aB0FKu1O4VmvrFDqhht7p6sYioZ/ubY
         jum9xmrVshZbyVJ6LcG4kxG0Bw10p6K+9XAF5At8TLB64fdVU7zz1Qo3pnG0mARzUncv
         fOYnzdqZexo2BsE31nI5xf/DyoIv+ynNBGPog054a/gfwPX37As/fqS1gy0D+wLBJhk2
         +kYF3mJMXgcw8L1AoaZ1HvkpY9VV0wylTKXwun75q9NDXfeppB+zKAWuPosmnp0Ha9+6
         ZTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773848195; x=1774452995;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2z7/lL0P74ieZc6NvB+xXjYjCxDI3Y0Z54tFhE7jN5g=;
        b=axw/fMIK+Rqj9I9YomIml2ckaNBDsSIUsJ7Ph1SlAPtAyuQPuRb0C1cLeFHBVw6pjt
         Wn1X2M9FIBNYhqBCxw52SNqV2/4ATEMOjSkBPeQDt7wmJZN2jYQHFrZWYF3nSCbqCvSJ
         bRo7BJcz6mN5goaKYHa7EJPG91YUCgX/SFZAA0V4PE8sgLXIKVhLNozg7Gxe6KtFkRwL
         6Om2HfIPLkqO/rs/YBhKMWE/fVsaifqLgUZWuE9dkn1Okdn1YJGk3oAfTrbbiZuuMNkE
         R4PECLEbAzbFZQ/PRQqzRfPgg5FKf6fi1D2y4pp+bAzN/MjDsKmap/ITihuVkUEB2E4G
         kJeA==
X-Forwarded-Encrypted: i=1; AJvYcCWIurcSbM2dVACjnTTzKjVzEyiFQTiWDG00+ra+RqcaugPi7u0H20YvKWspvh6DCqH83i1VMDIOW5V2TQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWIPqYqngU2R5ejqRI98E88XduTYIp4AsHHZVKYC/2mOpPycbJ
	NPvRkka9N1pll1PHEMnY2d0ITYEaWVppMs16yew8OAUTx0MjPUjEtotA4Ztn7XyG79k=
X-Gm-Gg: ATEYQzzHsQJUkvltuAJpUxevdSMrfAglHRPutX8WfBgr10BGtbp1wewTUkvVd1nYEvu
	fxyhFpVLyHGb4thxJCdAQCCWETozMzLuyETPUkjV6Bjcv1mYqhMfs3bFbrdkhT0nUmyZ4rH4SyO
	Lz4+SOwynkaaiL0XCvmJRqwDvNyWiAjGfJ9c3pslyZVIuzMGgS8Eo0qugIYiBQ9Iv7mcaOidYw6
	7b6HAwrHewQEBCVI3QBkjISDWSak23r/0Bz2vdLB6fh0m2eegnwcrinq9XEi2820VC4rw1aCiSi
	+aWzgWibbI8622L4RDUrL6gdwjXSnAg78dzC1X84GIk6J9gUlxFhTiYLlKKvSH5Jlx1fvBVl9gy
	Ji3c5RxisAE1DoCieUy9+jCPah7q4IO5RnrFvkNzcOVOMowv1dAiPhUaXKmcCrteS4DnicZNXZ9
	+Ylfyvd+U2nc/gDG9OMMMmGEkAilxv32V3I9LNv6Yak4v4iVzGcEm+hLrFKDlR3H7saIS6nz5tg
	Yc92cw3bBmmM2U=
X-Received: by 2002:a05:600c:34d5:b0:485:40fd:8390 with SMTP id 5b1f17b1804b1-486f4457b0fmr61544675e9.26.1773848195353;
        Wed, 18 Mar 2026 08:36:35 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f45f7e96sm44031415e9.0.2026.03.18.08.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 08:36:33 -0700 (PDT)
Message-ID: <faf5b12f-03a2-4d8c-b333-7fc275ec3191@linbit.com>
Date: Wed, 18 Mar 2026 16:36:32 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drbd: fix rdma dependency
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Ard Biesheuvel <ardb@kernel.org>, Eric Biggers <ebiggers@google.com>,
 drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260318104858.1868731-1-arnd@kernel.org>
 <eeb73048-d5ae-4fbd-9920-1395a3ca51eb@linbit.com>
 <c3daa9b5-3741-4a18-9bbc-7bad1a2e0c1b@app.fastmail.com>
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Language: en-US
In-Reply-To: <c3daa9b5-3741-4a18-9bbc-7bad1a2e0c1b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 18.03.26 um 16:31 schrieb Arnd Bergmann:
> On Wed, Mar 18, 2026, at 16:24, Christoph Böhmwalder wrote:
>> Am 18.03.26 um 11:48 schrieb Arnd Bergmann:
>>
>> Seems like we raced here, I already (supposedly?) fixed this on the
>> drbd-next branch.
> 
> Ok, I assume that will be in linux-next

Correct, should land there today.

> 
>> My fix is this Kconfig:
>>
>> config BLK_DEV_DRBD_RDMA
>> 	tristate "DRBD RDMA transport"
>> 	depends on BLK_DEV_DRBD && INFINIBAND_ADDR_TRANS
>> 	help
>>
>> 	  RDMA transport support for DRBD. This enables DRBD replication
>> 	  over RDMA-capable networks for lower latency and higher throughput.
>>
>> 	  If unsure, say N.
>>
>> And then just this in the Makefile:
>>
>> obj-$(CONFIG_BLK_DEV_DRBD_RDMA) += drbd_transport_rdma.o
>>
>> That should be equivalent, right?
> 
> It's close but not the same: 
> 
> - INFINIBAND_ADDR_TRANS is a 'bool' symbol that can still be =y
>   when CONFIG_INFINIBAND=m, so you'd still fail to build
>   BLK_DEV_DRBD_RDMA. You still need a dependency on INFINIBAND
>   (the tristate symbol) itself, though you probably also
>   need the INFINIBAND_ADDR_TRANS one that I missed
> 
> - I incorrectly assumed from the earlier Makefile logic
>   that the rdma transport exports symbols that are used
>   by the common drbd code, but I now see that the opposite
>   is the case. The difference is that for the case of
>   BLK_DEV_DRBD=y, CONFIG_INFINIBAND=m, my version force-disabled
>   the RDMA transport, while it should be in a loadable module.
> 
> It seems both versions are wrong then, but just adding
> 'depends on INFINIBAND' on top of yours should fix it.

Yes, ADDR_TRANS is needed because we need the infiniband "cm"
infrastructure (for rdma_connect et al).
Right, I did not catch that we need CONFIG_INFINIBAND separately as
well, but that seems logical.
I applied the combined fix now.

Thanks,
Christoph

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage

