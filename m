Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E0F20322
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 18:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742322747; cv=none; b=Z9LrlsTq/BizeqZ8c3Ri+2QZia/RhtaipHdgtqEmKRBv2ApsAR1LohFTordFgXa3SYhjaSN4UCeTQUv9iO4T/4m0hxVq6ifzgSk7bP+M/I+I+oBP7AVatd2TrUhChsqGj0Si8tEIiKK8PYRWHoS1NkLZpgBPTULeQwL8VbYsStg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742322747; c=relaxed/simple;
	bh=qrv+DU81gmi1ENITv/uf+Y+QCljkGvrsvRaZ1EA/ctg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZunY0vrMbP/zborq7KtM4+oFJZqdt7S8RsaHnRuXz7M1dRxE+pnSPqh1dwPHNv96LakgSLrCS1yWlFbBx6NL75qBGeKaeGnVK937T1/dMrP0L1+0wlburdyW0hs2hecja1AGRUWr9CRpb1Z23rFxyIRWBfavuMv0WSpGCuNF4XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rzaXjIVc; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rzaXjIVc"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d46fddf43aso42790225ab.3
        for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 11:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742322745; x=1742927545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vn8c/8xY9hsur5GaIQZhhu6nfpmRkGa6zZ/5hcfFcwg=;
        b=rzaXjIVcQHYIjeJ3Xdgtk1GmciRjSBQ39CYSKJoazF5y19GOwh5x8hzUgCUKwc3wNz
         3tk666LGtdCTmIULCw6wuLliIJw9T6sWNc6uj3kFjohjvhTjLz1TI66V1BnNeLu6xwtc
         p6vXU8PVkUV1YV+C2JoUb/mpDixF/CaJgkWpTGXbspsRtxu2OclllK1TWWNxQdQbk9SM
         xUIrBEKNXqnYvxyxAneYdvucWbmkxP63w/aJUS3nQwz9O/UGPzmD9h2TMtezHmTw815K
         UUORKyNiWThlfskW/AK0SoY8YMyf48cFMjMFw8JvHTbMGwAamuZUpXacbn5NHGZ+rOn6
         XM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742322745; x=1742927545;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vn8c/8xY9hsur5GaIQZhhu6nfpmRkGa6zZ/5hcfFcwg=;
        b=K+pvv3A8dty7Yf92Cpx6jLALNrZtZEWy/B2aGryJeV0wq+soZ8tzcZ5KrhAPIAVixV
         4/mnSP6VynngB9XmYF3JfVYHLgjMIab8I1FFVT62ykLRaCM4R7MfmwDfKUs+6SxuQE6E
         HqxqADnuFz+AZWa5Ql8HZo/uCH8a9yKjgdIdGZz8mOhQs9qNDA5R0sWL4f+l1TPm2dAH
         l8HyjHJvjf1t+Tejl4/yLnSZ59WvLiQkUWzbuLLiR1dWp8E6H+N4ig7zGzin3N7f0S6h
         +xOIGzdMnK4iWJjAY/EAt78HgUpnVhlS51PY8YeLnmKWkvYp6smHApdnygJX9eur9CG6
         nRMw==
X-Forwarded-Encrypted: i=1; AJvYcCWtvcKWkZoEVwMA3WGjRuuv2ti6yY7F68rSz8vmeFw03TCm10hmFrhm8P65PWrr+jY5bKGoPRD9JazUOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuHm3avbbcW00W0hr8JLZwzzOuSkTjdOyvlwJ3CycchuxgvnNh
	NMt1ZFRnksxQwQb2MkSUvUrEPNnemmohTcWeAUWS5h9nQCrPR1K/5y0MiKAdOjAucZ+hBE4BNWh
	W
X-Gm-Gg: ASbGncsy9Xte3ykpTcRjw3MeCkywjNbmOe1AsQzM9yqIMTgr4jgqdX8k3p3Wt0zDzZF
	NT4k8nZGjkLoFtgpmFRdrImOYwUECO5dlaja0TjT47LmFTFUMiCaLCjkJsRvBU0OFANIwRVBpzi
	oC6ES+Gdjn8bqdZRljfsRbaSfaWwuPg7moTHgsoHWztdZv/Cbgf/tAYLhm7uj/clrM2+tyuP22y
	ygMnENk/U4gocpSt1D77pLPo4bM8wcYw+/xZ/hfznp7oRtdxj+woKFoBwVy6vq6gGi8bajYt87g
	VWlKeMxM09sslEY+bBUuDH2828vwZ5YjKt2y
X-Google-Smtp-Source: AGHT+IHgYCKrD3peKrbdSEm1B+JO8dbCq7dov1VEXaRpVsSj3E7NIaJGpVqJEmXprxOB8OJUpmk3kQ==
X-Received: by 2002:a05:6e02:1d8e:b0:3cf:bb6e:3065 with SMTP id e9e14a558f8ab-3d48397f585mr168752655ab.0.1742322745570;
        Tue, 18 Mar 2025 11:32:25 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a67e5besm33337665ab.31.2025.03.18.11.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 11:32:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Wen Tao <wentao@uniontech.com>, cgroups@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <3E333A73B6B6DFC0+20250317022924.150907-1-chenlinxuan@uniontech.com>
References: <3E333A73B6B6DFC0+20250317022924.150907-1-chenlinxuan@uniontech.com>
Subject: Re: [PATCH RESEND v2] blk-cgroup: improve policy registration
 error handling
Message-Id: <174232274456.158569.739528900664075776.b4-ty@kernel.dk>
Date: Tue, 18 Mar 2025 12:32:24 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Mon, 17 Mar 2025 10:29:24 +0800, Chen Linxuan wrote:
> This patch improve the returned error code of blkcg_policy_register().
> 
> 1. Move the validation check for cpd/pd_alloc_fn and cpd/pd_free_fn
>    function pairs to the start of blkcg_policy_register(). This ensures
>    we immediately return -EINVAL if the function pairs are not correctly
>    provided, rather than returning -ENOSPC after locking and unlocking
>    mutexes unnecessarily.
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: improve policy registration error handling
      commit: e1a0202c6bfda24002a3ae2115154fa90104c649

Best regards,
-- 
Jens Axboe



