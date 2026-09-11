Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4689A3DA7C2
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 02:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093181; cv=none; b=fMJpwBQFp99R2Cx7lmgNwVwakbQxel524tVx5ggs7yAVYvFI5mHpGcLwHt6oSTj+ci94S1z3J2N/TCv8aXF3jid+67molgBU2V6O4UOcWnDJb5YXeWASrqfJxbb76UMUY3vLueF88/LzvWS4Y66p6kO++97lEmDVAh6WzHzXsf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093181; c=relaxed/simple;
	bh=H4/a2FSLp6LftzLUGcblfYwZA83RFZuLFIgwgg2u2sI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eZjcL8tmBIeGlHvqePGuL9N4Pof9uoNufmTiy0Bt1pNG4KYGiPQPxCF44bmz1kReM7lnuXf6Gle6l4siF+ipIlWn6HHefWUPgzcqxawCYxQh2Eu8KNe0vNQTq/9oaVg0MplJdH7r3vo61X9TMWXHI5RP1awiKyKEEXa7VMXTego=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=0riqxX/U; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="0riqxX/U"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-7fc4034841cso374067a34.3
        for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 19:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789093178; x=1789697978; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TjCJlPgox13ci9wZODwir0wXDgJXmVn3NLpLwiyNJAM=;
        b=0riqxX/UAUtTniODmN2G6zygq9+FqPRC1qKSCRrOtw5dKBNcASLkBgS9rgSIaSq2R1
         i5yzvzbawqm2Vb2VOOiYP/k7BiI876XmHrjor9S87qM8XPe1+BTCUqEF+MwBubSHl/CF
         9EXpQW0iNdVgnBkWcxGWyiqQfz38sgvrIk787snIMuzWuMb+7qAbCObphBAFT+7GxsfL
         LVfcX09fuHq2MXgfcaOSe3cY+3fBwm6zMXTS8d0luGVRj/an4f6aolzjHMBxdhFc33RY
         UBgml/sDtCl17nZ+T9Syx5OiyLossbyFLU9dYKvlo+Mm94rcMLlNDCvVIcpK+1vJOlfC
         G7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789093178; x=1789697978;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TjCJlPgox13ci9wZODwir0wXDgJXmVn3NLpLwiyNJAM=;
        b=BbzDdFewZq4/hTeihLGk3jxz5t2XPbMyvwAwFYWKDJ4pxhqaMxdehV2lavQr9+Zigb
         UceGx9IcB8l/AX2qnRIw94k0Zg3W3zhjMnCcAzWuIM6QmfUFAlCSQkKvR5z+JVlvrbPf
         5vP2pWJB1+qB53sYrZnf+BDdjj22OD+Y+lPMHgLhlJunuKQ5BHGIkjNsGaXFWNsIMs6X
         +7ZtBekgNDoI/fwfPNuQnOQU8Y5Y458omQUG/erFub8Yp+7mHemdwhls3R1PgDLEvKnq
         uz2Sv9MA+vZ2Fr9hYB9xtfqbdZFBuzz2le5M7E3ZD3/HR+aFnevGaVX6V8GM+Q0ZXL9e
         ac9g==
X-Gm-Message-State: AFuF++kjMImsWFl2OqrfTzkT3CEVcjdZBR6kAzCBl7BvHMsqf4WosJdb
	pDB+Wzaf+HeauzF1w8jLggjDzm585elQ6e/xBCSvZMMm1vu9PSM/EtJ29ZEzEMZnWV4=
X-Gm-Gg: AYBFou05DtmL9Mcndkjl8bBf655eRDmRZ+CYI/yAJENUVkKoJ84Tg0faFam6MtxEBpf
	ooHjmEBVT2+IW+2gPZzbZDjmHInQF4uVpJmHnB/YV4rbmFvCgOSrI9jmRy3uzYM3uawXaiHH63o
	merfwxKejjYbFF4ClkYTuK6HUMGKAM0ZPOPWPQhuGkBnPVKpH3QsfmC+YdaM5Q1bfzVJjbKhpKl
	hQgeVGGIiXeRi2U64RjiJRCG8zd1bsQxavyqFhaHj4YayTAuQlkSPCyJzPDxnR0XiNOrCHLpvLe
	faZHqqhnu1zC/xryfhQL+DoF4neNPsdbHgppgv+yxnySTOLVv00NsQV0IaiJfOVvFEcxDc/LZKK
	oBwDc06P0ceyUGR2bVzeRSgVNQTa7BYBLOZ2aWKIA91J788hTVifGGjGlWGFD3C2jc8qT3HaOz3
	6SidFse53OfYafMa2rhGsAmX03c8LKd3CBchUtxGJ2yJXowHmfo+C1f0puqTbS08FwCbLl2e+O1
	Lrv4Va4K/zc2UUAbk1toQrPgnNulmSyi3qxYNSAEfhQAtnQbME6
X-Received: by 2002:a05:6830:4c0a:b0:7fa:5c49:523c with SMTP id 46e09a7af769-8040197dc92mr1421635a34.21.1789093178227;
        Thu, 10 Sep 2026 19:19:38 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80477ea9138sm62573a34.1.2026.09.10.19.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 19:19:37 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tom.leiming@gmail.com, Yang Xiuwei <yangxiuwei@kylinos.cn>
Cc: linux-block@vger.kernel.org, shuah@kernel.org, 
 linux-kselftest@vger.kernel.org
In-Reply-To: <20260821103047.369522-1-yangxiuwei@kylinos.cn>
References: <20260821103047.369522-1-yangxiuwei@kylinos.cn>
Subject: Re: [PATCH 0/2] ublk: fix force_abort leftover after quiesce
 recover
Message-Id: <178909317647.514375.14568781884849195816.b4-ty@b4>
Date: Thu, 10 Sep 2026 20:19:36 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 21 Aug 2026 18:30:45 +0800, Yang Xiuwei wrote:
> Quiesce on a batch device leaves ubq->force_abort set. Recovery does
> not clear it, so batch fetch fails with -ENODEV and the device stays
> QUIESCED.
> 
> Patch 1 clears force_abort in ublk_queue_reset_io_flags().
> Patch 2 adds -b coverage to recover_03.
> 
> [...]

Applied, thanks!

[1/2] ublk: clear force_abort in ublk_queue_reset_io_flags()
      commit: 8a14be55bdc6d5a25cd7b0ac5d4d884fcc727b49
[2/2] selftests: ublk: add batch IO cases to recover_03
      commit: 94b1a3ca9b8db3151f1416263704c159a9470da5

Best regards,
-- 
Jens Axboe



