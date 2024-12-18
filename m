Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15801C5CDA
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734531946; cv=none; b=VVjMxG9BTNFStNDVBst5+DkVacGYlYsaNrjIQLGKEH8wYRWgInhZaQAb2DxSbPGcqVwWREs1dVtiszVa3RPnktaw51wn5RP/YUha/hbZbyj0TSKbFJyekNqopppAR8Rc8IWWAdNUlFwm7YFRdMlFLQhsPtbSgPFNnZ9g+3/atWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734531946; c=relaxed/simple;
	bh=20cVL8ao5dhc277+8lMFZroAMr5Q79AcJEY8Ch/4YxE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lgQFzymIRM9AEoTFwOHD0DrWC0YV8sm/U9EQlTP2dnFPkGE75gOQPh4r0a3zcLZbl2IfR9Dgl2UL/GMn060NlA5vObIlXrD7K+ko0ikkkDJOLBzgVFdStLIKbSeEWdwcwG2pL4o04LAgmQNRbJTBdFJvKtDOpX1aKtDgqfYuveA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=m57cOasm; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="m57cOasm"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a77bd62fdeso41788245ab.2
        for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 06:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734531944; x=1735136744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2yzzc+9q+BWLozkhPBgmpA7EeWaxWDlO02LeviMPILI=;
        b=m57cOasm2AGrLiFzjQFDgm6aoaECuRSUDCjgMb6eCsTpaCz8UtyS9tr4miiVgQVwbv
         i9B11hMh72ZSMV4HRd2RcI2t6Fgdm1n/GTs2HqRtODmVidGKr5ju/3hivD4SZXxsv+q1
         ya4yvN8Xvcs76N8d0HbxpgwK5Npo3uL0sJmdyYj3Rm3Y+J0dzzFe8/H6TN7iNyti5p2a
         Rb/NUKetmUSfbH3KJ5RMy55cZGnS2caVjXhMqLTOJAPYO+XORz5i+VIjCukgzPoP4S50
         51pE417nu/0l524HCLgN/kPB+3It2Pm4aoVSonVOVfeO/weq/2otV639A4ufdXwV0j/+
         GL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734531944; x=1735136744;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yzzc+9q+BWLozkhPBgmpA7EeWaxWDlO02LeviMPILI=;
        b=qWMBGJd02YCTTxUck0bLnUNteNDaAWiri/DgeJB1+G8s34i98WLp6goOuZnzYy0MDN
         op5TekDB8thrZhYyi1nULZ3Rxtm0BueVWJLR98Vdpb6WTr6ZV9o/thRFaRUoy2dc3AxZ
         kAJcU0PdBkXG+WVgzVYh3G/6htNjXZeuumkpVUD/aBmC/PpXVIGp4VG32j/ByTSRdW2n
         YMd/KlOslNYoElOcNz7mdRQ1nndPKIvdRfYJ3Vfu7tTjRokspUTRNvSC2j8m+bLzsRsQ
         Tn1bwx/07ZkfmQf7hQTf/Pu0RU83OzXRk7kHsvk5DWI08nq1Pbyf8P690gXG+t/WsWwT
         YsFg==
X-Gm-Message-State: AOJu0Yz/CRnNpDS5cc/oI3wHJcc+yNfNGsVURRL2Jweq5R3RAl65aJwC
	q9Awv1aSuUv6j3NEcUT/XeBuj2DjzCsafuHsL2C0V7xtsKPRRXNuqEP0BQ/KgL6MTtWCvWTlKT6
	N
X-Gm-Gg: ASbGnctLxJ4YGZJXIKIvc2UzIT/do6ZKl+868Q3sEpxc5IZ1sH+SiOONPFv4S294aQu
	dLQaHwqvrlt4xigUluIMiJpUkjD6UVxEewmq10FX5gDjrVbtyGEGzZXE4f2Bs83w8tV+7ogOEpU
	UWuj2DhGNS1xPrkv9llXxjwB8324fShrPhXH3uZ8vsn0RTZy3Ak45L/LfJFtWvnV3R/2flkDi3C
	8gKfI+L2ULdOUAbcvKnGj5jHM6ywUSJEV6Fj420rDM1m1I=
X-Google-Smtp-Source: AGHT+IFeV6xH8tFn5z7O3LzM6AWwj5xyRCtdMYhC3IWtK0n0iWNzOvnmr8okPAXOYLp8fV1Efonhfg==
X-Received: by 2002:a05:6e02:1d94:b0:3a7:9860:d7e5 with SMTP id e9e14a558f8ab-3bdc4f185e6mr32334665ab.23.1734531943846;
        Wed, 18 Dec 2024 06:25:43 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e03686afsm2243471173.18.2024.12.18.06.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 06:25:43 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20241218101617.3275704-1-ming.lei@redhat.com>
References: <20241218101617.3275704-1-ming.lei@redhat.com>
Subject: Re: [PATCH 0/2] block: fix two regressions in v6.13 dev cycle
Message-Id: <173453194293.594750.14881529263349622542.b4-ty@kernel.dk>
Date: Wed, 18 Dec 2024 07:25:42 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Wed, 18 Dec 2024 18:16:13 +0800, Ming Lei wrote:
> Fixes two regressions introduced recently.
> 
> Thanks,
> 
> Ming Lei (2):
>   block: Revert "block: Fix potential deadlock while freezing queue and
>     acquiring sysfs_lock"
>   block: avoid to reuse `hctx` not removed from cpuhp callback list
> 
> [...]

Applied, thanks!

[1/2] block: Revert "block: Fix potential deadlock while freezing queue and acquiring sysfs_lock"
      commit: 224749be6c23efe7fb8a030854f4fc5d1dd813b3
[2/2] block: avoid to reuse `hctx` not removed from cpuhp callback list
      commit: 85672ca9ceeaa1dcf2777a7048af5f4aee3fd02b

Best regards,
-- 
Jens Axboe



