Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ABF275114
	for <linux-block@vger.kernel.org>; Thu,  1 May 2025 23:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140656; cv=none; b=Rl228/aOlIzBmE9Fds0wHWuOBAZ39buA0ZcWyd8+cNNLr8yf4JaSnL5hAS90XBjdUaDZXRBsLq/ubiiEs5N/hiiEmiqQKryifPkcYF59p3Md0geQKYJCjDTyTL/OsXeKKuTiuqLpJJhW53UUWx0qT/t3U7qNOEhRUbrEElhgLIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140656; c=relaxed/simple;
	bh=rWXHb/2lEZPmNISP9PodHPetb/lbHqSQtkfeneIRwPA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TM0v2ifafoCWYVanS5PBGrDZJg0OMWCaxlra2k5gSLBaIBDWAdkiibBsmKkv5LVv1wlum6cB3qMCpUIRhh9BWr30edY1PBrqsxzZ2l1ZpG/n7tRJP5B1uiQlPBV6xyEQZSZuCZl/gbj2rCanA5Y6lvKD/f+XR1rWKEkzhZDvXVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mkESZhmo; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mkESZhmo"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85e1b1f08a5so46077539f.2
        for <linux-block@vger.kernel.org>; Thu, 01 May 2025 16:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746140652; x=1746745452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUc1J8bmHUNz3l9x47kyRNsdFL41uZsSnvsNwy7xfh8=;
        b=mkESZhmoHnjXKcDNr8pZs+3Kw25SmemikVgN2/XqVpb2Saes7fdDDZ/4Kg+kSVsaUP
         NOJcRrrPrmv/kwqL5ZFcfJvr7I2EZIZ9P4jpqD2j/9rE9ZoCuAkbKnazD2BGAs7S1DIw
         6i3juiuj/FUKIQf+IbhQMutOBGWWFXp7f2dSLuo8vm6S5DzSqUtFwuZS/lsMAqIGkTfc
         QMWrxQo1JJZhMSdL2wtczDnBjmYSmrbd5W/82HhV9crFaZGLlHGUaGF8l7KLEYyUCKMb
         3HBfW3oHzCi1XXylzo30nXW2hYUif976P1nlxnfj7xzJswKDXwi/SA5KX9Np3quvVyDY
         9Raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746140652; x=1746745452;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUc1J8bmHUNz3l9x47kyRNsdFL41uZsSnvsNwy7xfh8=;
        b=upO3nA6mqRD0FzfGd2Gu7X0ZZJx554GTYUXuFh5D5n4/cNXYtTQFyA5+AlK7e4Vu3v
         Qk6wy+ybK3d7K8k779/9uFvCg6LOMA2dyWgpIXXf1hd2cJzIbWGIbPPQE9olD6UjvWIb
         MCrrJwQKLFHJ7zlBqE1TITN6QxLQZt1RW6eZRuJYZEnnVML0UHhP4mwHvW2zIFotjgSC
         ZaFfO7TpTSISsh9G4Bdeu7e7MWC4gAfV21/58qF09a6x+ZtMA8B7XT8Sk59gl7fQ/xQo
         m6usrS/egVC1VutrRCvm8Wu5lmV4ycGSs+EJ0dzG99QxeLpyTq77VauTTyIXBrnsi0DF
         XnrA==
X-Gm-Message-State: AOJu0YxQLF/vCbq2xTNsF2TXW2a5jNDaBS7dp6ldzJo+ZzFN8dsLVV1x
	FCBp+syLqHMwhDM637d6EW5U7lnvndtqsG5N5Nx1QqwrgqCb2sMLPWxIg8WLLNCMHSy+Om4RrlH
	X
X-Gm-Gg: ASbGncuHeL3PrjIiiDWwp6nSIx7bnc2DWzsBNY786TyPcn8KCOikeCYYJUd9sTR2nlk
	/bNnQ1WtD8djgfkLsq0yhJ/qE2DcMDeW8lopq+SUtwIV8KNRNsNcfCDcmaZ9biphy0yPinkDND7
	TzbX5zx0+obFvzsJlIXkTvUoUlOMgwi9atqlhjcRAIW8jJmSeup7WfEphD4H/7pz7Af38VSrTaZ
	Lqo1zKxypYBmDAb7pyS4t+NzYSB5OkfDYKxxfmTGDiwGl7ex64jB9cY4nG0d5avDyryYkzcUoEK
	PLfyV96ETzUZj+scLDvuqSV+QV8FU6OsBVovcO2KdXo=
X-Google-Smtp-Source: AGHT+IFN8/D32igC82KO0x0QXIiF7bl8RHCaxljWMjky/OWsnYbut/IlvBy3/E2TjraZ3q63gwM5BA==
X-Received: by 2002:a05:6602:380e:b0:85e:2e83:52a5 with SMTP id ca18e2360f4ac-8669f98c3d4mr196032439f.4.1746140652403;
        Thu, 01 May 2025 16:04:12 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88a915f23sm91740173.39.2025.05.01.16.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 16:04:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20250407075222.170336-1-dlemoal@kernel.org>
References: <20250407075222.170336-1-dlemoal@kernel.org>
Subject: Re: [PATCH v3 0/2] New zoned loop block device driver
Message-Id: <174614065159.579305.17108051029455508276.b4-ty@kernel.dk>
Date: Thu, 01 May 2025 17:04:11 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Mon, 07 Apr 2025 16:52:20 +0900, Damien Le Moal wrote:
> This patch series implements the new "zloop" zoned block device driver
> which allows creating zoned block devices using one regular file per
> zone as backing storage. This driver is an alternative to the RUST
> rublk driver which provide a similar functionality using ublk
> (See https://github.com/ublk-org/rublk.git). However, zloop is far
> simpler to use (a single shell command to setup and teardown a device)
> and does not have any user space dependencies. These characteristics
> make zloop a better solution for integration in test environments (such
> as xfstests) using small VMs.
> 
> [...]

Applied, thanks!

[1/2] block: new zoned loop block device driver
      commit: eb0570c7df23c2f32fe899fcdaf8fca9a5ecd51e
[2/2] Documentation: Document the new zoned loop block device driver
      commit: 9e4f11c1228cc8ebf236cfa51d44abafec80f326

Best regards,
-- 
Jens Axboe



