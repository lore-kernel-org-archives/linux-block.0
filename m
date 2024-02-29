Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC80B364A0
	for <linux-block@vger.kernel.org>; Thu, 29 Feb 2024 01:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171252; cv=none; b=mNSZYrfkiyQ+QXAFaxcSzcdl37BuN27C5lnN93qT7Dum1fyIpJKANAKGXxqNiF6Nd5I9JWyjOqPd7CP+LYOW16IJ78BZYJxuYjIvrRZgbPa8dLPZ5oXi44phHKCIzY6voydcmO6u4YVMkrY+s9AD5kVrpgFpE7af8ebPjmCRPLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171252; c=relaxed/simple;
	bh=ST51FRZFul8YEBbDpxpTrFm5g6SSHferE2doQLVAfA4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Smt1sUxmTPApIy8DAXZYSwYCpMM6aBhq3iCyDgGnJFOS1t89scXvjLZU1JF9zHvRfnDLiSj3gt5w7sXc1xUxFib5aInSkN/sh1z6po61KI4xk3bAvCCo2OC3zwMCXDdDGTuE7UVFsAa48krKyjUl2xU/sa97YFvbUN9ClZdkxdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=S1U6tIlA; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="S1U6tIlA"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cfcf509fbdso43113a12.1
        for <linux-block@vger.kernel.org>; Wed, 28 Feb 2024 17:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709171249; x=1709776049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSvg2X7UpSUcSLtWToJuYyrvCTHFp7pFjg/Ys8rJdSo=;
        b=S1U6tIlA7JPtbrFvHe3bXu4eKiXQbdlivwEY3RMZRCuBBK4NHt8AhPCRTibaKNkYkR
         uB+p91hT1+zUr1K9jatL4Bos3u3SRkavmhpbmFby0GjI5H/tL9HSOLghR2mQZG6d+pXO
         314TmZdB96dFae8l0MBw7sDI8m9M6tC5Fka5YL1XlgZjiC/TjnmNzVHpbg/S3XxjcuJV
         uzk1YHX21M2sNE3AKXqTGJuN6Wp034ymWID2G0M86w6cE6QWtMjMzGD3dsr3Y51QGQpM
         eXXEeEAeGghM4cgnRfSK3sebRdclnNFqcrqWcETa2YEay3fEUEnQsnFxr2ubC2o8efuv
         AeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709171249; x=1709776049;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSvg2X7UpSUcSLtWToJuYyrvCTHFp7pFjg/Ys8rJdSo=;
        b=jneaWGEUFXBGQcebOmf9lYgCOFxZpd9GGPfvlu+XSVStT9lpRmwFA6EAGPpk1XL7jL
         awGWcBhs2pUHq++HpoUDhp8f6AWWTkfgtqoktGgARkSPInAFsMpGZU1/bVKZPAd20Lo5
         2MdOTkjxlDaDHIhp7bko+AEkCr7txuGh9LtwTgD0W0Vf1oQsDC8IbOAOk9Dx2C/tIx6P
         qd/7dduvtEZhhhwpoOZCQV/rgRfoMmiHv9wGdJEhkwOG4QZXF6OfoeqK3im8lCf11cCS
         yELv3M9QmXBSzIXP78XZ4kDq2YgwiXX1pXrJypzLA+B33LUQMUosr4hvPsItVhNVDs+D
         rNXg==
X-Gm-Message-State: AOJu0YzXPrqVlkl6okoeguVX3/aJROhuBJijzj9UZmNP3epd/eg/PG+B
	1jCSLc0yoaVEqAtrv010eowbkjCS1GaIpAKdQ2m/VGV1QXfTUDy0vxXU70I+eWAbPpCYmST/Qj3
	E
X-Google-Smtp-Source: AGHT+IHvLvOj0+dbw9qiIOmIt8rkDfRuYzKW2/EaW+Rzm89uFdRkfTiui9ae03ej6/BBQW1EErwq0A==
X-Received: by 2002:a05:6a00:2d14:b0:6e4:8870:66ef with SMTP id fa20-20020a056a002d1400b006e4887066efmr967846pfb.2.1709171248807;
        Wed, 28 Feb 2024 17:47:28 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id y133-20020a62ce8b000000b006e45a0101basm112654pfg.99.2024.02.28.17.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 17:47:28 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20240223075539.89945-1-ming.lei@redhat.com>
References: <20240223075539.89945-1-ming.lei@redhat.com>
Subject: Re: [PATCH 0/2] ublk: improve ublk device deletion
Message-Id: <170917124785.401124.9457654868952302906.b4-ty@kernel.dk>
Date: Wed, 28 Feb 2024 18:47:27 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 23 Feb 2024 15:55:37 +0800, Ming Lei wrote:
> The 1st patch cleans up get/put device, and annotate them
> via noline for trace purpose.
> 
> The 2nd patch adds UBLK_U_CMD_DEL_DEV_ASYNC so userspace device
> deletion can be implemented easier.
> 
> Ming Lei (2):
>   ublk: improve getting & putting ublk device
>   ublk: add UBLK_CMD_DEL_DEV_ASYNC
> 
> [...]

Applied, thanks!

[1/2] ublk: improve getting & putting ublk device
      commit: 1221b9e982e181f1c37789c46fe5bfe32d97bec4
[2/2] ublk: add UBLK_CMD_DEL_DEV_ASYNC
      commit: 13fe8e6825e44129b6cbeee41d3012554bf8d687

Best regards,
-- 
Jens Axboe



