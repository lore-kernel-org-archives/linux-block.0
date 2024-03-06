Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B1E13D2F2
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739340; cv=none; b=dmXjyda4s5JYshrelB24nYtH/4K02ozx6Kps/HPKjtBq5Qa3CnyZaNXQJgY1y8shPYE0mJUtko3rPNeFrc8DQ1dKG1gfjCos/1/jXCiu+qo5HLpywZWAyJNfvMs/HGE2bMxxTY6ANbw2ACTEJfxfRrEHWAF4/Ifn0QdcpXCHaFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739340; c=relaxed/simple;
	bh=dlzFF8ObzsH/OfbzCxANapBstTJQr/v01oXqmmsQbFM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GeGGKyNtLorqnuyEQqH5ATQanOsJOkAnaQ3lkmgzWdLMkzpqJYJkQZLetdIdvcOnnaiAJR8Ic1BBU5DTZ1ZRQp+la8fPwcdp6W0pAwXntkf89Ud+50zbi2gYKiD5A9g71eNB18rpr64Q0VEbC88zPiH4PHs6RhlfuQoJQGho7gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vAlt2blH; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vAlt2blH"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-35d374bebe3so5646695ab.1
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2024 07:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709739337; x=1710344137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iXoKZxEz8wDbvy0Zd5wIeCfXYitdQjVAg5WmFnT5ts=;
        b=vAlt2blHR2XbHGyS10R/eavclxlB85BXpjYOGcuQcEMGVWsaJf7X26QSNM118H1Hmb
         sCMEMEyOxHOGnOMxcfxzzLfu9Llq6m7AbxouV/Gg3kH/VeY5borjV27dH5N9TnJXTOBi
         7FNsMw+8UZ8fmZUxx/d9/7sPlF+BdqvK6LNbrGUncmg4Db7n/JbgdA6KVStgaKSZO14w
         c0/PWMhxUQ2NKRIiMW3y7+iiDQA+LCzAY+A8ZAsZU0Z5t8Q1wsoYpRIuXVfaraFcwTld
         X0XuO4+zGFOzzP1SJoOjni7MjniyweuZoJZmfcTyZwXtTcITV0/9JD3ivyAmFmw5hz+q
         wmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739337; x=1710344137;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/iXoKZxEz8wDbvy0Zd5wIeCfXYitdQjVAg5WmFnT5ts=;
        b=kPWDs4mH7xYXxMnhmJhE8aw/af5s7MCCw/Dh+OgNg37w32swpGm4bt3b8ozSaR8oOF
         Gad4go7hG/j2iXJjUdamES43knlfhgkHKYd6SOUHBNf7Yf7YudUYZeFsuLsZMwEBFZqT
         9bN8Aaz6h5PNL2e2aWkb6yoEOUZ057wdUT6XtWSsDo/rSM7k1DSHjQjYxh3loSp62G/j
         gitDZeDastO4XtwAIy8+b1YpPo+pHYdo9hDA3LLF25yK8uSgyqj9AXOyeFcRNGhcWguW
         TPATv0JuAZQ1qyyonH/4WRvUn/mGDcG/l4i0qAipRxf6yfrD0i98HXQdlYCAwb/FMLzh
         7USg==
X-Gm-Message-State: AOJu0Yxg6Jb/NPywOSjJMnX0Psujd36Ahkx/xWhUyF0NOa4Ye+n46Pu+
	6+k5tyoKFC/jPrtCgRv96P4H46LGFXEheN3fGKgj9bQ/xjvI/Co7bbcCtHBY2ktoZbosal6+N+Y
	U
X-Google-Smtp-Source: AGHT+IE2N7ChpiYdsarGfua/ewvaYuPL3BGYLSBLHYvtNJF9V9zFMIPOVppWv6VW7e7XyjsVom8WUQ==
X-Received: by 2002:a05:6e02:b22:b0:363:cec2:e344 with SMTP id e2-20020a056e020b2200b00363cec2e344mr3652519ilu.2.1709739337607;
        Wed, 06 Mar 2024 07:35:37 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t2-20020a92cc42000000b003660612cf73sm324467ilq.49.2024.03.06.07.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:35:36 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20240301192639.410183-1-dlemoal@kernel.org>
References: <20240301192639.410183-1-dlemoal@kernel.org>
Subject: Re: (subset) [PATCH 0/3] queue limits cleanup
Message-Id: <170973933610.23995.17893999177654098848.b4-ty@kernel.dk>
Date: Wed, 06 Mar 2024 08:35:36 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Sat, 02 Mar 2024 04:26:36 +0900, Damien Le Moal wrote:
> One fix and 2 cleanups to go on top of Christoph's queue limits work.
> 
> Damien Le Moal (3):
>   virtio_blk: Do not use disk_set_max_open/active_zones()
>   block: Rename disk_set_zoned()
>   block: Rename disk_set_max_open/active_zones()
> 
> [...]

Applied, thanks!

[1/3] virtio_blk: Do not use disk_set_max_open/active_zones()
      commit: 0e46064ebebb90b02c53283106f26600aa38c986

Best regards,
-- 
Jens Axboe



