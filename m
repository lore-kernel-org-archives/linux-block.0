Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC55714EC42
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805263; cv=none; b=l106UZeg/c+3eY3QDzDus4+LyzMPQgxbCtyAxk5YO2DBH9RBbb+Y07RYChVpgkSySt9Wihmo/Hqz0kWEdtK9qnqi19/YRQ3jlw+QjvQdA5zXUyI6aY4/6OpOrTapesT/kDstkghc2oDWrOQASXkKMhfUu7Gi/oz7Fg5eKiPJtnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805263; c=relaxed/simple;
	bh=xpkqazG6++afbEk83vkpLmSWnTiOgnZWcv/jTUALrv4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aNDmZjNwWj1imv0wd8nWleziRtccgFXoYicV6D+6+2YSqqMMr6f+OnrOW0Xc87hamDoHI9lYv5wNOHjMRUfJLTRf06g/qG/IM4gswGndqUFcNyJ0dxE1cwDqVsal0gxtZfMv4KLdo+dn+WJwpPD6lYsfJky3gFTqe/j8BK4dHs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MaRiY4d1; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MaRiY4d1"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6e3341c8767so199785a12.0
        for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 06:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718805260; x=1719410060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkDHd790kWmtvQ6UF8dcb7gjO3oHpCPMgBhaS8+VJfk=;
        b=MaRiY4d1qds/DjlSUOL5kNPU06HRjIVvMI2X3c0KSILjOdFvT1tgkbo9kqnO66OMtE
         yULRsb5fu8+FCt3qk5SLifHsNRkSAB9wRXhzd3JPr6lXAJ5s21REzaw244JLdgcHPREF
         oXKs0LuggaEzWFkIjKtEfXSxGpFI44z/5fzbvITZpTdP+h+7OXKbWIsspd35nYywlPb7
         HHwrtjyiJfT6AAZlRbOptU0djRGrL3ewLfyW38z6IDmCwYGfIVke8yj9Wv9NluUApu7D
         VtGNFHhVxvM5EKMApXwTmdVugBQZ6C4+iqUTAxiiztkoKSn3gqoYpk5A/nLVhG+HMa3y
         tmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718805260; x=1719410060;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkDHd790kWmtvQ6UF8dcb7gjO3oHpCPMgBhaS8+VJfk=;
        b=XH6A3EFv7/H1/o42zeioWr4kjiem3Sx6TLvs6C+X8BTOxMYEHCVdJOppmXyz5VkShh
         cExZvCW3LGJkm66FrVAOyMCDBSFXb/sJAjaN7f8fu1YY/V63dYHB8WBgSDU51eNqaQ5b
         4M2gGiMpjN3iDe88cTufZi5S60wneznZfAH9AH4kikgsoF6o3pFQ63r5sovvlPM37JHL
         AjZVtkRv7lzDojuzUSRaRDKoC2x46pkkf5S4iVEU3vXB4cQqf+SXwKGZ8O5z0cuGmipb
         uQP8Xc0v52U2E/mOZ4TUMc/YgpXcoEVpBipItrDB4A98YJ+FeSb4mMCDtVPmCo0KJ+b+
         bAnA==
X-Gm-Message-State: AOJu0YxYc7JLZkgKA3wOKF4W1KYLbcUuI7a0lxoMktOJMLF6cepSe67C
	UenV1GQ0tBKI7gc03nFbm9Vdgei5nsuQ7QJ+CwXY7SLk+1i+kSpZIr3NSu1768rGfDUtdelc/1c
	X
X-Google-Smtp-Source: AGHT+IHa5lmBL3cTRn8I7U6f9EAY1cpzPJyppZPZB1ibCn7ith2thKtjx5wQNTrWrGQBB2QxHoKaeg==
X-Received: by 2002:a05:6a21:99a0:b0:1b6:d2e7:160 with SMTP id adf61e73a8af0-1bcbb151a6cmr2662623637.0.1718805259647;
        Wed, 19 Jun 2024 06:54:19 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e56183sm116843765ad.28.2024.06.19.06.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 06:54:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <20240617-md-m68k-drivers-block-v1-0-b200599a315e@quicinc.com>
References: <20240617-md-m68k-drivers-block-v1-0-b200599a315e@quicinc.com>
Subject: Re: [PATCH 0/3] block: m68k: add missing MODULE_DESCRIPTION()
 macros
Message-Id: <171880525880.107379.10461906104688825511.b4-ty@kernel.dk>
Date: Wed, 19 Jun 2024 07:54:18 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Mon, 17 Jun 2024 18:13:31 -0700, Jeff Johnson wrote:
> With ARCH=m68k, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/amiflop.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/ataflop.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/z2ram.o
> 
> Since these have traditionally had different commit prefixes, I
> submitted individual patches. Let me know if you want me to squash
> them.
> 
> [...]

Applied, thanks!

[1/3] amiflop: add missing MODULE_DESCRIPTION() macro
      commit: 28d8c13830cc530996157e22ecf22def90cb7f35
[2/3] ataflop: add missing MODULE_DESCRIPTION() macro
      commit: ba8df22e25e7e906254f4f490d7bcfbe637152aa
[3/3] z2ram: add missing MODULE_DESCRIPTION() macro
      commit: 465478bb00168a7620788990b1679c5067d421f2

Best regards,
-- 
Jens Axboe



