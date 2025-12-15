Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B5A3B8D56
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816392; cv=none; b=h8Cw0T6T/aFXBuNO8A7RtoP2XEIHL5mFD1Ke1Z+CD7P636fqkNQvMv42NXQbCzscrUpbFMWC5l1FIv82b0m//P20QIxoxbMQtRogEJFvVtZBoQroBmq4tNUztix07UoXJeq57IxFkV5856WJ/4wGTG9bXvBqQPzBysJqigvRVWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816392; c=relaxed/simple;
	bh=aBRgJkRfcOuyhSgXploWpHXwohk0XMgkvTSyyntWLSY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NszcMyZBkuzRpZgk3/wiZHgzTmaZZeQA9HDZuZygwt6EFRvSABwQ3EZOWYKjH0PdZBiReGjlygVtURTFyjx3X6UQQ7Sg/qGTOrRdiDHCJCs4iNJubgFc1aThwcwTuR7a2qNrI46s/fbB7ww6AP883d22ADvwvJ17S78auQ2WI/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3GELCxba; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3GELCxba"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7cac9225485so3393931a34.3
        for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 08:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765816387; x=1766421187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAd8GTPKPl9Hv6UOQ0PFbMuyPCBKLIhC7TVRuspgjS8=;
        b=3GELCxbasGBi+/Id1Ta5C1N+za3Ns0GfDZ2xkFB0AYYWKnjaLPckCdKoHGWrONBA+p
         OUSTYtWGqXcs50XsLI41jRK7i3GHtisr+gPFhqWsi3LB3HOm6Gv2xziERE88f48+8Vkl
         iBTDABacfWRy5M16ta3MGE1dOQMQKX7mo9BhNxpQPwY70UliX0ItlGnIJtIfuq6XU4mp
         a1tVqrUMchXAZ/qKTw2QAgxcsmdAs0jOLhpuiuhy8s5Yvot8ryKhIfR4RAzW1NuHGDJB
         VZfdVtF2vvIOX/+oIkZy48Bu2USFmLe7/h1OvZA1ozuA41hFhbf57I3jZyRY8MmLzoSp
         btGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816387; x=1766421187;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dAd8GTPKPl9Hv6UOQ0PFbMuyPCBKLIhC7TVRuspgjS8=;
        b=IUMmE35B1iaTnJl4b8mvfFMa7osNgG2TNMBNW9iEMq/KccOZqfMsiGam8K/EDS9hW4
         cTBQQrdztDCBHT2jQbezF+EFZv8F7mcPDvN/x3vIeYl30GlCZ6vXPWRWXdh/0CCYf2ne
         Vl3VnM0lGHyj22f1UXSTICIZkMK6ApHa+XWfK4bESyFL28Tc9ThZKci/URbLj3uBk2jq
         U6+TDMv2nJD40J8RzjEVU9XKDq1dq5c6OcPhRZInxxfoVLXLE/BhYx4FP/8nSGV1pNUJ
         U9SAXN70czY2XxVlkO/CTMLOLh1tQpEZVrElQpIiNU/ZDCTAJ67ee5agpnCaSm7v7DJG
         kHZA==
X-Gm-Message-State: AOJu0YxIwXCaGjk3tiV/0F1uwtMwWctD4gtDyC/ToSZ085NV2oLVmpQN
	8qEUoEazWAwjW5xxXfh9+73c7JykDkF8QMhlEypZJqTh8XQoqVNuhEga54HH4OInJdg=
X-Gm-Gg: AY/fxX5hiHOrb03yI2Cgc4fL08GWcLcGYMPdO3GyKCnJrENNpqSejYc6/H6v8pX70Ss
	s9v7tEk99A+9Qw5CP7tPLXh6x+t/94zYpFGJ0cMVWPhurGSRb33DFgCANF6wZfZsLf7nSsa5+vT
	jNbBZJI6r/ZQbpFh2I9iMzgTHg10S0g6PUolyJoCNfYj//UlaTgl6gAA9dvyKkRqeKa12bSNdHb
	pxrbRaZyxTaNsIFrsEiTjK4nKAA1Phk+Pmy/oHn8Q13wV2jOvAG58pVfgfdS5972aLqj7xXlbO4
	fNgZysHOlT1ReNYmuygDStoFGMtmM309re8fapVylHXr0D07A5vXp6jhFwwSidTN0OKJo77D0TK
	bLpyfY4FuNe4imJqq6pPTW+YcP/trkHrU/mQwsr23IXdUskNA3W4ZT0RGqnSsP1Iiznn5RgbDhb
	wB0/UXQNzQZSJ7
X-Google-Smtp-Source: AGHT+IFB7EGV9OjEqFYzvmL1PFt3U84w+B6c46tLvypadIZpiNFqlxk5SCZSIl27Yp9DjbLb7UA4WQ==
X-Received: by 2002:a05:6830:438f:b0:7c6:b6da:e2ad with SMTP id 46e09a7af769-7cae838fa6dmr6664596a34.33.1765816386711;
        Mon, 15 Dec 2025 08:33:06 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cadb321230sm9641214a34.20.2025.12.15.08.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:33:05 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Ming Lei <ming.lei@redhat.com>, 
 Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: linux-block@vger.kernel.org, Yongpeng Yang <yangyongpeng@xiaomi.com>, 
 Yongpeng Yang <yangyongpeng.storage@outlook.com>
In-Reply-To: <20251215152104.6679-2-yangyongpeng.storage@gmail.com>
References: <20251215152104.6679-2-yangyongpeng.storage@gmail.com>
Subject: Re: [PATCH v4 1/2] loop: use READ_ONCE() to read lo->lo_state
 without locking
Message-Id: <176581638534.7473.13163996260667688818.b4-ty@kernel.dk>
Date: Mon, 15 Dec 2025 09:33:05 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 15 Dec 2025 23:21:04 +0800, Yongpeng Yang wrote:
> When lo->lo_mutex is not held, direct access may read stale data. This
> patch uses READ_ONCE() to read lo->lo_state and data_race() to silence
> code checkers, and changes all assignments to use WRITE_ONCE().
> 
> 

Applied, thanks!

[1/2] loop: use READ_ONCE() to read lo->lo_state without locking
      (no commit info)
[2/2] zloop: use READ_ONCE() to read lo->lo_state in queue_rq path
      (no commit info)

Best regards,
-- 
Jens Axboe



