Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ECC28DB74
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929965; cv=none; b=BjROHnKvFyn4phVHzkIsgYqW7/sJv2U1vQ96abyGmlzn9QKJmh0sUmDs3GtbEwLUKxI49WQITPq5ZlSykHmZbu1gIrR5zpvnyMYSzA0kZtmmBrEmwWdoFGQ2Eyre5Od/N1cFbW7JIJ7hEM6C00NwGyE+6K3h9YQ5gmMzsz21yiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929965; c=relaxed/simple;
	bh=mjZRQNAAXvKXZ0Y9oGTe0tkLz7aKgyt5oxY3ykDF35I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sHy+rIlj+RFDNuEK3kDzAZHSAYpj/S9wT3G98DnJG9Qy6nAnDnOWcnus4Cmvwc6rDdECh4ZMcfftI2H1lQwBcwSPE1A+v+1SEYZJULBib9GdiEKQhYwEqH4FVGmZm+pP4QZyC4gKe8AQjmm0nfLpPtnm1S8Cendv9StysjzM/DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wl7VUFNh; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wl7VUFNh"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d940c7ea71so33001985ab.0
        for <linux-block@vger.kernel.org>; Thu, 22 May 2025 09:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747929961; x=1748534761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0U9FxUnjw0vXFh3LhyHdxIJuCH5551jQ4gVapY3/Kzg=;
        b=wl7VUFNhQ/0hiAKxjyLXPEl98QXlo+AqjniUIf3O14PWGbBOOeSXHQVaZMJT/FvgWV
         dghutf2ilDGy6UU7Y8UobRdvv7jiVWyh4PkydcKpBUYr+3XRZOEXcwvxPC8pzurVxlQv
         z7jtYu0YwfsmMdUkyvyd/DhgH82EmgUvT17ylngJx2xYGQgRhQfRWEB2eqi1Hn04UwGD
         JmVvYR4U4Jqw/f0L6rfgG+ktTwUpZmibMHad3I6JByx7ZU0rdEwZcBz5yayZqrI6svdF
         xWeUrkid3B3fqNlP8XaSVh8BxttGZ+7UZbhtaRszcSwPyQ9YQUjRpkV0iUQZcFtORpRL
         +cnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747929961; x=1748534761;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0U9FxUnjw0vXFh3LhyHdxIJuCH5551jQ4gVapY3/Kzg=;
        b=pKqrS4FpAYrm3/EPZe1s1KJYx3HiX6/rSGORgwqoKjDxd9ypa4r+UsDFZDQZq8hej1
         2s5DHK0hhApAJ8D5x08r60mIYbBkLa8jRHxdetJEO5qNXm7uU0llgMXT1zQjn26FPrDv
         OZSZgDCibnoJEnQlRmkgynMEWveofwXdWNvB1KZxwX2auKTStzdORxQ9lihnh/qKs8mV
         2+tU/SYstk213nB1ba+r7+li86AsJKyZ9BvRQPSHRiCuGr6VE2/td8/dLGiOLQjIjlBf
         f3kseGecb/rQzQV2tVULs+b0ImI5CfdHC3jbUxTNMGDgmthnelkmGZ1buAdh5jgVNrHH
         A2+A==
X-Gm-Message-State: AOJu0Yyo190wGeTQN+SJUFhC7cRtZ51olJp36OkdyR0bu8rUThUZMTWS
	ULOzObTDmSRyN5YoYMFasZXvq7JPryo368E7muupmWzyLUJKd1OeEQj5mGrY3UMfIHjKxy3gy8+
	Edr2b
X-Gm-Gg: ASbGncud+Ph2NMXQL9j5TVhy4Td/xOtfJtHXJyveT5b388kJbwhpmdrZphL+PJJVqJx
	UcvD5fPfoIKlvlxQ7Lsh7HKXhNgyc59qiYqRNegYTXfocqihSq2PR2dfcd6tixGU08pv70Sl5Qk
	OPONnprWz8QhFe7ZJxro5G8y2nY5l8+JsFBiq0DCub9Xv21FyufNDdhdLBvNQCq1pfxvPcLeUlY
	UuwM0oROCw+L80ZvrysZ+sVdYnewKAIP83ixN1b9OtuLVuHi3TjAV4UOf9jqu//ZQ4u9TC8WlPu
	8FZefTuZc/u9oEaFmEkTbVtQ1yMRPMw9UW4M7rRnNktT7LfRJGau
X-Google-Smtp-Source: AGHT+IGZBRIcPqU2CSrk4akaRcyXCmpVVqUmQa6UPPZWUdn3FlgYspHriP2sBxUxFJ7afLrkhp6PDQ==
X-Received: by 2002:a05:6e02:214b:b0:3dc:8746:962b with SMTP id e9e14a558f8ab-3dc8746970fmr65156055ab.15.1747929961516;
        Thu, 22 May 2025 09:06:01 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc48c7b2sm3243083173.89.2025.05.22.09.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 09:06:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
 Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
In-Reply-To: <20250522152043.399824-1-ming.lei@redhat.com>
References: <20250522152043.399824-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2 0/2] ublk: run auto buf unregister on same
 io_ring_ctx with register
Message-Id: <174792996064.1177358.11375945979582071142.b4-ty@kernel.dk>
Date: Thu, 22 May 2025 10:06:00 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 22 May 2025 23:20:38 +0800, Ming Lei wrote:
> The 1st patch adds helper io_uring_cmd_ctx_handle().
> 
> The 2nd one use the added helper to run auto-buf-unreg on the same
> io_uring_ctx with the register one.
> 
> Thanks,
> Ming
> 
> [...]

Applied, thanks!

[1/2] io_uring: add helper io_uring_cmd_ctx_handle()
      commit: 3a91f28fab43f093c72312148288d125ae160c2d
[2/2] ublk: run auto buf unregisgering in same io_ring_ctx with registering
      commit: 914e0dc5082a335ea5e7d905e99e1a1cde001369

Best regards,
-- 
Jens Axboe



