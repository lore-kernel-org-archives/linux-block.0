Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03998BF0
	for <linux-block@vger.kernel.org>; Thu, 14 Mar 2024 02:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710383783; cv=none; b=PdZ0hUqPHVBOE25K7yqySGlJzRcdjYvYhxPtd/Z6374WNi29ZFlK78OFB7tJc3KlSW127OYuLlmoyRREF88C3nKS7RBu0TjhY7QPEhZTrOk8WWsjTSnqUZHisMdl5d2nFnaU8a4QqbJFhyDOXjJoVsZFr121Ozl9R96DGVcte/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710383783; c=relaxed/simple;
	bh=HSQE770E9oLafpm2PS3Kro0bJ2nNuYLRuNIP+gWpU4A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CnUd8Xwt6rwPJKBexEv85hACvKyBfNtiGGY5eqEnwqTPP4DUFJhle9Toe4HTI0cZGWIi8VbEKFfdf3WykOQ9FXTW85SedjHEa742A5aOBG3OtUYCkD2AAaHB9s53Kx9dmnzwyYpjdevuvMnLyDPnlflCOkYMRBhtzUUrNMDXQF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=s/Fb5ea/; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="s/Fb5ea/"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cfcf509fbdso118285a12.1
        for <linux-block@vger.kernel.org>; Wed, 13 Mar 2024 19:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710383780; x=1710988580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3R9RX3BD1V2lzFn8wqcB32+0kx+UKYAri93cexzcSgA=;
        b=s/Fb5ea/YywNUe26WSYimG5Aox/y178QfFWnoQPn5coU+BAfISdYMHhtOWce4CJwnL
         82Nx9I8dGvaBQK0y8pLsCS7f5rDo8HaR2/WE9L2VQO/HJRzLDhVTgJt9qJtSY2gf1V4E
         VzpE3MbhMJyWAOW48AHTUTlreIV2UZX+5Az/J/ATWxMQ6mZSyofGY4fs+uk3AI+9pNyQ
         I9/GNYUsWf8ulKVamtO4bzHkFBI/zgT8qtsrO065YP75E3wjQ3qauER9DoywyG0/L+YS
         zjofytZvBanGqje051FCPrtUYNn9iLOyKCoMwoVEObwh7R/RcPIvHZ91QLLwBP83SYxx
         nICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710383780; x=1710988580;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3R9RX3BD1V2lzFn8wqcB32+0kx+UKYAri93cexzcSgA=;
        b=wWN1KzkI2isJ+HLBBcnz7vFgJm/tWIrhX1ykPeS++ClXYA2oW7RNMcj21Vv7Oi85hP
         kgM8kOu3JKt+//FKuijAqEIZ1bM6ZPAYAURs24WsCAGsdQo9LL95db8kWNYG0v+cR9h0
         j2DEb1V/P7Wwje9cZIci8D4/ueQvughSZj7cEXxNymWz0rsIhyE+CYqQ+PNGSbiY/FAh
         U7GaHXnF9yxXoqsiRrxQB8LibLWkhVhSfqGIJZvMthEaUHw/9gnpVJL6Ik6Ykqbsfnom
         5H6OSv3r7YQ/QcqhvFf7vBsQF7GY8hA9CfH3AFWUy5yLmU1Ua9jJWr0v868wqwB3gPkw
         nPLg==
X-Forwarded-Encrypted: i=1; AJvYcCXUgb54d1YII/6jpeUrWLbCinwTw3+d7+iC98Wm9DR2FgJH0UN26c/fD8V8buuUj+v6ZnDzlvJpBjUcUSAOuLkyKQvuWtSoqOMeN/g=
X-Gm-Message-State: AOJu0YxNPmL3j5EMHYNd5VvIjt+/VgizqFXOluJMck0xJ616rcld3mm6
	O1edGuFhobVx0myh4Rj8iWGZGUZiRbTdTu/b4+KU5WK+xYbrtQkcvppqAPpshzjcwaTmSxmq0VM
	E
X-Google-Smtp-Source: AGHT+IGFjrK1Uq0jCzam2K+9sHj53ipJgBSek5n/F1fpEnPBKV2FuEI+SV6QnjkCOD8HL62PzqHPjA==
X-Received: by 2002:a17:902:d50f:b0:1dc:3c:fb67 with SMTP id b15-20020a170902d50f00b001dc003cfb67mr585742plg.5.1710383779833;
        Wed, 13 Mar 2024 19:36:19 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id z13-20020a170903018d00b001dd998927c6sm343047plg.26.2024.03.13.19.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 19:36:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, linux-block@vger.kernel.org, 
 Chandan Babu R <chandanbabu@kernel.org>
In-Reply-To: <20240314021623.1908895-1-hch@lst.de>
References: <20240314021623.1908895-1-hch@lst.de>
Subject: Re: [PATCH] Revert "blk-lib: check for kill signal"
Message-Id: <171038377876.3342.7887013728757478383.b4-ty@kernel.dk>
Date: Wed, 13 Mar 2024 20:36:18 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 13 Mar 2024 19:16:23 -0700, Christoph Hellwig wrote:
> This reverts commit 8a08c5fd89b447a7de7eb293a7a274c46b932ba2.
> 
> It turns out while this is a perfectly valid and long overdue thing to do
> for user initiated discards / zeroing from the ioctl handler, it actually
> breaks file system use of the discard helper by interrupting in places
> the file system doesn't expect, and by leaving the bio chain in a state
> that the file system callers of (at least) __blkdev_issue_discard do
> not expect.
> 
> [...]

Applied, thanks!

[1/1] Revert "blk-lib: check for kill signal"
      commit: bf5e3a30f777b6e763f6a46c10e1250c20237e97

Best regards,
-- 
Jens Axboe



