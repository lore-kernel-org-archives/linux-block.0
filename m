Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E153350851
	for <linux-block@vger.kernel.org>; Tue, 26 Aug 2025 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218505; cv=none; b=urJzaO/IyJlV4L0SFpwU7XAVIp89vzmpd4WIrBatWR/bNXJhl/pWipWPv0whWHA1CDNf3eQImKr7yq0148uijvgXhCwg8pJxEmKMiViO8zmjuS5IC1coEB54PSbuKeil+ifj8b1+v8NuCGASwMdSsX+XbSgAHiBRZZg+gVtGp84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218505; c=relaxed/simple;
	bh=T/GeuEkhEShS4kBmCts4ZNjk1WVxEzT0RRPBn5mqGSQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AGGCTsVvOhkGrm3Nz0LlvnVyRJacN3zYOI5hm+vexL79FPcP3n+8MX8Kv5Etq14Z5xW+jkK8emrr28G5KupCM4dwUDwqrKI1SUVeBQC80JjZmstcOxgu9c+Fhw84GY8/KlX8hqK4ZTRldz4kvGeFB/JEuICkVFFB1R++qxhHAvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=guZU2F77; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="guZU2F77"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3ecbe06f849so12118145ab.2
        for <linux-block@vger.kernel.org>; Tue, 26 Aug 2025 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756218502; x=1756823302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLkPQj0bTtQGaQneRQZH7l/USU1TBu/2YhWca59eGtM=;
        b=guZU2F77yIVISIalMpYEInHNzt8/C8wv7vCeOONWMYOaADu1aLBQM3bkqZTeIJSizD
         E+doSIsnGzf6pK6fT0dxTwq0Sv9e7bcpnG05xMdeX5LfHgLmAdAEw1+w2Hz53YuLtXtz
         Vu0cihAdnvcDm6Gb2XggQ38aHoXwfKgNks1OGTMxknHZs2VH0YHnPJX9oSDaPe3+H82W
         Zr2aFiPoWCcXX8avH817ADpVY+ZQa/6K1DzEbxvPbVLkiXV7fjN6mnysS81pV1Cf5d1E
         NGd+DGj9YjdFj9XkQtdk0gl4KEfj92SdL3k+xlq7iRLW4saEAbzu6BneyLdchwviN6qe
         ymIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756218502; x=1756823302;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLkPQj0bTtQGaQneRQZH7l/USU1TBu/2YhWca59eGtM=;
        b=Pdve2YrUmKuxhFVrL7U6nHlKgEJ9/t1VbVuxOXu2GPyfrTl9NSvsgXCCKImC4gcJvs
         cWaZ/osU36/TY8d4af8iPdYDNOW+ey+N0OB6ba74XQ1D9GTPSMKmaG9mRVUn60taFQQp
         S8IeEALyJqztW2tXFktjLYTK/gUQjCDnzB+spi29RKPmXJjY0J+IunKC6xfyO8N9IL45
         lDczAHET68iVK8MXd4H19NpVK4+edaPofLqJ6+Gk3awBGpjgug2UAIRfyd6Xe9LCKRou
         cB9Kx+NCtailpRQVBokNDjIYqc8/R+hDGW/U+8Qz/Lu3VWqtgLi3YreuuFthfnMh8xBP
         cNhw==
X-Gm-Message-State: AOJu0YwR2rErxTvZhi51EKcuvujcPW8Kl5X5G60tSLopZb5tB/U/R/tt
	X8EJGu3vV2lIhVMSPLJOMzmrge8j9w5/PmIlhbm/z4qva27jAvJtUkABTwWjvBhY+bM=
X-Gm-Gg: ASbGncuOdSDYo6V0iU7ZRbspdz+MqC6keHLZnv+8m1U+5TpvM+rJegEZrgUMlI2EeKV
	k/8kmA+AakZC5A3DLhoZ0t1CiKlsBXlXLq9IwkB5nMrdQNI/iLPdwvsLjwyra6mEaSDjnQ+LVyC
	Q/6HxCmXdGaNdF97U1hD7eN+ZEdwh4uvu3MJ1uzH+ftXIQ4wdBL8aVdG9xtfPlsXLkx8hK6CEtr
	F5i8+txcStDBr/tx3qslWq9lzG+tR2u8iiR7iI7cMWa50H35IgLRcZc13+nB4Ojus1SNbFnBPah
	u5ShR2T+P5JILAgPYi9Mo8An2gpWXuCB5aF0/MP31N/k/YfnsZLmYaX0ybAFr24PboK0lvhnE6s
	vrSqZ7UAxBnv5Fg==
X-Google-Smtp-Source: AGHT+IE4jleJdusUNya84eGkhqt+gNPfD4hmAqQ5NjL3Z358rUdj2cUJ7v1Md9Sycy2S3xLZn8LyhQ==
X-Received: by 2002:a05:6e02:19cf:b0:3ec:6e58:beb5 with SMTP id e9e14a558f8ab-3ec6e58c207mr101102605ab.3.1756218502050;
        Tue, 26 Aug 2025 07:28:22 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ea4e457cc9sm70655365ab.34.2025.08.26.07.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 07:28:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 Damien Le Moal <dlemoal@kernel.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250825182720.1697203-1-bvanassche@acm.org>
References: <20250825182720.1697203-1-bvanassche@acm.org>
Subject: Re: [PATCH] blk-zoned: Fix a lockdep complaint about recursive
 locking
Message-Id: <175621850117.50782.16973257839568919161.b4-ty@kernel.dk>
Date: Tue, 26 Aug 2025 08:28:21 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 25 Aug 2025 11:27:19 -0700, Bart Van Assche wrote:
> If preparing a write bio fails then blk_zone_wplug_bio_work() calls
> bio_endio() with zwplug->lock held. If a device mapper driver is stacked
> on top of the zoned block device then this results in nested locking of
> zwplug->lock. The resulting lockdep complaint is a false positive
> because this is nested locking and not recursive locking. Suppress this
> false positive by calling blk_zone_wplug_bio_io_error() without holding
> zwplug->lock. This is safe because no code in
> blk_zone_wplug_bio_io_error() depends on zwplug->lock being held. This
> patch suppresses the following lockdep complaint:
> 
> [...]

Applied, thanks!

[1/1] blk-zoned: Fix a lockdep complaint about recursive locking
      commit: 198f36f902ec7e99b645382505f74b87a4523ed9

Best regards,
-- 
Jens Axboe



