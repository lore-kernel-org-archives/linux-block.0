Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8064F1E52C
	for <linux-block@vger.kernel.org>; Tue, 30 Apr 2024 21:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714513030; cv=none; b=P3GQ4jR4jJjevtXytj4uLpKtC71qqdZCTKCenLvtoo+4/Vz8Vk+Ycfid+BdwBfYxji7mGLrHeFSRd7QBJbgwQV+QDWjUdkeeBKt4HsO5NJFlPobeor8j7JoDHBx4tzC78YewfBGPvcqA77sA1+tVezBl06R1QpTGbQXsq2ebv3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714513030; c=relaxed/simple;
	bh=kOVBn+L8m+KGx+xWui9qhwHE48LPdqGInZLL5XjNFQI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EMWxcKgvJChotYDpqWu2MCd/Tm9p4AH2i4/j9+l/xaKnyHSAFd2IblIwXWGxHR9W7eqK93AXKDKzOYFoZCXlVEJFEnioHtz6e8/K5TqK4i5eQxma6mbmTitbEdP/54f7bLlMmUeSgrvUuLWL0uSkoTcuzIGYjWjoCwm540ZRuyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cb4m8sR5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cb4m8sR5"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e4edcde7a1so1168245ad.0
        for <linux-block@vger.kernel.org>; Tue, 30 Apr 2024 14:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714513027; x=1715117827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsXDFuZiyvVk+tVFuwao6+tHBHPTn4kHu7I5bTNLw68=;
        b=cb4m8sR5tKjHECuSToVPA9/glaCGh0KUDNjOU9rnA+legAFdjnT3+up1WBJpRrfDRf
         aezUBqIGURfBHmYM/KsfX15F3VjJNI2i4+gqwcbds9bnunv4e9qUhBcsWeQfZWcOC7d5
         P8+ORaGcdoxnHYX7TJPrMsGtxoS1hlkXuHtfL7S8IlOsehO0st5xS81Rd7FQ4hm7oveK
         9H9fmxB5FI+NhXDxvLhkHvWLhTOrkm1AQZmOo8nfCFfwEOrQWFrFl8Zw/NQdYr3gHtr2
         LQuZTDG/jvJN9jn7qsQdQcyQepzQR/pJdrtfJfW8exj/QxyFUo2iqe8X+vzeR9XiDQ95
         bMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714513027; x=1715117827;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsXDFuZiyvVk+tVFuwao6+tHBHPTn4kHu7I5bTNLw68=;
        b=ExVClOcbw/mmN8hBglIK9Fl7RTbJx+S30rpDhc7Z4jDKw74NNOSlPRJSMbkPqUoWn7
         vTu2mkfqM00zAeokqMjNqS+jY14er8b4Co+SueHmOgXifCvn7H3OMqHAU3/xO8CYwO22
         Bld0yygK/MZhglzadtRo0AHG3B1wLetHLv8nCAl+YdkREU0dT+sMEW0r1xkDwA4lBToG
         p16XO3+tWaW/8Az2SITaLhRn7KaS1B1hvwaEwGAbbuIHUMEvgPBIi5IP/dzKRqlvMUsU
         P/bbIX5fZWC3c4XewbhoO0ImSkz/eGx84P/7JyCAlrX8lS8jV2ygdvnp88xNno2OMTF5
         +cow==
X-Gm-Message-State: AOJu0YxFTsLlZrk3oLtfbYd0hgRA6ShMmbR6KtjbSQK6ntAbmpWIBKsB
	/2CSCTCzgZgIE5RvXRvXCc2QGTFZxUYU3XJRRz7J+vedLnmhB8h+5chbnedgY8n1UiEH0v+N9J6
	8
X-Google-Smtp-Source: AGHT+IFskMVR2XTWlnojk5XC5/Xi3NVEgsWVudcqnuGTpHqfDXnpj2j+qOh9W7M7C5ZyxQI/KXyJtA==
X-Received: by 2002:a17:902:da83:b0:1dd:b54c:df51 with SMTP id j3-20020a170902da8300b001ddb54cdf51mr681464plx.4.1714513026759;
        Tue, 30 Apr 2024 14:37:06 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id c21-20020a170902b69500b001ec70d2b5fesm787701pls.197.2024.04.30.14.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 14:37:05 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@infradead.org>, 
 Uday Shankar <ushankar@purestorage.com>
Cc: linux-block@vger.kernel.org, Riley Thomasson <riley@purestorage.com>
In-Reply-To: <20240430211623.2802036-1-ushankar@purestorage.com>
References: <20240430211623.2802036-1-ushankar@purestorage.com>
Subject: Re: [PATCH v2] ublk: remove segment count and size limits
Message-Id: <171451302531.24801.16357937130261445082.b4-ty@kernel.dk>
Date: Tue, 30 Apr 2024 15:37:05 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 30 Apr 2024 15:16:24 -0600, Uday Shankar wrote:
> ublk_drv currently creates block devices with the default max_segments
> and max_segment_size limits of BLK_MAX_SEGMENTS (128) and
> BLK_MAX_SEGMENT_SIZE (65536) respectively. These defaults can
> artificially constrain the I/O size seen by the ublk server - for
> example, suppose that the ublk server has configured itself to accept
> I/Os up to 1M and the application is also issuing 1M sized I/Os. If the
> I/O buffer used by the application is backed by 4K pages, the buffer
> could consist of up to 1M / 4K = 256 physically discontiguous segments
> (even if the buffer is virtually contiguous). As such, the I/O could
> exceed the default max_segments limit and get split. This can cause
> unnecessary performance issues if the ublk server is optimized to handle
> 1M I/Os. The block layer's segment count/size limits exist to model
> hardware constraints which don't exist in ublk_drv's case, so just
> remove those limits for the block devices created by ublk_drv.
> 
> [...]

Applied, thanks!

[1/1] ublk: remove segment count and size limits
      commit: eaf4a9b19b9961f8ca294c39c5f8984a4cf42212

Best regards,
-- 
Jens Axboe



