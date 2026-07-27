Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455D0425896
	for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785172148; cv=none; b=ac6DOhmj/CMhFjUNuiWKMHXxg5RehJp0DRxg1ftUsfEOrZwvYQGmEO+as+ZPk4HAmzG6vXakU2TjQxXsYM5X6L7zIbM2p1Q07JyLbK0Wh7zZOxbSoHd6Yb8SudtyQpRJZ5RUzxpjnRNHBZhZLItnMb1zse1q1Y1dXdlbsroBIQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785172148; c=relaxed/simple;
	bh=FXdp9OQo4ALBepWPdxFlx1eYESgmKpUpw3e2ck8BZxg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EGnNT2JyPgtLSABmlCtX5lH1oEMsdUGXx6Jmh+3XSsToUi8AWJ0KT0IdEMn5cEKIEgq8Yi6xy6DZnkoD+c9TmTVmZpt8kgnepZFFSP5CJQU8n7b2MqCRsRtGophKw5tgJd487k6CSE4nqOwnlzdMbIKPU5xEpfs0K0BaR5coFYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=TW3ia6iE; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="TW3ia6iE"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c2149571dso28469951cf.3
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 10:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785172145; x=1785776945; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4tN5F81l95SRX0lNSZtF4N3Sk0HbQflC2AEM0fGaV70=;
        b=TW3ia6iE8u81oSlFifjhwmq4TPvvefQ2Udb01Q2//3fHHVrn+KpNyXAlWa5GzQxFb/
         aOJQ4CJ0NMMcR0GhffNIxztiyYmhJNI51EsHxW/OyqTllAMWGbZjPpqYtsiHSjhIVOZl
         jDUvdmeYgToLvwJaGIsjq01s/xz0HaoN37lmUOfYQ0n/uZoH4BPli9APp4mJPluHbN6A
         pVtHs/vXjPMDLbnGIHjbPUAMHCurp3FSdE4SE6opWCX8yhKjBxWDGsC0T03bRg7cKXEv
         z/fb+eYy5NdmfmyrSX+b1Y9Q0sfqi+p9dddaJZzOazZKTCBZ/KTJqbPvoahJ9VpZjR31
         eGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785172145; x=1785776945;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4tN5F81l95SRX0lNSZtF4N3Sk0HbQflC2AEM0fGaV70=;
        b=KWD+nfe/0AfW9CqXzHYH+4a2BjIElKfC3c3+S+g/w5UalxzVf69UbcmLibptHBn/fJ
         xsXoK8gdMDANUz8ukxM86MyeezCy4xI2NOh41aNN8VVkWJFg+9itH1FmzLR9ZCKzEsen
         nawfpV2P2KujU0FKx0fhG4y6iOzsN+xFUdImf7EA0VSrQitInbwb3sZD/FHm8DE7+BAa
         WaGYYIJ7Sa4h13kGJDFDGX3JZiL43ZwuhxyXIV8zYTiAW/nOlisfxanqhsUx/NZAeA2x
         hSGnhT8Ex+F/fA6FKiuclA3I1lIyXRlMl/HHSQ2d2XkVIFOV5SzgFB5nxfbN3BmDBgbO
         iX6A==
X-Gm-Message-State: AOJu0Yw9hOsCkYyDEYbI1lv4X08UKiyf8+Err0xLMQAJCwsEIjZ5PUp+
	CkodSfEtmC0whE/qsbhEkudi7c/OZ2eLK0u1Z8bQzVqJmv1TpJXNYbDL02ctTEo95Ew=
X-Gm-Gg: AR+sD116xpPEZgdyllv1ev97nTm1X4dSbpnLr+Vc8onNRjx3hT/NuNVpgdSuIFIFzwd
	7B4vI0keg1I65flUY6WIj1lvrB6LlJZTYPPNYalfmScGWAm6hvI37ZqD0hC0JoatBRIim2ouk75
	9k2bxksqMqbkMcc7Yb7q2cECJV8j/aGWkImC05FpS1pSf+SwkfUMm1KgdiVQDQg8U7+DK+S9FRG
	l7KtaulGQpdQcTrEI0gN4CsnWg6sYJBBT61sjZCkeLbbnR6PZuleSLnOg4EGHOsgf2C87nMZkgL
	GRisRKmo/a81vjUwC74pGFu/GmJpNT36g6ERSEVR6/YFpIZG2oKSAMf8qAh82tSixByHEPp5UxZ
	oWqXKe5UuFTire+8I9/NJCoyEFawx9EY3ta+9utNWOCdPyvel2Xmakqe7nKN124w4BOdquH1fUI
	wz8i+6bkiPlbz8aOtr1kiwK+4kw17tUHDiOjxBX+h2RTaQdmCdWPU3pIA7
X-Received: by 2002:ac8:7dcf:0:b0:51c:7b12:1211 with SMTP id d75a77b69052e-529a8754649mr97926101cf.79.1785172144843;
        Mon, 27 Jul 2026 10:09:04 -0700 (PDT)
Received: from [127.0.0.1] ([65.202.22.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529a2a0a7ffsm57646871cf.26.2026.07.27.10.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 10:09:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>, stable@vger.kernel.org
In-Reply-To: <20260726145025.1507383-1-tom.leiming@gmail.com>
References: <20260726145025.1507383-1-tom.leiming@gmail.com>
Subject: Re: [PATCH] ublk: reset kernel-owned dev_info fields in
 ublk_ctrl_add_dev()
Message-Id: <178517214380.2192703.14950200230738719801.b4-ty@b4>
Date: Mon, 27 Jul 2026 11:09:03 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 26 Jul 2026 09:50:25 -0500, Ming Lei wrote:
> ublk_ctrl_add_dev() memcpy()s the userspace ublksrv_ctrl_dev_info into
> ub->dev_info and then fixes up the fields the driver owns, but misses
> ->state and ->ublksrv_pid.
> 
> A device added with ->state = UBLK_S_DEV_LIVE passes the
> "->state != UBLK_S_DEV_DEAD" test that ublk_stop_dev_unlocked() uses as its
> proxy for "a disk is attached", while ->ub_disk is still NULL, so DEL_DEV
> right after ADD_DEV oopses in del_gendisk().  UBLK_S_DEV_QUIESCED plus
> UBLK_F_USER_RECOVERY dies one step earlier, in ublk_force_abort_dev().  A
> poisoned ->state also gets START_USER_RECOVERY and the char device
> read/write path onto a device that was never started, and wedges START_DEV
> at -EEXIST.  A poisoned ->ublksrv_pid just makes GET_DEV_INFO report an
> unrelated task as the ublk server.
> 
> [...]

Applied, thanks!

[1/1] ublk: reset kernel-owned dev_info fields in ublk_ctrl_add_dev()
      commit: e65848e4ce352bac9e3465099354c8b8f845391f

Best regards,
-- 
Jens Axboe



