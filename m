Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12927494
	for <linux-block@vger.kernel.org>; Sun, 14 Dec 2025 06:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765694521; cv=none; b=Zh0UXFQYmPSrO0YXOws5KdEWTS3PuRkfHQ4WLDyAxnlzHziVnc7D4uRPujX4SLaqiym8bjELWoeZSYfDMIqp93Vs13vXL0J7QQ2mYXsMFAtwrKJo+RedOo7RHJ8hVBOvb5H8lOSLUg5KsdqvqagrGKsSFZgXyvj59jci8fwYRWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765694521; c=relaxed/simple;
	bh=dQ16CfjkbkfCh4HqYehGqVSamuRbY6apRz6n0Tte68Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oalv/0y1RczeTjVg4xUsHS110++qenrVs2E1jOiw0durl4ndNsv5bXbett04GwHeyA6/tu+K/4SZp6HKW9PMxaNgL4Zw2at6k3nypPJBZsmFiRR1ILVkxeUXqC8FtRN49H2PTGKJ6ELnUNXII31nLcenVi95TJIfIJu6ip0bXws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NNyF90N5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NNyF90N5"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-297e264528aso26806605ad.2
        for <linux-block@vger.kernel.org>; Sat, 13 Dec 2025 22:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765694516; x=1766299316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k1myclC6Fz56BlTmyyPlaEo0TSEJoIxNrl3r4Mi+G78=;
        b=NNyF90N5yThp5nb0dqA7mlai3od0zb/CKvWvUw4Ouw6WZeL2v3YmgmG6Z9IQ7KAm/R
         RT/7ATmtagDxZAcMeTNbVgvp83cK1DcTkb0HuT4vlzWay1lqoXt3VvgaVHcnL39huxd6
         eEC89KD8KiURVVAEzFsarQ9xcHJQmez5GKAR2NaXzzMOVdiTjPA8Sz64CSnROwW1oLOH
         zagp8nt8EsNQshliV04Zz9TvjcigKWE4RhUQ+uTvWQhoD2tKxnyeo0Vzcmtxt0nCiuKy
         vWnhtetnq7B/rnhCsCySJrMOEXBJF6hRCNm8OFaq0mcaseV3vx67pcw5WKLfX/5qqgZ2
         iaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765694516; x=1766299316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k1myclC6Fz56BlTmyyPlaEo0TSEJoIxNrl3r4Mi+G78=;
        b=UmzyqXy1D8NID97GMfQ6z98cJFYv19gxtlNeiklzHjHvJlSRNyC3UmHEehP1+sIA8d
         NX328Snum5coeFF7sH0aB0636v3wx9XQFka/XFaTyPyGQw21lKRTAbPYDnbpSoiIML1E
         CWKahYRv2PtDyxZxN6yK9Jr5qehvts4dJu70S7yFJiUdBgCsbz4CmkepdUwP/viw+a2i
         2QvmIY6pOy463CrA7C4rMC3M8HKamQaN8SZHs1j7UtYHG0LJapfafsH4SkG/5gF8F3vq
         vA3I5wVX3UHHOMg3uU6oHsrFyCCokKq9eJHpWx+L6Jell+mHL4VIaL/jpgwxMcnr6xl2
         +KOQ==
X-Gm-Message-State: AOJu0Ywy1UfvVL26EeZL1HLu/QwrWPTHSWJB+VZStCMbQku9D2M/5+97
	fG31dM1n5H2JofN1b3OMmwrm8XAwd9iqqjfjAnIL9ghLaAiheHWXJ71klbr6hnVlHu4=
X-Gm-Gg: AY/fxX4hcSBatFEftiCoRPvdF/CA6WSo1a0YigoJbHzKOOXvvrjYchQZZtaT7tke2d2
	ubwqAqSIEdl07fP2MaIO2dJiQJ7s1EupfKOKFe0T0lhmPFqjalPgsPg+//DFNrv9a7HP2BxrEmq
	i6tSMnTONNzeXDBJFq0RDHs73GoSAZ8QCiHWlhzVAP2fBVKNQWUNg1bhrqhl4AAMd5SUNNgOEMN
	LDmY3U6e77WsKb0ajFoJ1F22P4oVcB4PqtkboOGKtvuz2Co+yIKRHroOsEHHbEwuf3m3L+stDSu
	MgH2R4qcnD0txN3GXcoZsWheTPPbIxmXvdb1hkywLIQIJRSvTXG8d4eKlUcA0F5QQz2BBBBlTLi
	RRjHSECcW+XpXN5qaUYSX2cjZwBHAGWbJYNg4hquPH9PPIeeNIEInIKGTRDj05SXuS4HnR7Onp7
	8CvoGSup/V56MN4+6Mv/bcG2apt4f5nbcQDj/2+ZkmFfkdz6vPUt37WvYLrQh62g==
X-Google-Smtp-Source: AGHT+IGk1bEteCTJcmDW+Cc3JwvCbre86yxx4swxVS35VLf29DA19LDx1ExFPzY1C31JPRz2XyfUpg==
X-Received: by 2002:a17:902:ce11:b0:2a0:c5b8:24b0 with SMTP id d9443c01a7336-2a0c5b82c96mr9968755ad.46.1765694515972;
        Sat, 13 Dec 2025 22:41:55 -0800 (PST)
Received: from [192.168.212.20] (x7a12e92d.tkyo.kotei.ppp.nifty.ne.jp. [122.18.233.45])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f1eff8481sm65222335ad.80.2025.12.13.22.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Dec 2025 22:41:55 -0800 (PST)
Message-ID: <93163617-11bb-4700-aca9-940c0df7429f@kernel.dk>
Date: Sat, 13 Dec 2025 23:41:52 -0700
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
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aTzPUzyZ21lVOk1L@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/25 7:28 PM, Ming Lei wrote:
> On Fri, Dec 12, 2025 at 12:49:49PM -0700, Jens Axboe wrote:
>> On 12/12/25 7:34 AM, Ming Lei wrote:
>>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>>> index df9831783a13..38f138f248e6 100644
>>> --- a/drivers/block/ublk_drv.c
>>> +++ b/drivers/block/ublk_drv.c
>>> @@ -1080,12 +1080,20 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
>>>  	return io_uring_cmd_to_pdu(ioucmd, struct ublk_uring_cmd_pdu);
>>>  }
>>>  
>>> +static void ublk_end_request(struct request *req, blk_status_t error)
>>> +{
>>> +	local_bh_disable();
>>> +	blk_mq_end_request(req, error);
>>> +	local_bh_enable();
>>> +}
>>
>> This is really almost too ugly to live, as a work-around for what just
>> happens to be in __fput_deferred()... Surely we can come up with
>> something better here? Heck even a PF_ flag would be better than this,
>> imho.
> 
> task flag will switch to release all files opened by current from wq context,
> and there may be chance to cause regression, especially this fix needs to
> backport to stable.

I don't mean in general for the task, just across the completion. It'd
cause the exact same punts to async puts as the current patch.

> So I'd suggest to take it for safe stable purpose.

I'm really having a hard time with it - and I have to defend it once I
send it further upstream. And I can tell you who's going to hate it, the
guy that pulls from me. We might get lucky that he doesn't look at it.
But the underlying issue here is that the patch is one nasty bandaid,
not that Linus would yell at it, with good reason imho.

At the same time, I don't really have other good suggestions. Let me
ponder it a bit, about to get on a flight anyway and -rc1 has been cut
at this point regardless.

Obviously this isn't a ublk induced issue, it's all down to the lock
grabbing that happens there. Maybe bdev_release() could do a deferred
put if a trylock of ->open_mutex fails?

-- 
Jens Axboe
