Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792507206;
	b=JSPrY34XjQc5j4at1BQazsZx1/m3YmL57xpieCZJu7iIP346oPA403W6ikDGbyr2LJ90
	 Ou26kIwTbX8y89Dc8nl7UGAefqF6ATHJR/ZGs72W7ugSXYH1GjitYdc9aj/oLBsy+EO/A
	 biuw6GE5UTLmGWBM4Xc6DHU0F8d0Ch5Sl65vGth7PTtVLiB1eoPVFWrkioQg90DKu5sx5
	 578S6WDb016nmfbYUju7wXdMDuGXnuPvGZo5PGJVq0dFWlJXRfIukXczpWAJb3z6xt5Aq
	 eC4Tc3DVAXWcWdqy8kwSNE2b1d8wVDU+1Pqdx9zVrlw43V32NEb4PBWAlYVd9nGyYmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792507206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=Q6fIiazwiX9M70R0T78E4hxTPNI+gCf6aNUzhJ/QqFs=;
	b=3bHGkj2NAARy7GbrNY++JiKN3Aclq1YdJ6HxJE0TinPUeFt9sHxXCnbihCetHk0qQFtY
	 kZAxudG4ZHUGjUSiKgzCuwdxGE8namIKYGI5R6WqW76KjxlIxObMNXyYs0Q6JrPU6B3SE
	 HTQ6TFZVkBS3/0HfhLU1R4j8R8aae5tqEZu6X2Pd/UjtHYIUS2VHMxOIQ0ZxJVxl8nGoU
	 6EkGy6iOUACGPQ5t03esBelfADAT75DjFcyGMTdvWiBAWcujiaB0XOlU3TT0mKdcSFCdQ
	 mABK8IovmUhMX51lxrO919un8YleeKdpprf6oETRWWhcHcLFve384ZznqeGI0nx06CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=OoDKP4rJ;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A3D606A31D
	for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 14:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0A3D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=OoDKP4rJ
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-16079d54c17so510894c88.0
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 07:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792507205; x=1793112005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q6fIiazwiX9M70R0T78E4hxTPNI+gCf6aNUzhJ/QqFs=;
        b=OoDKP4rJj8//Fkrqz3cIB4KZYMsqYLQDhx9M/EfrEsQmxL0M1ULhxcqTmAW6jk5gGS
         BfmcnnCDrF9qTdJE2j09nk3nxfnoC5HqTYTRu0khvXapBqv0xH7b7Og6QzI1BKlz6v/z
         dU96054x5lDvajZttrF2ZOnH8DJ6qZnvXN3Dz8ZPyuFXCazwgf+NHTtXcwrxy8mn3src
         3wLPHbCEmoq7p6V6oni+5J8KsHEL+bRp27NoiaP/wjjtlzQH5uOOMVaea0AMcALxSlyJ
         V7ZUp62T4yVKuSWfVTXYyzW/luqlIyWaMSNBYqO1QDtrdjs9qwtvHYfJEwBVY+emPaFW
         k5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792507205; x=1793112005;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q6fIiazwiX9M70R0T78E4hxTPNI+gCf6aNUzhJ/QqFs=;
        b=PevU3rsLxCrwtnSb37+wQgBo9+ZkPSZskvx59za0kdlRQiklSClPeASso7Eq3G1V/0
         yDpJQKRFOx52C+HCchtB0mMHs/gqgPubGhCvrJlQuOuchFk8TuD2gFlOwkX9Od39gLro
         06qQk+r5AkuEgRMXBrSzc41EGXDYAcx5cIlCmwFLGJhcJ7xWsa0xGYMswjzfK/ClKKiz
         uniU32q92PsUtbdZHyyCQc7sQRLP5mnLyWqRIoVHw43Ynr5DKDGh/LOeZ/h/ryGktYf5
         aMcW9TBfI0Klf99txIw1sjw32NSKGWXEQ0HnGOX0r5VvXB4J85kDqqAdkSsq5OqKQxal
         yBoA==
X-Forwarded-Encrypted: i=1; AKwUvBwPJ7xDZ5QczpJyS2j5uPQgGHhpQ85oq6qEOC32mBPY4rsowvxYOyGxbL7nZqXABqMIuoMh6++J9BnpDw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKYtUzwmZ4HokSiFbooqKqckSywYEXcaTDhf7LR2S1LUCMpvjvV
	ytlDRq+1KnvQBhivKErbjH9gbQjfhTqEoQ79n/finbU8Fu3HoFT0ZH8HJ+TSIVfkf3rGw2x0zY0
	/eSh8K0g=
X-Gm-Gg: AYBFou1Xt6HkkQDzfufGXoZ3OdNqL7wngRLZwGvr5st6tGb0ZqmHY/Imq3MhhRwns2r
	t6pUeGDVtCFB+L+HX/ecC/Jp0eePWmlz40GyIT8wrnfB8kIk6gh0f8W383TVIbAN9UcDjNYrm4y
	rJoxT6wUvGxVf6UZuKdJpQec7UEF/6Td4E6BJejSURLFVBGLi0Nq99+WyJt9GANNRGcpaIvOX2O
	dBQdwRl4Ey9LUNzY+Pg4oxhdwOkyDsguiJHvddi4xlovLhTtaIgeIO0xFrQoX0ToFEP4wB018K8
	f5ggzuqkMHSXcJu4efW8JODxBqx5KQ1Ou3RnzFni+yltN4SJQqFGFiJVN7R8YqQTBuzcyYap7Ep
	nx6U3bQ09B/15rKRKpqP4ik0ALrnO0JuHZ4g406QHKNSyj1mGpueLFPQxiznkpVxQs/0vru0jGa
	3N2wccAkEoMn5EfvxthIWZVssTZvRnTXAHs0j0l+EgielkjWkFsIS7VfxKuJ9Ypr9y60r43PDCd
	wAe7aBhR1LPy1SdhQpxEUxa8+LKI1sxw8ujDgh0deDRmz9Bc/GYgDROoSI3305ihqdGcUnG1YL9
	tEy6QUedIbsqHF36sDbnwXlX631AciPX3OyajnUrCB/FhX8v6KTfzGGPO9daluZFkP/bdciKDE+
	K4gk=
X-Received: by 2002:a05:701b:2608:b0:183:4719:5c01 with SMTP id a92af1059eb24-18513e7c69fmr13146306c88.35.1792507204827;
        Tue, 20 Oct 2026 07:40:04 -0700 (PDT)
Received: from xps16.local ([155.98.132.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608308a87csm68494455eec.28.2026.10.20.07.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:40:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Nirmoy Das <nirmoyd@nvidia.com>
Cc: ming.lei@redhat.com, hare@suse.de, dwagner@suse.de, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261020125129.430600-1-nirmoyd@nvidia.com>
References: <20261020125129.430600-1-nirmoyd@nvidia.com>
Subject: Re: [PATCH] blk-mq: clear stale inactive flag on hctx reuse
Message-Id: <179250720323.3338252.2582321707097985664.b4-ty@b4>
Date: Tue, 20 Oct 2026 08:40:03 -0600
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 20 Oct 2026 05:51:29 -0700, Nirmoy Das wrote:
> When the last CPU mapped to an hctx goes offline,
> blk_mq_hctx_notify_offline() sets BLK_MQ_S_INACTIVE. Updating the
> number of hardware queues exits every hctx and parks it on
> q->unused_hctx_list. A later update can reuse a parked hctx through
> blk_mq_alloc_and_init_hctx(), at any queue index, and nothing clears
> the flag.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: clear stale inactive flag on hctx reuse
      commit: afc1de47a7ab607ae6403c4bfda36b0bf3cd342f

Best regards,
-- 
Jens Axboe



