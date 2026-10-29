Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793289269;
	b=0jZ+tPSby4TMW4r/81v40l36vaiDHkPKZAPsellMTkt5ia04yvhuOPBU4fw42tB3/l2N
	 inNV6wDnQnbY9MQHeXJP5lfhbGTulCCDToC+VN8kOkA9HNwitLd6EDy2jfsYiXmjfqA+S
	 +xxvY2YRGasbqzmRF5dN6UyQP5mm/teEzTfV2gay0rg8/AsoRHAB4jWYHBA99zxcSw9xv
	 Xxu6HLL3Z1EniIEEtGqHRX7QIIKDug0rPUTVSLBpLOhffqnjy1LDhH+Um0XgWT9VqWj12
	 yjWatTR/nS5QuA0CNjY88bqSS3zlu0afQMJu/Q2rQOUjLWJkxmBRotuiBdlh/Ls1gTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=0ZwLHZ7L7aWOVOz4LxBw8cFWZIqB0VDhL3ddoYtSUTA=;
	b=BkaaefgrGuWP36yROJ1Jl9Oe6vEY0aJNd/R6uIOXFTgKfVj1cxMz4FxWAawx+WiZuQiF
	 IjpzaoF/pI+Q5/n+Kn8wJdhDa0cT7xF40UK40IFJIOtV64UiIEjRJ1WLgDKu1WwEDjNyJ
	 XR9HJeoUMFHlifjQX//A3dmAqE0tEDeQL8kC5D6RsUoAe4b5XYfSOqwgF0DRZ25dumFWE
	 mfognST9YYgujRlyWhB0JPsILIHBSjO5YOzfDKkApF+/UBE+m3Jo52x5HSc6X/v1Fpn4v
	 zMxlVuP8/4X20zZyt4ebJhkwPa8hGIsuFYjjAXQZxzQAbBNCgkd8wgLvEBfcBRuJ6mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KaFk3QvV;
	arc=none smtp.remote-ip=209.85.160.43
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF26606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 15:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CF26606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KaFk3QvV
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4911df1e196so1359757fac.1
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 08:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793289268; x=1793894068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ZwLHZ7L7aWOVOz4LxBw8cFWZIqB0VDhL3ddoYtSUTA=;
        b=KaFk3QvVGK4867N68K8ZvahVv8n5GrMUDap/wWGcfINkCA0vcIxK5luPVMbo5Afs36
         nmlfC26xg6xAxSoyDUH3mkr/lwqG+f3BRNl4eYhhN711/LFOi9k0SioID8mzv/CUQnOQ
         x6Mc9Zfe+Xu5hJLJITRCK5EyZGhUf0ZFhZn1DXCsdUQI5gmdmoZTMwohvhqV+1ui8kpV
         KUV9cl1K93RHuK8mXPXFbLeKDiDGkCZ8K3ielioPyECcWcEoq/xmIbQZNIiomTm9XFY9
         f7+TXaN2ai8JbXl+IbrKWyiXtACQWLEQ7HHdGOFTapVK+zVGYeskTAx1HvJRERGJeL01
         EEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793289268; x=1793894068;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ZwLHZ7L7aWOVOz4LxBw8cFWZIqB0VDhL3ddoYtSUTA=;
        b=OKC3X2GU9fvHHKeqHdUzDPyeqpxkPYq56uGgc2iYznCmgFKOCvBConVMGJXiPMt1P+
         Ko827Yw0a/xjRJ75m+WV3kzsjI7vanQZzDfXpfW/VrtDqpjzZbzCrr8wWhsUwvvYIbbG
         JvJnG3TacVK9pHbT0fqHG4cS7fnSlNMEK2DSnCg2IBi40Rzb+0h5KFyQ69DGTNqjFzmJ
         wFzaiuKBGZ9Rxyo/kAFufHzw9ZsfDO/sVmVpfuizrkfeD2fWt1X8mSbId/8ds5xhtNCD
         IPsEBFJ31A4u0gxWRG1AtD1a4P9tiQtczTl/jZOh0PSO0zxehgYboGiZ5VfMv7QRRoCI
         ETqQ==
X-Gm-Message-State: AFq9FYIEouLW+xLg8KhYqSeNhnnnoLIRc3qyHEN1Mp2k7+gOqCFTDTcY
	koFMxREi8OrJCfQzSXDrrpDKEwako3VO9I6StX8Q/86CUHHGijpdTzOQltPUY99XTXI=
X-Gm-Gg: AYBFou25ClmzEdFNJ5SkkQ5STGbG64479ugKgvSy3TjdobcudNUoKUFbqLXfX4UULUX
	OGPB1KV5JAXeiaEmgezFEGhrbBu92Zt7qFRBhZUCb8r2+DVSkUrJRk8u0fuaOIIWbmlFbe02/OS
	gemhvQh/eUk8AI+TNVNv+MnDn+KKA8rntqySUs1igawMeWZQye1Ihy18H9hrAhwGGm3e2/d13qW
	eRmiunQXr9MqC/BpLAi04CbHmHVtlc5uv9R9swMhRxBR4IbPWbIMtb/xn3awXLG+aaWYUmL6lHr
	FbsgZP1q1jMoSPLxcBjC12tKqXmNLQhRVAKgaUJcr6DBTlhE3RaN6eSVJJP6QnbYYCH3DdgTwKo
	eIWuFtbtaVmnFwyZu6oR+kghEm2lowF8wilS72YbpWaMJjp/Chnva7+oWH6bnahYSh2A224wGxi
	tkhB8Bop4uqioP0UjdAo8SWVaOn3bm2VB3EHFVmSiB+Fwl8GwO0rcxZYDvFlL9oSr2C8hXGEBTI
	bz86W2Ej5SFJUA6FbGweMJIRZeQwXxp0bkPv1TnWxrt1TRGn6DUAmlAv791ifIFo7L++LdunTvB
	4qvyiMWC5I+SlV2leEXXYGB3WqVep464Nz02UmlsWerU1RjJWNsmIYNxxOTto3Bxe/6d1dIGf8x
	+C1T5di0+MA==
X-Received: by 2002:a05:6871:c91a:b0:47b:7709:5568 with SMTP id 586e51a60fabf-4a8bb9634c6mr4540518fac.10.1793289268103;
        Thu, 29 Oct 2026 08:54:28 -0700 (PDT)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a9022465cbsm110854fac.13.2026.10.29.08.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 08:54:26 -0700 (PDT)
Message-ID: <5eff518c-f620-4d4b-9e02-1ebf142e67ff@kernel.dk>
Date: Thu, 29 Oct 2026 09:54:25 -0600
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aoe: Do not free a device while its work is queued or
 running
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Justin Sanders <justin@coraid.com>,
 He Zhe <zhe.he@windriver.com>
References: <d931ae52b451b1fa3e5de8baf828943f86324078.1793288725.git.bvanassche@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d931ae52b451b1fa3e5de8baf828943f86324078.1793288725.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/26 9:45 AM, Bart Van Assche wrote:
> Serialize flush() with a mutex because dropping devlist_lock during pass
> one otherwise allows a concurrent flush() call to enter pass two and free
> a device that is still being torn down.
> 
> Set DEVFL_TKILL under d->lock before unlocking and calling
> aoedev_downdev() because commit 430380b4637a ("block: aoe: Fix kernel
> crash due to atomic sleep when exiting") dropped d->lock and devlist_lock
> before setting DEVFL_TKILL, allowing d->work to be re-queued while
> aoedev_downdev() sleeps.
> 
> Guard queue_work(aoe_wq, &d->work) with a DEVFL_TKILL check under d->lock
> in rexmit_timer(), ataid_complete(), and aoeblk_gdalloc() so that timers,
> ATA ID completions, and gendisk allocation failures cannot re-queue
> d->work once teardown has started.
> 
> Cancel d->work synchronously in flush() before aoedev_downdev() and in
> freedev() after timer_delete_sync() so that pending work cannot run
> concurrently with device teardown or outlive the freed struct aoedev.
> 
> Check DEVFL_TKILL under d->lock in aoecmd_sleepwork() and aoeblk_gdalloc()
> instead of triggering WARN_ON() or setting DEVFL_UP on a device that is
> being killed.

Thanks Bart, I've replaced the previous patch with this one.

-- 
Jens Axboe

