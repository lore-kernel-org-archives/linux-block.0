Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223668;
	b=MVXeUtLkrx02K+2G9Zq15l54yo+o2dJnXR4MJlr8EiEt01AAmLtSDASpzSejoZGZQ9kW
	 h5OWtZBvJMa7EpmnhMqE/zHhGHOGTYXFLknDt0BtUvgf4s17KSJ8xWemiql+g+0XF+8EW
	 8ZDWRzN/diD/QxnLvcRs59ofRY3zFrgigPSVAE+7FRisTe729rbAxKJ237F5jtaQeuHFC
	 uAdnlctksV4l11JWXoRiFYSre1myZ91vmWm4iXs8AU5YsK8aOwe5j5H7/K0i/kgGqU/VU
	 tHXqg5E1nT15HlGCKT5V7byZkSQ0LEKyUD7TvXpwGqG8a0MoR6WG92gW8vIlpFJdfXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223668;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=cc49exvy41iKBAY2Mjfi2XX66SV5CDWWS6KdVbEg5mU=;
	b=ywfTXnacPww31rHmqBEzKwLwKNm517ArZv1mTQjFcK3DVpV1IgcntMbJXBq3J1gzROGI
	 L6ljRmIGkDZ5vgP9KUKmueU9VjyWkOwxxaG1TiQYSZeNO7YGqYtRVTgG0qVyBGGZqVENX
	 OHJuqi9ifZaRvx9zt2C1Q8H4y09eYnANa6YxdBzTx9ILYx2bT+XL5ACugx+kC9kbkhIN5
	 QTYVe6udqG3PnQGttVB0MRNWkrCiUkup5cBs3LpdXL8gket4Tr25Ybbw7fM77dFdwdpUx
	 EaAoQuVaon21uB6NJdPr/jvVgb4D5Fe8MREwdimb49WX3PRreaaY7DOxxrqj0D2i7/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ICEMhesL;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C749606A31D
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 21:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C749606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ICEMhesL
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-353804b591eso2346422eec.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 14:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793223665; x=1793828465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cc49exvy41iKBAY2Mjfi2XX66SV5CDWWS6KdVbEg5mU=;
        b=ICEMhesLKtT1lB/wsy2iZCKMOtsQvvT55wXAiEK/AU5RTSgpJu2OSb6HC9UnKTK7UU
         KlolMRA1yxECoXVsv1PA3OV4qNNCv5vFiizy6puIIIiOM75wiFuXBbS5dwSMngludo/1
         O/5WBjRoddtxWi/+0SnqEICZcnKugiXYk2s362nizZEK8OmzYlUD7njUeGJ3qcNUQDzj
         Mqe4BEZ81EqZiwNw3av0D75aUCsc77hOb1g4o0hgM8DZ59sXwbsz1GEgYuMKQdPcmNLX
         8MiMHg//blhVjYMxyYEM0goERvwj50Hv3sB8S18Rj78YZNtE2P5SPbg0f398xGUQKhaM
         mDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793223665; x=1793828465;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cc49exvy41iKBAY2Mjfi2XX66SV5CDWWS6KdVbEg5mU=;
        b=2zQprxWvF/OWNS5PF0trQ3JKOmYzU+q0dCGKkCYFE2mOpMlgD2o+y4D20ef85Fg2nr
         UCyiKlS1LvTJZPdXI7A8KiE6a0AOkNfhJSIfyvDevzAYL851HMFU8dIwTdHktJpUtJoC
         69QRobcGrq5nykRFBfocBKYRsOmJmWGUIjLDMoIL2PmhlybpMXDnNyAaXa3QLgkG+WQv
         CjGRc89wOvwm438EVUf782apGbB3c0c1RVX7KA/Jx/51LyvVegGtgxSp04sTBWwC0ABH
         59SoLw6dYbmdcnPsvRRD3B8gCyg7D2lNPwaxoYm0wH6uub4HE+M/8Dr8ef6eKEff9gCt
         RNjA==
X-Gm-Message-State: AFq9FYIRkNBAiSK+H8PIvwpbo/59FR8mpLLpYOyxbtPuQEpWcSu3bd7U
	AvXW7CsMGRGILXAUPeZckWzVzz1OQ444FYH/uLT6NVFvUD6wp59zHXGJdT6OwX1Z8YwwYtdQ9sv
	3t7GwOBo=
X-Gm-Gg: AYBFou0zVUMfmsSEATxxedeXqfq4U4FjOkhSDag1SQcpK7NnyQpxJl64yA3nlqbZwA7
	AZA0OhFXAHIts1Agl5cPjjt+uWA1yq7xC83QnzGqkwjlto/o7nttxABk5yC6iF9O5m65whCTx4Z
	SUPHJogsYTWNFWlorpQ1QIb34cIL3rVuUuz37sGoMcXGZ2/U+ZgvUVtO7vtzDbEeRO/Ps4Qmg+G
	B59a1TjbLRFAZNneuM/fCKtXkectC5G4iEqle7REgtxMV4jZdo3OHnnMpzrgG9DVwlyrY3LGYW2
	ZM8ESqrlSIDUc4rcIZYlZc0CVm3jOKU1SALjKol0a8CIY1hM5Okylw51CIJ42330QPQ6tqMVU9J
	sxdUnxCoGVTOKlZCRAGAHXWYir+VfM8lptvDUhN/mvrDGPwBkR5bRQlNRsnKRqOrKuzGWde0C5x
	Fa29GoZuJJs0i9eyG0zlbu9EUlks2dUP6+31L0GS0cCC78UPD/40sAgFhfqAATTDZeWVb/mkHBp
	iZ51+tGMv4HEXVdVGLBKD4Kfzd1qrOrYuCjZPSI0Ddk5xu1RJqNN9tJ0QNl2/BjlpEbtW0jXA0y
	mIh6H9EvOwhAHkBLhUb9ikVogyqdJHG2vhS5mt5A1QeHiBE77nenMmRONBniz4wyp/N8HRXy3iF
	vkbsoZV2wQlzp
X-Received: by 2002:a05:7300:b196:b0:36a:30b:5dc0 with SMTP id 5a478bee46e88-36a203bb12amr4981287eec.24.1793223665307;
        Wed, 28 Oct 2026 14:41:05 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a238da3e1sm13103508eec.8.2026.10.28.14.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:41:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
Subject: Re: (subset) [PATCHSET 0/98] Various block related fixes
Message-Id: <179322366442.1350780.18258243570598262428.b4-ty@b4>
Date: Wed, 28 Oct 2026 15:41:04 -0600
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


On Wed, 28 Oct 2026 10:41:03 -0600, Jens Axboe wrote:
> Got a giant pile of stuff dumped on me, and went through and did some
> vetting and, particularly, commit message rewriting to get it to a
> somewhat comprehensible shape. If you're CC'ed on a patch, please
> review it. Feel free to queue it up, or reply back why the particular
> patch is garbage, if it is garbage.
> 
> Thanks!
> 
> [...]

Applied, thanks!

[01/98] blk-cgroup: keep the old blkg while reassociating a bio
        commit: 0e1daaf9b20df2125452846f768a68d8ea280adf
[02/98] blk-iocost: free struct ioc after a grace period
        commit: 05ce1df3756773862c056ca8698f8ec4cdd7fe98
[03/98] blk-throttle: don't truncate the cgroup v1 iops limits
        commit: 7d96874ba80ba7a2ab578ea9139c2af79c353b88
[13/98] blk-cgroup: fix root io.stat byte counts on 32-bit
        commit: e335b853d919f2c6246ca0993115285742a2acc1
[19/98] blk-cgroup: don't free a blkg with its punt work queued
        commit: 4def096314cf29fb6940b74c087a0b923185580e
[23/98] blk-iolatency: flush enable_work after going offline
        commit: 020f61242d6ebeba5f8f2ef6e429aeffdd63f1c1
[25/98] blk-throttle: pass the I/O counts of a dead group on
        commit: 587edb931fdda032bcd63fdfb0db4ded75159ee9
[26/98] blk-throttle: make blkio.reset_stats reset I/O counts
        commit: ac81a07a0bd5e75e8edc0eb5be563be1b2d56554
[34/98] block: don't enter reclaim under rq_qos_mutex
        commit: 045cbfc369f5929ed473f7c200dc2e8146569ce5

Best regards,
-- 
Jens Axboe



