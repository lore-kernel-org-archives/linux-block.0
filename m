Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301D91DE8BE
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764598896; cv=none; b=Wtt5mGFbiWN5zpAYnlV7t/1KUYHW1tcc1dHisM66MetL5k4qIpQtKDw8ntHXNU6dGrHkE0f0FH+GJYMxCSrX3jOe0YH2eG8mMnAzws0+1SwrFQ4VHAW1JKrQFX8XPbooUg98R+mTB1oMOVePu55VOZY17xERx39xnCxWmMzN/U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764598896; c=relaxed/simple;
	bh=AVkpwlE+XPpCqhMAHz/G9EgcpLoGYA3u3IJFugVwQus=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HYskuhCotISd663OtTrdeEH+KAopcf6Xv++gq2V0jMmS94fzGB7pnubs9jghQiX7aP62WaIDaYxw2mZVLV09lMeONK6V+C8WlPydIH3e45KZM/vyyyBNtlFdRBQIrW9wxCt9WtkXc9plG6URKZLbh/1Y3YrZjcgdPPq1rMW556I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=diXO9nCS; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="diXO9nCS"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-94880628ffaso159090339f.0
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 06:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764598893; x=1765203693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dmqefrKstVvcepMtVsZp5aB8cPGmO5tuI5VefddNQQ=;
        b=diXO9nCSYdWgrL/GFDKNxepyks6e0kk4eURn49B4ONJimaOEvhUgGRtYuyOqfWEsC6
         G0JjaubLdQ/YSwErfkbYjyJxI5HiVlg5HMnLllb8espGoW93/P9VgAi+v11GAYCS1HN3
         sEmOqDs39GM6ZDP958KSe3cTichTGB8adlF18yLoTwynngFXOZCLEIXrFugcQBPtSoiF
         3rJHIQuZiqJS+efg/C3s5DsgnLwpRcbuHDL7AFk/IfmIluVTkFGvKnsvSybdcbRRK2mV
         srCxEoy1dBvvxOChJ8eYMhzGh47z7mVZm9Mua4kYpOlw8+mPUDIBntrZU0NR5nSOGPaZ
         2Wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764598893; x=1765203693;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0dmqefrKstVvcepMtVsZp5aB8cPGmO5tuI5VefddNQQ=;
        b=AcEHT25rO/HDlDG5up/e2c/bSIaV6aioKMRP2pq7SQHOJ448sGzZpVRMUKqvK54BZ1
         +7fo4XpNl2njKyl25++1ZqyMcAu60EnqVg97ETFH1zPsEKyiYR8FUS//bG11c57kl0Hv
         mJ/P2Fz21efa7BosOvXEiladmRmcTEArFCxD0XsLuPs99ApNsXVM/644vi2vtbSLoKWn
         +Vf33YrtozHFxVa/rbTE/TxqD0gyVd6gBJC86iki6EYgD5aaQYCCcJlEcg+IRwIruoNU
         ApksfRXHZBO5TNoDZdzMmyIUnMqyzxLykcQizrXCGu16A2hVCI5WbzQcbQcD49D/AOMk
         ZpKw==
X-Gm-Message-State: AOJu0YzDkSDnHLze7nQlbJKCHbKufpE51ZoE5XZSgdZQqXv9GB+EgEDy
	/wQsyVO9tO2d7YmCrx/GpD0zrQfNQqHfmjwTL4P/goK4cULejhk+545cRnX1PrXacgg=
X-Gm-Gg: ASbGnctyr4xZlols7BTbS8tlzH8C6kjgxJ5WkXxPy1q73nEjXUtil9WI9iUfuWvIOG+
	aEIatg+S4Y1sBhCP7v4GjPsLrhPKeqjrwUA+WI0al8g60SWhjt32GLEFyIKCW2DpbNa6KHBscUI
	gvaWNPiInsNSU53Se9GaPS6zxD80LyaWeTIdRAfGostG0+zao68+mVYZ4xFxvuJhPxDaQUEIq9i
	gTY4lzjZj3uao5OOsMM5Y26pyQi5c5M4YCGbvD3CgSRXDJUKo3Qtwav/vp0UDzfvEf8HZmBEJzi
	Vp+eb3BXBhCDuwqiXFKnq1z4OkQ20kNbJXWUv8MIXZQxzv+nZ9cclt7opwHX4ErAcs836pm1ep/
	xB/Ra91u0q3h0p6AbRM3yMNcOB9jY0pBKzziR84Kxy55j44eo3WyAouIY5eSRBO/EfdUsK2zs5c
	vtvA==
X-Google-Smtp-Source: AGHT+IH1RzKehQcG9R7gLk4AvlKgLKTT3BNmzHzt8guhqnCxTkTDNQGmkgxHbKX4q7nTTE1gNfsgGg==
X-Received: by 2002:a02:a913:0:b0:5b7:11f4:232 with SMTP id 8926c6da1cb9f-5b965b1b9admr25351652173.9.1764598891594;
        Mon, 01 Dec 2025 06:21:31 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b9bc3716e2sm5795794173.25.2025.12.01.06.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 06:21:31 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, ming.lei@redhat.com, hare@suse.de, 
 hch@lst.de, yukuai@fnnas.com, Fengnan Chang <fengnanchang@gmail.com>
Cc: Fengnan Chang <changfengnan@bytedance.com>
In-Reply-To: <20251201122504.64439-1-changfengnan@bytedance.com>
References: <20251201122504.64439-1-changfengnan@bytedance.com>
Subject: Re: [PATCH] blk-mq: use queue_hctx in blk_mq_map_queue_type
Message-Id: <176459889072.423001.3924642755209582792.b4-ty@kernel.dk>
Date: Mon, 01 Dec 2025 07:21:30 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 01 Dec 2025 20:25:04 +0800, Fengnan Chang wrote:
> Some caller of blk_mq_map_queue_type now didn't grab
> 'q_usage_counter', such as blk_mq_cpu_mapped_to_hctx, so we need
> protect 'queue_hw_ctx' through rcu.
> 
> Also checked all other functions, no more missed cases.
> 
> 
> [...]

Applied, thanks!

[1/1] blk-mq: use queue_hctx in blk_mq_map_queue_type
      commit: 4d0e1f2139ad452d0e209a16b3d016af2f8ef1f7

Best regards,
-- 
Jens Axboe



