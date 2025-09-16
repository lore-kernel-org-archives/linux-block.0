Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271BE2D9493
	for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 18:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047405; cv=none; b=HbGA/u/4w8Eua66NDiRfbkSdIdXtMiJ6IbvH0coCQZOBUV5bEkI006dJg1xzLr8uajWdpbki7QAuxaNOivcD9qHPd45mjASkH/FSAPLv23UDCW2ZvySR2KtfPCAnKYm/2LVgSHh+WGQcqplJYSoT3XlQLXswMyGHcUOZZkY2jK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047405; c=relaxed/simple;
	bh=6ak//zH4sFfTcE/2FvJxRzn2ut0a85H/Lqe/2rChH1M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O83dAZcNLa2OGeS5cEVPyPhbYdFvE5mNM3AzUpprTkto6N8Wp9OI756B0mzHoEa9A8p6E7PSYXzETn9RuNUGYWCePhJB50zxiVhGtnbmKT8ZsEWrBQlQJV4Mi6ZW33pGCelJUesboxJQsYwazOLz/qgl/wIMEEVWQmNa798cCZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=z4j0BKAw; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="z4j0BKAw"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-4240a63c68dso19597085ab.2
        for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 11:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758047401; x=1758652201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUXb+lKCIzcI280/t4rrhVkdvMspmBSIeu9u4mcudHY=;
        b=z4j0BKAw430E0lnefQt1QwZCm/EmtML9WDiyetPdDoCFa1ENJqutrcPLPRJLUgG7eS
         2qzvHCo9kx2jUaFApL0S0ACYt8jT32v46RfWMpWxfH/1q2subZKKmsmfjnbRAdEpB4RX
         jCRGQK7x3esBVF3pppH+DrIqzh4DtS5rI0YvjFUKwoVuYjLqKCSZVORynKtI3Mivg3hM
         avcbNPWt19uQwxhixBns8aTxuyzcuraoKJKINr7iejFF9OG9c3qaoOW2O2ezSKFz8mab
         BuPAAhuJ8G0yerDb7KWl263zCyGSK+elKM7j00zxIu1nOAz0kVzsO9guAHVO18RLHGA6
         3uMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758047401; x=1758652201;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUXb+lKCIzcI280/t4rrhVkdvMspmBSIeu9u4mcudHY=;
        b=QvPU7T0IDdvs/qFby/DKLnXIOtjFU2uUvntjDWvYpMZ2n915BNL/UPvb0/nKOc4Jnx
         BPWRrK7dUComzip/JLWTSqmDjwu8/wqecfP+rxAyCUBZBwFYhVr1Uak/mULglZ29eErX
         znlt6KLfDBFYUdP4/prwYY/6LaxBP/P2KhQbzEEotZFTNo1dZtsSf52vs9ZKL3PaYU7c
         LceRQuERb6R9tBBZLajITqYlL8nwiz+M5CMRLIuG4bjw8g+iZInWtsPU10HsB8SQwZgn
         uYrckrt4WTgwiK47dXvN85NiDXn86VQHRIMJN8ze1wvxc1Nqcq29EbBByuLSn8mFv+39
         tsDQ==
X-Gm-Message-State: AOJu0YzYHWVEa5/4Gh+jvV5R0SZ+z/yGMHs6SzsrDs9bcjMmE2NXHIKx
	wQp+TH0zVKVfJkloEvMpxbZzA+qaCT5bJYu+c2RqvENlXWNSDtgG/s/Cj/PWgDtHCZmEvPwFAcA
	rCXoI
X-Gm-Gg: ASbGncuVOpB03CnXANVEupXMYoqerdD6SE/1L8zA0XhBbnzrcWYWr/+r1IUHhLBIZ4m
	J4ICyelsrJhw7TU3hTlcCK6l/yi99zTw240If6Jgdk5ap7ZYyI3JS1WgXq9rq/0rRGF9qhldtKs
	72hDjCcz33aa3MfnK6Bc573UVOMtSLri0q+DTxn4HqzkZj/stOMkwXJSa/fpmYag3Lx0+RD4U2v
	+N77bGzthWTVLxfVBnNDE0GQj7SM8vwMIDJnjqYV1LMmyHi/wKbGyrmF45LGniOMLfhAMprrHFo
	iYBwxtmXyqX90d5rjUrDnHZcPX4cCr3ZSOtw8RWu5EwT9rqKatNyPHs4zAvOeNVZ3khdRTuHeh5
	0X8w3PtTqTb9RMQ==
X-Google-Smtp-Source: AGHT+IGokPJIUn8y6nQjBroGeyCjDdxaBtE4+3lQe2mt/eg6X2Gs9EenpBBE1tVDPX1AA3PmZxg4OQ==
X-Received: by 2002:a05:6e02:1a66:b0:424:a3e:d79 with SMTP id e9e14a558f8ab-4240a3e112fmr52032335ab.21.1758047401030;
        Tue, 16 Sep 2025 11:30:01 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-511f2f6a546sm5989950173.34.2025.09.16.11.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 11:30:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, nilay@linux.ibm.com
In-Reply-To: <20250915103500.3335748-1-john.g.garry@oracle.com>
References: <20250915103500.3335748-1-john.g.garry@oracle.com>
Subject: Re: [PATCH 0/3] block stacked devices atomic writes fixes and
 improvement
Message-Id: <175804740032.342528.7450652324776697123.b4-ty@kernel.dk>
Date: Tue, 16 Sep 2025 12:30:00 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 15 Sep 2025 10:34:57 +0000, John Garry wrote:
> This series contains a couple of fixes and a small improvement for
> supporting atomic writes on stacked devices.
> 
> To catch any other issues, I have sent a separate series to improve
> blktests testing for the same in https://lore.kernel.org/linux-block/20250912095729.2281934-1-john.g.garry@oracle.com/
> 
> Based on 7935b843ce218 (block/for-6.18/block) md/md-llbitmap: Use DIV_ROUND_UP_SECTOR_T
> 
> [...]

Applied, thanks!

[1/3] block: update validation of atomic writes boundary for stacked devices
      commit: bfd4037296bd7e1f95394a2e3daf8e3c1796c3b3
[2/3] block: fix stacking of atomic writes when atomics are not supported
      commit: f2d8c5a2f79c28569edf4948b611052253b5e99a
[3/3] block: relax atomic write boundary vs chunk size check
      commit: da7b97ba0d219a14a83e9cc93f98b53939f12944

Best regards,
-- 
Jens Axboe



