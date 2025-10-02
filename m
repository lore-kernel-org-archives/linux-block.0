Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01C11DE3AD
	for <linux-block@vger.kernel.org>; Thu,  2 Oct 2025 21:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759440610; cv=none; b=hL5is17zQbsUGivYvj+HWkEl/tmuByObQPGYWftvw6ko6Erc8WCSt6mmIAyA4GYgWU5nmO/xucS4IaFYozudWgT6H31Jrdibt+TG0bxsBbQEMuroWBr3nmJ/YnnSA1EH9h6QEMjqEqJJSGtyizYpfx7U2vmF9O6X7oWlrvMNzU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759440610; c=relaxed/simple;
	bh=3cXiHd2YBbbDhzLcMAyDC46g4zuUrDFj69nkTlySJ7M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kmC1s/mCUAJ+B2P89DNs2OvDO3pglaFI6jii1iOaevLRjp+1NeKFvMmri50E5xf4iJcNOo/CvfzzlMauvxezxSguLWeQeynalKC6J9KE/1M+RJ536hzhKkRyJcYHIwR3VS2uE6DYVxYcbTZxrmetzhObt4/KRX+HNaKKQOvFYu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MbsRzaJc; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MbsRzaJc"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-938de0df471so122664539f.2
        for <linux-block@vger.kernel.org>; Thu, 02 Oct 2025 14:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759440606; x=1760045406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dT84NsQ5L7cCw3pr4Gco4EgRoaU06NgeVgWoDKDnXE=;
        b=MbsRzaJcZiCcgdFx8OMvnwmTABmZV3lxyFI+R680rnerY66hGBry94F7dxEajbw+DX
         vkGuIgaG6z5W7Ux3rHpanx1HFqig/rOrS3GzJEU+rI6hIpt4y+rT6pCDYPamFNeffcac
         QKweq7vyVsoeDehvqccXv8xDGZalj1EYY08aUeSkIGjWO3hJfm/kz/KXxjuYL8wnHO8o
         ZxBzWnfjuG4afpzHeC4aIBDIKNonBJOt2gwgGJtFv/aj0nRtEVQ8SAC6Yk02DBmTHhH9
         IYSBuEGtZ+8gaEjMpCu5KmugDmCizAPCKdrVec3PVRMnZRz2JKHP3XOS9HO2XdyqbhUu
         AVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759440606; x=1760045406;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dT84NsQ5L7cCw3pr4Gco4EgRoaU06NgeVgWoDKDnXE=;
        b=fe2+RdJTXrwaF3xDGJ0ylmdV7lMkkcHUIvyBfKK1Cam3BJn5/OFy53X+xXlA0qk/LN
         xUe/m/zyNj1A9KfkWGT+jT79pI2OBuPbJgItJeIRHZmuH94RmbexE3bmXhMv9pFFAPph
         ic1haT/oTSKEAxJDpWsayDJ7G66DYnXIlXX4FvSkgXep3LGT5Nvk79+jvQxQ8OXC+tgu
         E7vFtYzmFFm/uhOhTrDyugqbIJzCyez8fLRQBuyEicGjdw581EX3txfwTRU1XUcmfeLv
         Uhby3fCc3VhCMLLWoOrabOjx3g74hrhJ2e7o7PnZcgCVbwIWeYZTAqgtjHASBdfq1kX3
         nFaw==
X-Forwarded-Encrypted: i=1; AJvYcCW8AU3pifAYdPPu2Z0fiNbPkESr1vzVVJmGx7TJeZ1ruGfSGNBi3Yr1/o+3EKg1y+gMl3Deyn201J6KhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBOCwAfdzqao8rkwJJc8nYc03Vgw3VvMKonQAfrwDf4ceDK4DZ
	HQC+RRAPXiYGpNxvzC9wVVV0mzmPXI6soGo8X6md281nS/OyPzeDRuQMr5l4DS6qmHk=
X-Gm-Gg: ASbGnctgYaQB0LOyhf3i+jgTi6zYr/fkIoNUyqcluW8QKF3WfMbCKaO09uy/LdVsHLR
	oTVuwLX/KEF0f5u8J/K3nssfc/MqCBq6UEWzfMM4KSrDPLiVrcEb4La6R/YlMEr2z3zSnUfIfsk
	QzElt/ZyZdflPlU6N6Rs8VNqU5w8GDxQ0VQtwOEdzlPhO9vVrV+b978JZJl3ffUYMzbZEuN6Fmt
	4X8kEJ75PN8iGVNWheGdk0fiM3x4DSeO9ZLyE+6XLxmukVc3jS0tkxjZxoqL1BaSmWb55rROME0
	JE+cKmH6LnQGY/jxQP8QEEEw7ig7wCRdWxoOSxWA5emqPe3nyXw0E1IX17BB4HNJvLmd7VZkLZO
	rZGz7LSg5+o2se+Q1zT/fJLIbB7iWBbMVTDzXHjs=
X-Google-Smtp-Source: AGHT+IG+SpEIbL5sC/8GSI6uW3/+xZz3Xd5NWiqbSP19k8VI1Cx5/MkHbZloWeiPJ7UWNIbczxvmvA==
X-Received: by 2002:a05:6602:1582:b0:893:65c1:a018 with SMTP id ca18e2360f4ac-93b96930cf1mr108216839f.3.1759440605682;
        Thu, 02 Oct 2025 14:30:05 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93a7d81bf16sm119168039f.4.2025.10.02.14.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 14:30:05 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, hch@lst.de, Tang Yizhou <yizhou.tang@shopee.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20250923112136.114359-1-yizhou.tang@shopee.com>
References: <20250923112136.114359-1-yizhou.tang@shopee.com>
Subject: Re: [PATCH] block: Update a comment of disk statistics
Message-Id: <175944060434.1563810.14517631402501395981.b4-ty@kernel.dk>
Date: Thu, 02 Oct 2025 15:30:04 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 23 Sep 2025 19:21:36 +0800, Tang Yizhou wrote:
> >From commit 074a7aca7afa ("block: move stats from disk to part0"),
> we know that:
> 
> * {disk|all}_stat_*() are gone.
> 
> * disk_stat_lock/unlock() are renamed to part_stat_lock/unlock().
> 
> [...]

Applied, thanks!

[1/1] block: Update a comment of disk statistics
      commit: 510d76646a6a7beaa49fc0da7282e285a3dfce97

Best regards,
-- 
Jens Axboe



