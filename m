Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C891D1F7B
	for <linux-block@vger.kernel.org>; Fri,  6 Sep 2024 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634286; cv=none; b=kaArAxAyMgFnxYUwDOsmblZ4psDGPN4w9Kn0Xhb9FN3nZom/EKh80RULyqIu5NdSm7Heq3Gn33emf5Bn6gabqdI7kihv03jOhZnMGaPf7UKQQxJENCZRzH/wjlYh8cw8FrWrsf7Ebr81uLhPTr1+bGFWw5CjnCZm5f3ELCVZFiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634286; c=relaxed/simple;
	bh=Z1OrjkMwic7snAUvdTaPphz5FQmZCu4Txatz2tUbX8k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sge/+ZHcSSNKQR7FDq8dQh3PqMC8q3fxPaXBcxWqsBCaQ8bK0ylPnKhJZmlSswd8KIOdywOd59Wy6zWicNTf1AUVHyDv5XdVq0m+BLogbpTFGyjNmLogYvI2uHisLSPyQI0LTVLYNcfVelxToQdxxEbMWYYkfRQDo05bbb4FcdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YpWuXAlj; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YpWuXAlj"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71798661a52so1062383b3a.0
        for <linux-block@vger.kernel.org>; Fri, 06 Sep 2024 07:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725634283; x=1726239083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ujc1/E9XRouz6Q28fqHYHFY+Z2eibCZnVzKCOJW3+VY=;
        b=YpWuXAljVsaw70s4BruaWsdBu4e2q30FhY2V/7BW49rWWuY6YA5ansXCOcEnjDs/27
         lUJx17AMcff0oRTim05P88GZCLHzyHVDAu86U8N+3fTEgLY3sYFHEsVtpwujSXc3ULO0
         26L5oIebZECbZvo9zlM4Pd/Hof0aHyjAd11ymII0+wc7h2Je7fYdswWCkhhnnDDW9hno
         6xmStoX9yPl132AQzZ6tsXVWlpWhit8Wf4t1W6VK/OMO+jAPyg1O4oeiEw/6GyIpnEVa
         XXCUgiff+kapcNirNbY1z+PuSXGfuAtm6Yz4YlHjSmySD4teaEXcee3YGaEQTFd4jWHt
         XE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725634283; x=1726239083;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ujc1/E9XRouz6Q28fqHYHFY+Z2eibCZnVzKCOJW3+VY=;
        b=b5yKY6sOG20I0k0aMtKdEDET4hobiXnnXFPnc5iVHFqWCqKykmNmBkISryb7rr6d97
         e2oOydWZ8skevLrv+kCgbnd81Sxg1KJ8hqdawvyYZpOsm2AUexkpcWpxOr8XlzrqWIyQ
         SRcmK16K52tpheVQ1NOBnR1t2UwRt3ANyPcWCOV7t+YHqadev8wYHT0a+sE+vtrjoSNK
         CEouVsZ6Va/5lrvWpDV1OR0Qq+nUzJZbevvyV0kaqFPAe6m15T3F0yLuHBBHlUqlxglt
         cWsw0vvU1zAlbhGhAB7ysW8IRMPAdM9viL8/XZAHxpMQY9ddbOCtx1gC3lcV3sTwWjqB
         cfCQ==
X-Gm-Message-State: AOJu0YwQOhWkVCzl4EHOU/4pYXQvBTnkafTIRZwj+5arNfkvffkJdlNT
	VPs4AMzSiaaAl5EXPR6gCvXLan+nYDBltieWGMLP6AEqjTRdS52aGEV3qGyWsRE=
X-Google-Smtp-Source: AGHT+IEUC5rtrsXtYDv/fRA/pAXy/E3nqDxKOGFW1U0rayUzPiaOSWvN4+jeEb2iNdqY8C1bzUGvRQ==
X-Received: by 2002:a05:6a00:1303:b0:712:7195:265d with SMTP id d2e1a72fcca58-718d517c2eemr5043514b3a.0.1725634283225;
        Fri, 06 Sep 2024 07:51:23 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717785331fbsm4930487b3a.68.2024.09.06.07.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:51:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Mike Galbraith <umgwanakikbuti@gmail.com>, 
 Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20240906141520.730009-1-bigeasy@linutronix.de>
References: <20240906141520.730009-1-bigeasy@linutronix.de>
Subject: Re: [PATCH v4 0/3] zram: Replace bit spinlocks with a spinlock_t.
Message-Id: <172563428176.173362.6692138069455842459.b4-ty@kernel.dk>
Date: Fri, 06 Sep 2024 08:51:21 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.1


On Fri, 06 Sep 2024 16:14:42 +0200, Sebastian Andrzej Siewior wrote:
> this is follow up to the previous posting, making the lock
> unconditionally. The original problem with bit spinlock is that it
> disabled preemption and the following operations (within the atomic
> section) perform operations that may sleep on PREEMPT_RT. Mike expressed
> that he would like to keep using zram on PREEMPT_RT.
> 
> v3…v4: https://lore.kernel.org/linux-block/20240705125058.1564001-1-bigeasy@linutronix.de
>   - Inline lock init into zram_meta_alloc().
> 
> [...]

Applied, thanks!

[1/3] zram: Replace bit spinlocks with a spinlock_t.
      commit: 9518e5bfaae19447d657983d0628062ab6712610
[2/3] zram: Remove ZRAM_LOCK
      commit: 6086aeb49e3d9e25165769b2a0a13ff67f98a1a2
[3/3] zram: Shrink zram_table_entry::flags.
      commit: 68d20eb60efbdc80662efedeb088353e9c4aa17f

Best regards,
-- 
Jens Axboe



