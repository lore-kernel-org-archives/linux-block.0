Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C673596FD
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767798504; cv=none; b=X+ye8Gbim/Ppji+XHHMClOqlAuqj8R6pBLYNY9QPKZ+1S73Qi6l0c2dKZ+GJ8xAH1LJ/f7NkFXHrExg1kmuOJkrFhuXx52xq6XY99OX6O1m/j1z2iIFzFfnhUKdvQnLw92pi5R4PtJ0BuB1zcgXLXyUB2FMF3WLMpIMEdyiXSmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767798504; c=relaxed/simple;
	bh=4xNefY6sx3j3BqnT6DCwuujklMkaozTfft/phYzXo1Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S7VoG49edr0gClmEgOHQdRRHhESwVEobbZzDTiXb2SUAQ6RllD2TJnppZT+QIEpH7+fianaOY1d7WvsgzENJ7rJ+G9iwrcWINT//RKdGhMyZGBZ+T7CHFOIyGf/EabeCS7JGXKbcETjoUTMRk3Ywuxou1/BPlt4xGW071RNaqCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YBYQXsgS; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YBYQXsgS"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3f0ec55ce57so1440005fac.2
        for <linux-block@vger.kernel.org>; Wed, 07 Jan 2026 07:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767798501; x=1768403301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMmEbhZsB6GcTHvr66TSYpqkKNAb2anJeM2Sl4gXS3Q=;
        b=YBYQXsgSYKvyHrunVA54s/Rir2XJjBdl8o9a1BLqRwAb9VJJZW6S5yxaXmucsF2xeh
         lLsFdk/ou6xM9LeX8NmbgDe88xgo99WMoGKtIhh6KcwY1+Id/BZrHpJZ59UX77AL5dsT
         7/HxaKZ/eeCbmTVX+xM9H3fSlvGjppj+xfMyD3h+gSc+/JHySt1GUOS7JJLcvfTwbLUH
         EA6j+qPcSbagaRUHO0O2RVpzwGZB3lEA3of75j0SKcmct3LfEtvr/LAyjbAlY1wtsSm0
         GcP4Eb8wdSso2KMQQbDsgXka0GRKkeJxsRPK0JdrZ3LiKJnDoXunRZMCX6omk7Dntb/j
         J1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767798501; x=1768403301;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XMmEbhZsB6GcTHvr66TSYpqkKNAb2anJeM2Sl4gXS3Q=;
        b=CHVou94kCQbwA481yCAZ60gTO3U4xy/gpBwaRT3orUWLg654oxXC6ClcUAwF/MuJvC
         awmPLPIoD3WeQiPzHdYDFC+ONP/lhjpjQ1xWaHOQb6AuN4/7TVETgW1Hl/xpE/+WW6aW
         YbAXm6pTCQbhrdWcoznHiZXJIRXQBG0n6utSjaVjW7kxt31vqhxZmpVObd2KxPfB3xBw
         0gUWZ/mzqqtH4KBHbhHBPgMaRvbwKt5NNsl7FJZv5ocQnaY8OOpeLz059WBJJznzYXSp
         1A3lj0nVAHl1reqerZIBK+6W6QQPek4yR4w9FRXdt0RjYIla/REtmUYorz6MlSqs5A7y
         ntIg==
X-Gm-Message-State: AOJu0Yw5rN5nS1jmq2XriaeWJZGxY9udJe1cBgmi1noWfd1mxZpPYesf
	GbMCUFwH1tGt0B0PtE5aAXoVu8QEYaeBm5mTpLW+zZAmEURpgz4sUrlEA2l3b3mwezvdNoPI/2U
	Ggkrg
X-Gm-Gg: AY/fxX6kijcic1R/FSX1SFlJbR79quRGUgSSrbtDVh6QkIB3Z+nwOSJLtYmmQvndifa
	UNqjK4BVDP4kiRyf0fpaI3EtLLZN48syHSK0srG5rFEYuLdJ+79NVQI8SMo1UuRvWlRlQL0QzAL
	hupbxAVrD8JXUOBQOU8jOIRyiwtx7e3dueNTdW2qqc8HG7cVOQvpSGUZ2A6aMu4Jcyd/BLzij4D
	tN6iJwiJOxKdePRyDKj6OQ18ir01Jl8uiG81m+1nNzoGYHO/CO3YfjcMbCuwWaQi1rn9ioyoQOU
	YTfR9r98sEHfdggXDGdCIci+0ahlBpGxiN212VedHe17NIQb9WEwGlxBcaUZnuGwOOGmtafP1SF
	0heag4PgZp3mXVlGe6s8Zi+0M6+5GF5eAnxCsnsUCWJbyAm98YZbkEvFDNuER/4sjCHay3hdEFU
	JeBg==
X-Google-Smtp-Source: AGHT+IHQOj4xYFWSAJWT2fA9/7KrVgQw4vpg7ujm3ZJrcmWA606HyJ1C2W3BvOqkXB7uybsSilpdQg==
X-Received: by 2002:a05:6871:7423:b0:3ec:31a6:8b77 with SMTP id 586e51a60fabf-3ffc094b60amr1330276fac.9.1767798500620;
        Wed, 07 Jan 2026 07:08:20 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4de8cbfsm3299436fac.3.2026.01.07.07.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 07:08:17 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: io-uring@vger.kernel.org, Caleb Sander Mateos <csander@purestorage.com>, 
 Nitesh Shetty <nj.shetty@samsung.com>
In-Reply-To: <20251231030101.3093960-1-ming.lei@redhat.com>
References: <20251231030101.3093960-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2 0/3] block: avoid to use bi_vcnt in
 bio_may_need_split()
Message-Id: <176779849694.38479.6300884354899625890.b4-ty@kernel.dk>
Date: Wed, 07 Jan 2026 08:08:16 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 31 Dec 2025 11:00:54 +0800, Ming Lei wrote:
> This series cleans up bio handling to use bi_iter consistently for both
> cloned and non-cloned bios, removing the reliance on bi_vcnt which is
> only meaningful for non-cloned bios.
> 
> Currently, bio_may_need_split() uses bi_vcnt to check if a bio has a
> single segment. While this works, it's inconsistent with how cloned bios
> operate - they use bi_iter for iteration, not bi_vcnt. This inconsistency
> led to io_uring needing to recalculate iov_iter.nr_segs to ensure bi_vcnt
> gets a correct value when copied.
> 
> [...]

Applied, thanks!

[1/3] block: use bvec iterator helper for bio_may_need_split()
      commit: ee623c892aa59003fca173de0041abc2ccc2c72d
[2/3] block: don't initialize bi_vcnt for cloned bio in bio_iov_bvec_set()
      commit: 641864314866dff382f64cd8b52fd6bf4c4d84f6
[3/3] io_uring: remove nr_segs recalculation in io_import_kbuf()
      commit: 15f506a77ad61ac3273ade9b7ef87af9bdba22ad

Best regards,
-- 
Jens Axboe



