Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6794B1D435F
	for <linux-block@vger.kernel.org>; Fri,  4 Jul 2025 01:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751594248; cv=none; b=Kb9qzucWsm/ufawbe2X3A7630YjkmEKkw+YlT2NkvaZvXFWonF5gyt4eSQVhluvlvg5fk57Sv8xU6Zf1M61CGL755Ea6OJSBVPOYLagcs4byZhtv3PVee3Jc30SEiAxTCu5m63zwsCgZagSgPjWC4IMZAxF//K7dvpqtuJVhINE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751594248; c=relaxed/simple;
	bh=OoCZq6LdsFnIFXOYI9tB7SS91E2B0eFrGNPYaxleC80=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ffHiYO4pCCqMy0c9bTBZ8BfWmVzUtdXwfX0j/SHWXquee8sWFXgLEJUBVtcG9plycccCrChKy280yYjdbtvkHd50mWjqnM4BrSAsB+8/xP36QSF96iGf9c6S4ezdFlT3CYzKdHf50YRJTa55NPNSwAtBiVobehTCZ8nZ9vza4MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=M8tTvihy; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="M8tTvihy"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-86cf3dd8c97so52844839f.2
        for <linux-block@vger.kernel.org>; Thu, 03 Jul 2025 18:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751594245; x=1752199045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcpGOYJoS+x1DjWEeDlJG5WLQCM2ycI6S4ggaBmrR7U=;
        b=M8tTvihyw5twFRgof6N8pL8bUYCiy0O2vkpwc4ngH+zw01ziJxn/lmmRrpRHG1U+Xw
         zlIwhlHD7FcOZphxChse2nDF7i+cBZTxcF7o/+kjmxs7n8jOPQ4xAFuoXp7qXly9NNx1
         l2k/U+lt8lDwJHKZBitXFGLyyAj3ZEUYVdc/irArvXzx4ho4A0Hma1c4RZA8dUsPTvCZ
         RReBxqu1GS0A8s/n6/dEwoZ7JZTTUg7yx+ndm3cukkNCujS0j3G3TedANK7UH4VyYLGp
         9Qr1R/4WklI3Kf1ZlUkVh7NFG/X73KTVmVctt+A/fX/0PrnmE+HVZc4m4nahuBrlWBlk
         4isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751594245; x=1752199045;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcpGOYJoS+x1DjWEeDlJG5WLQCM2ycI6S4ggaBmrR7U=;
        b=phzXkFAFPZpF86MreebPfyaSpnV7GUxU9e9DGeoF4/IGDFoG3BN59nhjkMRtrTTKkE
         lWgqx0VOn9kd1j0gnbSc17n8Sboti/A+nkvsOuvYwn91do19WeMnft7avFA65R9/7Rmr
         IZqhjQpCdTZlWKp+4SENwJRcE5kb4EaBop3EY5wfipz6C/zJByRh9qCt1lPs6WPUEGY/
         +2ViMr55CM5c/xOFyMVIhKsxHmH+AykF3e0gw8619ZwouPpomweXNH3xElGnjuaz6eXe
         SQ04VVtsvGQ0pecLw2kJ28/BJn/V3ZINFV9EynELNwzHgh1svYy2S0dt+CM6wISwh1uN
         hSag==
X-Gm-Message-State: AOJu0YyBZoyKHdYk0ZSbu6YDlSOPe5uLAtrXLNCpRXv3Inz1rGl+eOi2
	PfNYXFTbNvNC/cCSLPfy1OZjcVn3GX68jTnM0gN8qaGZ/1dokDRZES4LSWV1VBNUTM8=
X-Gm-Gg: ASbGncvJs/0MWnryy1nheiLzh4GIJWvul0fAWsncIpfzo6K0Mr//lE6uWHKypnB/XWZ
	yr4xxrDkq0idbfuMXUJqqw5Qnd6ri/vpSuECu/LrUpyR6GDLTxxPxAYTrCN3PT4vCxM1oRfBO9j
	s+S9F8VaYrFbDYEF8yBiSoAJ/03suBHMAH61PkcoT15yYIxW8UhYC1kLCUkAMIbcq4Sw1u8/gFr
	Dg0DQfF1K1FE0otEammDCfuNo759ObDq/JajuReup4AQO7blC4BjmU20jdY8fgeMtGBGzY5gGE4
	EZFik4i0tQeU5OR8dpgqd0eQRMrfl4OMv/tOA1ek9PP+Qpt+ZaaUMkocX3ZHTpGy
X-Google-Smtp-Source: AGHT+IGUGe/QPbULYs8yVIdrGcRGsydBwpQMFK+/9rqX/ujQ16crNXvpMjb/DcznQMGXzDKwDWM1cg==
X-Received: by 2002:a05:6602:29c6:b0:875:acf6:20f with SMTP id ca18e2360f4ac-876e490c7famr9887639f.10.1751594245338;
        Thu, 03 Jul 2025 18:57:25 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-503b5c38a6bsm218292173.120.2025.07.03.18.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 18:57:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: minchan@kernel.org, senozhatsky@chromium.org, 
 Rahul Kumar <rk0006818@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org
In-Reply-To: <20250627035256.1120740-1-rk0006818@gmail.com>
References: <20250627035256.1120740-1-rk0006818@gmail.com>
Subject: Re: [PATCH] block: zram: replace scnprintf() with sysfs_emit() in
 *_show() functions
Message-Id: <175159424438.587194.16568667665048848339.b4-ty@kernel.dk>
Date: Thu, 03 Jul 2025 19:57:24 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Fri, 27 Jun 2025 09:22:56 +0530, Rahul Kumar wrote:
> Replace scnprintf() with sysfs_emit() or sysfs_emit_at() in sysfs
> *_show() functions in zram_drv.c to follow the kernel's guidelines
> from Documentation/filesystems/sysfs.rst.
> 
> This improves consistency, safety, and makes the code easier to
> maintain and update in the future.
> 
> [...]

Applied, thanks!

[1/1] block: zram: replace scnprintf() with sysfs_emit() in *_show() functions
      commit: 264a3fdab2365395e43d3a0b40162a29e61ffa22
[1/1] zram: pass buffer offset to zcomp_available_show()
      commit: e74a1c6a8e8af2422fce125c29b14f1d3fab5b5c

Best regards,
-- 
Jens Axboe



