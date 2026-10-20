Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792507173;
	b=a66CosSBvtv4Z7uHI1VnTUtmfBdPlFQ7sYCyIrkTSUxCoHgq5JfcsH8vcaLHOGCuD/L6
	 VTIviMxd8JjrutSWlrsl+GbQie0baVPTeQy/PM6QEO4asHgytQIeVyTnmi56hs0jaDY3i
	 T5icOKcKDJuO2qospLQ4nL1sRWk/utP71/qfaCzZWM7P3ly9eJPk8UUWA539j5hzFWi29
	 zKOjQVbXXXwrL1BrW2q4tnejmDlbS4a7sGBJbC5/yHehTwUEO5vp3lwrlliAPwS1Vifs5
	 4yh0AMmLRO1O1b7Bh71Yj0+HRM4jdEJK3cpu5kCEOWw65MJnw0LjVM5MegEXXIR8xWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792507173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=TAz5HUAuhl+iZRwwDUFp7THQQfvQJd0tH/rHV2w2wmo=;
	b=TBjIOAKo3eHMR9Hxa6KSdXs292RMpLcXwtocKtAjCOcrp7XmW4qP4VXTqazA5OmK+gCh
	 dEiXffTGlxGAGnrZcX7O+jjVJicfo/4poO2W/icQ5INBhBD7aAG9QuSm2aUkhiuyxpN0e
	 cZ5Sy/XW+xg6lqOSfV3+pVsRWfryd8W+yxIvPoD6tc+aZ4pmp3hmAnRhJeDniNj5wf7Lf
	 yL41u32e0XCiCALbGPPCjGYzDH6AsYVXNqLo3AOwBaGlNOQk2BLxIqUnOSXH2LVd/uDbA
	 fAE6BlL+LaRnyRkFkkjUdQCTupBu4uo09TRc/hjXQkzXqkAcGn7pcNafCceAsUV3NTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=XAka60kG;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CFC606A31E
	for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 14:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75CFC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=XAka60kG
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1226075eec.0
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 07:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792507172; x=1793111972; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TAz5HUAuhl+iZRwwDUFp7THQQfvQJd0tH/rHV2w2wmo=;
        b=XAka60kGQCDYzLBujwoDyaziGz/wxKWOk9JDjUEnThjZQh0kSEDckkjNWPh9Sqfpag
         LjzanvOrEw+E5z8IW3l5Uij/VNEMTl8Oxtavoq8ZxtdZ6K65LpHEmQ+RQwTytiMyYBsd
         7nGU54F7hUmRkBU0Re08WpfTDdq0TkBpVxtqpRj7PcDaavTG9VJ6ty5APHoux1eEakQQ
         i4iF3EOD205Zs09120H/IUAIdn3b412qgqSIo1wM7RYLLWWQoSJrV2QVY7MZNYQgPxuP
         Yvp6LB/O5EykjqN/bjAB6qysZ/rr79RYznvopS8Gkg4NF/tkSqgoOHWjFhFme6g4b8RF
         dknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792507172; x=1793111972;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TAz5HUAuhl+iZRwwDUFp7THQQfvQJd0tH/rHV2w2wmo=;
        b=PGKTH7mrDUiRoe8VV/Jv/pQpCq/LCERqlOG2Onl/LSFz8UUyqzIbrgcinBNQuIe02X
         lXH96jStXJWfADrAxSXX/2TOENQbv5GYmtevFuXGjVa/u4Hqg3XJmfikH9nZpzEIdlbT
         KY2QR2f4t7n+XDxJQ5HBC1tveTUSb5Ve5RcTSTESqrfKLzFeg2st6PcOSNOWg9tthBRH
         8Kl1ZDrLWt2Uym6OF38jc4TXQsRdKXJThLIrfZxKO/g17ewn+tX1JiOW8SGffs9DP62n
         bgKDxN8jHmtVN97cS9FwlDuhfZNl4edAkixaLKa4Z55ZL29wwrtAlC9NKKFqM7/Nt1pu
         rpPw==
X-Forwarded-Encrypted: i=1; AKwUvBy4idLQePdH17AylC7/jecA9jysASkaClAespVPYHDxvCJY0G57KCvnVpDletEjxbBgz2oiFjwtMOCfQQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYILGuv4k5baVSzGjUJ/hktQGfftwHx9yENVCh7xciRV735JanzM
	+GpU1at/Fx6r42hVBQQESzgQkUP9k1DMely1xSo64vpk1KuXsTls3j2VB6kQ3G0DAy4=
X-Gm-Gg: AYBFou2dhdhboDH0IgO6vM4SDAYRWHS72YZ7/YDuGPWpHr7WxMqs4lADhAVaCF7mpcs
	QVvzTt4w9s9WKKhVfSdLwfqFIqx3+2JqyGdQ58o5cKHE5t5ZPJhCl8bkwdZwTbu+ttrT0GOVfr9
	sp0YSwfP77B9eEppbU+qG/A3/XASSv14Esxzbf0E03MKK/8U2tYrXMMSHzzE9XSsfP0mMjTazSC
	Y6DiKoyqcWOV/I426awe5ou9YdW5tPybg1t3+3nH2s43qNWIZXWq6FA1AFiD4IC+z9sA8rQKZaI
	vrCpM4hhG+ML6DbzBvUWZSPRyK2qFcbJHKJlmU/uO7Fg8iUPrey8x04YRLmf9FzuU1X8IeJogmn
	mVyf66F1FsWBJTkAbiGWx0rWbpicX+Z3y+IMa0JEZNBrAGvTKL7tehMQce5XuivIJF7DnHkgfUR
	t3UF0bTIJ2ZABvdkK7XUZ22qSk0YMSog+5bwNku4Q4+KpTZUs6WqF6ma5PqG8Cy3mKVkvwGRPSr
	FjkYIc/PE6q4Q1yHWtf0kLYG6tBnub3Uasdy/luqNHImz3X2uSK2EsmIVEUb+siyBohyJp3irmJ
	968x9SdSeYY=
X-Received: by 2002:a05:693c:860a:10b0:351:727d:b9c2 with SMTP id 5a478bee46e88-361a18634bcmr18267849eec.17.1792507171481;
        Tue, 20 Oct 2026 07:39:31 -0700 (PDT)
Received: from [10.61.8.29] ([155.98.132.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360819bc569sm40225365eec.11.2026.10.20.07.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 07:39:30 -0700 (PDT)
Message-ID: <29692751-e80e-4f29-a07a-ea0221f1116e@kernel.dk>
Date: Tue, 20 Oct 2026 08:39:29 -0600
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
Subject: Re: [PATCH] blk-mq: clear stale inactive flag on hctx reuse
To: Bart Van Assche <bvanassche@acm.org>, Nirmoy Das <nirmoyd@nvidia.com>
Cc: ming.lei@redhat.com, hare@suse.de, dwagner@suse.de,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261020125129.430600-1-nirmoyd@nvidia.com>
 <ff516ed8-d4b0-463d-952b-14cf110ec8da@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ff516ed8-d4b0-463d-952b-14cf110ec8da@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/20/26 8:13 AM, Bart Van Assche wrote:
> On 10/20/26 5:51 AM, Nirmoy Das wrote:
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 025a799f35b924d..00b75eb95dd943a 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -4002,6 +4002,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
>>           goto fail;
>>         hctx->queue_num = hctx_idx;
>> +    clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
>>         hctx->tags = set->tags[hctx_idx];
> 
> Why clear_bit() instead of __clear_bit()?

Since this isn't a hot path at all, going into details like
that does more harm than good. clear_bit() is totally fine
and honestly preferred.

-- 
Jens Axboe

