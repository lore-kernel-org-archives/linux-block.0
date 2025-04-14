Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B702DDC3
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 20:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744663179; cv=none; b=amV2NC2DdLFY7pW+YF0Y8tZmeO5GX8XNGIMg9CwZYj7Uba0zjxmEnOLjasV4JgrPGbrviyvBbkf5u+6mw7vVjpwcxnnykHGHR+QrFVRjNNVwdpv5Wkx04IoCaoZP+FydfdHvLQnYh2fdzAARXDTSqy6TTf8aKlSZ1fIafNYfwjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744663179; c=relaxed/simple;
	bh=KIX1w6M1KYQKkOIBF6xWRECPRnCF3gAFCi9OQhBV0PU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMko59RW/hjoQL5wKYoVHLBIrshICStatBcYDDaZbQyCU0V7p3WdkBiWqH82PDehayKZU5++ZezGFpF6opnWsI1ZVFtYma7lRFB7lEEwtzvVhgnON4iWuBq3Zauv6+tx8rgNF+INkKqcXb942FdvU+5focteTZiOPzRUdW3iz+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bO5FqYb2; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bO5FqYb2"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d57143ee39so38236565ab.1
        for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 13:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744663174; x=1745267974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HT4TcquhhzPero1S7aUOiqfCvNPKcjRzh++p8M16d+4=;
        b=bO5FqYb2BvqFp7J3C0M+o1Y4a7DrGHgLQw/UR8t4oOxzHaA9Jm0aN+opiiXGf4D86u
         dD31yWvmqDpdzR4axbfvsSbZR2qg2DxW7u/Tidal4q09oIOKwChZPNE/3mB9zcZb03m8
         0bF0ZIoN0OOoQlYUeN/1X2cK6ZYDmefUAaZXCIH1oR6Q45CG5KjuzYd6BNKMO2oVlKMP
         b5FNyrvwRdWIZF85J6m9UFK+tuJO826/MMUuBOLnVduAfuL+OkA1MJClw+cTQP1CrREN
         D1lfyXDT6YmODxky2qrhTdDOlTOaaq6OJagJx1b6KlIjj2kIwQL/thSKYb53Ir5M+qJM
         1XbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744663174; x=1745267974;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HT4TcquhhzPero1S7aUOiqfCvNPKcjRzh++p8M16d+4=;
        b=V8AXH3Hpshw8PH4kOWPTjAt6lKTYitbs9Rdm6bYjZlXoTG55twv1t0WOjhIZFFlOc9
         Qzkbm0CzATxlbg/LjYmABsTnVZNG2WKo8L1TjvSm7Oo735zsPFjForAVe5miSz1C2UWM
         pPuiAHsFH2I9XwoqoYhDuATiybtdZ85ykZTyvHkb7/U/9LzaHrcaNlZPPgQj//2Irq/m
         yzknFchW2x70hVyl4akNlMrs9hnAtcXvTdZz7aI7HgXIW/f1N19aQJHkJGEH0rsJI3Ok
         KSMjV8tMyxD8jstZNraDd2PgOlpeBlcBwwblztonQS4LNQGQOOj1mmSeLqHYp6+/Mqhg
         hdcA==
X-Gm-Message-State: AOJu0YzoN1+boTr2uS+xqFzdfvYrusE8kLggK6KVJ4RpfWnMmWjP26fC
	zQDb3sbyyx7a4LkmsFtuaFJ1GIf/D4oC+Th1p4slGZRnBwYlTARnIuS5lFL4co8=
X-Gm-Gg: ASbGncuHIBs8KTODvgCbaMqv9KSXRfzdO6SXTcEZDF7PG01Qq0y9+CqLrjXObjyTA60
	a6AnVRrQnpQgcLA4d65fCPOhSyNlfyFQloe6P6c0Uxu2Q8/PEc0u4Q4NWU9EbKOGSJ1YxBub9fY
	SL2uYMprpTYJFK6SXRKi2JWnuZRLC/ZRy02l+qjfX0pZ6C/HpbYVahlbd4r/ykwhW+EhhZisYON
	5JhdsTJmU7rd3OA5ilcpdAqTVyaJQRzks2JHnVENoXxgrOjRqJqciBwG9A9JKZU7pVVrfBaP3bk
	TuEdLbtXva+rFj9rejgNdATUAdk29aVb3tXvlg==
X-Google-Smtp-Source: AGHT+IEWS7D6RQyL9M0poy9mQW/rYC0sfbsDM2Bl1K6MjkXERga8B0qGuh1q4vQ7A+myT3FexiQBXg==
X-Received: by 2002:a05:6e02:378f:b0:3cf:c9ad:46a1 with SMTP id e9e14a558f8ab-3d7ec21c324mr121701045ab.13.1744663174381;
        Mon, 14 Apr 2025 13:39:34 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505e2be7esm2724528173.109.2025.04.14.13.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 13:39:33 -0700 (PDT)
Message-ID: <dc912318-f649-46bd-8d7b-e5d18b3c45b5@kernel.dk>
Date: Mon, 14 Apr 2025 14:39:33 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] ublk: properly serialize all FETCH_REQs
To: Uday Shankar <ushankar@purestorage.com>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Caleb Sander Mateos <csander@purestorage.com>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
 <20250414112554.3025113-3-ming.lei@redhat.com>
 <Z/1o946/z43QETPr@dev-ushankar.dev.purestorage.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <Z/1o946/z43QETPr@dev-ushankar.dev.purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/25 1:58 PM, Uday Shankar wrote:
> +static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
> +		      struct ublk_queue *ubq, struct ublk_io *io,
> +		      const struct ublksrv_io_cmd *ub_cmd,
> +		      unsigned int issue_flags)
> +{
> +	int ret = 0;
> +
> +	if (issue_flags & IO_URING_F_NONBLOCK)
> +		return -EAGAIN;
> +
> +	mutex_lock(&ub->mutex);

This looks like overkill, if we can trylock the mutex that should surely
be fine? And I would imagine succeed most of the time, hence making the
inline/fastpath fine with F_NONBLOCK?

-- 
Jens Axboe
