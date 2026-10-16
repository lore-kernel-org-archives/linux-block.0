Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B28D384243
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160897; cv=none; b=dZX2FCVUT2sJpdqmgbBZ45GHrlKjSP3jpqnL0LEB1+ml0kSunMJ3aidC59CuJdaxk48LxemLnHz1m3y9+nDNTraj+BrsMbCVK6WjHJ1/PLltNMIbOfoutNc/AZ1IdObntqoB000vF8VnXtsDe0w/bERWZkiMiGqrm7zTYb11LB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160897; c=relaxed/simple;
	bh=nB95imLiEPevytNPqh0EzqaKW7rTxiTQEyIsrzvZm0w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gqw0uDrnO1XyAsljyftq6maz7Tq6sj4XO4vUpS+3QIhA8GwOp4UW06gyq6X5kPhE7S5BcpN/Xso8b8O0BcUt04qN+uWwbETMFD1ssIza0mWhW0cnC7cJfM9K1XgPu9uCxfIG/rzuxiiFp3MXA2lQ5zkc9F5MP928ThKb56YAvho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=LlDay35l; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="LlDay35l"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35f036b17easo2905001eec.1
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 07:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792160895; x=1792765695; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XVqX/uG9HhgmTEJp8uRt7BRpC4NXDvo+DXaG+0jCn4E=;
        b=LlDay35ln4olc8FJ0v6XwWT0CvQrWsh2QgAxjSrOhyP9QuI+dgKGsWCAdehUzV39ho
         zOtLHRT1VsQJfCO3L3WnyA5DqllS473fe/VLR9soep6lLCMOIncEwJjQJotgIM6XcTIN
         bzLpjP2z3Yqc8i6rwlL9NvmclJxu+KAGyXUbpBdz+xNqMD86H54uzatP+bR84gmMmQLC
         rKkzmVSfYjiMpC1xkngxfMN+CJvsWatLHVR2yFCPctnzz68LTyovXhmgLu/UYANujpBk
         SJurVgNnP8SFjl5uRGw7VYpFqEpXRhEtAUqU9b15Rk3jL98zn9X+ZzCnTcBlmoYrYQgg
         PEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792160895; x=1792765695;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XVqX/uG9HhgmTEJp8uRt7BRpC4NXDvo+DXaG+0jCn4E=;
        b=gnCEf/YN0H0niUfJUETY7ZlOl4daUeILU/BgpLOXnCM1Umka94w5nsAgmGnw6jBrw0
         fMOLyi1mk0qNkolAL7pJ6Sy8i9Big6ZzD74KIBevHU7i3Yp2VTm6goCBppNfV03qYtWr
         GRanpUOkiH052ZxCycGiwJ5B1fcrIqnKzb7DoimLG2WkxbkqYVJQIJi6CeRJfMtlA3Tx
         gOmyShdPU63hGCCb1x5icAv8QS27a6Q6PlrN0LRPp9Tuc2sS+hImGtWK1s81MQZzgjP7
         w5SIZIJaj3rOyczpOlvzhY2dPzlDFpb/ZbZD8J8oSAzb8KlSCQedZnL7IyGSNGOngMTN
         56bg==
X-Gm-Message-State: AFq9FYJgBo3IocxF+qss5ccpDSB2g/MT1PFDvVc5GD4kCW0n/Zqsyg6N
	f7VhE7/gG1/ly6fYG5n0ObE9dIURlZFr773eb/kXUgwFRF+cieq/Zf8Gwo6KuVs3GLc=
X-Gm-Gg: AYBFou3BuXj4MyZhw6jYalVWdKX9sBfIm+rou4beWOrWiRlssTvMoRR4ygQ1m4ltw2+
	qRcTsKT5zLYeSucKLg2E3KP3MgWPD6rPgYWAHhkghFyitxEryPw9cWCKTQImx2kRmWYvt2DzfBJ
	I8UWraD/hIFzkGtJPcTjFLiViz0ed7GZ7csWLdQdh3/ZjwiX3Q06Rw+h/Rvbok1XA96j7+t/OLn
	V2f0V5Az9abX6TTcN/oQoBYpUJHjDN/ee7goNvIrS0+trFgSEEsx1OKKzr/6X/K1nalNVodPhmZ
	EUT1WKmTB88+w6VqF7leze5j+vW4D2NS5lLtxG4qBRL4NtELsoA1QHFOGvN+iFO3Nj39Y1aUvUu
	rtRzqlkR6Z3jnVY5g3UZpdyNs+cWsAg8ChXOMeDOdnl9WTVPTHoQcFdXN97KEHt+lirBklXC6ye
	cNmgVKz/5aBAupVN79YRfTNmv0hTr5srp4uo27WWigzQh+pOHI3GVDSkQCSF3X6KrgvRkpg5a2H
	dENly/zRRcgTEK1eRXof7ASRfFePeCa1I9gvT60IN3UpXbEkOzN1r06mQ==
X-Received: by 2002:a05:693c:8811:20b0:356:7ddb:2e54 with SMTP id 5a478bee46e88-3567ddb2f02mr29612277eec.29.1792160894007;
        Fri, 16 Oct 2026 07:28:14 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081bafa7asm7150945eec.14.2026.10.16.07.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:28:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
In-Reply-To: <de91f480f8507d44ddf99c193ef63dec0f02c749.1792142187.git.asml.silence@gmail.com>
References: <de91f480f8507d44ddf99c193ef63dec0f02c749.1792142187.git.asml.silence@gmail.com>
Subject: Re: [PATCH] block: fix indention for dma-buf checks
Message-Id: <179216089305.2070939.5189260832919805905.b4-ty@b4>
Date: Fri, 16 Oct 2026 08:28:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 16 Oct 2026 10:20:29 +0100, Pavel Begunkov wrote:
> There is a weird indention I botched while rebasing, fix it.

Applied, thanks!

[1/1] block: fix indention for dma-buf checks
      commit: 20d808694e40d81d3627f99b90b08e51087d0f35

Best regards,
-- 
Jens Axboe



