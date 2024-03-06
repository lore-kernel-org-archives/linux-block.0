Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEE913DBB1
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 15:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739341; cv=none; b=aBSRwCQ2+ro+OTID1Ee6GVo2xWmIxvFo1UDUnE4UGlpnUCBQLgkUCEBHxR6TTaKxNZ0+9CoE+rXXAKJtehaXY0oZhyzUDBlMWt8L3pJz/yANQLdMTN1ejaRDHkPahvGxkcMjAb56J2X5wY2T25rmFryQ88r0OgNaugCKJ/PEvps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739341; c=relaxed/simple;
	bh=kBmyubjd7UqX7KtOVqXQPAZbNnvgLHXmvVx4xERaGw0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JTLY4YrGBHaxlJZMz5eWYEpKc/jgga6uHuioB2vcbQCsypndvBIypyuZgp/u1JeTT1AC61UJfm3smNTwuNhZKAMQhTlD+XZNa7EyujCdKpsFTL5s83YytiywGLNjTjkbnoB79qaEZNbwdzET5FS/vGuMcSlhNAPKIh3Nir/re2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FpwIAzl7; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FpwIAzl7"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7c876b9d070so12650339f.0
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2024 07:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709739339; x=1710344139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EJVyKfo/qJKp/5TYAxUmzDSOM9Yh6oX5oGW77hIJQ0=;
        b=FpwIAzl73aPw+9keWnzvLKc8W+L/8alNQLOHPbgMMF/ZO6X0TAfuWmq3UD8BkxrjCX
         sDddZ0i5bEUVefqfzKdb6Uz2b5kgE3fE6xgGYY7jezmCS7mglPAcehheWFdl8u/CkoII
         9uPcEhNc2U3+2TWFbHOO0RU/HVOlba8LsfTvnYQnXipsGU3/emRmj2LjWWRZTpAeMIGy
         NXR/afx1qh9TSjqLvywUwr295Rxyeu7YBm7UkPhfN55HmlpdJef0GLbUkfZx6aShaEAk
         H6aRYCeSqQSc60oiGBPiJqFgGPFg49ZUwa118YAu4n/Z104oOsJMz8iUzeinmbk11bwc
         7Wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739339; x=1710344139;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5EJVyKfo/qJKp/5TYAxUmzDSOM9Yh6oX5oGW77hIJQ0=;
        b=kKtXmkO+gOdQ7r7nJ6YQadRrjGXabXgmVMqMVvn1FYxRGlwiKLpPtOFyyzNtstQ2Mw
         whVvpKOB18UdSvRYnCEvVqYK4q7yXByVH7pKGUli5HM9dj81X9kdCfV2OZov+89n/2uD
         yV4z919GGs3R15prEYBtWMyDOpVm6l943SojHi3IuPPK1ptWJjClhD1K0ey6Uv7URZqU
         ajtEjPZ1AUCIQTNl6fCLllUdkNgP+DwA0U2qa4dK337ZtQth4bass0WaXicwVFHAx2NQ
         QUvzuL6wXUzqmS/6RbX1714sqUhaAxl/uKfaw4rdc/PMMLgzgzlMZ482cLH7lJhiHlaX
         UOnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyaaxv4+dk6OWXiZRli42pwnDpdJcHVi9c9VdSVqicYaEoVJzQxn80RjUXbAdFub3qdAsABzXJ/L0F2fmTkBOHC72EWjkZScrMV4M=
X-Gm-Message-State: AOJu0Ywg03uS3RuJqcI+7AuEzvc1icZWK/LioTUkPomf1lx5FenQvgKo
	6CDhcmZsFsAzY2Vo+3rqAOjoXmYKNz8tWmq1x8QbTgAnc4kCKJBTVuqzdfNF3Zg=
X-Google-Smtp-Source: AGHT+IExezYwLCdk1ah3myJ1ZnMAxxK9psbgLX+yx/PyyFKASpLqrBrwGzpYSdEwh0JY5dYcBA98SA==
X-Received: by 2002:a05:6e02:1c46:b0:365:fe09:6431 with SMTP id d6-20020a056e021c4600b00365fe096431mr3733556ilg.3.1709739339446;
        Wed, 06 Mar 2024 07:35:39 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t2-20020a92cc42000000b003660612cf73sm324467ilq.49.2024.03.06.07.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:35:38 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Coly Li <colyli@suse.de>, Kent Overstreet <kent.overstreet@linux.dev>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20240226104826.283067-2-hch@lst.de>
References: <20240226104826.283067-1-hch@lst.de>
 <20240226104826.283067-2-hch@lst.de>
Subject: Re: [PATCH] bcache: move calculation of stripe_size and io_opt
 into bcache_device_init
Message-Id: <170973933779.23995.9027032366565112081.b4-ty@kernel.dk>
Date: Wed, 06 Mar 2024 08:35:37 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Mon, 26 Feb 2024 11:48:26 +0100, Christoph Hellwig wrote:
> bcache currently calculates the stripe size for the non-cached_dev
> case directly in bcache_device_init, but for the cached_dev case it does
> it in the caller.  Consolidate it in one places, which also enables
> setting the io_opt queue_limit before allocating the gendisk so that it
> can be passed in instead of changing the limit just after the allocation.
> 
> 
> [...]

Applied, thanks!

[1/1] bcache: move calculation of stripe_size and io_opt into bcache_device_init
      commit: 34a2cf3fbef17deee2d4d28c41e3cb8ac1929fda

Best regards,
-- 
Jens Axboe



