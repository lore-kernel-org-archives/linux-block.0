Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79B31494C8
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720547547; cv=none; b=lZTsBAdEQVZ4qw/ia1A9uVW4WGIImtH8FgWARr64jOj4dh7Q8BOaqwAsJ2WyNBzPE3EObKojEjhD8BFwDloWIf5N8TYl8+YWXJQO2KYOi33WsNykaBKsBw9I//EAZpbFvbVomFd6m63hCtP960cqIgA4vWjv1TYeyMpvqI5VD+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720547547; c=relaxed/simple;
	bh=B2ybeoGe/mdMT8ELtzXBtaeU6uv0Kbth2KRn9eiD6Ks=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UiGm/MEKwSQ9D+nEHlYL+3byDJepuTGkOWWfjHfFukmfcIdRSM5RoL3ioCKazg9pkVD52IeMi5R0PcTlxE+AXjZweS8hTWo9KWwau9UptV7pCMqoKGdUb+nASeUU7M5bdUAPEkPrALYsqkxrceMjRkEHKg23TTmBBp4G6hadB6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jtMkjYf7; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jtMkjYf7"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eebc75b36cso512981fa.3
        for <linux-block@vger.kernel.org>; Tue, 09 Jul 2024 10:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720547542; x=1721152342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4EOuy7NJXdErPjBoDexTRUjt+r44vQQLOT5S4Zc36k=;
        b=jtMkjYf7eVPIyQnA6Jd5Znga0NN3xkFLiuFyKOdkP0Pja+gHNPCVPdshqT01cQjg1O
         x+bv6Ojff/j6LE2Bt2GwISAN+PdfTs5D4O0sYRzm2wQsLsNxjGgNUs6EdtT1qr7O+cgr
         I4NO0Jwom6ID4lC1ioOF+HGXz8x2vDgzBRPp6xbQ/2CbMzvl6i4R+v5KCQzU4Ua1QGKt
         UT9YHZA3qyLqgdsUlaY92tbWEUqdTJGIE8Xy9MzOnXT/eolY9N98TRuKHvX9p5KBkHRx
         MsNYucH4Mmlaej0cOm84a9VHT951cJStHuB/qEEiB6pYk+owiqhnxLKknC4NLxhP/1va
         NUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720547542; x=1721152342;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4EOuy7NJXdErPjBoDexTRUjt+r44vQQLOT5S4Zc36k=;
        b=UhZ+L99KSVuh7YHFzUAfRCSjGG4voO+7nkytpnYW4NOgm8doFd5UVlBczyfmxjG7sC
         ZprGQjd4fIkU5D6cMbfwnHfvigceILIwjrAhaijxtYNuP6wTGu2AJhRZPRzUNRTTZLp3
         9TAvCEQYg1eZotZqOJbB/i/Ahf618zHy8Jx7+bZZ+UuyzI7YFt6xTuAOdWwYTfr+vEaU
         KPykSrDAJ02/FBEOiXV/6Tu7VOExc56RUSNu6K05oZmZN27/1lSFpeHNq8AFVPkcRHtk
         GoaU0lOFDskZS6r+rbJQ4ACQNAXzfgLBjcMoUVkSpSWWDGMkxuDyLAcbpI7isEQndF/D
         bacA==
X-Forwarded-Encrypted: i=1; AJvYcCUTT6WPUUV2YF+Ni+g1XSfzb05eST9Q4KwvZjtPxyWPlSq7vK1t1kGP6TNEgrLxdNmqQHjjapZQBN/x/1yqVo/v5EriAo9QTMDz1mc=
X-Gm-Message-State: AOJu0YyREvTTkXVRS2oi7CgFVNyr/UBFW0G+2zHuJ0Kwjz1CsqDmop/o
	ooKhnesHq/77FWHu6Ae5p+JwflAMEzW7oR2zhNwGpIFuPIAlg7+LjJyUMvjbSJs=
X-Google-Smtp-Source: AGHT+IHRjslBxiqyy0G3zZrlaEYF5Q+TIgFQwRt2w+/GueaRGC3kTXkbxEmvDPFr3e86fDi9Pu5PbQ==
X-Received: by 2002:a05:651c:198b:b0:2ee:8ccc:f113 with SMTP id 38308e7fff4ca-2eeb30b86a9mr21999341fa.1.1720547542378;
        Tue, 09 Jul 2024 10:52:22 -0700 (PDT)
Received: from [127.0.0.1] (87-52-80-167-dynamic.dk.customer.tdc.net. [87.52.80.167])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2eeb33fd1casm2454311fa.26.2024.07.09.10.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:52:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
 Jack Wang <jinpu.wang@ionos.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-block@vger.kernel.org
In-Reply-To: <e3d454173ffad30726c9351810d3aa7b75122711.1720462252.git.christophe.jaillet@wanadoo.fr>
References: <e3d454173ffad30726c9351810d3aa7b75122711.1720462252.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] block/rnbd: Constify struct kobj_type
Message-Id: <172054754133.374919.11899102978335897724.b4-ty@kernel.dk>
Date: Tue, 09 Jul 2024 11:52:21 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Mon, 08 Jul 2024 20:11:30 +0200, Christophe JAILLET wrote:
> 'struct kobj_type' is not modified in this driver. It is only used with
> kobject_init_and_add() which takes a "const struct kobj_type *" parameter.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    4082	    792	      8	   4882	   1312	drivers/block/rnbd/rnbd-srv-sysfs.o
> 
> [...]

Applied, thanks!

[1/1] block/rnbd: Constify struct kobj_type
      commit: e4eaca5e30c55c83c547974188afc2b2d02d4f0c

Best regards,
-- 
Jens Axboe



