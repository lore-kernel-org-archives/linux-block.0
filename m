Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D6041322C
	for <linux-block@vger.kernel.org>; Tue, 20 Jan 2026 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768929896; cv=none; b=aagyDJjZ1sR4q7keMuUOogjej4K/7Dw0yTv5epYDwYO41HfjLhHJORJcuvlVlYVV7SGLRBt1vJc9BAKVOviKmfWkTtPFwdojSSuTzQ6JhPj7yY6vnHh+SIHnqiYrIebWSGxNFiYktcaA6kz4GYiK3P5ObAwLJIpw+6kXmnUrbKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768929896; c=relaxed/simple;
	bh=CujrEw+cKm2GKzRdfUbANKRittHXfLKMnJNavHCF4g0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n7DDUT17ZtuBdm6/2X8YyFk8rcnQyuNzZPXU+6yYY2fKmQoc/KTgFBQkqjhLiJVSWRGZkrDjS0fqm6ZDQgvgmjRrOP2HHKpUe7K2GAZxKg+Tz4c+AEUFZKUZHPa/pwYgVmFHH730Tis92i4tsOnmyKIABVw1YHyQfex88ETOjKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nr09jmJB; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nr09jmJB"
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7cfd04f1be8so2099194a34.2
        for <linux-block@vger.kernel.org>; Tue, 20 Jan 2026 09:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768929894; x=1769534694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sa8+4KO1m/ufVgLZFpuPOgrMf4fnNhj8yXe10/VofOY=;
        b=nr09jmJBWfgxEC6vLKKvxIjyC4/HGPlMDfjimJO3foJMauqNpDNzMUaMKLYRR3YSsD
         EGIy9OrXBSNiOxJXIoXqNhZ6UqPdpxmakPAIrJB1VF7Su+RkWaLjsirpfa5PsYLv1eFB
         sJ+0qTcKWnJYrbCe4WN3s5BKXke55IGrHJprjCEQIIU52VbCnvnMqardffvSFAA+vf4m
         X788vT+TuV2N/g17b1jz5jfU0IiEVcfGWklJg6EgofU4kwDnf78gaWNAkS/CpMA0s2fG
         n+EQne9L9k9yYyZVJW3U+oZjnSd38no6x8HdSMQCud2SIQGBRFmzGrSwPZXZpnhhLBQq
         LUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768929894; x=1769534694;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sa8+4KO1m/ufVgLZFpuPOgrMf4fnNhj8yXe10/VofOY=;
        b=C4jED7UIakhlDgnuTyr8LSM/vCv5QCT2Dh9yq8KdYPxVG1Y0DlLq48rePNQKfEu1/g
         xLZudPoXNdlaGC3R52btbO8BBJWa8VgXFwtOh1YZYkjaWjH7pMw6SCtKlW9yZNm8h3/z
         VdoQQ5jbdA9d1Xjnf3ptrf2rfq7M8h+FyUlWsNQiBJfNk2PnVfmDynYW36KH8qFNmmjB
         CsOSq+FdBSHeEXD5FWo7OjR5uO8HZRK3bKHYASPCvy4CU7RhZ6OJHHgQIsfYbtdorKsi
         S7BQ9+8s7zOMsaVnlaSm1RgISvFhxY9H04x1Ehd1yV6a2BcdO34uVY6jZRkkuCgOhBrU
         Hc8w==
X-Gm-Message-State: AOJu0Yx8LfVNJWnRPQzAfnw12S/0TxEFjwIYJ/0NHITTYVE6tY3riMp9
	DV3q0PXEuQLwkql1ev+5PiVzImE7LPPdvvqGOjMjWyctsYLyY47Xnk2VPA1sRgN2rC4=
X-Gm-Gg: AY/fxX7EDSyJoC07JBmGzkksCr4SvrqNU3XTs4E2dp6ApabHJO7D6JnJyCcpx5Wz7I1
	gQithDJP3QkqaL5s0BPekftOV3VCXzURdik3ZeQkmcgdHlXW1P1c0mmsixcBgCKbLvwDWgLWM/I
	iiBp7xG8jrM6ouYB/bEM1uHKcCgiDGY4tDO9Yl0ryIn5OJKXxfMU2l2Ep50pberGyoXP0xW783o
	hcsI57yJJ2hBs2sAlnR3wjwYrfQNBq5zZMNzFq6LBj1bONb8kUGiXJoqPsdnHWA7vWbUlxs0UI4
	cWoRJ2rZOm/s8BR79dmnDl8oPzzV7RF+abfZ+6HcIkiK/k1Z95dQgR1Tag9ljZLJfXBabQ57p7S
	XvVpVSVWaISnQKzYtCy8/1UbzT0BbAJczklfjBT7G9iquSJX1wG1jgz9rlBrUixh43m62aqgLo+
	RXSpbnHFXLI4xdrNiheKTyGsOmbRoV1+RS3Ha7c9Hho6SgIW0rqz9psnKPDN5TPE0=
X-Received: by 2002:a05:6830:7006:b0:7cf:d822:37fb with SMTP id 46e09a7af769-7cfe029c704mr8422971a34.34.1768929893712;
        Tue, 20 Jan 2026 09:24:53 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf0e9209sm8932389a34.8.2026.01.20.09.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 09:24:52 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Keith Busch <kbusch@kernel.org>, 
 Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
In-Reply-To: <20260116074641.665422-1-ming.lei@redhat.com>
References: <20260116074641.665422-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2 0/2] nvme: optimize passthrough IOPOLL completion
 for local ring context
Message-Id: <176892989230.1994823.2473484633888931536.b4-ty@kernel.dk>
Date: Tue, 20 Jan 2026 10:24:52 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 16 Jan 2026 15:46:36 +0800, Ming Lei wrote:
> The 1st patch passes `struct io_comp_batch *` to rq_end_io_fn callback.
> 
> The 2nd patch completes IOPOLL uring_cmd inline in case of local ring
> context, and improves IOPS by ~10%.
> 
> 
> V2:
> 	- pass `struct io_comp_batch *` to ->end_io() directly via
> 	  blk_mq_end_request_batch().
> 
> [...]

Applied, thanks!

[1/2] block: pass io_comp_batch to rq_end_io_fn callback
      commit: 5e2fde1a9433efc484a5feec36f748aa3ea58c85
[2/2] nvme/io_uring: optimize IOPOLL completions for local ring context
      commit: f7bc22ca0d55bdcb59e3a4a028fb811d23e53959

Best regards,
-- 
Jens Axboe



