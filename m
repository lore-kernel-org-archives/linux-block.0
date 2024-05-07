Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47D24A3E
	for <linux-block@vger.kernel.org>; Tue,  7 May 2024 02:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715048914; cv=none; b=oSsTlQRrertygZQV2PMOKndcplPLlAK/yaRbcey3K09cTQlQV+8kxyp9pWn2YY0aJYb2Nbvw5P1rf5W/z950SNAMdB2X4tBmJq0ik+eOmCJgHTNX6979B/w5jdX57f2pnXz9JVJd9uUX4n3+LNC1zlLjedtlN7WTl9NVc4QXcqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715048914; c=relaxed/simple;
	bh=+CSkBnBgPd+J06ce1jh46cEKGNnoCbnsrDETobBGafY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OLlUCvjcrE2vDhdaArmeICmo6Hx7ltgUxsIJ1GBQAQ/oTj0FIHgr+VDsEETlQXm0BWbrbP7a8anBRzRdra8M3ma52KUpe+NxDw+VKj0K+ckaCyP8zVVzCuvKn1S6a+wZenVtgY+fOlt5K/Mqgx6iItK78DZHGBYKRAV/m8fBG/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=c3mASknz; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="c3mASknz"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f470d4f777so7071b3a.0
        for <linux-block@vger.kernel.org>; Mon, 06 May 2024 19:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715048911; x=1715653711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmC62/ezjUIPisfgcsC1ZvH2jf8v9/q15qxsZCWeKQs=;
        b=c3mASknz+/lmYfe8+lYathpHW5g2fuh/0Denzex9jrjHI0ytwqTUMwO1z17u+kzTa3
         HjaMgjNh8Rwp9b5n2YOL++LfCCNAiusfRE02dRY+RDYu+LUKw2gXdZYzToiDf+Nz43Sw
         VYjOznRvQrKl79JLM2GfVjm7dbdygL7PaPaZJnmvibs81CwHnR8z1WFKrQZpf++3zBW/
         3j2B/PMfuGMmWpwITNvC0UmJZigj7mTpGTnmSgleep//yA4ibgwUa7bxLUbdrwpvUU65
         hwQiDW7M2hnuCm+ncTMddkVL3mfhB61RvtZ1TfdS992MYo47GGhF4iFji42WVLQ6Ghn3
         2rYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715048911; x=1715653711;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmC62/ezjUIPisfgcsC1ZvH2jf8v9/q15qxsZCWeKQs=;
        b=GgE8nnZK9Fs6lCE+3ipBBo3BT1NR9MqNeHTWNQe0ywX1NvSoKjUqfJgf+WSkClW9rH
         CAZTFsBCqvfFV8Z6WxLB/wn7ItYMx+yYqmLTW0IdZlodh0cLaXf0Yhb9ohn8tCBn9dwx
         WQE4OzK+bi9FWl0YqFC9Do84iMmUOXH/z75SGVIG4TqG8JGuoEs6TZB5P9KgqmpJzE4v
         MV5U/s6/jVRl+fWKbi7yBJ5k5nxVcZac0tJQcnJcqxbMVTm//6rOQkqzNQWfswOM4gqX
         +OlEH5xnla10MXABly1xF6rs8v6tD4xNrMBEiDIWbDZSOaM3VW/LZW+4KeQYNnnKuHdW
         3LGg==
X-Gm-Message-State: AOJu0YxcSWWt7yLqHyMw9lKaX164pktKGlr9TMFTRlL02dxgci2IM17/
	dCmLWyPertxmoDvEriJDkpObpu4Mgi1iIf2U+AJgiGrdVF+10ogCcdaX9cS3Znb7deEPm7Yu/hs
	V
X-Google-Smtp-Source: AGHT+IGi7dDN1zaQctVUuzUX2G1GipF78B4o1yqdt51mpwCXyg7akJLuCnUnompoMGaV4oQSqj3L/Q==
X-Received: by 2002:a05:6a00:8c07:b0:6ec:f406:ab17 with SMTP id ih7-20020a056a008c0700b006ecf406ab17mr12498603pfb.0.1715048910830;
        Mon, 06 May 2024 19:28:30 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id bn12-20020a056a00324c00b006edd05e3751sm8703084pfb.176.2024.05.06.19.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 19:28:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
In-Reply-To: <20240424134722.2584284-1-ming.lei@redhat.com>
References: <20240424134722.2584284-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: set default max segment size in case of
 virt_boundary
Message-Id: <171504890971.2934.13939084723557956334.b4-ty@kernel.dk>
Date: Mon, 06 May 2024 20:28:29 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 24 Apr 2024 21:47:22 +0800, Ming Lei wrote:
> For devices with virt_boundary limit, the driver may provide zero max
> segment size, we have to set it as UINT_MAX at default. Otherwise, it
> may cause warning in driver when handling sglist.
> 
> Fix it by setting default max segment size as UINT_MAX.
> 
> 
> [...]

Applied, thanks!

[1/1] block: set default max segment size in case of virt_boundary
      commit: ffd379c13fc0ab2c7c4313e7a01c71d9d202cc88

Best regards,
-- 
Jens Axboe



