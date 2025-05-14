Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7058D261573
	for <linux-block@vger.kernel.org>; Wed, 14 May 2025 11:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747223088; cv=none; b=Sj13Qif1c/Wskpi96LlwjODNVNeTjzK55rF30ryEBzr2FnwVfa630HuEGtt6pXBMYNp2W+UF3Z6ERDhjEgeN3RBUvioXpF5VTWljuakhP2PlKAeu5y+D/VC7ovAmyQHTql/Zhb0umquGkzgjbOFBFfRrQ2lk05ZwZnd1ZUQ9OxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747223088; c=relaxed/simple;
	bh=m+yRtFWeabsxj5HuJI0IO3jiYPXUlHVFxYWSKEIhr5g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jh5e6KklAlaCGK3uIXORyv0e7W9APIF/dVv81eBHh57pAcCAyAHHBMGLABXKHO3T3IIUlj3kDrKdGEAIpFbZ7UQFj+CdQk/AhPTbC85pYj2RVgfWdfau9tS4/SE/VYRBtsHpaItZUKVsayjSWdgiLlIrfFqRlJmj1GWI2B4kgSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=w8f+FCQ4; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="w8f+FCQ4"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3db6d3868dcso2658315ab.2
        for <linux-block@vger.kernel.org>; Wed, 14 May 2025 04:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747223086; x=1747827886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPY4Ct50KGdPUK7jI/0FLeHE/EusxQi9Bns3VPy9y2I=;
        b=w8f+FCQ4LSkqCGAmqN4wbDVaWV1WpHPoPJyuo4qUtg5eoEXM7Fbun1j90DhSwHJUqv
         9e1/inPyq7XfmoSrQs2oNbDVnHlR7qOksnZiN/d0s4FKgfohrQndC0gU5Ct4hTP2buRO
         eVfZVZDuHKJYPOYjm+J30Ro7h2qML7I9C/UZT9UP4sL+z8Bgr9ZG5bbBnIm9qA/ddvFW
         w+AyQPUB1oDpjheKBRFPQ0sfDuXyLGDkFii3rBbCmT3i5S4R8hHdJJmJeOrrJpw3IuEx
         dVy0y+CIkY7IQPdI0g2NwTOrKa4Y4QcvvgYtZKu6J/ve3JQVUOLNRE9kWDhfKgJhZVhs
         BLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747223086; x=1747827886;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPY4Ct50KGdPUK7jI/0FLeHE/EusxQi9Bns3VPy9y2I=;
        b=o+rKqwZF1IrsY4+U/80EuDBdmGRR7GUmHFEtPUe6T+ZM48E22rPli2oNDe3/9RcQyS
         /Ei6ViaUE0KmkGLO6UTnClr8Bcmo8hYCjeyN9jm1uIC0aGuW8H1zaE9o2Mf+BdGLTE0i
         ExpsaL0KvM9dwXj+gJXKLWitRPNxxGi1csRQ6hGaV2QvrXFaxAfqUl9SZdI2hcfplJYM
         DJ1eYqzqxcr4GEaVvReFBmCaCY2/snDssprtCQzV4GX/b7T7GGdRnNOR8LM9vEQJ8L5t
         xBOqbvzMFfluLZ2pQw8MLi3sEyBbGYzhZ3kKhlHrqmc2OAM1TZzEhgjiCyuJGYQc0r+l
         sVYw==
X-Forwarded-Encrypted: i=1; AJvYcCXxGujJ4jg2u+A4kx12ckMVJ263FAtw+SVeIbG+IQmaQ7cW+sNyDARZasA0Es+3fVy5KLGwx6k0oqPjfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzajZgkKUoai2IqW4rWxA+nBb92Xy1QsQMJBc7NFaByS0KShfEk
	3vEyIBdRyBq+/3cIlVBV/WmxpqdmyAkrkDqPB3z+i3rn/z3omwSoxLRAvIC2nLc=
X-Gm-Gg: ASbGnctN3lRQU49I63B3S+2VeoggpnqD6/nI2HlMWiRc7uhjKBiCxug8Rf5kmzob+RI
	7gZKE72IrPnoEevOS87unFsgWXSwJf/dBek656geOwkiyn0Z0esiV5obipPeD1AFnWbIQE8bapu
	ePJlDYGQSCV9sHsabVWCfyurO4xfM5QSUNScrnagMvmEGbc8+SchuAlUIjaKX5I8R5oUQP17Kmk
	2hQl0mFRmsl2DaOY2OyjRx13TD1E6J/DjsKZBi97BxKidS45RT6+JqoZDvfX1QhRehyknWyU3iQ
	DcEw1f0eBLgpnOqlOITKJeiTZy3s+LxyT33EpSmtB2I=
X-Google-Smtp-Source: AGHT+IEioIm4FDGX/TlgQKfX9wwJ5LtfRaBZsGeozP3u13p1VC86ZRvCVUJUfmgSrN8sWOoVys/iUQ==
X-Received: by 2002:a05:6e02:1b0f:b0:3cf:bac5:d90c with SMTP id e9e14a558f8ab-3db6f7eb9f9mr35886335ab.18.1747223086468;
        Wed, 14 May 2025 04:44:46 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3da7e161d47sm33988065ab.62.2025.05.14.04.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 04:44:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: yukuai1@huaweicloud.com, kbusch@kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20250507060700.3929430-1-hch@lst.de>
References: <20250507060700.3929430-1-hch@lst.de>
Subject: Re: [PATCH v2] brd: avoid extra xarray lookups on first write
Message-Id: <174722308500.101960.5109818350655687104.b4-ty@kernel.dk>
Date: Wed, 14 May 2025 05:44:45 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 07 May 2025 08:06:35 +0200, Christoph Hellwig wrote:
> The xarray can return the previous entry at a location.  Use this
> fact to simplify the brd code when there is no existing page at
> a location.  This also slighly improves the handling of racy
> discards as we now always have a page under RCU protection by the
> time we are ready to copy the data.
> 
> 
> [...]

Applied, thanks!

[1/1] brd: avoid extra xarray lookups on first write
      commit: bbcacab2e8ee373eb8f4bc613912e7c203deb820

Best regards,
-- 
Jens Axboe



