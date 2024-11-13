Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFD916F0EB
	for <linux-block@vger.kernel.org>; Wed, 13 Nov 2024 18:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731523610; cv=none; b=WBdHW+Z9MolZAaQRUvefYRQZOjFtwf8df4fxqgZEpUfCwa/lzcljs1A4KDFMQGs56zygaPD1YN/O0kiBO1qAF357nvE2A8qkXiEFBPkWMq9mJEtj3Fb/EeqTyoDRjqpuCAtkzwjisaUVP7zC5Oi2tw8u85JCYnzQvc0XdPYU7es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731523610; c=relaxed/simple;
	bh=bjjmahyNCuDcOLFnSRDq1hTf8a7Q4M0XE3GdCGOoN+s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T/iwWDwH7R7pMG+04V/aMcHYPaK46RYZGGEu3dwydhFIwQH3FkVYgawMQYCTuT5IXKhNd/8O/QMcyH0vPYYyRKpQercO7Jrrv0hNNdo10DWTa6XX4vy9uVoxsU5kt5k4DRj9uGAu0hbY4MCkf5rBuA+Sj+Nw11X/h8Xfyjsr9tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HrYh2Zfd; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HrYh2Zfd"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-28862804c9dso600457fac.0
        for <linux-block@vger.kernel.org>; Wed, 13 Nov 2024 10:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731523607; x=1732128407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Y6LZQ+uMnK0S2LY6YW0GGjZ/J1h8Erndb3dSaVvNh8=;
        b=HrYh2Zfdu9OAmuzooQQRKHi1LLIPwilwqIlwCOffSRr2HAJ5H1VjWywPoLWDNJJ7ZX
         1s4ZBo1n/2k5Y/LFuUaSCQMtVrNi+Is4IU0juGMyT9reMN7h9Md6hvAG9nIM2ABwNszf
         cfMSN3iXbg5vqQ9DaopJFoBPTocTKybygj5lEJgnoJhj4znfFCR5HPWFUH2zC+7yzpKq
         GaKV4ZudhXkS/VZfrVb5SrcQh0j33JKVR40TYaZtLjXtSJoQv85QpJmyvJ1HYLlYnuJL
         92v6MaryJk2AC8GZTjWup8hs65V3O+ZAKtKbwR6lrsR0kPoMV6XcnIDvEKiY+RtVHrHd
         oFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731523607; x=1732128407;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Y6LZQ+uMnK0S2LY6YW0GGjZ/J1h8Erndb3dSaVvNh8=;
        b=EaQ61AiurV7LiuT1wlageyAMMntNrXrDUWfewRJ6MTpPUlwNWbge4lLWF/SMdHmoHN
         zA9S3VcOvhGmQrqE6aNw4xUmCbzQ/0pKenSS5WaQCDOzmw68Jnuvhriri346okuTA4Mt
         Owwd/kWwhXbqmrfeMgFddxxEVVCVKtfz8WqHd1znIp1UXQRnKxGQveMO1RIsc+AzRsfH
         7QIrvG1er8lLIo57xB8eb/l7YaHNvKX5/7IPY44INicd3bmz82g98Tj2H0yLz3IWSV6d
         zDjSHwHmHet7leTEIuo9FtUyWRh2ZZ/ZTrIOWWh386031U3wG27ktqBcrec0u28pk4Sh
         FyFA==
X-Forwarded-Encrypted: i=1; AJvYcCUqYoR3uZghI3xH4HlzPvFXcrTs1+VPa9tnGoYIlBdqe6ekqjuUmRTHo3byW3RsFlXuhTTpus8wJQcc1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8kgKn3xEklBfkqIwvJJ858qIU7BW8m9TQOQutrQeUjQn10kqK
	U4+VLB6OwnR2vNrbOotbQBllvuYB6JmqL7TXi65s1/ZxwA7gSbD+gTRvAYcu6TI2OA0sGOXCZ/i
	B2Vk=
X-Google-Smtp-Source: AGHT+IElqrUcRF3HfiSejpBqxBPsTzd7rzIjNzdtYsCTXlXDVD2IYEpSiVKFvfLa6IZJOe2HhDecgw==
X-Received: by 2002:a05:6870:2b0f:b0:288:3915:db28 with SMTP id 586e51a60fabf-296069ed640mr386417fac.5.1731523607575;
        Wed, 13 Nov 2024 10:46:47 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-295e92afbcbsm1023381fac.40.2024.11.13.10.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 10:46:47 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Yi Zhang <yi.zhang@redhat.com>, 
 linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
In-Reply-To: <20241113084541.34315-2-hch@lst.de>
References: <20241113084541.34315-1-hch@lst.de>
 <20241113084541.34315-2-hch@lst.de>
Subject: Re: [PATCH 1/2] block: export blk_validate_limits
Message-Id: <173152360663.2243093.16019874347039852484.b4-ty@kernel.dk>
Date: Wed, 13 Nov 2024 11:46:46 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 13 Nov 2024 09:45:35 +0100, Christoph Hellwig wrote:
> While block drivers do the validation as part of committing them to the
> queue, users that use the limit outside of a block device context have
> to validate the limits and fill in the calculated values as well.
> 
> So far btrfs is the only user of queue limits without a block device,
> and it has gotten away with that more or less by accident.  But with
> commit 559218d43ec9 ("block: pre-calculate max_zone_append_sectors")
> this became fatal for setups that have small max zone append size,
> as it won't be limited now.
> 
> [...]

Applied, thanks!

[1/2] block: export blk_validate_limits
      commit: 470d2bc3a0bc19a849cc7478c02d3f5ecaa1233e
[2/2] btrfs: validate queue limits
      commit: e559ee022658c70bdc07c4846bf279f5a5abc494

Best regards,
-- 
Jens Axboe



