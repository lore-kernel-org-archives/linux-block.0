Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F2540243D
	for <linux-block@vger.kernel.org>; Thu, 21 May 2026 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779390356; cv=none; b=H4ezMimxXxsa8uawOULwQlmqFZhoB95WpxnURKV1fx3/O5czBnpFgK3US7eM/XXB0sgFkt37iCAtfXJVq9K3yH5vI74b5N+Pjhp7ZQ8mDiNNq5tcpA1BSFTFzbpLJXvPsuQeN68BwXXIGSHJo5yf9/l+F4mIH65qF5Jz7dYSy5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779390356; c=relaxed/simple;
	bh=sCpXmwY2D7W100hPNNtGNhu19b2yEXq9YWt/CxTQWc0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B/qXXy54+xrukMHZMtdoyuSvkDZCdVgdtHBQ9/gol3rpJ7R/E7EKm6BVNdNVsDaKyAdId2Ptm1T1ld6Juz7LmrfjhtN+4kL7MFf5np0+gtiv/owixTQXjO/HP6I041bgBucphGbqKzT5t6MXmgJbJk4YEbvXXcXdBIjaANRlHxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=sfZMpLjp; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="sfZMpLjp"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-41576c5c01cso4785627fac.3
        for <linux-block@vger.kernel.org>; Thu, 21 May 2026 12:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779390348; x=1779995148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFHHfgaurUTrz+vHzG3Hux6ymWIPZickwnJOaNLJR3g=;
        b=sfZMpLjpJ6kxPWc/qTJi4GVyqMXkYfFDWJ6b0U3L0MWCNrXeJe4LsUOXPC8u++h2pT
         XXN6YClN7Fesb8aJcUAn771Xox3F2WkX2Ed6SAtj3VO9G68H5YmFtABREPDC3wWX3/Q3
         hdzi1tWWLcWMa2zvxeMM7uUmeHvyU+yLfi/unkDDPdtM+JeiNaJn01FL6RFPaFmIiYUt
         JCg/h8oclvRz803bzxsSMPPiBBYDFQ9+DgGcf/7Dej3gKLin5ZnIZxqBXV30pRClqztK
         YFOi9kHPI3nT5Ns3Vs+jtYtLo907eBE+LcHIWtNDp8o8IIxq+VPs0HXoq+0n66z59b0U
         c2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779390348; x=1779995148;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sFHHfgaurUTrz+vHzG3Hux6ymWIPZickwnJOaNLJR3g=;
        b=YR5Qd6Z4D0Q+JuHt0ag4bSIQljARvLN2qam+J+v2f6BXMYUQhKcYri29qfpPfWEJl3
         4CEEf/E20xBfNw23rL24nDEetvF692MQTUJ/tmPsKt3utMVAy7j6ZotSRRm9GNs+pFWT
         ObYoggrKTY4Rw77fn4SHGB+llyGOWnVVdOjEoYTU1IbJmy9E8tSK9mQE4lxh0yFrHcfH
         NbAnMUDgvstzxLMNp4NqP/F4p3n1tZr7yiooKFDnt4xFRmha2xNNp4OKfaS/Yft331jP
         btRtD0hPXLtz/ta1rOGbdCTd4y/hY8dWm5fkY1uM/WbKzxdaV5Qkd6/6KwNyNSmdDCjC
         EUTg==
X-Forwarded-Encrypted: i=1; AFNElJ8Tag3OprNAA8Z8nIjZHofiloO1dsMofGHJvAXRW1TvDZoW9xEPevfF0B0mo/Rw98h7cf7CSXDc4KdanA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg423q3NOCUHZJ9yVBj7q5NieP0H4QRRJnhCQYqD8YtQgMBxae
	X2XBe5Iz0EvJoyn5m1yQMXsVoBSEBfREARANdTg4/SMiwiBtx8mz50ne5EoYw35UN5M=
X-Gm-Gg: Acq92OFw0B7aZ4J+J3Y2HZa+/HmlAyooFbx7tIfhsWWo8RsGP6U+PfQBKvvaDRK94vh
	rDs0JuqyiDpmIygz8wY4gqEa2abSttTd8LbQMCgHRcxQ9Fu6YHYF0oyyr0ptbokVj7wu7HYvGGd
	UZvDrZ1prV+3Bd/Q9oKvt06g4lKW9UaGcdE+uwkkic6srPDfGcZOPyIliGCfsCXNgC+xBfg6uOG
	zdey2e1TkZTBxzCW7+AXIO+AvkhO0azWiSc4OgTSPbMTQPVwgWBbtHtm0P59HuBHTpzkYVs+/Ew
	Ji85QNp0yllg0mMCs4lb/gonXOkTQZDP4sWj9wYOLw0eHAnBKT2U9nBWZMt3XK2YkJ4OELFaZVX
	0NKpiZmpskRb5JNBImYZXt+HVdqFQeGpIKMVUAWLCdO3F+IimcTHAKZTVaOqJC0HSm6tr4wbKW7
	ca1fAaBlTqik9+HUKGq6Z1r0A9OM5KBncukr32T3RaR6584YlzA65HorK/5EStfb9FGu6ajxZML
	wjs2FO9E2H/UQ==
X-Received: by 2002:a05:6871:e7c9:b0:417:4888:328b with SMTP id 586e51a60fabf-43b5ad5c218mr205333fac.20.1779390348350;
        Thu, 21 May 2026 12:05:48 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b44860839sm1301019fac.2.2026.05.21.12.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 12:05:47 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, linux-block@vger.kernel.org, Keith Busch <kbusch@meta.com>
Cc: tom.leiming@gmail.com, Keith Busch <kbusch@kernel.org>
In-Reply-To: <20260521190253.242065-1-kbusch@meta.com>
References: <20260521190253.242065-1-kbusch@meta.com>
Subject: Re: [PATCHv3] blk-mq: pop cached request if it is usable
Message-Id: <177939034718.254843.4774076328896277514.b4-ty@b4>
Date: Thu, 21 May 2026 13:05:47 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 21 May 2026 12:02:53 -0700, Keith Busch wrote:
> When submitting a bio to blk-mq, if the task should sleep after peeking
> a cached request, but before it pops it, the plug flushes and calls
> blk_mq_free_plug_rqs, freeing the cached_rqs. This creates a
> use-after-free bug. Fix this by popping the cached request before any
> possible blocking calls if it is suitable for use.
> 
> Popping this request first holds a queue reference, so avoid any
> serialization races with queue freezes and can safely proceed with
> dispatching that request to the driver. This potentially increases a
> timing window from when a driver wants to freeze its queue to when
> requests stop being dispatched. That scenario is off the fast path
> though, and drivers need to appropriately handle requests during a
> freeze request anyway.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: pop cached request if it is usable
      commit: dc278e9bf2b9513a763353e6b9cc21e0f532954e

Best regards,
-- 
Jens Axboe



