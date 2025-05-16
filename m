Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3355192B84
	for <linux-block@vger.kernel.org>; Fri, 16 May 2025 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747406661; cv=none; b=tdK6w3HScobgQsiro8jhzdbYFZc4Sl1EDg3WOxDqadZbs1HzRmnr2ZY78epDkwDQntVzkwDBtOUZiztEOYQ8gxVVoO3TAJgaaEZCvbYZi+jjaXuM2BTxL6sjVYPSnl1lDe88oLIo5ax2m+mB9t+an5rlvbHUZCiMwUjwiyjXvw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747406661; c=relaxed/simple;
	bh=zsZ0x6nDAgQLumYKGLLy0s43yCizehl8FxZaNQN0DLE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jBPbqNepduEoSgkvFsXEL2Fpz3AjEoiQgktAySvuDnBEerR5A5p5Tvpn9vUAT24TLYwqEahD18/pr+mb9bWNDu4xTi5AkEjTzSpWloQgT+3Q2zqM8oH2TyZg3uQHrx3AMs/zhRkmjsL48EKVBMDcsa/v3krtdEle9VOoPlhLs8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=J3f5F/H/; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="J3f5F/H/"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-476a1acf61eso20223731cf.1
        for <linux-block@vger.kernel.org>; Fri, 16 May 2025 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747406658; x=1748011458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJFJhhC4sgqvNeQf5oDlYwU+H5hYANENysKorvcx1KY=;
        b=J3f5F/H/nvd9lJbMtC/DSWkD3Xcz9/rmLB/dWh+/UvNacXWguBVg3R8URShtP6k5/K
         lcIxVHjZxn7CISLJXy5EHCp7Drr4QUhP+pJ/OPkat4tcWDnxNSkt3NXm8EYar67I7/ac
         6vg6lS3dV9G3yhzw124hL6t334v+9+js0oXug6LieEYJS8T0G6v2CS+GjSddXSVY/Tjy
         wyuHBr7VUXo6crXv+tMmr54sghX5I4rULTEuThPme4Ao5sL1IEWTkPZ9kJxpkcsNDIvr
         xdkkvztKA9sHteCVro/OpeLhv6alzLVHoZwA1UYOecxOb8F8r61LD+djyDRgL+IrOqH5
         ERxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747406658; x=1748011458;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJFJhhC4sgqvNeQf5oDlYwU+H5hYANENysKorvcx1KY=;
        b=mNlRdRtvwt+46/iCnFGjlmhNgmzjHPUvuTFIbcCpunM/+7qAq8y09hPHERPGiStVFu
         WINq4IVOX1DA20SO9hosxw8arGJsPGt0KZd2sRByRWuKAm06InpQqzXfDRfxm7K0+xms
         1rwhE1Wwlaku80qCkIO8xKX6Dy8p3eeolLr8aaDvhH1QZUbJYgHUG6Vvz/kQnHcYHJ4j
         2AyOP3KBVEf5D171bHmsOKKKna2u3xN1F9/5Mp29Xasc6uafuvyiB/0G3kzNkXc7lNt6
         +GZF0fAIjJ+VFCSanrFS5qBr6KbyoTUtdWQLMmm/jNXG37h2zDpgvuCTkTkOJ7bbw87l
         Gr8w==
X-Gm-Message-State: AOJu0Yz57EPUaYixUjqeLotVLZXodQlfLOszEntwXY70W9NebxaLIAt7
	OPFE/XL51ozBu/qxlxTbFyWXh2ChRSIT1QCIWZ+Hwe4mfXEYqiUQ7QH40+qNTZ3r3QJ+tI+HOgY
	yxFXz
X-Gm-Gg: ASbGncvJfGngCu6OWs8WvF4BtqQ4FOy/y1nH4Ge0vKWOVtP+jaJGePQKRUwK+KK9ZPc
	arpTKc7WwmnG+QN1f9ON/mrs+Z857Xlgwbn33RU1LO6HaxHqh3FRqDUo7RKpHo3GAUoR9gxFpHe
	ixhohIkaUQN/bdZpcmlgZxA5h8JLDUY4KqVSnJW2pEX6wcefPd8uO6DFvqoAJTRwbSGxN8kAIVJ
	mKfPDKiEBA1BTpMeTwel2TXx0NHE6Y25tdlnM4yx0MB3cIRRaklJreULAv8hG2stT6oCfhVARVd
	Ww8kTXn1De4XxQ9/j+cCh47g8Pp5KfiJa6u8Mw/RLQ==
X-Google-Smtp-Source: AGHT+IG4fch8wX+HvvYtTscHfXLzaTZWKgfkFODmmebEDKWwBbbGSxobfZPdPbpOHxC9b/ldCZTfMA==
X-Received: by 2002:a05:6602:3f06:b0:869:d4df:c2a6 with SMTP id ca18e2360f4ac-86a2328839fmr560981339f.14.1747406646674;
        Fri, 16 May 2025 07:44:06 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-86a2360ae5fsm43991439f.21.2025.05.16.07.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 07:44:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20250513071433.836797-1-hch@lst.de>
References: <20250513071433.836797-1-hch@lst.de>
Subject: Re: [PATCH 1/2] blk-mq: move the DMA mapping code to a separate
 file
Message-Id: <174740664582.350443.10346450898681335928.b4-ty@kernel.dk>
Date: Fri, 16 May 2025 08:44:05 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 13 May 2025 09:14:32 +0200, Christoph Hellwig wrote:
> While working on the new DMA API I kept getting annoyed how it was placed
> right in the middle of the bio splitting code in blk-merge.c.
> Split it out into a separate file.
> 
> 

Applied, thanks!

[1/2] blk-mq: move the DMA mapping code to a separate file
      commit: b0a4158554b9017467435069c1b327f35987b495
[2/2] blk-mq: add a copyright notice to blk-mq-dma.c
      commit: 496a3bc5e46c6485a50730ffbcbc92fc53120425

Best regards,
-- 
Jens Axboe



