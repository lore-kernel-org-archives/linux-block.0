Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B61212550
	for <linux-block@vger.kernel.org>; Wed, 11 Feb 2026 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770831433; cv=none; b=u98q8olph218fsYQQwzYqFAQwQOR+JXplSELU/WozQ/u9hNz2LgpchEfNGWtcJ3u5+s78ooxrANnT9s7y6QVIikHPA2k9D3yHVCAPzdI1gkb281WXWy7Yc4cMa8Ng8YzboE9zix3vns5HKQEI4J5isDAGkqkbK2YLXmjCO59KE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770831433; c=relaxed/simple;
	bh=1/Bfcln1dkJjA6Nwk/wG9TfP7RmqVvl5xahSi6ngElQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ecEB8/dM+DQz5/OR156MJhAeEQ2y+zT+gujlI3RaW+HSo+4nl1c5Gsx+ELFXuYgsam4UC5a4GwwvWE/kfiEnvW3R9rFbQVEp0pGjtkIEOHNXO3jl5Y1V/38aVYeD7UmuDxsXEDObs8M+HlrCqMrJ1M31QYzAx6RKCwnl6ygos44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NNcp2P8H; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NNcp2P8H"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d18dd2adf7so4205483a34.1
        for <linux-block@vger.kernel.org>; Wed, 11 Feb 2026 09:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770831430; x=1771436230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZDgEsuTd+EIZcbbHpNiJG/0ozze0cH8jbfWhQ45z3w=;
        b=NNcp2P8HOK69p//Flv9UHWqXsBvH4i6i+dLzVN+qzmQxw/ew50j7jJG+GRjqsP3i6x
         IJ2jJhRkV8UkiUEJu8cwwXNjZBY/LcJBI5eruEDkMitpZVU3iXHWVeCOLLlJ5EGPLTwW
         N1KrWt3uxu5tPlRfvbtROObHguthIxxGZaAsv0IslM5tz4STWVP6uT1DrgKgm+ovWfjd
         ZyWJfKqFZhfvPkb8KX7BhDMBZ5IPpjILLYQG7XdtCx6D19/RMNoZXanZtQDeO9PWiTw2
         q6lRX9CWK0aBzLG1t2+IkP3jigwKr75aEsUJLlHXCnVRWfFIZeLPXwxxjIMTtZnwsVeb
         ImrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770831430; x=1771436230;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ZDgEsuTd+EIZcbbHpNiJG/0ozze0cH8jbfWhQ45z3w=;
        b=prKoTcCkJpzIEuxEDPEwvVZmPC3sfm3h5s3Ox8TY5IURHW9G02OB0OxR2llOxOLWFp
         9kM5XSGE9jIaDisKE8aBqlpv7a0CtdjB1d83kePmadbtMRB+syAP9SpAA6ssI3DgzxoN
         zFqIFB/JTELh7Ly0Gt8rSw+NCcOzGZjhbLFCRjAv26TRtNylS9TzPt8d9Y+KWRTGmuzK
         SK2AmkgjV+Cj3zkvloui7/++Bh1oDE/ZbEb5cCdt/B03aZamYN7uHgKu1bMToGlaZJ8U
         /yjbOO1ihSjHeof26QmIltzqamIomeTJEnkGchC83Hz/BUvPfdNqcE0fIgE9ur8pBRmT
         xO8g==
X-Forwarded-Encrypted: i=1; AJvYcCXuj9atb+XZ4xV4af2qbIgdVbfHlDEFT06wj6/pW1KZtsvi2lcqHFfd7DAB459MaPwQP03Ed7eag4w0Lg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc8CffqkQWWEOe1A9++8swA4ps2UPK+hP3MpFMXD1nOYqyTIJp
	bZEURQTT9iD9KoqEW1BScBPZ6R+JLcyfO6QbBCPT5q0JRGNzuIML3KceUBZ0JM0BUHDrgFE2xrD
	KuqPko+0=
X-Gm-Gg: AZuq6aLlxAAG4X6EkqT4wXseUaRR+Ado0DALbXXtgw38eRNJiDTjAbGK6DV6ri0zJY7
	WEJimevvgtyfQWj+beJFgWNKJZ3BBSOquZReH7QhO3n3cbZOGfQXgPodeOK4dvq156ObP8S0/nF
	YRqLW8IdcPfV/MZwkeVLdJ0xiDQwBkWXv0C93RqJOSPOAPiGsyRH3B+YtVWnfxLS5KWL78vwJZr
	zfmFBoZvB7sA4QQg2RWTrIozmH+XvnqWCQwiMs/+/I99BPXS4mRiAeWhyHVCuyCPF5vkcq7CzHQ
	nkZvjl7/hB3TZ5Ds6TYbS2r+dstirP+5bn3GKWrXNnuNiT83zTpLEBn1X/SNPcGFCR7lj/bE8MT
	1Y1qCLh45B9ukJdJI7N8oYk+GprYqr6TZTJkS752TfR1RHUl2NJID2URJRhkBFe0KVFyrKlchqB
	fGCTNQDjKCv9rCecG8CNUyG26uMvopENXvlQzH753lAPHRzJO2UQDSkwqrZHy1Hb6X9dnG1Sm4t
	A4=
X-Received: by 2002:a9d:7f14:0:b0:7d1:923d:683b with SMTP id 46e09a7af769-7d4a75a1558mr1071620a34.1.1770831429961;
        Wed, 11 Feb 2026 09:37:09 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a76dffedsm1730048a34.16.2026.02.11.09.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 09:37:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>, Martin Wilck <mwilck@suse.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>, Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260210163617.144359-1-stefanha@redhat.com>
References: <20260210163617.144359-1-stefanha@redhat.com>
Subject: Re: [PATCH] block: allow IOC_PR_READ_* ioctls with BLK_OPEN_READ
Message-Id: <177083142865.157742.4766975435017061790.b4-ty@kernel.dk>
Date: Wed, 11 Feb 2026 10:37:08 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 10 Feb 2026 11:36:17 -0500, Stefan Hajnoczi wrote:
> The recently added IOC_PR_READ_* ioctls require the same BLK_OPEN_WRITE
> permission as the older persistent reservation ioctls. This has the
> drawback that udev triggers when the file descriptor is closed,
> resulting in unnecessary activity like scanning partitions even though
> these read-only ioctls do not modify the device.
> 
> Change IOC_PR_READ_KEYS and IOC_PR_READ_RESERVATION to require
> BLK_OPEN_READ. This prevents unnecessary activity every time `blkpr
> --read-keys` or `blkpr --read-reservation` is invoked by shell scripts,
> for example.
> 
> [...]

Applied, thanks!

[1/1] block: allow IOC_PR_READ_* ioctls with BLK_OPEN_READ
      commit: 5b88af7113feba2f0ae3402bb57cb5c94eea7dc3

Best regards,
-- 
Jens Axboe



