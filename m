Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89F41A681E
	for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 22:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782165665; cv=none; b=q3EI/7Wc39rxCodtLXjVqXb2sDb800i+z+JxjeeriszguPIiHAwWn/CQvO6htQYmaFQMmncjhr58RTF0GfDgkzLnBgu+6vDVVExFXcHpWx9WgM/vdH9IFqeS4N2lnsaPiXV2S9gds/SsM/mzZqfJRXtBUSoRfpI997q20SB8Df0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782165665; c=relaxed/simple;
	bh=8iCisRkHV3+0EN6bso2f4frYm0nmJrhWJ9IbZh4Lo9w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WqQ6w/sKDvEWkdnHPPhOKs9jubIXXhSreyQqMxBVC9DQKdby0IE+At5JzSH3K1dulvs7Lj3HJEbsR8sj5BgfoZ9MzTrWg6RmgQpJYubJQgUno2DdcDu9gAnfBXuA2RpeJMwxwm+dWRQr2ray9eQnxkXoEUooXLMnuqCz4FJICe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=m4mbs7PO; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="m4mbs7PO"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8df7a3a6fc3so44520206d6.0
        for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 15:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1782165663; x=1782770463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14xOeLEoF1fHcF3BjkYbSGPbgudDiHstM/8c5Hb9SBc=;
        b=m4mbs7POaNoCQFs1WgrrGgRpIyRnmgRWnmv/GIAQ6BzLBsVJ7Tz3n5wcUmFHbn/3tG
         9+vIlYOHZMH4Bsm42mKpbRa3nOHj/Sl1HQjPF/9CqT1c+WYmHYf3P53YJTgiXY8ZSkcA
         MF1OdV1fpBpNH7fBnyODEXFoe3hVuffDwgosrwtWrz7nXNUwwRuEgiWWfEmEPZ5CFIuo
         UdmAIwANwTkKxWW3dD2tp+2LL8qQWv6ZQZ2Ujg+DwuhkVkv767G6HRFZWfaXnc17p8TS
         BVQx4/3zJGolnwFYGsqdd+TUxIKpez4nKaJOoh+byN6dz/yi9gMEwJVi5sDIyS5HBBCZ
         vnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782165663; x=1782770463;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=14xOeLEoF1fHcF3BjkYbSGPbgudDiHstM/8c5Hb9SBc=;
        b=MbUYF1lq4C3AHIy27ArttIuqqrnUBEezNzGJV08/Irm2tb858Ezbg9O12fm32Sra9N
         2z3qw9LGJFvQXS8LM7OM8YdOwqJ5LLqWnpBquQ/I6W5g9gtrBJzLSoJIETo01G1eVnnF
         HjYfMAaDEAPPMd0d86shuP+fItdmkLJ5uhJ/MEeyM2QqQVOPRYkM7XKp05LaU1Tox1eK
         sWqf2vHeTLkTiBBUzJW8lYB/Bndb4KpEQ0DMoaNEr+Y4gV3shIoMKWyzHm+G+7bq/xqy
         j8dzuo78yJ/yd7gYo7bD+5NZxDPH+Ur1vXbD3L2MXz6qshmNub82evdjXKyyX/lBESvQ
         kbcw==
X-Gm-Message-State: AOJu0YyWMgXYegPmNL9K1+PhqWYVjkZ4IZTiQge+fXW6yq2jc9SgTIUq
	iY9MktquDAlN/+SOLdzhA9U8MmLJvnpp96rzZpfsMEd590dMbFzM5rsWvr+3w/1x/To=
X-Gm-Gg: AfdE7cnMfIDE+mM7Aq5VObSOkoI62xKFj1Mi/bltOTpbhD9f4lmB5CjHmrY+NuDWRAV
	GYbjiL/qpgJiB+fEdp66sxbJlxpmUzmxLZAppmq3FlQQvpyrlO/a1d9MjdeHjPYo+IOQAv1eXxJ
	+EwoUPoBsRdgg/XvZQ0uiTWTQJOkx/28vWaaA7vzDX1NsaJGuIqtpeORNSAtVOlB7MIxr8yFXEN
	dqAgokvsyVaJlAy+XkWuhLBxMWi+4TZ4OfqxdRPU/HJAh3iEnBHBenihqL5xJAgOEWpGr/8kuBO
	TXA8a17hjyDU+8WyXd9mgkScPc1xvgMFe+LjJSr4Gmp3Wwy4u+O4VuQowif/3h05K047vwXDNJw
	FxWYRlT1zmzuE/5LUcZv30PJ5V/pLixmGBJRSa1DrSwiYpdL2WL2y3/RjLHvZ/M2bftP9MHR+vY
	XCahirjJPK7f37Es+O8Ld188WBS5hwqW0Vgug=
X-Received: by 2002:a05:6214:488e:b0:8cc:d29:9f78 with SMTP id 6a1803df08f44-8df8f90f599mr233832156d6.11.1782165662719;
        Mon, 22 Jun 2026 15:01:02 -0700 (PDT)
Received: from [127.0.0.1] ([99.196.128.58])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f018898sm106932496d6.7.2026.06.22.15.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 15:01:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Yu Kuai <yukuai@fygo.io>, Tejun Heo <tj@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, 
 Arianna Avanzini <avanzini.arianna@gmail.com>, 
 Paolo Valente <paolo.valente@linaro.org>, Cen Zhang <zzzccc427@gmail.com>
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org, 
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
In-Reply-To: <20260621135930.2657810-1-zzzccc427@gmail.com>
References: <20260621135930.2657810-1-zzzccc427@gmail.com>
Subject: Re: [PATCH] block, bfq: protect async queue reset with blkcg locks
Message-Id: <178216565206.110437.6768049462102917317.b4-ty@b4>
Date: Mon, 22 Jun 2026 16:00:52 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 21 Jun 2026 21:59:30 +0800, Cen Zhang wrote:
> Writing 0 to BFQ's low_latency attribute ends weight raising for active,
> idle and async queues. The async cgroup path walks q->blkg_list, converts
> each blkg to BFQ policy data and then reads bfqg->async_bfqq and
> bfqg->async_idle_bfqq.
> 
> That walk was protected only by bfqd->lock. blkcg release work is
> serialized by q->blkcg_mutex and q->queue_lock instead, and
> blkg_free_workfn() can call BFQ's pd_free_fn before it removes
> blkg->q_node from q->blkg_list. A low_latency reset can therefore still
> find the blkg on the queue list after the BFQ policy data has been freed.
> 
> [...]

Applied, thanks!

[1/1] block, bfq: protect async queue reset with blkcg locks
      commit: 17b2d950a3c0328ed749476e6118ca869b3ca8b5

Best regards,
-- 
Jens Axboe



