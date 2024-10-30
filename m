Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A536ADDD2
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 13:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295098; cv=none; b=kAJqWtsihrzAF0Zem940QFdn2gJ85lTQhYr/LnAPDa8jZ5qmqfedHtA+RI57Xp+/q88TRlwyg0AMbsRL0BxyfbzfL4bif1s3n74fdJXkgCXbxsMLrPTuqRwv8qDQtRsq9xkAAeXr/kYmcFxPkNM+6Lxs3f0Up/IkF6pqwZUhiSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295098; c=relaxed/simple;
	bh=JfEjxbbjSy46q6R4UVWqsoa5drPceNueU1cJkIYvP4I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jneOEAhX25sDQV9P/Q3e6OWkjyLh73GKosEHM48DJbKUKltJiQsaiMosuXOwOxYbTWV5Z51pHYoiCDkNjq/m0SF9qj3vkoPsqKXNEZVaapldyV62CzIkNl7lrR8QsE9j7ydxfBwZ8vsMQ5HUqAdqARHgWU81Nj11u5lekDOkuYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wBxmOjdB; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wBxmOjdB"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a3c00f2c75so25281115ab.2
        for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 06:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730295095; x=1730899895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QG0bHo+3AaqkzRTJMo9uhs8IGAc5w0zj0KZJJ320Jpw=;
        b=wBxmOjdBej6Fhb5rmhQBQq5PhI96RLWkT1K2PofEIP0ROELh5vP8rsoZUDxxIly+WG
         e9sXfynIX3ccvbDVNncxmtKAesWnltN5bv54Per26s1LfBMPv1e+fLJjvQa0UTMI98X9
         JIXQzzUYiSJe+zn70aStXTTTzFmUMKQJjG7Vrux6pH4suON4RkTaNJtc+mqoDa3mj6vV
         V9Ay13iUZ/ulS6zpHDRjZRJBck7dDmvgTmkuFvAx4w9IZfTStXn0KeJVxRv1lz8NEMnu
         hdRllp5Vs4ZYz+NpUmFzst5ClevYedCTFiArEXWdaBbRFJOcx/gCB6RD7uopoJXzgKn5
         wjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730295095; x=1730899895;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QG0bHo+3AaqkzRTJMo9uhs8IGAc5w0zj0KZJJ320Jpw=;
        b=xPejg9yavxoBpFgDBxEQgEXJNaF1eCKViwR0SLEyEA0nNSr8yhkobje0RqoQqGDU5R
         p75Bgcu7HtSMJWXwU73MOTfpUvrn+iRuW2EUK2czb/tEAu6s4GTrO7CKcrVV9jfp4LiG
         /5R062EnxlNX0V4btrbBUKefB82WsByQX24XjgIluEieX9Ott+pAa8LQs76+LPwzhTv1
         KfDzbAd+p/5JK2CkDnvH6fGmWJ6I0rQnIpq/AZUjo9ZppNrO2zHIUDBPbCP7zucS1Bc2
         ePag5JIC/fSET2IWOAZD7nSKLqw4esRNw+ujOMXZa/zMgvURrnuSQwtgtBZv+YzE+Ep6
         wJAA==
X-Gm-Message-State: AOJu0YzchpUVAFu9o9cy/c8eRoURIPHtBk7lHw3dA404gM4tX2q0Dfwh
	oN74VDoSr6rK0SN3GHwQoSdd0xvLXLL4NZSVjcsJ4GgmtkAznH7IaOxTuyIB40U=
X-Google-Smtp-Source: AGHT+IHBDoYFIQE8HrLOQVHt8MGkWKETeOH93sSfgYs10/jYifF8nyLcHZjgCOVDnxwsCGZQzscoHA==
X-Received: by 2002:a05:6e02:1546:b0:3a0:8f99:5e00 with SMTP id e9e14a558f8ab-3a4ed2799ddmr150334795ab.4.1730295095431;
        Wed, 30 Oct 2024 06:31:35 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc72784f07sm2829826173.153.2024.10.30.06.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 06:31:34 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: ulf.hansson@linaro.org, hch@lst.de, yukuai3@huawei.com, 
 houtao1@huawei.com, penguin-kernel@i-love.sakura.ne.jp, 
 Yang Erkun <yangerkun@huaweicloud.com>
Cc: linux-block@vger.kernel.org, yangerkun@huawei.com
In-Reply-To: <20241030034914.907829-1-yangerkun@huaweicloud.com>
References: <20241030034914.907829-1-yangerkun@huaweicloud.com>
Subject: Re: [PATCH v2] brd: defer automatic disk creation until module
 initialization succeeds
Message-Id: <173029509229.12165.10740300177309636784.b4-ty@kernel.dk>
Date: Wed, 30 Oct 2024 07:31:32 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 30 Oct 2024 11:49:14 +0800, Yang Erkun wrote:
> My colleague Wupeng found the following problems during fault injection:
> 
> BUG: unable to handle page fault for address: fffffbfff809d073
> PGD 6e648067 P4D 123ec8067 PUD 123ec4067 PMD 100e38067 PTE 0
> Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 5 UID: 0 PID: 755 Comm: modprobe Not tainted 6.12.0-rc3+ #17
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.16.1-2.fc37 04/01/2014
> RIP: 0010:__asan_load8+0x4c/0xa0
> ...
> Call Trace:
>  <TASK>
>  blkdev_put_whole+0x41/0x70
>  bdev_release+0x1a3/0x250
>  blkdev_release+0x11/0x20
>  __fput+0x1d7/0x4a0
>  task_work_run+0xfc/0x180
>  syscall_exit_to_user_mode+0x1de/0x1f0
>  do_syscall_64+0x6b/0x170
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> [...]

Applied, thanks!

[1/1] brd: defer automatic disk creation until module initialization succeeds
      commit: 826cc42adf44930a633d11a5993676d85ddb0842

Best regards,
-- 
Jens Axboe



