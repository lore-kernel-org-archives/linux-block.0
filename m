Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476E13AEB39
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323843; cv=none; b=ukq13lTNGwUoI+zpUdyKn2UHZH1RES+Ieg3X+GKUP7qVu5NHPCRSG+Q9LUKgOR2PXE30XDvPE0Jb/WMP9qkngrOxZ+ZFFMMJQvW781Od5K0hOXyLhdyYALRJ5qKI7N8WxFRsT43cRtprC1xtIDgU5mJIU8lIxeP2Cpbjaf9rbbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323843; c=relaxed/simple;
	bh=0g0xJMtNhcpAdosnwfNc2YWqUDhkUGOExVCW00dGG0M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TKNs8m7HlN/53V/hlLA3ySC2U4kL4eOeA/DI3sYYZrZdfWM/TPLQv7qs0AAADniF1LVHei+yJd8sd8JeJ0+hJm9VtEUjZBjYht8WkEmtnsEWrkFItKuNU64J9rGuKyNtIpZc5vcgzcLhpjEYhjFHB4tU9CVaMpPLB9P0MriqgEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=o2edfoOC; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="o2edfoOC"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e603d0ee0aso6227078a34.2
        for <linux-block@vger.kernel.org>; Mon, 01 Jun 2026 07:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780323841; x=1780928641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WwpNZUyFLop9PabhcETxrFKMUMk036YLF4I9B9pIOo=;
        b=o2edfoOC1Siusvdr8RByDelamJF3Z4x1a980egylRHGzQd7YhG6Fr/CRHZ53wqh9eR
         N4LTg1pFZOJdo4Hkg8DLGH0a6b8Mz7DgwmhzgzeqO280VmwOHBNwneV1tHvfkLzhBWjh
         5nRWTDxp7+HKDxTpyNuI1XO6b1eji+TSoR/AzWpIByfKinKd3n/Ryvq60ZACQhw6ep6/
         KPQ8qjXVguRWuW32EODTY88JSg11FmOwNZMgENodwSKSvzbpOGDzPizpjpPDHZ3575Lc
         DwbBJGQQ36E86NY8r+tO+Af/6l6CiAjwv5xgzq+ASrEocKSS32R5yiQmx2rA4iTS4xUf
         HcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780323841; x=1780928641;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2WwpNZUyFLop9PabhcETxrFKMUMk036YLF4I9B9pIOo=;
        b=rS5aWJ5AnOPBYQuAu88LtVjrUaoC+KiVxyyfETEACsWx9bXgfD4iY0xfgPeZu6poAv
         JHsVP9M/6mmvffaBlTb+4y28FOO0Dh/fPV6e319A9V86tz2PMWGBuy480CtU13eZ1age
         9Lz1zz5GknauOaTrKlA66ysxc8KAuzaEBkZXCSu19aBz1TG7VlccJ7e4AZeo9Rt/8Xs9
         CRZ4rkH1qoXDhwF+zlbM9r+NFJQD1h0vmNVpI0hrWPG1yIuM6rMnxnI5PzM3qNxV9Nvh
         s8kCfMBhGpX3QZnQrdc1PrmiBcUjczusZv6dUnLm4PD5Ie0DzXqsdJx+13MpqM2irMuM
         0SdA==
X-Forwarded-Encrypted: i=1; AFNElJ9KA/W/3yIQMjHqZKDKcLjhd7YJNm1pDZSBvPrrQuOsNL6mKzgty5oBPd+Hi8RlLLgQ5zVAIHphWNpH1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwyW28jz2Pok5B1WNMV9pcgZVg6V3LKfhkcbrcY7/n9aOhGIW2
	MVXiRymZNjZB96HQtr83MH4ofKKMGq/F1ZZA4L5MF1mjwWeyjBmxuOMzOaXfgNR6dIgLpeUsJW1
	R7Iq1
X-Gm-Gg: Acq92OE8M1gJQBeLd/uQuwszcCGQ7OV62npNVmj8L49cb0WRiqChGQsWBLPtZccCvX7
	cQw2AvDwO3rqs983GUFIdSUBBCTu0IIXNUP5tQbXGqzUGNL12fjzaSga1x9SG5WONVl2VrbLitN
	UL03B3ymI7zL6UyyoUmNj5Mx69Q2RK3x/cnmOtzSy8cACPHfBnRy0f2Soyo9wTquYs3cBFPdf9X
	bVGlT2vDsRnGIh9RuP1j0Xn9TlWz5uvmHjjuWcq4gElX1obTLicRrHdVY1F8t23WeWmXXc/n76L
	rc8uvi0HTpjxXIiRox9qC5eez+VXVPeyf3Z0/4Ym2uyRjaRxsMk2eM5IsZtyoOGuyTORJYM3HkK
	INV7BG20vl67T8YqoXf6E16jAaMuvV3CgtcwFjbO8xJaQZ0aQdoQXDrAc+UzoneKeY1Mu9vYB8P
	cTQRDgQRWPoqruI++j3+zg7u9KWULUpT3luHssr2swzsujd31bqWHUMXYUy1JRKNENK2lqnK6cx
	9wJPD3TceSJMvFSnDMKuGTf
X-Received: by 2002:a05:6820:4c81:b0:67d:e7c3:3c6c with SMTP id 006d021491bc7-69e1043e95fmr5843170eaf.53.1780323841294;
        Mon, 01 Jun 2026 07:24:01 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43c93ae5342sm7818948fac.7.2026.06.01.07.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 07:24:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, 
 Lars Ellenberg <lars@linbit.com>, drbd-dev@lists.linux.dev, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260513065557.36042-1-christoph.boehmwalder@linbit.com>
References: <20260513065557.36042-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] MAINTAINERS: use new drbd-dev mailing list
Message-Id: <178032383948.395085.15762076029664187457.b4-ty@b4>
Date: Mon, 01 Jun 2026 08:23:59 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Wed, 13 May 2026 08:55:57 +0200, Christoph Böhmwalder wrote:
> We are migrating from our own infrastructure to lists.linux.dev, so
> change the drbd-dev address to point to the new domain.

Applied, thanks!

[1/1] MAINTAINERS: use new drbd-dev mailing list
      commit: 9310b955c85ceb4700c7208baff2373a611a5070

Best regards,
-- 
Jens Axboe



