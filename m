Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6863F8DA
	for <linux-block@vger.kernel.org>; Mon,  5 Feb 2024 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152903; cv=none; b=DbuK1OxXvwkrQ8NV3lVcKoJKTumcTA8wMaZoHk8tLSrjYOaaTSHBq46ypakE8Zpg+Ot5qQb9tlLvWZ6W/VZFgtt2gG6nX5rJrnYCAYxHAYPq8fglWg6AyKz452l+afP0D6qi/ASbZ7Z48a04J05COD3v2Xpnq7g6f/RX5AMd5BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152903; c=relaxed/simple;
	bh=8AefJ4FpqeftLJ0655AIGPLXfD8D13NEQMdqGyv0tEw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gwanck3Mo/UKHj+l73ln9tRj1DDbTH2D9ln8JpMSnpWt4B1kq1hWLS9m67dLtQkVkM9NqD2Ldp5RbtTCPClqVU4MVv9P+l2W+oO6Py2/QBMlaPExgSBBbMefoePsjjOvhJrtxqkapPdet0cSLFoYCoZodkEGshbd34Z2rDw/nb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WDE7Mozj; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WDE7Mozj"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7c3e06c8608so16362039f.1
        for <linux-block@vger.kernel.org>; Mon, 05 Feb 2024 09:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707152897; x=1707757697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zzveQN84z7FAXQD8qzua9lNHvTtJuTssKVm3UoyZLc=;
        b=WDE7MozjXnoNXFtj4MJOkqyN7COrzfY+gS4sSxHOgjsS5Cw00FyfBaeYBtvR/lf2zU
         vGoaZOKZt9zdjfAuEIMpJzdAE0UpngKgSuCMoqaXWpMlRfss+PIng4UJQw9pu/I1/Owd
         JekKGUGy9n7XmCM04+tZ2Dv4hh0r3ByenmwPU0Jqt6gXU59F/hNlXY7jpsdGthcqSyPD
         dauiNlnnUz8+MzqaszNGD1HTNngB2hncX9GbMvRoI3dcn/Uxnt5+xgDJMmcMDEWD7wH8
         DGkL3tOvzKnCb8b8/Q0pQwl0KMfyCcv2XsEYL1HxAAvbGm0Jd73bz24J5F2JRlIo5cNk
         vKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707152897; x=1707757697;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zzveQN84z7FAXQD8qzua9lNHvTtJuTssKVm3UoyZLc=;
        b=WfCGDqC9cVWN/P0z+WXyqtuEUT0zEn9ytLtwL1zvkSo98nBztxU+yEhKb4ZgnoxlYQ
         aUG9fL9BFpg2FNFKue6vpmv+XB9m7VkZc5tKG+Ecfkx+QzYXAy8K13yQFE+QsJ8ziPgw
         9MfrEM9/zdm41euziAvlmijW6HZRVxp6Gkq8B+tyWd6J0N7ETAcobea3bDPwGa+qHZ0+
         EiY8MwTVrfCT5TlQ0MAHDrbDdx5SSscU7Y38XTebLQWmCtmgeVF9xiu9WHAWqk4ITqqE
         4mFzcIO5qHmKklmiaxG8lYIKHR+HGH97MFwkhZOQEOUGSrJC43IjH3ZWfp94PzB+judb
         eX9A==
X-Gm-Message-State: AOJu0YwTTZleh1XSGpfc/RN2QX6FgVRUqn21s1TBlo4PifP/VuPoTtkn
	0xn1nyivqYFXqTDO+USH6Uuo+7OfiXRWK30STpCRBKxZyU5gf/ogs/h8V1sxvJ4EgtXLBMk1sYE
	dtls=
X-Google-Smtp-Source: AGHT+IHtLRB5EY/fY3LFPUZ4j6jvDc4zFox84EDUoCb1lP7bxUg+yq+I5iRZiZz8uxejTZkArVqJsA==
X-Received: by 2002:a92:c266:0:b0:35f:bc09:c56b with SMTP id h6-20020a92c266000000b0035fbc09c56bmr440521ild.2.1707152897178;
        Mon, 05 Feb 2024 09:08:17 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l5-20020a92d8c5000000b00363c8049f30sm22479ilo.50.2024.02.05.09.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:08:16 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20240124092658.2258309-1-hch@lst.de>
References: <20240124092658.2258309-1-hch@lst.de>
Subject: Re: clean up blk_mq_submit_bio
Message-Id: <170715289604.491374.17992244784908429544.b4-ty@kernel.dk>
Date: Mon, 05 Feb 2024 10:08:16 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 24 Jan 2024 10:26:55 +0100, Christoph Hellwig wrote:
> this series tries to make the cached rq handling in blk_mq_submit_bio
> a little less messy and better documented.  Let me know what you think.
> 
> Diffstat:
>  blk-mq.c |  105 +++++++++++++++++++++++++++++++++------------------------------
>  1 file changed, 56 insertions(+), 49 deletions(-)
> 
> [...]

Applied, thanks!

[1/3] blk-mq: move blk_mq_attempt_bio_merge out blk_mq_get_new_requests
      commit: 0f299da55ac3d28bc9de23a84fae01a85c4e253a
[2/3] blk-mq: introduce a blk_mq_peek_cached_request helper
      commit: 337e89feb7c29043dacd851b6ac28542a9a8aacf
[3/3] blk-mq: special case cached requests less
      commit: 72e84e909eb5354e1e405c968dfdc4dcc23d41cc

Best regards,
-- 
Jens Axboe



