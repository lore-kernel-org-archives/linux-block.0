Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1798256D
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 03:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765941563; cv=none; b=QkCBQc/RJw24mPnzgulhtKmyfmcpsnzGJTgQ47fMcaz28AE3pD+wNZval4xJU6Q6rl1Llo4Igm6OWglSq9hTkVNjQp0MjepDvJt08rh41TSs8kqFHS1WhX5qhXW61CvwAiYDSfNCokdVlGXeTXp2Xbe8jkuQGUA8+JJRaE6kR3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765941563; c=relaxed/simple;
	bh=Ap1JaDZMDp7GXYUmwrHm6vV/wr7vEcntk11xIqt0TxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nO54rANzir1FrLniLK0f9+uVLg9Y7xyBqQX//qemkx0L024g/36aEqb1YFDKcvRmfsLxY0qL7Pda+hN6Ostl/DiQXFuSmxcC+ORZh6ZU2k9V7tM22rGnRnULWIHg3Ks8/HNAtkYkHjhO2/HgnPMhwfQhWN9bb1L/ewwA/Sarc8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=P/fQjhxp; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="P/fQjhxp"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c6cc44ff62so4608989a34.3
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 19:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765941558; x=1766546358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZjSp1pTvSMEcoeEM7tTQ4A06sHDyis/UKRZFOFsS3NQ=;
        b=P/fQjhxpDzJZ6piz4PceDgB2Upe0xnz3xeq0DRnLN8RP8tOLa+4fxerh2qH6Ud9Q27
         pk9xccotjGsb3xVZWyk6RGAUKkVYwq4AjiN3L0KA0kslRRD5P1mG9WI8VLuZJ5ENB0vt
         6dTqrVg9PxwvIAid8E6oIY5bsSlozv4zoSNq1+ARlcPP8GwQaQC5KpDU6YsFSePkHol2
         yDehajh1NBy8b2UdpM+IXn5aI8LeU74EvmuyGyYtXBBbhkkZlvxy1jsChZOfks2J4+R9
         a+eHj9Fy1rBeEJdUmy/oeYBm2L4I79cQQRE2lnG6gaRx45K5jCTHNgxbvKcgz7/0FtOo
         FGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765941558; x=1766546358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZjSp1pTvSMEcoeEM7tTQ4A06sHDyis/UKRZFOFsS3NQ=;
        b=vx+ueU6Pt9yAOBLzTnq5CAIZvtPzXhKcka0ZjBWfgVez55PWO9p9P2yTIvRAmsEplv
         Gp9AvMNDjRwG92/pEupAOuAYcTYTlOr0aemC9Sazoqw1yLKnH1YBy6yfK/iF5ESQ7dec
         nCszTppOcJtksOu/2sku0akfqS55CRtAKcYpM0dPLvmkxSFLj1mq5kXs0EarZZLqYcKX
         17BOvE8V1ZeG5LIzXVgZdYuK/vOvBmIa7y4pzCHHRfhT0VeL3F2p6Os9ZXLbinp1+8jr
         24mk/Wpa8HLi4RT0gfA9XHYF1nEm7N82Ev5HWZhpUZEQKos/07S4HVALZEmjK5V1Vaq3
         nGwQ==
X-Gm-Message-State: AOJu0Yzk6AXPduHBGE+W4N5W+8SxdXS3WLaxzjoJ0J05fWvTSAnJgH++
	QTp6PAOXSo+FVLF9wZ2YaHyH2gJQtUlbP5SVJWcOhNL2bbhRcSihe6Gurk/nQstriq2XA/ZN+K3
	IO6IA/uU=
X-Gm-Gg: AY/fxX7y1WmpDDtUi/9T2wbk4WB8Ze+EARKBrVJGlhjnT89UdyhOkJaFOrGsDsbYA+m
	QUSDoYnvx5Vg3/6oOyd6nFFziIKCIYgIoOppwVTA8z/18ezjd01I0oWWtOXodFhJ27/ATMkhIMZ
	Bn3xCiMJHiAee3utnTeFRV93tA16sWKi7lPbhsKlXcmMFGtZp7tjmBeoUvnE8g+VC0AjwD8ao0W
	/HFrBQUzd22E/SgE2seFPd85ceTHhFiaLUSoXBLTgmfl3BhDBt6CqvgePzFEKh6LrV+gCj3WiYl
	8ZnpvcyKaJ3yz5zyf3Vsmj9M1FLwI6hMH1l3B0s7k4bZ4T/z7zGbydDyzHZdJnsLo0ZxoGHvVzf
	p6mR3TnC2gachReWQReueFaUU0fKDPPJUp9qR9z9/YWlA5BtC6DkkqD3WZ9MDwWmdMqh5ph5jwv
	jN6/i0G6Hp
X-Google-Smtp-Source: AGHT+IFR3RkFQp++qLPzlBeuCSY9ePNEwx2emWqq3iQBtUJw+NxI0eOK/n+u8yc3MqxEQ0br8l50SA==
X-Received: by 2002:a05:6820:2016:b0:659:9a49:8e9e with SMTP id 006d021491bc7-65b451b574amr8128426eaf.34.1765941558632;
        Tue, 16 Dec 2025 19:19:18 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614be6c05sm7625744fac.6.2025.12.16.19.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 19:19:17 -0800 (PST)
Message-ID: <8b2d7335-fd49-4c15-87d9-0eb50e0a09a1@kernel.dk>
Date: Tue, 16 Dec 2025 20:19:15 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] ublk: fix deadlock when reading partition table
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Caleb Sander Mateos
 <csander@purestorage.com>, Uday Shankar <ushankar@purestorage.com>
References: <20251212143415.485359-1-ming.lei@redhat.com>
 <8dd3c141-3e92-44f3-91e2-2bf4827b36a4@kernel.dk> <aTzPUzyZ21lVOk1L@fedora>
 <93163617-11bb-4700-aca9-940c0df7429f@kernel.dk> <aUEeu9luJ9ZNvJzA@fedora>
 <6d40e8a0-14e9-45f4-bbea-360678524767@kernel.dk>
 <5e2038e1-efcf-4313-8a14-565b970370f2@kernel.dk> <aUIe3RXASOEKKc0m@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aUIe3RXASOEKKc0m@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/25 8:09 PM, Ming Lei wrote:
> On Tue, Dec 16, 2025 at 10:57:25AM -0700, Jens Axboe wrote:
>> On 12/16/25 8:03 AM, Jens Axboe wrote:
>>>> The issue for ublk is actually triggered by something abnormal: submit AIO
>>>> & close(ublk disk) in client application, then fput() is called when the
>>>> submitted AIO is done, it will cause deferred fput handler to wq for any block
>>>> IO completed from irq handler.
>>>
>>> My suggested logic is something ala this in bdev_release():
>>>
>>> 	if (current->flags & PF_KTHREAD) {
>>> 		mutex_lock(&disk->open_mutex);
>>> 	} else {
>>> 		if (!mutex_trylock(&disk->open_mutex)) {
>>> 			deferred_put(file);
>>> 			return;
>>> 		}
>>> 	}
>>>
>>> and that's about it.
>>
>> I took a look at the bug report, and now it makes more sense to me -
>> this is an aio only issue, as it does fput() from ->bi_end_io() context.
>> That's pretty nasty, as you don't really know what context that might
>> be, both in terms of irq/bh state, but also in terms of locks. The
>> former fput() does work around.
>>
>> Why isn't the fix something as simple as the below, with your comment
>> added on top? I'm not aware of anyone else that would do fput off
>> ->bi_end_io, so we migt as well treat the source of the issue rather
>> than work around it in ublk. THAT makes a lot more sense to me.
> 
> It doesn't matter if fput is called from ->bi_end_io() directly, it can
> be triggered on io-uring indirectly too, in which fput() is called from
> __io_submit_flush_completions() in case of non-registerd file.

Because of the work-around in io_req_post_cqe()? Or just because of
!DEFER_TASKRUN?

The real problem is holding ->open_mutex over IO, and then also
requiring it to put the file as well. bdev_release() should be able to
work-around that, rather than need anyone to paper around it.

-- 
Jens Axboe
