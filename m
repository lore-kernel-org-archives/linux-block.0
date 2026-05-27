Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC0F407572
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892686; cv=none; b=ZlojHsJuV/fA/qXdzIhiQDvxCaZjKltTCPo3P63C28382e4vHle90b5Xl6Y+dUCqeDCV8XNQ0B42l7K8K3rVGTm+FIi0gdk/cixyB1VkxQnZXRgOEUF1E6bX96DyTZL2ZSCSAzlTmUPjLXdf7acxHvyO5SIbpisSltY3r1zu8F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892686; c=relaxed/simple;
	bh=/UrVToUCN1/dFd9xlbwyZOXPSWDC8n0F587aoKesJTU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U5/kqEgMH7spyGJK+Ip2a94A2g22q9WAcS18sGuGtdexEODAlKKqjulSGEkAGEjfNysoB8floQjtRR9bDt03JS87OyWRAOV7+7NVQMAudzCDm3gQLQYU3iEqPhj3x3ZHHy+RrKUpo0UB0ltKIFLR8FX54lMVlanJ8ogMk/XrcN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=TYMJkmNK; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="TYMJkmNK"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-69d8091533bso2393551eaf.1
        for <linux-block@vger.kernel.org>; Wed, 27 May 2026 07:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779892684; x=1780497484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqdZyQ8TepaAQlegTcjHUyFuT9L+aZqIlpDGn7XrdU4=;
        b=TYMJkmNK70rtnNf3wttlrWdJb+7NUATnxHQJfA0604qnUOv2FTghGuh6vG+Ny99M/E
         F2tSyQEPA8GDYJVs/eVrxarcwqyyQtebTC1+mJsNt6Gb1vPoOSK23ArTkAohrHdckzxG
         IbJCci4RbkYGy3/oJW4w5AI6rBlUvJUtHrKGbdS7qZlhnXLr0dfu0Zk186XKrdPtTfAA
         /GfysEW0nA5YSw/PtHi9y2x/5Ncq6t8NgztYflIZBsE+jUpKxnoHPS/VZkCn/NwmExWu
         uiJZtVrd1zGnHouLR6VxYn1I68KgH8ZcveFMpBBOKqjwi16j/+SsuppiH62mdzFVyx8S
         AZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779892684; x=1780497484;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KqdZyQ8TepaAQlegTcjHUyFuT9L+aZqIlpDGn7XrdU4=;
        b=RzNxfSpwGGcnvRMBbdzJrQuiaX8psW9k37IlC7x9cdTaA9i+tOTYC84N0ueGeb0Edv
         2LGnrE8Js3DtlGXMdRpRgDZrYS49TEm01zYjYwpLLvLuZ0HczMljTNC02+IZdIanxgIP
         nnrnz06p11WnRRi7qgpeR17EdzC+mCHen2ETkh9+IKJ22U+G2vxD20+7TNs8PmtlSgFB
         xHwmIvxnuUhlwHQwYn+y4c/W0Q9m6gBmp4CMEL4tdJWTAy7BAADNUSi9tFzLf4bczGs4
         hlHdcsMIpZ47BIGzdUCPEngBDK+BAOOfRbpfbkubChTelX3dSQmrNdY/anm+N6n82a9k
         qfcA==
X-Gm-Message-State: AOJu0YxcOcs1TQqqljmJd55vdj6nkTdjpZrcDIJHWpN/pWxv6FtuSEOM
	Y3Kl8JVi8vJFdWl0S1V2EdCMuUDdqSnRzsV4DJ6N6Bbv8fO4V3X/L+2bZ6WDBZ1s4/8=
X-Gm-Gg: Acq92OHzQKSUR6Fz/A9pWTXQAz7FVzU788thEuraFXxDgqbUMCwYfXVaebX27A6PLSn
	dmUXHF3KZ8zwAvxn/x4QYviFDZJRemWVs3lHG1jMFf5qCa7nXlp3mAePG6YgahUo8uT1m2XFbVN
	oLW4t88eNsSgvCHgVmA/e+Cl9VoRRgo1zj6zV3ZBwu9tVaAdnT8CastZMDTZ8HdE+RRq3bGxOVm
	PgfLJtbymw1sGd4PCl1Abe+BMGE/FUwe0TNLj88JUU2f7dHOa1Gw3wCxhR+S1lNxJgTN0BVLp1D
	XBdlTbE709V05YhzihwMOBodoCYpHdAWGfl0KDNaqdfmeKhXOYIJ4qEJgfqHJ+dCO2pquSspzQJ
	ITcvkIU4XBy6ZYp61uycrjJ9kKCT3DSto2EfrQc9jH8ogtUUeRYQgCArUdT3xF0sE5U/f27Hgxj
	a9uCkFRMf8xrJ94wvrzxVNHdk1p8Dvc7RNW77anCrbNi4cNgMORLpUdvct8vtRzdMRhx/bp6bpM
	jA=
X-Received: by 2002:a05:6820:4c83:b0:694:8c46:e2c3 with SMTP id 006d021491bc7-69d7eb6b527mr11938897eaf.14.1779892683791;
        Wed, 27 May 2026 07:38:03 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b6351a772sm16950878fac.3.2026.05.27.07.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:38:02 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, josef@toxicpanda.com, cgroups@vger.kernel.org, 
 Tao Cui <cuitao@kylinos.cn>
Cc: linux-block@vger.kernel.org, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
In-Reply-To: <20260522091530.1901437-1-cuitao@kylinos.cn>
References: <20260522091530.1901437-1-cuitao@kylinos.cn>
Subject: Re: [PATCH v2] blk-throttle: schedule parent dispatch in
 tg_flush_bios()
Message-Id: <177989268208.742656.5047337286671399342.b4-ty@b4>
Date: Wed, 27 May 2026 08:38:02 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 22 May 2026 17:15:30 +0800, Tao Cui wrote:
> tg_flush_bios() schedules pending_timer on the child tg's own
> service_queue, which causes throtl_pending_timer_fn() to dispatch from
> the child's pending_tree.  For leaf cgroups this tree is empty, so the
> timer fires and exits without dispatching the throttled bio.
> 
> The throttled bio sits in the parent's pending_tree with disptime set
> to jiffies (THROTL_TG_CANCELING zeroes all dispatch times), but the
> parent's timer is never explicitly rescheduled.  The bio only gets
> dispatched when the parent timer eventually fires at its previously
> scheduled expiry.
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: schedule parent dispatch in tg_flush_bios()
      commit: 6235ea3f8b8ffca0333ade0863992f3cd69592ea

Best regards,
-- 
Jens Axboe



