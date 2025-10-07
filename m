Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE582E228C
	for <linux-block@vger.kernel.org>; Tue,  7 Oct 2025 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759845977; cv=none; b=J//6a8vd0Tu4W0gCPXuB1u6/o8kVqEoUnLfFKffrExYY+A8wZ72J9Nxws7y2iA9ExlN5Y3KTJyKh+Je2DtmkzSPACy3YB7Zb0AcCE2y7+K3vtD+UHqM0t0vQbNF8Fuak65qLfG0uECTVsuMVwn1azh+o77+8Q+G47HPACzJ4W/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759845977; c=relaxed/simple;
	bh=fjdxuOZIIKTBFnGbt8BiSYL43s3W7LOHRhTmhdZPtoc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gtoCvoL1WixskLZ1+uXKiVIDFUknFlFjZXvXHlGKCYkhTL2kNQlzaSsK2LTWDXdeK5RajgkXxDJ2mrY/msrEYR9knxhMj+GvEgt5xgK+jGN85+cjdD5LYH5KPeKWvhklEUL2IhIoV0+Kq2/1y6afq4C3GjStha9V6XzHC8+aOW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VNCtT4pG; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VNCtT4pG"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-42d8b15548eso28907815ab.2
        for <linux-block@vger.kernel.org>; Tue, 07 Oct 2025 07:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759845975; x=1760450775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYE/CUIQBS5jsZUtrSi2N8ZQe5xNsIdhpklh9KQF4U8=;
        b=VNCtT4pGNwHD35EBtJzmsd1iFtMXeINN+5O03dQCZXgnZbUnt91nlGGT0ES3Kc8PAk
         TTTgicCCuZb+ZuKczkSv1a2EsCZsaVfd2xuvgqCozNzPNjBUKv0uvsptUNcAbhLF422E
         RcdMYmWLJXzRLfLbaLPS4Bq5+h7IR4VvQwD5/VPbjmP/jGxxw9U0BZwUBwRk6GEw/+xd
         opxD52McxjqGvUcVCrjRlmLFYFVgAvLAKNcXGAONI9pj8ydEMkmox+WR/JmaB3EG+q0V
         iYb24uWnsddjqeZ29n/q1j7X6TciHNoz2tXKZwFJA0oTlsTjiJSEkCeZUktFgfZEYtiu
         Taqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759845975; x=1760450775;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYE/CUIQBS5jsZUtrSi2N8ZQe5xNsIdhpklh9KQF4U8=;
        b=qU8sIsC1N/KaI7b2iwLrsUgK65Rc7Wc/r+dwAO3pS3Xiifm/Xh7XzNaEtGZrMoGMsE
         LHkmpMQPZzX1XgEexnUJcS9ErNc5wPcdgFARKWoZ5RHprHa2FOoEY8ooKrRAVZMyB1hp
         XalONsjvSBGuO/rRjsjxfP6GomJ52rL86wvkPtK7M0uUS9Wq+PF0OoJow4iu8/BQPZFp
         qNi3wXJwCYIzDr2ql2YMSIduAX3PeT8pIHhFVPH6Y7jsMuzuPTopNjFTUbIcreX8GQXj
         Ge/ZrM5SuIX13nukg64fdZ8USwIiYH9sT9MqVtxRDX+yzVFxhX06vVwE4A7ZPG+WDhyY
         3kHg==
X-Forwarded-Encrypted: i=1; AJvYcCWIj1U+5MuTyGv0mhFmpeyly1uS8HV1YgKOqXzX84gS178UAOfI+ZRJxoP53cxYeOab2kEE+1BB4Vb1og==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+4BtrZs5/h8T2i86KkCP4HMco/RWJgBNnIXbEHaePxeurtcdK
	uawjF0G01fGJ3jCeeo4kgetDz1RAuAaxWhwhgCHx4NMebYT1TaizVfrOscdbxKyzC8o=
X-Gm-Gg: ASbGncu81wKXKE/us1LDEvVf4vrt783hmSd4sL6q5OpnSAdQfgYQPdssCyzDAKKhzMa
	zWUp0q5eJOiHV2LhcjeFX6OL+HfWwrF2EdhV1HYAWDKuETKmnuHGWkuWEeHVrjeXwrdEu79B7wZ
	DrV1QKDhot+1E3G/QTKESqwJn17i/u8KPi/xaA8FDlTu57TWGr1aCZ03mwGa4L2BsuHvCdkq1GY
	5ye/ZgSP0271j4yCPUzQTKwqO8YoKyGFTqcl0Ib+YhiGvxcNLK/OGf70GBCWf/SMc2VG+2wJxCR
	nEFfNvDJfTWu+eJljh7MauQGBwGy6M9EtETwBQVu8MZBBdko0ni84+bsn0zbgEVk8VacPHwapRN
	Gyt9BXPaChNErIz042Coy6EOKOyHwt7bbHiq/4Mk=
X-Google-Smtp-Source: AGHT+IGTaxS2obF6DcRXirMiDHelPrK7itEjy38RGBMWS7xHKp5jOZJcVBQvzLTNYmGnYeGRxMUAUQ==
X-Received: by 2002:a05:6e02:148b:b0:426:7dd6:decd with SMTP id e9e14a558f8ab-42e7ad83f76mr237542175ab.28.1759845974471;
        Tue, 07 Oct 2025 07:06:14 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ebc840bsm5970425173.38.2025.10.07.07.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 07:06:14 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Keith Busch <kbusch@kernel.org>, 
 linux-block@vger.kernel.org
In-Reply-To: <20251007090642.3251548-1-hch@lst.de>
References: <20251007090642.3251548-1-hch@lst.de>
Subject: Re: cleanup for the recent bio_iov_iter_get_pages changes
Message-Id: <175984597382.1934957.12416846170615404120.b4-ty@kernel.dk>
Date: Tue, 07 Oct 2025 08:06:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 07 Oct 2025 11:06:24 +0200, Christoph Hellwig wrote:
> while looking over the bio splitting issue reported by Qu, I noticed
> that some of the recent changes to bio_iov_iter_get_pages lead to
> more indirections than really needed, especially with the bcachefs
> abuse now removed in 6.18-rc.  This small series cleans this up
> an prepares for the file system block size splitting needed by
> btrfs bs > PAGE_SIZE support.
> 
> [...]

Applied, thanks!

[1/4] block: remove bio_iov_iter_get_pages
      commit: 1ed06c83506ecaaf1836ddeb7c65772ff86d8d53
[2/4] block: rename bio_iov_iter_get_pages_aligned to bio_iov_iter_get_pages
      commit: 82dd5d763c9b718e2d655b9565e0a06a91bb83dc
[3/4] iomap: open code bio_iov_iter_get_bdev_pages
      commit: cb6d51a4115781fd9de6108932e866a332e38406
[4/4] block: move bio_iov_iter_get_bdev_pages to block/fops.c
      commit: 506aa235f6e0baa00bf792df82a5e9f618b7a5d8

Best regards,
-- 
Jens Axboe



