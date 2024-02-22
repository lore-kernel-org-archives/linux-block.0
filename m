Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38004153BCE
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623352; cv=none; b=YL1VLSKsR/mt8t3x4oqynECRN9GhU+6yU7Uqq3pdJgsPWXqjbGnV7/DlmEzlooAN6IvWu2RCJJG60hU4C5frg023B1nd1+QZIGuZfMGo5wDKJcIyGIrDLrk+qqG25dWkPiBjSoHlP3el7bfAt+Nbryyy3Rd96s4+K6aw35/IKBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623352; c=relaxed/simple;
	bh=3iTf86ODfAqoFp8Mtk7tCgw5oyyHG3XbeTN3DALeUcQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o3tjWNkGdQ0vs3i7R04we4E7HwFz/hlKjdtr/1ZRu8XMOO9MosmYEQsYSUsb+YbKwcqSAy+c3HBoGv8pL8D8mSEia2Da3FhmNgI4N+MAOkYDUuw3yLbAHSUKHvJyO2d1m73f/018lSqdhrprc6BhB7hkEGUWmqCcgSKO0XyyHpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RYCrTfrm; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RYCrTfrm"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dbff00beceso8913935ad.1
        for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 09:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1708623348; x=1709228148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjjUhqjaW7k52N7t+RFxECRLBqZMR+0thsvxbKxVCVE=;
        b=RYCrTfrm5lCwkv3y5EZsC3EJEwi+jZHxGV/3xOUbLcepLA7+WHIF+V9tOUDVa0UQfw
         xvdt3S+ydyX48Rw8FNUycJGTxdUKiVnqfn2VXNtu3O4zeTcwEJ+MqVInNyiTJls5oXM3
         Xqg7Ob79jPRjsnEAsdq01+vfKSwug1kgHYJKtvUnQbVGYW4uQqSMS5pGOQEC9hpsI+Ae
         AQwourA6COslX+eIBnKRAC/M31K5LeNrLIlFcHP09d4w6/9Na2uvdpTXPusogjchkpzF
         +XNe1VnM7OYbvzIAXkgytq/pDAAg8ZA2QlQIxTFht+NPaRDe/SPHstWrKEIIN+EnzE2C
         RWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708623348; x=1709228148;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjjUhqjaW7k52N7t+RFxECRLBqZMR+0thsvxbKxVCVE=;
        b=LD78dhXO5kliUjzaKEr5jg+eTuXRw6HcuGa7EbSrPHlpIV7p7gcdaVUe0aAYGIzGz2
         hewjr6fLtV54KmtgCjaYYHWITyflcv3wimQTZRPRrGxvV0Dy+EhLiLu5auZNWXg7jfG9
         gYyWj/i17wWV3xMHtQci+OW5vIosiKSYyPjMyVegZRbqAiqhf2l5vUaFX43G20LGw2Z0
         PmnpJ4Ea0taEhvJqcqn2eDoOI4LIHCH1357d0GzNki+Iy4TnKRSYmIQAvoNl+UnwQMp4
         A7f8JsYCho5PInJqVSsZZ8YgOzIlADC7DUPiHKyLRX3p0yo99MD7lRGOOf8Jgdcwkuix
         iTqw==
X-Gm-Message-State: AOJu0YwE/quEaP+yNLt8tZPJYoX06OXjypdQHGx59N1Pz9VPyiKo0ELm
	z8yMAQII/pZafSdncy21iJrefFxzcEO1onpvh6gXiX/ufA6aWyN0YTLN0Z5yjF0=
X-Google-Smtp-Source: AGHT+IHBbvV7SoIwTBDhyUgHXLNLz7DnSwM63zkINCpixOngwLyvPZ1OCW/q2pvdrC6dL6OTZ0U1pA==
X-Received: by 2002:a17:902:c112:b0:1da:2a1f:5f55 with SMTP id 18-20020a170902c11200b001da2a1f5f55mr19945205pli.4.1708623348596;
        Thu, 22 Feb 2024 09:35:48 -0800 (PST)
Received: from [127.0.0.1] (071-095-160-189.biz.spectrum.com. [71.95.160.189])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902f7cf00b001db7ed47968sm10225218plw.30.2024.02.22.09.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:35:47 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20240222131724.1803520-1-dlemoal@kernel.org>
References: <20240222131724.1803520-1-dlemoal@kernel.org>
Subject: Re: [PATCH 1/2] block: Clear zone limits for a non-zoned stacked
 queue
Message-Id: <170862334741.17819.2324222407569946286.b4-ty@kernel.dk>
Date: Thu, 22 Feb 2024 10:35:47 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 22 Feb 2024 22:17:23 +0900, Damien Le Moal wrote:
> Device mapper may create a non-zoned mapped device out of a zoned device
> (e.g., the dm-zoned target). In such case, some queue limit such as the
> max_zone_append_sectors and zone_write_granularity endup being non zero
> values for a block device that is not zoned. Avoid this by clearing
> these limits in blk_stack_limits() when the stacked zoned limit is
> false.
> 
> [...]

Applied, thanks!

[1/2] block: Clear zone limits for a non-zoned stacked queue
      commit: c8f6f88d25929ad2f290b428efcae3b526f3eab0
[2/2] block: Do not include rbtree.h in blk-zoned.c
      commit: 522d73526f8d4519eefc693204bb474391e60f2b

Best regards,
-- 
Jens Axboe



