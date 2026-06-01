Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6273336493C
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340374; cv=none; b=eb/3ljTmQPhwe3lQS2R8Tta33mI4pSkVNVal4hXMXXM6N+iDEb22wU1m7qTfr4hpamPVmdHgb34Um4zklelUoFqCQn3NzSpUK2bmWUgKOr7SZuNmsfjJxWum2jDXRTW+EX4KJIW4zmGsaLfDt4lyXyo5c8VoA4bmqhUpq1xm60w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340374; c=relaxed/simple;
	bh=OpEc4Y/PrpWkGa9Fmdvfq4BLLoaFNGFe1Wlnjyx3my0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ao6pEx7cd5djoGq6zQXkkU1qeGZ6twY37JxjPsT9EAWjCkW3nk8H1EzMV2uUUKwlNOFmRgAfRGXhPOFxUfHWEiJ7BE8sPtLjwgsH4THNhlBZ9yDhnZtG+k6PRwdzJm78BrJ4NBFxri8+47JIHZ9UdfC0NXB2tu+xBScelZrjTZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=naSmWNjF; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="naSmWNjF"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-69d8e55e76fso5834674eaf.2
        for <linux-block@vger.kernel.org>; Mon, 01 Jun 2026 11:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780340371; x=1780945171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91eVT96xRY/faTwQKcQ63E6IVm1ZZTt7y9K01q2sZyw=;
        b=naSmWNjFHf6v0Zx1ANvz6dFXZkc1riNgrMcwpFiipy/FlYbQwM/dlUbCLLIjFcCKwN
         +hQtAn9m2bADbeEn1HdK+yrUHTEVUPKtTNnxPv1bCikKaB7QMRqWd/Y5ghnbSex2idVt
         QUl0wJQMCc1qecIAc7Sl/O81QpY4WDVSyg2wh7UXe2tIa98+cPcTJ1oE/iQjk6tXDe2f
         AGaqxYpkNluUgn7e9X63mPvnwhrNXBc8v/F9aPyuXi50Mn0BAhgnRIQ46XhVp6C02KgN
         cQ7K9609Bb5vqtHfI6HVGlPEpe74TyZnXPsceICD7Wz1B8OpHFM4hRNY4c0020otZWsK
         GEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780340371; x=1780945171;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=91eVT96xRY/faTwQKcQ63E6IVm1ZZTt7y9K01q2sZyw=;
        b=nrpwCyQZQbyFbJBFgnB39SDIPSH8iwiZJPoNDdTB2taH4O8Q0cV/gFxjxEXHxrATGD
         IfhUghv8KvwjntQL/vcLEEo+x8TklVZgjk462V35k5VIQJkjcg1lRVGGBCE6mvXDoB6G
         ZzTVPQAhhbIadOhm+VQnQVd1/RBVI7EwrZdLAYaMJOMdGgFwMR3AcX3wqxGtZeoINnil
         777ZeVnYCQxakEsryfNgDwX6RIpjYz7EZ+stkfDWu/Qv4rfw8vFxo8qG+Sa2puOmiqYb
         SnZt25KXJQFY+P0rQ/VoZ53XLdkgdXL4uqrhIpiCsbddprXUGYEnvuZZF6+rZQr8y+l9
         yaOA==
X-Gm-Message-State: AOJu0Ywyiupt069T5/AzzsjthOim8yRdxO9VZ8IYt+DSXIFR+lb6pekI
	vEnl2HkTqh/X63AywitwsIV3GwY2J9X9g3nnwvLsD02fVGtKxxo4Yl/i4uazfXyqMPSUa0bXVms
	wNgcH
X-Gm-Gg: Acq92OHRrTkvZOSPz7A+FRKOlWIC/KCdE2+VQsxqhCv4b7RF5qke9a7Qd0JHisEYrot
	ER60wXSBoBJXHmNHu8OXHjPCcBJS5Q4DaDzESlB6PdzUAp9dvar/45MsUCRgbWlqBzGJxcqExJg
	Ve9n52AhxgiYfIeJgVnTsEGHQdfVJKtyCRuxL8a99aUhc6bsvyozQ9FwmILAjQc98d9I2Id5X13
	3F+08qOQoZMGC2yaEeXSTyRd0fdVVH/ulipoyqsIw2GYKAKvLAVYvkQoaTcG2x8b3NufLijg4jA
	WUikFvR9G+EG4V+TERKq34giQMcv7yppLEROYCScLJSFQ3l2v7eNaLAIMp4uNgouzgKJ4XanRoj
	3KXOs8L3GLfYNCG9pNkgwGS8eC7qhpjHgvk1miPIZWg+s6+dxFC5UYxmtNpo1ojWllALPh9ZYut
	Gck4XZ+0tK00WkFNHVltg6p1228oTGgCpxg8wt4nQFzTiGjPzrF/+ejQxq7sqiLFvcmAVDbUG9f
	DSb2bXfEEZRug==
X-Received: by 2002:a05:6820:4b8e:b0:67e:3f0d:4235 with SMTP id 006d021491bc7-69e10403fbamr6175521eaf.11.1780340371050;
        Mon, 01 Jun 2026 11:59:31 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e067e911csm6386319eaf.5.2026.06.01.11.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 11:59:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, josef@toxicpanda.com, Yu Kuai <yukuai@fygo.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260601061312.896801-1-yukuai@fygo.io>
References: <20260601061312.896801-1-yukuai@fygo.io>
Subject: Re: [PATCH] blk-iocost: use irq-safe locking in cgroup handlers
Message-Id: <178034037025.437649.2280578282193529084.b4-ty@b4>
Date: Mon, 01 Jun 2026 12:59:30 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 01 Jun 2026 14:13:12 +0800, Yu Kuai wrote:
> ioc_timer_fn() acquires ioc->lock from timer softirq context. The
> io.weight, io.cost.qos and io.cost.model cgroup handlers can take the
> same lock from process context, and the direct handler paths must not do
> so with interrupts enabled.
> 
> A blkcg policy configuration reproducer with lockdep reproduced the
> following report:
> 
> [...]

Applied, thanks!

[1/1] blk-iocost: use irq-safe locking in cgroup handlers
      commit: 1059a743064b873aaaf34ebcff89110c7753fa32

Best regards,
-- 
Jens Axboe



