Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFEA1A0B00
	for <linux-block@vger.kernel.org>; Thu, 31 Oct 2024 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730393690; cv=none; b=r8aEE/zXhF6TclLQKs+vz2xT1z5SJQ/DvSjWv0HxdLuHPFssLsDhPzcwBK0kS2WlNeVIhd8MOl5MgO7+u9e1C2EleD2i5Xms9jF3EA5T1Ziwa7W+C1uluBZ+ZvNfDv78Ntu8PuilYw1X/VBzCKQQw1lyWZa/+BVMwSpBoOmXo4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730393690; c=relaxed/simple;
	bh=pm3wMhIjk1IQkkGYhBwrWt1Dh0xnAd226Rlpn7X3j3w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KFBtXFjLNlzC8xH03rckZUONttcwMo+M42liY1QxK2coeo0kmi8njIPIwt/NARWVlqOmaazh97LujORNGZ+z5yfpdxHUvjzOKrMjoYN9PTwRuEVL6GKpDvbmP2oLuF1WitojJI6Jzke3G0KWr2p3FgusFU5KoChDOcXDz2qtI64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fRh2tRri; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fRh2tRri"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-83ac817aac3so45952539f.0
        for <linux-block@vger.kernel.org>; Thu, 31 Oct 2024 09:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730393687; x=1730998487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRUlIOjXZWU10wG3kEGhcN6seqmgKOm8+59ALpOskDc=;
        b=fRh2tRri1/ged+y+ZllYq69LSG7R/iwG/KhTm+Beq/63vGSMTyQ4ilL5JQOF2dZIky
         mdGPgD4fybhzxkKqxjzoEz/YkscoSGM3ZHZC/SItlPMWVpapnilpjrYu7v0sZ4dT5sKT
         EQKFN859aS0uaHyGJShSgz+VlI/XSM5WRKgfemzCnb8b5j9OC06XNTVRNVpwJ664OJbU
         +eyGJyBzCeEcPih0rTlBH13DG/HRQ+4JsE5wB2X28Erqof+zypgm8vkPzVmuKDcjXxn0
         Ie+krtqDWqiI+E5q7cP4lqFdQkTFrzxxKpjBwocrCOc8cMgPg0xGW11K2nFdilupdEn6
         bRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730393687; x=1730998487;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRUlIOjXZWU10wG3kEGhcN6seqmgKOm8+59ALpOskDc=;
        b=lQxWOipSVY3i0t5P4iubHsNfwvZ00f6csi2XBjVLd//Kdw7EICB5sMPtj2GHTWLKt7
         NULuWai86cjrBYQuhgESzGqBpOxobFI92NREsVcT3FouqUB2Zihib40SDHLvXSyTvGr2
         YtRUsGPzvZAjXTN8MrfsAFvK23SxNT5/RFEBDDIga3s2kx9MPDW4SDVG8/ekKEdg9843
         bsSgw6bf03O079KSibaK5GJrNQaMRtIp1qAgUqZM30KHrvvJ7Wmcp+9Fy9IEqOo6ym2h
         b+E4FSmXC5HVzW7eeW10Y3kCr4VFnRk0gAagicmqrF/epmjjdLD7eL7/wdCScSVV5XF+
         AgOA==
X-Forwarded-Encrypted: i=1; AJvYcCU1FHPWsXgrnYjjOYaNAUnl4FKdDXKBDFzDtLv5msiEtyA5YuNWsaaSgAjCRD/f5FlTb2/f1VF+2yeaBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmV3BWnpLAFUM0K68M1oEWFY6k1rXSYehx7Nj/loBOVJtkHM/n
	zfU0unRcOZ3kKmcpx2tl/Tgqyx3NG7h7Qzz2Wf4aZGPq2bB9oOOxPIXbySqzSQc=
X-Google-Smtp-Source: AGHT+IEJ3BWDrFw2OfcWzScHXASiKoUwaD7+qXIbQHeYzuMZooAyeucE8M7hdVPssSAVfE2YTKCL2Q==
X-Received: by 2002:a05:6602:2cc8:b0:83a:f447:f0b9 with SMTP id ca18e2360f4ac-83b56712446mr922117239f.9.1730393686775;
        Thu, 31 Oct 2024 09:54:46 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de049776cdsm359130173.98.2024.10.31.09.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 09:54:46 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, 
 Kundan Kumar <kundan.kumar@samsung.com>, linux-block@vger.kernel.org
In-Reply-To: <20241030051859.280923-2-hch@lst.de>
References: <20241030051859.280923-1-hch@lst.de>
 <20241030051859.280923-2-hch@lst.de>
Subject: Re: [PATCH 1/2] block: remove zone append special casing from the
 direct I/O path
Message-Id: <173039368580.312932.12020401202563115882.b4-ty@kernel.dk>
Date: Thu, 31 Oct 2024 10:54:45 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 30 Oct 2024 06:18:51 +0100, Christoph Hellwig wrote:
> This code is unused, and all future zoned file systems should follow
> the btrfs lead of splitting the bios themselves to the zoned limits
> in the I/O submission handler, because if they didn't they would be
> hit by commit ed9832bc08db ("block: introduce folio awareness and add
> a bigger size from folio") breaking this code when the zone append
> limit (that is usually the max_hw_sectors limit) is smaller than the
> largest possible folio size.
> 
> [...]

Applied, thanks!

[1/2] block: remove zone append special casing from the direct I/O path
      commit: cafd00d0e90956c1c570a0a96cd86298897d247b
[2/2] block: remove bio_add_zone_append_page
      commit: f187b9bf1a639090893c31030ddb60f9beae23f0

Best regards,
-- 
Jens Axboe



