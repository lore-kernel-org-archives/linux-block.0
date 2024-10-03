Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4293B1AAE38
	for <linux-block@vger.kernel.org>; Thu,  3 Oct 2024 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727978975; cv=none; b=HQvEs48GOrrH8MjNbuQkQURyCI34uWTUm6bTANSf60rSHuZxblInCF8LH+kiXy5no/rWqXxhlMDs8R0UyA5VpBYu9p9pSkry4i2urf1n6a75sagOIiXJ0togDV5mmUz7/VyMDWkuh/ofwvuPDla9hs6j5THU0nRLFZMwf66oAR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727978975; c=relaxed/simple;
	bh=hIbEfGSzbk9CuPKpySmuY0aeUQ2NHf6pxuqu3A66rwY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L57qfZde66D0VGGWf3GnEpwHToyJONDK/YYqVN+uXg+oKWKwHZNdq2VdE6x+8LimA1IEuEsR61loy98Kiuay57jv9gpE0VW9PpYbOi/qD7tcnmJzcnAs8LKUOYyVb9CnnAb75LzTYRcaZdLvfYtl7+TsPYxnEgxG1ja9YVsYGSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0DJFQ1l/; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0DJFQ1l/"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-82cdc21b5d8so60132439f.3
        for <linux-block@vger.kernel.org>; Thu, 03 Oct 2024 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727978971; x=1728583771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBAhHn6lq7uRizD/o8uMXzgYvkc+NDkb26zNzjvNzM0=;
        b=0DJFQ1l/2jMamVwLULkWF4OLEelJqmfR+EMRJU4N619D8vyIhH9ivU59Gz4E8w+OmO
         gT6BbQx0OQduobT33cdql3noYtFu3hxadq1WEeK2qv0M+lOEoSZ4GRTMMCwiKb7P/bCs
         V9R5WTrnbVbxFgSFmJsq7JrWbRuLbCm2isTJpJ8lto9wbxHmfggoEMoqY+ePjuQE7VdJ
         7E10ImUN1q1Trv+0aumweTG1xnrPGPglJA2K7FxGejrOAp+O8ZxDOD3CXLYp909cZem3
         zXl7Lb0PRX8Wfi/IaG7GgmAPRZOxRhGpA2ExkFr8x2d+ZcTiNGm7YPY1W6himl9B1H/C
         d9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727978971; x=1728583771;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBAhHn6lq7uRizD/o8uMXzgYvkc+NDkb26zNzjvNzM0=;
        b=ulCHDR/dw03kyEWNZUdLkjilwI3gtMsLg4hxmtUW5D2wsKehn4u5YCCq8TW8Fq4Sy7
         WOZSUvbCmuI+03F1Sg679nlZ+yVR9qH7n1/YQFG8fu+WVOhkUQGQIuVvWGjYM57bUkp+
         s4fGY+KxhYiHvMzhIqUXGjySJXiCWQt+njggLWB17x/U1o1jDAqT4EjOXmHkMSA+vtwP
         yzilPph8AlAsESMzr5jHvedqsJwKcmbZoUgj/6swyxmKFhi1gLceosMlXRXYIJDR/EWi
         6aJe+Snv7QXAPWOVpBXVqtCZmBL6eHkxmo+nlYByTLGyxGCG5zi9VDi4/nGlsggHOvtb
         To9w==
X-Gm-Message-State: AOJu0Yyvk/vxC9nrTwbeLN0gqqnzsKQgzgeL39ohiMqUxRc1lDVeTzMd
	KF0IZZW0ltXS+0h9/wnUOCTvaRi5ztB4XdInqa9n7udEZcNbOxixh1GSmkWPm6EimUd+gzI9jHC
	xIM0=
X-Google-Smtp-Source: AGHT+IGukIsRfsbc1Uam/3tynycIG7Xw1uSaFuEUfnPizgpc1ofGare8EpjmsGSWt3utbOuf46R7VA==
X-Received: by 2002:a05:6602:1554:b0:82a:539b:9838 with SMTP id ca18e2360f4ac-834f7c694a9mr15538239f.5.1727978970741;
        Thu, 03 Oct 2024 11:09:30 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-834efe3888esm36641539f.54.2024.10.03.11.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 11:09:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>
In-Reply-To: <20241003153036.411721-1-kbusch@meta.com>
References: <20241003153036.411721-1-kbusch@meta.com>
Subject: Re: [PATCHv2] block: enable passthrough command statistics
Message-Id: <172797896969.247173.9551686718114544655.b4-ty@kernel.dk>
Date: Thu, 03 Oct 2024 12:09:29 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2-dev-648c7


On Thu, 03 Oct 2024 08:30:36 -0700, Keith Busch wrote:
> Applications using the passthrough interfaces for IO want to continue
> seeing the disk stats. These requests had been fenced off from this
> block layer feature. While the block layer doesn't necessarily know what
> a passthrough command does, we do know the data size and direction,
> which is enough to account for the command's stats.
> 
> Since tracking these has the potential to produce unexpected results,
> the passthrough stats are locked behind a new queue flag that needs to
> be enabled with the /sys/block/<dev>/queue/iostats_passthrough
> attribute.
> 
> [...]

Applied, thanks!

[1/1] block: enable passthrough command statistics
      commit: 663db31a86bc7da797ec62f301ef0d6058ff0721

Best regards,
-- 
Jens Axboe



