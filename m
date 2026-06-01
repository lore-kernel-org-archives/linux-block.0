Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93352C21C4
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300966; cv=none; b=EQ2xLqirY0SaTperNKy0+0fJamn4XAzfe8MjDy9IxfIWOAgisR73JZwSK7uTPnysWD5LC/QF2yR98W8PQBqkCgYEL8qu6wi1vjLAN9P8ZmqzlDgQSRxsaAF8cpnfu5ZP1nipbVKdVEjIWkOQfMTcN1vlJHwilpymAtYPueBIuzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300966; c=relaxed/simple;
	bh=AgD+BzwxhQRkx6OqAI3ZzibLKjyCAVWY50FPyoOIYh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEVuRNCGzYjUOUz3BlLpECFwXMk/bliHqYUWEboQh+/iXzHtVh1TcfzZYWg5oL8eOhbIwqejOFLylidtRhF3080ZerIHOq0W9Y8WgCbikMSL9yJdt1oTAoN31yxANEIIMLv/X98hh100j03VSULDdkVEWOH0vM1lmow0mR/nv9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=MVLCiPMP; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="MVLCiPMP"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45ebafde87cso6377831f8f.3
        for <linux-block@vger.kernel.org>; Mon, 01 Jun 2026 01:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1780300963; x=1780905763; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bhYB9HvL0n+VB2gN+GfbC+Zc+n1I631BCVDzgaKbOyU=;
        b=MVLCiPMPl2tjg2FvGaB5x7Sqw5bty6enPN+Zi2q7WvxmCJEPlsrBamhwcwYrtEyrx/
         OUlD/d5OAxhT2LA1+YqZyjN6vdQmYCMnvggGAyFLMkh7ZKqmPwbkVo7mTe0YM+ISe8Xc
         TzjSPuX7KD+STfpDkUFjdLEqeoOzttntQ1OwT+XGxMAbpmN9yeFO89gaCtzw0W/03+IS
         Bdk9/vswiPkjT+uYZSSuGZMtmEDvEejQ5oMLX+JUHFEfisgr68gHS5F/Va/jSk++fvk2
         ZSfsscyiyOvc+Ty+NkYYS+CaTq1pJxWGF8qGcMb7zOySsMMtl7ROqdg0DNuoIuCoNEXo
         GmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780300963; x=1780905763;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhYB9HvL0n+VB2gN+GfbC+Zc+n1I631BCVDzgaKbOyU=;
        b=ltwSXkzH2hXtiZfVPDOr2/13UZn4FIozmg7Fho4KcxzXb8yTcLfdTlxiVfYulouOMJ
         zGHex1IKUj2AR7AZpkP6NVOR4ROKZpE2tUMjDFbe/ORR2xfd5MUvYpgsgyfTiMdyvoWe
         +I7/7xNUqLWru2S3NshqRohobFaIrxljMxG1hiSRa+DRwkRZvlE5+qjehdEcxq7/3WHN
         AfIXMFIUTxbeYVG8rhwsAFGZ7gSYvINhDzd/kC9E8erIXRmswcQ+IWYlyLIaqCcsLc5s
         obTW58qxsOTRFBdSMmsk2GLuyw/CJAlRtPJxdKxOxnQH8u8L8oSGt4H+0CYvGtc6HBbs
         m0og==
X-Forwarded-Encrypted: i=1; AFNElJ9tSTt/ILKbrEAcx86Ih19EoIqudBLf6CkmUUk1MJrT+8wgzdhS8DhudpRGBJ0CHJg9ej/D0Ov06AzUFg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgo2J5MI7YPtZyPantDs7FbPdvncvxvj809kZPDPdBYC/mrtAz
	Y9U71ybbEwq3rySh87ko5Ir8091wYaUcQa0XwFDzFmQDTLgW92ueN/smUsa2Lbv6spc=
X-Gm-Gg: Acq92OHJg7hAAEqK4KUjTS9KBNPWycjAeklYfFnhhwgtokxKSWkbTQsCFWMOXeE6eVq
	xrG+C8o3uD9hnBOSJ/fJsBSGax2j2i/TVIYPSR9xr68wPY2f7jsLCac2pwU6guUrmp3Tx1rGq2g
	JDGhkaHIjCLGl3jYk3yxQPh+BxeWpfHr0hPlYDG7iBoW9VOXoBiV2nnowdx6C44TF8AMCkXazRF
	5B9dfp/ExKkfMmHRaXnpLaOxO+INflX1K6iZUJANqS7KfCiqW+FMXcjspWBgttsb72SGx3qy/Vz
	l+pCcs9RsONOr5+O4cZjoHEOaLptE7tTI2s+jq66IgibQ1SFE/7Q6vuETw+AKy4wXn280mTcy8Q
	+fBwQjcF3J5sswSR9LdVbgEViZbYTFaEM/TW+4Yk8VdZb58/H5fAb/wbmrK+Zs7FsCXeuzTF/VM
	5ygIWG/4NltqF0gA9RAaVkjKNvnVFQothESbMiBks2t3E9424gu4fVWUltpsvA+MF+cNPrUD63S
	2OzdA==
X-Received: by 2002:a5d:5f4e:0:b0:460:42c:1133 with SMTP id ffacd0b85a97d-460042c121cmr10149587f8f.14.1780300962972;
        Mon, 01 Jun 2026 01:02:42 -0700 (PDT)
Received: from localhost (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34b7d6bsm24631881f8f.10.2026.06.01.01.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 01:02:42 -0700 (PDT)
Date: Mon, 1 Jun 2026 10:02:41 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, 
	Lars Ellenberg <lars@linbit.com>, drbd-dev@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: use new drbd-dev mailing list
Message-ID: <ah07tGQ4Fz8CXy9D@localhost.localdomain>
Mail-Followup-To: Jens Axboe <axboe@kernel.dk>, 
	Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars@linbit.com>, drbd-dev@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260513065557.36042-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513065557.36042-1-christoph.boehmwalder@linbit.com>

On Wed, May 13, 2026 at 08:55:57AM +0200, Christoph Böhmwalder wrote:
>We are migrating from our own infrastructure to lists.linux.dev, so
>change the drbd-dev address to point to the new domain.
>
>Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
>---
> MAINTAINERS | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 4abb3345bc4e..b8db0c038c55 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -7773,7 +7773,7 @@ DRBD DRIVER
> M:	Philipp Reisner <philipp.reisner@linbit.com>
> M:	Lars Ellenberg <lars.ellenberg@linbit.com>
> M:	Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
>-L:	drbd-dev@lists.linbit.com
>+L:	drbd-dev@lists.linux.dev
> S:	Supported
> W:	http://www.drbd.org
> T:	git git://git.linbit.com/linux-drbd.git
>
>base-commit: 36446de0c30c62b9d89502fd36c4904996d86ecd
>-- 
>2.53.0

Ping. @Jens is there anything still missing before this can be applied?

Thanks,
Christoph
