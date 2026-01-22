Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0192D7DCE
	for <linux-block@vger.kernel.org>; Thu, 22 Jan 2026 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769091989; cv=none; b=fgxzEOc7TwKfXQw87nzEj51irSqsi5yaFZruyYedHHUYeOzb2w/gQgYBpptQT3+r2Ppgcq1dg6w/05gbVrV5rPz03TXv6as6zmSEEOOk9/oPvnLRhl9vBAFAiWCpIynPmfvGwehO2X0f7CXMDqjD0SieEMC0OT+FYw4PDZJ0wQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769091989; c=relaxed/simple;
	bh=66VB/AMEzyoE5jTCMB1QdjnB4v9vc0xbnhFR0Ipbtls=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E4dnPuUyKjJj4kKHtakAgsXzzgzBXwnr1xFkz8LGtoNPFeGYG6jzFRL1kGRks6pfNJvnRX4vmbec/JmLSK21N9Y1bXLRhKB/O6572/vl9y+VR5SoKrVI3ZwRj1UPkjE2mHx4l4DBl2wJG+2qgaTDNFFBZMmrdcCg3RAXL+bjjME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uSOBpyLk; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uSOBpyLk"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4041b3c1fa1so343991fac.3
        for <linux-block@vger.kernel.org>; Thu, 22 Jan 2026 06:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769091984; x=1769696784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpaxYFrnUxY2g0ZArUKY1BLteN9kYcd9xSmswCrQoww=;
        b=uSOBpyLkN4+8lM++wGDxd8Y0QWIc1dqEMu1Kv7RIW7nmqqfPBkKadLlWgPxG18oRPg
         fuLYoMT+qcQ2GPTu8dlH3/GsKkO+Fq6FJs9OCrAl5biM5JTe9Kscc8s70w2NRF+00N0v
         7VdrhhjZ+Y/69BoBF3mpy41O1dzCSoKQ3VfQc85ODR4OfzOZZPx1JTVGB+xGWuILMdcI
         +XOqj/Ntixa+gbObaSM9xWZz0Swm272iB73MqBxQ6BgXd5+9x/Hyff9QnM2SMPK/YXdx
         Z9HxWMXhR3ZCtOYvDe5ll8+1eAyDrUkFra7DWxWKHiqgl+anndgRkytUhTA0+rZsHb4Z
         BBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769091984; x=1769696784;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kpaxYFrnUxY2g0ZArUKY1BLteN9kYcd9xSmswCrQoww=;
        b=byFqKsfbX7qxT0lh7oCzjeWKNDMDtFmdqlO2QBRQH2EUcw9cM9QHNjdQXsjJw0ej0w
         H8ON2jrLIas2YWpWGvwPJl/og2KZGFNHvplsl+LP4evkvXp9pzXNXiwCPQMCo/fVumnW
         e2g7eAn+Cosn6PAKofOCGcEkQdcnKOK3ForozzGYOOF3frvG6gHhAfRSdwitplb0wSbM
         MTYaG41/SSEm7E6eFKXb6RnyGeqJKO8kx8LCAOPVZNSIl2o3dQ8n763VHRnAfl4gVpTx
         I9jQfDYrrfWUN4RCQc8fDNeqIc+TDsB81NaDlr+KUAQtOlvoLA818IzThlHYNBJO/N9y
         mxgw==
X-Gm-Message-State: AOJu0Yz7WTKVjIIUPksTyAl3/ef7WZT/uXeco8CXn/gcgGVHo1iquThU
	pER4JKFPClj2175a6K7jtiYBqMfJVAj49KYyxux+sKzqyGuITnwJFbjshePoxb4K2CA=
X-Gm-Gg: AZuq6aJ+TJ1lGkB16HbgTa5K9UpP8GQc6iklGk9TXobKY9k793xCbWiHKd85CZP697i
	JVuCnfeXJdKV013gHygXDMkKx/RNXV6lRtdBUTqhAPbG3D3+Jp8i0oGEcjWAIOrc4lknwMFwBg3
	vG+AZTpfGHBiv/QBFKI4R36YphgdKbcS35gGx7JhdyMyuU1aHSOkmjBua/gAbESfetfOFI+wd6j
	cxJfycrZxSnSTDQ/xDvIRfOK9OGcHkiDupCoB1R0q0wM+5A3BzsCyTNjxt7nfP8ELFqBzjT1QVW
	iNcp2iS7X7LB9Yhj4g5E/zosSwXEFZ1ZPl3Wn8jb0E52/E0o9b8ueCiBYtlMR+YszlD2LCV28Kc
	IodwxtsD/yoK7IUgqqYuVnJPoWMKl5efMAEzIU//Fj1AjH1Lcy7S3KrQMZp/UT93lrbCzygu8DJ
	Pby+QsDQXr2GjCWeakrGFGvRKKlEuvIA8WbaCPOZgnI08lfuOXVwpya8jVjzBI760=
X-Received: by 2002:a05:6870:7098:b0:3e9:35d4:213f with SMTP id 586e51a60fabf-4044cd9e8d0mr11226469fac.10.1769091984396;
        Thu, 22 Jan 2026 06:26:24 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bd5c64asm13773891fac.16.2026.01.22.06.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 06:26:23 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Diangang Li <lidiangang@bytedance.com>, 
 Fengnan Chang <changfengnan@bytedance.com>, Yi Zhang <yi.zhang@redhat.com>
In-Reply-To: <20260122042858.1877497-1-ming.lei@redhat.com>
References: <20260122042858.1877497-1-ming.lei@redhat.com>
Subject: Re: [PATCH] blk-mq: use BLK_POLL_ONESHOT for synchronous poll
 completion
Message-Id: <176909198326.303056.8789456651018562823.b4-ty@kernel.dk>
Date: Thu, 22 Jan 2026 07:26:23 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 22 Jan 2026 12:28:58 +0800, Ming Lei wrote:
> blk_execute_rq() with polling is used in kernel code paths such as
> NVMe controller connect. The aggressive spinning in blk_hctx_poll()
> can prevent the completion task from getting a chance to run, causing
> a lockup.
> 
> The spinning with cpu_relax() doesn't yield CPU, so need_resched()
> only becomes true on timer tick. This causes unnecessary spinning
> while the completion task is already waiting to run.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: use BLK_POLL_ONESHOT for synchronous poll completion
      commit: 046be7e5967ef80547f7fd8a399e932f5338d5d4

Best regards,
-- 
Jens Axboe



