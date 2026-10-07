Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BEB4D9F88
	for <linux-block@vger.kernel.org>; Wed,  7 Oct 2026 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791401030; cv=none; b=VHuBBwUIonqbiYbOnIi+5Zw6orX9zti3cn99eaxGf7OZI6ptaWZLRp4uRjkc2M7ITzrGJ2pCs4xzzweSB5sWVgYpSeopMSh4I6rhLKuhU/8G7yZd2Dck+8k0lpDvtmDTl2U2YqSK0wzC/y7ylAqZY7co9IqXg2ikr/wwOeni8vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791401030; c=relaxed/simple;
	bh=Y/YJ2pZCGx9u/s+xQBYfaDP04NWZxbzJF9hiZPjchc4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DEqPAl1uW0HJfbPBsxV9qbLQ6ZEaM84oRKV6jdddTCyZ91P9AoXgt3mvI5cBMobp/kFhaUCUB73gT83vgicaXN+eTAS/ZF//Fi3km5iCwS5gqCmO0D7KdZV/SOXGeuM++HxEn4TPz5fbZCLCsYrYKzdsF1i8/S6cF/9jfBi+i9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=sFHJXTiN; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="sFHJXTiN"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-144f79153f5so1792228c88.0
        for <linux-block@vger.kernel.org>; Wed, 07 Oct 2026 12:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791401028; x=1792005828; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RE39zueeiSHdMCMyMQenTlKwDLdMoj4zEmgv0Dvbh88=;
        b=sFHJXTiN2AxdD7md4ijrOGhq3aVkniAryea3gnvinLTq52Gb0XQzTcABk3VWNxRBZF
         BuXAuqt9Yv5NCbqjV8ERLvnXdCoukRtp4IFllksygayTw7YljuFjb9VUyQCrLbwf2X8H
         rwh1PRurhuyxIHoxnfuCCb5CJI8nsN+9rhpo4xXDUpUK83FS9VM2M+TagbXf5+cdbU6x
         eYOhZbneo8Jt09ufNfEhV94WHlmWQzV6SzdtglwuqoQiSqvvKLdQyAUOLXcVHZ73aGRI
         USbfmcJdpoq46E+wGLiO2YRnSbfBsGJleqkf7lsO39TPwNloXqy4DIsjN3CXJkr7oklN
         excA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791401028; x=1792005828;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RE39zueeiSHdMCMyMQenTlKwDLdMoj4zEmgv0Dvbh88=;
        b=1G1aStmALlvcHK81vB8IWbsd/wtsa2ePryajC3QIdiyda5hWtcPTMKeim/QCgTEfL8
         I2USDess4RX6wTUdzpEVyib/yQRzLWa9VYospKeTxT8URyM+lZBEyGmIKxTkHHVaoStH
         /8y9/+5SrytK8WsmIKyF42/7zMRptujdomrpkgstAip8BVoUpF8eXFPgkDgFoI63SOIy
         V2aCagoF9y43rkfCQ8UPJCIOQNg/xEXYBIQ08oV5K4+8VoDGZWm7pXXOUEw/vA9Rio8x
         ZrmykVf2eK2/wfz5aciYR6hPtSDXy8cfnYAotwP18Ql77GDvbM9r6Hq5HgIjBJ7vmH7Z
         aoqw==
X-Gm-Message-State: AFuF++mTvmCZvulRxrN+OEjn2Ig79HArabLfSTwPG7NwljAUNQM/G1m+
	fFLlGFtciLeBRLih3I3Tj2Ctrq54v7t5ATkYLFQdu+cvLB+5lutKe8ABaLLHgJs1+aTNR06b9Kp
	CJFvA4mI=
X-Gm-Gg: AYBFou3GUfDhr/6EoVCk3tRwCsyHWUxMjB4yrDYh+C3bCR9LeWWXfsms+Iu77aChH9Z
	y+hWGQwNfojZdcJOMTf+pwvCgVGa0v2fZDOiqEtkyrk5IYqfiWKwuJ9Pdy/1HKDVoahjeBPBwJT
	mTozosenXnP/9uVhP+27RvO3Lz+bxFrXJiNOTC6k2/8AITl8TZTuf7qxr2qp+MrNodPD6aOcdtv
	dh4JUj13LlSoB2uma4gGo+ye8yk/cMRs36ipp+jc5MiN+h27nf9A34/j8opAC0JJNA4qXISV25K
	zrkAOCppq0uW6kYBqYcs7XPCL9uWPyqiPXJRLM5kJ+mfoMJ6ZpwW/wthOmrrDGqnhN32g7fC2pV
	6CEpgGZoWF9Gb/AFUYWJL6B19x6XAH52quZuD9el/fCoTTkwDCkENXLGGEnabzTTLgZF+xCcu2u
	Gwy288eTDGTs0SUTrL6U3MOqSP3kS/cGLB24exqBx5i0EXrQE17C1iNNIwTos9oKEKWVAMnsetT
	6LphgBWvdMJUL1l5QAIeo7t0QWfp54D4XyYU5IzvAajz99tvFb5G4lNNQ==
X-Received: by 2002:a05:7022:150b:b0:151:7831:e403 with SMTP id a92af1059eb24-165a107a5e2mr204600c88.13.1791401027516;
        Wed, 07 Oct 2026 12:23:47 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16166216f39sm10538896c88.6.2026.10.07.12.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 12:23:46 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Justin Sanders <justin@coraid.com>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261007-b4-aoe-short-packets-v1-1-db5155f7bb9c@toxicpanda.com>
References: <20261007-b4-aoe-short-packets-v1-1-db5155f7bb9c@toxicpanda.com>
Subject: Re: [PATCH] aoe: pull in the headers each received packet type
 reads
Message-Id: <179140102638.379040.10375002764067840013.b4-ty@b4>
Date: Wed, 07 Oct 2026 13:23:46 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 07 Oct 2026 17:52:29 +0000, Josef Bacik wrote:
> aoenet_rcv() only pulls the AoE and ATA headers into the skb head when
> the packet is long enough to hold both.  A shorter packet goes through
> unpulled, and aoenet_rcv() reads the AoE header from it anyway.  CFG
> responses go on to aoecmd_cfg_rsp(), which reads the config header
> after it, and ATA responses get queued for ktiocomplete(), which
> skb_pull()s both headers.  Ethernet pads frames to 60 bytes, so this
> mostly takes a virtual link, but nothing stops a short frame from
> getting here.
> 
> [...]

Applied, thanks!

[1/1] aoe: pull in the headers each received packet type reads
      commit: e1274a6bc40a4618f6fbaebbdc51cca865d51bed

Best regards,
-- 
Jens Axboe



