Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CDF14B96F
	for <linux-block@vger.kernel.org>; Thu, 29 Aug 2024 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724927605; cv=none; b=de9gpiTxdTi9yL7S0bSbOOsmap5EGJXwu2dT06IAInDnutAHHuPXuIA6UYL3rVGNiMBv2K6I1LzRB87SQiuf29zezdCSGI9nmoWTfAE+Y5G1Vxff66V0mfi6yXastiHgnP3dY7UAZonBr3y1ze99PCWxQcJWkDn6QIPxvwDdsh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724927605; c=relaxed/simple;
	bh=ePFONNT4JBWZE5LLbd2PnO0bH792wSm6u1Gt8XUn1g4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L9unBqOoXTvSOhXt5cfKZCKRo2VEtZyTx+A2Ks4bo1X6JSZ+dnL0vWGC+3KI+/Ccx9sx84fn3Bpe1MpGs8O/go3oCE1022ZET+XpQlR5zQOu6gfUEERZoEHPkmLgUOtVxSH+r5E2Ns8BI8siwg9VQZVVcfB/Z2cYyKoW/bDyKek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sfXXXlDl; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sfXXXlDl"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7142448aaf9so335162b3a.1
        for <linux-block@vger.kernel.org>; Thu, 29 Aug 2024 03:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724927602; x=1725532402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Va1B7yZjdvPCSOy59Y/n2CAyZdY+ONap4VqcVCvTvt0=;
        b=sfXXXlDlTTdRBcQxxI6gT8mR9IBYvZFjC71ByixsgKNO/8GQziriFa/Esq+SV+SF9s
         WvLlT99JGdPkEkCa46C39MrColH7k1FL9OsjT8rjwtbBN5xaX/+XGt2cgegrWBacGK7E
         aoJBwHcr2L7nUqrEI5FQit2LljcmzaL56QF+LKPNZ7WByfxc+fih9LBcFqcY+jMtrsbt
         WoY4TjGG027XAatRFUAGC8xq2/nY2uLQbQGxpQ0ml67RH5VfVBWInuqy1Q3qNriw1/nV
         Ue8D/iWhsMqeDfByakGtr9qJ297lPaU+kfltifUWMMZeGcmWevbIYintDOWtuBxp1fgj
         LOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724927602; x=1725532402;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Va1B7yZjdvPCSOy59Y/n2CAyZdY+ONap4VqcVCvTvt0=;
        b=lVFo0yUC2z8lBP2/CV/wHNWkxJ/pKmW3OTE8ITVF61YVZdr/9OoEGbwqGpS2AZ4v8C
         MTHFu4P1K7mCH3yMNaNdA2B8L+jXeMuVD1aS+aBQlCDmgnulHntNa71NRicsWnTIWG5n
         64K5k1C8w53wb49fSUkgE/Sd39VDMhloSTLRWfEHH2zNsaN5kmBoTPvp7LQYCV6KRVHU
         dfyKpV0KeU05dCxbNUIH06zRxSQTz8fxbl3zZOh3gt7/dhPOEDHdAWggrH96rIpMYhww
         BMkVAlEXkqXycomsMBiX3mr0Z4znNyqicPDPFMxx8hxqrdsgM3P6MS+Phn3MdGWNSMXT
         6S/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+yoAruJjPffRYhOnSv/dKI4hBQu+A+7+zg3FwCFdRwKbeHJ89nX2iVKiRBQblHLr37HxqIqx3sl9IBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAUrvqmloyqwjNjFcr1sBp2T7FddcvDMtSFv6kZI3ij++vuJ5B
	bE36pfRQZoWI4DyNe7iIcvO0oW6mTHtAMghTxtspZApSgroeNUKNXNHAchXXcgw=
X-Google-Smtp-Source: AGHT+IEY17OXNLJSJhnojd4PPrAHmEygRhNdtDK31kywPE4iwKLbttLu05E25ysMH3R5p84tiSfYLg==
X-Received: by 2002:a05:6a00:3e0a:b0:704:151d:dcce with SMTP id d2e1a72fcca58-715e78562f3mr1849169b3a.5.1724927602321;
        Thu, 29 Aug 2024 03:33:22 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e57629e9sm842881b3a.211.2024.08.29.03.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:33:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Hans Holmberg <Hans.Holmberg@wdc.com>, 
 Damien Le Moal <dlemoal@kernel.org>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
In-Reply-To: <20240826173820.1690925-1-hch@lst.de>
References: <20240826173820.1690925-1-hch@lst.de>
Subject: Re: fix unintentional splitting of zone append bios
Message-Id: <172492760103.439393.3318673064085368440.b4-ty@kernel.dk>
Date: Thu, 29 Aug 2024 04:33:21 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Mon, 26 Aug 2024 19:37:53 +0200, Christoph Hellwig wrote:
> this series fixes code that incorrectly splits of zoned append bios due
> to checking for a wrong max_sectors limit.  A big part of the cause is
> that the bio splitting code is a bit of a mess and full of landmines, so
> I fixed this as well.
> 
> To hit this bug a submitter needs to submit a bio larger than max_sectors
> of device, but smaller than max_hw_sectors.  So far the only thing that
> reproduces it is my not yet upstream zoned XFS code, but in theory this
> could affect every submitter of zone append bios.
> 
> [...]

Applied, thanks!

[1/4] block: rework bio splitting
      commit: b35243a447b9fe6457fa8e1352152b818436ba5a
[2/4] block: constify the lim argument to queue_limits_max_zone_append_sectors
      commit: 379b122a3ec8033aa43cb70e8ecb6fb7f98aa68f
[3/4] block: properly handle REQ_OP_ZONE_APPEND in __bio_split_to_limits
      commit: 1e8a7f6af926e266cc1d7ac49b56bd064057d625
[4/4] block: don't use bio_split_rw on misc operations
      commit: 1251580983f267e2e6b6505609a835119b68c513

Best regards,
-- 
Jens Axboe



