Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D509283FC4
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 00:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110365; cv=none; b=nR1bwTkl9yNBt/wZqybvwbpEYGqeMgMw9YafwIWfyKlEj0dHcf6oN7c3I5HdgI0IYbhPoCMqa8JSJYlQyvrW7DraFDeT/TxlkCmAirIvx4wUPNtzEpERuTmc8ZDcfWNoFgf9F4Xs0un7lPsKWoZBr6OXCI4yBfghvrP+aharGcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110365; c=relaxed/simple;
	bh=VVHJvToiSv0Qj9MmIjQY3/1H62GZzD8cehQmtHUEY6k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ae2CZFAuNd81FXs716qF3JRhpbARtW2rLRsK+2GUQIxQfLnRQSfc16Q/4hgJDqDWjy0/dwYtc10tNGT2S7SVJ4jOG0wnqaU0ELthv2HXD8aWbozViwjN/+dPEwO4xBGlMthPoCIxRW5Rf2zAY21SEQ8Rv7a1+YfBt40UeldH384=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=neQCYNdn; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="neQCYNdn"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6f8a519e215so510755eaf.1
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 17:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792110361; x=1792715161; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iX2M7P0FJXo5H40qEueYVFWq+OgK2G9wQYuxMssplYg=;
        b=neQCYNdnwEMRShife12WUcnWrZYbkyVl5/UNlWZl3D+fwrL0St6EdkWTW/gqWi3cXH
         bZW6AxFLOjG1eB72FCR32XfjRxHLq2dHyeQgcgDPeDsUZkPLh0GPCz4wmBbm/F3dowSO
         rZlL1FB2lg2bFmjv0UEkTV0zxRSxMGwv52Qe33bv5wEJa9siI9vQamwUY4VpmqCTwHrG
         ctru9TTd0sC1amzY8WdcaKEDZ2tUnJcEAUQTPKo7oo+5nVFNCaQShpVaE3SI2dVdrBR7
         DNTnavf04RA5T1k0UpJ90HWSwnaO9Tm1kncM6Z5oT1oxllhFNEWfEYJKB52guiyufchm
         kGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792110361; x=1792715161;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iX2M7P0FJXo5H40qEueYVFWq+OgK2G9wQYuxMssplYg=;
        b=KECo20pk2f5tNdOmHcoSJ62N8uomQO8+zK4nhz/BfQNIzEIjBIEERLnXSlHvZwAh3r
         IVkJ9FTUy5XJfF0pKc9I2KpzWOPEoqBSJ2C3SJF84hAm1KcGrdfxvRsXEq3Fn6yuoYMj
         XK0D4a0EJXs2DK3nmz8d1UQ6OL6aHhXvAkghMan93OgDipXM0ELXz8g/kHFSoMepjreg
         XdNZKKVeEasrN1JDC+uWGsAjTzi1DGST/wyKGIwOu7qDH/inUs7r4x/Qv/IKPWQPx3qf
         JMbPQXIddnyWiEkxD8KFGFiEf3X89L1sKebx+xK5/nOomuhM1IyDagEj1JOAD9QY5CNe
         Wt3g==
X-Gm-Message-State: AFq9FYJy48jFfvqR4OJsGfAozQ6VcuFTsegXDvdt1Fh0jZGmbVzE3Fgz
	GjcYPTFUu5F+yKR1MtFvMk34kPNlMtKrrHhxtxT5gM7/7f9g/Mre1xDbSm+QqSWEVNfg7TjyPJU
	iyT+rkLI=
X-Gm-Gg: AYBFou0QLOnUZ7SIxMQvlmZhuhbgjeeUYC8bWLBciNbP4t9BRyg3rZFjoSaoL1BAykN
	bbsQ2vFEzDpKR++IqS+FvTq6xVcT4t22ouF7IAY6KGLmwf0nAC2gYXQKGOi5IQJWftQzfY7ZuuP
	ub51sJgzjbVlwPgUcIdB/RLD3cT6euXiWe3J+v5tZG/DSFkCXg6ztIV3PVWMSBRuxiLDwHIiq3k
	+NS+mL/+yO4BO29UU9JYnjqBUMWDthFkW8ZpInR3k4Egj43CRgQg6xupwiYbasVdg6dNd4XCTeC
	bJ8lwDFAVo6infJmA2ZIqoydTMtpXibkQaG6rlUhRGvNxODIVgfzGqUZkGg5TUbdrm/BNPRlizl
	LAsdiIPqF6pJYkQMro52lXm8d0ql2IC4IGqwsMXubMORiZ7Fl4/gtErU4F3ipDnA96RajFByDKT
	h60+xVF7iUjteb8NiAmkLGtM0kOwIYCeCM3+XYeEIKqUD6TJiRVmCxV9/izO+2POFc/JHiIl8yR
	tkSaaED0qOBFBdBsmhb4VwQmzh8X/3y7eKLXLErpVISDiiOoLcAG6RRXw==
X-Received: by 2002:a05:6820:2d49:b0:6cd:3fdc:2663 with SMTP id 006d021491bc7-70110172412mr1081549eaf.36.1792110361294;
        Thu, 15 Oct 2026 17:26:01 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7018fd92933sm609390eaf.9.2026.10.15.17.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 17:25:59 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Josef Bacik <josef@toxicpanda.com>, Li RongQing <lirongqing@baidu.com>
In-Reply-To: <20261011063555.1142277-1-tom.leiming@gmail.com>
References: <20261011063555.1142277-1-tom.leiming@gmail.com>
Subject: Re: [PATCH v3 00/12] ublk: don't dispatch to canceled io commands
Message-Id: <179211035881.1953571.17228596115085922697.b4-ty@b4>
Date: Thu, 15 Oct 2026 18:25:58 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 11 Oct 2026 01:35:43 -0500, Ming Lei wrote:
> Josef reported three ways in which ublk dispatches a request to a
> canceled io command, which oopses on the NULL io->cmd in
> ublk_queue_cmd() [1]:
> 
> 1) STOP_DEV, then START_DEV
> 2) partial FETCH: a task fetches some tags and exits, then another task
>    fetches the rest
> 3) user recovery: one queue's task exits before all queues are ready
> 
> [...]

Applied, thanks!

[01/12] ublk: keep a canceled FETCH round canceling until the server is gone
        commit: 4c454b5b2634d982caf797fbe477770c3edfc983
[02/12] ublk: mark the io command cancelable before publishing it
        commit: a261f0cacacc022e4fab5b8e38c59f74ce4942e8
[03/12] ublk: mark the batch fetch command cancelable before linking it
        commit: b59e96011d22e322fbf4d5d1d1124de538c278ed
[04/12] ublk: reset the FETCH round in release also without a disk
        commit: f06ca594eafcdf58a399a0f92480631192e06032
[05/12] ublk: reset the FETCH round under ub->mutex
        commit: 84824afdb5a4dc127fbd7036142d7611c5e53651
[06/12] ublk: allow a NULL io->cmd in the cancel callback
        commit: 4915dc0a1834457520ef0592bfd454b26901614f
[07/12] ublk: let STOP_DEV cancel the server's commands before its release
        commit: c8b349f9daf6d88ff21033028167d00e819dafb6
[08/12] ublk: refuse to go live after an io command was canceled
        commit: 7bf71ecab1c225d4f7d0717ec482638a03527be2
[09/12] selftests: ublk: move the control command helpers into ctrl.c
        commit: cdf6e5de86a91da6e4d621260bc70e99e2f3a25e
[10/12] selftests: ublk: stop a batch thread when PREP_IO_CMDS fails
        commit: 9703575564aa7c74d6746e4ed2d3f8a99af7590c
[11/12] selftests: ublk: add test for going live over canceled io commands
        commit: bcab0b98566b8f73f8e398d4f12a088b81885459
[12/12] ublk: use global index for reported zones
        commit: 80897c7e5ae5c56f37a2eb004328edcb4da7cdd1

Best regards,
-- 
Jens Axboe



