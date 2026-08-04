Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C0D459AD7
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785849807; cv=none; b=GnppqiyXqhmzWwHaGeyhZ2RIJ/buXEM+DF/J5CbxeE6RGo4n1lU0W+Cu7xhPC1brMy9WSHhVNccS2rrYST2/gY8JRoHWdXMND9vsi8Zxme0rlqHiaWsJ+9DpM4ZnXPP5Fz9ZdD0xv5uOz64VfVVAnsCSQhLJWEgNp3UsJyMgT2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785849807; c=relaxed/simple;
	bh=nJGLwOnjaiBGr3EByw1hYgPml8fYT3IQsjeefH14hdc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R8NLBUS1uYBGZP60yvkFc6lHhUvPPsRSFNYEfMFMrPMkvfSKz4VdVrO8aruQNc86c4dv9xToUKdZpk6RcBBnb7BTKMPQDTIJ1lbnnBvAAuSs8T09wh1Dwmwejd/uZLsjeFIbnA2N3YTCLFOICbeZrPxjkZ6nwmFGLX2LsIA1ubU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=PD8eEW0D; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="PD8eEW0D"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso5094966a34.3
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 06:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785849804; x=1786454604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RpVxsVekQ2M9CokiwJgSvP8TW55dMVQmJDPHcSttZIE=;
        b=PD8eEW0DbugPbt6RfZ11dAUcnJBahnu1PPs5Pd0d/YOVlGlH6x96F/rfwVfh34q6Du
         4x5K0VlJ8dvvwneyjHspysXAihMbD3ZJFW0SfyaC5AHCFUs9WkA5In63z0B0q05ZU5rG
         ftFdUIuRqyTJ28Hid/z2rVmYDr/tLglvmT5C9leaJU/oSt4BTEMCgyP8QXhlDC+xJ9vz
         MHAOrvBO7hkANitKHwg3+Cl15PG0jk4mfI1QkMJ7z7WUSRbHfTXxn6pQfDfErRe13UL8
         kesEDkM1PX8gqv3R7xnZEPNdDYs0h1Te8ZnMzIZOxPmTHf99jEBdjwGOaEAvMvoXHkzh
         zV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785849804; x=1786454604;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RpVxsVekQ2M9CokiwJgSvP8TW55dMVQmJDPHcSttZIE=;
        b=n36jVWHXszTc8e+E4sv1sQTFURUHBp/O5cYO4tTiETXXRXCMHdby5RWP1wDz7IMJcm
         t723IpZS4z/OjSTwFejdDdXFBsZVt5klvCjTAebdSjX2i2kyabsu+gLXZE4gp8CfK58o
         fhokSZSTVLj0+8rSINRKCQfl/OSAPWO/9q5ZjPs5LNBfWiP07y2JfvvwmMFaEdkvrFUr
         fPYYAAFcq12I/xY54UZk7tNibiZ2aZWSoIA352zgjMSP8COLzGSVRTLHjx+GzEt1/ehN
         uZ4H+k4aRQYC0FwjNnvq4FHTWncG8zdXo0OX7a1TYx/uHFX4S6TyA4yGLtswqeuIlKU9
         b69A==
X-Forwarded-Encrypted: i=1; AHgh+RpmFubMAK9BiDHUEAxPi0EA2UGUTF+MKmXhf1lWHjj7+pXf4gL51cj6wVRWEYu9mANX2BzFAyLhpCKnRA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5QvHqpbqZ9J95oAsjN/zs60ILJbTEJOxL3GrVIxz/Bpz+9CZJ
	X4meTzIlsfBpdcyLrWlrzz5iD9nzSeCI76e/w3j8ffJJdir9JB1+LG6Y6JoTCdHGLBk=
X-Gm-Gg: AR+sD13ziTowAcuSy7muJd6na5MlvpRNtj4EAVrJw5TK/8BKd/bH/K925+piONMYB2r
	SkokMik2M/CErmALF9S+diF/f2D5SQLvzLdCg8eQwz4JSmNdIkqiB/yBFeunmLifWZYkUT0mKmY
	CDLUcxC6vZ6P8C1/4rwZCPoBr9uL9UJ7Prw1ZPHDL0DGVeXHv+p7l7SEYklJFmMnwUqUUfQfqAK
	a44pxYY00ptV/JPOQ/K/Gwf50hz4uHOy1jb7CAhNgumtfAgMisv5E8TMRPuPqDf8kSQL+Jr2ZeW
	jOnTCn642iVhsyt7+NNjHSjcqI1UUcco/St9LMmy0Jw0VXUhPehzEuiCDxQYFuNgqGojkmJCoGO
	TA/J8v5Pc4gK6+cH5Q1Vvkt9ilUk+oEdd+zWVdWxcR9awNWK79tayX4T2xBIafWJonScdqItPP5
	flEnEYWjlNRGyjavrp0Y0YLs2vOKTZKy5e/GgCK5XZHwkjV7m2RJDAHdWi2wsf4Y6f9gR/Jv3jk
	oDqv6zZhycsc7Q0Yr6GPfKDdAsESWgkLYxbZnSKvw==
X-Received: by 2002:a05:6830:81fb:b0:7e6:f482:df36 with SMTP id 46e09a7af769-7f196f48cbamr26550307a34.15.1785849804022;
        Tue, 04 Aug 2026 06:23:24 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f1df568d7csm752384a34.18.2026.08.04.06.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 06:23:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, Tao Cui <cui.tao@linux.dev>
Cc: josef@toxicpanda.com, cgroups@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tao Cui <cuitao@kylinos.cn>
In-Reply-To: <20260804054120.161933-1-cui.tao@linux.dev>
References: <20260804054120.161933-1-cui.tao@linux.dev>
Subject: Re: [PATCH v3] block/blk-iocost: annotate ioc_pd_stat reads with
 data_race()
Message-Id: <178584979848.950360.4692094909873127154.b4-ty@b4>
Date: Tue, 04 Aug 2026 07:23:18 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Tue, 04 Aug 2026 13:41:20 +0800, Tao Cui wrote:
> ioc_pd_stat() reads ioc->enabled, ioc->vtime_base_rate, and
> iocg->last_stat without holding ioc->lock, which trips KCSAN since
> ioc_adjust_base_vrate() and iocg_flush_stat_upward() write those
> fields under ioc->lock.
> 
> Commit 35198e323001 fixed the same issue in ioc_qos_prfill() and
> ioc_cost_model_prfill() by adding spin_lock_irq(&ioc->lock).  However,
> those functions read configuration parameters (qos/model) that need
> synchronized reads.  In contrast, ioc_pd_stat() only reads stat
> values (vrate, usage) where stale reads are harmless, so data_race()
> is more appropriate — it silences the KCSAN warning without adding
> lock contention during high-frequency stat reads.
> 
> [...]

Applied, thanks!

[1/1] block/blk-iocost: annotate ioc_pd_stat reads with data_race()
      commit: 4d73bf0ca4fbe7f252154ce98d6693c6c198164c

Best regards,
-- 
Jens Axboe



