Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D0E282F34
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680450; cv=none; b=DyBz4QFrA+1Ykcm+lCYPHyBTEcTiMKtRXBp3ES/eukYDK7Ux54hDjLMunjw8bDWp07d03JxloGqarID0VH0RdfdWkcuhq0ytSeRdrmO5MvT8eHHoF9jNhIKK794os2l3LsOQZicPqs8fvSzpu1ihWDWpIz2SkiGCXdPCGO0l9Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680450; c=relaxed/simple;
	bh=VblI1AdyJkR5aKIEzu1iv+NjnkZBsAcb1LuT0EYm6A0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CDngNWF4rx6YP/HNUVB0ewwRSAiHOp5iLjXDuJjgHnat02Qhee2M31hWUGk3rSIvsmENsPXuvcOXxNeeA1LLMidMFDAAzbfkmopkRjuZWm6xgjWAor3riaVxQnNX3YkF5DFlqo1E7qZ0SumozuELT8qjHFkZYSRe1Xa6crsEmB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=vw+k8kGT; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="vw+k8kGT"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-47c941f6bdcso4325055b6e.3
        for <linux-block@vger.kernel.org>; Wed, 13 May 2026 06:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778680447; x=1779285247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2FCDgUz+zxvMvODNC6gcP65BHRtM5wnyKHr7DJ3v+E=;
        b=vw+k8kGTVhlP7c+T5AYk1yPXGEbVMcWc8DUz25B0OdYNHmmdhXmwSNmr+Ui9VqkY1G
         j1wHl0NhFc6KTh0rqOQVV/CFA4YKn0srQP4qcizkTLSBvChh8JYF887aqsl6nTtg1YuN
         2qkwYhmWeEtooKV+v7+WLe+G58VlR+z4VliG7dn/ClOY2OupzzmxjBwACmv2sVshcYWw
         cLYAvzAD1LFkwwnh6H4Hq+DrS+JW6XHxS9tVOjTyheN+O1oowWOz6HLs8Buz21rRKlEL
         aCI9MVQ7PLxpcWQza8Havm2i/DsW0tWOn0BcMyydc8+Tdg7SI95YyOl4dn/c2lzHwHxR
         pNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778680447; x=1779285247;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E2FCDgUz+zxvMvODNC6gcP65BHRtM5wnyKHr7DJ3v+E=;
        b=FHyMkRBT/pxuFmHJf8bpODrQKPQ0j34gKQwkmowBCIwaol5gvwkLvTS0NiGWUKWnxm
         0uXaE28pe1KO3FB5wLZ+FE8AxLlEdsitcegskq0xyLvQwsRom2NPvFKVEN71UZhRBKZi
         05zXofnYKqFRCPlUECU9I8AM3fyG3e92rWUp+rUGKtUnUSVTUuvERWGqG9Mv3f9puxHl
         t5ICd1jQYTA7e+EDidycYa58Iac32p/wJct2GIilFZdbcqVnnz8ESnwFXAaz09x0Tn4/
         8Ox3OsUNRofFxamWQfYlkR+afnphVvMzhUr81B73dee7c0ss0zBYbp4WeOwgHVw5MspC
         wKfg==
X-Forwarded-Encrypted: i=1; AFNElJ9QTTErCu222r1eHpMNGSmcMc9pTgrLZX6xl5SY4B2FFHJ6RdBaU0V+WEqY6KVEBz1u4QX/aFc6YWwIvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZP8dRpXF106vZs7N4n+frUUWNeOegaWc+dJAh0dAZaNB5R9TA
	pZCMCpovSrwbrs6KVGir9OQMI9LMXsIpD9wMixrbu/IZHq7jQL8Ucs6ri3XdGzXXBM18HGGjEL6
	LFivn
X-Gm-Gg: Acq92OFMnyBJ++xFM1BjpKv5uK768QnPmY+5hZ59hcM8nT1vhQQSBH5Sqt8NZySBUxs
	zlpE1bbRcEeylCopla4xuiiJFZNIMN7p6OOyVChAQjtHa07QJaRkDykID1BONUnDt4Umzv8QJWO
	/XMv/8pHoh0tJTh5xwicVQ0o4cE04LPCYdTu/tcMBzGmXN/buAGTgIsUcuVZC41GiSgpMzQnNzU
	1RuHWH41lNrNBws0QZyIbowSa7b+qbpp7uC4EZDYG2DEmrageaX3gN9+fvX2ta5vcGVhnZ9geuO
	ceJFORnXlwRTHHV/QvCp/Nicn+sU5nj0GqUlQ38Xryz6OPJ7j5efZdcuXsFm7NiZTMxaeVZXpMw
	O0w/X8IkRDZVRINBOdDispbADHZewVz+HuGXKfNb5p+szz2MnfwMVRHqTeL8ubCbL4q/Mku4iyq
	va6cBlKxn3h1ORXB1UdzetGAZK/6qSJ2QSAi8hJetbtPILO36Ld1drivUQtMXs8lzZ8v1bzFHFc
	TIV
X-Received: by 2002:a05:6808:e652:b0:467:e7b:6fd5 with SMTP id 5614622812f47-482b623a6aemr1425000b6e.41.1778680447575;
        Wed, 13 May 2026 06:54:07 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76985f8fsm24532821b6e.14.2026.05.13.06.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 06:54:07 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: drbd-dev@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20260513110343.3170338-1-christoph.boehmwalder@linbit.com>
References: <20260513110343.3170338-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: clean up UAPI headers
Message-Id: <177868044624.398953.18340642491837775041.b4-ty@b4>
Date: Wed, 13 May 2026 07:54:06 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Wed, 13 May 2026 13:03:42 +0200, Christoph Böhmwalder wrote:
> Commit b1798910fc7f ("drbd: move UAPI headers to include/uapi/linux/")
> broke compilation on targets without a hosted libc:
> 
>   ./usr/include/linux/drbd.h:18:10: fatal error: sys/types.h: No such
>   file or directory
> 
> The underlying issue is that there were some constructs left over in
> those headers that don't belong in uapi.
> 
> [...]

Applied, thanks!

[1/1] drbd: clean up UAPI headers
      commit: d5607f1fafd7eb72ed693b6a033d96221e870edd

Best regards,
-- 
Jens Axboe



