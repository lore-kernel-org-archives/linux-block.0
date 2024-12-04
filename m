Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089351547C3
	for <linux-block@vger.kernel.org>; Wed,  4 Dec 2024 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330009; cv=none; b=eRdea5XrV9ffYH42IhvX8fMXJe5Mwdeq2nAsQNzHxyScMfdP0wcDPMbKdT2J7CUz3r4fecsFDisACIkOnCJUeoWp2/2MSKlNCbsAqoThhPHZ4Un+pkJkvhJ30e2UKqMBQMU6U6lTC+yWJWJ04GGsf3/E5wZcGoWjdYL+YmiDqi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330009; c=relaxed/simple;
	bh=YLqX/28N5thdvuWAhBCT6xbYIfwdHgRjjlYUHnZfPww=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EdcIf5Vguq3reLna3/TIKADCmabjBWfg/+ZP89Q9UVndkHshzAcAnwW/T7kxfV8TDiJ4KoHb5eWzQ74C6N+EON1FTpNEo9v6qPn4KuiXPgKHKn7FFGUPCxTWB7g0evcFa1JMhMOjzvTyzPwJRO+DHQx9ewhG04LAvrEnHfG4tfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cbOP1qWm; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cbOP1qWm"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7242f559a9fso21311b3a.1
        for <linux-block@vger.kernel.org>; Wed, 04 Dec 2024 08:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733330006; x=1733934806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HFpbZOKpkO7AeS8bDe3st3+sWFuj7iai+TcTZhQd9c=;
        b=cbOP1qWmavkAFYTjIGGtxmICesXawjm7Tw0HYbCU1e44Cjsq1mwqI9RYGBfu4ZdzCK
         etKRraOqeFHs+Ev7wG0NXqYDvsRggihA2pOCYbBGpiJviaXUzVZmna5PzJxDURJv+Cm7
         5Xvk9nJxjTGRomDor9qKlDvik1uEDVH1o8ZsiaeKN5p8J/oyplIlNkbF5iX7vdlw2FOF
         DxeKZo2qOalyVhtPNcerN3p9rSaWa517MC2NdiNs5wmvWOoIjmX8enlrB2XluUmce7PB
         zjdgkdN25dDPEYQ9iH4uN90fOFkmqKuhbeTqYDPD/tT5+20PN3jNwbfzMa/vZs79YmSa
         6epQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733330006; x=1733934806;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HFpbZOKpkO7AeS8bDe3st3+sWFuj7iai+TcTZhQd9c=;
        b=pgtkSc2CyvhoSbBd2aIa/HyyMq8D9+LvcVKG9p5wv45iL52ipqHNp3rM8qlD8rusAi
         4qLpkmrVOVsvR4Q8QPowF0L0kfx1/AQl+cFMoCBsWzXs3YKoRolKMGBt9hQHnUKdP7lW
         Cef2+oojetYDYzrRfsI0x5cIxBPza/HnPJ+VZh9tM+zWpoJGuQDvoxGHyTYCjNvXU1oc
         TfvB4Zg1RTtfQAF4C/jbAt/P3vSVz8YImADY6tFbHIAozAHZiUelFFzk7ylpZUlwYqYI
         XAKY4BKm+MNg+XlsptcZPXwZPxgC3Wzos3+Dh9sTfpAgM26MinVgwQF48UJAlkx2vVdB
         rNOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLmOI5ITQ/sK/tguSNHldEl2GNstnug7eci/5EPjZu7PwxHlu6Yp5CFOcSSJyokSzM1tMImOLOy4L5Fw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCHu6InSKFEcnu8Oxh3DL4Up9/ibx9QleQ867XgAXgf4Nidi62
	83JmaILTGV8OgtFAu9nSsFE0MjBVm9GsIPhgJ9Wma9yYTcX/0LmpaWtpGh67O2jX2kXBRaKIK0y
	p
X-Gm-Gg: ASbGnctTGoaqa3R2PSTGctF+hssnwrWPO9x+6AV5CuczHrkQb2YOPqfZU7d4Hkva4k+
	mSU0HR5fzh5Q7wvrKnRHvnaaaPRkMVpXLHMDsRlOV2VxCf08tQfNg7w8fguGtxp17xxz3p0/rwc
	UoOmXmVzIiEuS9k4TcJNjwQefVgoYyiI2/atkP7KEQKv3Q0xUf2HGNnV6z9Q4mOuFE55n7KUoMA
	/7+LnDzIK9v8YA9m63YJJ8QWAstqQ==
X-Google-Smtp-Source: AGHT+IHGetUSTLBEO7g1Mr54/8uXPJm1zbpOiVPZj2JidglSRGFFA2sX/e54bN5zcvRXs+5U75O04g==
X-Received: by 2002:a05:6a00:995:b0:725:2b93:3583 with SMTP id d2e1a72fcca58-7257fcbc006mr8373190b3a.21.1733330005713;
        Wed, 04 Dec 2024 08:33:25 -0800 (PST)
Received: from [127.0.0.1] ([2620:10d:c090:600::1:a7a9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254184952csm12955492b3a.185.2024.12.04.08.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 08:33:25 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241204150450.399005-1-colin.i.king@gmail.com>
References: <20241204150450.399005-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] blktrace: remove redundant return at end of
 function
Message-Id: <173333000444.511414.17569005007152720429.b4-ty@kernel.dk>
Date: Wed, 04 Dec 2024 09:33:24 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Wed, 04 Dec 2024 15:04:50 +0000, Colin Ian King wrote:
> A recent change added return 0 before an existing return statement
> at the end of function blk_trace_setup. The final return is now
> redundant, so remove it.
> 
> Fixes: 64d124798244 ("blktrace: move copy_[to|from]_user() out of ->debugfs_lock")
> 
> 
> [...]

Applied, thanks!

[1/1] blktrace: remove redundant return at end of function
      commit: 62047e8946da6269cf9bcec578298dd194ee4b7f

Best regards,
-- 
Jens Axboe



