Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CADF3D1AA6
	for <linux-block@vger.kernel.org>; Mon,  8 Jun 2026 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929273; cv=none; b=ScJ2M9cKpdS3aeD6MrsxVN2tHOuVqw37WIYqHaUNeRNuaHG7u9ygCDOfP7Cgj1VVkImrRu5JFpSTZxetZcMC8mCM1LBgpuMmDfqdaB5k8gOpozONhgSplAHh5UbGUmJJPzgOktco2vd5yQ/Li0vvHXMQJpLmfiuRKHF2ZEYmrtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929273; c=relaxed/simple;
	bh=qoYJ4ZOXQM/tDQPzafgbpBJ34Y0uEUc4WCcwNTJifsY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hqsAwm20tgdUz2hOCm30luEYUi4C/m1TJbJeykPj3nKkrhhv+dcVCe7nlLE8UUyufkkbhXkPd5xwypaYRpCy1AJ+0JayqDnV5qo9jOhVw8Vat0qgFTF93Q+6Xp3xNglW7xfKqxR/9h/tUpsY0mAjnceApzWgd2yKVSjzJEbl0AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=bQWSASED; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="bQWSASED"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-69e66e11386so1393054eaf.3
        for <linux-block@vger.kernel.org>; Mon, 08 Jun 2026 07:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780929271; x=1781534071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4ofM2BsLAWXXhsae9VD6Ch8JaXFv1QC90mIszAgAXE=;
        b=bQWSASED/L6EfkBQpXge4PHqoEAwF1/VNJR8XdOskpT9/9K1t+hkvXZXRik+ZWmhI2
         R1o+Xe9OSgUxOhkxsp4kSEVOIKtPKuIIySVC5CEnHwSe37peDzFN7l0m2swKs2KvIOuK
         8n5EvAgQWx6q94QL253k2LvqgB5w5U2QS27jXQqCAy8v++UadX/WiyHyvMv7hwQT16CU
         1C0JDIHdzHrJx5oYYLVQP4m7T4gvLyagDFX7iPHIffO7ww0r5viNRP2AWsN5/s4I4GE+
         yW7ZlYMYO+KHn8O82gY2Yu1/KBOqaIA3M/pG90cP/w7GdOUYJ25EVseExNCM/LNGkUc5
         ECAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780929271; x=1781534071;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G4ofM2BsLAWXXhsae9VD6Ch8JaXFv1QC90mIszAgAXE=;
        b=lWJrPqrKCd2sQwSMYUMwItfY86+gnIZ5NFkCn4jKnJ5Lpx3cVoO+BUICnbYxjjcmfh
         OEw8mHGMsby0xjg2zYaXhrOez/kAptQIR0UfeU4oALeUE+TV5v2Aqx3zTjSCy7jX3NZ7
         eEgJH6h6hdSF3RymCjLYytWFp7f5oRZYShNiHyMiORbu0g51fDwxGBTsUhwi6E1Sy5ET
         NLn1HLsy5OWA1p4l+vY/X88RKcSzbKnx+k8bGF4PMNC/4zu/paBnK3xae3z/mIPkZXHY
         NiNMXJ94yAKtzGc/IfZTVh8QnOQ1Y+Z4wMp9Xnwa3nklKB1KNtI4Qez7SHxHJiImVoUS
         2DnA==
X-Gm-Message-State: AOJu0YwZpVMao6PAxB5Keu2Y1Xpms3z638KorLyfiD6WFwI8jsApTYyn
	0AweGw18DoAJhqQ+ZHUEMtXxumKtFve83B8/e5ht2OfarrDW9ELJ+lswxblxvktyXmvyEFBYu2C
	MQ3w1
X-Gm-Gg: Acq92OFiGVKp+PKS76kzvmoWa1zPgPE2HiajB7pgoBnqDKb/hCSQA5nfhif43wLZHty
	HBrTL5XHKqkDHxX4IYo2Ki8wi6Q7H9TDc93oc6i+nzGWNpekwmngh/Q0WkT2/2r11MEoWycHSgf
	gfUO0f4H2tqV8OesAjPkZiwPoeIOAHKULRZzTwPfrttHwtLbpLGPT5cvIhTow8xnb8XLks0AucJ
	58XYOOkccTVITD/V0dqsdVBZ401+vi/DHeI6ZQdDrbXX6yKxb2Q4mE6FYQUQ4MpPkQaKxDEFuzu
	UL4CuuNcJIYJ3GReIkGFdEEq971JCy3G20v2VKWxPUkcPnO4dgsGvULq1XC/iTpkvEXoL2Pe+YT
	I4yiKR7x7MPvkW3CGIWAiXbQt2hX/M18DFjnvYQWMwmRExHAF5Xouwyp2q1Gz3qWTnlBguwBC69
	LcIfjnh365WFLg+sWTxBoan0fkrHLRt6rRv/iEfdNb7Okk3MiPw4pYCjTuraWF9EaBjakQixbCz
	PVzfbRkIaYtpYL9ELpwk6+RwQ==
X-Received: by 2002:a4a:e053:0:b0:69e:6606:d137 with SMTP id 006d021491bc7-69e68b5f73emr6960852eaf.22.1780929271364;
        Mon, 08 Jun 2026 07:34:31 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e464050fasm9622409eaf.9.2026.06.08.07.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:34:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Steven Feng <steven@joint-cloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <tencent_79B652BD0CC23E093F27914380F161E7E505@qq.com>
References: <tencent_79B652BD0CC23E093F27914380F161E7E505@qq.com>
Subject: Re: [PATCH] block: optimize I/O merge hot path with unlikely()
 hints
Message-Id: <178092926806.1038952.10749895636675728500.b4-ty@b4>
Date: Mon, 08 Jun 2026 08:34:28 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sat, 06 Jun 2026 10:42:18 +0800, Steven Feng wrote:
> Remove redundant '== false' comparisons and add unlikely() branch
> prediction hints in block I/O merge path functions.
> 
> These functions (ll_new_hw_segment, ll_merge_requests_fn, and
> blk_rq_merge_ok) are executed on every I/O request merge attempt,
> making them critical hot paths. Data integrity check failures are
> rare events, so marking these conditions as unlikely() helps the
> CPU optimize the common case by improving branch prediction.
> 
> [...]

Applied, thanks!

[1/1] block: optimize I/O merge hot path with unlikely() hints
      commit: 7ed4aab1381f3439f45032eb860f89d9da5e45c2

Best regards,
-- 
Jens Axboe



