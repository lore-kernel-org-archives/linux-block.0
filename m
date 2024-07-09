Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DC2823CB
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 06:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720504899; cv=none; b=U6zbyhJOMX6GlMvuDXwofTArD7kvDXXiOXaeP1GFtMa2qwv4+T6SU8wwFFi+PkmEk3Qa4sOGk6SxeCtRVTgRBqD9YP370ZkrUc6XcyaeLZHpKLnaYNIhMIkO08ZytpcCD0EmLbqGEGcpuBRw/BIJz3khiXnv8Gi5HgcVLapuJ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720504899; c=relaxed/simple;
	bh=bf6YHak9bDd9EVGsj4ABZ10lcLHDUmA7WAU0sVebGq8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mMiEy5ErQHcCEGrzydEfN/uUTkGf0e5yXx2wr/mdOv5+++s6nqOUrsDNS8DXBbf8llm2NIPq2aVkcU/cb+SYMR7FQ1whPZ4rxY0iBmgBWlSbojbZ4u0NyyVzl4/gytKquxhY9rlqY4i/3iXaZDJOYj2SVG19SJwPysEUlgW9fnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=EWAGpepy; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EWAGpepy"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ee92fe5fdcso3765021fa.2
        for <linux-block@vger.kernel.org>; Mon, 08 Jul 2024 23:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720504896; x=1721109696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5i6FvIxu0t61KmW6nSz5YuypUDWAgduXP6OmKVCi+V4=;
        b=EWAGpepy103taJZ3C6hCvNaQ1yPRL236T0MlQ4AHvKSXN6LaNuHxxDHAbyRp9nvYzw
         FMYMkGZJx8lwzvaHQH5xvJefctlh5pPT6P+VOGSU4kgHbbyHb74eLxWRS2wHhsihBjae
         1agyu0WZi+zGxo/NgYj6b+s40lO7vqHcrQlDqv3IG3ou7FOnQWIrgeOdO/nU68SCBawO
         78l7Rlpfd4sUGwPamHcFux1gG1xqfmR0pw/3g3kUquZNCfRgzW0Vb/tfWepXabd380vc
         rfG8DGZAxygbNiUrsGRA6Kr4+ePWw9awhWpN8zXzVBg6JgrpZvzeC8IQY76U2mogEHWU
         N6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720504896; x=1721109696;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5i6FvIxu0t61KmW6nSz5YuypUDWAgduXP6OmKVCi+V4=;
        b=h2fTLjTvAwZQWaHE266pd3J+KNqqJuZiGAWH5NwMTS3222sLc3e2UmTC4Lpa/Gw//B
         2kZNEY0kUW1JvkkCeZibaH8+q6Qfd1rMg0nDxTiz8bxRQ837SEV1YfhabPUvFIdh0oPZ
         uMIh4v/vssawk6VSHTlH25MACFE/HUIIzdkoOnE/lZAFgKfgt8dc+/wcU0IwZm2Axd3/
         V+kczMiIOAzdamvg6SROhioWob+TTfrqTtAWyK6lAbQ/5q/7TnmoXbehNqDn8MaVAMj7
         ssNH5fnwsFeMdAfSEXgzoaDquOe47MMJAWFp/KeNJtgm4bdrKO+KJTaTsHZz8g6l5F/x
         P2EQ==
X-Gm-Message-State: AOJu0YyP68PEgljWL09IYA3t9rW9d+rGMyTw60FUi/yqcgIlTSaIikWF
	N7DCsvEWwWkxcrZjT8jrSfXdacLVzaXemQ9G4yixONZy35Sji1f8BzNsGOUQKKi7BZeeUpeWhdO
	IX0Bnq+X2
X-Google-Smtp-Source: AGHT+IHHjyeREFlAGsBV2lh7fvw67dOk2mHpx6V4x2IX2A5FRKetOc7G6lvBtH0ZEpS1y8j6mtrnWA==
X-Received: by 2002:a05:651c:b0a:b0:2ed:59fa:551e with SMTP id 38308e7fff4ca-2eeb323173fmr12143941fa.4.1720504896383;
        Mon, 08 Jul 2024 23:01:36 -0700 (PDT)
Received: from [127.0.0.1] (87-52-80-167-dynamic.dk.customer.tdc.net. [87.52.80.167])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2eeb34338b1sm1133741fa.67.2024.07.08.23.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 23:01:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Cc: hch@lst.de
In-Reply-To: <20240709045432.8688-1-kch@nvidia.com>
References: <20240709045432.8688-1-kch@nvidia.com>
Subject: Re: [PATCH] block: fix get_max_segment_size() warning
Message-Id: <172050489549.367933.7550059720166197848.b4-ty@kernel.dk>
Date: Tue, 09 Jul 2024 00:01:35 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Mon, 08 Jul 2024 21:54:32 -0700, Chaitanya Kulkarni wrote:
> Correct the parameter name in the comment of get_max_segment_size()
> to fix following warning:-
> 
> block/blk-merge.c:220: warning: Function parameter or struct member 'len' not described in 'get_max_segment_size'
> block/blk-merge.c:220: warning: Excess function parameter 'max_len' description in 'get_max_segment_size'
> 
> 
> [...]

Applied, thanks!

[1/1] block: fix get_max_segment_size() warning
      commit: 0ffc46eb1b6d0b9dd07e4f2b1019edd4fe678b9e

Best regards,
-- 
Jens Axboe



