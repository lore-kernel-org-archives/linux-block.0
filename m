Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27B93839BD
	for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782492118; cv=none; b=W2nzUEjFp85ndl122prDSvUYtxajpGCc2etIr0HQx6WG5PXJif8CFiJ5LDnD/zmHi7IPfiWDf40bjDSpVMd9BsXMp7+t32JwWmlrsAl7zs6bY4ogGoSlO++6qVf4tVzDMro53aoNFkAv/G4Ncgw+jws6j2eU4NAoD9etDcMpRXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782492118; c=relaxed/simple;
	bh=K/bwJEx5d3Jh4eWAtC93ZctXo2s/KTrTE0cnysEv9Zc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IjHwN1+GP+bhDIRdaAmPhZywMNfKCVZciAqibTNPQQ5KVNuLxUt+8X+MD+JkK8R9z5x5J1J62unFQu0+90fUcWhwD1lAB4bwvoNjm/BjsECYDW2E4gHDPVWe5hTMPP7IripiZmxUp0XmyPkX6HXUpd1TPuWlf4B01p3aLhIeL/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=TLhQm5oV; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="TLhQm5oV"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e93d1dd156so471839a34.0
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 09:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1782492115; x=1783096915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBpuFkjpEyKsyt5/1ZVbLtdrTInXAbZyYBzR22KylFc=;
        b=TLhQm5oV0BbaZkagzIuIW0WT+d6/q3PpiE0cQSvPOj1jWtcG9Vx2K3ZalNXky4uaxZ
         l9k6VOZBpzOQWnOQOEr4wWatD24cSMiS1I1KqkPS/sfdij+RaaLm40KRPompFGh8F7y0
         7RK8bLnD6BhslZcnwTUQxXqBeKDyy47olgcitkpBhYrXcXqqaeujFq4TRMrrH1FZ+s4t
         oVCSpYm3nnB25YsYFWQQyWwTI2YC6OEdL6w7wLDzf/tGrSJXd8dWCM4HGW4ebctR7pEw
         ke6D2SS7XAa85z+E9CH1RlhenE4v4JrkoXgDHjAs8Y1vPxphAO5xsSYy6H0GQUccFKLv
         k8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782492115; x=1783096915;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UBpuFkjpEyKsyt5/1ZVbLtdrTInXAbZyYBzR22KylFc=;
        b=iA1smUzaPl4fI2PnyrE2CfPL2xVu33o/CN8CHZ0jISMH/ntuzhVxpgDk/GznyQdmvf
         Hzdl0dUMrYJdOE4GLcRZkwfWU1i6OAzdwOVunYTAyt6EjlPhMONtlSyb/BvQkEPGC0Nl
         7dI6zl79fT6bBzTyLyn1V/i1K/LtnFiNbGM1FD6AyAlwR6kXPGaToESUy9IqBRKnZ6fS
         r81doBJMfp7YJBLapCMnNC1LgsO5IXIT/Gm0rhHeobvU0a6gOE4QK3mj+1cdWmu19yza
         m2Fobg+tL7y2jGQoynrnnsr4YMVkIeq4aEohZ+yBqNb+OS3m7aTgiDVWrpv20Mx3rQPj
         38ZA==
X-Gm-Message-State: AOJu0YxriKl92IvATakwibWdd2KQiFacLgA/4zcaH0hqfa0dCT29WtK1
	J79ByWVPEI8EcGwqUvgXeokF8gb/9WCOPjADnYi5DhPzvbPwTHC4lu7hWS9sHn3ubRY=
X-Gm-Gg: AfdE7ckxNvAutGbVWhW3la6bgYhZQHT25XXq/9CisJAvGFqLdZXnzqXYUrmiGFN+0PH
	7fAlDYaejvMYI7xp4j0Z9r+5+7S8xuiUvc+hRjCzb6xYxWWO0DYS8eC66FNId6XkZ0rZvLfzF4C
	gGZSX1Yxaj0rYSM1MnzyhA6BM6/NFjKml1K/7ngsqM+vx7VxsPpnNg43MrdLEZiLFp8sysgL95r
	C5j4GOf6SSYvbIGiUCCr4rbrfR+237a+1xdZIypNfcfwJrKk+56QlrLgvrImsPvHxJfLjBYvgHm
	w0jZDjXXLUmwVMw9WrFojkEjXTmtT1mQxlRFtj8LclvIm88lirYi547ShyT2HOg75rEf924BYCb
	Prl7ybIifrIhLDYK+yog08yCoKya4L+N0BKapqxE8fswAnrfKmz8Mx+DEYIcNzXi4G5QS5pW0BS
	8qkRbvygZXWkx5iGbld0Ah7DrR1D0UdCkBnl4VeqZiwi8OKfjJxLaqFFOFlB+Y5syS
X-Received: by 2002:a05:6830:6d41:b0:7e6:ee1f:96f1 with SMTP id 46e09a7af769-7e99bff2787mr6632075a34.5.1782492115017;
        Fri, 26 Jun 2026 09:41:55 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9aa5d3500sm1995948a34.8.2026.06.26.09.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 09:41:54 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, kbusch@kernel.org, lidiangang@bytedance.com, 
 changfengnan@bytedance.com, tom.leiming@gmail.com, nj.shetty@samsung.com, 
 joshi.k@samsung.com, anuj1072538@gmail.com, 
 Anuj Gupta <anuj20.g@samsung.com>
Cc: linux-block@vger.kernel.org, Alok Rathore <alok.rathore@samsung.com>
In-Reply-To: <20260617155051.1266079-1-anuj20.g@samsung.com>
References: <20260617155051.1266079-1-anuj20.g@samsung.com>
Subject: Re: [PATCH v3] blk-mq: bound blk_hctx_poll() to one jiffy
Message-Id: <178249211373.32579.13097309329751344504.b4-ty@b4>
Date: Fri, 26 Jun 2026 10:41:53 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 17 Jun 2026 21:20:51 +0530, Anuj Gupta wrote:
> blk_hctx_poll() can busy-poll until a completion is found or
> need_resched() becomes true. On preemptible kernels, the scheduler can
> set TIF_NEED_RESCHED on the timer tick and preempt the task at IRQ
> return before the loop condition re-evaluates it. After the context
> switch, the flag is cleared, so the poller can continue spinning instead
> of returning to its caller.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: bound blk_hctx_poll() to one jiffy
      commit: 30e542a36228db353e81efcd39e4dbc7a95c88c5

Best regards,
-- 
Jens Axboe



