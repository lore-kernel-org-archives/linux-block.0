Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0541146A8A
	for <linux-block@vger.kernel.org>; Tue, 14 May 2024 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692983; cv=none; b=GJi+UUs1cZnNjLK1ohn+e2RKrlS69aeu42/1E/nWv1n0+mBcQxjAWUZ8dOEH/aWTk0ZPgv+w7Yugbb++jJykg+gZhnUuGEnSzFHsBuXK4MoOpeFAL1/g4zqgkdt57mVIJq1m4zn2jwQOV+tDsWHj+ys7IZHQFEL0uOQBPwOFYzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692983; c=relaxed/simple;
	bh=caTajgp7wr5lL8Zqr1Zf1iv9MQqr1coB6X3fvJdqMvY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VQoOgMczx/m42DfOmeknRMweZ3vQb8exx/VGZ2N2c+SKBMDdz5pzNWZI02sEyGAV8Bs4JFMvabTq5VUKk/sdTiuo+BfhiOre3DjswCkmaLRvxNTJtelmgefZ3aOtjPPMANLAuc9UQc9m6vyWm+caSgO5CB0e6OJo1rBm3VukORM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=EbayFsTi; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EbayFsTi"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2b4b30702a5so1418126a91.1
        for <linux-block@vger.kernel.org>; Tue, 14 May 2024 06:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715692979; x=1716297779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBz+0EoAj8tRotJX75zTvVyN6+ypYgr2NjUyx47M1sg=;
        b=EbayFsTizGUXozZltvWAGvnAKoiR27ng8uSmeBOQV9y10KUBebHAYi9xmBN27wCXHd
         x7ieptAf2eeu0d6zWWYMKKEd7zBczDMdTNp/Rw9k4eRCTffx0irmBXZv7QEc5hQBQYiC
         DbK6gXOMq9jt0eXQ5GKSltPNdS4wjW7lUkHPMZoLU5qGj1BtVTDoYLDpG+irhOxPJAfe
         p4ESZxxulANtIjxasEt0AM0UzE2I4rRy7239jcfgSwiuSDLPfEfrC4oIH9r/tqQU9qPV
         TSsqkhU1HUeMhBLcL9Ockpefs9/gOtVdpeEx1KgdKlfLcq0KzI7QsUA1nlbNKnAnR0Op
         ivTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692979; x=1716297779;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBz+0EoAj8tRotJX75zTvVyN6+ypYgr2NjUyx47M1sg=;
        b=IL65/nMvXVIofiGkPgwTRnyk1TsyHqC0bhGjTh29BV67oSWL50A+6exiQ2rm9eklOt
         8M1dhMFeVYwtPnUSWWApjULFEgqFKF1cKMeydok6I2mX93braf/KfQlib+71DCxwo0Ph
         ZTyj/Zso37rG+iQSl9IOFpTaAg3O6PiwMNwNj9rzdrVr1pNEE93ptcMJKZm1w7cP9Crl
         /K10LruCvXJqhLp5bES/5mZcrfRoV2ASDuJ6yIwPGBAthzFkfzQsh2SlnLFShNuCQJzR
         BB8yg4nOHZSKer/Qhv3/y0hfCVHWbe7hr31QilOSgQi6yjQ8LGcclZiUF6cBc9WAtT8T
         AyjQ==
X-Gm-Message-State: AOJu0YwQhcbazcuCkPRC+qalMX0fwZUvIEkq2yFvPvkEmC0NfXV40ng3
	1MAvswK2zmgAEvuqPuiGd7ohy4W7vVwQwnZ8fH/20K8w8aZ41o62fyOpd4b0hvnTcZBxlxuYBlL
	4
X-Google-Smtp-Source: AGHT+IHxwMKra850PVDtfrzQeGzTIMs3S1tZv8gtgqSasAwvKKdKvv+Fa2r5MitQv9UVIoxg0M/YZA==
X-Received: by 2002:a05:6a20:a122:b0:1af:5385:3aff with SMTP id adf61e73a8af0-1afde1bca05mr16862404637.3.1715692979041;
        Tue, 14 May 2024 06:22:59 -0700 (PDT)
Received: from [127.0.0.1] ([50.204.89.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340a449f4csm9538660a12.4.2024.05.14.06.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:22:58 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20240510202313.25209-1-bvanassche@acm.org>
References: <20240510202313.25209-1-bvanassche@acm.org>
Subject: Re: [PATCH 0/5] Five nbd patches
Message-Id: <171569297769.29126.13525185875517518274.b4-ty@kernel.dk>
Date: Tue, 14 May 2024 07:22:57 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 10 May 2024 13:23:08 -0700, Bart Van Assche wrote:
> These patches are what I came up with after having reviewed the nbd source code.
> Please consider these patches for the next merge window.
> 
> Thanks,
> 
> Bart.
> 
> [...]

Applied, thanks!

[1/5] nbd: Use NULL to represent a pointer
      commit: 08190cc4d8a62f2a07b4158751afd3a01638c4c5
[2/5] nbd: Remove superfluous casts
      commit: 40639e9a0f6e49edd4ef520e6c0e070e1a04a330
[3/5] nbd: Improve the documentation of the locking assumptions
      commit: 2a6751e052ab4789630bc889c814037068723bc1
[4/5] nbd: Remove a local variable from nbd_send_cmd()
      commit: f6cb9a2c3d2e893a8d493d34ed3e0400fe8afe28
[5/5] nbd: Fix signal handling
      commit: e56d4b633fffea9510db468085bed0799cba4ecd

Best regards,
-- 
Jens Axboe



