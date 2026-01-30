Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CA935CBC4
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769785962; cv=none; b=g3SYUu5z4PvAQhC3I+CAf0I1LHdCZjF57yvDYY8i1FlWDgIZQ43CEdRKnr+kch7kSR5oZvv2J0dV2CEs5sJizA19DNoVXTuuOsdNbc3LCfkOyeD/G2C2TYY5Ir/RklsaOTDM0tFkPBaPuFk7dLP5wz6ynrpvrm30QQQCNtrBrmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769785962; c=relaxed/simple;
	bh=sVRIbLRLm2gdKVdmxMHiNrrjFKokCmeAu5KAGlszTcs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QQ6+uX/iEyJwS4W6rZxEtrTSYMS+QV+pMM9Es7qYdBr68L/LmexbUg4tRswWmF7aLKeDeXNJvfpoIHrHcJtEtc7OEDfn8c0tm0OOfnF3VXA4msw210SqJ4ZvrxNE2KyqcaSvdw0AWMmIqnan+LBDxJ7IotkzWbUMGfSAd9HUa6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Zj2VVCgO; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Zj2VVCgO"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d18a9d2b1aso2206529a34.2
        for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 07:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769785960; x=1770390760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXoX3vnzmebVZOm3CUt6qKUyHourmARTnybZ8qjemAw=;
        b=Zj2VVCgOx5+BLUt3wOEOf+8cVRC5q0SyyeIG1Y/GUwngcBPVAL68HWAdZlC8cOgLe5
         DVQu5M5onKVsChvQ4kc2daU5YiEeH3sc2XZjBu7Cbzu6Z6rTl2MUZA17puYLGBuZ8tcf
         lCriotUSNfVJw9IKFWn+ZQVmhfk0CmAJLEVaodlJIE1xzflXv3MOJK7TYr5/kleD+o5A
         i3sdSp1C8JJ7Rg/cLTFokts0sBqpPWNp3CdXj95WWoIcc/9mNLlwGhVVJcJcwDSUrroA
         L7vGc4XRJvfybn3P/11GsMxoghxER4w9G2eGoAHVLe82ZPO0puBWEO26RYH1FCtxbGHj
         bQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769785960; x=1770390760;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eXoX3vnzmebVZOm3CUt6qKUyHourmARTnybZ8qjemAw=;
        b=qJNGutpzHUnOf4HEYefLWmFzIWwBlY9cyi5UVQnndngu/KB7FdB2jmLxMoyMzvsN0D
         6CS2yklnFNkz6p8rMQ8POe7jSmiS7b8HT3c8ZCkDBjbZix6MLEDo7H/kXni7ZA9huE/Q
         QJ8Gxb1SOJJdk0nOydPpSR+Fv8b80dCx9ndNSKoxyTjo9bLKYRUrpHlNl2gXtuM2UJZV
         SZqRmCJHY16Y4IViMoX8GBlXLeGz09MQ/Q0v25Yzsq6/ZyPxPddAIOZdkdvVDc5Xqbb9
         HUZyvh1oyqNB4r2sdx89pApa742tSvpSVyzT369EvtFRkDMOeBJhWEwL7/TDR9b/ph6h
         rDIw==
X-Gm-Message-State: AOJu0YzPNsTeWzy0HbFik8YMbEFjPuz/BZTBKYlk2TGVBbcrd6PeUX76
	I+SRK+qn+5D6ZqyhcRappifnu/tNQWl9YCwkP3UU1EOZrE2KxzBP1wMpTTQpG6IMO4g=
X-Gm-Gg: AZuq6aIsQHhx+ztNfgMJUnLv7Qiog7mC/WWkcyABTSA0tAr7tl5+PjmRZH9aba5DcyG
	2IQSCSd5KYfZjjsavwM5+aU/Cr4jFDmsNlz0olmOwnbc0M4X6fzkMCvVqARy9lteZ20WY6ST4XP
	HUDooKD2wuCXspfUQGrlQOJF0m446Bl1wZZtDu+MdmATUdwqbJybWGz4jBhf4qdeYhNobwYoqb8
	XVG2V6DSAFltKOp8yKCESmIeDeWHk18YmlWu70JbxnZ/eMOBP/rPfbX8N45vrsyhOtUwXb00/Nr
	NpiQ1t6xuaSSDFAv/SmrUz3EIOz997IzhXVlKKZ4DsZK3bBgppVYqQ/94RoqKqch/+DjhKhT0HX
	BX92cXAojDgTZfKWrcsLtIhVFo5EpnaCVFTKuauuUm2vWI01qE+KwJOUZ1+Xx3VLOyZ3B5bTyYD
	eFRy8xM/XSvv1xhxoVRPnnrjzk6UwJPHnCvP3onaQXZlzD7jRqXq8CdoPEDjsA1an2OeKzYwILZ
	w==
X-Received: by 2002:a05:6830:3498:b0:7c6:aea0:3382 with SMTP id 46e09a7af769-7d1a532b43fmr1876606a34.23.1769785955615;
        Fri, 30 Jan 2026 07:12:35 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c69e632sm5685845a34.10.2026.01.30.07.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 07:12:34 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260128205636.4003327-1-csander@purestorage.com>
References: <20260128205636.4003327-1-csander@purestorage.com>
Subject: Re: [PATCH] ublk: restore auto buf unregister refcount
 optimization
Message-Id: <176978595418.809940.7908857788281671989.b4-ty@kernel.dk>
Date: Fri, 30 Jan 2026 08:12:34 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 28 Jan 2026 13:56:34 -0700, Caleb Sander Mateos wrote:
> Commit 1ceeedb59749 ("ublk: optimize UBLK_IO_UNREGISTER_IO_BUF on daemon
> task") optimized ublk request buffer unregistration to use a non-atomic
> reference count decrement when performed on the ublk_io's daemon task.
> The optimization applied to auto buffer unregistration, which happens as
> part of handling UBLK_IO_COMMIT_AND_FETCH_REQ on the daemon task.
> However, commit b749965edda8 ("ublk: remove ublk_commit_and_fetch()")
> reordered the ublk_sub_req_ref() for the completed request before the
> io_buffer_unregister_bvec() call. As a result, task_registered_buffers
> is already 0 when io_buffer_unregister_bvec() calls ublk_io_release()
> and the non-atomic refcount optimization doesn't apply.
> Move the io_buffer_unregister_bvec() call back to before
> ublk_need_complete_req() to restore the reference counting optimization.
> 
> [...]

Applied, thanks!

[1/1] ublk: restore auto buf unregister refcount optimization
      commit: ad5f2e2908c9b79a86529281a48e94d644d43dc7

Best regards,
-- 
Jens Axboe



