Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD6A4B1E41
	for <linux-block@vger.kernel.org>; Thu, 15 May 2025 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747316853; cv=none; b=N+wJPI4RJCvwejm4YzXZP54db5DCUX5fiWpVGgrnOqICV9RNTQ5hnRn9/Ohp4yZJd6h99QwQ7pGLZ+V2GSFfJuJVM8SpfG8yiZLKhKF4ykBIFxEyaWqCLP9jCqI92Fe8iQCKhwwhEQCTJwxrAOmiEXMtWbByqVVeDGhDMrNIgNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747316853; c=relaxed/simple;
	bh=4ZrF0APFhrMgIHAqsve+BN1SiVoV3kDNWUfsW2Gk7Io=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ETyRB76sgyIAWZ6B8eS23qFBI7H8TjKs9GSaQyJNwEFdIsOyzqoLITZEEw03d2GTRANm4UjHuw8Il4ksi6JuyEBqpfTd2BDAe7w0PEcT/9PF22cS64eWVcpqZZzcd0EBfmQsV6f0S0MbDTqhSCPixjQ0njQAkMGaS4RzDOz3TDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biozm+4w; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biozm+4w"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7426c44e014so955967b3a.3
        for <linux-block@vger.kernel.org>; Thu, 15 May 2025 06:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747316851; x=1747921651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J0YhKGodUV/0q2pt8iV2yRhh8Df+ryeJNwrffyqF4gk=;
        b=biozm+4w+re78dtz72Uaz3sX3SlfPJWKmXxyaLPsV1WNsF+I5SNsZeU9eAC5HMIYi0
         mSqkZC5cC0GihQMz+xXGpkfkSzGKzto5ElhPwz2k1uVbHBBveCMFyjv5CZRtefwYoxRU
         aPkeFLTtLqJ0mgF29njCfTZQjR0+pEbbB3df+27kNKzGtKU0p1I0h1sCe2g9Pge1M/J3
         sDrDRcPflLUtpGNtMNbxOPy6IaWs4BhG0rZhYHbO7W2sIHfuOi0cnmiIZ9nOJk1aOYkh
         iASddNMImWEC11qAuO1buOaQNr4NGu7QAI8SbQbL7fobA90SXDLKovupraQueHpZQtUR
         g2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747316851; x=1747921651;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J0YhKGodUV/0q2pt8iV2yRhh8Df+ryeJNwrffyqF4gk=;
        b=CV0a+iOcVkr1XsE0HC76aBw6LWpx9qw8eyyp97kIb3dzFlbFafgU1poIGgZNGvBNyQ
         jurYuhcBDozcPvFEomxx0GuEXnHpzCAwiu6X3Chsv0tUlkUgO4mMgJ5pxcDeSdfs1y/S
         /MFNoqh9WUEjhq3oqTXBP0CItX1Op6qMMiImEn+ozbDe7b4goTsoAfoCK86bl1/Tw9a5
         xk52PRnJ2Ojtg1W1TpTTzPgJSHkB/9eT2SOU1MyoHJ8eodQmpjyP/fJF6mosBWaDcygu
         o1bo+P2LC1sIyQJW5OW3qKqU9/JBajVhCIi5Qt3vwT3fsbzG1+no7kWR/ZYjSkepIahk
         1QYA==
X-Forwarded-Encrypted: i=1; AJvYcCWrz/lWhaeZShEnPK/fmM7jL3BRi/eGllwtgh8nDwVP4IrdW4qOpMMGEyVQkdqIm43/hywscrs71uwktQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMT62snZmEEA/kmLXWJJRdaBsc1Dy0pNkmC7JORQiNwT9FaQsH
	hqmkbYgC/cyPyB+rvHquKQytEw9+tVeKXKitZgXWX4Y0R/IeTnfMDJ3H9I8zHhGrZg==
X-Gm-Gg: ASbGncuwcLcQKNgm3BDp2k5f6fT8tGB4oG3QfwmV9RWlihM2VqLzsX0t20PnNr3fMJ/
	kMehFINuRbzrKHRRiZFw8UETWtk40+di/vz0lUvk8EjDuLmxeNC3NAUwzmJB1PypUrJ+mPbPGwt
	mKIEM5a55q7HqJXEX7ONEMyCATuVrjwugC7P0ABO9gT+syE1P6wOK5WcxrWEnJ/ODO5QLAX65/P
	BXqVe/yGBwWlz52TaW2k5iVHaH5t9FQkh/XXKkAdpV1gmkbnifE8U5hPO0RNfqz/ro5qAcTFocf
	YuYeMIiLg5UaldxPjEB3NqyHqAsLLynHvvaTTVN8nA8Ckw7bQ/M=
X-Google-Smtp-Source: AGHT+IEpyHJoBB4dmhaedmwTZgOUMqpUUgWGbygHY9za/uKYFLCs1scIBeDT9k/HepXpP2WDmQZJzQ==
X-Received: by 2002:a05:6a00:a83:b0:736:6ecd:8e32 with SMTP id d2e1a72fcca58-74289377eadmr11356450b3a.21.1747316851409;
        Thu, 15 May 2025 06:47:31 -0700 (PDT)
Received: from [127.0.0.1] ([103.56.52.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a97de2sm11617779b3a.175.2025.05.15.06.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 06:47:31 -0700 (PDT)
Date: Thu, 15 May 2025 21:47:23 +0800
From: Yu Kuai <yukuai1994@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Aishwarya <aishwarya.tcv@arm.com>, wozizhi@huawei.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_for-next=5D_block/blk-throttle=3A_s?=
 =?US-ASCII?Q?ilence_!BLK=5FDEV=5FIO=5FTRACE_variable_warnings?=
User-Agent: Thunderbird for Android
In-Reply-To: <0687b8cb-d543-4166-9d92-d22fc7188707@kernel.dk>
References: <0687b8cb-d543-4166-9d92-d22fc7188707@kernel.dk>
Message-ID: <4072C2B2-4D09-4C64-ADC0-AB2F6BE37C79@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E4=BA=8E 2025=E5=B9=B45=E6=9C=8815=E6=97=A5 GMT+08:00 21:42:02=EF=BC=8CJe=
ns Axboe <axboe@kernel=2Edk> =E5=86=99=E9=81=93=EF=BC=9A
>If blk-throttle is enabled but blktrace is not, then the compiler will
>notice that the following two variables are unused:
>
>=2E=2E/block/blk-throttle=2Ec: In function 'throtl_pending_timer_fn':
>=2E=2E/block/blk-throttle=2Ec:1153:30: warning: unused variable 'bio_cnt_=
w' [-Wunused-variable]
> 1153 |                 unsigned int bio_cnt_w =3D sq_queued(sq, WRITE);
>      |                              ^~~~~~~~~
>=2E=2E/block/blk-throttle=2Ec:1152:30: warning: unused variable 'bio_cnt_=
r' [-Wunused-variable]
> 1152 |                 unsigned int bio_cnt_r =3D sq_queued(sq, READ);
>      |                              ^~~~~~~~~
>
>Silence that my annotating them with __maybe_unused=2E
>
>Fixes: 28ad83b774a6 ("blk-throttle: Split the service queue")
>Link: https://lore=2Ekernel=2Eorg/all/20250515130830=2E9671-1-aishwarya=
=2Etcv@arm=2Ecom/
>Reported-by: Aishwarya <aishwarya=2Etcv@arm=2Ecom>
>Signed-off-by: Jens Axboe <axboe@kernel=2Edk>
>
>---
>
Thanks for the fix
Reviewed-by: Yu Kuai <yukuai3@huawei=2Ecom>

>diff --git a/block/blk-throttle=2Ec b/block/blk-throttle=2Ec
>index bf4faac83662=2E=2Ebd15357f23bd 100644
>--- a/block/blk-throttle=2Ec
>+++ b/block/blk-throttle=2Ec
>@@ -1149,8 +1149,8 @@ static void throtl_pending_timer_fn(struct timer_li=
st *t)
> 	dispatched =3D false;
>=20
> 	while (true) {
>-		unsigned int bio_cnt_r =3D sq_queued(sq, READ);
>-		unsigned int bio_cnt_w =3D sq_queued(sq, WRITE);
>+		unsigned int __maybe_unused bio_cnt_r =3D sq_queued(sq, READ);
>+		unsigned int __maybe_unused bio_cnt_w =3D sq_queued(sq, WRITE);
>=20
> 		throtl_log(sq, "dispatch nr_queued=3D%u read=3D%u write=3D%u",
> 			   bio_cnt_r + bio_cnt_w, bio_cnt_r, bio_cnt_w);
>
