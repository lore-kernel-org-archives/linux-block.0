Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1CC26B2C5
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 12:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749645801; cv=none; b=E/6V5ohTaFMSGiipp0x9AS9sbfDk5MtVgAI9ngye1/tf/sgAU+NqDZMTiJEPAlCYehVdKsghV/nLtIhkADr7e7PCQv5i6L0WD0uIvabfKJAmZJcaNZHDoUfcKPSlzBzvH7sPF2hWMfTeRvf6KdnQp6riz8jYz1KPJ8+P8wF0bRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749645801; c=relaxed/simple;
	bh=BvMN2l9SX0x9ZXrrFiTO2and2/HjC+BjRArgWkPdMFw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d6kYh0NUBUqx3XhKI+ob/UedSsW4JZX4jbOchWqaGLSbtVkN1K3Y8pBfr9tj77T6Rmn/BW74EebQY1ZNTP4dV8fDxuMV3GarUEliyxZnArLBTc+fbk9cLeXtBQmSZaVKwtux7lWMBekM/O95s/iUzgGQvCI8OPSwiTljAk5VatA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fzGccDHQ; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fzGccDHQ"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-864a22fcdf2so34301739f.0
        for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 05:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749645796; x=1750250596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8JQ374dpksxryeTKHfHlq5UaSZGr3rRB56rMmLm9+o=;
        b=fzGccDHQAUai5MItBzBxi1owLs19FVfmUsY8Z07B2CMMlZS6GG+LaHaTOtdmVFhXUY
         cyyDyMaYEu/bi6kxnHNURB6PP6T3asOctp+5Ys9TU53GhDt5543kD6SKWWDkyp6vE321
         N6uIWmxc4l97hLl7s52rND7+0NUnODNMwNC84XXqLgGHf2Ih+wlcBeZAnF+/y+aGHY0H
         +gUvmcdZ71wjOrwzQG98dWh0lU8R/7eUwxcBMCVxMWlbOuQhmwXCwql001C3wredcxK/
         D5huH1g6rlTFLXE9ar48TjsFjw7FoZ2v94G4bkt5PC17JDpKfvjKQSpwyxpVm4osA2ut
         oDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749645796; x=1750250596;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8JQ374dpksxryeTKHfHlq5UaSZGr3rRB56rMmLm9+o=;
        b=Nt/SaD5Hwp5AOwhzRwzwxQHBaalSXJnlPoV7240xHyheQeEFYkPcaR1dh3OlBboQpp
         c1IpOVZFvT7zJTjh/hrbLsRqh1uW7IDiSVbMrIMECEdROQW64FwNiOY9KY3LxUVw8IOZ
         djYv33nx7cYuD32W92OgbMma7yS7XgYNOANkv9fIEziaR0SGxakHkFLwxdcLGGidJFfp
         0Lf3YQKwFkO+WEmgMt2tuyWOqOKOYFmMyai3fn2RcgCPeiUQXxeVvDN19x2D81kEW91t
         /usJRcYqWaGCABmVjEupUW071kXgUU5HNdxwTpu46X756lA+cNXjvrkbYb3+s74t0Kp7
         N1mQ==
X-Gm-Message-State: AOJu0Yw4/7HeLXNLGLPMhIaxAH/jj+OYJzSwiWHCbck+fIS8D4cEXA0u
	dYi2Z4q4uJDwXVFHut7wq4m1L1zNaRQdYKTPnI0Z+DaRlRuhA8uoAKKO9h2+s5r6zmDRl3aoRwz
	ZcOrr
X-Gm-Gg: ASbGncuNMXp5OLoAEgu8YNsv9Wi/trVzr7EMt297q9VyMGb0xx5TeD1y9E2Z8GL+KjL
	ebfzSXyIMku/xmm25/XFTyY50JYqEmfX16qxWgAJyCgiJsxjGW8omjzKJmu8ah8bVPNCDiBgwJz
	ZQDGxczctlvgSHBhiq8bNg72irQ9Z900HvYE+CiCSQEAweM+OxurLXslcJy64A/pG8SLDcNK8Dk
	sIkSq0E2flRaFJLW12PGf6JiO1QqHrKPkercXUZbEOGPpLhn0ecINn4nBzRDlPM5kFZcZgil3VD
	qyPgIW8ZBoBWnMbUv/JMK+s6lYYCRc51FAykj60MYmr7N3dlmlLjsw==
X-Google-Smtp-Source: AGHT+IF2MykYMgfehFfNWOnxqz1sibdE0FTtv1XhYH7StKYQVWhUVy/9/3ZhqjDya5ValfD+8OVYNA==
X-Received: by 2002:a05:6602:4085:b0:867:973:f2cb with SMTP id ca18e2360f4ac-875bc12d5a1mr362674839f.7.1749645793387;
        Wed, 11 Jun 2025 05:43:13 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-875bc585b5asm39495339f.9.2025.06.11.05.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 05:43:12 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: syzbot+9dd7dbb1a4b915dee638@syzkaller.appspotmail.com
In-Reply-To: <20250611084938.108829-1-ming.lei@redhat.com>
References: <20250611084938.108829-1-ming.lei@redhat.com>
Subject: Re: [PATCH] loop: move lo_set_size() out of queue freeze
Message-Id: <174964579234.357731.13903890301163957630.b4-ty@kernel.dk>
Date: Wed, 11 Jun 2025 06:43:12 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 11 Jun 2025 16:49:38 +0800, Ming Lei wrote:
> It isn't necessary to freeze queue for updating disk size given submit_bio()
> doesn't grab queue usage counter for checking eod.
> 
> Also many driver won't freeze queue for calling set_capacity_and_notify().
> 
> Move lo_set_size() out of queue freeze for fixing many lockdep warning
> report.
> 
> [...]

Applied, thanks!

[1/1] loop: move lo_set_size() out of queue freeze
      commit: 4bb08cf974c54adc321b8505ce82720c2a15c451

Best regards,
-- 
Jens Axboe



