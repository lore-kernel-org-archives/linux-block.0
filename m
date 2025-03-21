Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9DA22098
	for <linux-block@vger.kernel.org>; Fri, 21 Mar 2025 02:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742522533; cv=none; b=Szv/vyt/0QutsPyYaz0aWPE6f9bPGn/tZMrjZjHfb5POIHyjtbuosEqAe/b7cqYQPnqlcryWRIZhmUdmPY9+JFKJsBj1+aL4Pv3qox8H+pisDHc26VreQVrvHMcgr1UncHngz8i2S5VdF8jyWDZ5GfxukJykzw90gRKgxJTB3uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742522533; c=relaxed/simple;
	bh=TLZF7Ge4PVR5zbSIsrZTZsfQ3oIhEPYj4cYsHC9mkJY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Jp7Yp+KjQHlzA+eglvUlKe8vvJs/Q4bKr684UU1+lsuTGWaFg3+cV1SvFIkLtI2J6ss9KwoA+FRGo7BEfUrlcizUR9uYqlhlbpK45mS2YAvTNQfsa+30wDPWAhPzCX71tEKRqXkAA5UaGZIuDNvHN4uWrwgy/v8y/z6m16tkHi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VYGtQkrl; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VYGtQkrl"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d571ac3d7eso4362725ab.2
        for <linux-block@vger.kernel.org>; Thu, 20 Mar 2025 19:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742522528; x=1743127328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7JRJzh2vg8tYPkZDdadTBYNyJJcI80UyyO2l5CxuV4=;
        b=VYGtQkrlESOGno52vpENM+2ULdexdiaxtRuFZtyCh/dNQgqSAt8zFM/Eb9U+Xk1nn3
         gglqUV4mSVIIQlK3Zga1Qh5PjRzMI6mT4l71X6idNi6RRb2XgztfFZLxq9D1sEkITMLh
         cinPuMvc502ZlvohzarZUfblCoYRYv4JGzx0AQ6hrhhypNGs62hAh3DLjynkGeHBt3op
         dceFQmD2FIsCSP3w9GqFsEyFzifEIOCFxiInyvLT2x+wuzqUWXAZli/QmbJ4MB6iaBh/
         yUVpnkn/BjLiSY9xI2BOIBo1jwwJF1rMyHgb9PwYUjDxQvHcKJt6K0f9McL85NKVHypm
         NDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742522528; x=1743127328;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7JRJzh2vg8tYPkZDdadTBYNyJJcI80UyyO2l5CxuV4=;
        b=JHAfZueScGWeb9KNy/uInom99lqyX/gd+DJCCqZB6NkeSSraFe2w93BzJ8ZQeQj2PY
         ehuBrL2W1rrvL7vjw7L8G1ruWSq6B18PQ7VMd1sV++iQrr+CkMUNVB3dJCmm+207aGBj
         hFBTk40Eek1h00PcoMcMCVj6JlVDbKyVBvUlAoJGD1C/H3hTBCPV4niyEAp/q6ZvY30O
         UGMfdmn3e/oMxnEbM3rjrndD19h5m6CeovqUM8Tv4WfMZtHyAbQHwjSRiXYnuxZuJTdc
         x6O9bqy5FSxx+eS/V+JuoLwa6f6fNSqbUg0wm1qPnFfbUoSSNmWWefBDmV8Kqsc63Znx
         ztig==
X-Gm-Message-State: AOJu0YxlVC7QJF1vE9UNaNoSY/M7Q6vnRsKjlREavqHeldyjxt+HJlZL
	LthRvfJUT0BXemFn5TU8BdC+/Y9n8SJ7vIqQff6UN9QR+YXycLXIaoRgFMlMfzmztFaK+2KoY1W
	S
X-Gm-Gg: ASbGncs/A/sDBGbS4g7nL2xZelNKuTmRDKErveNmlkoJwxpaODsw7J5Zni9gDpo4CnN
	RKDTuGCbY45n9AvcdCDgPC5T17rIXhhjOtE1GeD6VxdzsaK+87ujVZVdmmxwmcu3e+rUFBO5DGY
	I0u1VneG6sKhelL2+FgNfphSPMvvG7aBLoL86ToxCvETGMzjSBTohaUzJKZpus1paKnh64cJBJI
	QE179ns9VKW6U2qC0QUNeEvLpye7BYJQsW6rOPuNYIEnxjHcYAjX17ak/MBuTq/VUQPAe2GgfeR
	c3X0oBDEf2VqY9prihUswM8zSzsdWuryD8Sz
X-Google-Smtp-Source: AGHT+IEJRyRGjxKdWuOhRcArkd1pZ111hrs4C3nTUsNIxRyCI2IwRQrMey0qPTqRQ2MQIi14Npuwzg==
X-Received: by 2002:a05:6e02:1646:b0:3d5:890b:8db with SMTP id e9e14a558f8ab-3d5960f4df6mr20476205ab.8.1742522527735;
        Thu, 20 Mar 2025 19:02:07 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbc545a9sm215517173.0.2025.03.20.19.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 19:02:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20250321004758.152572-1-ming.lei@redhat.com>
References: <20250321004758.152572-1-ming.lei@redhat.com>
Subject: Re: [PATCH] selftests: ublk: fix write cache implementation
Message-Id: <174252252662.334452.914885952471920412.b4-ty@kernel.dk>
Date: Thu, 20 Mar 2025 20:02:06 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Fri, 21 Mar 2025 08:47:58 +0800, Ming Lei wrote:
> For loop target, write cache isn't enabled, and each write isn't be
> marked as DSYNC too.
> 
> Fix it by enabling write cache, meantime fix FLUSH implementation
> by not taking LBA range into account, and there isn't such info
> for FLUSH command.
> 
> [...]

Applied, thanks!

[1/1] selftests: ublk: fix write cache implementation
      commit: 96af5af47b5407972689929543c73a39b477c8ba

Best regards,
-- 
Jens Axboe



