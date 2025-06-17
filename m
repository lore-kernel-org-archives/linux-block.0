Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FA32D130C
	for <linux-block@vger.kernel.org>; Tue, 17 Jun 2025 12:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750162328; cv=none; b=V/35vhwfaRav3IEPtDdyanyTG6l3ku/BsEaOQ+wWcV5sknKm0iryrTNP58oelHGyQwySeY84XtW+TzjT/FXu20wW+dU3lx/uIuEuKnNnRm+EPIe1LhlxViH8IdRuMZjV0GKcw/bHDV+EQZDIlFMKY/tBwEMJBHrnPobvPXjvdfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750162328; c=relaxed/simple;
	bh=jtjGkx7PbcE2vHDnfHVl0N+SZYB2VE9WYKDSXkb4WjQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e0KMuwIXJtRA4rLFDbFrH97+luIhHQPFMFn//B8iQ74vCnk05KUR93VXXzoY8yfQCh/ciwaR2rY+75s+cTzG4XKrxlgkcoYn7YyB3nx/SiyN2diZ+5LiBK6OUmyiNJiUwHoQme7gbr714tFuEIdbr7utjP1uQGpu+Yu24PGjr0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mGmT086r; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mGmT086r"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-86d0c5981b3so193971939f.3
        for <linux-block@vger.kernel.org>; Tue, 17 Jun 2025 05:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1750162325; x=1750767125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f/qjREJUOIJxRz7QxQVVE+iucFdBwBB5lgjEmSZXzLo=;
        b=mGmT086rDSv7DqoRsYsm4hr01t+EewawRqPgaSFQ7wJ8WbFVCNAgAXCiF8xgAAX3sc
         pdQILmDjv45bpSIS+NgKuIoSZ/cNchEEr7GO8ILikEADqb4iXlk5LHssXe0/Eyt5lI7B
         v3KOFuX+CJ0RC4pT3fOI53UICL/+eJOGvTZ/w3uCe0J5g7MbPF0QOwexLd1jyjNU9CzB
         JQEcOrdfA0EPcaxWrOJqwdwpiavmBJ7yQeOLLxVi8UKhyrIeT8iVjSi7G4L95Qf9lQgu
         XAtuvf7HLPdHAE0R/hkoeIEi2Bno+KqGPCG6nFerdz1P3INH3Xef3FZQdY1fDLYepG3A
         IGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750162325; x=1750767125;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/qjREJUOIJxRz7QxQVVE+iucFdBwBB5lgjEmSZXzLo=;
        b=VxYYMMC7tdVHLR3JLQrUWHvSB7RT8Zrkf7bqvb6/pZ7bVXOcMB2Nh/wnPozgHWvBQJ
         aFisyshE58UoNM1ULeZmn3IIAB98fpBADrBeO3eekTrTuWwYpDtdWKq9R9wKTNv01rG7
         mUNVWniTzoV6aOp9k+RRewdc4b3EpLlcZc7yDf7WNK+88s4lJy4Kn+FW7u02XNRPeojl
         Bhl5krhJs9xjoX++zINYsXp/ab9IwZaFcQqH9IR/1IuTNLBEe6fYuFSVBRJKBmiu4hSW
         674Lmp0NMmlOR55KNI9dEJ6ABQsOZAgZ0M8peMcI+rlJuU72kW0/wl+YvrhNLVWr8ln1
         AECQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlaeqH2on900jeLcKranKY7jM1TWYlfrCE0iwkeUrrAdVKBiYJyMCOreFyhxlgKotzkTpS7zmHVNUG5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLYFktLY32sY85pmY57pqGIGanP8eb+9cn4La/6RpeKjWHBqVB
	ArjrprNp6WwyCsTJYDdvbpE5pbq2ztcaLNdFVN42aabvwx36uuUDVznkXFJfdvtrNJKIYTuCNEQ
	u9xhS
X-Gm-Gg: ASbGncsuspElWfY7woNcuCHySkB0BCigGSu4aapYe1tb4BYNJmYut7U8M7yDPKhtkrn
	NwcNNhLhBRBVOf+lVS45SXYWU11WCUT0KaB7PT+IbCDBZmTQFKuYZrgn41UE8gjMorjRCi1O4pY
	3Hw1YD+86vv5eZqC7MED1ctWNAKgwcRRw/mTbUSmL81ygXqTKSyQq8Nv14NreeCDwzZg7xJUb08
	91Tw/goSNZl+dLddHkuK11lydxCcHSE15Q+v+22FlBQHiSMD4wm1yYCJHmY6AMCOP29nFur5THj
	pCjNHjTo9jU5S/y+lgodDG5lll2i7uJBKvM1pVcvhBsK0rcHYdH+Lg==
X-Google-Smtp-Source: AGHT+IG0w7oJnEhc9SyJVK6zFLHv3cqGyVrecWmvAPvfn0VzcgjB1pecE+hhN3zMhmzyPcnm5FRGeQ==
X-Received: by 2002:a05:6e02:184a:b0:3db:7c22:303c with SMTP id e9e14a558f8ab-3de07cfe991mr128241535ab.8.1750162324822;
        Tue, 17 Jun 2025 05:12:04 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3de01a502b8sm24901745ab.66.2025.06.17.05.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 05:12:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: ed.cashin@acm.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Justin Sanders <jsanders.devel@gmail.com>
In-Reply-To: <20250610170600.869-1-jsanders.devel@gmail.com>
References: <20250610170600.869-1-jsanders.devel@gmail.com>
Subject: Re: [PATCH 1/2] aoe: clean device rq_list in aoedev_downdev()
Message-Id: <175016232389.1144398.4390914425439308132.b4-ty@kernel.dk>
Date: Tue, 17 Jun 2025 06:12:03 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Tue, 10 Jun 2025 17:05:59 +0000, Justin Sanders wrote:
> An aoe device's rq_list contains accepted block requests that are
> waiting to be transmitted to the aoe target. This queue was added as
> part of the conversion to blk_mq. However, the queue was not cleaned out
> when an aoe device is downed which caused blk_mq_freeze_queue() to sleep
> indefinitely waiting for those requests to complete, causing a hang. This
> fix cleans out the queue before calling blk_mq_freeze_queue().
> 
> [...]

Applied, thanks!

[1/2] aoe: clean device rq_list in aoedev_downdev()
      commit: a847c4a41630b38136e069aad82dd619c03e95b6
[2/2] aoe: defer rexmit timer downdev work to workqueue
      commit: 71437cf6208c63af6ba99cb42074d13d7b56b669

Best regards,
-- 
Jens Axboe



