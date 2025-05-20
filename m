Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889461DFD84
	for <linux-block@vger.kernel.org>; Tue, 20 May 2025 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747754215; cv=none; b=efk/ql4yPJUc4knVMuDq5e9lwqagFOIqUQUki6Q+EPPwFR9DYvfvYz7xeqj1zY1of3mODKws67ZrmT1kjS+T29OnU5JN/oL0iR0nIpnwksqnM6z1D9YJebCNoWMkbSVHHhTZl9KAMhnlC/tRsnELmSU0V7pOiknrsLQkV2fV89Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747754215; c=relaxed/simple;
	bh=HJHsuF+8AYW+XvkmUMpPgX+UTJ9c2WsKFmbKlfHPgWQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Vx5aO3XK9O65UJwzqdIYoWolksv1+XYKwmVtCvwxUzrmMEXZYAUxQg/e3afn3wCSllRZDsgauK8gNZVnzyqLyEjDLPZulZG26S/8yHL1uGIRbQ8nbhiNMeeN328J2xpDl4ik4I/I9Sl7iNYggfxP+3EjL4o96q+uhI0O/BcxFNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FzOg5H3Q; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FzOg5H3Q"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3dc75fe4e9bso6105745ab.0
        for <linux-block@vger.kernel.org>; Tue, 20 May 2025 08:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747754210; x=1748359010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PC5NFMMD0v5ikl6Bv/+gEdoenCkS6KLRrHTVehVQ13o=;
        b=FzOg5H3Q19wmHOkxO5Ylg7IqW/dCfFsaJU4IRKLfmlFoK6j0ozKQH/TKox98vbqa0W
         /B9vzK/QJxcVUwHqr1KjbzXh8i3tt05CUCsqwSAuK+a9LNijU0p4zkrvXZEWSRPEUlPI
         KjokBbs/tPOHJSjzGSWy3i+MnaO7QSOFEnuLMaTXHykmOrqm9QOH76nE1H4/4TUE9trx
         dnE0bQYN91v/rvazz4fm2fPeIAjPncDfRFmakbrZyN7QHn38MHiKeAw3XJuHru40OjaW
         5OdkiBHYArTJeWVC3onhFhx5Bc7iO8FDhjzQnqBUikORGkGscORsT8d3rxXk2hy4PPln
         +2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747754210; x=1748359010;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PC5NFMMD0v5ikl6Bv/+gEdoenCkS6KLRrHTVehVQ13o=;
        b=Jr2Qvt5SReHNWaQWqeOIWThFQIgSudENGeNa8AF+wShDUrdaJ1R3yHBaS1/HP0kmQR
         HaGp6qfZGliB7EB5Y4vgAScWsnbGFpTbmfOfGW/BN08MWjHZEoBII4uOGFT1V3M3pzfu
         SbojZmENu9F8S8ebzASAg46/MOJQ1RC8UIPUXqxUo4DAckldyYLhG97X9BLAlWT0u+CV
         AK3DMpvluQ3uDyvseGUube9bkIgcRu5gt4ExyGfWhtDboKlFHHpGhSx43QI9d710gDJ5
         nbuRZx8lOlfB9YMokpUXx+dgDj8s70wIX3Sfm0uDxem/Q7wlMMobP0k6PKmfrNM+Ivyw
         QhzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXirhMKaGN8h79DPxjyWRIojKwyIfO2I42c+5AyvPwg0Nl3iIrJPK7r0jBZIVidiv0KBuhPCKbon6tU5g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7nUBsaS7Gx0YSofB6z8b2KPIgQ9C9qjf/eJQiwSCIj5XKXN23
	PGw583zyNv1vNTgQN0X7eXYyfWhD/KsjHUD96CCPtRxQaFWYxlI0Kk/jIAGfXpvxYLM=
X-Gm-Gg: ASbGncsOT44cpqZ28noIvnP8KflUsPMiidEYZtBK+BAHv3dGI5cJ0bHYUy11nrHQHgX
	+ZEVlMAIDlmkodM8XFhaQwlIbJw61NbhWDI8iBnCQKIA/qq3wBvQC2RfVEvDISU5op2/l028cTI
	lLDRS3rK4plHep/ZTxGf+mGOMGyWY51mdjzbWzyJTeZn0i4ohxWjGUbG4BG77uCZrHFSsZLHeI3
	xzXj+dZFSdu1TemnfWbRT0f2on97EB3N26FBSGAeTEEKXZclbUHbgpyEUTF79VgdBWEYgQ7DBVb
	a7ccHnGPL/rVn/n9rIiH5dx84O8Ss52vZnhnNI7r/A==
X-Google-Smtp-Source: AGHT+IETyTM0vxJsHPAW6wqnzBHG14FfXjkEhjhyttejzdyZHLD+Y3vk7Ra74SxtlYlgfQP9qMC0qw==
X-Received: by 2002:a92:d607:0:b0:3db:800d:6edb with SMTP id e9e14a558f8ab-3db800d7140mr150542565ab.2.1747754210459;
        Tue, 20 May 2025 08:16:50 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc3add36sm2256532173.30.2025.05.20.08.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 08:16:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: mail@eworm.de, lizhi.xu@windriver.com, linux-block@vger.kernel.org
In-Reply-To: <20250520135420.1177312-1-hch@lst.de>
References: <20250520135420.1177312-1-hch@lst.de>
Subject: Re: [PATCH] loop: don't require ->write_iter for writable files in
 loop_configure
Message-Id: <174775420950.728210.18324544264622226588.b4-ty@kernel.dk>
Date: Tue, 20 May 2025 09:16:49 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 20 May 2025 15:54:20 +0200, Christoph Hellwig wrote:
> Block devices can be opened read-write even if they can't be written to
> for historic reasons.  Remove the check requiring file->f_op->write_iter
> when the block devices was opened in loop_configure. The call to
> loop_check_backing_file just below ensures the ->write_iter is present
> for backing files opened for writing, which is the only check that is
> actually needed.
> 
> [...]

Applied, thanks!

[1/1] loop: don't require ->write_iter for writable files in loop_configure
      commit: 355341e4359b2d5edf0ed5e117f7e9e7a0a5dac0

Best regards,
-- 
Jens Axboe



