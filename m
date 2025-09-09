Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104BF3451AB
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424560; cv=none; b=nEnCDnO8MElO8uu9FrtPa0gK5hcY5pxTCR4berESqOdWHjWGaUlA7nZlRnz4sk2YK5mlXsqGqM35a4/u9fvv96Sx4ugdup8C6Y3OrKyBZvP98u9Hy4VIYeAjKLU59MjODthEtAiI3JCGuzTSmY0SkqD8EEtdIuQmZskeulbjT20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424560; c=relaxed/simple;
	bh=sdAUUAnXyg3K/25QJcJ/H03t1J2tpAN5WH0WT43DIUw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aAKdDAshWl+0r3AnyIIdYJGWJtks4ZkB1Wy+2x9b7MUlgfxJxH6MDHT9MmIGXJOyboKfbGrvQEzbGUT/DtKe+zMQ1D1PgAesFn0n62UBn2+i2okjwQJ/YMfvPIOgBBo8yNt5fPlr22pYy9grL6OCM+S7hxE8j60ALqpAV0JaK6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3Fz/YLx2; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3Fz/YLx2"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8876de33c86so341845839f.3
        for <linux-block@vger.kernel.org>; Tue, 09 Sep 2025 06:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757424557; x=1758029357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrUpdS9XW8kCmiI/HdKgdDuMgaTmT22blEzvxDbI6UY=;
        b=3Fz/YLx2M8b0ASqOsObwg/F7nj6Bz1m4S5gi2raA8xXcMWalm8Vza4oIPHmgsbAJOP
         fVjQ3DXRLa9zsLK16oheajgZ1lUoH7Kx1dfepg6OiMAn7rwb+iVdWN0Qm3Rdf7EzPzIW
         5AH1DjDwM7M8WXhc6Uuhg8+ckMZ17hLSh/1oAt86eY7xXKYGw0db1TVux1ylNkQzWL95
         StKd7j5VgC6YIulq5Iaz6k+GCU3MgvZraHDajQF3s7jIUGU7cDC7K2j6EA28rOkxZTWP
         UG/2n2HTeY3uE0Bpc9RFOlIFcKrB2Nc3wEIF6gOh5r2Ns6Jysh5pDMyG23QsNs/4hIA0
         kl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757424557; x=1758029357;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrUpdS9XW8kCmiI/HdKgdDuMgaTmT22blEzvxDbI6UY=;
        b=jgDlRXq88FqE5uDNBzO3fX7OkCfyskqghc60zt3wP2t/dgaOdgkOPbuEKBvdHXtcrB
         4psZPIu/uT5vY8QDX6dn0/X/6MtHxl0eVk/Tnmwf4BFNhUQ+iLmwdo+hkgjyayZpZEts
         0EqEVyihn+Zu5hS0F9tqW2VQc4uXADI/xBfEZQ6/0Ioxok7g2ENd8COJGl3Swipsbg71
         rFPzP/zaTSaXEtA9LKvZEySWxez9yv/1fisdxyhy71x0iE7BkPxyxflv5F68KUEUL9v2
         fgXQ3R21qVjbwIelti3GwYp8U2D0KLN9N1c8ABJpxww/OSh3kftRGZR7HtS8m+nTTixG
         rraw==
X-Forwarded-Encrypted: i=1; AJvYcCXifHePCVdOGSEvs7vAtlZwbtFk6SEJ6yFP0Kv0QO9pelK5SAQzUYwpHsrbzcCUB0W1l/pRPi2zevxJvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YytAbgxpZW8nYhk11jtKQnFapdSjWZyk7rGNV3ugsyUZSH62n38
	KDorwY4tOxeAnPwx2lBbm6uFElcw1U9+vYmD+FPTCBM49Gpyo/SVliZZEnILuRPYMpQ=
X-Gm-Gg: ASbGncs6F/NRvo1azznqcjUH/Us6o1fdP+u2RDj3Cn2XRGreK5q8ksHGv/1HYpedNXF
	11KJ/HZLxbsRnvIjqXAxNU+9+qtBTkLfvAhKcM8h2Y4Hn+wx4a18fmtUmRd2vjS/bYXgD989Wgb
	+vjHdBwZZZ1I6daK3/n8wZ7/3Gqnhs7cxHhFyROQwHJWFU31aGZmi0PrIHBvibuqzWmLFL8N/Dr
	YbHBlXRlQp2RhQSYRfHrlLsibDmkxsp8OWKJsIS/TbacBqerJgUYNd3TXWwHddqfJwKYL8SesGG
	rD8wWNjqNg6tqol7tSGXVlk5LM0u18z4AVWboqDSr0x5gasarOGuX+21QjN+GwPAkzPPvf8P5Q3
	+4J1HuMSgXpUB85RKjNMJJXe5S3X82uYRKLw=
X-Google-Smtp-Source: AGHT+IEIjWqcE1zYENpDxaX7YutdAIuak1sO9GmLbuURziKcQXpN8xbXlPbtAPoitLTAuWNCpHzs7g==
X-Received: by 2002:a05:6e02:3784:b0:3f3:bbda:d037 with SMTP id e9e14a558f8ab-3fd965c4d04mr182350825ab.26.1757424557099;
        Tue, 09 Sep 2025 06:29:17 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f31f6e4sm9895116173.47.2025.09.09.06.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 06:29:16 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Josef Bacik <josef@toxicpanda.com>, Eric Dumazet <edumazet@google.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
 Eric Dumazet <eric.dumazet@gmail.com>, 
 syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com, 
 Mike Christie <mchristi@redhat.com>, 
 "Richard W.M. Jones" <rjones@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>, 
 linux-block@vger.kernel.org, nbd@other.debian.org
In-Reply-To: <20250909132243.1327024-1-edumazet@google.com>
References: <20250909132243.1327024-1-edumazet@google.com>
Subject: Re: [PATCH] nbd: restrict sockets to TCP and UDP
Message-Id: <175742455632.75115.15346620038817180242.b4-ty@kernel.dk>
Date: Tue, 09 Sep 2025 07:29:16 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 09 Sep 2025 13:22:43 +0000, Eric Dumazet wrote:
> Recently, syzbot started to abuse NBD with all kinds of sockets.
> 
> Commit cf1b2326b734 ("nbd: verify socket is supported during setup")
> made sure the socket supported a shutdown() method.
> 
> Explicitely accept TCP and UNIX stream sockets.
> 
> [...]

Applied, thanks!

[1/1] nbd: restrict sockets to TCP and UDP
      commit: 9f7c02e031570e8291a63162c6c046dc15ff85b0

Best regards,
-- 
Jens Axboe



