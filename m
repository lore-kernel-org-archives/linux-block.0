Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4BB2E7389
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 01:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780278468; cv=none; b=K2pJZIDoFJHCHBzB1z47bCHpb97zmA/ZDRAf3jJLyHNRQKlOq4/c6OiJJFVO1MzZlvL+sHZh2InLbjboYdAqIkAse/GFvZRyCwqcl1rntyJ9/jTQEfCEdHn61YCOtAu6XHIIjWu4T0b6QkgRkokLForxnLEj3rDxJwZDXAOfRUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780278468; c=relaxed/simple;
	bh=WnRyvGjpMt5RBQl70VieCFocaB97nn4QrlAXnPCTCuE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=opP8byBvVo5GU+5zs+hAWY/B3LJllAadL+Efq2MtEts4IdgHYWfr4/1UR/ivN6ItkjGBLm79Ilha/hudkRhLAinDioXZiKFfm2bdHQ6tMm2vIuHDRpbNMZdPEvAKrspcejsVoSpRI39FnFVksvlffdWoCwli2sZMMo/2aNdCHmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=jWBrBFEu; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="jWBrBFEu"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-43bf94534a1so3165739fac.2
        for <linux-block@vger.kernel.org>; Sun, 31 May 2026 18:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780278465; x=1780883265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tB5EL8Rhi9qKT2QoOgXudFsNdbKOqjFRFUpfHfwDsc0=;
        b=jWBrBFEuKZbhAG/GOmNfoxhOELcM9kYInNjH85p3YpFgKLWLpFLDV65aqVujN1btH/
         6BtSq7JYmqpfI3DZqBrbe9kDdtctDBoEW+I4pohyD4/h3zCKGh/GYNvMhlQ7qPm8s3+b
         s9EjOB4G4z4mhgGbcbWSxlHHBKMUNopKFgr56XOmcOIr0W7fZlxsCybcPOgNeTSjv4C3
         d6PyynfIY6uRcl4ZRNU4DDv1tflqfhBjVXQ2P+8Yf+jh+ywgtrJSx0Ojc34CzZilSDCd
         LGeOWvG96YkOrGfw9Pv3A2oYz/WVTlireMFDU6N7xBhunNgETa6oKqybSjPOTci/dVr/
         FgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780278465; x=1780883265;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tB5EL8Rhi9qKT2QoOgXudFsNdbKOqjFRFUpfHfwDsc0=;
        b=RgpRPyCKBomCJMbWHYnlzCveZxtafTZDqPwXlfOCiQeHA3TURbD9adTNvapJFQF+di
         txyhN3aIGSSW0b3o9cf9qBUDdTC+jxHIGsvyGiyI/TLaFlunBq+pKEpnw6yE4Iyh6cc+
         V7GNy+0iq7iZnBzngDB5wF28YPLjgBTfxVm8b3ltER7IkX5ZOcqAlyViD0nvc/M8xatH
         8qQo3jnLfQ9mvAzhVh4EiwjdhNFtw3TqlVoD+li+dDjEJhn3edp+CXsWEjFUn9c+T+4G
         20e/yqeHwE33zSTowl3vNz9ee6kR/d6LpAY09+LDrhV0smBQtDi3RI7YUDyY28elWdGF
         2DgQ==
X-Gm-Message-State: AOJu0YxhOxIEeh9HXYnGFLUfX8DIYA9g1lR6n2exgikduWuMLy0FYrxu
	gL6SG7s9gawxb3VZQAJWklnOBnJX997nBtpoZc+6NWB/mC3dK2acGIFys6Pf03c8UPpZlqRo3qJ
	u3hZ8
X-Gm-Gg: Acq92OFywq1Nt121hqPulaMrbuVi4JMun3gtd05caZuD0mxd+791GUBre8ldLaUHDHn
	G36o7smcV6427rm00ciXqh100j/V4LqkUPI0AosIZb7eMW6CBYNX6ikbHBf0DTgIE1vRYGBkFQu
	x94B3qoQ9GOz6fT+m17ZDFQ2gc4JO5Iv7odkg23H3jJ45AOOtxViTCG1rVyoMYieNRD+spB8cVN
	I8ln6lBWyVzueP8eQU1nt3mqa4C/pNNTJrGIvId8sddwi1c0I9UIkr+zwJcpg76Gq2xK32BbyG5
	xi3XZ2rstKjgexkqXyVIDRgQ+Soo4tSkZz0FtErQ6+abgH3kTph2KVqbo8X/jETyLWgWGK4Tujw
	0pjVBrgw4TOdFAo0iVZ0q5xuekrKLEOXN/3jTCiHCypBlh7m1C/6xBLrwmMZYLm3bysk+2OE+OH
	6P7wt7qTXdp0pq6gxOZvMJ12RZWMtk0KOPHYwhUYJX23ic+d+TP4tf0j/3
X-Received: by 2002:a05:6808:1514:b0:467:70c:a7d1 with SMTP id 5614622812f47-485fb43370fmr4269971b6e.27.1780278464735;
        Sun, 31 May 2026 18:47:44 -0700 (PDT)
Received: from [127.0.0.1] ([99.196.133.55])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48605f6a38esm3494847b6e.2.2026.05.31.18.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 18:47:43 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 io-uring@vger.kernel.org, linux-mm@kvack.org, 
 Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20260528175905.1102280-1-willy@infradead.org>
References: <20260528175905.1102280-1-willy@infradead.org>
Subject: Re: [PATCH v2 0/2] Add bvec_folio and its kernel-doc
Message-Id: <178027845531.370486.4907470779948430731.b4-ty@b4>
Date: Sun, 31 May 2026 19:47:35 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 28 May 2026 18:59:02 +0100, Matthew Wilcox (Oracle) wrote:
> Add the convenience helper bvec_folio() to avoid references to bv_page.
> Convert a few of the obvious users.
> 
> v2:
>  - Tweak the kernel-doc (Christoph)
>  - Add the bvec kerneldoc to the documentation build
> 
> [...]

Applied, thanks!

[1/2] block: Add bvec_folio()
      (no commit info)
[2/2] block: Include bvec.h kernel-doc in the htmldocs
      (no commit info)

Best regards,
-- 
Jens Axboe



