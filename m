Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42B43C6A29
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813425; cv=none; b=H1pOLDdO6F78PwGtHJdfIFPquH/6f+9/yKfBoB6YRNHRbJ9WOoqzkur5f2efEL6tga0aDvguqKcVu8OCe9yuuTbZVDdffE/ZGm8z0lXjgiJ+5PWCOOe7YCaaYyrBQP7QwODUKTbIWbkV8nv1FnSaCT4vkLCUV3+GMxV3PV+GP9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813425; c=relaxed/simple;
	bh=/GO3LeLy3wKpnITAQTk1hnrHhz5bef2/BRgq4MASNl4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BJ0vPczWTrZDEShF1TAPh14K4/4AJfgRzBgb7kcDK5XmtdRAAbLXUt0FGcHdAedwt5ubLPTCh8Lub06Okwi+4aqkIAiwxOvpWntdkqoF+XB1lPEp2OJUKdYW5QIZFyWapeT8iWrNqmHhyj+ytDWUntLvnXoW8k81bHJydxsvX0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=jK8Fy/jy; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="jK8Fy/jy"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-69d8e55e76fso2660885eaf.2
        for <linux-block@vger.kernel.org>; Tue, 26 May 2026 09:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779813423; x=1780418223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7pfyyoGQMu4WrjFiMzIODi4ZGH4tu1162Cj6NAkVLc=;
        b=jK8Fy/jyUnzS49pxgSdZ8X9lpQrw/+/L8hdngVx/hvxZXPwqfPBOkAG6L55I8aHDIw
         zKunQHdGSiZ0lPPEhzHf8brI8K00BXAFQPRd3uXwooU5b2+kPbBgLr+4uNS3oGHjQGhf
         Rmvecgn2h77BGa0pBKVhzvDVWYTy142hub4VkMWgPD/FU3ErZsBP06tbEbC/hPwsqu92
         3b7UKytUCO//2Yhxi/K7IW6gwugcSzl4kU3Xnj36j1Z+DxzG+SfNxyWsHs44hKc1BxPZ
         YclRuOtWmH427dC7wniovX8R4AGz+/GbPecPQnZtyEPgDlwlG+70GlgWHZ+uVPYctGYW
         xAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779813423; x=1780418223;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b7pfyyoGQMu4WrjFiMzIODi4ZGH4tu1162Cj6NAkVLc=;
        b=N+Tm2YG7GOrJSQ8D7vonsU7/CUp2FduQklObv7lMpj1FeTEJPrHu7W+Q9UtlOsY2Jn
         XxH776mX0h3hKhF7ShEml/uguxhWCmwFggyru+W5j77uy/OsA/i3QStFmPfrcoktsS4y
         I4RPjQYqDV4OJjjp1iBaXOWJzjgQSVXzo3J748Hk10XN8nE8S7w1oe+IhgiIj8zBpOf8
         e0dqIZsKa5xCM6/j8wLDhF4DZ1BA91Ay3gV+CbhnWE3zhBOHE3eZj5a0tPH75ITwRiap
         LTBRUkiUzR54RFMALjPXqEgZsn9chaOKIHvfSc8qa+xYkbU173RKXBkcAgQhg/Z1U8A+
         xiTA==
X-Gm-Message-State: AOJu0YyBNscRRgTi+Jg+jIz7NRuGH41G1LJwdQgCdt9+bOEqVU9O4hpy
	IXXR/efi3J288Fz2vUcSErTwTmFxVBr5INo26PIOJiOz02WwLpPXcbzvzpJwd4iMVo34chG/q3h
	ZNrwA
X-Gm-Gg: Acq92OGdQ8paMDfwS7pOTsZ7sBSuipLbFItwPIOD/bKQCnzTlbdjQ9H+L5I+BF0Netk
	smlhwdYPwx8SVtZ+hnWuDPqL77xAVlh1BZf357vk0ktsR8M8l8d3rRqYrtzxPSC44Z6CBMtFuMb
	kJZtjEzmZEknx6AtJLORWY2PtDenPF/P2wAGR5pQXz/FzrmhieRDT+ARV0Ln9LRhbKgDKe3PjiN
	WOgsN/e0Bd8Drpn/VBtH/lQfjvfob/VKkqnWIzphGORChM0CGJGRnM0fuX/Mx5VmJd7M60mYAaG
	qs4BNcXVXmJW6KJH3VBXWazEiQSlYF1bgwdUHD4hdhylXtPK08MisxJqfDdwaNETQcWN2j6Q5im
	+IVGu8qkvP0qMlAYux6bNHoqyQUT06BpLFDGs3s2gMuA27vLGZDwGMP6xl4BdQ3AcOYmDxOBJdW
	+6q6TxFND2SEZFbe6buZPFO0k/nQg/BRKOQl/hsntfph++ZNNjjBhsTflfMHCPgK6RdG2z++Hfr
	iiRLCIw6Aox5w==
X-Received: by 2002:a05:6820:215:b0:69d:9be6:860e with SMTP id 006d021491bc7-69d9be68ef9mr7011333eaf.43.1779813422691;
        Tue, 26 May 2026 09:37:02 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b639fd7adsm13561265fac.14.2026.05.26.09.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:37:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260526103722.2287587-1-vulab@iscas.ac.cn>
References: <20260526103722.2287587-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] block: blk-mq: fix ws_active refcount leak in
 blk_mq_mark_tag_wait()
Message-Id: <177981342076.464267.17950379735757813338.b4-ty@b4>
Date: Tue, 26 May 2026 10:37:00 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 26 May 2026 10:37:22 +0000, Wentao Liang wrote:
> blk_mq_mark_tag_wait() calls sbitmap_queue_get() which increments
> sbq->ws_active. On the error path where the waitqueue_active() check
> fails and the function returns early, sbq->ws_active is not decremented,
> leaking the reference.
> 
> Fix this by calling sbitmap_queue_clear() to properly release the
> ws_active reference before returning on the error path.
> 
> [...]

Applied, thanks!

[1/1] block: blk-mq: fix ws_active refcount leak in blk_mq_mark_tag_wait()
      commit: 94028f339610f5d39d101449dc27156aea03b3cb

Best regards,
-- 
Jens Axboe



