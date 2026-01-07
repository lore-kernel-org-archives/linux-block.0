Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB97B27991E
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767798501; cv=none; b=kcp5UA3acviYVEhO/+BbmGBL06to01/07oP1Pj1D9rce2K4ea9Uv5Pd8OaqC+IeQ/TaIwd1w8xHdTvW2TjW2dOev0MSOLARzGtT/oh5yWq1390K5/9tfgreNF9mRNZ36KACYNeQBTVfp0Vpu+gddiZe1j/+wb5j+79E73hz7Zoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767798501; c=relaxed/simple;
	bh=QVagYrAQRIEHIVpcrmGOuKbIN1hMl/g6ajzwMyjoCkw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j7HG7RQDXfbAG5JST8G6H7VHX6OSOHEHjeCjqkG1AruIl3IuXIYXW0xl27TZrDSUyXBoM7FEiH3w1kqCV6LYeysO4nqx5VJV8W/7J67POYFzZEzr3JzIGhcTOsIpLJ1MKUefv7E42e+R7SHl4d4Ax+qzOneFVukXyPZlB91ymOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PYiNxJwW; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PYiNxJwW"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3ec6c10a295so977446fac.0
        for <linux-block@vger.kernel.org>; Wed, 07 Jan 2026 07:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767798497; x=1768403297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QcL0zLb8Fs6bCDuPAPqqm5TibfvMeqN45Uj6eEQBap0=;
        b=PYiNxJwWy0t2iCtk6qdrv373FD8pujEwIpNKiHutYHDwmt6fdz/amqJst/ZllEI1Qi
         WwoWGZM9tZhSQEwfsoQIT6K/2TV+GYB64TXLovm1C4ddAQ4YUZ6gQL91PePa1aVe6a8V
         puA7A9kttqmo+LvZanKY3lb04boNNHmImwrsZzO14v637UvoJNDKtzJy8IQryX+oUTwa
         eRiu8PpWPcXKs0jh7YxoAuu7umMHFt++hFZ/Y6V2uKRjf9c+0nkfj7FytE/A4fY1eRVA
         vom8oJ9EK0KuPPewm9nNPLlBMKxljdB94vSj02updEBzpnHo3X8jQ4Aww7egWfPJKU2Q
         4THw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767798497; x=1768403297;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QcL0zLb8Fs6bCDuPAPqqm5TibfvMeqN45Uj6eEQBap0=;
        b=n/a+uPbOUumsmFupT0MKGLMJdo6YmEJGxeXCseX0fBkGpGOALnXCOlVven88O28bLZ
         3ZjE72kocN3R82bCZKdSUoitAXSKYK/8Uev96bqBaqneJ3gaRoOBH9T8Xs8hsUHKvoLg
         y0jG3vN6T8afhdiGXgiP+H0D3qetaZ8shzGiAwLNxP20JuKnNPYOGqNZtkTUT9smnwQG
         NpTt1/JBbE5LLn/3zMrGXcqT922+mIMKGKttK9mHhR2Id/blAW9wAJnOqr+wWXV/nZ6w
         R0KmY6jrfxkRZL5ym2Zl2NGh/J4iCbTm6qEcdBaEtemG2il1yA4FgbxS76gtW6xork7K
         aODg==
X-Forwarded-Encrypted: i=1; AJvYcCXg1Eitw9qrloZjuUzWTViocsctArJjR1L8RBe3CHzXFs9oFzHOWddIiCWmYfxm428/B7iI8PlRNM6Ckw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ7UhkGeCiVfAv52fqPkVHHPEFUFZlRF6Q1sNTfoQRYAJVQONV
	/6BVV45niGxIdRuS0mZmymd0WTG0fmNZExBJ+KeXnj3D3Nyfze9ji9EJSPXOduSrMLmBosP1WIa
	9gw4h
X-Gm-Gg: AY/fxX5N12PMZH6+dlOQmKcDvwiA2o9H86GbYJDppoQi4gZr+qWoxVVDFOLAx/fU8n1
	jqB7J+L1Qp/1OP1INR5rfPglbGgky1S0Onm+15RVCWx8BKawL+jYBj9uOfEgR801OutFZ3dR9iC
	cSUC1xtmRP8Zuf1EmLj/9G5Try/95aRJQ97qtM9Hbl0YW4ZOZEqPoqeai0C7upmLgWIpTF2bRFJ
	6XmdaHxY/LNM06nm24YGykUro86IoXJjIO95PqRXOs4u/XFnkT4qg8IkzREnVvd/5pG5MxRDEpe
	mvMhD1wZNepST/E4AaWpwJFg2KEudt9aSwlrjELaXRvKYfAvXv1dsC9lERlwIGu2HmUYTQRahNw
	oYIlD3pjtNLj55KFn4giv5dxngwoak+9uzN/6OECxOUXtSl1ykeRGtJMjYloAnse4j/7lVXq73L
	Ykog==
X-Google-Smtp-Source: AGHT+IF3vF4zQeY1EQTe5QAw1AoIyVjaTXi3JNkkmOtdTPo6wxUwFvKe1Yb5+ZkB44+7SiboMjoh+w==
X-Received: by 2002:a05:6870:b14c:b0:3ec:5e47:8553 with SMTP id 586e51a60fabf-3ffc0675777mr1402840fac.0.1767798496853;
        Wed, 07 Jan 2026 07:08:16 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4de8cbfsm3299436fac.3.2026.01.07.07.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 07:08:13 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>, 
 Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <cb9229f1-5472-4221-89d4-4df31bee8488@I-love.SAKURA.ne.jp>
References: <cb9229f1-5472-4221-89d4-4df31bee8488@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH] loop: add missing bd_abort_claiming in loop_set_status
Message-Id: <176779849219.38479.1276566740035299097.b4-ty@kernel.dk>
Date: Wed, 07 Jan 2026 08:08:12 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 07 Jan 2026 19:41:43 +0900, Tetsuo Handa wrote:
> Commit 08e136ebd193 ("loop: don't change loop device under exclusive
> opener in loop_set_status") forgot to call bd_abort_claiming() when
> mutex_lock_killable() failed.
> 
> 

Applied, thanks!

[1/1] loop: add missing bd_abort_claiming in loop_set_status
      commit: 2704024d83fa9eb8e5f16925aae340fd9d246694

Best regards,
-- 
Jens Axboe



